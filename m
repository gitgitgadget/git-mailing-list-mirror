From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/4] "git apply" safety
Date: Tue,  3 Feb 2015 16:44:18 -0800
Message-ID: <1423010662-26497-1-git-send-email-gitster@pobox.com>
References: <1422919650-13346-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 01:44:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIo4z-0004UD-Qe
	for gcvg-git-2@plane.gmane.org; Wed, 04 Feb 2015 01:44:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754650AbbBDAoZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2015 19:44:25 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62676 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752562AbbBDAoY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2015 19:44:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EB43A365D3;
	Tue,  3 Feb 2015 19:44:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=O/+N
	nWtgYmOHREygkhf3YbBJl+E=; b=TT10LidJ7DADsleXzEqp+IHrI8BTFT8NyVi9
	jP2w8zNrYTpj5vIWZIxlBVL5pn4gXWgsigqvW521m9x8OvtdABBgLjx4OSkhNmoA
	WaUPZT7JWIiWFaJJ+yNYRAlixFeNvLBGFWHW4hMT58PG5YCyyx6/aACC6yi0nX5N
	wpwPXD0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=BdeYvl
	f5JrEnqg3jiHGiVLzhvDLwfQ8+//X/t3ei1vBPV5bCtqKgpD9drda5Jso3v5I3cf
	/EvriEiYZTTqktRe7LZ/SN4Y8yk+HW9om0S7nQGbqfnxrfxPuIPTLb8O89Lk6A+7
	eEhcaXtuB/Iew8xn4s7UsfeqxmqAO+kk9E92c=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E24DF365D2;
	Tue,  3 Feb 2015 19:44:23 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6CA99365D1;
	Tue,  3 Feb 2015 19:44:23 -0500 (EST)
X-Mailer: git-send-email 2.3.0-rc2-168-g106c876
In-Reply-To: <1422919650-13346-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: F692A13C-AC06-11E4-ADA7-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263341>

The design and implementation haven't changed.

This round primarily is to update documentation and comments with
rephrases and grammofixes and tighten some tests.

The previous round begins here:

  http://thread.gmane.org/gmane.comp.version-control.git/263291

Junio C Hamano (4):
  apply: reject input that touches outside the working area
  apply: do not read from the filesystem under --index
  apply: do not read from beyond a symbolic link
  apply: do not touch a file beyond a symbolic link

 Documentation/git-apply.txt     |  15 ++++-
 builtin/apply.c                 | 141 +++++++++++++++++++++++++++++++++++++++-
 t/t4122-apply-symlink-inside.sh | 106 ++++++++++++++++++++++++++++++
 t/t4139-apply-escape.sh         | 137 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 397 insertions(+), 2 deletions(-)
 create mode 100755 t/t4139-apply-escape.sh

-- 
2.3.0-rc2-168-g106c876
