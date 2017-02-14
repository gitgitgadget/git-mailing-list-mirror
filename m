Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 031EE1FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 21:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751752AbdBNV3t (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 16:29:49 -0500
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33661 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751987AbdBNV3t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 16:29:49 -0500
Received: by mail-lf0-f54.google.com with SMTP id x1so72602860lff.0
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 13:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XDynonvudU/fjJ5TOvEFa9T/GF0MOp3cqJD5t9VnKO4=;
        b=VG60RhiDKGMZ8K6UI3dpsosS3/UPWKMKnPXkTuLeQashstTqoxbyL715oXvxG5e9+f
         nn7OXTdVh6IfDn0/8xGPVtua1lfDd6GFVVO7gIhcqEA6KsixP/+dFSn/223yANms2V0V
         qZuB2R7Q8uAd/egJmgL+2XqGDKzr2JgC6PB0cKqZz99BDUuf2rKyP7x8B42n36Xpkgus
         46f1woBM+019bz7Oef3ZAP7kdziXpW6Fy4sWyzcO5YfQsPUF3tKE/3j502asWjd17lOV
         gHJkpuG8ibbYft2/cLzeD7wwy7JJAAevJwsv2ukfGaWf8gNc4wka0LbTfB1IMMDdr37Z
         fJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XDynonvudU/fjJ5TOvEFa9T/GF0MOp3cqJD5t9VnKO4=;
        b=dTJs/BnGWztthM97V+l8Bnm1gHSp3n0tqWr7PhXrZWa/MSSrcwYIAlO/sHPOiHQ7oP
         SQxH6iiwrcdPrlpQnTEbFY9r+q/PR4fCOzhZf5uW5x+vl/h3mOFWVATDSD4aXSmf1XKa
         YKNDdScYwvy4rsrS9Qa4ljZ/5vzkfgg/mSW5a5+QtGoKxMtNIhEApbXr+zMxumrxIYyK
         jZ8oa9KQelFHf6SKvjP5MQEfHfydbp+A0sqb5HdulbnP/7d04KizgVQyWjOUE/BMxboX
         pr+xiA0tyOS0le102pTjFEovBa4Us6l8RuFZUDDyaoaIpXIPGH49YplpCixz/GY5SgFi
         7sVA==
X-Gm-Message-State: AMke39ndiifHfzUz/ri7NMIuold0elwllczGHEC+8ZIrtNDy/ndkmhrNev8Uz1Cja9hsHCNo68ylmOU2+Jrk/g==
X-Received: by 10.25.67.83 with SMTP id m19mr8400133lfj.24.1487107787291; Tue,
 14 Feb 2017 13:29:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.199.13 with HTTP; Tue, 14 Feb 2017 13:29:46 -0800 (PST)
In-Reply-To: <20170214195513.7zae6x22advkrms6@sigill.intra.peff.net>
References: <20170214154816.12625-1-chriscool@tuxfamily.org>
 <20170214172526.hzpm3d3ubd3vjnzr@sigill.intra.peff.net> <xmqqlgt88t0r.fsf@gitster.mtv.corp.google.com>
 <20170214195513.7zae6x22advkrms6@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 14 Feb 2017 22:29:46 +0100
Message-ID: <CAP8UFD0EfUgfmTB4dj-A+rw79F7SWKxYvatNfR+Nj-8ukWYAQA@mail.gmail.com>
Subject: Re: [PATCH] show-branch: fix crash with long ref name
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2017 at 8:55 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Feb 14, 2017 at 11:35:48AM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
>> > This fixes the problem, but I think we can simplify it quite a bit by
>> > using resolve_refdup(). Here's the patch series I ended up with:
>> >
>> >   [1/3]: show-branch: drop head_len variable
>> >   [2/3]: show-branch: store resolved head in heap buffer
>> >   [3/3]: show-branch: use skip_prefix to drop magic numbers

Yeah, I noticed there were a number of things that could be improved
in the area, but I didn't want to spend too much time on this, so
thanks for this series.

>> Yes, the whole thing is my fault ;-) and I agree with what these
>> patches do.
>>
>> The second one lacks free(head) but I think that is OK; it is
>> something we allocate in cmd_*() and use pretty much thruout the
>> rest of the program.
>
> Yes, I actually tested the whole thing under ASAN (which was necessary
> to notice the problem), which complained about the leak. I don't mind
> adding a free(head), but there are a bunch of similar "leaks" in that
> function, so I didn't bother.

Yeah, I didn't bother either.

> I notice Christian's patch added a few tests. I don't know if we'd want
> to squash them in (I didn't mean to override his patch at all; I was
> about to send mine out when I noticed his, and I wondered if we wanted
> to combine the two efforts).

I think it would be nice to have at least one test. Feel free to
squash mine if you want.
