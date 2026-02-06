Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAA139525A
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 13:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770384190; cv=none; b=H8ULogrGiLwLt4NBXHb6NrOQXQkT3Xp7GOmuGieAeMiUyjXxhn6ttxcSt0DNQnuL4BSolS2QGIgG0iDof2Buz1QJrya4jYW0d8eLxfpsFsTvahdKkDZugBTM2rnZKzcnego/+Awn9/G7K6JY6MS05v0CxfGhKkRcDb00B2mSrRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770384190; c=relaxed/simple;
	bh=sTvARXBGSIXdzWwsfu7sw/3xeP3O7wJtWoDe67PAeww=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SVZoOSPGjrdDTGuKgrc9CDp+gNwof3GJeFphfg15H5w/MxJlwMSOesT1gk99GAzSJ9mA753f03jW+lq+80lvqljfJ28AmetNb1pvPOdAxfJuLRRMMhpET2fnqlhCiuvd4YwYGe4aTDEAbU9v7AqWJoesOEw0aa6hk9BmqGY/bqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgdmDVYB; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgdmDVYB"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-124899ee9d3so1549344c88.0
        for <git@vger.kernel.org>; Fri, 06 Feb 2026 05:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770384189; x=1770988989; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2Om5lCEApDg8Xs3gJvXLdP3hhF22XIDCXkjS83JCZM=;
        b=fgdmDVYBgb/2x1m6LmOvW93anq/hMMFYSJ0ZuSnJU43gLHoeJMYkM1sm8K7Ny8/z8d
         83pmvMqEzYqMmeF0xqSytqT3LCIZ1TDybHGh9nZvbQUMod6MUaKh747CNo8S/JhVUvPw
         xfV11yosgYemphBjZgW9hsgGc/0Ayv/EhCNWN+GRNQ19NqtSUZ9UQHUpWpcUfl9zT6rT
         G+IxDj0lmNQflY9nleHxni/x6gZ2hJuIw0wNwx5NOZF/Ondv8pLaWni50y6MEDpp8dE+
         rrSdL7ac3e32X2p/zuJRia6SHz7mcrJZFnPeo9hii++2ugeM8O3tlkFKbOUIFzw0USpd
         BLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770384189; x=1770988989;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A2Om5lCEApDg8Xs3gJvXLdP3hhF22XIDCXkjS83JCZM=;
        b=EZW7ZNhHsrCzA6+bdlKX0utk25kIaikF5gcYq5aPoNWuN2vSjClPfgqNUeF1LGru/S
         6IyoENJXHbEtzzldCm2vZDX2gL5AVa6biMbTQvk9wb3E8MpmKxbI3ksjBVt69PXJWgXX
         WeN8sV/jkGJFVqyjq+/jIBYEC/YF2/sDRnhS0xdRWxsDLA5vlUlmkoc1YGMQdPIkMhGg
         q5LHHFwp4CMhv9zi1GRGDUQMItLFlQYTFs50PLVW0HJy7ioO72Tmg6HhO2biuznO/zZN
         qoiJ5F1z453o2ZvuBl686azhNTdnBa0x9Zfc8WJVl7OK+ctn5pgKLCAeXonuzjhjCDsz
         pBtw==
X-Gm-Message-State: AOJu0YwCMr0IOQNMDs9Fjc07HNc2epC5pXrG2XpXr7kejLYAjsC7Xr9H
	uteqdC+/6713d03mB323d/hgmG37eFj5YToA/hTzJSciUQvLkBCS4dp4e9XHuNvz
X-Gm-Gg: AZuq6aLKULRzdTzDcRKXcrsQ6+W8AoJo2+CjvN9G1DUqsgGQl2l5GZ+GnGGwqc1XfP5
	HxYIfMq+jndlLznWzrBzrjJJMhYrv5IXuN48W68frqcEpADtXX0NcJZHSLGECurUawDyhwaWPET
	fty095glPzvv18LO+7zGrfThrS5GaWo/MuPv66H0nQybU7s7lmfM5rBPqu3TVktige+O0MI5/r8
	Eo/LGlPcSGu2XL6RomtwPYHU97/qrwW0EPVb2OS8WpNmi8/huxzuOO9L8LJ2ey2VJukndK2RTW/
	D25M3ErQ7qU39xoI1x2Mt7iDvpQIBcuJjQPMZMbbB2ToOqPMOQ+2ppv/ROhZjOhzoVu8KvA9zIJ
	Lcvbde9ozk+EHaDnN+2oWu6wAOpAf9Vr09XrB1wZ0nPNmBbrNsgCCd2nJRoDEXVQseljY8jvwi/
	XnOqDnGmskmKEi
X-Received: by 2002:a05:7022:20b:b0:11b:c86b:3870 with SMTP id a92af1059eb24-12703f16b27mr1301101c88.4.1770384188459;
        Fri, 06 Feb 2026 05:23:08 -0800 (PST)
Received: from [127.0.0.1] ([57.151.137.36])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1270c4073ebsm281376c88.15.2026.02.06.05.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 05:23:07 -0800 (PST)
Message-Id: <df5c85d9f2a90da9b0ed0c5e70ba4abe08c9d31e.1770384180.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1987.v4.git.1770384180.gitgitgadget@gmail.com>
References: <pull.1987.v3.git.1768376879.gitgitgadget@gmail.com>
	<pull.1987.v4.git.1770384180.gitgitgadget@gmail.com>
From: "Claus Schneider(Eficode) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Feb 2026 13:22:59 +0000
Subject: [PATCH v4 4/5] tests: fix existing tests when add an ignore=all
 submodule
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
Cc: =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason <avarab@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Brandon Williams <bwilliams.eng@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Claus Schneider <claus.schneider@eficode.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Claus Schneider <claus.schneider@eficode.com>,
    "Claus Schneider(Eficode)" <claus.schneider@eficode.com>

From: "Claus Schneider(Eficode)" <claus.schneider@eficode.com>

There are tests that rely on "git add <submodule>" to update the in the
reference in the parent repository which have been updated to use the
--force option.

Updated tests:
- t1013-read-tree-submodule.sh ( fixed in: t/lib-submodule-update.sh )
- t2013-checkout-submodule.sh ( fixed in: t/lib-submodule-update.sh )
- t7406-submodule-update.sh
- t7508-status.sh

Signed-off-by: Claus Schneider(Eficode) <claus.schneider@eficode.com>
---
 t/lib-submodule-update.sh | 6 +++---
 t/t7508-status.sh         | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 36f767cb74..f591de6120 100644
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -95,14 +95,14 @@ create_lib_submodule_repo () {
 			git commit -m "modified file2 and added file3" &&
 			git push origin modifications
 		) &&
-		git add sub1 &&
+		git add --force sub1 &&
 		git commit -m "Modify sub1" &&
 
 		git checkout -b add_nested_sub modify_sub1 &&
 		git -C sub1 checkout -b "add_nested_sub" &&
 		git -C sub1 submodule add --branch no_submodule ../submodule_update_sub2 sub2 &&
 		git -C sub1 commit -a -m "add a nested submodule" &&
-		git add sub1 &&
+		git add --force sub1 &&
 		git commit -a -m "update submodule, that updates a nested submodule" &&
 		git checkout -b modify_sub1_recursively &&
 		git -C sub1 checkout -b modify_sub1_recursively &&
@@ -112,7 +112,7 @@ create_lib_submodule_repo () {
 		git -C sub1/sub2 commit -m "make a change in nested sub" &&
 		git -C sub1 add sub2 &&
 		git -C sub1 commit -m "update nested sub" &&
-		git add sub1 &&
+		git add --force sub1 &&
 		git commit -m "update sub1, that updates nested sub" &&
 		git -C sub1 push origin modify_sub1_recursively &&
 		git -C sub1/sub2 push origin modify_sub1_recursively &&
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index abad229e9d..a5e21bf8bf 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1576,7 +1576,7 @@ test_expect_success 'git commit will commit a staged but ignored submodule' '
 
 test_expect_success 'git commit --dry-run will show a staged but ignored submodule' '
 	git reset HEAD^ &&
-	git add sm &&
+	git add --force sm &&
 	cat >expect << EOF &&
 On branch main
 Your branch and '\''upstream'\'' have diverged,
-- 
gitgitgadget

