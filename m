Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DA675809
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 20:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715552; cv=none; b=h0fVsc3919x1zddO+qMrv/Csdp3FFbjiYwwpF6Itr4QBbNu5okyjUfN+41MeghCOeffrAfKaCi+ur80iYg7nuEuLTtrH3c4ogthVJj7UNySJHoYTIw23T3TLfLGOZJJvQ6S3OgJm7U+qjhnc3lkRg1IeFHGAFziLRsJRvb3pJh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715552; c=relaxed/simple;
	bh=mPpAFbAfg/aH0MQU1oXxzcrBS2YlyNO/MYf+4NhqrT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcG/C7Ps4/VKp+3lP5Bw5sOcA0PP/DwW0wvGv51gDY7oxH6iNma+FfrPQs8p/dN+PnPWrVBoE+noUaxBaZOHMU+1CZKmCu7iYSTESvgYZuV6zP5FOhdcG2yVhd4R4TEmhkgAvkJsAPFDo7FNrp6mGFxRCBOVd6Rv7C45MqZah0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=GUt84/yY; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="GUt84/yY"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e290d48d3f7so231581276.3
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 13:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729715549; x=1730320349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Aud9Wa2K5QVzznTbLwGED01Q73v+IYzkJae0Lzm1DLg=;
        b=GUt84/yY6ZdhvRMfDM+HxWptqWbEJ4L8S7xX9RqA1hByQAJ5VqO/QZ9qxeilcGojuc
         Xgjy8ugkl+rBuWwBxpOHSqWWZ1Xw7zdTSXGEs7/N7MkrfVoE8BiBCLHh6p2xwZb/+Vbl
         sPEAglEeWo4vY93xmq5ABFEN80mgK+WjRBPCY6FA/zAJQQiJ4f2pR71qqPaWPsxnhiDW
         h+cDcCZYoiqDolkco9U+h9ywy7HjFnzFGtO+w7jjvkECzPe1U0Z6F/wWzkx/anzQOUaK
         YPPfOWax40GkW14TQ904WJdyvORtDyMR+WALO2uBxRMS2NprmU4R/taj6crylNl3ocK7
         rH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729715549; x=1730320349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aud9Wa2K5QVzznTbLwGED01Q73v+IYzkJae0Lzm1DLg=;
        b=nEAlNHA3IxCWinI3c4qM5Zr/kT2N4irQCadFv/aYgxE81ZCRBeVrLs1aXlTsFR211i
         9QqM/zEPvlyuD8IvU+sDzAHk7mWlCgFtQsKNFAxKTQJ03CocAa4KEocAn/xgQ7OgkuQ+
         U2zMIWQDEP5LaVfHR1GI5f4SvcI3d3TcOuPzqQTD90uNw0reDby6l1RrI+KuD2B3ZOS4
         aJgYFwChF7sEjODE5t6oSI+HyKy4dK3XjqqoEeW9n/AGKdYkZ4LPkBSFAto+qg2+5l4X
         aYiZevbRinDF3dz3TBpNSCODGHws14A8Rx8/P0hQ4VAhIMllQiq3D5bbK2+BLccy9zLg
         ttCw==
X-Gm-Message-State: AOJu0Yy+RYjYLZsrwou18FV7W5EmB0cPGIpuVx/z403ZykozUras7rzl
	rur1AlW2ikJvt6X1o25D+lT/ZRGu3m+Yo7JE3OGv4rpjl2CUjCtnf3p+4XoYNpw=
X-Google-Smtp-Source: AGHT+IEyiUk3zvCEeb+H4u3mtNXt5LBwlADYBJoKhEglUplol+krN75/pp9qv8+Y8kavLkYArCLY2w==
X-Received: by 2002:a05:6902:2513:b0:e28:6b10:51b4 with SMTP id 3f1490d57ef6-e2e3a6d14d9mr3445419276.46.1729715549610;
        Wed, 23 Oct 2024 13:32:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2bdc9b2547sm1680818276.27.2024.10.23.13.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:32:29 -0700 (PDT)
Date: Wed, 23 Oct 2024 16:32:28 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>
Subject: Re: [PATCH v5 2/3] merge: replace atoi() with strtol_i() for marker
 size validation
Message-ID: <ZxldXMfsCuiyeIE8@nand.local>
References: <pull.1810.v4.git.git.1729634937.gitgitgadget@gmail.com>
 <pull.1810.v5.git.git.1729669220.gitgitgadget@gmail.com>
 <da9ea10e4e115777c16b32f1cde96a3df8c5cbb1.1729669221.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <da9ea10e4e115777c16b32f1cde96a3df8c5cbb1.1729669221.git.gitgitgadget@gmail.com>

On Wed, Oct 23, 2024 at 07:40:19AM +0000, Usman Akinyemi via GitGitGadget wrote:
> diff --git a/t/t6406-merge-attr.sh b/t/t6406-merge-attr.sh
> index 9bf95249347..c2a9cf03808 100755
> --- a/t/t6406-merge-attr.sh
> +++ b/t/t6406-merge-attr.sh
> @@ -118,6 +118,12 @@ test_expect_success 'retry the merge with longer context' '
>  	grep "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<" actual
>  '
>
> +test_expect_success 'invalid conflict-marker-size 3a' '
> +    echo "text conflict-marker-size=3a" >>.gitattributes &&
> +    git checkout -m text 2>error &&
> +    test_grep "warning: invalid marker-size ${SQ}3a${SQ}, expecting an integer" error
> +'
> +

Do subsequent tests further down in this script depend on .gitattributes
not having invalid lines? If so, you may want to instead write:

    cp .gitattributes .gitattributes.bak &&
    echo "text conflict-marker-size=3a" >>.gitattributes &&
    test_when_finished "mv .gitattributes.bak .gitattributes" &&

instead.

Thanks,
Taylor
