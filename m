Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174B81FCF41
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 20:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729542242; cv=none; b=jHAiPjkX7HfMKzwc5M33XXNFrDTZ3MZ4ep0maWOZgoGSqtLEmszgMDlbjzdkdaz+7rRKRWpsvvuXm2guVrPDs7/cHe469AJU2wvcSAZZCF9ztSPqLZst2Aen7BdtbKba2ZtjESwb36npMpAhh/sfMLZn78CBC4nTWsA7uY10AJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729542242; c=relaxed/simple;
	bh=6LQ6XAxCh153v0xAOvxN8o0yjB0HQHDXS0jr1bnooKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isbIlekCG8ovVnK/pqi0q3UoKgYpsMINPwnVxvCXh8UAgBS7SDGkgb1EigSoEoUN3EfUx15T0JVbJkVUKWE+5Gj3IARUoZeV68jMMID03dfITCUH1EISO4NSu8Uge6uOtpkijQrkCV3UmKroWMm17VpaouVcW+ynyMlo1I5g+bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=hKs+nyp6; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="hKs+nyp6"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e2bdbdee559so1685918276.1
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 13:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729542240; x=1730147040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A+7Idlm9iUEGAms33tmwn5izOWuaqyqx0864+f0KaRU=;
        b=hKs+nyp6S+bcv4WaoY/NyhuutA76ct6X0poJNWTe7U5+zzkvOubBkZfKn7ddU3OHBj
         Si6sAlBWS+IHT9Pg6c4B0qxevL7Zy+GBPR/IJN4N1ZtVwcbDpbe/mxoN2C+ZmI8s63JA
         ntAoRRfsz3Vmyk70duCovGtgJnLga9Zn69y11KZRA7mGdYhxJmwN+9WSoUBnWCF0HvG7
         sdFyuDSOU4rQlumQvypmpDShGKNGt7ceREFvgn2SrVyTVGM2h10KoyjkOxxbFAXUy897
         7Qnk1yWFXgNrBaJfISi6yHCZmyAYrfSSC9sez36vPdA+CD2flEty9UqdsEypV1puUGfz
         HUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729542240; x=1730147040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+7Idlm9iUEGAms33tmwn5izOWuaqyqx0864+f0KaRU=;
        b=jY1CxKD99kalE/mcFGqsO2HYY531HzXE73+i6r1AoiylDY7mH+KiAzbPXqKi7faOTg
         SsWrCDfwhELswsQaA7KmvI550jSm+P5bUHOt77AjMnIW+K33pvN0Y3OGedmnIDdSz52K
         7Z7KDdhr/m8eor8kk3Bv14hwevXJtD4xpswxOQFd2f1Lc4MCgKvskxEJXoj0DYG1ifdA
         IS2qylcrs1ESk8ANnj5cfrZ81MmZsjc62DLMqC6M06hmi0EkHMDZKVMs+l4zKHQL5/Ga
         Cb+dMuUWyEO3U4G5TQlxVdlc2B1d+SgvOXfA4B/SJGFIiHeOgOgiiqqV1bc9rigEZ/Jk
         azvg==
X-Forwarded-Encrypted: i=1; AJvYcCUYqIcCRBCdXEpYXxsZKtK7OqD+22Rt7hi4zDRvhPRyInVnt6Ao+dU3N7JtSjn/JRviF7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG9TSaSmrbhet9g1/WvZx/ukdjFzsodFrK05XApsniAC7WXeMW
	rVfg7nGBzJUO1GsWVPsHfI2Jb9lIutb+rxcPpyrBpDMgyo/uS5LXQVBe8h9ugOM=
X-Google-Smtp-Source: AGHT+IEdT2YhBzJ+oA1Xqm1g5y1sbIryCoYZi0wbJmFxrlX3PF6WaaWqn3w6CwP/8mtVnWjgpasYCg==
X-Received: by 2002:a05:690c:93:b0:6e3:3dbc:ca60 with SMTP id 00721157ae682-6e5bf735420mr104358857b3.8.1729542239922;
        Mon, 21 Oct 2024 13:23:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5ccb70asm8104767b3.79.2024.10.21.13.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 13:23:58 -0700 (PDT)
Date: Mon, 21 Oct 2024 16:23:57 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: fox <fox.gbr@townlong-yak.com>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org
Subject: Re: Bug report: v2.47.0 cannot fetch version 1 pack indexes
Message-ID: <Zxa4XU+j4+SSmk9c@nand.local>
References: <BA07EFA0-0793-420D-BED9-ACD7CEBE0112@townlong-yak.com>
 <20241020012455.GA599236@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241020012455.GA599236@coredump.intra.peff.net>

On Sat, Oct 19, 2024 at 09:24:55PM -0400, Jeff King wrote:
> There are a few things I don't like there, though:
>
>   - obviously reversing the tempfile name back to the idx is hacky. We
>     could probably store the original idx that led us to this pack and
>     use that.

TBH, I don't think that this is all that hacky, but...

>   - I don't _think_ there is any case where that .idx file is precious.
>     We wouldn't be indexing the .pack file if we didn't just download
>     it, and we wouldn't have downloaded it if we already had a
>     .idx/.pack pair. OTOH the name we got from the other side isn't
>     necessarily the same one we'll use locally; we're feeding the pack
>     via "index-pack --stdin", so it will do its own hash to come up with
>     the name. The other side could have used a different scheme, or even
>     be trying to intentionally trick us.
>
> So I feel like the root of the problem is that we moved the other side's
> "pack-1234abcd.idx" into place at all! We do not plan to use it, but
> only need to access it via our custom packed_git structs to see whether
> we want to download the matching pack. And in fact I'd suspect there are
> other possible bugs/trickery lurking, if the other side gives us a
> broken .idx that does not match its pack (our odb would now have the
> broken file with no matching pack).
>
> So IMHO a cleaner fix is that we should keep the stuff we download from
> the remote marked as temporary files, and then throw them away when we
> complete the fetch (rather than just expecting index-pack to overwrite
> them).

...this seems like a much better idea to me. We shouldn't be keeping the
provided *.idx file given that we plan on overwriting it later on in the
process.

This feels like more fallout similar to the one described by c177d3dc50
(pack-objects: use finalize_object_file() to rename pack/idx/etc,
2024-09-26), in particularly the paragraph beginning with "This has some
test and real-world fallout ..." and the one immediately below it.

So I think that your "cleaner fix" is the way to go.

Thanks,
Taylor
