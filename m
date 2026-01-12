Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E282FD1B1
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 15:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768231673; cv=none; b=AUD8YXSchSqzyg+PL+QZt33aP83H2mWW5Am2RqogUJcVrIwwFLveG9ZPOxeB7AUH8jf7yrKWL7zUAn1TzwG5LwjKhwud6qeaZoTejpe2BxYiEVPpAE+JfQzwJXOQ77gyViTHVB4LOmhPyDyGyE3zIiM6LpHC5fC6phU5CsTE36U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768231673; c=relaxed/simple;
	bh=WGL2YCdKJ0kjYjHAxQ7OgaecWcw8A+VHeMEVgOpKMTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FG8Cbl/NX6f1Mx3JgPZKFM4TSCvaUbXQJq2nlAMTi5hHdnMYFX4LX1vooEdvsYkJZ8AcOA5Jw1mw+VZ90QY0qRw9KksQ5IskyWSrNebiqJFGRTEBxxE0fuOGR5CR2XJ1X3Cj5YjKwdoB+6dL+BU9Qmz5KjN2qmIsO+9+BNQILkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFws/f4Y; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFws/f4Y"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-65d096dd0ceso1447745eaf.3
        for <git@vger.kernel.org>; Mon, 12 Jan 2026 07:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768231666; x=1768836466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=06e6tjykCGxer/8XGkNoqf3mxS/kJZAIV6VfHP1y3VE=;
        b=gFws/f4YNKPAssS1vxcuh2F8rShK3MVtxxSxvbZ/WJJaxlvQ+isVuMAlcdw0qAPFrN
         jIclZBfSL49Yi/Bpsp5TWlaRI0bCtbvT9Vh30fiODX86jIKT1H05VWsy2eDF02lDuqlT
         NGfabQm09dm2bBN+IZzHZ85qzSO5wKcJDEtpUfJQwRdxUVp9OiDV2jVebpnEGFWdEe/z
         fX53WGojznRVCXp0sZMnFBiQ/r8wy+GIKAM+2rrpgYLKnMD1Ss7EAwBZ+F24+Or5XhtU
         XMGA8HIj3grfvKJ1GEwnTjZKgLjaBoX7gXZEGyaH80aNjsRe6dLeY4oiUxSBQ4ZnDztO
         S/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768231666; x=1768836466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06e6tjykCGxer/8XGkNoqf3mxS/kJZAIV6VfHP1y3VE=;
        b=uGltVkYEhC0gRuUkxxOR12/CGEQnKysw25HWLbqZb1JIsbnROWUzm64W0qUNa6L4os
         FpVON7oKAZjBve4kT/CKc9iYpPCus7x9C5YSwObJZBjFlF3YNtSTEjpv9JMV3rUujuwm
         /qvq3+cs8Y0cZKDmBMkGtjoBD6PVvcaL8X5BLhlo1MZwTJIm3pukJm1kWScQoHa2okGH
         kRGlldVoeTKr/SKBLT5LG1qbWUJZtWhRj72DupInqbdp6K+2MSy5MYQeGtyAEBIy9uee
         n8YRQBcGQYDWqWS89pMIQ5/neA6RagZQkQiaAHqqlUpyECmn66T1zuTpUSBnTyk2gZeW
         0j/A==
X-Gm-Message-State: AOJu0YyTwmUnATMAEOmPF/Uqz6OgKk4DE9AZQEyAmfIg6Tb6/z+REmfD
	R/XuFEaGjdrSBvZ4n+vgZM7OGCbCfPsfk6e5Uct55EnOKJzbMZ09zMqXNke9Sw==
X-Gm-Gg: AY/fxX5oEIrqi669jg9xXeJ9KeSLA2BUkc7bl2FUXw6eYg563EsFMg8ZooSXE35CfqK
	mJM2yiFNkFEmY3XUFiBNoefDMyHyg7AiR+fPVT/tFgDchz970TN4P7wYt4DGPunsT3BAEHy0aTx
	pEgY1HCWQ4PlAJQgMGfmsm3cLY+SmQ2I8G91zgKQ3gTwVDQD/tUGCgpGuu+jyGXlDNCFtyHr7LM
	irfLuxPq4RNUH9q3XlhT64D1anReEk5+puNXw8D1GDtAuHPBaL7FREZDScQ/GCCekUuf7m8UGP5
	bBHtpMTmlxXDPw5QfJps0efQtAnuXackSnX0dEIXVaeImCXaoIGAr7OjHHUynGM6Z7dZC6kzViC
	VwgzfME5PrKqKQjlVXiCwsPfLQcCPiirlTV4lvCwG/EiSMB0KItqpOs+AP8wo0pm4n8GIE1Bh25
	7bXbQF
X-Google-Smtp-Source: AGHT+IF7t/4mtYKqpSm60wjnluB/B42Xn83d1Ms4JbC5x6CHx/Pju1KYBVKeq4mc8w+0SexIHCWMfQ==
X-Received: by 2002:a05:6820:1aab:b0:659:9a49:8e02 with SMTP id 006d021491bc7-65f55074400mr6538149eaf.68.1768231666046;
        Mon, 12 Jan 2026 07:27:46 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65f48bbb218sm7499512eaf.1.2026.01.12.07.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 07:27:45 -0800 (PST)
Date: Mon, 12 Jan 2026 09:27:41 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 00/10] Start tracking packfiles per object database
 source
Message-ID: <aWUR7mnX29C4YtEn@denethor>
References: <20251215-b4-pks-pack-store-via-source-v1-0-433aac465295@pks.im>
 <20260109-b4-pks-pack-store-via-source-v3-0-877fd7b7bf81@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109-b4-pks-pack-store-via-source-v3-0-877fd7b7bf81@pks.im>

On 26/01/09 09:33AM, Patrick Steinhardt wrote:
 
> Changes in v3:
>   - Fix a commit message typo.
>   - Link to v2: https://lore.kernel.org/r/20251218-b4-pks-pack-store-via-source-v2-0-62849007ce21@pks.im
> 
> Changes in v2:
>   - Fix some stale comments that still refer to `kept_pack_cache()`.
>   - Improve commit messages a bit.
>   - Link to v1: https://lore.kernel.org/r/20251215-b4-pks-pack-store-via-source-v1-0-433aac465295@pks.im

Thanks Patrick. The changes in this version look good to me.

-Justin
