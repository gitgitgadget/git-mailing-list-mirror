Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 173901FA7B
	for <e@80x24.org>; Wed, 21 Jun 2017 10:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752684AbdFUKKy (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 06:10:54 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:33504 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbdFUKKx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 06:10:53 -0400
Received: by mail-lf0-f48.google.com with SMTP id m77so91410513lfe.0
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 03:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=dmLh3nOCBl7wSo/RCh/+tRFIVCWy1lsntmFeDKtSXGM=;
        b=rGClm2t+mopBp1cD6eJi6uTTojqFkISt6KVUOzh/MG3vmWlWsmbfhU9NXhhUweCgAv
         fm6gDT+chF4iYezJZ6DwNHG3yuGOeeScxrLSo4Q08SmEJA8alju891MXk4bmg6ce6itu
         aXc/GPIENjyT/CACDdKz2LmvYAOGt4pSMmWiU6FWt+oFjo/pE5eaW0tPsNEFWWzV4wTj
         mm47L/40yGyTgdiEbPUdgmc4pRSS2/OlbvHm0YTPbSpnctYTiExHVZwC3GwkJ86DBejI
         5CsSoVY7zt1fPRiAZ1MzWtfVOOqXWUzBwGQ5udnMkAhR9kdlMCcv24QGpAtwym8ebaz9
         WNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=dmLh3nOCBl7wSo/RCh/+tRFIVCWy1lsntmFeDKtSXGM=;
        b=iEOvYTpMLcNN8TgVbA1S7gpvG8yKok2IEM83TnutAdoGW818qCqU6TU9L1AaBsBsPU
         R93KOx4ZLmAILtC8zsDIlaFPEyNwb4xBzbxfDHwDd8GVaMc+glEoLSv2y6ljcDHN9t1K
         wNBGigotjlRe1cci2IwSg5C8zD1duOB186Jbek3nzh+x13oCABbYUHi8XomXtYOeu1of
         fkH7T4Fo97n/6MVTBT54sAGIBcT+awEoKBboadJQ5uCJ5KFZVkBFQRDRb5/GYbz6iWEl
         b0s8FFzRg1W5+JGssNrJogbKS59FlD9eC5aEBOnlfwg08QVC27A3fTYAXJuAMm2dsjyn
         3qzQ==
X-Gm-Message-State: AKS2vOyZ2YL259C+Waw+OYBZLJwhIJ71BxlQp2kfXvQMSmihMvfdhMG8
        xjgH8e2iqtjkagpsZFs=
X-Received: by 10.80.186.37 with SMTP id g34mr1743003edc.162.1498039851933;
        Wed, 21 Jun 2017 03:10:51 -0700 (PDT)
Received: from snth ([92.109.130.42])
        by smtp.gmail.com with ESMTPSA id y4sm9744771edc.40.2017.06.21.03.10.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Jun 2017 03:10:51 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dNcb4-0004l5-F4; Wed, 21 Jun 2017 12:10:50 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Simon Ruderich <simon@ruderich.org>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH] die routine: change recursion limit from 1 to 1024
References: <20170619220036.22656-1-avarab@gmail.com> <20170620155459.a6e7pypxx6vpdbvs@sigill.intra.peff.net> <87lgom8pew.fsf@gmail.com> <20170621081209.gfqqkselek4bqdjl@ruderich.org>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20170621081209.gfqqkselek4bqdjl@ruderich.org>
Date:   Wed, 21 Jun 2017 12:10:50 +0200
Message-ID: <87h8z98xcl.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 21 2017, Simon Ruderich jotted:

> On Tue, Jun 20, 2017 at 08:49:59PM +0200, Ævar Arnfjörð Bjarmason wrote:
>> If I understand you correctly this on top:
>>
>>     diff --git a/usage.c b/usage.c
>>     index 1c198d4882..f6d5af2bb4 100644
>>     --- a/usage.c
>>     +++ b/usage.c
>>     @@ -46,7 +46,19 @@ static int die_is_recursing_builtin(void)
>>      	static int dying;
>>      	static int recursion_limit = 1024;
>>
>>     -	return dying++ > recursion_limit;
>>     +	dying++;
>>     +
>>     +	if (!dying) {
>
> This will never trigger as dying was incremented two lines
> before. But I think it's already handled by the dying <
> recursion_limit case so we can just omit it.
>
>>     +		/* ok, normal */
>>     +		return 0;
>>     +	} else if (dying < recursion_limit) {
>>     +		/* only show the warning once */
>>     +		if (dying == 1)
>>     +			warning("die() called many times. Recursion error or racy threaded death!");
>>     +		return 0; /* don't bail yet */
>>     +	} else {
>>     +		return 1;
>>     +	}
>>      }
>
> Maybe restructure it like this:
>
>     dying++
>     if (dying > recursion_limit)
>         return 1;
>     if (dying == 1)
>         warning();
>     return 0;

Thanks, silly mistake. Will fix.

> Btw. is there a reason why recursion_limit is a static variable
> and not a constant/define?

Nope, will make it a const. Thanks.
