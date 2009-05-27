Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 14326 invoked by uid 107); 27 May 2009 08:16:52 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Wed, 27 May 2009 04:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756400AbZE0IQi (ORCPT <rfc822;peff@peff.net>);
	Wed, 27 May 2009 04:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757460AbZE0IQh
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 04:16:37 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:32870 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757168AbZE0IQg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 04:16:36 -0400
Received: by mail-ew0-f176.google.com with SMTP id 24so4320130ewy.37
        for <git@vger.kernel.org>; Wed, 27 May 2009 01:16:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:to;
        bh=vablvoB3pqKzzjspc4ZDVFfLF2hUotBvxLAqlpQeG7k=;
        b=TRC1RLciAPZo372fI3bwQRiGoh1tMqapm7xe4hWrUWS+4KrlH4tFSy2LZtnPDpXVli
         2JUwnZCGx+rr2oy/B9ExrwDdh7v7YjBcpsfrsgoBkY6bP67eySFma+COjmN+XxqzAbtS
         j057PmUNC7GHflzBLz5baRTItkrvoZElXYjhw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=R0+sOXIjQWF4HYLFvdFuRtJl9oE80+GwBplo8mbplfH7/qemrNG3uhcF5000Fsptwy
         QkYHmmAFfVXR2dJnVWhPlpIulXpTZQmSAquQWws7OuS5uGyB6r/D3J12yv+HvHS5PH5z
         y/C1f2dwhJLZOMUXAe8codcAl2gkx8sERO9Jg=
Received: by 10.216.10.73 with SMTP id 51mr3561197weu.167.1243412197675;
        Wed, 27 May 2009 01:16:37 -0700 (PDT)
Received: from localhost ([141.76.90.80])
        by mx.google.com with ESMTPS id 28sm5805125eye.36.2009.05.27.01.16.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 May 2009 01:16:36 -0700 (PDT)
From:	Bert Wesarg <bert.wesarg@googlemail.com>
To:	Petr Baudis <pasky@suse.cz>
Cc:	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Marc Weber <marco-oweber@gmx.de>
Subject: [TopGit PATCH v2 2/3] tg-push: prevent multiple occurences of branches
Date:	Wed, 27 May 2009 10:16:35 +0200
Message-Id: <1243412195-29841-1-git-send-email-bert.wesarg@googlemail.com>
X-Mailer: git-send-email 1.6.3.1.143.g17592
In-Reply-To: <1243412182-24126-1-git-send-email-bert.wesarg@googlemail.com>
References: <1243412182-24126-1-git-send-email-bert.wesarg@googlemail.com>
To:	Petr Baudis <pasky@suse.cz>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

So, I finally tried the tg-push and got a lot of warnings and errors:

warning, no base found top-bases/master
warning, no base found top-bases/master
warning, no base found top-bases/master
warning, no base found top-bases/master
warning, no base found top-bases/master
warning, no base found top-bases/master
warning, no base found top-bases/master
warning, no base found top-bases/master
warning, no base found top-bases/master
warning, no base found top-bases/master
warning, no base found top-bases/master


error: Ref refs/heads/master is at b725fc951a37854fc65945ac5bcab3bc61ccbd94 but expected 0000000000000000000000000000000000000000
error: failed to lock refs/heads/master
error: Ref refs/heads/master is at b725fc951a37854fc65945ac5bcab3bc61ccbd94 but expected 0000000000000000000000000000000000000000
error: failed to lock refs/heads/master
error: Ref refs/heads/master is at b725fc951a37854fc65945ac5bcab3bc61ccbd94 but expected 0000000000000000000000000000000000000000
error: failed to lock refs/heads/master
error: Ref refs/heads/master is at b725fc951a37854fc65945ac5bcab3bc61ccbd94 but expected 0000000000000000000000000000000000000000
error: failed to lock refs/heads/master
error: Ref refs/heads/master is at b725fc951a37854fc65945ac5bcab3bc61ccbd94 but expected 0000000000000000000000000000000000000000
error: failed to lock refs/heads/master
error: Ref refs/heads/master is at b725fc951a37854fc65945ac5bcab3bc61ccbd94 but expected 0000000000000000000000000000000000000000
error: failed to lock refs/heads/master
error: Ref refs/heads/master is at b725fc951a37854fc65945ac5bcab3bc61ccbd94 but expected 0000000000000000000000000000000000000000
error: failed to lock refs/heads/master
error: Ref refs/heads/master is at b725fc951a37854fc65945ac5bcab3bc61ccbd94 but expected 0000000000000000000000000000000000000000
error: failed to lock refs/heads/master
error: Ref refs/heads/master is at b725fc951a37854fc65945ac5bcab3bc61ccbd94 but expected 0000000000000000000000000000000000000000
error: failed to lock refs/heads/master
error: Ref refs/heads/master is at b725fc951a37854fc65945ac5bcab3bc61ccbd94 but expected 0000000000000000000000000000000000000000
error: failed to lock refs/heads/master
error: Ref refs/heads/bw/log is at a16df35cc7009b36f6f71717ae3d9a3dc29987da but expected 0000000000000000000000000000000000000000
error: failed to lock refs/heads/bw/log
error: Ref refs/top-bases/bw/log is at b725fc951a37854fc65945ac5bcab3bc61ccbd94 but expected 0000000000000000000000000000000000000000
error: failed to lock refs/top-bases/bw/log

 ! [remote rejected] master -> master (failed to lock)
 ! [remote rejected] master -> master (failed to lock)
 ! [remote rejected] master -> master (failed to lock)
 ! [remote rejected] master -> master (failed to lock)
 ! [remote rejected] master -> master (failed to lock)
 ! [remote rejected] master -> master (failed to lock)
 ! [remote rejected] master -> master (failed to lock)
 ! [remote rejected] master -> master (failed to lock)
 ! [remote rejected] master -> master (failed to lock)
 ! [remote rejected] master -> master (failed to lock)
 ! [remote rejected] bw/log -> bw/log (failed to lock)
 ! [remote rejected] refs/top-bases/bw/log -> refs/top-bases/bw/log (failed to lock)

Also the result was ok this output is defintive not ok.

To prevent multiple occurences of the same branchname we sort -u these at the
end, as suggested by Uwe.

Regards,
Bert

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 tg-push.sh |   33 +++++++++++++++++++--------------
 1 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/tg-push.sh b/tg-push.sh
index 40849ae..8e1b43f 100644
--- a/tg-push.sh
+++ b/tg-push.sh
@@ -45,27 +45,32 @@ for name in $branches; do
 	ref_exists "$name" || die "detached HEAD? Can't push $name"
 done
 
+_listfile="$(mktemp -t tg-push-listfile.XXXXXX)"
+trap "rm -f \"$_listfile\"" 0
+
 push_branch()
 {
 	# if so desired omit non tgish deps
 	$tgish_deps_only && [ -z "$_dep_is_tgish" ] && return 0
 
-	echo "$_dep"
+	echo "$_dep" >> "$_listfile"
 	[ -z "$_dep_is_tgish" ] ||
-		echo "top-bases/$_dep"
+		echo "top-bases/$_dep" >> "$_listfile"
 }
 
 for name in $branches; do
-	list="$(
-		# deps
-		if $recurse_deps; then
-			no_remotes=1 recurse_deps push_branch "$name"
-		fi
-		# current branch
-		_dep="$name"
-		_dep_is_tgish=1
-		push_branch "$name"
-	)"
-	echo "pushing:"; echo $list
-	git push $dry_run "$remote" $list
+	# current branch
+	# re-use push_branch, which expects some pre-defined variables
+	_dep="$name"
+	_dep_is_tgish=1
+	ref_exists "top-bases/$_dep" ||
+		_dep_is_tgish=
+	push_branch "$name"
+
+	# deps
+	$recurse_deps &&
+		no_remotes=1 recurse_deps push_branch "$name"
+
+	# remove multiple occurrences of the same branch
+	sort -u "$_listfile" | xargs git push $dry_run "$remote"
 done
-- 
tg: (8f4fb90..) bw/push-fixes (depends on: bw/push-remove-useless-warning)
