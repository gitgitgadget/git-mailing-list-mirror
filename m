Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF3B1DC720
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 19:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725392915; cv=none; b=c4R5/Te23kENiPjHABqX41XT2GzznHSt8pJhYzQKNEWLqO2c2GX0xPpr5KbFjlMUD/lYLltxMzCirXcoyDxcD+T5nLqgfrgXA5zk965IMVVA4UqBypAtgXwEfYxTZRRJNDOmRUXj3ksQbSDdkJFfPTtuLZdYRDpCMr2clN1nKMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725392915; c=relaxed/simple;
	bh=sToCivZjJ4ZL37hpHvjd/Ryvva3RgBWYZ4z26Wi/plA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbdxvpJHDNMZt4qbyyqUhRrA0xp4wAv2s+lVmpAC7IOTJkiNoNWzPkRdRJbuHrt2OvfhDjePc2aSJMmWshZvBULa/wjT6/yvUIvWKRMAb2DEDonzeci5L0HL1a+h5m+UUvLYi08fNyv+xURauOmakdCvOH/glbDJccpfQLee4Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=f67hILZT; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="f67hILZT"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-690aabe2600so47225177b3.0
        for <git@vger.kernel.org>; Tue, 03 Sep 2024 12:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1725392913; x=1725997713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q4s+RFTJgkv6cPHSwBd+9Ql/HwBq3q9TzZAlAeVC2kg=;
        b=f67hILZThzpvqljJw4ym9H0jHnoU3INzfD9/xjNPkapal4mFHT3NHIVJE1Ijk5jWF5
         UG43SzhobOyvCKFqNM+IBXMdVLNI/uDIjnkCzwgCPwiQAuNK7BRdxXHxeP82RWjXtc3w
         hd0ctpIK4PqOEMJ+CuL9vo7kTFw6qzm6ACSr8zUCrY5zZ3VTsoaCezPEm6ROxZ/jfbiF
         7wAvOFXAefrDkShDRZL/WPiP/Wnk8mINBBRAgOt/oek7fHFIoi/YroIbyt53w5OtaWgM
         G7m5Gqfm8x5GcV3D9hRFllOVU7GdVhlu0sgw33HdS7n7fRyH3RuYuuFB6fZpk6bZ26dR
         j2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725392913; x=1725997713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4s+RFTJgkv6cPHSwBd+9Ql/HwBq3q9TzZAlAeVC2kg=;
        b=kRSfgjdlJoV9zxiEi0H3DD+DD6Hm0NwHOkCsPynmDFHi+oCk7XuHfdjl4pWLaO48IC
         ZoLeKzjlDZjwj4PToB6YEUJxp30Imw8XA6LlcZKMTMb0WkyW9fXEKlhgMhNTMAKnpaTO
         wJJQrASP1EjM8w9qJlvy9r2f8tJpIIV/QPI7zO+jAYQ+hWRIilI6r3VKX/ivsHBztize
         6aOZccHF7rWthGQ393S7yhhB5fkur2nJwyJTv9cBkTlMzqsRNtgNpO0tM6tmvqmbufcZ
         Xal6EMGMOsvyz2qZcSJmYs2cVFD64JETN4HrEFvShfnq+irVCH4EGEehZMknjn7S6tpt
         jzYw==
X-Gm-Message-State: AOJu0Yx27rqpfLCaahdTKuaoU0CmX5PPWEWFm4xQBv7piImDCF2J+BDr
	DnK6ywwmEj9gxQ/RGdlpD+wmSeOxqOM04u4+XEQeF099nm6d/KlmFRDurKqY/iOlUrtenP9togO
	esIc=
X-Google-Smtp-Source: AGHT+IFdkdL34iFhWsZCBDpj+4hwsvZQsOMx9Oa7YywplPH2Nq6oGFv9TaegYoN/a9+VR1kySVW17w==
X-Received: by 2002:a05:690c:110:b0:62c:c684:b1e1 with SMTP id 00721157ae682-6d410cb3880mr156642987b3.29.1725392913040;
        Tue, 03 Sep 2024 12:48:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d564f3b989sm13567267b3.84.2024.09.03.12.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 12:48:32 -0700 (PDT)
Date: Tue, 3 Sep 2024 15:48:31 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/4] hash.h: support choosing a separate SHA-1 for
 non-cryptographic uses
Message-ID: <ZtdoD/slbc+u7Aql@nand.local>
References: <cover.1725206584.git.me@ttaylorr.com>
 <xmqq8qwaoh73.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8qwaoh73.fsf@gitster.g>

On Sun, Sep 01, 2024 at 08:41:36PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > After some profiling, I noticed that we spend a significant amount of
> > time in hashwrite(), which is not all that surprising. But much of that
> > time is wasted in GitHub's infrastructure, since we are using the same
> > collision-detecting SHA-1 implementation to produce a trailing checksum
> > for the pack which does not need to be cryptographically secure.
>
> Cute.
>
> I wish we can upgrade the file formats so that a writer can choose
> the hash algorithm independently from whatever the payload uses.
> Most of our use of the tail sum are for files that are consumed
> locally in the same repository so nobody shouldn't need to know that
> you are using xxHash for the tail sum instead.

Yeah. I would actually like to get here in the long-term, but of course
that change is much larger than this one (the protocol would have to be
adjusted to learn a new "tailsum" capability for callers to negotiate
which checksumming hash function they want to use, etc.).

> Except that the story is not so simple for packfiles, which is named
> after the file's tail sum, so you cannot use a hash algorithm of
> your choice independently without affecting other folks.  All other
> csum-file protected file types are lot smaller than the pack files
> to matter, sadly.

Right.

Thanks,
Taylor
