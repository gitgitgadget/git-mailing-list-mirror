From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/4] Signed push
Date: Fri,  9 Sep 2011 13:41:40 -0700
Message-ID: <1315600904-17032-1-git-send-email-gitster@pobox.com>
References: <1315512102-19022-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 22:42:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R27te-0002zX-3W
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 22:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933636Ab1IIUlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 16:41:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59908 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933201Ab1IIUls (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 16:41:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 711035E53
	for <git@vger.kernel.org>; Fri,  9 Sep 2011 16:41:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=7L5A
	YYYKLBEjUFF0ghigvH9iWN8=; b=p9kV9F+rovs/yU6FehAq/NHOadYJ0EzcjgFu
	vyvOm6CT7UDFx05L39ZAhaL3OCu5cUjDdBdLkGN3YOdpQD8D9ii+yg+k2WetKATu
	onaWJBIJraN42lESuOV+976Sfdp2mpZhniPCKV5JmE7LjWU5JE9v5r7aWqWZEFsA
	KWJRFv4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=onqelr
	aTJAUmSjFHXB+WgXOZ6j5V8Vrx9T39BUskOWqFHEOOHuG5hUmIZW5mifdF1UshVv
	zyMOGdfsORSEtjcC3LNdfPUTNebIYrXHzi4Ej0G5Asmhng7lCSDyUYxB/hd8gwz9
	hn0zrfcr6DwTEu8YY0KBPrtakgKoEATx1htKo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68B2E5E52
	for <git@vger.kernel.org>; Fri,  9 Sep 2011 16:41:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EF45D5E51 for
 <git@vger.kernel.org>; Fri,  9 Sep 2011 16:41:45 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc0.188.g3793ac
In-Reply-To: <1315512102-19022-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 222EA1B8-DB24-11E0-9D3E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181120>

This is based an alternative design we discussed on the list to prepare
and push the notes tree on the sending side.

Junio C Hamano (4):
  send-pack: typofix error message
  Split GPG interface into its own helper library
  rename "match_refs()" to "match_push_refs()"
  push -s: signed push

 Makefile             |    2 +
 builtin/push.c       |    1 +
 builtin/remote.c     |    4 +-
 builtin/send-pack.c  |    4 +-
 builtin/tag.c        |   60 +++---------------------
 builtin/verify-tag.c |   35 +------------
 gpg-interface.c      |   94 ++++++++++++++++++++++++++++++++++++
 gpg-interface.h      |   11 ++++
 http-push.c          |    4 +-
 notes.c              |   16 ++++++
 notes.h              |    2 +
 remote.c             |   13 +++--
 remote.h             |    4 +-
 transport.c          |  128 +++++++++++++++++++++++++++++++++++++++++++++++++-
 transport.h          |    5 ++
 15 files changed, 283 insertions(+), 100 deletions(-)
 create mode 100644 gpg-interface.c
 create mode 100644 gpg-interface.h

-- 
1.7.7.rc0.188.g3793ac
