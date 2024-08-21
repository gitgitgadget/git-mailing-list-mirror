Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829051C871A
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 11:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724238162; cv=none; b=sUkPlLBWoUf7vt6AAXFhumMsT3GfjWbCKZdwuNFo+G5LONDF4rmGxy/xqg8rw4Wt8BoG8Qlf/AeFSnsJrEHjw3g782n5k5HDt3Vazbpn2/uySRIvYEA15QGIOnuCFg1SI0UDxED+aIxBle645zgMz5iQ5gkmpwux/CBhVwY05Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724238162; c=relaxed/simple;
	bh=rISH+set7lb8UDls2gt8l2Z6kFymd68DOZKWcYvfPBc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=b1C2+ZXgcTZAVdpN78ZurvIDUCeQUfsXcZUEn73XyHFOlxae6OiyNKoKpVbxviqesDZQex3zkwRjGdHmauDgUsXdnREPBbZw3NrvsfwhFKACBiWCLmnH9IsUflGUrEfzu1rbg4fvn17J9hzeBkWnFuSGuAJDckgy2M33tH25pRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKOqEv5+; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKOqEv5+"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52efd8807aaso8354216e87.3
        for <git@vger.kernel.org>; Wed, 21 Aug 2024 04:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724238158; x=1724842958; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVct6ftF0XWqTIeg27f2v8uwyfiVWAfFL80ybPxR8Bg=;
        b=cKOqEv5+uOytlxrhiJqpsHGw5Dka/exon3bUGLwPd5Txpa9+Jqi3DXOGbXQyEaVGh1
         SQcU3h7YhpS8ytrA4LWwksFHWB5k3WhcSJU3fLSwf1OZhIlL5lBN1ue4CpbCNBXouo+f
         BmGA1+BeDYO7Xxpc39J/h2I/XjSjBTQqVJTbw4zs2bCy9063qYCfiyba1vFeRK+49+LZ
         0pvRZHvInc4MAgIjKHt8/LOs7YVWWriQI/IK+pBcGXyAXk2DRlhTiQ9wFmZIp6T9IVg9
         njJmOyVQRvOxG41hcGPQsgwNZVb7L5R46MJ3rGRB+cXG5Eil4hSJCgAvTr80mpEJxKYr
         nABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724238158; x=1724842958;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kVct6ftF0XWqTIeg27f2v8uwyfiVWAfFL80ybPxR8Bg=;
        b=nk/P1lSJNTXgY7iqHWbJVTS8M5PfoI1M5kRMbW5dSuh0hTcDSCgkrpuGAJEKtW9pEE
         whNJUzrAomBTvpMynNTWMbcur+IUGUMeaf9S9svN/RIdwtcNTlB1Wq5r+a9kR9Sy0BsZ
         lPhvYHh6TA/7DPEzPJfJU8vihf7gHLrFRSJfsyukZGihfn9Codix1tslp7lWbiIlejlA
         zzqYH+GNaHGvZ8AFHcLbcziOR4zF/cAdB7kYoXyvLEdpI7EoTzS/JemFjrisB/OEuO3n
         5CZKDY3KGN0nWGenE1CZQUgwtdFacrqgtAfjLMyZKCtveSDs3m5hHZuQKTp8V3SBqkpu
         Ljog==
X-Gm-Message-State: AOJu0YydBFOXnV6xQBPDxg3JaMRoAZiIERQCWwjNyUxpdRbwA5A5fYmM
	sM0vEf1W8pKOOLiSxNiJeifULRIH3Mmdk/VIMWhB03sPHTLVjCq+O0DpWQ==
X-Google-Smtp-Source: AGHT+IEPhvRhrrCNm79O7oOI3QDfizNW5vRGhVaHYtl47kEJm87SrkBAxpl3hTEJzJvB3GsWzLitXw==
X-Received: by 2002:a05:6512:114d:b0:52c:c5c4:43d2 with SMTP id 2adb3069b0e04-53348590ee5mr1105070e87.47.1724238157546;
        Wed, 21 Aug 2024 04:02:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c65f2sm886710466b.29.2024.08.21.04.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 04:02:37 -0700 (PDT)
Message-Id: <970964550ab519c9a8070fada116951bfe04f75d.1724238153.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1776.git.1724238152.gitgitgadget@gmail.com>
References: <pull.1776.git.1724238152.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 Aug 2024 11:02:28 +0000
Subject: [PATCH 3/7] t5000: add GIT_ADVICE=1 to advice tests
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    Johannes.Schindelin@gmx.de,
    ps@pks.im,
    james@jamesliu.io,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <derrickstolee@github.com>

From: Derrick Stolee <derrickstolee@github.com>

Several tests validate the exact output of stderr, including when the stderr
file should be empty. In advance of modifying the advice system to only
output when stderr is a terminal, force the advice system to output in these
cases.

In particular, lib-https.sh must be updated in order for t5541 to succeed as
it calls test_http_push_nonff.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/lib-httpd.sh             | 2 +-
 t/t5505-remote.sh          | 5 +++--
 t/t5520-pull.sh            | 4 ++--
 t/t5541-http-push-smart.sh | 6 ++++--
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index d83bafeab32..b85ce907f05 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -265,7 +265,7 @@ test_http_push_nonff () {
 		echo "changed" > path2 &&
 		git commit -a -m path2 --amend &&
 
-		test_must_fail git push -v origin >output 2>&1 &&
+		test_env GIT_ADVICE=1 test_must_fail git push -v origin >output 2>&1 &&
 		(
 			cd "$REMOTE_REPO" &&
 			echo "$HEAD" >expect &&
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 08424e878e1..3e5215add31 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -1452,10 +1452,11 @@ test_expect_success 'unqualified <dst> refspec DWIM and advice' '
 			else
 				oid=$(git rev-parse some-tag^{$type})
 			fi &&
-			test_must_fail git push origin $oid:dst 2>err &&
+			test_env GIT_ADVICE=1 test_must_fail git push origin $oid:dst 2>err &&
 			test_grep "error: The destination you" err &&
 			test_grep "hint: Did you mean" err &&
-			test_must_fail git -c advice.pushUnqualifiedRefName=false \
+			test_env GIT_ADVICE=1 test_must_fail git \
+				-c advice.pushUnqualifiedRefName=false \
 				push origin $oid:dst 2>err &&
 			test_grep "error: The destination you" err &&
 			test_grep ! "hint: Did you mean" err ||
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 1098cbd0a19..c4a309ce4ae 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -375,7 +375,7 @@ test_expect_success '--rebase with conflicts shows advice' '
 	echo conflicting >>seq.txt &&
 	test_tick &&
 	git commit -m "Create conflict" seq.txt &&
-	test_must_fail git pull --rebase . seq 2>err >out &&
+	test_env GIT_ADVICE=1 test_must_fail git pull --rebase . seq 2>err >out &&
 	test_grep "Resolve all conflicts manually" err
 '
 
@@ -389,7 +389,7 @@ test_expect_success 'failed --rebase shows advice' '
 	# force checkout because `git reset --hard` will not leave clean `file`
 	git checkout -f -b fails-to-rebase HEAD^ &&
 	test_commit v2-without-cr file "2" file2-lf &&
-	test_must_fail git pull --rebase . diverging 2>err >out &&
+	test_env GIT_ADVICE=1 test_must_fail git pull --rebase . diverging 2>err >out &&
 	test_grep "Resolve all conflicts manually" err
 '
 
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 71428f3d5c7..dfd4c21808f 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -145,7 +145,7 @@ test_expect_success 'push fails for non-fast-forward refs unmatched by remote he
 
 	# push main too; this ensures there is at least one '"'push'"' command to
 	# the remote helper and triggers interaction with the helper.
-	test_must_fail git push -v origin +main main:niam >output 2>&1'
+	test_env GIT_ADVICE=1 test_must_fail git push -v origin +main main:niam >output 2>&1'
 
 test_expect_success 'push fails for non-fast-forward refs unmatched by remote helper: remote output' '
 	grep "^ + [a-f0-9]*\.\.\.[a-f0-9]* *main -> main (forced update)$" output &&
@@ -477,7 +477,9 @@ test_expect_success 'Non-ASCII branch name can be used with --force-with-lease'
 
 test_expect_success 'colorize errors/hints' '
 	cd "$ROOT_PATH"/test_repo_clone &&
-	test_must_fail git -c color.transport=always -c color.advice=always \
+	test_env GIT_ADVICE=1 test_must_fail git \
+		-c color.transport=always \
+		-c color.advice=always \
 		-c color.push=always \
 		push origin origin/main^:main 2>act &&
 	test_decode_color <act >decoded &&
-- 
gitgitgadget

