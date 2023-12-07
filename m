Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="U3mHdFzg"
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852B093
	for <git@vger.kernel.org>; Thu,  7 Dec 2023 06:36:44 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-67abaab0bc7so5776456d6.2
        for <git@vger.kernel.org>; Thu, 07 Dec 2023 06:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701959803; x=1702564603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wtL7B7+YGF6+2D9Qjx380pArajtS8YbqkYXeRhjaDRo=;
        b=U3mHdFzgiAGE9hmoKFfIqve6tWEuhZlUr93RIOlpeCJknHXGaZpH7YvntTXRMYl7+Z
         oxnfC9QFGLRHKNpYaL3HKXrgssSSc+icjaIFHACMQxnUyFBwYLxaaPzZTS7MHIosFaeF
         DdoXOfs+QBOqtQkfkZc4Ql5l9KWEEbaBWZ2ayo8JdwP3CaaDut60o+gd4Fi1+X4W1b4O
         DMQtDsHR4e4oX9OXsf1DwCs6OBLlU5cbGI9Tl/c5McIOA5zdRFKtEvc0vzWY8EP4Vr7M
         959tIdQEq7nQa/hDzPwQSyqSEqD0qscW6JsfJfak+xeH7P4pPy1nu8VIcW/pM7paD4Pn
         9xcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701959803; x=1702564603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtL7B7+YGF6+2D9Qjx380pArajtS8YbqkYXeRhjaDRo=;
        b=p+V3Ozp7qNq100lgSqU5asHY3OprvPc0GiO4UKV3bmHjNoM48CbeFw8EoGFgkShtV5
         0dVkczPr6fknWiwSDA8ZL8ox7wPGGpEuebDD6ao9Uvn45gDLjRdL563ZxQkwEXqQyBp1
         a5YmCjHdPErR0LZzXO398b3bmL5zQkURoFAZSVC6LGX6Biw114ZvWGRj/RWQ6SJRkLE1
         AVP9cbevqJZEhoeUkW/7kCGAKvZMFjavKL5CkBDieSH3arbXz3l7f12eVs/KnFC9dNYb
         x3Q1wEU0h/WRFT5ng461XStUQ9gIk0tEp+8wMeiCzqkX3c7ubAiOgRQZEsoh4u+aRreO
         b7YQ==
X-Gm-Message-State: AOJu0YyadMHnDIbq1y/Z3i2pH2B5ce4PW0E8UwBPvHkwBnBz7jm7S+lE
	2dfz1MKuDwXFi5yXgs5RAV6ZmUp+hwa3rzQM3ys=
X-Google-Smtp-Source: AGHT+IFRlOF3IQOf2B9T7mLJmwcv8qm96PyJOHyeZpT2ztBP/SEZYC8JMnbSPEU4VB/YUehrftRM/A==
X-Received: by 2002:a05:6214:c2f:b0:67a:bf84:b811 with SMTP id a15-20020a0562140c2f00b0067abf84b811mr3299287qvd.99.1701959803505;
        Thu, 07 Dec 2023 06:36:43 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id cp13-20020ad44aed000000b0067abe3867a0sm522641qvb.146.2023.12.07.06.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 06:36:43 -0800 (PST)
Date: Thu, 7 Dec 2023 09:36:42 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/24] pack-bitmap: simplify
 `reuse_partial_packfile_from_bitmap()` signature
Message-ID: <ZXHYetGa/e1VjwLn@nand.local>
References: <cover.1701198172.git.me@ttaylorr.com>
 <432854b27c6731bd6ab1fa739b3a086ec0a90be8.1701198172.git.me@ttaylorr.com>
 <ZXHE7_KwukSRBET1@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZXHE7_KwukSRBET1@tanuki>

On Thu, Dec 07, 2023 at 02:13:19PM +0100, Patrick Steinhardt wrote:
> > +	if (reuse_packfile) {
> > +		reuse_packfile_objects = bitmap_popcount(reuse_packfile_bitmap);
> > +		if (!reuse_packfile_objects)
> > +			BUG("expected non-empty reuse bitmap");
>
> We're now re-computing `bitmap_popcount()` for the bitmap a second time.
> But I really don't think this is ever going to be a problem in practice
> given that it only does a bunch of math. Any performance regression
> would thus ultimately be drowned out by everything else.
>
> In other words: this is probably fine.

I definitely agree that any performance regression from calling
bitmap_popcount() twice would be drowned out by the rest of what
pack-objects is doing.

For what it's worth:

- The bitmap_popcount() call is a loop over ewah_bit_popcount64() for
  each of the allocated words. And the latter is more or less three
  copies of:

      b7:	55 55 55
      ba:	48 23 45 f8          	and    -0x8(%rbp),%rax
      be:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
      c2:	48 89 d1             	mov    %rdx,%rcx
      c5:	48 d1 e9             	shr    %rcx
      c8:	48 ba 55 55 55 55 55 	movabs $0x5555555555555555,%rdx
      cf:	55 55 55
      d2:	48 21 ca             	and    %rcx,%rdx
      d5:	48 01 d0             	add    %rdx,%rax
      d8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
      dc:	48 b8 33 33 33 33 33 	movabs $0x3333333333333333,%rax

  Followed by:

     144:	48 0f af c2          	imul   %rdx,%rax
     148:	48 c1 e8 38          	shr    $0x38,%rax
     14c:	5d                   	pop    %rbp
     14d:	c3                   	ret

  With the usual x86 ABI preamble and postamble. So this should be an
  extremely cheap function to compute.

- But, the earlier bitmap_popcount() call in
  reuse_partial_packfile_from_bitmap() is not necessary, since we only
  care whether or not there are _any_ bits set in the bitmap, not how
  many of them there are.

  So we could write something like `bitmap_empty(reuse)` instead, which
  would be much cheaper (again, not that I think we'll notice this
  either way, but throwing away the result of bitmap_popcount() and
  calling it twice does leave me a little unsatisfied).

So I think we could reasonably do something like:

--- 8< ---
diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index 7b525b1ecd..ac7e0af622 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -169,6 +169,15 @@ size_t bitmap_popcount(struct bitmap *self)
 	return count;
 }

+int bitmap_is_empty(struct bitmap *self)
+{
+	size_t i;
+	for (i = 0; i < self->word_alloc; i++)
+		if (self->words[i])
+			return 0;
+	return 1;
+}
+
 int bitmap_equals(struct bitmap *self, struct bitmap *other)
 {
 	struct bitmap *big, *small;
diff --git a/ewah/ewok.h b/ewah/ewok.h
index 7eb8b9b630..c11d76c6f3 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -189,5 +189,6 @@ void bitmap_or_ewah(struct bitmap *self, struct ewah_bitmap *other);
 void bitmap_or(struct bitmap *self, const struct bitmap *other);

 size_t bitmap_popcount(struct bitmap *self);
+int bitmap_is_empty(struct bitmap *self);

 #endif
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 614fc09a4e..e50b322779 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2045,7 +2045,7 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,

 	reuse_partial_packfile_from_bitmap_1(bitmap_git, packs, reuse);

-	if (!bitmap_popcount(reuse)) {
+	if (bitmap_is_empty(reuse)) {
 		free(packs);
 		bitmap_free(reuse);
 		return;
--- >8 ---

Thanks,
Taylor
