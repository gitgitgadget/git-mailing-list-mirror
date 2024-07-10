Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97D2848E
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 12:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720614594; cv=none; b=fqF5bemLCLV9nQ7N+8FRwSb4R92Y6ySr/THXDtqr1PF6R0TovOhCxJ5BV0seC//sCofFa+ENXeUqzVjtVQ0KaO4FsvNRBrOwnnibjY9PeUeNdd57liF/lF5tVMZlt9mckGKd6z2xtF0oeVhwbRtdQkNBHzgRPDBo35Olethe3wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720614594; c=relaxed/simple;
	bh=zeV890UBUH6Vj8mQlFqqL0513SSn0Khkht2L+/+xHE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/Ai/rlebx9LjBFvoWy0LD7hD3i3J2tQtN1kT3W+92u2bkeMZCRGX07ITk8/EL6wmiWB3D0Tqbn8mczvL6z2n9uS2w3A8A+hAZJBa44ChVmQOIImZeVTEQfs5F79vK35XX5vF8XpYHPKu7UnJiyLohEcmLs28WCjjT6wMninIds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjPGoL11; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjPGoL11"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70b0e7f6f8bso4511649b3a.3
        for <git@vger.kernel.org>; Wed, 10 Jul 2024 05:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720614592; x=1721219392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yxaf8XSLtaGlxMOW2aalQh+I0vLNInCkrZD8ekL7YNA=;
        b=FjPGoL11xbPOBXen13untbgNyiKyCXkJB22cMDgIEhZzRNO+523k/L5ray258yYLb5
         RwOrG3GaOna4z2R2/7ik2FJ/NA/NtAeI5+r9W5tYBfMFdWmXoFSrGyApExEBjGGuasJQ
         tPu02XyXxxy9lzjzGtwswTFRZ5lJDYIK6ZGfgWF/Hb2z0JL9KUo8nKYXHXJlH957172r
         0L64xcOVAOYM+d/jN/QtxQ6IDe2Po4Yu0Qe7D1/vQzkAyqntOelYVRpj/FTP+SKFqaDt
         edUO4Lvo7qECGJ4Vg1Ffn3bfrX1QboE3Acp4fUIPJUP2YjOtYuX64CEeIrxWsCmwTioj
         BimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720614592; x=1721219392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yxaf8XSLtaGlxMOW2aalQh+I0vLNInCkrZD8ekL7YNA=;
        b=sdaCPAo6uBeI7BEcihJkkV6ZTxo+SJtxtgNT5FMROnw+F6GUoeV1vxUdKQLmOgDv9F
         r0e1ZGa/8STrXWARL6aj6B2Scjq4eT2gaZNnIYFYf1mZlowGJW6nUG1kj1goL9fCRvA4
         VGJD4KpnWwNmsRy2T3Lin0EdH6EpDa8V4dNCRUWej31308JmftP4Ef14DKkb6Uu6lGvu
         O1qFMHE52/48l4p4FLt2lUklDiXmbP5FiI0S0g3DwHzIXHzWd+67LdbulTwBF3KPszYE
         P5ctrfxekFjfaRovDaaYQDYxyctXh5Lw83HECbovqn8+lKMqP1VTeFJWgdcbq7smDDC9
         FeNg==
X-Gm-Message-State: AOJu0YxZbGL3RKSV9/slByyVV8SExI+aDKEyn8p2bcbp6CkcyqT2B9xk
	+HPOGGUGQVUxomoz1JRsXVYItL1Ysqv4SOOXauKEDTEqhngvZHMmqJc/Dw==
X-Google-Smtp-Source: AGHT+IGgXGr7749pLCMlBGwh3R1tkeDblyY2vnezTGOnb5yJ/MZMVdAJ17YRqBfunNAMEKP9Euhivg==
X-Received: by 2002:a05:6a20:1594:b0:1c0:e1bf:4c23 with SMTP id adf61e73a8af0-1c29820ca53mr5666039637.20.1720614591880;
        Wed, 10 Jul 2024 05:29:51 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ac80d6sm32608685ad.234.2024.07.10.05.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 05:29:51 -0700 (PDT)
Date: Wed, 10 Jul 2024 20:29:52 +0800
From: shejialuo <shejialuo@gmail.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC][PATCH v9 4/9] refs: set up ref consistency check
 infrastructure
Message-ID: <Zo5-wOYnVMcOPQc6@ArchLinux>
References: <Zo0sQCBqyxX8dJ-f@ArchLinux>
 <Zo0umVPABD1wkxQG@ArchLinux>
 <b7apetyejg5ycvvqkc5motpx45mbval5sixvlgwfrh4q5lzc5d@b32kkwo4qeer>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7apetyejg5ycvvqkc5motpx45mbval5sixvlgwfrh4q5lzc5d@b32kkwo4qeer>

On Tue, Jul 09, 2024 at 05:11:36PM -0500, Justin Tobler wrote:
> On 24/07/09 08:35PM, shejialuo wrote:
> > The interfaces defined in the `ref_storage_be` are carefully structured
> > in semantic. It's organized as the five parts:
> > 
> > 1. The name and the initialization interfaces.
> > 2. The ref transaction interfaces.
> > 3. The ref internal interfaces (pack, rename and copy).
> > 4. The ref filesystem interfaces.
> > 5. The reflog related interfaces.
> > 
> > To keep consistent with the git-fsck(1), add a new interface named
> > "fsck_refs_fn" to the end of "ref_storage_be". This semantic cannot be
> > grouped into any above five categories. Explicitly add blank line to
> > make it different from others.
> 
> In this patch we are not only adding the `fsck` infrastructure to
> `ref_storage_be`, but also wiring what are essentially no-op functions 
> to the various implementations. It might be good to mention this in the
> commit message so it is better understood that future patches will 
> actually provide proper function implementations.
> 

Yes, I agree. I will improve this in the next version.

> -Justin
