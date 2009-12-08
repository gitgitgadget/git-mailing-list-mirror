From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Weird message when pulling git version 1.6.6.rc1.39.g9a42
Date: Tue, 08 Dec 2009 15:33:13 -0800
Message-ID: <7vmy1t6nye.fsf@alter.siamese.dyndns.org>
References: <hfmijf$dl1$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Alejandro Riveira <ariveira@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 00:33:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI9Yp-0004RT-T7
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 00:33:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937902AbZLHXd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 18:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937898AbZLHXdZ
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 18:33:25 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55710 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937858AbZLHXdT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 18:33:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AC608A5273;
	Tue,  8 Dec 2009 18:33:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QeKNde3p9Elt/EwmXpz/PqFfLj0=; b=s8FSDC
	OKf2fmxhs3d5VStY1c/7mwzz9w+qp1voFM8hNNfAto4gOj1fQugTHs35sTxIFk3q
	2JitUQmp2ulv/yxGdOdBskkHTPVE/AfbnqmkIFs/TJAe7ZHA34KZ5/Nn5515dHLZ
	RUoLqFyOMTW1AJ9/kV2iRqA6uQRD0Fqt88s9g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vUNi4SuuQXtEDLJKKsk38ay2DwkRtu4j
	nIDBTEyyit9r+ayiwySwa8p/wRiuH44BqSfdwkHq7d60Ky+i1J5FPGGQR8mspRf8
	xg9L5+Nl1o3shcdKT1CksB2L8pMWKGeVl7nz7Egl+oEUDeN6zY0OPqM9l7VjDBq7
	sTTu3zPcuqo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 699E2A5272;
	Tue,  8 Dec 2009 18:33:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AC9B7A5270; Tue,  8 Dec 2009
 18:33:15 -0500 (EST)
In-Reply-To: <hfmijf$dl1$1@ger.gmane.org> (Alejandro Riveira's message of
 "Tue\, 8 Dec 2009 22\:05\:35 +0000 \(UTC\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1257B72C-E452-11DE-9AC5-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134920>

Alejandro Riveira <ariveira@gmail.com> writes:

> $ git pull
> remote: Counting objects: 9, done.
> remote: Compressing objects: 100% (5/5), done.
> remote: Total 5 (delta 4), reused 0 (delta 0)
> Unpacking objects: 100% (5/5), done.
> From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
>    6035ccd..a252e74  master     -> origin/master
> Updating 6035ccd..a252e74
> Fast-forward (no commit created; -m option ignored) # what is this ??
>  net/sctp/sysctl.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)

Thanks for reporting.

Warning about a message that the end user didn't give the command is
clearly wrong.  I guess we would want to revert c0ecb07 (git-pull.sh: Fix
call to git-merge for new command format, 2009-12-01), and b81e00a
(git-merge: a deprecation notice of the ancient command line syntax,
2009-11-30).

Reverting them will still keep 76bf488 (Do not misidentify "git merge foo
HEAD" as an old-style invocation, 2009-12-02) that resulted in the change
we are reverting here, so we are still ahead ;-)

  http://thread.gmane.org/gmane.comp.version-control.git/134103/focus=134145

-- >8 --
Subject: [PATCH] Revert recent "git merge <msg> HEAD <commit>..." deprecation

This reverts commit c0ecb07048ce2123589a2f077d296e8cf29a9570 "git-pull.sh:
Fix call to git-merge for new command format" and

commit b81e00a965c62ca72a4b9db425ee173de147808d "git-merge: a deprecation
notice of the ancient command line syntax".

They caused a "git pull" (without any arguments, and without any local
commits---only to update to the other side) to warn that commit log
message is ignored because the merge resulted in a fast-forward.

Another possible solution is to add an extra option to "git merge" so that
"git pull" can tell it that the message given is not coming from the end
user (the canned message is passed just in case the merge resulted in a
non-ff and caused commit), but I think it is easier _not_ to deprecate the
old syntax.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-merge.c |    6 ------
 git-pull.sh     |    6 +++---
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index 56a1bb6..f1c84d7 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -796,11 +796,6 @@ static int suggest_conflicts(void)
 	return 1;
 }
 
-static const char deprecation_warning[] =
-	"'git merge <msg> HEAD <commit>' is deprecated. Please update\n"
-	"your script to use 'git merge -m <msg> <commit>' instead.\n"
-	"In future versions of git, this syntax will be removed.";
-
 static struct commit *is_old_style_invocation(int argc, const char **argv)
 {
 	struct commit *second_token = NULL;
@@ -814,7 +809,6 @@ static struct commit *is_old_style_invocation(int argc, const char **argv)
 			die("'%s' is not a commit", argv[1]);
 		if (hashcmp(second_token->object.sha1, head))
 			return NULL;
-		warning(deprecation_warning);
 	}
 	return second_token;
 }
diff --git a/git-pull.sh b/git-pull.sh
index 502af1a..bfeb4a0 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -216,7 +216,7 @@ fi
 
 merge_name=$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || exit
 test true = "$rebase" &&
-	exec git rebase $diffstat $strategy_args --onto $merge_head \
+	exec git-rebase $diffstat $strategy_args --onto $merge_head \
 	${oldremoteref:-$merge_head}
-exec git merge $verbosity $diffstat $no_commit $squash $no_ff $ff_only $log_arg $strategy_args \
-	-m "$merge_name" $merge_head
+exec git-merge $diffstat $no_commit $squash $no_ff $ff_only $log_arg $strategy_args \
+	"$merge_name" HEAD $merge_head $verbosity
-- 
1.6.6.rc1.42.gf9ad7
