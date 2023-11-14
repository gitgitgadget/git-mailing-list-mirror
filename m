Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDDA26AED
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 21:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eBsl8Ee6"
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A1FDA
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 13:30:00 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc3216b2a1so47869475ad.2
        for <git@vger.kernel.org>; Tue, 14 Nov 2023 13:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699997400; x=1700602200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DugXsvtusfS6e19BH/yf1C8eYw3jsy8yO52j/F1GSbQ=;
        b=eBsl8Ee6QVrxD/fmW2RNGj6jDJl1NCW9ajOC0YTj/xt/lYdTA4TXFXX4W2tEGNvov/
         ywIQb/cCE2QTlHiGMx5ewBQAml3iC6J9VB922eafnxiVf5yku3UOlJHcTZbRohCIsi4T
         Hmd0no8u6LLLlaZy8SfoYjuhJgp/cl4AGHvw3KodVYp7TUtfIsSGQzRSLXPpgarjBL7x
         N0lRv6m+ciK7TS0I80ilaUlCRsmyhyf9maO0lynrWplNBH5+heqkslKxvDQYHL70z4FJ
         fHBOnzB4P+TrJODNGFdI1azLfVgKu0ae1BDjOZmtqOyuV90PzO3vZ8vxc1FOYVOApw7R
         YNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699997400; x=1700602200;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DugXsvtusfS6e19BH/yf1C8eYw3jsy8yO52j/F1GSbQ=;
        b=iqGoAN6cOUNs+QcOi+DwqW66a67vSKfbmmEiuYGvlKxVqGguBVI7yE1CC+ovM/QJKa
         vJGD3DAy5SVokD45fPpSqKecfhV4DcJh2X1Y64SQKolqQovnrwr3224S2baIuF6VhMmQ
         sR1ZL+LIumJl0KkPZhSSZny9Rl1/uLStqtt3WVIpmaL5oUXKSAwJNtcA4hBqF/OYyinl
         20pkAVfvrfRNy+VugJdajYa6o8dN2RESl4MfKrnp+6V8FgCa1k9ciaeXY+JDDfe2z94o
         mZA2iLUi8LeuAJF9E9OAOCt6zHg6UjXwoS3yRxFYaLU+cPrWWHWj63Cq8kj7AMQEPGvk
         Ms0A==
X-Gm-Message-State: AOJu0Yw5GiT5SJD6vUYZ2k7N4drUzpAcPg8iKYaHVtDM/1j5rcUwMwib
	zDr1JrpXPWBUOkAVCAPxvax8BaH4R6z7mzR0Bw4SpA==
X-Google-Smtp-Source: AGHT+IHhGZ42ZBzNYu4cgVqYctX+VgbJ5O2Uhi0nvnrq2xoUQ1HvwsHHiSO9alfA1SU6Zh26tAeYGA==
X-Received: by 2002:a17:902:9343:b0:1cc:6597:f42c with SMTP id g3-20020a170902934300b001cc6597f42cmr3012006plp.21.1699997399751;
        Tue, 14 Nov 2023 13:29:59 -0800 (PST)
Received: from google.com ([2620:15c:2d3:204:39f3:c416:fb5a:11b0])
        by smtp.gmail.com with ESMTPSA id iy6-20020a170903130600b001b016313b1dsm6131037plb.86.2023.11.14.13.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 13:29:59 -0800 (PST)
Date: Tue, 14 Nov 2023 13:29:54 -0800
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: avoid running the test suite _twice_
Message-ID: <ZVPm0qn6XsbLL8eM@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1613.git.1699894837844.gitgitgadget@gmail.com>
 <20231113184909.GB3838361@coredump.intra.peff.net>
 <xmqq4jhp438y.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4jhp438y.fsf@gitster.g>

On 2023.11.14 08:55, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > I do have to wonder, though, as somebody who did not follow the
> > unit-test topic closely: why are the unit tests totally separate from
> > the rest of the suite? I would think we'd want them run from one or more
> > t/t*.sh scripts. That would make bugs like this impossible, but also:
> >
> >   1. They'd be run via "make test", so developers don't have to remember
> >      to run them separately.
> >
> >   2. They can be run in parallel with all of the other tests when using
> >      "prove -j", etc.
> 
> Very good points.  Josh?

In short, the last time I tried to add something to CI, it was not well
received, so I've been perhaps overly cautious in keeping the unit-tests
well-separated from other targets. But I can send a follow-up patch to
fold them into `make test`. Or would you prefer that I send a v11 of
js/doc-unit-tests instead?
