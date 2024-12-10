Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B237080A
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 18:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733856353; cv=none; b=Ex2Yrz8RGI8qPtWsASYoXzyrNRM0rg/LJwBtMmKYw0x+EoIPgOWNU6LxJOQpFbKvsRQTwNoEDVfSK+w9oPGvFe/OGRFec8E3QrRMFsxNRAY3frJNWstnD6FEmnjPulpCwAItzQlNhm97gzzNJIe+8u7MrAc5bF7fhY/3bt6ZsWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733856353; c=relaxed/simple;
	bh=Hm7eRlmMLyvj0use0LjmZMSobagTJl5SUqJSZdrz94s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hj360oXRyyaVO5Zr2HfJVUYrQHBiTuSSx/g0rv/iT47xcxV0lh0XYFBg8j5xDSmF6ASiA/GGJZxEt3sQ0xn0Ao+Owzj2zcfr0sRcN7yIPzGtWZCQfzJb51bqIlFkPMXf7bo+qVrJAfbNmGY1bSadGrrC6QJQgvduNR9OeJ9tbW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kO4Amch6; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kO4Amch6"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d0ac3be718so794207a12.1
        for <git@vger.kernel.org>; Tue, 10 Dec 2024 10:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733856350; x=1734461150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYGCLeqLdul+mVz5NP0TeN7a4D3K+VPQJTzGLV8jr7o=;
        b=kO4Amch6/hfMGG9jjAM7R+0SHpHyJ9plDPU26X39ZFsrlmHQ1O8u61OYzvrIH6Sy9t
         WKsxw6A32Dy5IVUIPsgErmYnKCLjFMEyxssButIUZHhIbBc4jquC9mYXC/rkDp8qwgyK
         n3rWkWXzGC39BOjioFbtFQlAipprMCxrt/I5UywsPSsm70NMkKARZ1At0m/Du8neaz0I
         Q707rA7JcdzmR2Cy9IqMnAA346DvwCt8XwXTvAD5lmxIC2ALC5PvQ8LLF6oedY+kAXWi
         pO+fiA0TEItMo98kUX+bhz22WkzbmMuorqMQHsrhRdDqCFxHzn8MXNNjDVZbjz2o2wqM
         61eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733856350; x=1734461150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYGCLeqLdul+mVz5NP0TeN7a4D3K+VPQJTzGLV8jr7o=;
        b=FuElN+nB8eme8ETUYCm6VKppjdZHqHBvzMNsrSVHn1wxUxbWq/komFeu7RxC2WF5B9
         +xOglxHyq4Umjgzr1H+sHgDk6DTNsvwBwSj1+Yy46/6jeOOpLpNKmxPURBCqdyrTSZfN
         V9pM8KSuxJasH6LbhZWfdTGTTPFh6mSBwgN4Fridb72hFj09YTZR+EYYNIL0YyvJrMrO
         XWP4CNWnG+qO0if49VgSdG3vSQ6wgkL9gGbVs0S/jyCq1K4c2R+ysqKaHaWb19XtBq6y
         53QPpPFElIGtRlvIzwjqfNFNcFsPQv0rTcqfol5ErpsK7laUqubNNIYGsvpKYKreKPk0
         NqZg==
X-Gm-Message-State: AOJu0YwQVTWmhFnWRQAaSi79lI0tMSo5W0rU7chrniJtgzz/ok3W3UEJ
	flEggWPR0wdHgWP4p2DyFTUZdzAq9JqtviUbK5mYvcP09ZismAKFP/u4b9zw
X-Gm-Gg: ASbGncsodtkdKxbT3NQLksmoZ/ISOnUYIp6L6AVEK+V2t3we19EBkUwyGnoUGSs0EV8
	C7HXS3lLMxZ79SVQw2QCaPvAbOFcVxiHVXV0O4HGrRvmuZHhN8P5+1P9zuDtpyCVP0Qnps50UvD
	yf+HmapkptdYdp2B0nYGGY7l48WZ6Cgkwd5HrDIWvy6AXwsKaXldrHyD+6WdM4LIizFJHTlt+5l
	fhl8M7hJ/z/+WOYNkI+aTTBG0KjVKTYcnEIYzkOh87zzYqsLksJBiLC9oJTuwU=
X-Google-Smtp-Source: AGHT+IG2P2axJotZotl/honqhAHZHEqmkC8zfI13w/vu5Y7iEIfB5i21xVdxnNf8HDdHYq6BMAPrBA==
X-Received: by 2002:a05:6402:518c:b0:5d3:ba42:e9e1 with SMTP id 4fb4d7f45d1cf-5d41c62c9bamr1446686a12.6.1733856349978;
        Tue, 10 Dec 2024 10:45:49 -0800 (PST)
Received: from localhost.localdomain ([5.29.161.23])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d149a48882sm7895896a12.24.2024.12.10.10.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 10:45:49 -0800 (PST)
From: Roy Eldar <royeldar0@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Roy Eldar <royeldar0@gmail.com>
Subject: [PATCH v3 7/7] git-submodule.sh: rename some variables
Date: Tue, 10 Dec 2024 20:44:42 +0200
Message-Id: <20241210184442.10723-8-royeldar0@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241210184442.10723-1-royeldar0@gmail.com>
References: <20241209165009.40653-1-royeldar0@gmail.com>
 <20241210184442.10723-1-royeldar0@gmail.com>
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
index 2da4d55d64..24276847ad 100755
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

