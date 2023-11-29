Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="rqbfGhaS"
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326B010C8
	for <git@vger.kernel.org>; Wed, 29 Nov 2023 13:51:15 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-423e95c2d54so1484621cf.3
        for <git@vger.kernel.org>; Wed, 29 Nov 2023 13:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701294674; x=1701899474; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4sCHIS3aypNTiv0aNKQy2odWn809dN221nZA2xXf4KA=;
        b=rqbfGhaSb2i34OCwZuZoQ7SzfyRgxrK8c3RP2R8gZccRLs96F7T7GcB3Yqv+TKU4w/
         OOvVO5eaYzoEKDx7bw1FnZMWVVyCaoOmgt8zfyN3PxmzkygPgKSUt7KKkybpkrV992kG
         xnRVE7kAtOHtp+sRvHwDeMjeYdd07zPrmoX20D9bAg5hOTexKB0C1ZZPMj6UUeRdNDCK
         bWXP0bYLPC/crqTnhh4O57wSWNXx+X20ZYaoZ6cORPVjendZshJbjl6Vug9q007nHbVe
         ODtpcAScLXfvDbG1eGLD+GQnJTYlbsu1jPKb3I8QLrdBi4vzgKf1YK2YHC0MzPY/DhsB
         F9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701294674; x=1701899474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4sCHIS3aypNTiv0aNKQy2odWn809dN221nZA2xXf4KA=;
        b=eEaOmEhMx/pvRwWKCtYMkY5ajMlXsPzwLygG/5i9QRcIphHlD5CMbpeEAYn0Q4Qz0H
         5iE1hdtqOd4I0ljBISxIz51eef3yiBn2W9S3Zv4QYHWlCeoFJu1zHdvqZvW4pMq3jIAF
         q+C9EGry48wtF64wJfnTh7htxKUMZY5U/g/+xbnwntTz1LY8mMAv96oEq7PZ1jR1yZPi
         yt0Sq4jn+MglZ7MfrrsBI0g6wtDFsYnxTGydeEDBNc+cFUzcohBH73yXhsZGhQ6symd4
         vA95K4ELaPsdlNYpe0TMqphHcKgrEfB6nwQYeCrffjbr+8zgZ/b12UsU9Aq+LyMfF345
         WEtg==
X-Gm-Message-State: AOJu0Yz61H9I9QOBA2yIDNR42ImIhEfG/6x51/JVj/u8iejpnchvsMkz
	zD3uD3vE++omH7O3ZApWj9ELNOKxvApthDY9lFs=
X-Google-Smtp-Source: AGHT+IFblCGmjAjZS6My8msa3Z3aHcoOyiNXwG0uCvQKih0aaDKpjhIjv7oT8VaPDqhm2i2vxQ54eQ==
X-Received: by 2002:ac8:7606:0:b0:423:9f01:7e12 with SMTP id t6-20020ac87606000000b004239f017e12mr15103423qtq.26.1701294674218;
        Wed, 29 Nov 2023 13:51:14 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bq6-20020a05622a1c0600b00423e0952d7fsm1535930qtb.95.2023.11.29.13.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 13:51:14 -0800 (PST)
Date: Wed, 29 Nov 2023 16:51:13 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, hanwenn@gmail.com
Subject: Re: [PATCH 2/4] refs: propagate errno when reading special refs fails
Message-ID: <ZWeyUU/NqmGUvyOL@nand.local>
References: <cover.1701243201.git.ps@pks.im>
 <691552a17ec587b0c03e758437c33d58767803aa.1701243201.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <691552a17ec587b0c03e758437c33d58767803aa.1701243201.git.ps@pks.im>

On Wed, Nov 29, 2023 at 09:14:16AM +0100, Patrick Steinhardt wrote:
> diff --git a/refs.c b/refs.c
> index fcae5dddc6..7d4a057f36 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1806,8 +1806,12 @@ static int refs_read_special_head(struct ref_store *ref_store,
>  	int result = -1;
>  	strbuf_addf(&full_path, "%s/%s", ref_store->gitdir, refname);
>
> -	if (strbuf_read_file(&content, full_path.buf, 0) < 0)
> +	errno = 0;

Do we need to set errno to 0 here? Looking at the implementation of
strbuf_read_file(), it looks like we return early in two cases. Either
open() fails, in which errno is set for us, or strbuf_read() fails, in
which case we set errno to whatever it was right after the failed read
(preventing the subsequent close() call from tainting the value of errno).

So I think in either case, we have the right value in errno, and don't
need to worry about setting it to "0" ahead of time.

> +test_expect_success '--exists with existing special ref' '
> +	git rev-parse HEAD >.git/FETCH_HEAD &&
> +	git show-ref --exists FETCH_HEAD
> +'

I don't think that it matters here, but do we need to worry about
cleaning up .git/FETCH_HEAD for future tests?

Thanks,
Taylor
