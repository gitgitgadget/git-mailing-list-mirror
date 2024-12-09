Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7095414D430
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763096; cv=none; b=TB42M5VtDTwOMHiHVmBplM8fx/vffl7DjgUV8JnW3cWw42UiGlP854wZB76TaUAzFWLJvbdTuYI7cihiKRd1d/aj2KLQIFdUq1Q+/GPXo3fyQgoWtl3+Ia1BNXwi0H2ANaOjfVkFfD4lHOXAi/obDy9NM+QZOM+THHl/H3r1ALE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763096; c=relaxed/simple;
	bh=w6kZBdeBwCc3AIqN6w3bzxiNvPzcOCeRrQy47kwuhZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O4KQ9grXy1VhydWPEqd2bHkzMlkzxWnsQv80Z5oStu/G/wRYME/XOeBQBeJlVSg+zONAjTxmGOHr7mzUDRg4QoAVqEkxfGy2ljr9SO6KKQAC7/hsjo1eFo/jVsXZD4FgTs4h+LelB/VoipIF3EtRnykwT3iy6gSrBOr1Pb6vhgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lwi/0XOh; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lwi/0XOh"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d0b85c5574so501112a12.2
        for <git@vger.kernel.org>; Mon, 09 Dec 2024 08:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733763092; x=1734367892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oyb6rQ/GtGZbuPidGq4BS/h97tnwe1X0LPsRdsXX3GI=;
        b=Lwi/0XOh8rrPq9zEcri5YEgfHJNXb6g1GPlyT7gy+9zGAyhwbQqC/FS8DySrvI/cQ1
         on4Vxpe1u8doyAhrtS0BuF7/+Zz6wnzxYP6EPbBxCoQ5dmav5hw/fdVwdhzEla55Pet1
         Oks/ml1NpKkP+m0VkyH8RKbo0jmq80S4/pWQ1tWhuR6b3ijU6VTCC3S2Lvt3m3Wt7sx8
         Biu33puiwZYn9DQy8T07dX5dSMMinmZ9LG/qHKeXD7hRaPRYyS3iW+cSflj8f6CjBZ90
         qfTtMi+ohk9Ztw8oI52esva6zYiATBOcp3wCdtN2H5v2JUEXN8QLUtxAwudvyf5sVhEA
         +AgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733763092; x=1734367892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oyb6rQ/GtGZbuPidGq4BS/h97tnwe1X0LPsRdsXX3GI=;
        b=TbI4AXx1nWL9bgEirRv16otIkSp+Dck67zBNPKBGzJvRRqEw45LaxY13uyQ4PEiQAZ
         pjqC/0ZaL0Mm1rYNBAtR41kxjK45egl4gdvXtsQDOsHztDBs31wiSox8crjm6yfCHun9
         Wc22m8kFh+v7pxOsMtyXm3bDtMgIQI6FmjpQaLnFu/J58Kcq5Yci3EbUbXV4mjRSAJPB
         9t8MLzIeZAvto/nM5CxH+4M8aZKKBN3ibsaQ3NI6pVTWvVzp8ooMGnzJyuvs0roqGgUq
         CpQa+Zg6J1onrGvPxwP35sXFabyVpWD6nUytugajOjBMO+lZg2LAsyXERq7noL95O2nh
         sa5Q==
X-Gm-Message-State: AOJu0YwwVNdcsPEqjtWWConwrxLojvyIKQdqzhKw3Mc1TbN2GA3U9VV2
	zugnTf6Jz8PB9gxA0noMQafXoovL5pHOqQV4F61xZ/yf4NiNckm0hXWc622r
X-Gm-Gg: ASbGncvj7ENZD7QW8+6p3Qr/+UvqNDYPCoDuoac53P63r4h4Mzh0k3pZysYQcaQ+lJv
	FzT3MXHb3Dq5fo6aLAmVd8Hupo9vjTBDqFeqMOAnLDuf8ZUQnesiDTVadq0KQ0jFPD1gRRQZlzu
	6Z3k6SU4KV3QycjNyEWaRDxeaOk6be3EnRa8q0thsOXV5wmbkHCIC9iBLKtH+5FCdoFrC/NkoZj
	e4gHwr89MS45jfgj3nkotS+dV3ASQzl4FvVXK5JMDjXacqjX9UzvJZWT2o=
X-Google-Smtp-Source: AGHT+IGMsYZZ55duJfvo4pd9B39yM27IPtluxVVM9ZyvX/U78a2Y/50D9q2SKD5czQ8GKWbbMdSegA==
X-Received: by 2002:a17:907:894b:b0:aa5:a36c:88f0 with SMTP id a640c23a62f3a-aa69f27e04bmr9310166b.12.1733763092427;
        Mon, 09 Dec 2024 08:51:32 -0800 (PST)
Received: from localhost.localdomain ([5.29.161.23])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa673474e27sm300539766b.102.2024.12.09.08.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 08:51:32 -0800 (PST)
From: Roy Eldar <royeldar0@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Roy Eldar <royeldar0@gmail.com>
Subject: [PATCH v2 8/8] git-submodule.sh: rename some variables
Date: Mon,  9 Dec 2024 18:50:09 +0200
Message-Id: <20241209165009.40653-9-royeldar0@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241209165009.40653-1-royeldar0@gmail.com>
References: <20241207135201.2536-1-royeldar0@gmail.com>
 <20241209165009.40653-1-royeldar0@gmail.com>
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

Rename "$custom_name" and "$deinit_all" in order to improve consistency.

Signed-off-by: Roy Eldar <royeldar0@gmail.com>
---
 git-submodule.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 2da4d55d64..9c10472b5f 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -44,7 +44,7 @@ nofetch=
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
-- 
2.30.2

