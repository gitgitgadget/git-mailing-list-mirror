Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C441DDC11
	for <git@vger.kernel.org>; Sat,  1 Mar 2025 21:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740865652; cv=none; b=Pt+8iTaU6O7FXHmGfwDDUP/SVGuGjmGsCYrs/FfL9HS8HDn+UitKLYdUJx8l/LI0lH9uVncoCKSU4UDUmfGCjv42zBwhXNQ0/12eL/MS1Ko953gxDws2JflHXwWmWHtpYV/+FSH3xcmLPnlRSL0TLgss/KQWBHqHeVbOJ6bQrRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740865652; c=relaxed/simple;
	bh=fMoHu+AnZ0z5NdU9dr+UNA1zvtQ3lMbAEVfz5y1p25g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LA3LnGgMK9BkxhCDNiS540ThRzzPh5Iji1+lmmuAb1RNaM+qD9wizXd9XaVym4R9gEx2pvE6AbY62mH5lDEbKD3QUlry07DAF0EZw0B3Dshj/z7G23IGj8I2vGrYV4is+zzmTaaOB74MXKdootffM57F95IOWuDr3o7rx8/rqCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTjg5Aje; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTjg5Aje"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-390ec7c2cd8so1268660f8f.1
        for <git@vger.kernel.org>; Sat, 01 Mar 2025 13:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740865648; x=1741470448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nANSXsbnMVSPgk9DqfnzIonZ3gmkSlKLzQIs0eyq1Qw=;
        b=HTjg5AjeKgNSFUnxZ7tSHH8bgrhR+9j+yRu1FSkS+k26jXXUGVNp6wP8PWOmZFafbk
         oXSV8YPtbqvMfJ/QrgkOXiF4f1hZ7odm+4rdGmcdK34BwAeQq0PUbHfm80CiQ/QvJcsh
         p5PdGnSyPAlbvwDBtMhSI3nUtvLINp3MElQp3JdJuPm+0DBe/Q3gaGjSPWQfHjmVlRBE
         RkFxss1FCgV4igFOvjIyxuY4nHQAM5O38uJr1iTEk5VTaA2Byf0s2XXeHxG6CNwcBsGT
         sNCBH0nzTEmZuscxDl9IE2MnNrvgfVzygp1OSZZ2afZyhieoRFjiRE3lH3LxUjZ5vbmi
         Iv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740865648; x=1741470448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nANSXsbnMVSPgk9DqfnzIonZ3gmkSlKLzQIs0eyq1Qw=;
        b=YwseRk8z0E/MmMiLq4XNXafN+WiG1XbpbzBpLJvHKUlAbn00Hpzh0I/bn6+TLazvQF
         iC8d9EbJUYfaCqO4obAalti6iPiFngcC+R7sM5qCubGq6+3Z1uto1tyAjOcN+6qoOFMp
         yBNCyrPNwNPYFocTPbsznoKOsUxP4NA9O3KOm0MZ1gNrM7XZVKQXkFNGF+78yMrS5/O6
         dq6bhtI/GQsiFEj2psgUDsJx6kr+4FiAMXYG6TNZA8GCzrb7kgDzMtOQhnvqw9ldiypE
         Vd4ubkHbdkf+qOqWmanbhnsWQY7WhS6mHPTdb2qFxhRbXvncTweRuZ8S2KMLQe93sUz/
         hLAQ==
X-Gm-Message-State: AOJu0Yxf4hDbLhdoByalp+NFvSp5LPcizF+g/+tvwdYlLTg3SAPjnu3O
	WUaY8GatZKsb7YpIkq2QIw2g1e5mp2z9tmyapa0NzRzCZXYIq+11FjX9L2xt
X-Gm-Gg: ASbGncu7oc0L7WEdtT9UjSga40bDCtfWreaX9+SdlfYMANpY/uYQfXPMN0yoxX2qaZq
	5qQPrh8Xu89GLaxnGR4sM5/xu6I/LVvtPIIZYBoyZw2JHh/J/LNh9NaVTx44K5BWxrkTF9LO+og
	xRJnF5ry4KHSIan6h8KEzGIyEB5Tr7J959jc1ZrnguoXXCSfJKp8AyXfLn4Reywrwswn0Wwa+zh
	WzUkaPjhV/ARHcT+jHGdYEMW48peAyx+jYcGwGXX938qUFVeLfJyGxHvs0RL/AYkePwXMlXJjxm
	CgjKgclwwvvDmGNjnYBNijoyrIJzkPMGDI8qZc3ezVdTsLQyD5PH+1SBEqsJ97y1Pi6ocxf+iMm
	iFFO6
X-Google-Smtp-Source: AGHT+IGSp0eETs5ntIxahot1h7SuKuc5JxxVaGBjVf9X645GhMEmK/UOVHP1i23YI+jGWuET5eDzpQ==
X-Received: by 2002:a5d:64a6:0:b0:390:df6c:592a with SMTP id ffacd0b85a97d-390ec9bc813mr6082513f8f.29.1740865648295;
        Sat, 01 Mar 2025 13:47:28 -0800 (PST)
Received: from aleksbgbg.communityfibre.co.uk ([103.205.25.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a72d5sm9603474f8f.31.2025.03.01.13.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 13:47:28 -0800 (PST)
From: Aleks Todorov <aleks.todorov.1337@gmail.com>
To: git@vger.kernel.org
Cc: Aleks Todorov <aleks.todorov.1337@gmail.com>
Subject: [PATCH 5/7] t8015: Add tests for git blame -F
Date: Sat,  1 Mar 2025 21:45:04 +0000
Message-ID: <20250301214652.536439-6-aleks.todorov.1337@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250301214652.536439-1-aleks.todorov.1337@gmail.com>
References: <20250301214652.536439-1-aleks.todorov.1337@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include three tests, testing each facet of the implementation:

  - an empty format test to confirm that the flag is available and
    correctly hooked into git (respects empty format and does not emit
    any blame metadata)

  - a default format test to confirm that both the existing log
    specifiers and the new blame-specific specifiers %F and %L are
    expanded as expected

  - a config test to confirm that the blame.format config is available
    under the correct name and used by the program

Signed-off-by: Aleks Todorov <aleks.todorov.1337@gmail.com>
---
 t/meson.build           |  1 +
 t/t8015-blame-format.sh | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100755 t/t8015-blame-format.sh

diff --git a/t/meson.build b/t/meson.build
index 780939d49f..da798fbc88 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -958,6 +958,7 @@ integration_tests = [
   't8012-blame-colors.sh',
   't8013-blame-ignore-revs.sh',
   't8014-blame-ignore-fuzzy.sh',
+  't8015-blame-format.sh',
   't9001-send-email.sh',
   't9002-column.sh',
   't9003-help-autocorrect.sh',
diff --git a/t/t8015-blame-format.sh b/t/t8015-blame-format.sh
new file mode 100755
index 0000000000..8d05310d5d
--- /dev/null
+++ b/t/t8015-blame-format.sh
@@ -0,0 +1,39 @@
+#!/bin/sh
+
+test_description='git blame -F option'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo line1 >file &&
+	git add file &&
+	git commit -m commit1 &&
+	echo line2 >>file &&
+	git add file &&
+	git commit -m commit2 &&
+	shortId1=$(git rev-parse HEAD^ | cut -c 1-8) &&
+	shortId2=$(git rev-parse HEAD | cut -c 1-8)
+'
+
+test_expect_success 'empty format' '
+	echo "line1\nline2" >expect &&
+	git blame file -F "" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'default format' '
+	echo "$shortId1 file (A U Thor 2005-04-01 13:14:15 +0200 1) line1" >expect &&
+	echo "$shortId2 file (A U Thor 2005-04-01 13:14:15 +0200 2) line2" >>expect &&
+	git blame file -F "%h %F (%an %ai %L) " >/tmp/actual &&
+	test_cmp expect /tmp/actual
+'
+
+test_expect_success 'blame.format config' '
+	echo "$shortId1 file (A U Thor 2005-04-01 13:14:15 +0200 1) line1" >expect &&
+	echo "$shortId2 file (A U Thor 2005-04-01 13:14:15 +0200 2) line2" >>expect &&
+	git config blame.format "%h %F (%an %ai %L) " &&
+	git blame file >/tmp/actual &&
+	test_cmp expect /tmp/actual
+'
+
+test_done
-- 
2.43.0

