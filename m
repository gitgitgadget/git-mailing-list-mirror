Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E314A1F424
	for <e@80x24.org>; Mon,  9 Apr 2018 09:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752188AbeDIJg7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 05:36:59 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:38047 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751630AbeDIJg6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 05:36:58 -0400
Received: by mail-wr0-f181.google.com with SMTP id m13so8772657wrj.5
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 02:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=STufcPP9g11M+bOAWLPqWPYZkQbC8PGA31smT2oeZ6o=;
        b=qI5Qix+SgVZmEOIxFJynTvN2OsvX16XtMW1fqK+92yiAV2eDm6XjawCJySicRGD7Xy
         EM15XY29/1pTLF0hy3/80kiSAqsKnwFch6Rv10/t2ThUGA3jKkH9F8WUkVavCnGtnLmg
         T/OmjxodR8LHamgnQ/MxQ2MV+/KReWfCvYcPC+GimfaULlkpXOmv8b0yGPSGHNPaeyl0
         KH7CHmFz+O5ZIfJ3EuiYhBL2uq25Y0LJwzbIvSOhz8gV7PF9TTV4iGTD5W6oCb+dSUqx
         V0Cyj3tWw+UMfo1u6VluZ1hPI18rw+g6zwyz4CMTCfwdQzTIauCHz5vhRbsEIKfs7ynf
         DniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=STufcPP9g11M+bOAWLPqWPYZkQbC8PGA31smT2oeZ6o=;
        b=tcvlhsQrS/QqpzwjDCF9FjkoKvPMxKxQXH0aiJRXgrz4taHepqfilS3Ot1NVdGGza/
         vHTh+ZBQbRdEdbs9u8/W5cqu3tVZzSRLVTSqkDgRiiocfJY1t/zCt4El99vLhT23121e
         RPiD6p2A3uQWtcd8ysamM4ENTePSeOOv1yO5QbX1iK6va9xWJUhAz7AN+jS0HWL9+/TW
         j7XwktCohBKHECkvy2///VrgzEi3UZyndQcOfaOIbLcOlXni7sErxTLZ7lsPPkXu8rJX
         EQ82FODAbL1rKPJeLjPNF+hMb5crdQM1v9ObSBtcuIJy+Z7L4h4/66GtvqWzYd7LIwd2
         P7LA==
X-Gm-Message-State: AElRT7HNA3iCT24zWoMFOpGmF53ErZrABsQoIzayCeawM8ApeXouDR61
        Uh/WjFMyfl8e5qtb/jg4F0MBaQSh
X-Google-Smtp-Source: AIpwx4/TLLb8eSXSHWw88W2botl21jVtf9w8VKRCEDqbj1O9P5Xi+L67ptxJvwrbJnTVzfWA2IuYeQ==
X-Received: by 10.223.153.114 with SMTP id x105mr24884925wrb.108.1523266616675;
        Mon, 09 Apr 2018 02:36:56 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s65sm308860wms.26.2018.04.09.02.36.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Apr 2018 02:36:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Florian =?utf-8?Q?Gamb=C3=B6ck?= <mail@floga.de>
Cc:     git@vger.kernel.org,
        Szeder =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [RFC PATCH 1/1] completion: load completion file for external subcommand
References: <20180409072909.GA30684@arbeitsviech>
Date:   Mon, 09 Apr 2018 18:36:55 +0900
In-Reply-To: <20180409072909.GA30684@arbeitsviech> ("Florian =?utf-8?Q?Gam?=
 =?utf-8?Q?b=C3=B6ck=22's?=
        message of "Mon, 9 Apr 2018 09:29:09 +0200")
Message-ID: <xmqqlgdw67rc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Florian Gamböck <mail@floga.de> writes:

> Good point. I could go even further and ditch the if-construct:
>
>    ! declare -f $completion_func && declare -f __load_completion &&
>        __load_completion "git-$command"

I personally find that a lot harder to read than if/then/fi.
