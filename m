From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/5] Updates to replace-object API
Date: Sun, 15 May 2011 12:54:49 -0700
Message-ID: <1305489294-14341-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 21:55:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLhP5-0004h4-Dh
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 21:55:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061Ab1EOTy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 15:54:58 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50683 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929Ab1EOTy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 15:54:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9DD094D2D
	for <git@vger.kernel.org>; Sun, 15 May 2011 15:57:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=MYXmFLPbH6KeEFTP+GCpgVLPWxE
	=; b=D9d2VniPnbc5boEUMCxcR2X+1oUrNYAPQ4u0J6K9SZ0zXItajog4H+09Llz
	bnVVcmqePv+ucwj5/CVQqyl0jrqJLWpZggdx1i/VexdXGYo2q2rHGQL3kAXZdgWL
	26yGKVFBNJ651MCwWlWb7ThcZPITv3Eu42+kNBlswxxtyUt8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=AgM60gL9svYYdt+XJypvVfFFCSVHW
	hTmWPqKKlqcTSGFWjqoPFYKpTANQW0zp0IBMZ0+iI2Vq4p2mNfih+6BzRdzW9J1G
	xTt7KfhU5wA6TTwQDb0cNTQUlgtYdF9Y9u7v82j3cxHk1jqjYUuKB2fpD8+f+SUJ
	NbBbJf0xD9Z9Bg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9956F4D2C
	for <git@vger.kernel.org>; Sun, 15 May 2011 15:57:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 285104D2B for
 <git@vger.kernel.org>; Sun, 15 May 2011 15:57:01 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.334.gdfd07
X-Pobox-Relay-ID: 80655E3C-7F2D-11E0-B563-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173649>

While I was looking at gaining a low-level access to read from the object
store, I found a handful poorly-designed part in the internal API to deal
with object replacement.

Junio C Hamano (5):
  Declare lookup_replace_object() in cache.h, not in commit.h
  t6050: make sure we test not just commit replacement
  read_sha1_file(): get rid of read_sha1_file_repl() madness
  inline lookup_replace_object() calls
  read_sha1_file(): allow selective bypassing of replacement mechanism

 builtin/mktag.c    |    4 ++--
 cache.h            |   18 ++++++++++++++----
 commit.h           |    2 --
 environment.c      |    2 +-
 object.c           |    4 ++--
 replace_object.c   |    4 +++-
 sha1_file.c        |   16 +++++++---------
 t/t6050-replace.sh |   18 ++++++++++++++++--
 8 files changed, 45 insertions(+), 23 deletions(-)

-- 
1.7.5.1.334.gdfd07
