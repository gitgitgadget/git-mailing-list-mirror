Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A310B197545
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 22:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727909138; cv=none; b=r71hvHfEufSKi/ghrkrj8QW0NOL+h5W+7amE0jkZP+LKW+L8/BmJcPsCxPm0HcfZuvyUonNQJ/NRwMA4WCS5FzBXO4csQalE9lVsyCN720sxg5rx0YzkMDmzyc+JEM+SA43HjzFPNNWNTfKr9HeFUrW7m3hJh1VONol2YKXM/hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727909138; c=relaxed/simple;
	bh=FtnC2K//obPUQqrSxh3vgE91eLeg9nhY77Ot8oRS1bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuCYMIwSt8YySc0Yym2I8Vg3PWHH8DWX2/IpzgjznZMpRMAqJ3Tvcaj9C54sFYUNVi5Sr4hIWEkncJZDoMmmt0eXQCH2FUpbDYj5bnLpMlcLmAjLYgUmdtq3kRbD5NDK0XN/NkjSLlqbQf/pGIwwY/a1MYtPXUeqU6dFMX5ZQPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kQSEWHiX; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kQSEWHiX"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20b3d1a77bbso70215ad.0
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 15:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727909136; x=1728513936; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOXV1VjaSUuR1CJLMzBW90ClmOtlns3t9vtOpyedhRA=;
        b=kQSEWHiXC0FaRPAeHFeSheM0VoPJ8xCxrBt0g0y0xhepUYHXmzghG3QDgUKZW+cu5z
         BUGy8om14WaLJlk6USO9+ACqUEE8afcDO7x8TYtqnvRcLMiplwT5NwN50pYzZ2oMqeHr
         3LvOy9VB1IaMxbF6GM8DmjaDDmkz0CEYPPCe+nxM9Xp0/WVVsOqnBtyTxmQYMeETb/WA
         Tfq6iJgFt0gzV2KnL5sWXfZQcj3c8jiFYJaHg1FPqlECamp+TnkAL8CQ35SldFj7PRNo
         l2tFEnTN83kV0PDLicB7BpL/Vg3tAJMy4ide+zu8JQjG2AEQb4qHIKqTDGv7G9Wf57rB
         ysUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727909136; x=1728513936;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZOXV1VjaSUuR1CJLMzBW90ClmOtlns3t9vtOpyedhRA=;
        b=Cqvss/4ds0tvWvuMH6O9hohSDywzBaacD8gUggIccABk4MpsUIdbdvCFroy1kRrbL1
         0kx1OX2iJEPdKmVwGGtymvNTMj0oRG5ylXkouXnIoit5hYVgvD+5U4ekWlho9mv4gCdj
         mQ0lzMQgfG/uv6q9tK1H/nwMPpebloUEUrxbO7am5EJcGT8Up9UldsJsmRBYjcRgWMRR
         Vo59HLFxzZC+g15PAluyAdO/pUaPjJtohgO49tLW+Kw0nO87YFT1Iiv+cU93bi4vTktJ
         r7PVLXo7EdHw/71ZmCfTHp5/IrlMvtlwNIcaOFTqsbBoL87+Qjh5q0o1qJK39PgK8NoY
         3g0A==
X-Forwarded-Encrypted: i=1; AJvYcCXehUaG5UlyD45Y//uqDfXnMLtrS15UzsTz7RXY4fybrBkzl0P1iy3TnbjlIVOCLUAg19w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNj6Tg6ZosliqKTrmJKBz8eUjRhj0dS01uqGFJ6L3QHHL8h+ZO
	JgXdvo6hte28iIXMkG/Az9cIhvblHcqu0sCyKLKg8qbSfkAa8mHMjQtoyfiS4A==
X-Google-Smtp-Source: AGHT+IEufBy5+TqGHA3jby31kiZfbqPxF1Nm7Lv9E9LLef5d3LCNIOkM1t9sz81UqhPphUrhXnbA0w==
X-Received: by 2002:a17:902:ec8a:b0:206:9e8f:7cb with SMTP id d9443c01a7336-20be4cbe88cmr1113205ad.2.1727909135230;
        Wed, 02 Oct 2024 15:45:35 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:2dd:9410:f675:e07f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20bcceba623sm14327925ad.133.2024.10.02.15.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 15:45:34 -0700 (PDT)
Date: Wed, 2 Oct 2024 15:45:29 -0700
From: Josh Steadmon <steadmon@google.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Calvin Wan <calvinwan@google.com>, git@vger.kernel.org, 
	spectral@google.com, emilyshaffer@google.com, emrass@google.com, 
	rsbecker@nexbridge.com, gitster@pobox.com, mh@glandium.org, sandals@crustytoothpaste.net, 
	Jason@zx2c4.com, dsimic@manjaro.org
Subject: Re: [PATCH v3 4/6] config: add git_configset_alloc() and
 git_configset_clear_and_free()
Message-ID: <g5h3agfmrsves4lazgohzihkqmao47obr2deh2t3nxlauwxj4s@p5fqzqwfcvpo>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Calvin Wan <calvinwan@google.com>, git@vger.kernel.org, 
	spectral@google.com, emilyshaffer@google.com, emrass@google.com, 
	rsbecker@nexbridge.com, gitster@pobox.com, mh@glandium.org, sandals@crustytoothpaste.net, 
	Jason@zx2c4.com, dsimic@manjaro.org
References: <20240906221853.257984-1-calvinwan@google.com>
 <20240906222116.270196-4-calvinwan@google.com>
 <CAPig+cRKbvWT3Bx65-ULAYRSrrKTCL0C7r6xpNSdN5JjLBPjCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cRKbvWT3Bx65-ULAYRSrrKTCL0C7r6xpNSdN5JjLBPjCQ@mail.gmail.com>

On 2024.09.06 19:24, Eric Sunshine wrote:
> On Fri, Sep 6, 2024 at 6:21 PM Calvin Wan <calvinwan@google.com> wrote:
> > From: Josh Steadmon <steadmon@google.com>
> >
> > Add git_configset_alloc() and git_configset_clear_and_free() functions
> > so that callers can manage config_set structs on the heap. This also
> > allows non-C external consumers to treat config_sets as opaque structs.
> >
> > Co-authored-by: Calvin Wan <calvinwan@google.com>
> > Signed-off-by: Calvin Wan <calvinwan@google.com>
> 
> Almost all these patches suffer from some sort of missing Josh
> trailer, so I'll stop mentioning it now.
> 
> > diff --git a/config.h b/config.h
> > @@ -472,6 +472,11 @@ struct config_set {
> > +/**
> > + * Alloc a config_set
> > + */
> > +struct config_set *git_configset_alloc(void);
> 
> Should this documentation string mention that git_configset_alloc()
> does _not_ initialize the configset? Alternatively, should this
> function also initialize it as a convenience (and mention so in the
> documentation)?

Yes, in V4 this will both alloc and init the configset (and the function
has been moved to the shim library).
