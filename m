Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41F017C7CA
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 15:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770350; cv=none; b=WOyfLTyztPKU616V9lZ3c+y8Bkl9zBIo95uChHSYzIWyJqyNDOv4BBQEeYikRl7XDhcsZthQinDW/H+VqFQkFj36iO9RlsKtr3FmofZ/nqNzAdsRSXARMH2enMZ5TIWBce7aYG8eNiqzy6ySfOcc8rKdvZYLWgu703T1Y9zWURk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770350; c=relaxed/simple;
	bh=sJLbqoqa2lza+CrZWKhKqXlneKNQj1aln6Yjs0L13uM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZauAF/qhjkrtGa8v0pIrQkEuV0wFce9q/eTwwmRfkcK1CyRHSaR+dtUaFHU53M+YAJ6/fhFU7bQnlLNXmLjTaNUuGHhHKyDcZWiNg8niZHcaQZvz3YPpFmywC/PcS/Zfo7fKGbTDYkwJBoGvMa1tQRnNn8lAUIJaVzchNPsqko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRm1yUkx; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRm1yUkx"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-21f2cfd821eso3560165ad.3
        for <git@vger.kernel.org>; Wed, 05 Feb 2025 07:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738770348; x=1739375148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/ruw86WEQvbJgMoEL3p3FZmwiXl8PAH3WWryolZSks=;
        b=LRm1yUkxcpg8rXPsnruvZHh7Mt7DlxyKQMNnmJ6jvKFGiSnX7SKxgxRMCbmHfFkqPL
         xsU5GBO/mb1DaX9nMSS4i81m7CdQtsjpXwSekiyP9D0hhLn5fm4DXtHf4if3VBuCjdhy
         NbXX/m36a0HgbhQ2IWDvb1varCdpLbaPVGR2V7TJia4OYTF1AIG0JzfjuJZc3ecDSoLB
         lRVdMmovkDxmk//PxZDoa6NbD1JW1UHj8wKEN1i/d4jVdf2m3JZD1Soy02b3mCDZODl0
         EdXACO79V00Gk0L2G4ZGGW32t4nw9icoGGVGeDCDhuG8jmUAtpJw6+KNpp0LBslqSQaD
         Ywaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738770348; x=1739375148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/ruw86WEQvbJgMoEL3p3FZmwiXl8PAH3WWryolZSks=;
        b=ZolCunTRvs5eEbc/HS/QshPwlC7OCoo0SoRxrki8GBixhuwg7+MsDKMpfSdhzmDQK5
         3sX2sux9G9kO82yKdk9Lq/XjYwz1/7D15/tJZMPRwPLki0nl+swnQfAWlTwTCQZoS/pC
         YK91acyZ502QDgXuH/fujqtuZ+3xKTzm2ALupBKMDoL1gwc4TeE3urGZMxTZdIg1zUAk
         sHfvpBl3Miqnp1oZplaEKoCJGAF+mQdLwGiftbszJiY2oI2uuswEvz++v8wdiqSvxZii
         C+lRoBWFK2py8+k/fffHLPLe26d0WQhya4NYAs6ydDXSFPUzrQx1oI4Khm8W0FQU+Hpc
         uOpQ==
X-Gm-Message-State: AOJu0Yx/F8T+KE++wJDOCK2wpKbzVDKohtlToRL1d5XjegKMLwkGPiqB
	jTJcui0w9RGAQb9cWLbQ3O419UlHD41IhXIZmbqiRXAjYM+rK8Zj
X-Gm-Gg: ASbGnctt38z8FcCD8CVc/oSVINcdE7aV76MsOiImPm9c9L1FAEf1vGcvcPSp69mFRXk
	ZaI2jXOJxQHCJQXw6JQ8ts1YyeQ2HtPV+U8aA0CNqdSoJTFlTs/rylZj6nKJR8Fmha5Kl3qXzt7
	+u50d4uRRNr2YJnUTS8fC4g7sjX/edPAaRJ95B+xpbEK3e3+OJt7sYwOXcm3bDP+0i6GcuFFUqz
	0MCrHFGyppbl8Pa5b9M7pfK9AmfVycHMTLahxI8cWVG1Lwk+mcrtkN4jKNsTw08Sr2y4mVQ2rOs
	gpj8yfMtQA8+NS1Xs0VZ9a8HHfhOEiRK0nh7apsR4hekzC91xcHxTtmTm3nSNZBQCDYCcDIjYp+
	IItppn2Q5bv3FCpT4yI52Z5+ZUuLbJbs=
X-Google-Smtp-Source: AGHT+IETd+HGZKQGs1+jkTveQH/zE8ykZO1H8sQkqCyA6Zv+CrJBA4YsNZT2pouDeoMGbt4a8ltgxA==
X-Received: by 2002:a05:6a00:4648:b0:725:db34:6a7d with SMTP id d2e1a72fcca58-7303521c76dmr4967191b3a.23.1738770347844;
        Wed, 05 Feb 2025 07:45:47 -0800 (PST)
Received: from Ubuntu-ROG-Strix-G512LV.. (ec2-18-162-44-43.ap-east-1.compute.amazonaws.com. [18.162.44.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe631c021sm12526091b3a.6.2025.02.05.07.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 07:45:47 -0800 (PST)
From: Zejun Zhao <jelly.zhao.42@gmail.com>
To: ps@pks.im
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	jelly.zhao.42@gmail.com,
	newren@gmail.com
Subject: Re: [GSOC][PATCH] apply: address -Wsign-comparison warnings
Date: Wed,  5 Feb 2025 15:42:32 +0000
Message-ID: <20250205154232.237380-1-jelly.zhao.42@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <Z6MXevArKhRLacAb@pks.im>
References: <Z6MXevArKhRLacAb@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for reviewing this patch.

On Wed, Feb 05, 2025 08:47:06 +0100, Patrick Steinhardt wrote:
> You should split up this patch into a series, as it is really hard to
> follow what's going on. There are a couple of things happening:
> 
>   - You change types in `struct apply_state`, which bubbles up.
> 
>   - You adapt `git_hdr_len()` to receive different inputs, which bubbles
>     up.
> 
>   - You perform small fixes in several places.
> 
> It might also be a good idea to split out the loop counters into a
> separate commit, as those are trivially correct.

Sure I'll come up with a v2 patch series, in which each kind of fixes 
will be put in a single commit and I'll state why I believe the type 
cast/change is safe for every single fix in the commit message.

> > @@ -1087,11 +1086,11 @@ static int gitdiff_index(struct gitdiff_data *state,
> >  	 * and optional space with octal mode.
> >  	 */
> >  	const char *ptr, *eol;
> > -	int len;
> > -	const unsigned hexsz = the_hash_algo->hexsz;
> > +	size_t len;
> > +	const size_t hexsz = the_hash_algo->hexsz;
> 
> The change to `hexsz` shouldn't be needed, even if it makes us match the
> type of `hexsz` as declared in `git_hash_algo`.

Yes it's not necessary here to change the type. And for the `hexsz` stuff,
on Wed, Feb 05 2025 04:58:57 -0800, Junio C Hamano wrote,
> I thought that I already saw this discussed in another thread.
> 
> The .hexsz of any hash algorithm would never be larger than what a
> platform natural "unsigned" integer type can hold, so using size_t
> for the member _is_ the wrong thing to do and the fix may be the
> other way around, no?

I found the discussion mentioned at [1]. It seems like the change here 
only makes things worse so I'll see if I'd leave it untouched or change 
the type of `.hexsz` member to `int` or something.

[1] https://lore.kernel.org/git/xmqqttaqw2eb.fsf@gitster.g/

> > @@ -2185,7 +2182,7 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
> >  			};
> >  			int i;
> 
> This may arguably be `size_t`, as well.

It's OK for me to use a `size_t` loop count everywhere but I tried to 
keep the changes in this patch minimal (forget about the `hexsz` thing).
I could apply this change if you insist.

> > @@ -2257,12 +2255,12 @@ static void show_stats(struct apply_state *state, struct patch *patch)
> >  	}
> >  
> >  	if (patch->is_binary) {
> > -		printf(" %-*s |  Bin\n", max, qname.buf);
> > +		printf(" %-*s |  Bin\n", (int) max, qname.buf);
> >  		strbuf_release(&qname);
> >  		return;
> >  	}
> >  
> > -	printf(" %-*s |", max, qname.buf);
> > +	printf(" %-*s |", (int) max, qname.buf);
> >  	strbuf_release(&qname);
> >  
> >  	/*
> 
> Do we _know_ that `max` fits into an `int`?

Yep we've set an upper bound for `max` before:
> /*
>  * "scale" the filename
>  */
> max = state->max_len;
> if (max > 50)
> 	      max = 50;
so it must fit into an `int`.
