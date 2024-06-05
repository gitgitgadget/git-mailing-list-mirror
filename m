Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A7C19D8AE
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 13:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717592819; cv=none; b=OXIdqao7q79hUgVOdxl66TEKDDfQ02DpTFNFZV7qcOJNRiOx9HO1jpdeEc54hBLblrqBQYGLQEHR/+TiSqnmnTsYTocEhM9GcJEq6J634BxLtaFbiulx+Cz2E2bVwDy02P3m2Am/Hr8i7Bxv7PtzvTlPjXa97ScHYTKqcC84iXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717592819; c=relaxed/simple;
	bh=OoapvgAg4bcOjBZXBIz7W30liZC/UC25DRIsMPGp2FM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZPTMbojUMoAFYXmu58xEs6SHer/RJctCx2jTcxxEnMSw7SaTu9WZu+n6EInGrwPG6AGDFEyeQ+mo9AeK80LaHTwAMlT6CkIWgT4QdAViSbZtSbQbRv/aM8ugCnw8v3jGSLXi0hvlUhGsS0YeHYRvum+JZtZ6SpDD4SQWKOQlzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xe9qd9bb; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xe9qd9bb"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42138eadf64so34748445e9.3
        for <git@vger.kernel.org>; Wed, 05 Jun 2024 06:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717592816; x=1718197616; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kdZdMVMnubSoLxfZlp0GUBhZLdL7XMe814kK1jY0zyc=;
        b=Xe9qd9bb0t7GWQFaqxbVndt7KkoHJ01DYwUpYH0oa1bOUUwLKPxyVEDHcBSVcUCAJC
         DTJsGx4TEdHUL4H1cifrprT+LEf8GNqPFWo5QGM5B7YC8F8lrI7lgpm9fPsnlEJviWla
         Noq0wS2CNPGVhz1MRLlfd73BUci3SfVjvdnozTeeObMUnazu3JM3dX4yXBaO2mDNj/jV
         ZUHOr9tBStp0S8VxzmnOjpVxEPxeV7PrjQz3K3vWltUG8fXd7xl59e2EXfgFJkYpBOjC
         Bi1k0qfTLt6PtZr4mX1Jlxn/LbAy6N/AQ/o4opscIryD7but3G7U1pramco1WaRbgjtl
         amYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717592816; x=1718197616;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kdZdMVMnubSoLxfZlp0GUBhZLdL7XMe814kK1jY0zyc=;
        b=h+Gqwn+LbqaX50lVvgrRonLLFd6Vb5eJdlm5Z3N4Pp9Zeh/HDS1m4D5FAiK5wuLpR/
         uLy7sk8nycBCI4YT3LHyr7YrwjOF012esm/usC7jw9bRasHLyeMtRv9o10zAz4SxRv88
         I4DxPO6fqJMNIzJYRf1svVnYLghVt2ASNUYriRrNCrcW+AdIS/EiEMrsP3FAS835EN1G
         G9skM4gTzi11UIBMAyNZaXWRfIALyDncLzjv0nNYXIRzWCGFG1uh4VX3H0J5l+nGLeoC
         zNpCjko0rN9XDoz23eby2mYWMTl16objGBvYo1coB+0HLuvEsh5PQoSl4Rqgg0J4gQ0w
         /XDg==
X-Gm-Message-State: AOJu0YxUK1LexP8OE5gUHQDAEIJJptJemvvdKRZk4qBz1jTwiuxeSxLA
	jg9OBIadnnT6o8I4Vnu/Hgfo6VwyXYhdv58hLQhT+NCnGXPqWQex
X-Google-Smtp-Source: AGHT+IEMfxveZHC/RXGPleOmita3UbRBCAkgXr0+heBJFEMdOFEprn/UsP1rHmkKkNUh784Yy7gS3Q==
X-Received: by 2002:adf:f9cd:0:b0:355:692:f663 with SMTP id ffacd0b85a97d-35e8ef65569mr1885974f8f.50.1717592816219;
        Wed, 05 Jun 2024 06:06:56 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:641:9001:d2c6:37ff:fef6:7b1? ([2a0a:ef40:641:9001:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-35dd04c090esm15254180f8f.6.2024.06.05.06.06.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 06:06:55 -0700 (PDT)
Message-ID: <d83f640e-2528-4326-bc46-d2b99f83a153@gmail.com>
Date: Wed, 5 Jun 2024 14:06:55 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 24/27] builtin/rebase: do not assign default backend to
 non-constant field
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
 Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
References: <cover.1716983704.git.ps@pks.im> <cover.1717504517.git.ps@pks.im>
 <e19457d20c80f9ce332f2d890a5089972e28f0cf.1717504517.git.ps@pks.im>
 <be8a315a-3fa7-40d3-80e1-6a5c01afee70@gmail.com> <Zl_6anUl_C3W2j2Z@tanuki>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <Zl_6anUl_C3W2j2Z@tanuki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/06/2024 06:40, Patrick Steinhardt wrote:
> On Tue, Jun 04, 2024 at 03:06:38PM +0100, Phillip Wood wrote:

> Do we have any other cases where we allocate inside of a `_INIT` style
> macro? If so, I'd go with that precedence and just allocate inside of
> the macro. But if we don't, then I think I'm leaning more towards the
> way I did it in this patch.

I recently added an allocation to REPLAY_OPTS_INIT, I'm not sure if 
there are any others. In general code that does

	struct foo = FOO_INIT;

and does not call

	foo_release();

is asking for trouble so I don't feel that allocations in _INIT macros 
are generally a problem. The only reason not to have allocations in an 
_INIT macro is if it might be used to initialize a file scope or global 
variable but that's not the case here.

> Happy to be convinced otherwise, I don't really feel all that strongly
> about this. I'm merely aiming for the interface wth least surprises.

I'm not that fussed either, but I do prefer our _INIT macros over 
_init() functions as I think they're nicer to use and easier to write 
(no need to worry about memset() to zero out the struct).

Best Wishes

Phillip

