Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3291474DA
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 22:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748989327; cv=none; b=BB2A2NMSUm1rFg629l20UZ4no5aJcH1YWI3mIo6Gq12wrwlQRbgMzhPMJhOwY+LOLWt2D5pDtJBbpUBE+G5Z+YdtpNg1g32BgSY4fRl+I5K9coohvNy7K70BTqedR0vF+qInFdmW0vbKxWuDK+3tiw44oy7CYlJXg/Una0o0BeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748989327; c=relaxed/simple;
	bh=1ZAdo83PzQRilQtGRgIpDzoq2NmcWhFQSp69o2WEKD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7A0Dqfvzx1BAOB6HWEkmsuALNb5KEv3kOHJZI3zEC8xCfsxA6A3ZRifQ2RaGEm/MJNlDtqblQQW7ZeIgfFqKw5dChAz+YP4ZoBw+R+vPg8xz3jt8RqbUhT1N/v/fJeMUYwAVdSs/f+Wnsmlb6oXZeu1qjf+EHoksOHIf+6NK0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=YvVrC0DU; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="YvVrC0DU"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-70e5599b795so61229607b3.3
        for <git@vger.kernel.org>; Tue, 03 Jun 2025 15:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1748989324; x=1749594124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n5gsnK6wvYWflxLn5Zn3u00Wt7sEmHv97+uJaVlvOD0=;
        b=YvVrC0DU8Gz+9PrXBmbZzHK09Vk7FIniRbRXTZqMe+H8FLWWNFxEFuAHYEgHYvd9gc
         tzG8HW/ByOrbv8C6hTJKT3BVIu2ctojrVbfhkeTROM5fl99CPLPGjW3WpMNy58jw1ms0
         ja9Hh3wu7H/KyeEvM1pwJSzbpRTlk1+tlf73t7Fx1rHpbL402R00zPr3dkrDeq7ydDol
         ZvNgY9yVay3oWBTKRKf5ZyRCNsmj5OyHK/Ea7MqXfyvz1qZdzpDY10he0dzxrorYL0la
         5E4rEhgX84rbzfCrEKovB7C/nROeCr1xcBak2eZtT6cmUfo4MsRzHwcE/hlDtGBR0gut
         3KOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748989324; x=1749594124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5gsnK6wvYWflxLn5Zn3u00Wt7sEmHv97+uJaVlvOD0=;
        b=ndvhdxaGJjDUWohNSKOvQICgTcLvBg6cAmnn5JiJCaAzWsxnCJhGBEZ2fx7bsz5ffX
         gXO4lpbLsyoVb5zB9xcKfJnn0n8SkZNE51BJK1rBVoGfUjlF4xq6lY+eg9+o+YgJa71e
         HiQRBXPEKdRCI7Tg0ZAOxGCzr71RvhIqCCNu8rJCi+oiav2bVFpYI9wdS8k3BW59FarE
         hBQAzSJ6J+pJPZpCRHdaZinquQhbqKR+fn8LxMniBiT+s+mKRdWw/d/+MRndgGJYxuQW
         0Hqg0FhIBSHcgv3AvU4TNEBXy7WmGuEbn/6PjfmoV4ZxuwBk+mzI7RjFzVMwGsV5HjEU
         dirw==
X-Gm-Message-State: AOJu0Yz4ykfuSBjnCjfjOsR20q1O+CAPzbxhn0sQG4rtcxBYI0jle+qt
	6B9PjdrcMMgBqSHv7MmcjjwJJ1hUz/F1uK0N1q2gpbV+caKRa5hmUFAjFM1fkn41JKk=
X-Gm-Gg: ASbGncswPqgxru6VVvj/abGBT+ZodBjCgL6gUfORxqRKK1nSz9G2WJgJvmUxiuAv4p0
	6j9uDX2jEbNxZghS4vjlk8eBu3GGGgcJry2Z1N4zfXqOPPxuB7Jgz8Ok+T9ss5Y61H92uPlutd9
	bWZlmQKCw/Stw0zaDSPZR+MpPuBVdQ6wetov318tgv0RqqotTpHbKZF/Ygj1T4vfpeF4e+RrIWu
	aTjBK+9L4IYFCJCSMgijWBtZsmvMjwmGKT5737Ja08PehJekVGC3iG5sZpg4Eb7a+nGnqcjnDTM
	Edhf0DXRpZNovJEv68avGwMeH5ue04MOgP1BF2bbgiFsJds7KIEaGL0Bgk0TXcqZIZsEMUdT2Go
	4h7aKNUIVBe2siGyHg7/c6h4=
X-Google-Smtp-Source: AGHT+IFzeK8WJh5T+u0B7d8kAKZ2+aLxuQ9JRL7gO36XgQHwrmzaGEhf/nfUJar4P28tPjv0crBm/A==
X-Received: by 2002:a05:690c:62c5:b0:70e:19e6:6f1e with SMTP id 00721157ae682-710d9d512b9mr7628067b3.1.1748989324162;
        Tue, 03 Jun 2025 15:22:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-70f8abee875sm27225867b3.34.2025.06.03.15.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 15:22:03 -0700 (PDT)
Date: Tue, 3 Jun 2025 18:22:02 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/4] midx: access pack names through
 `nth_midxed_pack_name()`
Message-ID: <aD91ivFa2x1VBGRo@nand.local>
References: <cover.1748198489.git.me@ttaylorr.com>
 <cover.1748473122.git.me@ttaylorr.com>
 <d3508d3cfbddb512dbca4c2177731fffb5827084.1748473122.git.me@ttaylorr.com>
 <xmqqr007jg9b.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr007jg9b.fsf@gitster.g>

On Thu, May 29, 2025 at 01:47:44PM -0700, Junio C Hamano wrote:
> > diff --git a/pack-bitmap.c b/pack-bitmap.c
> > index b9f1d86604..8ddc150778 100644
> > --- a/pack-bitmap.c
> > +++ b/pack-bitmap.c
> > @@ -490,7 +490,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
> >  	for (i = 0; i < bitmap_git->midx->num_packs + bitmap_git->midx->num_packs_in_base; i++) {
> >  		if (prepare_midx_pack(bitmap_repo(bitmap_git), bitmap_git->midx, i)) {
> >  			warning(_("could not open pack %s"),
> > -				bitmap_git->midx->pack_names[i]);
> > +				nth_midxed_pack_name(bitmap_git->midx, i));
>
> This loop runs from 0 to (num_packs + num_packs_in_base).  I
> understand if it runs from num_packs_in_base to (num_packs +
> num_packs_in_base), iterating only on this layer, but probably this
> just tries to open everything (i.e. in addition to num_packs we
> have, we know num_packs_in_base packs are there in our base layer(s),
> so we iterate from 0 to that number).
>
> The updated code converts the global 'i', which runs from 0 to
> "everything under us" num_packs + num_packs_in_base, to
> corresponding layer midx plus offset in it, so it looks good, but
> then, is the original reference to bitmap_git->midx->pack_names[i]
> even correct?  If we have a base, i can run larger than
> bitmap_git->midx->num_packs, which is the size of the array
> bitmap_git->midx->pack_names[].
>
> Or, unlike how the proposed log message portrayed this change as
> (i.e. code clean up), does this patch fix real bugs that manifest
> only when midx files are chained?

Right; the original code was buggy if we had a failure opening a MIDX'd
pack outside of the base layer in an incremental MIDX bitmap. Reading
the proposed log message again, I see what you're saying. I am happy to
clarify that this is indeed a bugfix, not just a cleanup.

> > @@ -2469,7 +2469,7 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
> >  			struct bitmapped_pack pack;
> >  			if (nth_bitmapped_pack(r, bitmap_git->midx, &pack, i) < 0) {
> >  				warning(_("unable to load pack: '%s', disabling pack-reuse"),
> > -					bitmap_git->midx->pack_names[i]);
> > +					nth_midxed_pack_name(bitmap_git->midx, i));
> >  				free(packs);
> >  				return;
> >  			}
>
> Similar to the above, this is also in a loop that runs from 0 to
> num_packs+num_packs_in_base.  Is the array access to find the name
> for the error message in the original even correct when midx are
> chained?

Right; this spot suffers from the same bug as the previous hunk.

> > diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
> > index ac81390899..fbed0f6919 100644
> > --- a/t/helper/test-read-midx.c
> > +++ b/t/helper/test-read-midx.c
> > @@ -53,8 +53,9 @@ static int read_midx_file(const char *object_dir, const char *checksum,
> >  	printf("\nnum_objects: %d\n", m->num_objects);
> >
> >  	printf("packs:\n");
> > -	for (i = 0; i < m->num_packs; i++)
> > -		printf("%s\n", m->pack_names[i]);
> > +	for (i = m->num_packs_in_base; i < m->num_packs + m->num_packs_in_base;
> > +	     i++)
> > +		printf("%s\n", nth_midxed_pack_name(m, i));
>
> OK.  This used to iterate from 0 to num_packs using the local
> offset.  Now it iterates from num_packs_in_base to num_packs_in_base+num_packs,
> meaning we iterate over packs in the given midx.  No change in
> behaviour, as accesses to m->pack_names[i] using the local offset in
> the original was correct, and the updated code iterates using the
> global offset.  This is not a bugfix but is a code cleanup.

Right.

> > @@ -108,7 +109,7 @@ static int read_midx_preferred_pack(const char *object_dir)
> >  		return 1;
> >  	}
> >
> > -	printf("%s\n", midx->pack_names[preferred_pack]);
> > +	printf("%s\n", nth_midxed_pack_name(midx, preferred_pack));
>
> Again, is the original buggy when midx are chained?

This is also a bugfix.

Thanks,
Taylor
