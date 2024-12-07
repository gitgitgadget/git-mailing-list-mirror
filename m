Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE1E149C54
	for <git@vger.kernel.org>; Sat,  7 Dec 2024 13:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733579585; cv=none; b=mivtq0et9bsT1aJ6YrZUyIm9Y+59HJFwLh2JkTnMQWcLL24z26COo+QtkTfSDYrj52kuzRYgqo3MXOgm5yiw4M8MjdASAi8Iw0tBi8CTt1W47W+DaMlXDKN5vuF5O0ybSJ9e0yTIC2TC+nmJGeNLikjl2zZl71XLJJ3iYeCRJeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733579585; c=relaxed/simple;
	bh=A551sKNwUrIgY39NdUMaPNGWYiVWwTi6N66bJo+6OcU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HFV2XNMFAppEAEu1N1e4GTu/+W7MNnTcFeOKYEppxC+9x+42BIWJHRCXai+VqR8CTNJqgaDQfdt/mypdq3v7HbmHWfK/TXAp7qeb195YVSyzt7kUtz+hCer6Rywnko+FA0Hwnj6RcdRRYodUNovOa3oGcJP6fSnyhkL+MnXxwtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CC1tt/AF; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CC1tt/AF"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa62fc2675cso37229466b.1
        for <git@vger.kernel.org>; Sat, 07 Dec 2024 05:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733579581; x=1734184381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxPGqA/wMkYPZAbED39kDn5RPPa0ojwbXq22XnPY6JQ=;
        b=CC1tt/AF1dSsUlwTK/TPdDSCy7CZbe486QSb/FoyodcLN4VNUftQy9lMXjOOf/ZcqJ
         M5orbPVeOnOOS9yqxgXausz6kU6k1/YGyRyYzeuSC1278NPX2pYifqr3qyWiFSA+HbLx
         htr930+GAUo1iB7yvEqlCOs1v0Ch56kUhj2k+qglNxH7kF9ZUHFWAa9OvVop2PRONMQQ
         l70dFZxhyh6LuNxLhwujSS1UfrQvFE4ZdN2YReKvlsVXpJkDmkPlGHeLWvnMWQcy6lUw
         dO641gdy+mbNLTybWpXH9W77SFCrumjy3BZk9jNbxKtd6lTG6AKP+Mr7Yd2jE6Bm9UjE
         BNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733579581; x=1734184381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxPGqA/wMkYPZAbED39kDn5RPPa0ojwbXq22XnPY6JQ=;
        b=pyMPZF0zcr66GJ7bHUyhTz6IuSXaPhQFN2QuQOeJ5Yk7Wl8OIrf8PvzHSafYF0qttA
         UcFnQkwX2TOGYT8gwYjC4EqF2aawnFlX9DP4qDwMYkZ/0ZOIEdNB7xG/N8cgjPKyGhmq
         /U7xc0O/MGPkxZVaRyvwovOCo4m2mo5LIPgACn2+uTvd3zGxVUfPtwv/BPELXUPJOjc/
         yJAIjiVdyZ58hQUPiryevsjhpCRjAA53c7BIBFGJxW7+R6D+Byc33XmblmBhibyqRQv2
         aTdvY54tua48tVubvOUCjCIt+sm3aRbCoyXDAxnHMvWj4AEhzRdoWuwP+7+Xz9a41HIC
         9Tyg==
X-Gm-Message-State: AOJu0YwvRDtnb/CMOe/p9JbvYAiKY6ctlftSVcQKin+15MSYwkVjokhA
	58FzIOCK1+lJ0JnUyaYnURC6e3G5TfXhKK4qYEj3+kheiXN1ty5H79k9xMTb
X-Gm-Gg: ASbGncuH69dlhnls7Ma2mdlwsuzwAtACk3WS3rnOfBj+mRikPPI6FWNlLgzaSIgd+7G
	b7XCRQuWLr1wRhf+V/s/SH4fMx/fGxqZoX7NpWt4E1RiVhtOwKH3yQ1RobSg/MFxjNosxU1Rw7+
	xv8VPy+KihtWn5Ichf9MWOlBTDCMTX1Ji57J5fZKahTuQkbCU0A/ric0Plfg1eOH6Ilr6MWmMbV
	Ma+1EtLQhG0FKdLKTuQUektcSr7uYTFRcVZ7ImWayTzOeJThLXTE8tBxZQ=
X-Google-Smtp-Source: AGHT+IFTxspNTqGpfI5m/qSkH2mTtsWaPIQyHWmsSnuMOPV5wePq5msHXrJ8Z8HdWnbfOooVEkIjBQ==
X-Received: by 2002:a17:907:944d:b0:aa5:b1bb:3461 with SMTP id a640c23a62f3a-aa63a0c3fc0mr266187066b.4.1733579581371;
        Sat, 07 Dec 2024 05:53:01 -0800 (PST)
Received: from localhost.localdomain ([5.29.161.23])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa62601f4e0sm385811966b.119.2024.12.07.05.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 05:53:01 -0800 (PST)
From: Roy Eldar <royeldar0@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Roy Eldar <royeldar0@gmail.com>
Subject: [PATCH 3/3] git-submodule.sh: improve parsing of short options
Date: Sat,  7 Dec 2024 15:52:01 +0200
Message-Id: <20241207135201.2536-4-royeldar0@gmail.com>
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

