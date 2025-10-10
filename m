Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643EF1A9FAE
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 22:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760136680; cv=none; b=NJUwVthpNVs2Oz/OAtJVL2NW3b0vG5VdniWfo8s/r68BOsK8XymsVQuuNz/V3pq+3D6dblhI+wg3AKtAABburt7/UCrkMLDZcneLz2uK1kS+VY1vVDMrBpoIeNmfvNgcxWXnNKHwi+QoFM8Mdu7BwId2x5qbN9AHEcSuTDzQl3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760136680; c=relaxed/simple;
	bh=7EkPce5M+SdaDKylCBmRx/KOZoo7L1tmOQQLECoJUR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPw27F1G49dyNn3iMAcDzbqHunQxPhUhfJWIlSyFekF3yQMugtb8HraLEimxfRotmzvm8IgdmMO8U98duVYItyaZyjR5NFZNQ1GHNsNwoQvl+SuKrxJ7kpk9AORu1u7qWFF0RuNANVNOXnlaVTh4T36fSYk99NfE9mQ2lbbnGBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=KUjmz5I6; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="KUjmz5I6"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6354af028c6so2684036d50.3
        for <git@vger.kernel.org>; Fri, 10 Oct 2025 15:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760136678; x=1760741478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pmtOV9njyzdEZ8x4mc+6pECRlvqvG4Yq2ALWx82aEnE=;
        b=KUjmz5I6jBlHMXixLQyrj7QR1z3PK5ZAfUYU4GRySFUROmX82ODDZec4R7Wv9TQCFd
         QBK4KLOW4U2ZAKEikl2mM46kPPmrb4qwoFmNWETr6YwAeEpITWjgnnZ9B+zeL+5ifsBN
         bPtI9PGfJLx/Fu9ps0t18h2qzdZujEoFvbSKHiTKcGHeedyp79S4n0LXUbxegHgHua+I
         rylIXs/w4g9pE35TUqHjvp2T7vwkastk4bJrv2sop247MUb4K+9D/6bYL9i0jBDO2+VG
         Qya0wF2wCYP56tTwFCXYKJVrmpzkIGIMuNWFow5rJ/sur6PdrjIUnvGguBWTyFmznGnN
         vK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760136678; x=1760741478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmtOV9njyzdEZ8x4mc+6pECRlvqvG4Yq2ALWx82aEnE=;
        b=NdS4Nizlw0DzSQv0K9YvV5fEJzk9UyP/2J8IFGppyYcpoLVtWHyOHC09RVgTOwPToZ
         aVwICHjtUinQJ+ZjTbA8d6ygeIKHbd0jF55CvSvSv9SjDZkm0ADy8RU3FOEmBkNnuzfB
         638DjGK8zYzvDR/xpV6FdLnhHUytachyTL6jyasUPza2C53e+06bn4n/WAHABKIDNh+k
         mj75BYflIb4AYwtcPTBpbbQth9+V+idz48HkIR0shAdKel57DtLSdr2vK0hUs8I1gKWw
         3XdtWADAWp0TafFeceEKaSaDgV1IyIZpa9LuhnrFC5RP68azKOxiOJYYAxefymJYUhrL
         yTdw==
X-Gm-Message-State: AOJu0Yy+56tMT1gUCr1vies/3aIVlifeZz/OAG7VRJGa2AWybyFV/MWL
	meEXkRMXqK42KXzaJ6G6/fQRVTObx3xsUJyFj0dFNNg6kbAgf9rKnxDVAU/lFJtuSnM=
X-Gm-Gg: ASbGnctA/kjDAOp9ZhV7kstNsVPteCOYqupqUkPuJGFVZ4UsylkaxWq9Z3BBBs5m/gp
	t2I6dRLP7lj3J3cHel4rB4c37pF337Y6BjlMU6sganE1Pcyp8YhfW/c6TrN9cZv2rj2rTHjLAqm
	uBrfUvxYOz9ctggzaR/KvpaFgsV2bN9ntO8ufCbKtQybp+kQifjoQAQG9SlrYavFXiLm0EbxUpP
	7/kWdHw3e5hTYNcx5AoRWWPaiz1hsG/8MfpykpDo553l6mIk0QGDTN99w3WJ1rBYVYlVGn8+sf3
	47m/rD2+gdslT+19msaC232x+oCaEGykT6LyRzCzOMv3Z+6leIHbrrIiQmDYGtFFTEGMO5o2Z+Y
	qLljbuMlEWqFvdRq1gaRZvwc3wXiDyjv/LoLh6ImXSyvyEUsJLcG3cftIHQXgdmoKK4T9IRQ83U
	KhNY/9yS6bc0Xi1QWxGmnUg7cjmLBRmoQjuANQ1bY9H7OS
X-Google-Smtp-Source: AGHT+IEjGawkad9ppkuIylPiEldpZ6DkPg2k3z+kGJvvTrLIok/VG6PwYruodxI3ybgi1k5RqQzN2A==
X-Received: by 2002:a53:cb48:0:b0:629:acb6:d8a with SMTP id 956f58d0204a3-63ccb8e1528mr9704118d50.26.1760136678094;
        Fri, 10 Oct 2025 15:51:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-63cf31a6109sm426872d50.9.2025.10.10.15.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 15:51:17 -0700 (PDT)
Date: Fri, 10 Oct 2025 18:51:16 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 09/49] builtin/repack.c: avoid "the_hash_algo" in
 `finish_pack_objects_cmd()`
Message-ID: <aOmN5Hj1xT4Qc6Ed@nand.local>
References: <cover.1759097191.git.me@ttaylorr.com>
 <f16dfbf0c7fdb2ff9bbfa8f3cdbc849916a722bd.1759097191.git.me@ttaylorr.com>
 <20251010053115.GC1965904@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251010053115.GC1965904@coredump.intra.peff.net>

On Fri, Oct 10, 2025 at 01:31:15AM -0400, Jeff King wrote:
> On Sun, Sep 28, 2025 at 06:07:45PM -0400, Taylor Blau wrote:
>
> > @@ -1150,7 +1151,8 @@ static int write_filtered_pack(const struct pack_objects_args *args,
> >  		fprintf(in, "%s%s.pack\n", caret, item->string);
> >  	fclose(in);
> >
> > -	return finish_pack_objects_cmd(&cmd, names, local);
> > +	return finish_pack_objects_cmd(existing->repo->hash_algo, &cmd, names,
> > +				       local);
> >  }
>
> OK, my last musing on which types to pass around, I promise. ;) This is
> a great counter-example to my initial comment on patch 2: if we had put
> an object_source into the "existing" struct back then, we wouldn't be
> able to pull the hash_algo out now.
>
> (Well, sort of; object_database does have a pointer back to its
> containing repo, which itself feels kind of weird. I'd just as soon not
> rely on that, here, though).

Yeah, that feels like a tinier example of what we're talking about here,
just within the object_database struct itself ;-). I agree that it does
not make sense to rely on that, since I think the existence of that
pointer is equally something that we could consider changing.

> > -static int finish_pack_objects_cmd(struct child_process *cmd,
> > +static int finish_pack_objects_cmd(const struct git_hash_algo *algop,
> > +				   struct child_process *cmd,
>
> I am mildly surprised at some of these spots that _only_ need a
> hash_algo and nothing else, but the proof of the pudding is in the
> compiling. As they say. Well, as I say.

I would like that on a t-shirt, please.

Thanks,
Taylor
