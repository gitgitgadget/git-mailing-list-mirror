Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB505762EC
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 18:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708452965; cv=none; b=rC44IOxv54H0Sd1F/nK4xTQWAM/SpEbe7r3iF6M2D6zHyXcvYsiMOe3LwowLd5hNqFE3KOgytfqcE8r65pdScLlP+NAF9OEA6WWdexsFNiwT2tBKgtYkxb4Yp0LLPUvrG85zE53wKz+7+ZxdF7SQDad8UwhND9hn1wdkZgsNnnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708452965; c=relaxed/simple;
	bh=ohY9y6S3ffwzCzM2PDeZFKP+ew2owgJUP8xxxsA9ZQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9eo44ecD/CIh7XpsNvv4b9okl53XyyFUJytIRmv2BBm399f3DTJPYoqt+HwkWIZEgf8YdK9abJ/ASFCGa9BgXR7siwR9guWDbtObgo4Dn5ecKXKwfSMAuPq5kO7B5ldvFOzdw2iykq3VwnYD3OrAF4PMbQAj+k510WSlm5lfaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcxoH8qb; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcxoH8qb"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-59ffbff2841so458753eaf.2
        for <git@vger.kernel.org>; Tue, 20 Feb 2024 10:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708452962; x=1709057762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zw9fSfFRXLK5bgtLhYHc4vHeLRM2y06THhaIQPKwPAo=;
        b=QcxoH8qbTDoNaVjh1HBJv6WXIjjAeEA4oL9CiiMw4R8tnvEtGoiDP741u5KBiQ3tut
         EI9XBYKuw5r08CrRDFHWpdWLz4HeTDi7U1o1CbtJP5Xhl3otZnNl3bgw4PFVzVTfyxXG
         mbrFcgdBr1Lg43qoO8LcLF2nTEQBUGFg2KJXzKcssxtGD+sISVOuZyx4/OQC5EGFjlya
         hpnxv9girCyXo5TYcyK/uUcU7rrs1lT0YhwVNcHqu5jmKasZvicqvFZ591l6foisDdU7
         dl3DOOl8AkLW0rWtRx0wOKD/87s6YlOKkTxugQT6seg2wunGJz74BQurjTFk3IvtEzBM
         a+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708452962; x=1709057762;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zw9fSfFRXLK5bgtLhYHc4vHeLRM2y06THhaIQPKwPAo=;
        b=i9+2xylaB8dHQf146rQa/1sxqsrqrxF7YGWnJFk0ux/nbs0NmQ/QfMSghlSJ/nCiy7
         1efQxbyqu/+zJlDb+uAbAmtKLC6psgeB/mw86rPnQNpbA70cUChhohTP9z5lFPHrdBwc
         0b8sOgC7w9XIMRkZRwAq1UopWw+7xnxSZdruEY/kwQ30oRbpGcgl37OyGaBl5bmvNpdq
         hKnAIsrZk4WFTpdu5v+rmYtDhlmYzGvx1kXUptVaLUo4zD/metvCefb+XAuh8YlTBAag
         RGSktiZ/fCM/F8n5on+wBe6/jHGSDPjbbq9p3WnukSRudevTi1J5v7iYRHEMM2OynqMb
         80VQ==
X-Gm-Message-State: AOJu0YzUK4QBI+AEwRFHA+/m6QOXo7xmc3TfLsqAKWL8eJVBPiCyhOYE
	ASQ8Q9XEelgC4XIHqYz9/rTf/uQgP+gvXflOTf6Ia7f5yBZEwDSg7BNGH/Hp
X-Google-Smtp-Source: AGHT+IENax1Vfxjv3svotgOIt70mtFdOdFtLD3k74DzzYaLvplLe6FG5ON8SwEAfqRK+ujO1foTflA==
X-Received: by 2002:a4a:3542:0:b0:59f:efc9:fd62 with SMTP id w2-20020a4a3542000000b0059fefc9fd62mr4853534oog.7.1708452962689;
        Tue, 20 Feb 2024 10:16:02 -0800 (PST)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id z6-20020a4a8086000000b0059a530f54c6sm1510366oof.10.2024.02.20.10.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 10:16:02 -0800 (PST)
Date: Tue, 20 Feb 2024 12:15:23 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/12] reftable/merged: make `merged_iter` structure
 private
Message-ID: <qprofop624nevbicid4rplfqlanfrujyxiilfqwchrppnmw7u4@3dvw5udjtrah>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1707895758.git.ps@pks.im>
 <be807e7650e2b11e5d6f7dd84ca1c549408f678a.1707895758.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be807e7650e2b11e5d6f7dd84ca1c549408f678a.1707895758.git.ps@pks.im>

On 24/02/14 08:45AM, Patrick Steinhardt wrote:
> The `merged_iter` structure is not used anywhere outside of "merged.c",
> but is declared in its header. Move it into the code file so that it is
> clear that its implementation details are never exposed to anything.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/merged.c | 9 +++++++++
>  reftable/merged.h | 9 ---------
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/reftable/merged.c b/reftable/merged.c
> index 1aa6cd31b7..12ebd732e8 100644
> --- a/reftable/merged.c
> +++ b/reftable/merged.c
> @@ -17,6 +17,15 @@ license that can be found in the LICENSE file or at
>  #include "reftable-error.h"
>  #include "system.h"
>  

suggestion: I think it would be nice to document a little about the
merge iterator here at a high-level. Maybe just to explain that this
allows iteration over multiple tables as if it were a single table.

> +struct merged_iter {
> +	struct reftable_iterator *stack;
> +	uint32_t hash_id;
> +	size_t stack_len;
> +	uint8_t typ;
> +	int suppress_deletions;
> +	struct merged_iter_pqueue pq;
> +};
> +
>  static int merged_iter_init(struct merged_iter *mi)
>  {
>  	for (size_t i = 0; i < mi->stack_len; i++) {
> diff --git a/reftable/merged.h b/reftable/merged.h
> index 7d9f95d27e..288ad66656 100644
> --- a/reftable/merged.h
> +++ b/reftable/merged.h
> @@ -24,15 +24,6 @@ struct reftable_merged_table {
>  	uint64_t max;
>  };
>  

Since we are removing `merge_iter` from the header here, I think we can
also remove the `#include "pg.h"`.

> -struct merged_iter {
> -	struct reftable_iterator *stack;
> -	uint32_t hash_id;
> -	size_t stack_len;
> -	uint8_t typ;
> -	int suppress_deletions;
> -	struct merged_iter_pqueue pq;
> -};
> -
>  void merged_table_release(struct reftable_merged_table *mt);
>  
>  #endif
> -- 
> 2.43.GIT
> 


