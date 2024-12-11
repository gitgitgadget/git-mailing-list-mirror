Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AD51C4A20
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 06:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733898843; cv=none; b=fXHme2AUtucpZc3X7uO1x94WvHwRozKMu/DkBEn8ncTzfkmpReVZo6hORl0Wd3H3nClY4N950gkwSHtQItx9jQP1iSARAySaa5l9Qxyg8OyuRubV4UhGKyo3+OgZFlFP6EkmlzLHwSAg2LcmV5v87tCtX2ftj0V00J2j4c3+Vow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733898843; c=relaxed/simple;
	bh=ev+11mU5iXv4dbeuKMdhAAy1wFhfrBowfB/dKnXoVF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mHqBgdoNrSOcLhXzCxDrFsD5pua6OfcLjJfMC9cLmdAgJT4s9LyXosy1yC2y5kwJXhX1jyrPNsQNFVAqSXVhTUQXZBST4/6fIoQ0HANhAH043nXE1MRO3lilAoU7K03WFzHs6LPM511sDyuVDoK7ZUOe+FgaBA299lP3UngONnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbQlWeHt; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbQlWeHt"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3c0bd1cc4so549470a12.0
        for <git@vger.kernel.org>; Tue, 10 Dec 2024 22:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733898839; x=1734503639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2yB1tEk0Nsnls8/N5W2ppxgI65fHdFdL0H5PwofDMQ=;
        b=QbQlWeHtI7dFfqvLlCWsh6SC56RYPsjTn2dZguI5S7MufAr3rsh1LpSTPXDnCpzxEl
         am/6qDivW1PJgULzoCt5DExIEz4wHxxESsw3ZnuNEovfpZWzhUpx1iwE7/yeufT9orAd
         V/f1Lqeus7Z6DHTwOvKQk/ei0zIeFg/Rr06lEPdOQepi6Q1GAyJS938tPUP94fvU2Jkc
         9S8Q9ywC3OOfqF+hI/abiJJDXcvGVSlhaI4wmHARGKFivMiIcPOlzQD+l1nQpfwdStIU
         uXwCwxsuCmsyHmaGKtSQSKrcZs/hNhRMp8hbhpRlHvG8z+DaQLUbQtCd1tmniXJJZudx
         UPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733898839; x=1734503639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2yB1tEk0Nsnls8/N5W2ppxgI65fHdFdL0H5PwofDMQ=;
        b=ZRAJ6WcOwptdhrtx8sPVLSoV7X7KgJvGnSKbftixVlbqksT2ICuQyGfkizLyVdbPky
         ON/R3F/v79U19UrNUivgLaX2qdP5pWk/fyrFqcthALZ6Ruh3Qlv9VoNASzz9btxFmXgB
         g+r8PiTcFWAcNGO3mNxYbSPQZccjL+Bz24eHNOuamTAjDbss9fe8IVdZ61l5X9XpmzCx
         ANAJKiWz+7bwoA9Cf/qygVfkpf0y7GLDsrHqznMVcCz1akhZmoFdvXbQpMGkaGF2EJA1
         /F+hrKzeOK4oNZsdt030lxDAXtnEJnouOTf0ECv1UQ1RjZc3PyDSXrIajJhemPAy9C9+
         Ze6g==
X-Gm-Message-State: AOJu0YzasxFQ6+MJHnm06PMJp7CffULY0UpF+DO8qK8nWSzKHSsLlS9v
	vxK6kF8d3ZS0XYvcBBduzMn4xhGOUaruIBU1X6AL/jGmVzfN0StXjsJQFdvl
X-Gm-Gg: ASbGncsn894Lg8ROGix6qEoauIrz8ZgK7TAIU57Nqv1nRvb6+ZQQ1LJONxS4porFLJk
	tyEFV+5FPN3tFuovmtE7sApeq5brAmhBoOfXrCryDESmOrWZ2VPO3GFsAc2wxY85Lbek5+pa2Vm
	LNDgzKL2YNSQwTLG8PV0JMsYm7+fRv2PSoeVF+ViikrYfOlnV+tGi3ar/djzorCnr7IqzdfCf5I
	fCFNx2LgSDr8POUPPbHHrCrwyRbK4115M+p/k7KzxrjCvUGYZV2KfHEmDfI8y8=
X-Google-Smtp-Source: AGHT+IGS7t6WJoPru2u7ppg5tJoQbyI9ZlGSX1qnSaAU9xAVsg+8DEZA83ABCl9Aphm8kjQCJuNT2Q==
X-Received: by 2002:a05:6402:35d5:b0:5d3:efcf:f163 with SMTP id 4fb4d7f45d1cf-5d433179cecmr377199a12.11.1733898839388;
        Tue, 10 Dec 2024 22:33:59 -0800 (PST)
Received: from localhost.localdomain ([5.29.161.23])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3d00a0370sm6875803a12.6.2024.12.10.22.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 22:33:58 -0800 (PST)
From: Roy Eldar <royeldar0@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= <congdanhqx@gmail.com>,
	Roy Eldar <royeldar0@gmail.com>
Subject: [PATCH v4 7/7] git-submodule.sh: rename some variables
Date: Wed, 11 Dec 2024 08:32:34 +0200
Message-Id: <20241211063234.7610-8-royeldar0@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241211063234.7610-1-royeldar0@gmail.com>
References: <20241210184442.10723-1-royeldar0@gmail.com>
 <20241211063234.7610-1-royeldar0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Every switch and option which is passed to git-submodule.sh has a
corresponding variable which is set accordingly; by convention, the name
of the variable is the option name (for example, "--jobs" and "$jobs").

Rename "$custom_name", "$deinit_all" and "$nofetch", for consistency.

Signed-off-by: Roy Eldar <royeldar0@gmail.com>
---
 git-submodule.sh | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 6df25efc48..2999b31fad 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -40,11 +40,11 @@ init=
 require_init=
 files=
 remote=
-nofetch=
+no_fetch=
 rebase=
 merge=
 checkout=
-custom_name=
+name=
 depth=
 progress=
 dissociate=
@@ -52,7 +52,7 @@ single_branch=
 jobs=
 recommend_shallow=
 filter=
-deinit_all=
+all=
 default=
 summary_limit=
 for_status=
@@ -108,11 +108,11 @@ cmd_add()
 			;;
 		--name)
 			case "$2" in '') usage ;; esac
-			custom_name="--name=$2"
+			name="--name=$2"
 			shift
 			;;
 		--name=*)
-			custom_name="$1"
+			name="$1"
 			;;
 		--depth)
 			case "$2" in '') usage ;; esac
@@ -149,7 +149,7 @@ cmd_add()
 		${reference:+"$reference"} \
 		${ref_format:+"$ref_format"} \
 		$dissociate \
-		${custom_name:+"$custom_name"} \
+		${name:+"$name"} \
 		${depth:+"$depth"} \
 		-- \
 		"$@"
@@ -240,7 +240,7 @@ cmd_deinit()
 			quiet=$1
 			;;
 		--all)
-			deinit_all=$1
+			all=$1
 			;;
 		--)
 			shift
@@ -259,7 +259,7 @@ cmd_deinit()
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper deinit \
 		$quiet \
 		$force \
-		$deinit_all \
+		$all \
 		-- \
 		"$@"
 }
@@ -294,7 +294,7 @@ cmd_update()
 			remote=$1
 			;;
 		-N|--no-fetch)
-			nofetch=$1
+			no_fetch=$1
 			;;
 		-f|--force)
 			force=$1
@@ -381,7 +381,7 @@ cmd_update()
 		$remote \
 		$recursive \
 		$init \
-		$nofetch \
+		$no_fetch \
 		$rebase \
 		$merge \
 		$checkout \
-- 
2.30.2

