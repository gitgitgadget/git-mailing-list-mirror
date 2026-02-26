Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB37A3B8BD4
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 19:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772134146; cv=none; b=CGs6M7Mydm5g4xxHpSPVtIgsW/8g5+NwXe9U8C5sgjSQ91ZlCnas94POBrnElWU0OKqiE1ldQ1RUxp3PzwVdk+1dee9ZbyGLfl9UCT9amGMLqYkUIpZyJ6JJLpeal/PG20m53pzWTNND70p4gKJBePcPkZvoT/jj/8jaA4nmMTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772134146; c=relaxed/simple;
	bh=H6TOtPKdxNtusihUtw4UVTdpgrzcmax7LavFePsp1yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvuV2IPWoAIqN5TFBUENGrdBcKGqGrKuJgGpg7VtxuQin8cihie5QTlrVS97Q+/BPnu4kzQA31IxCaegznFipkSKvWCvCBEIaB8x7blcXrlWYUclzFnOb3OxhtjCWS00ydCrl9+wXi4MZi9qR4SSNmzxHZecwiqnE0rUZf6FdrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cuYkzlR3; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuYkzlR3"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-46394090d2fso479976b6e.3
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 11:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772134144; x=1772738944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MWKZM+xDM9rCriTFZN+50wziCu2Uc20eHLAFsenVKxA=;
        b=cuYkzlR3r1tIbTerFgyhtFIcmlH64vLCm2hRiuD69hlpeBE/y2JiqjPfwUIeGnK431
         k6Cro2qFpHzfgmmRRZAmgOJnrmsQTpac9SgEXLYoyE8hMxc/6AmWXZpbgEICqajq0la2
         I9g05QKvzXJyCYFfd+9fFkxeUmaL3GkNKFPDPY0X+5gSPGVwxXRizO1gExHqjIN5L5sr
         Afaddh1dcmARlwPvVglMyDT8QA2oBUG6cOmy23qlUxeyh/w/xT57jDeJ/MeQ8VnYL8ze
         hZ7Kzr/wcr88rCeiU3HOeoDIZchXNpOI15O/KmvhYxeOWcGlxpQnLI+BIbMPAOmyzvsR
         CIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772134144; x=1772738944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MWKZM+xDM9rCriTFZN+50wziCu2Uc20eHLAFsenVKxA=;
        b=Wgqk9evcz80zdPJ/xbOZn1CrggYvGCN0q6qDBD1yiTyT4VYVeNPhnqwGKDzTCTgmZU
         OBqvJyV6bh7TerGQ72NfBcsgQHVRTezPuhJAUd3Xkmm/rnpQVzfZkWWE2ufCMB9dcxBl
         NjHNg1M1EuOvR5m1UEzDt76k+5BhYeEjvarcFWr0fi/xMI/Eh6DtJlhQHyKvOgi91DfT
         aXai8rNBIaZlt8TXh6HowtVzK1YbEa7rP91qnyp48f6lXjhE2PgtoLaGE7v10cSDCd+X
         OoAfR7nI+LQr8EvaeFJc7eJk/EhuHSU+sc4QTTWvt3C0/Ek9iYF9BgaxEQvxWgdS/W9Y
         PzWA==
X-Gm-Message-State: AOJu0YwxmrZfMpENS5RxDWDcBKoe5pfeQ0L43MSi64MUi3LySdcWKUrr
	4M3n8j+GjR3tSXHxYud2bfIbYO6DehUsYbg0GaU4e6Tx20XsFDD30g94QuZPMQ==
X-Gm-Gg: ATEYQzxAo66AvfTGDADa7zq4mkh2dNZBV3IDE+lpbPjsGEiBTIlBm0yXYZU3sS+unEy
	3SoGkcMjZA7/wBb9jW/zoWy97L4mF0hDNc6njQwxznK/i+S0NICxF8uQY3HE8GPZjyJWbWri/HV
	JAP4FQGNeuKXSyWLgRDUt6RyLEHrCQctQoGj7+cgA/VYeL4TYyeb828gXAT9/wkJdWEmrq3lrN8
	rDz/YZTW95psUUKbXPqm6sR0g72P/nTvFl9zfQ4fMUY7XRpYVxvmktrwsYBgzvvuF11hLS5Wl3u
	kvDDNjTE90d2hgzNQjuhh/6w2NSH/+/EBAaW3IjUrJ0sjBmhcB4A8G4TSmuizLwFKMNFB2C7sCf
	+xFlzstUCvVBLrGCjoLWUpAt/YF4kn8MoCbVV1iSvVg/S/IRhXs2IGRpGEa9RMFKh8WPSXU8Ujq
	60JT3Z7HuPNT7xXPru
X-Received: by 2002:a05:6808:1789:b0:450:aa96:3c13 with SMTP id 5614622812f47-464bec1d92amr127818b6e.3.1772134143746;
        Thu, 26 Feb 2026 11:29:03 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb5d0a8csm447992b6e.14.2026.02.26.11.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:29:03 -0800 (PST)
Date: Thu, 26 Feb 2026 13:29:02 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/5] builtin/repo: update stats for each object
Message-ID: <aaCefUd8JLpKAyPu@denethor>
References: <20260203221758.1164434-1-jltobler@gmail.com>
 <20260203221758.1164434-2-jltobler@gmail.com>
 <xmqqzf5pqwtm.fsf@gitster.g>
 <aZYUwjSEAcGRSXNa@denethor>
 <xmqqzf4v1fdc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzf4v1fdc.fsf@gitster.g>

On 26/02/26 11:20AM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > Good suggestion. Some of the info added in the following commits is
> > object specific and will need to be handled accordinly, but we could
> > probably still benefit by structuring the data a bit better. Will
> > explore in the next version.
> 
> I am looking at v2 patches, but did this happen?

Apologies, I mentioned it in the cover letter, but should have replied
to this thread also. In version 2 I kept this the same for now.

-Justin
