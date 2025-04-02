Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06900F4E2
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 08:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743581752; cv=none; b=C0F3ZlyuYkDNbojePw0f9fLj+JZ8EvSShKUlHdy/4JGAEbviswSzNKAf/JIPtbue7UdJZjyNHQgzFxcDgVcjG8CdkTK23ocn8au9opERxUMV28odfg9NRG5EwrXsUadEAd1VOsRx8G0JDwlfHdEowfZz/1LqLycI9OKw4bp01Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743581752; c=relaxed/simple;
	bh=DgCF46LE2gRTW7zgkYALY8GzRntY4/QnW4vVqOgVP24=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cB/Sp6Op/O1WGQw7pj5N/26pCCuYB4IkSWmFhL/OEeUieh3KNL5zfEY0HQGeYL4CdQ9e94d0lyAs92/LoZXBgZPddC+RIl4eIBvKrd9stGM8udKpybOHnFNWbNWAgZfOO8KlMGA3LmqvvZVoiofo85FSomYfL8eAiCLPaM8j3Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ps57BCaD; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ps57BCaD"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e5c9662131so9956445a12.3
        for <git@vger.kernel.org>; Wed, 02 Apr 2025 01:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743581749; x=1744186549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SGzHTiwMeWwrGcXQ/lZeXojN+KsA6yBszQoXblqoUF4=;
        b=Ps57BCaD+FwBjR+LhhtLIbGNHaDqXIkUqEHR0POzVpy8A2E2CALXJTkgCW+7TS8Cva
         juDSwa50/bKwR4oYQYDizC2LzriD4wsTtzqohPlnpdpBJrRyMoaq+MLMpADZIC9pf+8O
         vBqeI0PY/LFhKs42kll0s+KH8jns9XznAMjmSMK35j4474lvGTyBjXdUFt+JU+/D9ZQE
         BZP1oIQcXdqkDTOUb9poOABHwoKdzU18VVykh5ioFN97JTvBX66B63XXQyINjsW0RML+
         mf4rN1BxPRow9kXCt4w7+WNyqMz7tIVIYp8RvvVwJzMBR5h+DkYi/l2vnw4n8lpL+SxC
         xg2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743581749; x=1744186549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SGzHTiwMeWwrGcXQ/lZeXojN+KsA6yBszQoXblqoUF4=;
        b=M5FgquWKhMEv+iMet0q9BPSNfJCI7kJnE59/jaLLg1fK9aybO++UWlv4JFtqAapihZ
         uC9egQvmy2vERvangvCaNodZowHeECdiD0ou47pYH6q9BR6NLxi0ogrZlT7cQjgm9m/y
         04uIFrvWESGRFDRHCp/94iEmKIu8nBxQnnssEvW6EYBLpVzHKWhCMZghl6sxRxMs+1Qy
         MvQLkDq05B4hn11ymq7yNvIWBd21BkEnKSVA5jtWNtUznjFd+2pGf98GmGIWevlzHhwT
         XwoDtWqV+D+aajzwGAKu1yPeyJ5Wzxl6boWd7zC6YJcXWkl2pjE4y0wY3osO4u87edRf
         vOhw==
X-Gm-Message-State: AOJu0YzdlimzcNt/U/0ujiqfjFb9xIi5ON0bt/2BwwWmnacP262qAvhd
	IntYjfU8dDHJbba7dGtgbo8wO9dRdstQh2QNJyNpA0wZSayUBw5ii/ZuZzy0Nw==
X-Gm-Gg: ASbGncs1J+T7utFF/CXqXWggrjE9IuZ9JBFsCsxNGDR/eCcYcnK7ibWVtjHueWjfTk5
	ks//YkC3NPPdHGNYul2tLFs9NKyUgX/LS0JwFIndUjRhlBM9E2UBSO5LJch+jmk7aa/mizz3OTr
	KCC1eFE1aDpYrYemmutzuRMBXq7NIg+w7Hxv7bA3fqVIfMOyTKEDDThy10QBDM24he/7q/7PMjT
	OYWFBBvGv1LSKy1IG27EEh5YJAGWh7aMtAuSYMc4YBhz5OSw1KsccyXDlonK1kpS80qv1TxbbWc
	4aPG8BoX60uxGWZTDad49GlIyucyLBKoc06iCro2Bt+I29diPHVU1Ad7/BY3xhQNPnm8FsFSA7M
	GqJNOv7bIOgExr5YVy+qA7L8VtAVG2tN6W7+374tRoW6vDLuirw==
X-Google-Smtp-Source: AGHT+IG2G43Z1Rny1gtVR4bTOw6S0aRQ58acsgXWItJMPOKdpDoyWe0maGWhBjjtgVsvHgTYPShpfw==
X-Received: by 2002:a17:907:9719:b0:abf:742e:1fd7 with SMTP id a640c23a62f3a-ac738c27f02mr1364207866b.57.1743581748809;
        Wed, 02 Apr 2025 01:15:48 -0700 (PDT)
Received: from localhost.localdomain (host-95-230-249-134.business.telecomitalia.it. [95.230.249.134])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71961f149sm880083566b.119.2025.04.02.01.15.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 02 Apr 2025 01:15:48 -0700 (PDT)
From: wang-anthony03 <anthonywang513@gmail.com>
X-Google-Original-From: wang-anthony03 <anthonywang03@icloud.com>
To: git@vger.kernel.org
Cc: wang-anthony03 <anthonywang03@icloud.com>,
	Anthony Wang <anthonywang513@gmail.com>
Subject: [GSoC 2025] [PATCH 1/1] t9811: avoid using pipes
Date: Wed,  2 Apr 2025 10:15:45 +0200
Message-Id: <20250402081545.94784-1-anthonywang03@icloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wang-anthony03 (1):
  The exit code of the upstream in a pipe is suppressed thus we lose any
    exit codes of git commands that are piped. In order to ensure we
    pick up the exit code, we can write the output of the git command to
    a file, testing the exit codes of both the commands.

Signed-off-by: Anthony Wang <anthonywang513@gmail.com>
---
 t/t9811-git-p4-label-import.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
index 5ac5383fb7..5abac938d0 100755
--- a/t/t9811-git-p4-label-import.sh
+++ b/t/t9811-git-p4-label-import.sh
@@ -95,9 +95,10 @@ test_expect_success 'two labels on the same changelist' '
 		cd "$git" &&
 		git p4 sync --import-labels &&
 
-		git tag | grep TAG_F1 &&
-		git tag | grep -q TAG_F1_1 &&
-		git tag | grep -q TAG_F1_2 &&
+		git tag >output &&
+		grep TAG_F1 output &&
+		grep -q TAG_F1_1 output &&
+		grep -q TAG_F1_2 output &&
 
 		cd main &&
 
@@ -208,7 +209,8 @@ test_expect_success 'use git config to enable import/export of tags' '
 		git p4 rebase --verbose &&
 		git p4 submit --verbose &&
 		git tag &&
-		git tag | grep TAG_F1_1
+		git tag >output &&
+		grep TAG_F1_1 output
 	) &&
 	(
 		cd "$cli" &&
-- 
2.39.5 (Apple Git-154)

