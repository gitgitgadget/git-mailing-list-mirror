Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53A91E1A30
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 20:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728505895; cv=none; b=MtlP3FwuUmRGou2/jE+Vvz1ZR55321hCY7WGuyeEjEB5qlW9I0zZuMkL2nBHydMlujTiomTve1YRVxTnQq8RB+swyEg9EK1AUrSYVuypkK4wdu/1SIhY8tz2NOAjFTZ3ta5AVQSZGidsx83SMUEH+mQvV4Ray8JJEKtdOrmBLcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728505895; c=relaxed/simple;
	bh=bC9eK4v84n4FRZ8oq5ek4gaR9/Fgd1GU+eV8sKM+XWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBAwSRcRZP2Pni3upgBZa8KxOBq1/uXrL4GnQkS5koPYa/WL8unlk8Jda8ABkIufeBhn3KZnLTq439gzWuU/cwvxiH9JWKqDFmleWfKEPSlOPIOqLBD9/jSrWWeShqDTGLRaXZvYHq4jWf2WwsOg8RDnYgCzNI9zXZTCOfpuhM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=cGkkvn7v; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="cGkkvn7v"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e28fa2807eeso189540276.1
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 13:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728505893; x=1729110693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l+RPYImUZjOCWOEE4ttOaMWNBXBFypcKjzPRW7st1KQ=;
        b=cGkkvn7v98OhSH0tDwCyJvpUMmTYqFGx+cfykPWZkXA5B5bbfiBc63yrsuUQCXRkhH
         B7VJO8IXnMF8kYYOin2bSpWgB+ZF5wO1hFuclXZ4Rm/9rRH/7jiYcbt+mxYYiNn2eK5n
         +K+Gtjqlq3OOj9rZHkZ3rzvMX6+TGqxPRr2hWxoYG6yfybNtxrIBe5Xn9oQUMarPXTR2
         qLvLUm0lemkcXz3xpWw6LFg3SH7f2SImlE6n0Ius4BuacfKoA9Q7GTcSqIaLetBS5O2u
         zTWfCVqkW5KysI664TmFSxqZUWXYgxn3P3nvjWPjAZAK1snVsac6JBmdE0Mc+0UsKyd1
         xWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728505893; x=1729110693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+RPYImUZjOCWOEE4ttOaMWNBXBFypcKjzPRW7st1KQ=;
        b=Jg3Zq3E8gI9lI8/kAJC6CvJXUEmfaC+EZ2bxl9iW2AUNpU/dpxQ1J+EoNRB9mDXnrt
         fatl8XMaRMVxo01cOoLUBdRo1BoGe9K38c+CFHvGTzB9NcKrCay+UUJzw5oPnEEDiNph
         3VLEtf4kxSSPcT6i/bvYiWFCCVglCq9OJkIyZpimLIOKuTQRauHdL+N848F80KYXfRUE
         7MFwAhDszb2eigJGts59YcXbmkXP02dI6rdfMNrPssOzVJ7/gp0W5W6jw0b8zICVKNPq
         /FgPw/NECq4TN8D66Ta9eRyoER78J9ZEqA6zR6u+9pjRIraDNUqehZJ5Q8nWgFjlVXX8
         SdTw==
X-Gm-Message-State: AOJu0Yy6d4e2N5g9xQJyLRj64O7ZOco1l5lTU9BFgQZFBleCZTXioeU+
	l2SNHArgAqkW3kvNMpQU9tTUBocIjRVeznHBR9cW2Ap+oJXFVWTp0cfOHoYh46EWP8XAELSuOk6
	KI5U=
X-Google-Smtp-Source: AGHT+IF/DjSZ9TlU8RzYaTs2xfc7AG/OlnD/o/uzXBDGmH5h/z3sctTHZrs3g0EwH4piuEiOTYBzVA==
X-Received: by 2002:a05:6902:138f:b0:e28:e746:1f07 with SMTP id 3f1490d57ef6-e28fe44a3b4mr3939626276.16.1728505892716;
        Wed, 09 Oct 2024 13:31:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2904e29b3csm314355276.56.2024.10.09.13.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 13:31:32 -0700 (PDT)
Date: Wed, 9 Oct 2024 16:31:31 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 10/11] pack-bitmap.c: record whether the result was filtered
Message-ID: <dffdd794de3255719028a5f2c64d43048a5a5f60.1728505840.git.me@ttaylorr.com>
References: <cover.1728505840.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1728505840.git.me@ttaylorr.com>

In a following commit, we will prepare to mark objects for reuse which
are stored as deltas, but whose base object wasn't included in the
output pack (e.g., because the client already has it).

We can't, however, take advantage of that optimization when the
traversal removed objects from the result due to either (a) object
filtering, or (b) --unpacked.

That's because in either case, we can't rely on the principle that "if
an object appears in the 'haves' bitmap, that the client already has
that object", since they may not have it as a result of filtering.

Keep track of whether or not we performed any object filtering during
our traversal in preparation to actually implement thin delta
conversion.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 8326a20979e..67ea267ed2a 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -112,6 +112,12 @@ struct bitmap_index {
 	/* "have" bitmap from the last performed walk */
 	struct bitmap *haves;
 
+	/*
+	 * Whether the last performed walk had objects removed from
+	 * 'result' due to object filtering.
+	 */
+	int filtered;
+
 	/* Version of the bitmap index */
 	unsigned int version;
 };
@@ -1684,6 +1690,8 @@ static void filter_bitmap_exclude_type(struct bitmap_index *bitmap_git,
 			bitmap_unset(to_filter, pos);
 	}
 
+	bitmap_git->filtered = 1;
+
 	bitmap_free(tips);
 }
 
@@ -1776,6 +1784,8 @@ static void filter_bitmap_blob_limit(struct bitmap_index *bitmap_git,
 			bitmap_unset(to_filter, pos);
 	}
 
+	bitmap_git->filtered = 1;
+
 	bitmap_free(tips);
 }
 
@@ -1892,6 +1902,8 @@ static void filter_packed_objects_from_bitmap(struct bitmap_index *bitmap_git,
 		if (has_object_pack(&eindex->objects[i]->oid))
 			bitmap_unset(result, objects_nr + i);
 	}
+
+	bitmap_git->filtered = 1;
 }
 
 struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
-- 
2.47.0.11.g487258bca34

