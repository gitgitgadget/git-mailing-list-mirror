From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] make-static: master
Date: Wed, 14 Sep 2011 13:33:47 -0700
Message-ID: <7v4o0euams.fsf@alter.siamese.dyndns.org>
References: <4E6D0E3F.3090304@ramsay1.demon.co.uk>
 <7vhb4in4j7.fsf@alter.siamese.dyndns.org>
 <4E6FDE71.9050606@ramsay1.demon.co.uk>
 <7v62kwvwe9.fsf@alter.siamese.dyndns.org> <4E704EA2.8060307@viscovery.net>
 <7vlitrt08n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 14 22:33:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3w9c-0004em-PM
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 22:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933221Ab1INUdw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 16:33:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41149 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933122Ab1INUdv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 16:33:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83B9C47D1;
	Wed, 14 Sep 2011 16:33:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oE7UpHrwq5H55khIaETEaAOfvXc=; b=w04bqI
	LGhgPpjuXWr+M0xlsv2nwYvJEVmjyFa42kAyFqqU/RkZkREMvGxMsxwK9P/ZoCBC
	/ThIBg6VB+z//+KQZ1sK1bjmt/fxZpfi+1XTrIe1krCtzcsJbtSJyw9qSke8qSXV
	ODav/kZWd+LewAlFkhCz4MXZ5K6zYeP4YZ86M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yo5NYndjKfoJlO8Eqzn5KVpU1zs1BUQ6
	OwIkM/7IbIvIJTzBDJTP+ocZJ2UDMKgv8hUKjR1glvgi380u+6FymN46FiFJTMtK
	FszG/BMIvKoksgknyEJjxxJZ5kc7dqAWPal5YHLa4Cci8yA5jgWqRGpcF9bFPhn/
	ZlNWrhYxyu8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A5D847CF;
	Wed, 14 Sep 2011 16:33:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E7E7647CE; Wed, 14 Sep 2011
 16:33:48 -0400 (EDT)
In-Reply-To: <7vlitrt08n.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 14 Sep 2011 12:03:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D9EA8F8E-DF10-11E0-9240-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181396>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Sixt <j.sixt@viscovery.net> writes:
>
>> Am 9/14/2011 1:46, schrieb Junio C Hamano:
>>> This kind of breakage report was exactly what I was looking for by
>>> merging it early to 'next'. Hopefully no other (function / platform) combo
>>> has such dependencies...
>>
>> There is! prepare_git_cmd is used from the Windows section in run-command.c.
>> Therefore, the following hunks of the patch should be reverted.

Thanks; this fix-up will be queued on top.

-- >8 --
Subject: [PATCH] exec_cmd.c: prepare_git_cmd() is sometimes used

Add warning to prevent people from making the same mistake.
Noticed by Johannes Sixt.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 exec_cmd.c |    7 ++++++-
 exec_cmd.h |    1 +
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index 1dddbf4..9c784db 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -113,7 +113,12 @@ void setup_path(void)
 	strbuf_release(&new_path);
 }
 
-static const char **prepare_git_cmd(const char **argv)
+/*
+ * This symbol may be unreferenced from outside this file in some
+ * builds, but run-command.c on Windows does use it. Do not make it
+ * static without checking!
+ */
+const char **prepare_git_cmd(const char **argv)
 {
 	int argc;
 	const char **nargv;
diff --git a/exec_cmd.h b/exec_cmd.h
index f5d2cdd..e2b546b 100644
--- a/exec_cmd.h
+++ b/exec_cmd.h
@@ -5,6 +5,7 @@ extern void git_set_argv_exec_path(const char *exec_path);
 extern const char *git_extract_argv0_path(const char *path);
 extern const char *git_exec_path(void);
 extern void setup_path(void);
+extern const char **prepare_git_cmd(const char **argv);
 extern int execv_git_cmd(const char **argv); /* NULL terminated */
 extern int execl_git_cmd(const char *cmd, ...);
 extern const char *system_path(const char *path);
-- 
1.7.7.rc1.1.g1e5814
