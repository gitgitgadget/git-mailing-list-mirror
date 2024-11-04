Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950F51AB6EA
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 22:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730760517; cv=none; b=KCanLgA3kOjY4GWxU+vRMXBvTIdddKMueMPJXhe70njzMLANzO3JikDlmkxUfeuXAp2QvPo82JixyIy7WeRr/Dc1p3o33oK6KqLvZSSy9pQNzQgPviqRcjfEe2oLnR2NFx2ivw/L6B5NClmjJIM3/3Tw6udnlZDyMDPgG5Zx1SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730760517; c=relaxed/simple;
	bh=HFHi3ZMVH5lgiSiA3WCqWcbg4qmPhuj6FxekvJ86rUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRak4/ONLj0ER1abK0Mrn9LKoockVY8HXq/ic4c+ENb5OiKni6qu7f0kTXEJ/rKzWHM3YfJEjmtgO4wxJ+MulKp2MdWqJH6IGTJ6TlA+FgdQOD5xtiWrBBXzTPU01j+5dhPWCGp/gtdqvoTwuecQNC2Uexlyx1uEoBStmUQwfN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiiMxqGe; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiiMxqGe"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5ebc27fdc30so2548155eaf.2
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 14:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730760514; x=1731365314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U0aiMks8aW8yFc+aO981PVGCZlgQn+CSBgirVwg7JEs=;
        b=hiiMxqGeGK0WyBceZFGDjpTRRn4n9/b+gYuDkZDyEmdh20YBXaFZHT5qqVZANX6I6Y
         lf3HIO6UngisM0j2eaqY7Msq2VvlSwoKvDRnt7s0Vpj3/ux/aRY8aW1rAMPFF+g27y5u
         st0XI1M0ZxVcAyuX5EcIbz/n07cU9eTX+SF1zI65+lXgOK+sPBoPexnT15gANMXpS3F9
         8kf0lBXhRI9n2DX0WkmyrWZb+emm7vEfQ5iN3gU/upjScsTLfAiMXS/upTG6ji2TLnXA
         cGnlKYqB8s7Zkip4bH8WQFvaEiDBJcXDbWUJLmfjIe9DUFMHqVNgBi/c+QuFn3DcKMLz
         b3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730760514; x=1731365314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0aiMks8aW8yFc+aO981PVGCZlgQn+CSBgirVwg7JEs=;
        b=medliQFN56DyYDMzg2awYAdKNUrYabhe4U88FB4rfimJaqcXKYdPtcfoYe+JyYzMA3
         o3zQ723qilzvDJ3psXLdOC6/FFytn2GUK8xgNJn0L905kvBnJVdLGDlb2KS9dFJyDRDM
         xGQFjgg2k20Rzf0+bbyT2xWKLYGI7TXnBkEo+q5db9+ciU7Svsf3paa9NvVRp7Ve8VGz
         WcXlSpvL49/lLgj+rkzB65zFy6T1L4qWxG9wheZU31raYnF4/1FTZ5kz50OQG2gHoNOk
         VBcwkDMYQph4/8hZUlB5YAU/FXFmcN7SS+MeCy1ru4sCaw3UIHaSZ/o8xTyWvjHqjMQI
         nDhw==
X-Gm-Message-State: AOJu0Yw2vwPKVxX2LxAlKayYZtVet9fx+IwmC5ErmUWo/7+bXo2wazHv
	LdZEoSAIShY+VeqquF2N0ly1el28fW0Fo+2dVH8DkN6XDjrSzTz/
X-Google-Smtp-Source: AGHT+IEvDYDI8mHyyh5oqWO6rZDiUVlR7yob7pc1hka+iJ9RyDYQJGDuDe4vpRdHds7h0/36UlU9jg==
X-Received: by 2002:a05:6870:9112:b0:277:fe14:e68c with SMTP id 586e51a60fabf-29051d75b27mr26971292fac.33.1730760514685;
        Mon, 04 Nov 2024 14:48:34 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7189ccb122bsm2232445a34.49.2024.11.04.14.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 14:48:34 -0800 (PST)
Date: Mon, 4 Nov 2024 16:46:57 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, 
	Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v2 00/22] Memory leak fixes (pt.9)
Message-ID: <v4cfsfnmvqhedtsoykax4wkq2ug6ke4c2rrtbwmtanmc2fonzj@4il4rzkuyffa>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1729502823.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729502823.git.ps@pks.im>

On 24/10/21 11:27AM, Patrick Steinhardt wrote:
> Hi,
> 
> this is the second version of my 9th series of memory leak fixes.
> 
> Changes compared to v1:
> 
>   - Split up the trailer fixes into two separate patches so that we can
>     explain them standalone.
> 
>   - Adapt the second trailer memory leak fix to instead pull up the
>     strbufs out of the loop such that we can reuse them. This makes the
>     code flow more naturally and optimizes the loop.
> 
> Thanks!
> 
> Patrick

I've reviewed all the patches in this version and left a few
non-blocking thoughts. Overall, this version looks good to me though. :)

-Justin
