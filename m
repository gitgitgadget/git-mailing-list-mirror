Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F051428E7
	for <git@vger.kernel.org>; Sat,  7 Dec 2024 13:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733579583; cv=none; b=qoia2MobFYaknC4HFL56eV7UIyWgr0SIBLhFNXG7AIgCVFcMlo2NJZKL3hfrEVXPV3SngAZnWz8brxzQAn+QET9ZQY7JbSsbkx8iTDk1ePnQB7Cr8xGSzTDARO9sP0ZmceIylGHIXYaP7O6bbWiBRBej0UKX2DnYULX1GsfbMR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733579583; c=relaxed/simple;
	bh=pzDeZ3DSmvYGy3VbHSeHsAPU+GWiOiAb//hKYq4y66g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gU7HPtsiZOV/3Fmw6B9OWiB7PM2rt3FSIk0hIbGBKk3iYeGp7oYgI01uF2WS8sMFnQ0YUrYWRN8lD85rrZX45voOVbERyQIewN8Pj0zFBwnGh6LCCdaxGvbAmGBd1O4op2TGdyLCicGuL5QaGvmHL9j1eZUZbikVyX3Td8KOTvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/+LyG3J; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/+LyG3J"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d3da226a2aso43914a12.0
        for <git@vger.kernel.org>; Sat, 07 Dec 2024 05:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733579580; x=1734184380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVfWyFkCjAPIQl2JhELKMRT25GIIVVZLVGqa0/iWq8Y=;
        b=O/+LyG3JSmLwT9wAfAAlV9po8/UwO2zgbx1cFSYx3T5amTRusY/IQJG31ZCchAd15N
         CPajPwKfm9B+sMjivw3IRRvWaRSnNTNaLdjO1TScNw3e+4tZcl10CvVl+9JQoPmUxTMS
         M1ObXbx1en5BcsDKqthJ1t3uB7ScDvvhIw/GF32/Rps3kqYkbKJxxR9qgdjBeyLuPY41
         tAgrjeA6J9MTRoOfsQ4W04XYlmnsETc78xZ3dsOPAjCKuSZLxM5iU6/x6ZaAK+lst2Ke
         vrMoZNJjwOaepPjQYrqmLCamf1msd5z5kgMI0iOsZr0azXZTgub6VR+QraBkycA/uVJO
         vrjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733579580; x=1734184380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bVfWyFkCjAPIQl2JhELKMRT25GIIVVZLVGqa0/iWq8Y=;
        b=czvuIlCdLYaWHLD4dGB4I1F/qvob2hCdLsQuJlqhv6XARtEctNxGfRSw3Xhx+tmbCw
         wOKRHV8vdRYh+lYRPq6AEF4WgiEjmKpnAVT/ImpYGgseXJEL5Yrim7FbQl+MwQJaMAxQ
         mGcC51tA1lOj28LIPJ+VuQoVjfev4aS8oK4XonTpKmGY0TGlMmKHCopcZCp7p896m8Qg
         GQXib1ZDb/U6RIK5xQJJC3OSdrsOZ2NDdxwAGn7Yl4SeuN6qeVkxsGGtSVhbPg4hG9gG
         uMV20umoM9Ln4j0lynfbfz+UdtciTKPxMZnFcVSvo1bcV17tbbhPhGmbS5RsKFuF0Y/V
         toyQ==
X-Gm-Message-State: AOJu0YwndPnUtE7CcDP3WMmwyTMEJS+/nCbqTsrpEVcN+X7B3tijF4Nr
	FdiV75QJRW6SeswezN9KEQLAAQaCSK++sJ6T7gHt5DeRYkxIvYSixDbVDreo
X-Gm-Gg: ASbGncvCJKYLw54drnJ5NYtp5RF5fOrtK/E/1UCWTqpcAt+ukjcFYyb4ZRTOFQH7+Q7
	CbX0NAFY2Eo86u2jvCh5MMavhzvLToU6hnOafheGaoYLUjQEJCJeh3BMUz5l2UXXHd/decNIFga
	BQMMBVUXpBn2CLXBzebBu6QxYxLhTNyr0DPaNXUW0pS1Fu4/s6rKWWEk48q4045ObtSGIDo2ggW
	ZLhWoZBjbppi9LielAIRBP68MtsrUv68INX2RgfbbE30mpU7qSF4cx9aD0=
X-Google-Smtp-Source: AGHT+IEBFRZAm1IoMrwH2huKj8UxX8zheOdLuDo6DVJLAF2TjFaTAOdlaPrXMysIOwWLGAkxaMTlXQ==
X-Received: by 2002:a17:907:2d8d:b0:a9a:1dc3:d5b9 with SMTP id a640c23a62f3a-aa63a200391mr238357666b.11.1733579579555;
        Sat, 07 Dec 2024 05:52:59 -0800 (PST)
Received: from localhost.localdomain ([5.29.161.23])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa62601f4e0sm385811966b.119.2024.12.07.05.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 05:52:59 -0800 (PST)
From: Roy Eldar <royeldar0@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Roy Eldar <royeldar0@gmail.com>
Subject: [PATCH 2/3] git-submodule.sh: improve parsing of some long options
Date: Sat,  7 Dec 2024 15:52:00 +0200
Message-Id: <20241207135201.2536-3-royeldar0@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241207135201.2536-1-royeldar0@gmail.com>
References: <20241207135201.2536-1-royeldar0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some command-line options have a long form which takes an argument. In
this case, the argument can be given right after `='; for example,
"--depth" takes a numerical argument, which can be given as "--depth=X".

Support the case where the argument is given right after `=' for all
long options, in order to improve consistency throughout the script.

Signed-off-by: Roy Eldar <royeldar0@gmail.com>
---
 git-submodule.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/git-submodule.sh b/git-submodule.sh
index 107011f613..a47d2a89f3 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -77,6 +77,9 @@ cmd_add()
 			branch=$2
 			shift
 			;;
+		--branch=*)
+			branch="${1#--branch=}"
+			;;
 		-f | --force)
 			force=1
 			;;
@@ -110,6 +113,9 @@ cmd_add()
 			custom_name=$2
 			shift
 			;;
+		--name=*)
+			custom_name="${1#--name=}"
+			;;
 		--depth)
 			case "$2" in '') usage ;; esac
 			depth="--depth=$2"
@@ -425,6 +431,9 @@ cmd_set_branch() {
 			branch=$2
 			shift
 			;;
+		--branch=*)
+			branch="${1#--branch=}"
+			;;
 		--)
 			shift
 			break
-- 
2.30.2

