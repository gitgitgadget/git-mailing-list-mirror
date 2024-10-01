Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E8819F110
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 13:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790044; cv=none; b=qJQIn0Q1GtVh81QJbRe3XRTiXtleKEwxIO74VD3cmJjKYeXtUuzEyt5yv5m93YKxW+6P65/9eMBGGESy5j49K0iBLOVl3DQTAotoRTMNq0N9IL/jqA8WqbEZ+bW/r1rNd8o47ZEqrjLSpSbr+RdlfRtSRURwsWsqvH8dk60ysMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790044; c=relaxed/simple;
	bh=PC/D9pxvomX1VYkq5GEtUSNQn1qCroejAydIjvLQudU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCE8zJFLxIuGP8lb3h0FmbFpC6k33a18TOqZwuwrNRRIWOY5KwrwP20Qlr1kiAqnkv19z4sIA0W1RrsljC4t83lakZ+t0os/Oi9wRCjhVTW9OxgcfWY8IEtrF5hK9qJj0b/yVGUA5xGwtMZd2jkn3HNIYz9vB8jfeMgM4jQjCic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egEcH/4R; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egEcH/4R"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a345142c25so16313495ab.3
        for <git@vger.kernel.org>; Tue, 01 Oct 2024 06:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727790042; x=1728394842; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VpjKNsZ70R4KuQtmQtBBm8hWFniRHJhJY6z4knFOUxo=;
        b=egEcH/4RPfOXKInBuna7tQfL1yTj54GyXxwxUgVFW1kF8pEkcenDBq63lWOmLEVlPW
         tuJzKwQGTSIycVsE9XTbo8SfufO7n+W+EEMXAwFfbW3ajWXSZqYoR6MbugpCNBXxy8Se
         EUlWjdBPKSYV5SF7nuu33HErqtUvLPT2THKvqG27PcjnNBQZfgwozNHAK0787PZy1p0s
         ULxNtnu+2GLCtgaoEstQmhFBrgKaMW6Uq60rPxlj6guSVVEmss5zaiBNGbcQaKsFIji/
         P0oL4CCQcdeGiwUx8blbcueaydAVVQDIPsJWXuZ3J3+D7ccGTn0Fc87yENRlmqsw/hOD
         +bLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727790042; x=1728394842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VpjKNsZ70R4KuQtmQtBBm8hWFniRHJhJY6z4knFOUxo=;
        b=LUnYyXCeL3T64M7Pr25oV4bDsP/nKcpbA1dRQtw1h5c9sewGMf/2iIAzti7Be7bK+Q
         MRgC5K/ZtmeaLc7zS/eWIPrFC3VQneiJ8lWjywaIMZxvB19XvPwSinMx7KlFVPJDpHDr
         GqkWmlhfmFmVW+rwSj3FrGzDqhWwR4mZKYSsfL+4tNFWYATSb5wlzYtEGIi4hc9EkpSV
         3vDzl8vmldkOVOcvqIYTIFi0DNeyljQvRQEPRbj0JMwzXbSTa1iB0RCBiDpPv/WND4kw
         9RaFTimybk0N7Z/45LncJDoRY6nvCzJJQPLiUvHMk5udZg7xO4d4ZBXZZfc/f2Z3d8dW
         yGcw==
X-Forwarded-Encrypted: i=1; AJvYcCXhS26YuECgi1vcVkfJDkFqj/mbN1v2Zcsr/mIdGaLzHxWKU4K2kwC6TKm1lWYtEw1DJ74=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlEyPidrmTPpMoGRvm3WABnj3iCIMBQIVNeuhawQkTlpN5vasA
	k6NTOrgYoJyiHIYBjxQGI8sCmlMq+B0GvLHzIsVhhLnZysAn+gw/
X-Google-Smtp-Source: AGHT+IEoICwdFFQGJS+d3F9UwD1RTWhhyeZvQzo/N2o7iEA+AppKXBRBOUVjEWSd273BpV8P4cKOjg==
X-Received: by 2002:a05:6e02:1c08:b0:3a0:a80a:997c with SMTP id e9e14a558f8ab-3a3451b0cf1mr114753865ab.19.1727790042173;
        Tue, 01 Oct 2024 06:40:42 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db2c8704sm8363813a12.52.2024.10.01.06.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 06:40:41 -0700 (PDT)
Date: Tue, 1 Oct 2024 21:40:43 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
	John Cai via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 3/4] apply: remove the_repository global variable
Message-ID: <Zvv723-OwvEr0qMV@ArchLinux>
References: <pull.1788.git.git.1727185364.gitgitgadget@gmail.com>
 <pull.1788.v2.git.git.1727718030.gitgitgadget@gmail.com>
 <d64955a2e277da138146020f6a0cf96f4636a162.1727718031.git.gitgitgadget@gmail.com>
 <xmqqy13852jk.fsf@gitster.g>
 <ZvuBduVg9TJeULpl@ArchLinux>
 <Zvvr1_9syRh1McVA@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zvvr1_9syRh1McVA@pks.im>

On Tue, Oct 01, 2024 at 02:32:30PM +0200, Patrick Steinhardt wrote:
> On Tue, Oct 01, 2024 at 12:58:30PM +0800, shejialuo wrote:
> > On Mon, Sep 30, 2024 at 01:06:55PM -0700, Junio C Hamano wrote:
> > In my opinion, we should first think about how we handle the situation
> > where we run builtins outside of the repository. The most easiest way is
> > to pass the fallback object (aka "the_repository").
> > 
> > However, this seems a little strange. We are truly outside of the
> > repository but we really rely on the "struct repository *" to do many
> > operations. It's unrealistic to change so many interfaces which use the
> > "struct repository *". So, we should just use the fallback idea at
> > current.
> 
> I disagree with this statement. If code isn't prepare to not handle a
> `NULL` repository we shouldn't fall back to `the_repository`, but we
> should instead prepare the code to handle this case. This of course
> requires us to do a ton of refactorings, but that is the idea of this
> whole exercise to get rid of `the_repository`.
> 

Actually, I also insist that we should refactor here. But I worry about
the burden this would bring to John due to we may do a lot of work here.
So, I expressed my meaning in a compromising way.

But we should face the problem directly :).

Thanks,
Jialuo
