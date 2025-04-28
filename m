Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620E91C1F0D
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745836229; cv=none; b=fcsq/E/VTD9p+oDl3j1czE4kkErxysrqKfFY3pTHoL9ANEg2eL4E78dsDOH7Cl+fblTnWv0M5F6Qp+kMTLbaYGmT5LXrLc6aj0/uLhWxdR/hdc99jH1uvYlUuvlnXyxitEros7QPK4xN0cnHnjvLRRORf6OyP5Lc9F2GIdu9BUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745836229; c=relaxed/simple;
	bh=YY440FcVSE4uiML9+ny+puHy8WM1A+2v/jAbJILxi0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Df3yBNzAOX5e/pCED+RFoAAoDCpt1WPyauMAhUTOzcgGKpcWQxjpy0I7l9ndd3xUpTxcx7re1f9jJwJ+WFLfEJP/HjN0S2B/SDgceut0ZA5AvozIQA5OUSzOYemiEZE77CW432H+xxWPjmiSowzcu8tBQ9RrtG22SPtNLOapK/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTdy12vy; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTdy12vy"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-73bb647eb23so3745279b3a.0
        for <git@vger.kernel.org>; Mon, 28 Apr 2025 03:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745836227; x=1746441027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=knMPKhSsHn3odw43oGxFm8xEhmu/20IDcGioMOCgAhE=;
        b=jTdy12vydXibqtV1CDoiKJJLxwLMWUnNQNw3K5dysQBbAwzM4zFojGMuRujq+q39SG
         P8soan5KjygMqRPFyF7Z2OQhx+rasQvCaoMAI7zu6rtXOeGXqkI103zraRym8H3IruRJ
         7KzJTGGCOw4zfYRK7atVoijQJtc1nUxTbnNzGZh7/QXAx8cIPYrhvAUbF5lS3YF9P+LE
         XuNWg2fMHGWtgh3jAztUuL4ickrQoYGMntL3hvjU7UMqQ7o+GSEi1xM4x5wUvqoc2Eva
         /XJ4i7vnS6y5u20IiJxPmYuhgcJuEiTL2Io2B8/02OhdCdgJcVMZsneWVMK59Wtg3zqX
         7vDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745836227; x=1746441027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knMPKhSsHn3odw43oGxFm8xEhmu/20IDcGioMOCgAhE=;
        b=YI3Xd9IK5h7mkeUEdjBzKVc6P/Fv7toTTTtVqa4+KR/ec2KNvHJQrXcUKEA1dqLSDG
         Pn51JGYPDAX/WcSimpLRrvBUMjdkOLd647PdIKwmOU1jzvRhevaO85ScBn7ANYrq2WGz
         mgclduBWa45RPvZD/gz/fqul4xR+I4kkgvibJtR0HY8iqKGXAnutD0n4I7VlhpmAi1p9
         eQk7Kb6fYsV69GgJBiFJFqnkFC4MuofHzb0W3L4bOnI+6Ypr+kaf3eeGMPFVdNJjoy7R
         QAJAwUaY7ix7dFmPITNKbeZMmsU8WRGyRvWERMiNsgLnWXSwA7F1vz5cA6Aslxyqjto+
         pqDg==
X-Forwarded-Encrypted: i=1; AJvYcCUOEUPUWRj1CqLvX9LFA3p/NQXdpDFLloRSByVU03VuR4u8zKpC6L9RhImma6t/+ELaAhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvHoOsbugTehYiquJB/bqziPMpgldsJ4vbyu24O4ISGCqrtyIP
	eLiQ68icnKarS7BkBptUsmZptYDvU6u8aGc/r3SWhu3gYFNQJGoz
X-Gm-Gg: ASbGnctI4fd2Ef6aVJXWAjQDwlqFxnzhvzyv/aH9l51MuvMBCTaiwkwKnk2N2r2Zai9
	k4B90cNYdaaalSYrrFS++llhyzOxaiYvPgcq36Gv9Gzjro4hI8Jv6luVk3Nzz45kob1bCeg29xZ
	1e8iIHGLNUgEPogu+VV0ArwJ2iZme0ZWTjkSCanCPGAPhWgbkhBarF1tuP4HW3WRPRKly+MlWsO
	jr+u8UjFXl7rntpzAprEbKz1YBmb744NW4r81w34B+GqiRAzUaZ5FCUShWDa/ZvMcCpetbg0CP/
	m3xkBZ+kKep2HA6kkbq6NGdP6meMcnRedGdO
X-Google-Smtp-Source: AGHT+IFsZ8nv6K0taxu+1sHb9CAR+1qmoU9BhSdARPwobMYfm2gbQEmjR/01B4u10WVj02lMDbw+Zg==
X-Received: by 2002:a05:6a20:9f9a:b0:1f5:6c7b:8920 with SMTP id adf61e73a8af0-2046a3eec69mr10645875637.9.1745836227553;
        Mon, 28 Apr 2025 03:30:27 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b1cf3921092sm1904261a12.25.2025.04.28.03.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 03:30:26 -0700 (PDT)
Date: Mon, 28 Apr 2025 18:30:41 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: repo.eclipse.org outage breaking all our linux CI jobs
Message-ID: <aA9Y0fp2crq_izqP@ArchLinux>
References: <xmqqfrhxtdg9.fsf@gitster.g>
 <aAui8hrhm1qAxGcU@ArchLinux>
 <xmqqikmsuv2e.fsf@gitster.g>
 <aAzp49aUREpSsCrZ@ArchLinux>
 <aA8k6XLM1Mt37Oq-@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aA8k6XLM1Mt37Oq-@pks.im>

On Mon, Apr 28, 2025 at 08:49:13AM +0200, Patrick Steinhardt wrote:
> On Sat, Apr 26, 2025 at 10:12:51PM +0800, shejialuo wrote:
> > On Fri, Apr 25, 2025 at 08:20:25AM -0700, Junio C Hamano wrote:
> > > shejialuo <shejialuo@gmail.com> writes:
> > > 
> > > > I want to know whether we should use the "cache" mechanism of CI for
> > > > these third-party softwares? I somehow feel strange that we would
> > > > download these softwares in every CI.
> > > 
> > > It also feels wasteful to me that the CI jobs need to do a full
> > > install-dependencies.sh over and over, instead of running it once
> > > (per platform type), dumping the state, and let all the other jobs
> > > on the same platform type to restart from that state ;-).
> > 
> > That's right. I'll investigate how to implement this.
> 
> It would be nice if we could adapt the Linux-based jobs to use
> pre-seeded Docker images. The idea would be that those images are only
> built once and then used by later steps of the pipeline. In theory, this
> could even be extended so that we only rebuild images as-needed when
> something changes so that the images are reused for multiple pipelines.
> 

I agree that it would be better if we provide pre-built container image.
But there is only one problem, which platform we should upload to? I
somehow know that github container registry is free for public
repository.

So, we may just push the image into github container registry. However,
I am not a member of the Git organization. So, I need a help from ones
who have the access.

> Another big benefit would be that this results in a fully-reproducible
> environment for developers that can in theory be uploaded to a container
> registry. So if you see that something fails only with a specific job
> image, you can now trivially fetch that image and try to reproduce the
> issue in the exact same image as CI used.
> 

That's right, we could easily set up the development environment to
replicate the problem without setting up the environment in our own
machine step by step.

> Patrick

Thanks,
Jialuo
