Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91FE19BB4
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 19:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="0p32BwSX"
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F67CA9
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 12:14:38 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5a90d6ab962so44438687b3.2
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 12:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698693277; x=1699298077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EMkNhKW7GeE9cWX1oziBATD35cODaL4zKB1t5LZxuJM=;
        b=0p32BwSXtgZSNoHL/8mH66lnmSOEHKmt1IgGjeSQPXCPuDsI3si9FFLZ81guE5dwvU
         YM8STW+E671eHGnAwAOKUBRniJZmv/mFv3jPa6Nd7l/1o0SEWfW19HqQLKa8QKbwK6r5
         K69U//JTe4Q/CZs4se6INjrAlGsAEegWOLEQScxwQgdPTzY6cZrssZPrYsx/th3speMH
         6EI4kL+ZZUBOqobnAtfEXxNLmpdzrMNaykkxYYvs5oiVmWqSVnjHkApvfa5oDAY5z242
         O3b5G+c18fqAYs6x0cNuhT+6cc3c0WKUNTgzNeb3su2R1PYXcd4v79MOZ5Io4Yqr4hTn
         qDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698693277; x=1699298077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMkNhKW7GeE9cWX1oziBATD35cODaL4zKB1t5LZxuJM=;
        b=ivpWZ+kBdLFAKs2iM4ZimbC0VoCFyUskQnd2/bVgYHnsTDCm+hTwIneAP1rYGsyNhQ
         /EfncU+4SAuO0+JhK3Wd/APv20RzuY30eDut4xW/KIeIU4cvlJiWdk9ZoHX3tnhVG/e7
         Vc4eTti1y0G3OTW5eoWBZ2i1VsiFbWG1g/8TG4Ura63bb/v3S0AXN1xX/tQ/7hQGI+Gm
         06Y122yi2tPQEIUU/gOyJmzP8SndnxRYqO2jdwfg/pJa/mbsiuN0mBLM4AxM+dh2+Cny
         ao0jZNSt8CMpATVIHIa+4Zjbu2DSGCo/kPgXQIZC6f8n3aSrYEbphy3DIq/g3GhRkMLG
         BzSA==
X-Gm-Message-State: AOJu0YwzhpK+IPswMO7KQd2VUpGna3kjtpOFG8EwwsCgl6rvTtdF8ESw
	Olu8Di6UOZ28QQRamMPWhNeRPliAQDTHpvl6IpYlDA==
X-Google-Smtp-Source: AGHT+IHwg3uSTjoURQANtPvRr1vM67y6wAL6sg/M0JpGF1uNFisUi7jwzaUii43mRrJEOVW41YsBHA==
X-Received: by 2002:a81:ae22:0:b0:5ad:7fc2:4787 with SMTP id m34-20020a81ae22000000b005ad7fc24787mr12797961ywh.15.1698693277663;
        Mon, 30 Oct 2023 12:14:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u143-20020a0deb95000000b0059f802fad40sm41860ywe.22.2023.10.30.12.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 12:14:37 -0700 (PDT)
Date: Mon, 30 Oct 2023 15:14:33 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 06/12] builtin/show-ref: stop using global variable to
 count matches
Message-ID: <ZUAAmY4aKGrvSDp8@nand.local>
References: <cover.1698152926.git.ps@pks.im>
 <cover.1698314128.git.ps@pks.im>
 <d52a5e8ced2adc5c9315edea9fc497d1ffa30125.1698314128.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d52a5e8ced2adc5c9315edea9fc497d1ffa30125.1698314128.git.ps@pks.im>

On Thu, Oct 26, 2023 at 11:56:42AM +0200, Patrick Steinhardt wrote:
> When passing patterns to git-show-ref(1) we're checking whether any
> reference matches -- if none does, we indicate this condition via an
> unsuccessful exit code.

s/does/do, but not a big enough deal to reroll IMHO.

> We're using a global variable to count these matches, which is required
> because the counter is getting incremented in a callback function. But
> now that we have the `struct show_ref_data` in place, we can get rid of
> the global variable and put the counter in there instead.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/show-ref.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Looks all good to me!

Thanks,
Taylor
