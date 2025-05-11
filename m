Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CB11459EA
	for <git@vger.kernel.org>; Sun, 11 May 2025 14:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746972126; cv=none; b=s9qBkY6wu81cj38UVcg3/4yg4B0pC/LjtXd/iWMayNbXgX4mOnK9wFh21F6okKcCUtgA6J6uiwiJ3SolSsUYvfrDkLDIWUQbMnLg52+pxvI9NYnqSPp+EgVQ2lInL1+kZhM56aGPmM2vnDHRVtNd1nddDseiiIV07i3w6pdAUH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746972126; c=relaxed/simple;
	bh=D6LqkK3b4PPvI/gP5wz6X2LmqYBNcAP2l3ao16d/TIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZR0+guqPjommHlv+kIbWEiGi5pbO+E6k79OlvgiTBP9j/BEUCaCAQAImKULKopS3s6mfSlVlMUpUIHa+a2lT68FXN3K5hWE7HK+4NCZB6LEeVYNOGUmkFPLKoOosLo0SMHBvhYhEnGvoJ7mhPaxJcujLYEKJvjKMFJgNgGfTys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqisvDsM; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqisvDsM"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-739525d4e12so3210086b3a.3
        for <git@vger.kernel.org>; Sun, 11 May 2025 07:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746972124; x=1747576924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LtkxIzChUTHqGhByJErcvwCPjgd/s8ypwYHi+35YfGw=;
        b=LqisvDsM66LTtgnMxQkTZ2+ePqy7idYA4eKWAs2DuTTUFoGrl7k07GDHueYkJjf4vm
         op3TZSbMmWyCQg1ptvu2P3uMOzzjw01tuEWsdTcRgYepje2tCZiV2FrZWwe8lLIaNr9a
         Vg5TeHB4KWt+C+9YKmrgBOogehd+ywTsiHp5qwiquNvles7eUV7SIbl0lpUALrcb6Kot
         ZBeMk3TyeWUFs9PrP0KHaIe0IVxInw01pb0PKvjEoBas/fzIHvSqmdg8n0f6c77S8ydo
         8AN4oDIS9cSMuzoBnClKKIM+4yxgY6G0HLuycd9XsV6Ce+jkOFz2encwBPr20BdjEMrc
         88Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746972124; x=1747576924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtkxIzChUTHqGhByJErcvwCPjgd/s8ypwYHi+35YfGw=;
        b=qSiUvPWaD6/hP5vDVNAgUs3c+znwKUm4Ygx/eYms4k3IVYplsgz7gT3r7FpPD/QeQO
         jJUv7Fzf0E3P3a73eBrylO4g8u7A5U196GREGUXc03BUYf1puWZfWdQzo/lVDnH92LP8
         DqUXgU9DM/TuETifjgWLy2lgwexq8XnDPIRiPxML0BXMtERO0xS5VDevXNK5QkWq4u9F
         DYXitBQytclf+IIAJVyn7q0mZUdbFUS4On02AqYGpO3THciC9McUEsMVW7SZ3UWk3BqV
         L47RZOAb249fyk7aDfuB1xRsVc/SB29Vt3yr+JbFplzFXKQIK1iiPTSkO5FMOqI/knRN
         LZeg==
X-Gm-Message-State: AOJu0YzvVGdCjVss1RtClcHG+t98kKehOrLRYNvv0psAEbKkJNpzA7Ez
	2G3HCikVgugFlk8At8+2S7prWGk/uJjHn4l9QOtExdLFnBaYOs6NqLbTIQ==
X-Gm-Gg: ASbGncvhGnBbr0jmNGlAr+R4hRnRHRLSt0djEjm5+WjbmAEu2HVnlmeG2goyQlTFUht
	T3i6lC+j0xCqCbcL+NQHOVUfdrPA4xK/ZQXxCg0q3NcbnRtyyCvv/1XO4gsSC0hKyGUWZ2YUHuS
	QuB45ay5/BNQvwpUgHq1EHXeVp4EUQEQU1PAI33WTztrnyaZE9AeTHkkT1ockVYDcnkIJueYcOF
	YdEh18CQVJ7l7Er+bAZGadTAL0ER8aIztPIsIU6alTilwc0iBe8mXy2QqTha2HhKjtpDesmXSNg
	o+ksZ0vL2P/j/7kuyYa63KSIl8yTQCDovX7AHWRvkkLpu3o=
X-Google-Smtp-Source: AGHT+IHIcNlletWirrwncezehViLmYWEbMqeZPKSvBPUZe7VQRKF9T1Yf06Ls7+MpKPP7JTz+JF0tg==
X-Received: by 2002:a05:6a00:300b:b0:736:39d4:ccf6 with SMTP id d2e1a72fcca58-7423be710admr17619137b3a.8.1746972124004;
        Sun, 11 May 2025 07:02:04 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74237a8972asm4431460b3a.157.2025.05.11.07.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 07:02:03 -0700 (PDT)
Date: Sun, 11 May 2025 22:01:59 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 3/3] packed-backend: mmap large "packed-refs" file during
 fsck
Message-ID: <aCCt1zJ2yviOz--l@ArchLinux>
References: <aCCtQDnWII-knmEc@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCCtQDnWII-knmEc@ArchLinux>

During fsck, we use "strbuf_read" to read the content of "packed-refs"
without using mmap mechanism. This is a bad practice which would consume
more memory than using mmap mechanism. Besides, as all code paths in
"packed-backend.c" use this way, we should make "fsck" align with the
current codebase.

As we have introduced the helper function "allocate_snapshot_buffer", we
could simple use this function to use mmap mechanism.

Suggested-by: Jeff King <peff@peff.net>
Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/packed-backend.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index e582227772..85f5a45160 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -2069,7 +2069,7 @@ static int packed_fsck(struct ref_store *ref_store,
 {
 	struct packed_ref_store *refs = packed_downcast(ref_store,
 							REF_STORE_READ, "fsck");
-	struct strbuf packed_ref_content = STRBUF_INIT;
+	struct snapshot snapshot = { 0 };
 	unsigned int sorted = 0;
 	struct stat st;
 	int ret = 0;
@@ -2113,24 +2113,19 @@ static int packed_fsck(struct ref_store *ref_store,
 		goto cleanup;
 	}
 
-	if (!st.st_size)
+	if (!allocate_snapshot_buffer(&snapshot, fd, &st))
 		goto cleanup;
 
-	if (strbuf_read(&packed_ref_content, fd, 0) < 0) {
-		ret = error_errno(_("unable to read '%s'"), refs->path);
-		goto cleanup;
-	}
-
-	ret = packed_fsck_ref_content(o, ref_store, &sorted, packed_ref_content.buf,
-				      packed_ref_content.buf + packed_ref_content.len);
+	ret = packed_fsck_ref_content(o, ref_store, &sorted, snapshot.start,
+				      snapshot.eof);
 	if (!ret && sorted)
-		ret = packed_fsck_ref_sorted(o, ref_store, packed_ref_content.buf,
-					     packed_ref_content.buf + packed_ref_content.len);
+		ret = packed_fsck_ref_sorted(o, ref_store, snapshot.start,
+					     snapshot.eof);
 
 cleanup:
 	if (fd >= 0)
 		close(fd);
-	strbuf_release(&packed_ref_content);
+	clear_snapshot_buffer(&snapshot);
 	return ret;
 }
 
-- 
2.49.0

