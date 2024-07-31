Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9F15A10B
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 15:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722440444; cv=none; b=qUvLQgEzn9zRrnlCKMQHJScJjmrIp3QaO/O6t0ycuHh9WV7FMyA39mtAclKNOkX3n8LGBij7JbeoU17JA6HsCJCqQyJf5EocAK696IiuVmxp+FEDXhEk0RYYMMZYQpLsgHuSXgHqRypyd7M6Kq8HMpJWCddI+VG/vQ97mRHvJUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722440444; c=relaxed/simple;
	bh=BIUalIsMRnmNb0XSBqi3nlammQyoMzI4l1D7qNmj2SA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvwgOP8xV64DBjcryUUN19QiA6mqTed6ixbS3cXuSQWX67thtJhJO9OchTbuTf8YLClqZWPu8XBplLEJ8Q+POHiis6opVRYPvDv8uUhY/pSLcst0GZWJ7IvGZ9E8hY7pq3YnWdfrwbztHPoTVphbtf9/QuXdeSFPXurjSXJD6KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ejHJj8C6; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ejHJj8C6"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a1d81dc0beso381477485a.2
        for <git@vger.kernel.org>; Wed, 31 Jul 2024 08:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722440441; x=1723045241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BIUalIsMRnmNb0XSBqi3nlammQyoMzI4l1D7qNmj2SA=;
        b=ejHJj8C6P5QqeETomfPce90rtwELg1GgVDDWhc1ZQLo67NWr8LTpqEL8V5UK2Kza6E
         HL2H6jYodiJU9KUJYWR5QwTWZ7A5kqVdqyCbPirbMgeTuPPVrGEpE47rQVTXcMdYGYo3
         1PCtWOIgz90o3gFQZ2CkV1NDUZritUOANXqDxuvA3ljTzfyoHsYvlAqSQ+OMs/Lqo7Tn
         BdTlfUD8G35SZAWXNmPPCjVFrdvbdxDXES1tQLJep2O6Haj15MzU22S+MuUiW1CsPr49
         dtyRd212/P9ll+YB2HmEyq7vi/9TSK6aDWbs+sy9Wf7l3xT5Q9trOsHsJSzg83aquM7Y
         EGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722440441; x=1723045241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIUalIsMRnmNb0XSBqi3nlammQyoMzI4l1D7qNmj2SA=;
        b=flAZknZctDGOhUfNupwMRV8AQ12EQbPw8uV5RqOFozY4xEe1o0avAQdviqx1sw1cS4
         3q91QcM/vgSEp0rV1q3X6KYeXXmvICAuygOcgH+/SkjULCuiTfwqBdY4mozByDMA6+D+
         EnGymhyslIySIsZsvTYb1EbN0evS3Sa0NztdEBCbkD93zEoksLa/FpMUpmQdEx3lbomo
         CdTeHClhOM4rQpspBG+qa890xK5MSPT4R6PkwOMKSsEl7JnlYa3SwLcTxu2dFq67NAxt
         skg/rHFs51Eu5CSMkpSbZyu7RSMooWIkdWCtGYm9LTOK4elQHDZlK4dkvAHFErkEMvMq
         OTAQ==
X-Gm-Message-State: AOJu0YwHmAgcx+S8oFHaGcdtB+K38sPo/GlzKriP89Vz7frEnXla0+Yb
	OBNVs7f8y70qp3UGthGtVeDJi+uaYXXYg0D2r6LbC9oFQCWauGfYorzx4Q5GdzE=
X-Google-Smtp-Source: AGHT+IFFFXPuIiTNWMO6LWzKCX7gXSl4Zx8rpJyg1r70aUPVrMfmMAZ9HLbNz1iQY1DID80x23iOOw==
X-Received: by 2002:a05:620a:2447:b0:79f:17da:6444 with SMTP id af79cd13be357-7a1e52c734fmr2001447085a.47.1722440441478;
        Wed, 31 Jul 2024 08:40:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d73955ccsm758850385a.11.2024.07.31.08.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 08:40:40 -0700 (PDT)
Date: Wed, 31 Jul 2024 11:40:35 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	John Cai <johncai86@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/4] Add 'promisor-remote' capability to protocol v2
Message-ID: <Zqpa8/aLpgtzoBH2@nand.local>
References: <20240731134014.2299361-1-christian.couder@gmail.com>
 <20240731134014.2299361-4-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240731134014.2299361-4-christian.couder@gmail.com>

On Wed, Jul 31, 2024 at 03:40:13PM +0200, Christian Couder wrote:
> By default, or if "promisor.advertise" is set to 'false', a server S will
> advertise only the "promisor-remote" capability without passing any
> argument through this capability. This means that S supports the new
> capability but doesn't wish any client C to directly access any promisor
> remote X S might use.

Even if the server supports this new capability, is there a reason to
advertise it to the client if the server knows ahead of time that it has
no promisor remotes to advertise?

I am not sure what action the client would take if it knows the server
supports this capability, but does not actually have any promisor
remotes to advertise. I would suggest that setting promisor.advertise to
false indeed prevents advertising it as a capability in the first place.

Selfishly, it prevents some issues that I have when rolling out new Git
versions within GitHub's infrastructure, since our push proxy layer
picks a single replica to replay the capabilities from, but obviously
replays the client's response to all replicas. So if only some replicas
understand the new 'promisor-remote' capability, we can run into issues.

I'm not sure if the client even bothers to send back promisor-remote if
the server did not send any such remotes to begin with, but between that
and what I wrote in the second paragraph here, I don't see a reason to
advertise the capability when promisor.advertise is false.

Thanks,
Taylor
