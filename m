Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DB051F453
	for <e@80x24.org>; Thu, 18 Oct 2018 01:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbeJRJvj (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 05:51:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36742 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbeJRJvj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 05:51:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id y16so31771564wrw.3
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 18:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=la++EzlJEwmo/80ArgFOFKcxo/vaxZUkvzMFCGajJFQ=;
        b=NTZR1y1x9zp5nGkOHGGeFVp/qUy1ctUI4zILxPRKaEo8CrxGpbgaDdKpQnVwcSddof
         9T99giK8NawZZoGlAndpKaKbsKPBc96UR7Mpx4XLnZfA6I6ZpWad0wZqhXeo5j3RsN8n
         7QMt/XIAJQVg2cMCIVW3SctRCRfZSP2SXD4DKvKkV9S34XWV8e4W3UvbJ8vG6Fwodj2w
         JCgXy1bOD+/tk8agsQt0klF2y6vya18vJxSjTRxMusYf3VoUHpSbIcgtW0GRhGZFuKsA
         /VhLLSodfFTMGKhf0SKtXwe6pt+G1ODvPQ84gH2x4+jphu6mLcYPhARUUMAF81rUOCFt
         QEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=la++EzlJEwmo/80ArgFOFKcxo/vaxZUkvzMFCGajJFQ=;
        b=U8gCz51c616jxNN1DDUrxJxCMrn0JTPa4snImRcxruLEWWWxE/49fB/9L89Rb39Cg4
         Tt8hogQGQELd+vdWQNtho0Ftc0jYLu+TLpF2DxrgHS6utHbXVdNJp2GmJgts3Nv6TOjp
         YKZaDkY2VYWIXqVbKbW7bFXdIRYhEPr7+oIDCJO4GoEccjOXnhWGE7tS6Oz8a2N2lgBW
         hAXQfdcBh0Lq25rnK7LB90wLSx+9ElwIFCvBbgtAH5wYHDUTkxzkL2LbTZnw8CR6JPhY
         35RXHuNt5GOHk9a2KTTseWFOuZkfwJBGKds7LtwFnG9ggpNaPyQslXBLO5BrjE1BHpA1
         T/ew==
X-Gm-Message-State: ABuFfogYyLTLENEpo88HNYfuBQ6TKG9Yh07/n91SLe9YVO6QJtzErQ0o
        tPBjjMN1Cwvj8H+yzeZN0K4=
X-Google-Smtp-Source: ACcGV62hb3TzgMphb0bw3KVAmf7pfWn3+hg1IW4uR6kpnZEh8rI+ONE1owzvcJqdGukWV1sghSAf0A==
X-Received: by 2002:adf:f7c1:: with SMTP id a1-v6mr24477729wrq.152.1539827585926;
        Wed, 17 Oct 2018 18:53:05 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e133-v6sm2266539wma.42.2018.10.17.18.53.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 18:53:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Brendan Forster via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Brendan Forster <github@brendanforster.com>
Subject: Re: [PATCH 2/3] http: add support for disabling SSL revocation checks in cURL
References: <pull.46.git.gitgitgadget@gmail.com>
        <764791d13d20478639402e7af95e901223444240.1539598481.git.gitgitgadget@gmail.com>
        <xmqq1s8q34g2.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1810161225310.4546@tvgsbejvaqbjf.bet>
Date:   Thu, 18 Oct 2018 10:53:03 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1810161225310.4546@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Tue, 16 Oct 2018 14:22:03 +0200
        (DST)")
Message-ID: <xmqq1s8oxbpc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> In any case, you can use "http.<url>.$variable" to say "I want the
>> http.$variable to be in effect but only when I am talking to <url>".
>> Does it make sense for this new variable, too?  That is, does it
>> benefit the users to be able to do something like this?
>> 
>>     [http] schannelCheckRevoke = no
>>     [http "https://microsoft.com/"] schannelCheckRevoke = yes
>> 
>> I am guessing that the answer is yes.
>
> Frankly, I do not know.  Does it hurt, though?

I did not and I do not think it would.  I was wondering if the
ability to be able to specify these per destination is something
very useful and deserves to be called out in the doc, together with
...

>> I guess the same comment applies to the previous step, but I suspect
>> that the code structure may not allow us to switch the SSL backend
>> so late in the game (e.g. "when talking to microsoft, use schannel,
>> but when talking to github, use openssl").

... this bit.

> Crucially, this fails. The short version is: this is good! Because it
> means that Git used the OpenSSL backend, as clearly intended.
>
> <skip if="uninterested in the details">
> Why does it fail?
> ...
> </skip>

So there may still be some polishing needed, but as long as people
are not using the "per destination" thing, the code is already good?
That is something we may want to document.

Thanks.
