Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="h9bxDkFJ"
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C6A1713
	for <git@vger.kernel.org>; Thu,  7 Dec 2023 12:43:48 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-77f4b8bbe0eso9038685a.1
        for <git@vger.kernel.org>; Thu, 07 Dec 2023 12:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701981827; x=1702586627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NqkVLeoKqodn9ajU02euS+0+vg/pQScXI4dduuEKI5Q=;
        b=h9bxDkFJEykMOFYAMui6DTC7ZWmEZghZGcjQ7VSbm2/yvrwTRaqkHYE2AzSputdFfq
         qafZvrux8Hf2gkt1/XIvfDq9ljiSMyJF7qGg0xSVz90M7G0NwCnKI6cizdTvQNRJeegC
         us0AhGiRlueJw1CU4MRicVaaoBjYBXQ0eh9jgPSFvtwkHUQk22wvhBqT3lmtxxPCPziK
         rdpSR6Av4+SVPuKzv1rCjLoH5sBPtqbJ1UXb79o81cIiyO3wTIjdagdoaNZA8Qihc6+g
         bpVrPDbpls+LUrSenPnUQuhlC/Z9kLzbQn7ke5Ucu6VVv/GlCAnhpAXsnWzqabrsiaiZ
         zeew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701981827; x=1702586627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqkVLeoKqodn9ajU02euS+0+vg/pQScXI4dduuEKI5Q=;
        b=NKLsviesrZ6SXuA+VnfyyEeC93owussZJU/9bCHahcFC7/bOXe9Poz2sFpAjt2MEvw
         7Gt1/kecMthiY+3IRI3NNofhn7c1XDKg1+N07FIi+Gp2muVRoXQXAIgqyhDo8BvdKTBK
         QMygEJtXCrnjhiPd4uCdgsmIwLch+nFj5i75YsbxLai+V8CTdhKvRnA+bvTInKRaIBOW
         kN7g15v5yZhvPvVcRhtM/L1ECtfBHxFYp/hR1Aa6oCIUghV5JmVXBKDuSPVKJwwcb7Zu
         02553Q8feJDfST0xjs63J8WKtWw9PM7SskV78GI8dCfpf8LibEwtHarprEFZlTA32cJB
         lx2A==
X-Gm-Message-State: AOJu0YxA6rp+LM/yAI4k+fx42VshxkNZQ4gN6oiflEztupo7Ojkrs2+2
	SSXV1US8ikXC3pjC1qwkBmwoZA==
X-Google-Smtp-Source: AGHT+IGGYWZVJVutLPUcZsKzmNNNwsS8cAKr1zEbWHridaDTcMmrlaBzgUZ1qtB0D7DpLUbr0cgyeg==
X-Received: by 2002:a05:620a:6d87:b0:77f:3f7d:b4a8 with SMTP id um7-20020a05620a6d8700b0077f3f7db4a8mr1182981qkn.79.1701981827192;
        Thu, 07 Dec 2023 12:43:47 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id qf4-20020a05620a660400b0077d66e5b2e6sm174067qkn.3.2023.12.07.12.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 12:43:46 -0800 (PST)
Date: Thu, 7 Dec 2023 15:43:46 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 14/24] pack-objects: keep track of `pack_start` for each
 reuse pack
Message-ID: <ZXIugoH4Py3Ie3WT@nand.local>
References: <cover.1701198172.git.me@ttaylorr.com>
 <6f4fba861b59f909148775ee64c3ba89afc872b5.1701198172.git.me@ttaylorr.com>
 <ZXHE9L7iqXQAit_1@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZXHE9L7iqXQAit_1@tanuki>

On Thu, Dec 07, 2023 at 02:13:24PM +0100, Patrick Steinhardt wrote:
> > In order to compute this value correctly, we need to know not only where
> > we are in the packfile we're assembling (with `hashfile_total(f)`) but
> > also the position of the first byte of the packfile that we are
> > currently reusing.
> >
> > Together, these two allow us to compute the reused chunk's offset
> > difference relative to the start of the reused pack, as desired.
>
> Hm. I'm not quite sure I fully understand the motivation here. Is this
> something that was broken all along? Why does it become a problem now?
> Sorry if I'm missing the obvious here.

No worries, I should have explained this better. Indeed we do have to
worry about patching deltas today when reusing objects from a pack. But
we have to extend the implementation in order to perform reuse over
multiple packs when any of them (excluding the first, which would work
with the existing logic) have delta/base pairs on either side of a gap.

I'll try to make it a little clearer, thanks for pointing that out.

> > @@ -1126,10 +1129,12 @@ static void write_reused_pack(struct packed_git *reuse_packfile,
> >  {
> >  	size_t i = 0;
> >  	uint32_t offset;
> > +	off_t pack_start = hashfile_total(f) - sizeof(struct pack_header);
>
> Given that this patch in its current state doesn't seem to do anything
> yet, am I right in assuming that `hashfile_total(f) - sizeof(struct
> pack_header)` is always expected to be zero for now?

Yep, that's right.

Thanks,
Taylor
