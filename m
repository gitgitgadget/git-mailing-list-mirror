Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AD713D2B2
	for <git@vger.kernel.org>; Fri,  2 May 2025 14:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746196403; cv=none; b=IFEgiOqpgegyGIAkWyWwJ90O7AroZiUD8u9bTfg2hxX+2iXTUBPsOE0Jjs8jLEcbpF5iZ//QdvTgEyeZBenlf4GoNvLuUnvRCo83ESzbnyF/47Hmq1k/1csJEq5LK+DvTyDG4eNtnzw6bcFW1I/LHqmXYQtkkCyHUsmAa8Q7V+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746196403; c=relaxed/simple;
	bh=tsRcwBUctX9bHjKuGnXQsIwRckaUc7U0jLN4spHDH80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YScITya6d/CAfUQT1/lRPaKmthcowiUJpbGdcMNPaUkz61fuUSWhGiIArG/fph1GIq6gY7yXBDmgtmYqZBCHJB6k2bWG4rDTEY8M03wNMrRxt3Xg8X7epVdhPITUx5fc3VpKGMEh9yIIgonNL6IyX1B/pyfkLvCcUWQKFAF+zTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2z6lyHO; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2z6lyHO"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so12394205e9.1
        for <git@vger.kernel.org>; Fri, 02 May 2025 07:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746196400; x=1746801200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZapfeB3RXisc5U8irdPYwWisNk8JjqK7ZFNs2QANDgw=;
        b=d2z6lyHOusv64tv+HPriJy19GvuL8kBaptE3Q2bxHRoIbgb7lb7dMFtSl91/YX3MiS
         deyP+/kHpXFEtsUL6w5To/pl1kYEBcsh3Y1DfOYCZ4DFgc1219YEZHdOjm6xVPmlLGrD
         zINFh8HRbvWqbThHaiEsQ0AYU5NW2u+VZiZp16wcNSGD6nr3GBRcWjumO1Wjl5GhP0ua
         BNaOneEh7xpODaLwfbxpuSdbWcGbldz8PfQEpY9TAQJR4Xk7MIAtiMscvDU5Y7owdn97
         F3HZYElMhusFUKM91vW/f+ZHeiJ7CEOCeFYEZ6HOF2Ifg3szBfadDcJIAJPijgweEwSm
         nyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746196400; x=1746801200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZapfeB3RXisc5U8irdPYwWisNk8JjqK7ZFNs2QANDgw=;
        b=rp2pc1GORqI71SGgGCMU5mvaVUz7BFl5P/CvZ/6XPmWrTlQ9Pjop2Tr0J7R9G04BsH
         MtlPk1opjtyRjxnleGwYmyELtWtB2S8f1sYLiBAfMcWg7Q6MlUZWuLgZGIJB3xS1dg9T
         98T1paE1360xaNIKtpqWCFuCvApNiavHPzo75xs8H4V3jtvcTvpBD3o4zWPP24Vim2or
         duOTLIgz3L5pW1CMyYG7kehn6sjX+HA6eYMly7clna2nkFQXXstUYywVL6n79plpSzw5
         UjpmMYPSEMF8lGuuQjlxvXc4dp2SH4w4LQmy0ARQmXaS+X2BEMYauuv/CQ367Ys7RNht
         FlJg==
X-Gm-Message-State: AOJu0Yxg/o5ZNMA3o/H4VfNJg7Cbh8yI9Ggzfx8hbiwdBQ/GRu23GlHp
	EJtrQUna4zz5D5xIb1AWDm4L1znvV3lr8iB8qCI0apdnd/Cfr6Jm
X-Gm-Gg: ASbGnctzSFEMe8hv25MsZbfBvNHYzh4dyKuIaL6GhffgMLpDjMPmWBcCR1OcGcdnMup
	/X+KhhXbG0hwoKpjbR5Fr5AL3p5y/s8viZw1V7WugfeXWZ9IWRFGkBpZQ9isTSvldK5w7SDwZXH
	tCPdLrKJG8FyvVzfWO3U1CjSrubvFVr0B0TGnFTE3wC2d9JUv8G0QSvs+z5GzQRmGPkjl2yeSrs
	iSAo/kcCIthwIhjfSeTnWHeWwuL4FwIZ7mMM+QEyxqzVNCfkXgBoJyCFBtrloWPSBpRtmAmqEgl
	BAo3N5YvOlJwD381uhoAgDwHQrPQub7mhlOI29Nc5j0uI94XuWuwQIV2kPdRAcM1jV7zmtZwGAN
	m8AFrxoETODDNnUC/
X-Google-Smtp-Source: AGHT+IHwIcR3P2oTbNBhtBmiRsUYuABz+2KCQl95j0j+bzeZciX6cOx3BUVH/X+IwT9M3ZvrhlkSwg==
X-Received: by 2002:a05:600c:8711:b0:439:5f04:4f8d with SMTP id 5b1f17b1804b1-441bb88d42emr25762375e9.12.1746196399556;
        Fri, 02 May 2025 07:33:19 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2aecb60sm91624335e9.11.2025.05.02.07.33.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 07:33:19 -0700 (PDT)
Message-ID: <3e38b7b4-eb6e-4af5-a5f6-f0d7ca4d32d6@gmail.com>
Date: Fri, 2 May 2025 15:33:01 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Discussion for interactive --patch commands to get --unified
 support
To: Jeff King <peff@peff.net>, Leon Michalak <leonmichalak6@gmail.com>
Cc: git@vger.kernel.org
References: <CAP9jKjGb-Rcr=RLJEzeFdtrekYM+qmHy+1T1fykU3n9cV4GhGw@mail.gmail.com>
 <20250429220933.GC36727@coredump.intra.peff.net>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250429220933.GC36727@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Leon and Jeff

On 29/04/2025 23:09, Jeff King wrote:
> On Tue, Apr 29, 2025 at 10:16:15AM +0100, Leon Michalak wrote:
> 
>> - make `diff.context` setting extend to the interactive patch commands
>> (not sure how a change like this would be welcomed considering it
>> could change users command outputs seemingly out of nowhere)
>> - add an `interactive.context` setting that would work like the
>> existing `diff.context` setting but apply only to the interactive
>> patch commands
> 
> In my opinion it would be fine to respect diff.context (and probably
> diff.interhunkcontext[1]) by default. Though it does change the command
> output, the interactive output is by definition user-facing, so we
> shouldn't be breaking scripts. And we already respect other porcelain
> level config like colorizing.

I think that would be a good place to start and would be a useful 
improvement on the status quo. To implement it one can copy what we do 
to respect diff.algorithm. I'm not sure it is worth the effort to 
support `git add -p -U <context>`. Being able to interactively change 
the context as suggested elsewhere sounds more interesting to me but it 
would be more work to implement as we'd have to regenerate the diff each 
time.

Best Wishes

Phillip

> I think the only reason we don't already do so is that the interactive
> code is built around the plumbing commands, which conservatively avoid
> various config options. So the calling code has to explicitly check the
> config itself.
> 
> -Peff
> 
> [1] Looking at git_diff_ui_config(), which are all the options read by
>      porcelain git-diff but not by plumbing git-diff-files, etc, there
>      may be other config in the same boat. E.g., I'd guess that people
>      with diff.colormoved set would appreciate seeing that effect in the
>      colorized versions we show. But I think it is OK to just consider
>      diff.context for now, and see if anybody ever cares enough about
>      other options to look into them.
> 

