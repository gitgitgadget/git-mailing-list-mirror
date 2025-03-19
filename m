Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C170224896
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 07:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742369123; cv=none; b=r+6qD3NBIsnbXuD2Fkxkw1TX4RFLBQ4YteOvrHkbeDq1K6VJaAHSl/K3KK3B7antM5fUixPy2aFyNcm7Mrq4XJvIDq19MKC+n9peVJ4vs7fz6C6wOye86RgiCwZ/tPf9YOqkl/mTLDU4lbzBdfzRRMsHkjjz5uWbZqBlRpOkVCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742369123; c=relaxed/simple;
	bh=lPomomhH2Jp5NS+SthBXAIhVGg5p2aKU1Q9Sam35MHA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e7l4Qlnrrs0hzl7+GKgkLdvgB9+GJkXyQcwAmgoUVtiT/S0uoaiQcLCLThdZ6AUqEoHBgINOMB+M4PwbYErEoBA0bH0kqhqX7eQ19R6st6n7JoC9WuJtPFXU8Uw5kX3W92Gk/aVBITmT2WRjkmYxVuUXBsu9jKkKAUKJJr/Jd2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NixRX6Bi; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NixRX6Bi"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5499614d3d2so6898363e87.3
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 00:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742369119; x=1742973919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qv61sTArLdp+ygVLAED5QvzRkh3KapfyJ8EUqp7yke0=;
        b=NixRX6Bina/mky0hCyDTXQI5+iFC3Zo9yZr4Y26OFQZxcIjvC5Cu6cQ+5sMZJX6oCG
         n9u/dL62pN494iK61302OgaQkz7FjrEI3bk9FFyv+3cOZtXOZvjpPdnkOj0WB6kISoAf
         YJyhvlXuddNrZ+gnUCwxyP74OP+fKSTeAOgHjzKyD0zhdYpPGDE4ZX5Ea0xAe3JyVNQs
         2LUI87tdxUaoeSv9I3y1rWO1lQd9kVpsYF+t9LUV/UdLORNR+S0MPjXFXfxfLI28U1A3
         oXZhjyJanlny72CsxYiyCbprrTvlq2LmsXWBtpSfrVxwb+5CfcZjn1yQXz9dfQHfJArj
         0hrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742369119; x=1742973919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qv61sTArLdp+ygVLAED5QvzRkh3KapfyJ8EUqp7yke0=;
        b=DzcgcmaVzgAkPla26jxmjF+4XgwovO4OaPg8l8fhWt9JQnmY9gqiNFwHo6FgUfeZVQ
         fzxIRWd9ka2nWyBOBuvkaHxO1iTDBg5CjtbOuhPRYLefApyVlO0bwYMKq1KOk6FSA/P3
         6/vZiJZNBDN1rEtb1VTb8Mr++Lr2tm6BwMmJE6B0JwVMdzOM+zjDtcgAepy5aJ8NCvqS
         ZqIyI8c/hi4t95LbecNfiqIvJuuM6sttCMt0/A//uvGe9TVPDEJ/LgNYHPU6Q5lO4WRo
         TGdjew5fv+V1hCvxlG4xJT7WvebBiPiTBC/1L2NsAs3JTC+1ZqUSYQqRZ/VUDXTkxNSq
         PRJA==
X-Gm-Message-State: AOJu0Yx84VF/SN83K1z0LFiQtIaKJnyZr8sg+nNMQR5eiaGZo2bm9ypz
	UurFEqgX17Wp4VIjPEF02sVc7f7x4Q7GEtBbu7lePCEf2bBb1VtwnnziTQ==
X-Gm-Gg: ASbGnctHP3qPXhArTtRp5GZT7BezW68wkCM7hxv/3P6lUUvXnamv52o/b/5T8WECWDF
	4m6JzMqNBPMAZb8SmZB9VPwUDfSp3qJf3vnKbgqN2zPMSfoipJ3bFugcnKG35cL3XRUvvJhbXFJ
	lcmBhaTNL3h5MuOV6rxDzuSEHoD8ht9FKIgNpDVYmXjAcfqrVjOV2+bSAzR1HgJ/jDCJ520uLlq
	ATtREXekr3auJ4tHQS8YXzWtxpmDMC7OYnOIocRLwFht8eMksJvewtFdjTGpAU1NAAc9QgtdtJq
	lhrYhmgzeSJFtVuZVyDK/3aZwdv94UvBXzG5oZ627ZJ/37BRO01dsbTqOupUlA==
X-Google-Smtp-Source: AGHT+IF6YXGMWRXVV/QtsPVgr++HkbhmUTRCC/g6WmltZZUYSDR34O9vJuA/g1VcggQTB/c60W8I4w==
X-Received: by 2002:a05:6512:1591:b0:540:2fd2:6c87 with SMTP id 2adb3069b0e04-54acb1b81ecmr481380e87.16.1742369118694;
        Wed, 19 Mar 2025 00:25:18 -0700 (PDT)
Received: from localhost.localdomain ([217.116.228.14])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f209d6esm22089541fa.112.2025.03.19.00.25.17
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 00:25:17 -0700 (PDT)
From: =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To: git@vger.kernel.org
Subject: [PATCH 5/8] pretty: after padding, reset padding info
Date: Wed, 19 Mar 2025 08:23:38 +0100
Message-ID: <e34ae37982e76179aee780c70b48aaaf959a307b.1742367347.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec
In-Reply-To: <cover.1742367347.git.martin.agren@gmail.com>
References: <cover.1742367347.git.martin.agren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After handling a padding directive ("%<" or "%>"), we leave the `struct
padding_args` in a halfway state. We modify it a bit as we apply the
padding/truncation so that by the time we're done, it can't be in quite
as many states as when we started. Still, we don't fully restore it to
its default, no-action state.

"%<" and "%>" should only affect the next placeholder, but leaving a bit
of state around doesn't make it obvious that we don't spill any of it
into our handling of later placeholders. The previous commit closed off
a way of populating only half the `struct padding_args`, thereby fixing
a bug that *also* relied on then having the other half contain this kind
of lingering data.

After that fix, I haven't figured out a way to provoke a bug using just
this here half of the issue. Still, after handling padding, let's drop
all remnants of the previous "%<" or "%>".

Unlike the bug fixed in the previous commit, this could have some
realistic chance of regressing something for someone if they've actually
been using such state leftovers (knowingly or not). Still, it seems
worthwhile to try to tighten this.

This change to pretty.c would have been sufficient to make the test
added in the previous commit pass. Belt and suspenders.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 pretty.c                      | 2 ++
 t/t4205-log-pretty-formats.sh | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/pretty.c b/pretty.c
index a4fa052f8b..f53e77ed86 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1893,6 +1893,8 @@ static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
 	}
 	strbuf_release(&local_sb);
 	c->pad.flush_type = no_flush;
+	c->pad.truncate = trunc_none;
+	c->pad.padding = 0;
 	return total_consumed;
 }
 
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 26987ecd77..d34a7cec09 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -1124,6 +1124,15 @@ test_expect_success 'log --pretty with space stealing' '
 	test_cmp expect actual
 '
 
+test_expect_success 'only the next placeholder gets truncated' '
+	{
+		git log -1 --pretty="format:%<(4,trunc)%H" &&
+		printf "$(git rev-parse HEAD)"
+	} >expect &&
+	git log -1 --pretty="format:%<(4,trunc)%H%H" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'log --pretty with invalid padding format' '
 	printf "%s%%<(20" "$(git rev-parse HEAD)" >expect &&
 	git log -1 --pretty="format:%H%<(20" >actual &&
-- 
2.49.0.472.ge94155a9ec

