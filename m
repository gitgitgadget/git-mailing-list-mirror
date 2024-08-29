Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDAE1B86E7
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 19:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724958026; cv=none; b=llN09fc9wpqOG30UoMP1hbMWpLrn+4jJJyyB3oEKIx8ZNM/F1c3CwGUHyKwA077iQnrg9TFRfxyUHRqq8VhUieqkIJmBtPubnxDSRqONmK+XImLQ0l4ZAtul+CeIZvmkU6pm2uLl1Jd4T8P4kCNGHF3e0/etl7J2txaGg/hjnmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724958026; c=relaxed/simple;
	bh=9/rKFXuSAP8ZlWSA8+uZGndrJ6i7VJUBlV4YWSGnonM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBxlM4VnudG/U9mysfBlm4dLz3zQjsuyGQ+3urRtSkqkJNlndT3raYFTWipWLSw6/HVQPjKofIxAA2JPeNad7trjW0YIUsj/edMEtBt26HM1SpBQG8kdttXHT0aSuyNVb7msBWwmeZdfq47eTf1AcnmR0K3H3K+k6PhiueFCmhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=hSMqXtyc; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="hSMqXtyc"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-44fdde0c8dcso5837301cf.0
        for <git@vger.kernel.org>; Thu, 29 Aug 2024 12:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1724958023; x=1725562823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9/rKFXuSAP8ZlWSA8+uZGndrJ6i7VJUBlV4YWSGnonM=;
        b=hSMqXtycF2GByfIAWzpwA9E2fOgM4mNnBtlYnIfy9tDdQvmacQ81xcrotPC4GQW0fV
         0M9Nnqw9EZKhhQ1PNPJMrTJsrrLdO2hoA4N1mpylMN5AeOl9hZm40VCcI5+OcLQrmPlW
         AKfaWQctZ8/eriec8b93pqffjTk3gkM6ByrLSD4kGTPdPFtUWMRF1oJ+2J89RJhs0GBo
         F8y+VfYEU1DS6ISr1gFHodmSe+H1V49omoVjUuazpcZd1gpcpd1D1TtywLHR/t6CQi48
         1ipCPoY+XR0XbAkSoirHTZanWWcS9OUIBGueT539sdAfEonCShAJjmObawTdZPSYRqNS
         Bx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724958023; x=1725562823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/rKFXuSAP8ZlWSA8+uZGndrJ6i7VJUBlV4YWSGnonM=;
        b=W1mVEEsnIZ1heRinaQIn3AqVXWme1Bj3uKa/opMxA6YepVqOgtdE5BNrfq82iFxSmg
         jLZROKAeidYuGz1JODGT3TpcgIuRXyjV/FBB2/m++owO+ojnuOJ0/thZiCoDWnweFkEr
         GM94VE0Z/vEgkL7SNtVpbrFwf2msVWpubAHA/tV9an80p+Y7A7o3EddjdSbCsoM6FRO/
         RqZRxuo8rReLfKtjBGuqBevGpyvP8bXZ9MDTrLDC8QPpnKuhQcVc3VrWhjzim9W9pay9
         J322x+3PfF2NWVRrMywJrW+sxLWVulPjfVUX2nTvQIOjHQabiH5pwbkKNH0ieesDLmEp
         aCBA==
X-Gm-Message-State: AOJu0YzMBeaOcKKQM924fXIbyN6XBA/DMOXWckysBdx4A3IUQPaTtLg8
	sde292eZwRWCKYDabBVadG8rbWnEMxPNHD+LqdbStR4QDGc3Xtuo5twYNWOa3qU=
X-Google-Smtp-Source: AGHT+IGRvBVsukKwBZ1Kb/SVmK7JtA41viB+9vqJr4Yhlrn0uKSM08X7x/ewhx+lIUprdBNnmNB3Zg==
X-Received: by 2002:a05:622a:53c8:b0:456:7241:3431 with SMTP id d75a77b69052e-4567f57e0b1mr39379881cf.31.1724958022931;
        Thu, 29 Aug 2024 12:00:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682ce3058sm7373861cf.52.2024.08.29.12.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 12:00:22 -0700 (PDT)
Date: Thu, 29 Aug 2024 15:00:21 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] pack-bitmap: initialize `bitmap_writer_init()` with
 packing_data
Message-ID: <ZtDFRYQRLQoe+CHS@nand.local>
References: <cover.1723743050.git.me@ttaylorr.com>
 <9d322fc5399c453913d08f35eee907b5c909ad6b.1723743050.git.me@ttaylorr.com>
 <20240817103155.GA551779@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240817103155.GA551779@coredump.intra.peff.net>

On Sat, Aug 17, 2024 at 06:31:55AM -0400, Jeff King wrote:
> On Thu, Aug 15, 2024 at 01:31:00PM -0400, Taylor Blau wrote:
>
> > In order to determine its object order, the pack-bitmap machinery keeps
> > a 'struct packing_data' corresponding to the pack or pseudo-pack (when
> > writing a MIDX bitmap) being written.
> >
> > The to_pack field is provided to the bitmap machinery by callers of
> > bitmap_writer_build() and assigned to the bitmap_writer struct at that
> > point.
> >
> > But a subsequent commit will want to have access to that data earlier on
> > during commit selection. Prepare for that by adding a 'to_pack' argument
> > to 'bitmap_writer_init()', and initializing the field during that
> > function.
> >
> > Subsequent commits will clean up other functions which take
> > now-redundant arguments (like nr_objects, which is equivalent to
> > pdata->objects_nr, or pdata itself).
>
> This (and the next few follow-on commits) seem like a good change to me.
> It simplifies many of the function calls, and I think it expresses the
> domain logic in the API: there is a single set of objects being mapped
> to bits, and many parts of the process will rely on it.

Thanks. Yeah, it was a little surprising to me that it wasn't already
this way, especially having worked in this area for so long. I suspect
it grew this way organically over time (though haven't actually gone
spelunking through the history to confirm).

> Even the midx code, which is not generating a pack, uses a "fake"
> packing_data as the way to express that (because inherently the bit
> ordering is all coming from the pack-index nature). If we likewise ever
> wrote code to generate bitmaps from an existing pack, it would probably
> use packing_data, too. :)

I agree for the most part, though there is a lot of weight in
packing_data that would be nice to not have to carry around. I know
within GitHub's infrastructure we sometimes OOM kill invocations of "git
multi-pack-index write --bitmap" because of the memory overhead (a lot
of which is dominated by the actual traversal and bitmap generation, but
a lot that comes from just the per-object overhead).

I've thought about alternative structures that might be a little more
memory efficient, but it's never gotten to the top of my list.

Thanks,
Taylor
