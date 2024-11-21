Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866BA43AA1
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 20:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732220234; cv=none; b=t17c2hgTPhMfX8DFVclql6cavrzNtnD77pw+8le6frHIy2LyHyVmvV+P90V10B+sHOaYWDtMKqBok9xugOpn4ZXMzN9iydweg2fj1Gsbd6Iq4TKlf7QltAzuQxzm3LjIaHU1D/IsXH5cbZjG6g+RGSnKWQ6tMXHsjNJGswJqBYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732220234; c=relaxed/simple;
	bh=d98ssLq3lM7iEgvorW5R8HotiT+C6A+pwN0q91H1nRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQPJReCTZ3sjQsXTqzNeUYxkV3B72lrlPA6UnA89pnVrypcPwuXT8FDEvNSnboOvtGsfhfSz7xQ8AMW1wRaDoFRBsv/5aBa7DYuz79RNhmuU37quy/3Vm2w8ZNPBAnn9eqElu93zgQlfM1LbCDN7bxPGenqhmXucHy+Oc2Wmzbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=YJPagptF; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="YJPagptF"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6ee6a2ae6ecso13128787b3.3
        for <git@vger.kernel.org>; Thu, 21 Nov 2024 12:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732220231; x=1732825031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d98ssLq3lM7iEgvorW5R8HotiT+C6A+pwN0q91H1nRo=;
        b=YJPagptFx1MiFQ2AEesICXIIkkvA250ikS2PjnK6CDY7IANKUdlIDbDV3IR4o5jsu+
         wx2D07cS/qHZUgHLX1zjonRgQa7+gsyPit7NT9Vyls39K0eF6aiscTKG18OSbyO4Ajki
         zBT+wMOPzM5I3IgHxDt33WXqV5p/6O3lZttsM06PSl5BW3bmoqpwNLRLvF2D8Azd9Rnf
         BcPkX0SB+d5DbA5roU5RX4MnhFXrktRmGrGH9ztAMq4TvaDwXDBCiLRgwsdyn4TIYHZg
         fDDr1UPbk83ji9+dAXl6TQjdrHymMBKZ0r8LiMKjQxM08+LUfjv+mF/AW9Lx4phHdBuj
         fesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732220231; x=1732825031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d98ssLq3lM7iEgvorW5R8HotiT+C6A+pwN0q91H1nRo=;
        b=ULoHJFB2b9A+5kuf8iwol+k1Rofbiw1KdIQ6pjrGJL7RNgCl4ia4UNp7VIUEG4XPO0
         ofbEfkCtm7R8FErXe8hKXGFtS9LcrDhEUppLoznEMJEKL6PC5euSlREeKfm+MbEjz5gZ
         SCLelWRjRtl6S/Mmwv9Ta6WpjotZIkV/3MrkPGpHWRcJzuVNkvYg8k3qrYZlpKywTXve
         X34SsBIRmtOyGA09pEb/cRWarUnZki73pmrSHYUWxZY6+mJLayVp2KjV4EBQ54r6liLN
         abf33LkGeK23fpjmgwH8vw/GKiA7/Bt9VrgsG3R9vCVsG7zTofOlyQx5zjqCVEv+Pqoe
         tlaA==
X-Gm-Message-State: AOJu0YwXooyIWQIpE950LD+IDT88HHEjwEiFVmQq+Y8FbkmGHG+oNsUh
	GOz+euqejRvQIDJKub/0WQMahvc/KMlXvgbbroJ30TQabsSAElB0KF30Ky6QwNQ=
X-Gm-Gg: ASbGncuGejz3MhImdYZ3x/+WLZ/f3S0AJqlxHJ6/UaaxEVAnk7M+c8aSmWvnQ2iZNfC
	nQrrm0bDryxdP2ebAl7MTbNDLCNzoJWHaOJo/isnqLASAeTMTDQ1lRtg4ByOfbhWq24eiIgubKX
	wvw/W0YIYGCoc3BTKRS5CHUtcR6yAGtHBISs0jhaW6jSJCVl3+gSocpyEPgfrfLt1j8HOcxM5SP
	v2esOz0Ikx4UpKCkCVHEy5oi5/AjFNUmyg6JCDC9P+sUIufjMAky4naZRM+u3MU35K1SvIxJsfV
	M4DYLjkqhqz4PZikmBAl1A==
X-Google-Smtp-Source: AGHT+IGlmImdTvKsCeixfXC8ZE2C/vyFQK4QaOoddI7r6o9eCtsDNP5Ro0Z1c/5CCuZlMVzFH+rs7g==
X-Received: by 2002:a05:690c:7206:b0:6e5:bf26:578 with SMTP id 00721157ae682-6eee08c667emr6593897b3.17.1732220231472;
        Thu, 21 Nov 2024 12:17:11 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eedfe16d45sm1096527b3.3.2024.11.21.12.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 12:17:10 -0800 (PST)
Date: Thu, 21 Nov 2024 15:17:09 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, ps@pks.im, johncai86@gmail.com, newren@gmail.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 4/7] git-repack: update usage to match docs
Message-ID: <Zz+VRZnWjsDI9bLt@nand.local>
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
 <65784f85bce943e6a6bf29d7a57bb106aff8226b.1730775908.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <65784f85bce943e6a6bf29d7a57bb106aff8226b.1730775908.git.gitgitgadget@gmail.com>

On Tue, Nov 05, 2024 at 03:05:04AM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
>
> This also adds the '--full-name-hash' option introduced in the previous
> change and adds newlines to the synopsis.

I think "the previous change" is not quite accurate here, even if
you move the implementation to pass through '--full-name-hash' via
repack into the second patch.

It would be nice to have the option added in 'repack' in the same commit
as adjusts the documentation instead of splitting them apart.

Thanks,
Taylor
