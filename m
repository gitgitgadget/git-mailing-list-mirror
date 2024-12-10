Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20FF23ED5D
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 18:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733856337; cv=none; b=eh3Kl2Q2xeCz6D2qDImhrGbpiIPcr4TcSYRmcdJOHEOLK+R1cnd/UBKuJWvmKH3fVrvovEd6HC4GKnUT/lR0LYt81oKoN4H/Q9knGs66/bAqW3QYYwSTu+c55aDdTQuOCC5L8s7MDX1Elhyr5XuJJ1V+ZTidVuv2ZrYuli1O7zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733856337; c=relaxed/simple;
	bh=14mN/uQsgMY2nZdTzHXDlnXsPn04Jyi7B7bY8xMAvjU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LAe2rwVTPrcAa+nO/fNTubAcpwSW2qkhdvrQFdt6mPlWbFV8So4rbAa2iMCTk6WNV3d0H5wTKACXqosFoMQFZ5zlohyO53taH7wDWVqy5TChffc4SDg0TND22jHQ5bsyGtCrxzPDZXuLYJVFv9ZbF/hV5Z3UQLDLrvq6CeOOkcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U731u3/b; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U731u3/b"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d0b85c5574so704550a12.2
        for <git@vger.kernel.org>; Tue, 10 Dec 2024 10:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733856334; x=1734461134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gAPGDr+WiUf06luBBNRaYgfVqRmQKfVRA0+eKbJbh8w=;
        b=U731u3/bxGAiz4dPdZlSjFpSOciKihfhcU1rU73NOALRiHC/R+OXrGkt9QrFWsHk39
         a0rhCFD61DeLmCtcVd4CcfvNiqbCnIU8+YpAasH9r/bpyNjWkAjuzXJ/hQrZG8NF6HcY
         bHZVZJj+f7T9uft8mknKrgFqo5Lwbk4Gxm4CRaytmtkBfC/uettkfSkonKpl9F/LKRF8
         PV5Y6t4A2uFxfeypzsTYwP8B/t+UkFjaoLfysLZk6ueK6VW1nT4UES7TqnGtSB0A/LGk
         E/wZ/sEeNVNQbKJTz3JEhGobb0csi1fFzCKAka67iK5/G6AdZBEt8ZSl0L41nL91R/28
         cEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733856334; x=1734461134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gAPGDr+WiUf06luBBNRaYgfVqRmQKfVRA0+eKbJbh8w=;
        b=nsdzdKXzegKSsCUZ2VmNBI8va4cUsWWl8rHccjDQ22wAbCzB+nJZiThCDfc6ApCNIr
         u6VAMwfMiVF3G+BSXGc1csVr1Z5lyP+A4j+wEW8iJwCDeivoxg4hLnffTR0Kw9gBeGII
         fYw+flxxNxEmiLyKugaVRCAAsKbguCAO/DOTFMfCMdsOY+2rhfgJOrajJ7ItoNK5lu/R
         LHtSmhKP6OqC50ARdHoBUkd2L1NxVhS9yv9//RHmvd+SVTZcm0LkY76VToMTzftd5ydA
         Wi8fHDHRhm26lFpMTxJu+oZhHUu4iFR4M0UxO8gT8jF9QjiD2T7wy5PPr2/3c3oo/9p+
         IdNQ==
X-Gm-Message-State: AOJu0YxvwM6zRE6fYV2DqpefzyGzevy36TzVq1SmATFMQycxJ74XVn8z
	blF+JCHCj2U/K4rSYorBy0FiAOwDixM/orOx7uuH9ngyHZenIr0fQ4L4Aing
X-Gm-Gg: ASbGnctjixZ8qybMgKepeKVKNPvh39+xsWW+8HRpLOHQJ2JZ1IPrd9l/JxbCqBiOSKv
	JSLsUsb4Hj7qQACRMCjycrH81wtJj1y9KDVFT+myuM+GOeB4UMBecu3dc4sH1O391dTGYlxriR2
	q2qXkgO8kPti5FZmK7UbJBSCDLc+VtY73HVibGNk/TnWCJpu06T/dCijolnkBsewIALCIk5UFIW
	X6bK/MivhZVB71iBZgOJre3Lrlm1vN0AHckPeQletp5EdPmL7D6beRuZUk7FDw=
X-Google-Smtp-Source: AGHT+IF92yap3Mhrx+FBLiLZlRyTdtX1+7TxGoL+YRZKUvcrgmMQStwrR8PyNT5KmlXLL+npxVw7+g==
X-Received: by 2002:a05:6402:26c4:b0:5cf:f1fd:c688 with SMTP id 4fb4d7f45d1cf-5d41c40cc4dmr1715622a12.1.1733856333532;
        Tue, 10 Dec 2024 10:45:33 -0800 (PST)
Received: from localhost.localdomain ([5.29.161.23])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d149a48882sm7895896a12.24.2024.12.10.10.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 10:45:32 -0800 (PST)
From: Roy Eldar <royeldar0@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Roy Eldar <royeldar0@gmail.com>
Subject: [PATCH v3 1/7] git-submodule.sh: improve parsing of some long options
Date: Tue, 10 Dec 2024 20:44:36 +0200
Message-Id: <20241210184442.10723-2-royeldar0@gmail.com>
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
index 03c5a220a2..d3e3669fde 100755
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
 			force=$1
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

