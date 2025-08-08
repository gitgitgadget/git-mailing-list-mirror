Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E624A2E36E0
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 01:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754615224; cv=none; b=CMs5R36UwAX+br6SEJ7lOLABumHNO6idhMMPaZawnvWnEJFb9m+0lEy+J73ZKOrOtoLEZXtfl4fRzP9VK3LNGePBIGz5vff5pkX/D5ieeAax240fOLISxQ+3uowBHzAH9MD1nWItoOxjK+FNU/AKmOUCcjotu19k5hpqG5OYzQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754615224; c=relaxed/simple;
	bh=7FHPfOxOSgBO2odBocEIPeYEB1XuRMpJyvm2pCnTCgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6kW0PhO7aIpX7jKaQK5h+SXBrvZbFXMTed8voLKr8Qu0L3AihOlQT8jMYuMJtWHekEWgUH152o3xBU51hdsRyirZmd5HtQCxIk0QVea0+0YTJw1+vXZY58t/Gc5wz1kGVsyX4n0945lIw9nMnSgCUdcZoGGBk5G0CA4yAYX51c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fh1sCT4z; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fh1sCT4z"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-321265ae417so2015789a91.2
        for <git@vger.kernel.org>; Thu, 07 Aug 2025 18:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754615222; x=1755220022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5LRfAm4IuoZqy/WrV7YGXiqMF+2eMBF5iumiYOSxPag=;
        b=Fh1sCT4zH6AieS2T8eNXPacrGjbq3RKZppldy7e4Q0F/j9cYv5pfzVDCpb2O81lxgL
         MkfwgXH1THKI8mtasgW3i7xtQALX+4GEgIbETOwrS4cxfBnOiDJBmNh3DZ77TDeRGuDw
         ziROpTtSzzmzrhelafw1mfHo7qSENURyEHSRvRX7t70TAte2o/jcViX6O0CSgs2lXz4i
         nEQrNEYIU7QJFrhV04vP8MgKbDBpVKm2BO+6Bg3pJJkoZ5/cwnXvEjB7we7HyI4I6RSi
         EWLMwP73WmPPNdxmLbDc/rkYqpidyCpfV7Px1dj530JWi2Vf1HJOqepqOxc3A9lEsNDa
         ttnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754615222; x=1755220022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5LRfAm4IuoZqy/WrV7YGXiqMF+2eMBF5iumiYOSxPag=;
        b=mG3yOrYQcOMEjxvGSt0W5wCd+qVVj3NJb3w8nW86O0RA094en8Wq597rdcTHV8TLkK
         /STiYp/e/WSfydICDkGE230lkv03erd+eZsNuvhNb+NzizQXwkRJASzI14GaFrWFdtV2
         XCnajfpo8K2eFFE/D/XEVFixX+Gsk/LWH17ZH7PPatzwk1ycE2akHB+mTsj1Bkxcixty
         KP+YXM28KSyqBcZSsVf4JDu0DMeykEWIu+t7VmteX3LJEqjKleYQ2iqle280LpiFqdmt
         tLAS/YUBlPWfk4ZmCX/bKJ2fEnoIuAG+YX6TpegiayrfJikrrqhMOqzoWwe78igfuoRf
         TiCA==
X-Gm-Message-State: AOJu0YwTPjACAebgyKncp/wDFMAR0jmijFwDHh6QV2Lb1cHWt0PsNg4V
	rQ7GorVktsRr++ZgZdTu61Xzc0By61tIwNAc4mKxMfCZSemf8MB+iluF6vX4hgrdDws=
X-Gm-Gg: ASbGncuCPKlmb/Aakc99FF6yZZFKNYj+Gp9ggIg6nvPp2ndjEVxM2+OpFlg0OCYEELb
	QN/xj8p4OYSZ6MVTyRM2ydjbSpRQESPipzJWtn1hTtT+afuJ0HKCj5VDZLaD37tAdYW1/khozTB
	14us99psZU8DRciRyq85wyDH+rkHU2qqSsHmiLCTTqy6uZ2zC+bR7O2KAHzucG9ySjCcCNWFolP
	uEJKdzuVCbqBRa2Nxd8o7UXgu8NB7bAMp2ziMU79xaWJdXhcG4UhrAP2vIwbCJpV9NxX5PNfYLS
	shjWxSihqGrBIEENGbuZtJGhXrvg5Zzy1JArfOQEmaSVIKCshBhpGS23yaZ634sU8gb2KxDNEoL
	xOY0voUcsrGwBA/NaHunOtz7RsX2bHbmBPx/MGhyaTQIawkOCbgs=
X-Google-Smtp-Source: AGHT+IEalFS3Q943shUUEj6rUPfuyidzAQ5KW3a/ucwE1MbYEjuNx7Ebsqu7sNlVhog48Qo1VcQxCA==
X-Received: by 2002:a17:90b:3951:b0:321:2f06:d3ab with SMTP id 98e67ed59e1d1-32183b4573emr1788084a91.21.1754615221972;
        Thu, 07 Aug 2025 18:07:01 -0700 (PDT)
Received: from archlinux.tail6959dd.ts.net ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-321612596d3sm6610391a91.19.2025.08.07.18.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 18:07:01 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org
Cc: usmanakinyemi202@gmail.com,
	ben.knoble@gmail.com,
	chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	gitster@pobox.com,
	me@ttaylorr.com,
	ps@pks.im,
	"D. Ben Knoble" <ben.knoble+github@gmail.com>
Subject: [PATCH v6 1/3] t/t1517: automate `git subcmd -h` tests outside a repository
Date: Fri,  8 Aug 2025 06:36:49 +0530
Message-ID: <20250808010651.591906-2-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250808010651.591906-1-usmanakinyemi202@gmail.com>
References: <20250803020744.1037392-1-usmanakinyemi202@gmail.com>
 <20250808010651.591906-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual `-h` tests with a loop over all subcommands using
`git --list-cmds=main`. This ensures consistent coverage of `-h`
behavior outside a repo and future-proofs the test by covering
new commands automatically.

Known exceptions are skipped or marked as expected failures.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: D. Ben Knoble <ben.knoble+github@gmail.com>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 t/t1517-outside-repo.sh | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index 8f59b867f2..e9f6d03e1b 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -109,8 +109,6 @@ test_expect_success LIBCURL 'remote-http outside repository' '
 
 test_expect_success 'update-server-info does not crash with -h' '
 	test_expect_code 129 git update-server-info -h >usage &&
-	test_grep "[Uu]sage: git update-server-info " usage &&
-	test_expect_code 129 nongit git update-server-info -h >usage &&
 	test_grep "[Uu]sage: git update-server-info " usage
 '
 
@@ -121,4 +119,32 @@ test_expect_success 'prune does not crash with -h' '
 	test_grep "[Uu]sage: git prune " usage
 '
 
+for cmd in $(git --list-cmds=main)
+do
+	cmd=${cmd%.*} # strip .sh, .perl, etc.
+	case "$cmd" in
+	archimport | cvsexportcommit | cvsimport | cvsserver | daemon | \
+	difftool--helper | filter-branch | fsck-objects | get-tar-commit-id | \
+	http-backend | http-fetch | http-push | init-db | \
+	merge-octopus | merge-one-file | merge-resolve | mergetool | \
+	mktag | p4 | p4.py | pickaxe | remote-ftp | remote-ftps | \
+	remote-http | remote-https | replay | send-email | \
+	sh-i18n--envsubst | shell | show | stage | submodule | svn | \
+	upload-archive--writer | upload-pack | web--browse | whatchanged)
+		expect_outcome=expect_failure ;;
+	*)
+		expect_outcome=expect_success ;;
+	esac
+	case "$cmd" in
+	instaweb)
+		prereq=PERL ;;
+	*)
+		prereq= ;;
+	esac
+	test_$expect_outcome $prereq "'git $cmd -h' outside a repository" '
+		test_expect_code 129 nongit git $cmd -h >usage &&
+		test_grep "[Uu]sage: git $cmd " usage
+	'
+done
+
 test_done
-- 
2.50.1

