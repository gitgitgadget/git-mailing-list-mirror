Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 281631FAF5
	for <e@80x24.org>; Fri,  3 Feb 2017 02:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752227AbdBCCt2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 21:49:28 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36355 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752200AbdBCCt0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 21:49:26 -0500
Received: by mail-wm0-f67.google.com with SMTP id r18so1169033wmd.3
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 18:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N9DfvzO+WbyDs3HgOLJtlqepEg2FBtvTDUNnZyBpqGE=;
        b=J2rkG2Z0duXgA90ljoW9Rlo7kIExZ1ipp0gMSmz+buYzV4VfkQ8rQXEu1g50WKPxba
         8Np7d+wb1dY6eDkQcNulVZdewVZ8J4/FXTItivPTjlIIWdC3DV/AFYc+wE9A0fk7qgHq
         sEJKhxKzjl5xLiu1iVgRcI7NfcFTfye/wo2pMBJYQPc5Gu6w36jBHf5HgrYfAxGkemJa
         +WNyaYgvazQuvT4eRP5ddjikzOf5SGGYGxoaQ/CWcp0aDWZsR+c0YHW/ayQFnpjmXbTR
         +ICJuH31IRq+O3nvX4eypC2TTKdSfgcln5b7mrtOCYszl44BULAgTzch1f0xfmnyMX+t
         d4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N9DfvzO+WbyDs3HgOLJtlqepEg2FBtvTDUNnZyBpqGE=;
        b=LRUqn0PS4JBt9O1buRtMS171EVYSiDkgUDAEcfT5RNYGQpnO1ZQf2MXyEyjRZHETAn
         TXErS/X/S/CYwLCREivm+1ZIqh8MvyWEoCEuTwPkMI5EFi9uNl+1t3vrHA9iTkXsQO/8
         Mpwcw7mz5erYt620aMyUCFRl/UoGXjX4tEILnPKDQDGvnBhj2rYwrcW1JybgcfnQsbUx
         f6smnDAGZ6vTqRD14PYlUD6Nr43Zorgyk5Fu5sqklQCF55+f17tzTB0pDD5oFmSwl0uJ
         kKNxin5g4gyHG4Epi+mZzYsQx1WakpCqdtn4BRwMJGf3eWRJXwVASqU91aQT+bCbn6J0
         kJXg==
X-Gm-Message-State: AIkVDXLOLritrryEzEZPiFoiu3wUCjQrCrZvB+x8OSjL1jClMcQ+Jrv6AcaLQJy8fXRwqA==
X-Received: by 10.223.151.214 with SMTP id t22mr9918736wrb.2.1486090164578;
        Thu, 02 Feb 2017 18:49:24 -0800 (PST)
Received: from localhost.localdomain (x590d744d.dyn.telefonica.de. [89.13.116.77])
        by smtp.gmail.com with ESMTPSA id k43sm42867464wrc.46.2017.02.02.18.49.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Feb 2017 18:49:23 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 12/21] completion: list short refs from a remote given as a URL
Date:   Fri,  3 Feb 2017 03:48:20 +0100
Message-Id: <20170203024829.8071-13-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.555.g967c1bcb3
In-Reply-To: <20170203024829.8071-1-szeder.dev@gmail.com>
References: <20170203024829.8071-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

e832f5c09680 (completion: avoid ls-remote in certain scenarios,
2013-05-28) turned a 'git ls-remote <remote>' query into a 'git
for-each-ref refs/remotes/<remote>/' to improve responsiveness of
remote refs completion by avoiding potential network communication.
However, it inadvertently made impossible to complete short refs from
a remote given as a URL, e.g. 'git fetch git://server.com/repo.git
<TAB>', because there is, of course, no such thing as
'refs/remotes/git://server.com/repo.git'.

Since the previous commit we tell apart configured remotes, i.e. those
that can have a hierarchy under 'refs/remotes/', from others that
don't, including remotes given as URL, so we know when we can't use
the faster 'git for-each-ref'-based approach.

Resurrect the old, pre-e832f5c09680 'git ls-remote'-based code for the
latter case to support listing short refs from remotes given as a URL.
The code is slightly updated from the original to

  - take into account the path to the repository given on the command
    line (if any), and
  - omit 'ORIG_HEAD' from the query, as 'git ls-remote' will never
    list it anyway.

When the remote given to __git_refs() doesn't exist, then it will be
handled by this resurrected 'git ls-remote' query.  This code path
doesn't list 'HEAD' unconditionally, which has the nice side effect of
fixing two more expected test failures.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 19 ++++++++++++++++---
 t/t9902-completion.sh                  |  6 +++---
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6b489b7c8..4ded44977 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -338,6 +338,7 @@ __git_tags ()
 # Lists refs from the local (by default) or from a remote repository.
 # It accepts 0, 1 or 2 arguments:
 # 1: The remote to list refs from (optional; ignored, if set but empty).
+#    Can be the name of a configured remote, a path, or a URL.
 # 2: In addition to local refs, list unique branches from refs/remotes/ for
 #    'git checkout's tracking DWIMery (optional; ignored, if set but empty).
 __git_refs ()
@@ -410,9 +411,21 @@ __git_refs ()
 		done
 		;;
 	*)
-		echo "HEAD"
-		git --git-dir="$dir" for-each-ref --format="%(refname:short)" \
-			"refs/remotes/$remote/" 2>/dev/null | sed -e "s#^$remote/##"
+		if [ "$list_refs_from" = remote ]; then
+			echo "HEAD"
+			git --git-dir="$dir" for-each-ref --format="%(refname:short)" \
+				"refs/remotes/$remote/" 2>/dev/null | sed -e "s#^$remote/##"
+		else
+			git --git-dir="$dir" ls-remote "$remote" HEAD \
+				"refs/tags/*" "refs/heads/*" "refs/remotes/*" 2>/dev/null |
+			while read -r hash i; do
+				case "$i" in
+				*^{})	;;
+				refs/*)	echo "${i#refs/*/}" ;;
+				*)	echo "$i" ;;  # symbolic refs
+				esac
+			done
+		fi
 		;;
 	esac
 }
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 5b4defaa5..500505dca 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -540,7 +540,7 @@ test_expect_success '__git_refs - configured remote - remote name matches a dire
 	test_cmp expected "$actual"
 '
 
-test_expect_failure '__git_refs - URL remote' '
+test_expect_success '__git_refs - URL remote' '
 	cat >expected <<-EOF &&
 	HEAD
 	branch-in-other
@@ -567,7 +567,7 @@ test_expect_success '__git_refs - URL remote - full refs' '
 	test_cmp expected "$actual"
 '
 
-test_expect_failure '__git_refs - non-existing remote' '
+test_expect_success '__git_refs - non-existing remote' '
 	(
 		cur= &&
 		__git_refs non-existing >"$actual"
@@ -583,7 +583,7 @@ test_expect_success '__git_refs - non-existing remote - full refs' '
 	test_must_be_empty "$actual"
 '
 
-test_expect_failure '__git_refs - non-existing URL remote' '
+test_expect_success '__git_refs - non-existing URL remote' '
 	(
 		cur= &&
 		__git_refs "file://$ROOT/non-existing" >"$actual"
-- 
2.11.0.555.g967c1bcb3

