Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32CE189F54
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 12:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720613624; cv=none; b=GjhJgeXO807jZEV4jjQEKhA7CREgGFOiLn1aEIj1qaaMYxIPaSQVtzDOktgBphHDhVneg+KFiDKh8ALhA/1T+NN/zVIvb6Asv8tGfnZm+XoQ5fB7cVPLCEpH4SelD6JoXY2EsSDMYmGtlHxvqxcqB0Ovljq6id57k4MEHxCuulU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720613624; c=relaxed/simple;
	bh=kPB8xOw61VsagmK/RVlor+aluRGohzz5zXJYuziNIT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbAz1wrAyyaflrEZ57qZsSJMgRZBf33CBYvhDPoI3cFhrhKe5E0aN9Q2oSoHtYYTSqMHm/FscJqFerHOovjSzFsRvQOMPjUwtl36eQw7IFLrZpK2uckD8wUOer2OQPcTtam08UdYV/KOxyAS6a+pO0so/NsFEGp6FBW8T+ASqeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4G1eCMb; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4G1eCMb"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70b09c2ade6so3391594b3a.3
        for <git@vger.kernel.org>; Wed, 10 Jul 2024 05:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720613622; x=1721218422; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l7oVWE7W/skgdzTrFM4ZD/SFjGeAYUwPIV8YCxb0+hA=;
        b=H4G1eCMbmhzppAOtJTHf6pfuD2RmRQyuP3HbQIVV4ACuXpa5X05/wmP8H6x2Bb5HDy
         CvzfTO6MMbeion31h2cLzCN+LEUmnE7np8XulaByVoe+OQgIxEFfgH07JPib9px4B/Sx
         YGfjqW54lrk7VECqCKKjeDXKFbk3qXnbk9LtCcBVxUsNi0g/fnFnboY+lkuF3XZoMn/+
         X+9KKfuYXTBRK6f+JRmHCAGFwDU9D8HfGz+p6eZzlEUS2Vwi0sSIl4HGJ9Vd5g3mZbgQ
         S8/AiEf8iQfyNG4GtTO0TVH/sWa4yPxMlLwAzpHRmFNWHuHutM8GWk2qrOeOB38OOPcV
         +u6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720613622; x=1721218422;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7oVWE7W/skgdzTrFM4ZD/SFjGeAYUwPIV8YCxb0+hA=;
        b=YPvT+IOFlvBTtsJIpAlnTf1YxOCXSHC1h7k++KOBSwA01KdjKk6bt9Bn1norpF1yn9
         GGzrIU4MCjuOlqX79Noumc4xOcCqEOTWpEhov67j4HZp3lCwkg/z7igS3vf5DmSgqaPM
         hsqxkTiiEcjF0bV6VHr6RBf29g/+cpY0+PIeUu4z3PjYQYPsGMm0XTxz+h38Voh/S+RX
         kcJv/YjTW+xwbcd48AUv+9BRTmhGUD914NVqBy6EsLWJEqi4jD38HFF6idD1D6boIYVk
         8ImR8pucVOyZyjACLAn2YS7zOCddP7z2tAOV3WVFVxW7GGYj314+hk6Ri35J2aq0HqAF
         aoJg==
X-Forwarded-Encrypted: i=1; AJvYcCVGo2lNj91pGi5HGdLpfNN1I3PXawcwYg5u/02m1bClJa0pF0nvz7/qR5zac5HW6EsX6lfoFRSJ9d+gBy7PLhTf8cBn
X-Gm-Message-State: AOJu0YwF9X0m8V47jTe191SqPa7dQNOOY08PQzFr38314shDsCqwEyXN
	CICeI0fl6B0c1GfKwsi1cmIBpScvZ9VoibVb/oJ7GidyOWguTmlE
X-Google-Smtp-Source: AGHT+IEFiZuNDj7WqsERFbc6dyPdro40OzRBy873BbX3RZj2KAmuaQZwyGd5cSEJvo/GfFCB5S7+Fw==
X-Received: by 2002:a05:6a21:9993:b0:1c2:8d72:67ce with SMTP id adf61e73a8af0-1c29821e0dfmr5448155637.15.1720613621886;
        Wed, 10 Jul 2024 05:13:41 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ad089dsm32082625ad.271.2024.07.10.05.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 05:13:41 -0700 (PDT)
Date: Wed, 10 Jul 2024 20:13:43 +0800
From: shejialuo <shejialuo@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC][PATCH v9 3/9] fsck: add refs-related options and error
 report function
Message-ID: <Zo5695Ig1q6ronkg@ArchLinux>
References: <Zo0sQCBqyxX8dJ-f@ArchLinux>
 <Zo0uiz1y6hJld2Rv@ArchLinux>
 <oan7pcamqpi2z4jzfshff2sfziqgisd3jcbpzfoiuyks5g57mk@7isgeztkcgmy>
 <CAPig+cR=RgMeaAy1PRGgHu6_Ak+7=_-5tGvBZRekKRxi7GtdHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cR=RgMeaAy1PRGgHu6_Ak+7=_-5tGvBZRekKRxi7GtdHw@mail.gmail.com>

On Tue, Jul 09, 2024 at 05:40:08PM -0400, Eric Sunshine wrote:
> On Tue, Jul 9, 2024 at 5:30 PM Justin Tobler <jltobler@gmail.com> wrote:
> > On 24/07/09 08:35PM, shejialuo wrote:
> > > +int fsck_refs_error_function(struct fsck_options *options UNUSED,
> > > +                          const struct object_id *oid,
> > > +                          enum object_type object_type UNUSED,
> > > +                          const char *checked_ref_name,
> > > +                          enum fsck_msg_type msg_type,
> > > +                          enum fsck_msg_id msg_id UNUSED,
> > > +                          const char *message)
> > > +{
> > > +     static struct strbuf sb = STRBUF_INIT;
> > > +
> > > +     strbuf_reset(&sb);
> >
> > Naive question, is there reason to reset `sb` immediately after
> > `STRBUF_INIT`? My understanding is that because we initialize the
> > buffer, the other fields should also be zeroed. If so, resetting the
> > buffer here seems redundant.
> 
> This particular strbuf is static, so it needs to be cleared each time
> the function is called.
> 
> The cover letter provides an argument for making it static: that this
> will be called often, and we don't want to make a lot of repeated
> allocations. Personally, I find that argument rather weak. Why would
> an error function be called frequently? Is this really a hot path that
> needs to worry about a few extra allocations? Also, importantly, every
> static added makes the code harder to "libify", so making it static
> requires a very strong reason, but there doesn't seem to be such a
> reason in this case.

I didn't consider the issue of libify. I just want to reduce some memory
allocations. I will change this in the next version.

Thanks,
Jialuo
