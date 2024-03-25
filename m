Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA5F1272AF
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 17:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387476; cv=none; b=FArLQl58eSeTLKqlKY/DFNDWTxpNK0Wc+U2izJN6yBBC5gDyCOORsqyIJwuURiTYMG3vABL+b6mtjLuNxTKJxczSpyliwOQgiRyRIQK+4tHazkcD6BssK1ok9daSlR+27N4llunr5RPUe2AtqKiQ8rR45vIzYXFDf4Yd6nMZKUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387476; c=relaxed/simple;
	bh=TqjaVgNPJNpjRRicv16JJgia3X0dZv9Z009I814wat4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RiUVuPfGAd6l4PFRjVstxH8nIaE4/E8sqUIyfGiZMBb8exoxMfGNwxn6gXm9OCn0Pswz8mhbH83bSRLhxlTRHCu4SemdP4wzKd7uPEqYVi67CCwiaoXGDaw3WA6aLiFKbb5++uENlKQyVly2R3zXXs0XvGX2++c/dO9wCDfo7lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=0PatccOL; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="0PatccOL"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bbbc6e51d0so2851580b6e.3
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1711387473; x=1711992273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GnGIBLKWbE5v3yKfheu+hdHEAHVfHxkWdQ7KR2ETDO0=;
        b=0PatccOLw5xKxqBplCUjxzg+JdksBLJUKS6hgRbPher3opfB3Hb14agM48uojTrgIF
         xiSwgHsaFIVrV7rnKVQXGDDxAJwEmAXtQfpetNu5BOFMDkQBh9gdYQfcB1bRLD5zJCmC
         bF7B3vAu6/O6jnK+yEb3N8vhEoWEWoEsrnWdbb2mDi0PQzwBaRpjeNBav7yVcUK/uFoR
         CtUwXqyntCrHLdDPwhmQx/uGSuYywMa9LFIGxmuLF6HmagOclB14EXW1pcoeC6FgFerG
         qUMpFGX50YgsWbvfSUARxdYJN4BB+4GLd6V4SEy1RhuTABKLYNIf0QKYwBeoAIW+Jg1e
         sUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711387473; x=1711992273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GnGIBLKWbE5v3yKfheu+hdHEAHVfHxkWdQ7KR2ETDO0=;
        b=QWzLujGNIs7YE+D0tCJavRUs+KaggXL6xEz4mS9EyfuW4CJLi8aUJuELtM9uhnpnxY
         fL5TQqS8vGfmrg+DLw+OOHBMBBGSBrkDcnq7hN0bJs+BjZz2O3LQqM28rotxzbKU3K9R
         vqOzejJqK8sAGZXShJDR32jK2mRSJsYMq3ShXfbmLP1983uscKo6ENN5NZ58/OY9pvge
         jrFtPB9H+51VaaFQZf0oWOGWg9TciL02q/i7uQ6n5TUYmwwBxIbYdp98WdZzgJ9zwwQm
         Iug+JyaqJXyzLnJGUjiPuiyQR/UOpDYYa2SFpPQW6PPHDCS+GZ3npBnhdi20iu2oV0lG
         MvjA==
X-Gm-Message-State: AOJu0YwADkWwbsuSukc8TV4h5cr8K6ycR56Cq96ZtsYCfwGsSpZZe4r7
	CVQw5IsEe0EoKBZRPxaatrlACWyUET2fEqSQElhHQVe5oaAvfHhhQww/OykmBuppr/AvmQld3nD
	FHqE=
X-Google-Smtp-Source: AGHT+IHVLEF5wMb+nRy2I12u5xhg4kLIek3Z5ZbZKBVqIR6WsuOXlcIZC+tqL8AUCsEwE9iloOa/Cg==
X-Received: by 2002:a05:6808:179f:b0:3c3:be7d:3c6e with SMTP id bg31-20020a056808179f00b003c3be7d3c6emr10487651oib.41.1711387473502;
        Mon, 25 Mar 2024 10:24:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o26-20020ac8555a000000b0042ebbc1196fsm2770151qtr.87.2024.03.25.10.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 10:24:33 -0700 (PDT)
Date: Mon, 25 Mar 2024 13:24:32 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 05/11] midx: move `write_midx_file_only` to midx-write.c
Message-ID: <31d2e074fbeb81dc856a66fdaee455a7fa70e9c6.1711387439.git.me@ttaylorr.com>
References: <cover.1711387439.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1711387439.git.me@ttaylorr.com>

Prepare to move the last substantial function related to writing from
midx.c to to midx-write.c by first moving a thin wrapper around it.

Like previous changes, this patch does not introduce any behavioral
changes and is best viewed with `--color-moved`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 10 ++++++++++
 midx.c       | 10 ----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index d679e0a131..635e6af193 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -18,6 +18,16 @@ extern int write_midx_internal(const char *object_dir,
 extern struct multi_pack_index *lookup_multi_pack_index(struct repository *r,
 							const char *object_dir);
 
+int write_midx_file_only(const char *object_dir,
+			 struct string_list *packs_to_include,
+			 const char *preferred_pack_name,
+			 const char *refs_snapshot,
+			 unsigned flags)
+{
+	return write_midx_internal(object_dir, packs_to_include, NULL,
+				   preferred_pack_name, refs_snapshot, flags);
+}
+
 int expire_midx_packs(struct repository *r, const char *object_dir, unsigned flags)
 {
 	uint32_t i, *count, result = 0;
diff --git a/midx.c b/midx.c
index 5936bc5b9e..702eca805a 100644
--- a/midx.c
+++ b/midx.c
@@ -1764,16 +1764,6 @@ int write_midx_file(const char *object_dir,
 				   refs_snapshot, flags);
 }
 
-int write_midx_file_only(const char *object_dir,
-			 struct string_list *packs_to_include,
-			 const char *preferred_pack_name,
-			 const char *refs_snapshot,
-			 unsigned flags)
-{
-	return write_midx_internal(object_dir, packs_to_include, NULL,
-				   preferred_pack_name, refs_snapshot, flags);
-}
-
 struct clear_midx_data {
 	char *keep;
 	const char *ext;
-- 
2.44.0.290.g736be63234b

