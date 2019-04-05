Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3C1420248
	for <e@80x24.org>; Fri,  5 Apr 2019 05:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbfDEFoZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 01:44:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41534 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfDEFoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 01:44:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id r4so6421619wrq.8
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 22:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PXey7Dt6q7WKIYcOxx0GbKYVrxjyOGPItJPP4X0IFJ8=;
        b=SDcvj/tWswZ1XlTOHEClZM49iD3OQSDGTt6xJa3GwCGHVsRdgfM9wC7E0qgkw723y/
         qFK2Po6ww3mq1UVeLCkMuPStZCoOdPDr2gd0kV4VmoA5agH7XuPBtA8+tnvVzF51aq3w
         mbbs85fD2kLfgyLcfU52sSyqVcR2HBbyC5ndqskfQ6v5AQJjPVvEF7ZO+Et/uAfSwxpL
         FF3qllDaPpWKizaTVLk7/EAB/PudQS1jhsGa8UAJaYORVYitDI4A7vgTh3AXCBydKkUI
         9PeMcBVxoSr5cuWFKFc9UcZH0ndPOnfrwzpOkz8kGuqdP/g4xIJaRu13qOOnyw1zOcbP
         9j9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PXey7Dt6q7WKIYcOxx0GbKYVrxjyOGPItJPP4X0IFJ8=;
        b=B6E5J6vZRSz5p5XvD2HpxpRQwk2tS5CzbTLRkFfBpiIxcWTEkrBCL/ShGLiEJFTcna
         uZZXT/fFN8LGMGN7krz+QMZSFi7otIoevpIoHOAYV81Fn63vI71OSstpQVRwHTXhHLp0
         t4IZ4P42k85yC6mKm7M6WAUvuz/MHB76lAtQi8DbF0CZvtXO44hP70D85uknk4UlcvR+
         RXc1vxSm9SN+KjYTl0/MoEGb9CBMWsKTYC/BYDK6W8FWt7SnEuHp7hFMOPcH6tXj/cxW
         bH8IINby+Dml2VxADtcbTZcHU+sc83bDe1MksWwMIOVxnLMAKCYHQkGAhgMDFi2GfJfn
         Vhiw==
X-Gm-Message-State: APjAAAUAFrAHzdcxbpiOvLJii5X69/qQx16Mbnvgv+NPigc9Jd4eEy7X
        fODeUbb3FlZcVYTFNlG8XA0=
X-Google-Smtp-Source: APXvYqzTw4YzpPsJqLqbwT9PcRMMVRBHx81erumS0D3VgPDtF21wDRu6k+MJ4AbtPl50qXCfqv9kZA==
X-Received: by 2002:adf:f10c:: with SMTP id r12mr6716514wro.216.1554443063739;
        Thu, 04 Apr 2019 22:44:23 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id y125sm2284600wmc.39.2019.04.04.22.44.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 22:44:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] promisor-remote.h: fix an 'hdr-check' warning
References: <0830dd3a-551e-8d74-18cf-288ef05ec287@ramsayjones.plus.com>
        <CAP8UFD267N_zaomOD_-_1YnyKpGu7jDuEjyRW0sc3Y6Wjo2xRA@mail.gmail.com>
Date:   Fri, 05 Apr 2019 14:44:22 +0900
In-Reply-To: <CAP8UFD267N_zaomOD_-_1YnyKpGu7jDuEjyRW0sc3Y6Wjo2xRA@mail.gmail.com>
        (Christian Couder's message of "Thu, 4 Apr 2019 23:55:06 +0200")
Message-ID: <xmqqtvfdc8g9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Hi Ramsay,
>
> On Thu, Apr 4, 2019 at 8:59 PM Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
>
>> If you need to re-roll your 'cc/multi-promisor' branch, could you
>> please squash this into the relevant patch (commit e52d417b57
>> ("promisor-remote: implement promisor_remote_get_direct()", 2019-04-01)).
>>
>> [I had a deja-vu moment writing this - it seems I sent a very
>> similar mail about 3 weeks ago. ;-) ]
>
> Yeah, sorry. I don't know why but I failed to notice your previous
> email about this.
>
> I have integrated the change you suggest in my patch series so it
> should be in the next version.
>
> Thanks again,
> Christian.

Thanks, both.
