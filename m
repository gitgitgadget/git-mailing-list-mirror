Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FCB158DDF
	for <git@vger.kernel.org>; Mon,  6 May 2024 19:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715023395; cv=none; b=SBIlsyYAHpHpK6rngDNbzWJjTOv5tpcYufJUgnNggP7bL1fA+4/9hNYWU3zz1DmX5owssT+xbO7KchZ57KyAFM7sDHyH2KEAiPiByCJ+COFTHI/V4BaD4fBEF2OVQdXIxuEJh6MW0kEMJB7gwYzsACRSOt3f9lSaTJ3bkxPTtiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715023395; c=relaxed/simple;
	bh=2cRvjsceVJwpzriV9eIlyj+zDvBbjkQZobjkxT3iZR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTf/NqNI4er5vtfH9MXWoI+iiaFAb8EWwyq0nbWw8oH0YWCtCXgm2evQ4NZVJkie/hRB2ohi2aWB73zCsxRVMSoE42bXe1B/fW89z2uhO/1M5d2obBPqEkn4/+dHDXsw4tbwiAQhUiITX0ENsWidihdZAzEh24boh9PPRK3/fBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIRPxcPs; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIRPxcPs"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6f08df79b9bso144461a34.3
        for <git@vger.kernel.org>; Mon, 06 May 2024 12:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715023393; x=1715628193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dsqwZtHiVDwlyx03NRcn4XQiXLqZJ+IrygwX4Y3JcFY=;
        b=eIRPxcPsR9RxzprCATQOG+rLN/1eGkzRCuoW+WGlfYCEHUvO6FsWOIxiq4FXjyNLHI
         yJopXJtC2bo6gfR8z3YvJTmXrO7jB2QUNPlqWw2rsmHigttMMBDPwHv/M4lM2R+6yPlm
         EgFPrzoBERwIxws+bdGquG71RRZJ778TmpWa0Ps5/er6AtUfss1p/4umglDZnw/VIHW+
         7TpvXBRoi8zHS0MS2FE5Xvc3FBuuIj/8nxr0HeoRS2XyS4ZIuUiTXurXO/KQpa81WuTJ
         dQT0hDf8BbAo60IVeyAjaOjjikLO+7HlIQRgdKt70wv98i9gDT00sYycioie4oksJMyk
         OIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715023393; x=1715628193;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dsqwZtHiVDwlyx03NRcn4XQiXLqZJ+IrygwX4Y3JcFY=;
        b=SXoKiRlJMg6svAOxuEDf+ugODifDOeaWJQTYRgkTAuTpQY2CFLcImhAK0TfARX9Ewy
         Z0iFevhdvjG8+871C1Ojz4MZvL/d4JyqmipLEMFKvJfcuJjf0NiLu+2eXbI6AWRiWtvl
         ZTca9bVpsAbZCYiYB4ZBQt+DqxJj4N52Y6iAWgxGMUAiy+fI4wyx5SFV4yOKyQd5u3N8
         MPzLTfz/sMbgmC78slP55JdHkOeXh7X+4XmCSXsp3hixhB+PMh5qbFDmMRetlEfstfa+
         ml28CRECntGJ83jQDuYL8h7awbI9UP8vx10ghHn37wH/rDc5SIcYLfnc+IDx85VfKVNa
         R77g==
X-Forwarded-Encrypted: i=1; AJvYcCW2/YP7tSe65/8CJaR/0S2EGNEktL1OwgYkQZg8tT3L4Qjk18qDHvzKY2rRjK845kw2eKRfUnqc0cwZlMbd5RLYzKfs
X-Gm-Message-State: AOJu0YwJ4GcPqp1Mch4BeOyym4rERe6BDxccuLOA6/87IZ7uSDVhEXqT
	XGVvSu4wYHTJhMRXGepCzHeCnZBfYF9wl0OQ+HP48SHRF0XY/BXo
X-Google-Smtp-Source: AGHT+IHEUIoymp6s5HxcMR9Wccy1U7TKo8e3YaPugspzntwE8TU3WJ8g7aqj7Qch/mp6BVyBNXjQXw==
X-Received: by 2002:a9d:7548:0:b0:6ef:9b63:7c04 with SMTP id b8-20020a9d7548000000b006ef9b637c04mr12140504otl.33.1715023392651;
        Mon, 06 May 2024 12:23:12 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id o10-20020a0568300aca00b006ee4db9f637sm891232otu.52.2024.05.06.12.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 12:23:12 -0700 (PDT)
Date: Mon, 6 May 2024 14:21:52 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH v3 5/5] gitlab-ci: add whitespace error check
Message-ID: <xjp247ji6zjyacniodws6jbdms7tr7726h6spsn7jvx3axqd4a@k6xhzf4v5akc>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, 
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20240502193840.105355-1-jltobler@gmail.com>
 <20240503172110.181326-1-jltobler@gmail.com>
 <20240503172110.181326-6-jltobler@gmail.com>
 <Zjh-3dCL2-MnV-PE@tanuki>
 <xmqqle4mzwp8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqle4mzwp8.fsf@gitster.g>

On 24/05/06 10:17AM, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> +check-whitespace:
> >> +  image: ubuntu:latest
> >> +  before_script:
> >> +    - ./ci/install-dependencies.sh
> >
> > Do we actually need to install dependencies? I imagine all that's needed
> > would be Git.
> >
> > Other than this question the patch series looks good to me, thanks!
> 
> I am a bit puzzled.  Is the proposal to check our sources with a
> pre-built Git (which by definition would be a bit older than what is
> being tested)?

The GitLab `check-whitespace` CI job only needs Git to run and uses
`ci/install-dependencies.sh` to download a pre-built Git package via
`apt-get` since `ubuntu:latest` is the container image used. The 
`ci/install-dependencies.sh` script also fetches a bunch of other 
dependencies which are not needed. 

I think Patrick is proposing, to further simplify, we avoid using
`ci/install-dependencies.sh` and only fetch Git. Patrick please correct
me if I misunderstand :)

-Justin
