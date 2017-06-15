Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 361DB20D0C
	for <e@80x24.org>; Thu, 15 Jun 2017 16:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751757AbdFOQsp (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 12:48:45 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:32934 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751459AbdFOQsn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 12:48:43 -0400
Received: by mail-pg0-f67.google.com with SMTP id a70so2259124pge.0
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 09:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=E3ntoASbG4muwYtERlx0sqtWwhrnxDrTLh357OX92DA=;
        b=ZFtFDZhEocjMWIWapgaHPuoyMC21sEwojuwB9dUuRo5re/d2NK3VdPNIqYFPvHcUN8
         nDfhj0RIMlBKGYSlT6n4rD+FfZYjruA2u+D0riDyeU488FmdEBqRxDosKx9gM0Ec4zkF
         1wcSDqpranQ+82vDkMOQI81hvC8ukcEy+mrUuWF01+ERFTf33ROA3TDL+MXmgu+x+eXq
         bwl1oKnPCZZ8m3lH2OTgix5Y8lnFs1nzeltXQeDXbLXLgMXJYSGTYjye4t2IMazF+U+F
         5PEFM3C5ogjQJ8Yo3SztJiIYPK9KJHfB6LcTotwWKQxoUFrkklQPVBMb7MjxdvqfmJt9
         dcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=E3ntoASbG4muwYtERlx0sqtWwhrnxDrTLh357OX92DA=;
        b=UyPBJ/1olQQQVpNaqTRjFNJugAbT+8KWBEfPfIVGkUIAw4OWu0f/GngnruRuTmQ2Qc
         Qot4Bor29Ql/TvCFL2evayDzW3wGqco4EA5zhK25zrreV421j0yfd+ElSNfw7mlaqkwO
         hzIDLYJA3Pr1t5qcZg2u3FSKrSCHqH5fq1i7gXexVxCL/17p1vy4gEi/fEIMvHmVOYJV
         RmRzth34nwz+ZmHCYe+9ArnBy0o7JG1EeTYyR1+usIa2M4eqkU0rbar69vNwG51GkE4C
         S0FipJ6ift84G8qaq1MCknZqOsvIxm72QU85MxmpXht3Jsez4GtbNooe/3dtgmL7yWig
         QF8w==
X-Gm-Message-State: AKS2vOy9arwQApx7wUnm7QCLupCwHEJZWBbygSS3dnqEBKRrr3YjV6wr
        3kdVvY5EX7D/lQ==
X-Received: by 10.84.134.34 with SMTP id 31mr7427110plg.51.1497545323058;
        Thu, 15 Jun 2017 09:48:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:88c8:4433:c52b:12d7])
        by smtp.gmail.com with ESMTPSA id t11sm1753548pfl.3.2017.06.15.09.48.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 15 Jun 2017 09:48:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v2 1/2] git-compat-util: add a FREEZ() wrapper around free(ptr); ptr = NULL
References: <20170609085346.19974-1-avarab@gmail.com>
        <20170609220420.4910-2-avarab@gmail.com>
        <20170609222738.GF21733@aiede.mtv.corp.google.com>
        <20170609233701.GA7195@whir>
        <xmqq60g462nd.fsf@gitster.mtv.corp.google.com>
        <20170610032143.GA7880@starla>
        <20170610072506.embaavscstmjnv6v@sigill.intra.peff.net>
Date:   Thu, 15 Jun 2017 09:48:41 -0700
In-Reply-To: <20170610072506.embaavscstmjnv6v@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 10 Jun 2017 03:25:06 -0400")
Message-ID: <xmqqfuf12o46.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sat, Jun 10, 2017 at 03:21:43AM +0000, Eric Wong wrote:
>
>> > So make Jonathan's freez_impl a public API and rename it to
>> > free_and_null(), perhaps?
>> 
>> Perhaps...  I think it needs to take "void *" to avoid warnings:
>> 
>> 	static inline void free_and_null(void *ptrptr)
>> 	{
>> 		void **tmp = ptrptr;
>> 
>> 		free(*tmp);
>> 		*tmp = NULL;
>> 	}
>
> That unfortunately makes it very easy to get it wrong in the callers.
> Both:
>
>   free_and_null(&p);
>
> and
>
>   free_and_null(p);
>
> would be accepted by the compiler, but one of them causes undefined
> behavior.
>
> Unfortunately using "void **" in the declaration doesn't work, because
> C's implicit casting rules don't apply to pointer-to-pointer types.

All true.  

I still think the macro FREEZ() is too confusing a name to live;
perhaps we can take Ævar's patch with s/FREEZ/FREE_AND_NULL/ and be
done with it?  By spelling it in all caps, readers will know that
there is something special going on in that macro, and Eric's
"forcing the readers to type & in front to let them be aware that
the ptr variable is being manipulated" may become less necessary.

