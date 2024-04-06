Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0301617BAA
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 03:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712374159; cv=none; b=PtGfbVyTGoWoM7ZK5EkOJfA5/IlCmTEXZR9LEvuhu3eFaO+V5UmeCkwSfmm1ii040lzFrzOiFPoVW0yeVJRDZUp9XQ9Vn5rdinKgbX6kDIvZbzepKtWbgFNPhqa4AB0D7SKJy4/dHohUlWPfKPdXfsiToumBP9XVMO5QMFhpddw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712374159; c=relaxed/simple;
	bh=5YBq19aMBx9qzypUw3R0dXm18wuSkijAI06jGZhe/I4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aiYqvkjcEU7Ipdw7URQtiehFvx2tT78pW63G1VH6lwKlWzPVRLFDCIP3LJy5yvUJApGSeUhrCjGnYaaCplBGr2boNkfjsN/HsfHS7Eyz4OvhjHGDt6VAfRm4z0BPne1KyuDWsPc6cyo/yt9AbF8H2udoO07Xugo6zPFaZ3lo94M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBPXymx6; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBPXymx6"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso2156887a12.3
        for <git@vger.kernel.org>; Fri, 05 Apr 2024 20:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712374157; x=1712978957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PVqldlooswL3Ui59nprlaDQHhOG5AO+Di0cX3U6b1AM=;
        b=fBPXymx6Q2DMmKbw2uNmbBTOOP1Thf9JwyisFpUr+4OdareBSDUc33C+7XB9jaW8WI
         w+oy4GSYXtjDwHsm0ZzgMPlFl6qEZmykNkMtHSteN/j7WCsq1AYSTp2ffG1OJvWiod72
         d0lfBnzYHGSsvOzQRSpAI0QFvZSlezEq5flxygak1nU5ks9Tmp+TvgCmC0Nqqd3NLbA1
         jGlBCnizWuUS+pZ1BAIHo9ammGmN9yqKzknJwjWwd7KyvkV6QY1Qip/FbxdqzDvbAz31
         +HOA29lMsKiWibDu7KL0VL8LzTyKOHvDWqhE7A/P1wP8Em3IasYwh1xs9lGhlTlr9T0R
         Lb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712374157; x=1712978957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PVqldlooswL3Ui59nprlaDQHhOG5AO+Di0cX3U6b1AM=;
        b=wQnS2Iuq+UTRgH/k0TxKPJr7spns1qrKabSyrgCJCc3PROt723dQZAhfyGiPYyLTaK
         Fet2c7xbj714ox4ya4Tgb4tAFfNJNumNWjz+t1fdvwdHmLIZHdvWpvR63v4HFLXq9H7k
         kr6nrpzYhkkppJCK3YN1vxIso/vitoIMSC6UHvxeWsWKbCpElTcLuwYaUyznZ+bOrzBn
         JOToAX5RgtdgjOsnJpvkv3Dx22ZDxF2V326LeUfTgDWevCs7gc/bVnkj2gAJ267IJGfW
         2hp9eeueuQP49quMVYMRnrdT3vhkpASSYlJmETKsKRZGPg4WD4VAWHH0ZqilxSAd/rt6
         Lszg==
X-Gm-Message-State: AOJu0YwoT2Hichk9DYR4gRqQXn+GA0JMuwMeHOzFC9Xm2AUD9VCaMj09
	1ZBDEVNiSJ7bGrqgPOjipZqV0j7dNRjBSe1g+w3UuydcVY7OGpp6oZ8zhDcy
X-Google-Smtp-Source: AGHT+IG933Ui7FR4i9gIGkCf9Akgn26aFZh+XmsWQ/cJ+FQ8Lg1W+BGMTa3Ryz2k6gn7aD+PdOh5cg==
X-Received: by 2002:a05:6a20:9784:b0:1a3:e0b5:418 with SMTP id hx4-20020a056a20978400b001a3e0b50418mr2949565pzc.36.1712374157195;
        Fri, 05 Apr 2024 20:29:17 -0700 (PDT)
Received: from thubon.lan ([14.191.223.174])
        by smtp.gmail.com with ESMTPSA id d14-20020a170903230e00b001defa712890sm2379922plh.72.2024.04.05.20.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 20:29:16 -0700 (PDT)
From: =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= <congdanhqx@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= <congdanhqx@gmail.com>
Subject: [PATCH] t9604: Fix test for musl libc and new Debian
Date: Sat,  6 Apr 2024 10:29:10 +0700
Message-ID: <23a4298eababe54ca4b43d7b675b858605d20ec5.1712374021.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e9588666f
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

CST6CDT and the like are POSIX timezone, with no rule for transition.
And POSIX doesn't enforce how to interpret the rule if it's omited.
Some libc resorted back to IANA (formerly Olson) db rules for those
timezones.  Other libc (e.g. musl) interpret that as no transition at
all [1].

In addition, distributions (notoriously Debian-derived, which uses IANA
db for CST6CDT and the like) started to split "legacy" timezones
like CST6CDT, EST5EDT into `tzdata-legacy', which will not be installed
by default [2].

In those cases, t9604 will run into failure.

Let's switch to POSIX timezone with rules to change timezone.

1: http://mm.icann.org/pipermail/tz/2024-March/058751.html
2: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1043250

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
* Note that since our tests are pre-2007, I use the old rules in the timezone.
* We can also use IANA notations, which I believe is better, but that mean we
  will depends on IANA db
 t/t9604-cvsimport-timestamps.sh | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/t/t9604-cvsimport-timestamps.sh b/t/t9604-cvsimport-timestamps.sh
index 2ff4aa932df44..07560d4779872 100755
--- a/t/t9604-cvsimport-timestamps.sh
+++ b/t/t9604-cvsimport-timestamps.sh
@@ -5,9 +5,10 @@ test_description='git cvsimport timestamps'
 
 setup_cvs_test_repository t9604
 
-test_expect_success PERL 'check timestamps are UTC (TZ=CST6CDT)' '
+test_expect_success PERL 'check timestamps are UTC (TZ=America/Chicago)' '
 
-	TZ=CST6CDT git cvsimport -p"-x" -C module-1 module &&
+	TZ=CST6CDT,M4.1.0,M10.5.0 \
+	git cvsimport -p"-x" -C module-1 module &&
 	git cvsimport -p"-x" -C module-1 module &&
 	(
 		cd module-1 &&
@@ -38,9 +39,9 @@ test_expect_success PERL 'check timestamps with author-specific timezones' '
 
 	cat >cvs-authors <<-EOF &&
 	user1=User One <user1@domain.org>
-	user2=User Two <user2@domain.org> CST6CDT
-	user3=User Three <user3@domain.org> EST5EDT
-	user4=User Four <user4@domain.org> MST7MDT
+	user2=User Two <user2@domain.org> CST6CDT,M4.1.0,M10.5.0
+	user3=User Three <user3@domain.org> EST5EDT,M4.1.0,M10.5.0
+	user4=User Four <user4@domain.org> MST7MDT,M4.1.0,M10.5.0
 	EOF
 	git cvsimport -p"-x" -A cvs-authors -C module-2 module &&
 	(
-- 
2.44.0.rc0.258.g7320e9588666f

