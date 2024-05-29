Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69BD169ADC
	for <git@vger.kernel.org>; Wed, 29 May 2024 22:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717022459; cv=none; b=X7YPJbQmVP5ziXeBv+avZEGYL3GeymbYNnoXD0p4c2CdZoExwoCUwuEPR/LFL4mv5XUGf35INtZmfdKeLbQWcJLUlqy3soxvaRiuP3T5y16XC/o38eJXW18DSnFkZy/nowO24RNWRPhlCc+8GFKxO+OkNWO2vptSCQWnCEQxVPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717022459; c=relaxed/simple;
	bh=lxWiQ9XXUJP4TgN6hy9r9CXKCasabvkP7yKaCjr2EvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWP/ReTH307d6VjTVzrgHDqQB8ZIj9cub23gDPZY1xNP7JBV9k+j4wCOXPe3ln7imSQ4G4KWX8D3R7rmqRKwQNawQ1mqAp1YIIPVeb7hEWd5GWAPt4J/7bVno6DYBl6q3reGpSaqIqRt22lSDDgM+5ZlsqK/9sRaezvC6x/gPuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=MkJPCzmW; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="MkJPCzmW"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-794ab0ae817so21417485a.2
        for <git@vger.kernel.org>; Wed, 29 May 2024 15:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717022456; x=1717627256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LkPMKt//487Zl6nESXqcMKjJyfJt+E+jon9Gjugb6dU=;
        b=MkJPCzmWm2fUxoveoz5qrrBZoPP7yCxzG3ZMXbeOixY8vAivhm6+LvJZuI+cNMjCZh
         pCiju7/Pwf0AiacEQbe53KcHZqg1etJw4tCrPw7oJpPGlU3kUu2acjjmb/xuqP9HklCW
         XDE7HA3/lKY9KzKP/3RR3SUJZg1qkKcChIZm6+AKAP6If25S2FAgCpw7fZkcCRmxQH05
         NLv/c6tDRxzptozCj5xxodFk2ZIHP5cFLeEs8B3DinoQIlPGtFKbVOkMMp7drbbCanfI
         w9KqqaRwtuusPSOBH3IjGM/A61jvrImiV7as7qN6cCJqrhP0fOSDzZrFzXOhN7qJ5XDk
         mYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717022456; x=1717627256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LkPMKt//487Zl6nESXqcMKjJyfJt+E+jon9Gjugb6dU=;
        b=tyIXzxBg5k447IROY3FXgAKhbDJaW618NU2CFoKPEePEyN3VIShXV20qpre1EmsjZ6
         RZZXWgQsdluu6197wF2OAbiei74P1sNPGRW9C4L2qi2baKEIm6adejKAdzponHipr2kD
         f2Akrw6Z5xf6T6eZO36dl8zlfRC7TJ4wOwg/Q+FnCa7Rq5Q/mxJyZ/YGf9Jgh8FgnV5t
         OFURMpkqpm3otXhb2XkPWqm7RdZ5xmUkKKoV3kp9fC+uYGt12tN0UtXo8HXbY9YrhKbB
         J1NWG6bZYmOBy8BLb/PVsdbPrNunL6aJbhzrpFH5Zy/79SjWNGPwePXfzhTMfvaSPEfV
         OO/w==
X-Gm-Message-State: AOJu0YzAhvvH1jUkDaFZAj0eIbeIsPjRGAYY1QiVooIg8QAqxFsBBpP6
	55Die13SQyJZM91HL1jbT5Bl79T23D6rOBX4zLWTliGeoQZvW0WFoP0jGOSAYMptNc0q9HmFMMN
	IBcs=
X-Google-Smtp-Source: AGHT+IHnf5m+VSZWyXrXuW0VZ5FF3MD0Dof9n05KAlFA480zbQMEe9vbda1SS8SmbZUpJKGLv4PXww==
X-Received: by 2002:a05:620a:4c5:b0:790:b658:b924 with SMTP id af79cd13be357-794e9e1eb1dmr58588985a.51.1717022456587;
        Wed, 29 May 2024 15:40:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abd368cesm509255885a.119.2024.05.29.15.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 15:40:56 -0700 (PDT)
Date: Wed, 29 May 2024 18:40:55 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/8] midx-write.c: extract `should_include_pack()`
Message-ID: <Zleu90gpuXt/qipa@nand.local>
References: <cover.1716482279.git.me@ttaylorr.com>
 <3908546ea85eb36a27ce6bd681a3c2152ff005f5.1716482279.git.me@ttaylorr.com>
 <ZlbduH9UZZIm8pNh@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZlbduH9UZZIm8pNh@tanuki>

On Wed, May 29, 2024 at 09:48:08AM +0200, Patrick Steinhardt wrote:
> On Thu, May 23, 2024 at 12:38:13PM -0400, Taylor Blau wrote:
> > The add_pack_to_midx() callback used via for_each_file_in_pack_dir() is
> > used to add packs with .idx files to the MIDX being written.
> >
> > Within this function, we have a pair of checks that discards packs
> > which:
> >
> >   - appear in an existing MIDX, if we successfully read an existing MIDX
> >     from disk
> >
> >   - or, appear in the "to_include" list, if invoking the MIDX write
> >     machinery with the `--stdin-packs` command-line argument.
> >
> > In a future commit will want to call a slight variant of these checks
>
> Either s/In a/A/ or s/commit/&, we/.

Thanks for your careful review, it is much appreciated! I meant to write
the first one, and will correct it in the subsequent round :-).

Thanks,
Taylor
