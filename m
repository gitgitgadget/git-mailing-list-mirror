Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE3A11F404
	for <e@80x24.org>; Mon, 12 Feb 2018 21:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753260AbeBLVMV (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 16:12:21 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37457 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751441AbeBLVMU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 16:12:20 -0500
Received: by mail-wr0-f193.google.com with SMTP id k32so10120840wrk.4
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 13:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FSEK4fZWJ2npYY+V06QkVQ8MmCvOtT2ZXnwPDtEChV4=;
        b=bN80InFXib5lZX06BL/7w4KOj0mkF3uQoR8hG/Kd8l0p4938OFhmjLiwcE73W51d1K
         hmShsZINFLETEqBdeGbIGl5qN/e7PhKq9mFfw1NGg9M2gXR12H33Q6grgYprTSt8EVCi
         Uh+SFASheNtzn9vdcZov9/oBx2efh+7nrvXfuH0W4H8+UiqVK2F0GPhm0WtiWPxZCE5e
         TrEq23+/BvVXI2o92OHGL+5+ZKvt5hVqrrAcUnTXXDb8ixczflLyXPnRpw6jmSPM3+Ta
         SVTnLxOiIaYYzhcJPYTmf0d++WFN19/Ist3vTsp3uZFULOjNO622nahtV6xPFGKjuGWw
         zCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FSEK4fZWJ2npYY+V06QkVQ8MmCvOtT2ZXnwPDtEChV4=;
        b=jDCYPWs/9p/I5ByHhSBrwK/tlXrU7CXboJDAh0fd3DcWdaKeCxAosmzIkgx+9kTIjN
         WziiN97HdoX+Z3o97vW3IknBjmaBtmUd9tdIyJtXeyHacMLUnbBSFTiWSFdN4/HKsELq
         bIM+8caYIxCUh5sOxvOsgSQYiMYIBVAT01/2whyz7EeerRZeSdhq6tCBCH0e122TFtKM
         ogiItNJdDPdwq2bILXnVTCy9oIPOPvMO6F9jZb5pcWRT4A8ij3wjkub5k+sebSRtB/hx
         qS4SeBKzxh3Hd5fypRdFvwqusfIqiR02Pp9ynukDbYXM7yDG8gefPhJ5jB0+AMZHasLJ
         HgVA==
X-Gm-Message-State: APf1xPAvziusRjGWf1igQ1p61jR1oSmVQORWghFwxbl+FYh7nOrRVd4a
        dWMzKM8Wd9dykRkK38SnrN2av845
X-Google-Smtp-Source: AH8x225/Vy7PcB5n+WGo4yjFF/adi58WtRaDxvMMqU8uT6wfa85PzjGXBkYNPhkjkr4703cgL4nkPQ==
X-Received: by 10.223.174.176 with SMTP id y45mr11337266wrc.111.1518469939246;
        Mon, 12 Feb 2018 13:12:19 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r70sm6007297wmg.30.2018.02.12.13.12.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 13:12:18 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] t5556: replace test_i18ngrep with a simple grep
References: <d0e6c6cf-7166-bef6-f179-c4e6acf7b0ac@ramsayjones.plus.com>
        <xmqq3726t11d.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 12 Feb 2018 13:12:17 -0800
In-Reply-To: <xmqq3726t11d.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 12 Feb 2018 12:18:06 -0800")
Message-ID: <xmqqo9ktsyj2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> -	test_i18ngrep -E '^(fatal|warning):' <error | grep -v 'hung up' >actual | sort &&
>> +	grep -E '^(fatal|warning):' <error | grep -v 'hung up' >actual &&
>>  	test_i18ncmp expected actual
>
> OK, but not quite OK.
>
> Two grep invocations will not leave anything useful in 'actual'
> under poison build, and is almost guaranteed that 'expected' would
> not match, but that is perfectly OK because the final comparison is
> done.

Sorry.  s/is done./is done with i18ncmp./ is what I wanted to say.
