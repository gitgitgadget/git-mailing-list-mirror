Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194CA1487C8
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 16:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763087; cv=none; b=cwKlB1/KJsVmvJPN0kR/cKGDIT0V4TxP19yaFHu2s1QANuJDSG/XYHbx8ICTOmvrERuxm7/kWnz3uxtBDiWd7oLMvwY4qyxH7uFyNcwWGUule1Jw/uE/Wh+siVQalSp2Ku7/udLd/l8CjS5mlsQDwya/M6ttBeoHX9b7yXOu/Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763087; c=relaxed/simple;
	bh=A551sKNwUrIgY39NdUMaPNGWYiVWwTi6N66bJo+6OcU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kYM2WfhvcByG5t9FzkI/IpmR5qyr4/0y8LWil6qcWCakZ0AUTeHj2BrfMIp2lQ292RfWwjm/apKBfLHb0fcNEuDcJa86MN0/j/uMwmw8XmudBaKnCEborDoREU48uMs+gt6Pckr2xaJHd6WpFJQUtv1GJMK/vAImKQP65dlbpCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJGCmV1x; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJGCmV1x"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa62fc2675cso69836266b.1
        for <git@vger.kernel.org>; Mon, 09 Dec 2024 08:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733763084; x=1734367884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxPGqA/wMkYPZAbED39kDn5RPPa0ojwbXq22XnPY6JQ=;
        b=IJGCmV1xcWFZ5EJjFA27APymgUMXa532d6jwqOPHbC+D1HwUSvauVaITm7Vxq8TtDc
         6S/aiRRnRpBuCl3GpzSItQfyUg9NUrN807JCaEOSJoH8nAL9h2MZbCl6xl+4hNnTk4Zj
         cnJXH0nqwgOmPlVVB2QBwBD+hBKCLetp6YwCzFrIx2O+E/8uuY3JAN/SWC2kuHh0xDyX
         fdJ2s9MgBulyNU9Vj7VwRhbqgkMd4pf2yc6AVyABIlg1XWlz4dNtSwWq/Y6DYbxfhKiI
         oPHSYKm+IIu6Lv9MbNek6wpsIRuV0qN0biH1MpQQimPUin7EslGPWm4MCz8Nql15nonU
         aQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733763084; x=1734367884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxPGqA/wMkYPZAbED39kDn5RPPa0ojwbXq22XnPY6JQ=;
        b=w7jSEGadDKcS265wCwzN+DqKia2A+ReerRiX2GVDB5kqB82UYsNax447DMTOP5cDeN
         9SI78elDi31Tf4HA2Z+ywKrqVDKUsxvDC4qijuVe9ur9QE++OlEYYPRtidTO3J8McAQo
         sk73z4bbXwtAfB9UOuHAw0iYgZdHwV9f0n32HHqrGU3ZWFkOLC0orNhTWu8Qe75r4KQB
         Yx3AAY64U1VORY5TiZrGjdoE1EB7wLPQx/RsqoC5yPJaSKhRALdNHhkEBZ10TrQNGTfH
         +IK+JpYoHneYDV9mzi6CwU7pykF6Cf8lfyUEkskiIQyyj2TXUHjmzUhRCmKiwBOb0hd3
         sDYQ==
X-Gm-Message-State: AOJu0YxsMsf61U2yXsuwdx86ASQv6lEqPMWVpkbg8kR3faObeYYMRSCP
	yA7q8gVU2cR2QO9gRZRiM1N1dYgveQLztLmnIMSL0j5ZO8k2QPOFRtZ1Duxb
X-Gm-Gg: ASbGncu31xjV3CMtyV5oxshZoNrv9Lu3kppTjHXHSgnCaj/P3EphoVPxHeALwuErtbK
	yHGinJ2WEPAd9evl3QAcahC2yyu9+dR3kSyebwasC7mlf+Kvaa+swD+LYTQPU+ZpcPYz+q+PLHc
	kyDc0QQnKc/f4LMhZIO6qvNPX3XWcUey8ycseiYCW4n0uJdQeoaLoA8tPhslZqrLUR+5XpwlPDN
	O0KYUu/DIifUh/gZ0lDDVssFElMIavc4z+YT2pgFy3LQfdt28WNAW6XuKA=
X-Google-Smtp-Source: AGHT+IEVhTauHcGF1RnrgNLywVOlMFReMx83JumiZuh1UPzrLRGsJAi2+8jbhGF8F9K/eQ5F9pxVzQ==
X-Received: by 2002:a17:907:3f1d:b0:aa6:2572:563a with SMTP id a640c23a62f3a-aa63a10f275mr562902666b.6.1733763083963;
        Mon, 09 Dec 2024 08:51:23 -0800 (PST)
Received: from localhost.localdomain ([5.29.161.23])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa673474e27sm300539766b.102.2024.12.09.08.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 08:51:23 -0800 (PST)
From: Roy Eldar <royeldar0@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Roy Eldar <royeldar0@gmail.com>
Subject: [PATCH v2 3/8] git-submodule.sh: improve parsing of short options
Date: Mon,  9 Dec 2024 18:50:04 +0200
Message-Id: <20241209165009.40653-4-royeldar0@gmail.com>
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

Some command-line options have a short form which takes an argument; for
example, "--jobs" has the form "-j", and it takes a numerical argument.

When parsing short options, support the case where there is no space
between the flag and the option argument, in order to improve
consistency with the rest of the builtin git commands.

Signed-off-by: Roy Eldar <royeldar0@gmail.com>
---
 git-submodule.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/git-submodule.sh b/git-submodule.sh
index a47d2a89f3..fc85458fb1 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -77,6 +77,9 @@ cmd_add()
 			branch=$2
 			shift
 			;;
+		-b*)
+			branch="${1#-b}"
+			;;
 		--branch=*)
 			branch="${1#--branch=}"
 			;;
@@ -352,6 +355,9 @@ cmd_update()
 			jobs="--jobs=$2"
 			shift
 			;;
+		-j*)
+			jobs="--jobs=${1#-j}"
+			;;
 		--jobs=*)
 			jobs=$1
 			;;
@@ -431,6 +437,9 @@ cmd_set_branch() {
 			branch=$2
 			shift
 			;;
+		-b*)
+			branch="${1#-b}"
+			;;
 		--branch=*)
 			branch="${1#--branch=}"
 			;;
@@ -519,6 +528,10 @@ cmd_summary() {
 			isnumber "$summary_limit" || usage
 			shift
 			;;
+		-n*)
+			summary_limit="${1#-n}"
+			isnumber "$summary_limit" || usage
+			;;
 		--summary-limit=*)
 			summary_limit="${1#--summary-limit=}"
 			isnumber "$summary_limit" || usage
-- 
2.30.2

