Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B31E23770D
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 07:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754639729; cv=none; b=KF4N6fU2E4lc6QMpP3HlGmHh3xKejzCgtdKE2t0sNen/dYe8GxRdPhyuvJqwRg0AT0ibnhmlKwp1BuDMH4f0ZPeV5+2sthfgGppV0+aVQpfOFvd7oaaOQkFmktmkb2thQ8TSNc04XOQTm0/1gJKXmJr5uL9jsdpn1On1h+kb7H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754639729; c=relaxed/simple;
	bh=17sw/A6iruF8MfoGEx5k7SjtxqDNJzvQ0Eh6lPldhNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GB0fpkx7tQRU9yC171ULAB2lGLpw6UdyeFxk/4R22e8T7yFJ2gktA5WTXy/bTWIXXPGXJabGIuMUg14qw2IKTezXHE8GF6myeVaUCpbZrGYEKMMjh/YI0WeCYNf8aN+EKLdpr9J/44Wxllm3UpPOsjwajgr8cxt+baY/fNYsaTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmH9M0UU; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmH9M0UU"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32130f6cfbbso295609a91.0
        for <git@vger.kernel.org>; Fri, 08 Aug 2025 00:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754639727; x=1755244527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZznwwwpPOOmMqMRJnTVKx+ZqPDQcG3IYHxgjfvFARq8=;
        b=XmH9M0UUOaB1+JBAemXNfKFLWSgKZ1xAPSwRTcfGXCCkEI02kFTz+9C39ft+1kQyiq
         JwzN5LbIzNddF8zIfBnF75ryZOa1WK/P/dvDMqj5L01XNy+adeKl7BHrvaCjrVjVmBNr
         P8B8a2q7jfH+pgMTFmcY318V7FWcHYhS3Odku5yXAY28zLDms4gAlJWLNHQwhZ/B8Wbl
         kQlwiN4WVAQ5qxHlRuab2eyqlqzD2BZ4JioWkExPWDazsbBy4920pDRzN2IPWsMPIgcT
         FVNhEbxs39Wr/Yf6V3gZA6w4Ad30Rv8EX4tStiYGJ2Q6EF9w++rNFTFZUBn69o/9yDv5
         fJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754639727; x=1755244527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZznwwwpPOOmMqMRJnTVKx+ZqPDQcG3IYHxgjfvFARq8=;
        b=OeDfCBQrOBKwypWEqzcf3B8OePUhR3uWr0a/tH1UvOl0QPNrhPeLOfZr0tBfcX8BeR
         TuTWOZScK4oPA0aS4paUBRd2SuOmrfpiDzrAOdERWKRauSSXuqepNRIlftSpFEjsDJxo
         lRH18B1wujythlUoqiY1uEMCgF7NgdI5q3p3j+L1Jna04/QYNunYBYm8mUCAEOAr55vE
         4X5IoEjeKxf3U8YlIM/RKSankldzxyPaOgfjQHqBZqzRSX+Wo1YtT5UpTddtzzWPcl6W
         V3JO85tjB7mx37SnN3qXa/uPgkvO/iNMNlmIvNucgiJ2vAHCeFx5+FhvtLQPl0PQdChx
         l5fw==
X-Gm-Message-State: AOJu0YyQOVd39RAOfwsBjqA8CbTmhTlIGeGK2UZAPOyh3/6hVmajag9M
	1VhT2/p5S5Wiu+meB3zDE43pPMmq6bBqQPAzDN56Cz+brg1Sn66t3bPTDrYTeA==
X-Gm-Gg: ASbGncvnGzYd7Fnv/eKPw940T6tYlmL3w4kAnT/eTBHeE7hxCAJHLU2Bnc7OiKzXUpO
	bp9PDNzrbLIigWhUrCBnjFjygZpbAwQ2koWY1j+jNR1fg7LwDWU7/Ma3cH3XjExioMBB/L0CrzK
	zpaBkqUHhi/z74XBGPFXbk86Zyc/tvAkxYg+FW0GOhWp43i+NVuR2E50FdbRM/u9D7sMrG7sG3/
	UPChAuLuPHA2dYhsTnY7KhOdU/MW3AWodAH3XGk32H61+d9WjhAqP7v2aTNDOkYghHdicksWdhH
	MLwtQpWF/iEvSgI3a1zF9fve2V+XkSUaCG4GFQpkGFYLphJVwpSt4uG9JdWhaMynDyfsbfu/Mve
	oAn+j7Gv/lRTQNtIfHChXuSWizB4jYA==
X-Google-Smtp-Source: AGHT+IE5IQuAwj2cJelKFbrvHUW4g6kGbL2i9qhtUQ17mGNzmKxQtY1i+Gfand/Y32NKWxTTcX9qKQ==
X-Received: by 2002:a17:90b:33d2:b0:31f:ea:ca84 with SMTP id 98e67ed59e1d1-321839ec014mr1406998a91.2.1754639727400;
        Fri, 08 Aug 2025 00:55:27 -0700 (PDT)
Received: from generichostname ([2601:645:8300:3b10:e54:15ff:fe8e:caa6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3216121ec0esm7596061a91.10.2025.08.08.00.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 00:55:26 -0700 (PDT)
Date: Fri, 8 Aug 2025 00:55:24 -0700
From: Denton Liu <liu.denton@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] t/unit-tests/clar: fix -Wmaybe-uninitialized with
 -Og
Message-ID: <aJWtbGGBOELZN6tp@generichostname>
References: <d03308e9474f5e26fd4a5494ec243a278e971443.1754302009.git.liu.denton@gmail.com>
 <cover.1754371649.git.liu.denton@gmail.com>
 <8ed0ac14092e7ec979e53d2a3da84dfe884d6b3f.1754371650.git.liu.denton@gmail.com>
 <aJWPmo6oGCuQvqMG@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJWPmo6oGCuQvqMG@pks.im>

On Fri, Aug 08, 2025 at 07:48:10AM +0200, Patrick Steinhardt wrote:
> On Mon, Aug 04, 2025 at 10:31:16PM -0700, Denton Liu wrote:
> > When building with -Og on gcc 15.1.1, the build produces a warning. In
> > practice, though, this cannot be hit because `exact` acts as a guard and
> > that variable can only be set after `matchlen` is already initialized
> > 
> > Assign a default value to `matchlen` so that the warning is silenced.
> 
> Would you mind creating a PR against upstream [1] so that we also have it
> over there? Thanks!

Good idea. PR over at [0]

-Denton

[0]: https://github.com/clar-test/clar/pull/119
