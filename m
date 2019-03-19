Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF69420248
	for <e@80x24.org>; Tue, 19 Mar 2019 00:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfCSAao (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 20:30:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37091 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfCSAao (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 20:30:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id y15so19069130wro.4
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 17:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uFXituQ06B12e2zWWynC3Nr2GEHQf7cmapGnjyt237Q=;
        b=TKQRoJ+DbXD1PO947IZgF7FvlunnQtkv6yUrWxQL59dBQORAJDkq80qEnv2mjRhTqW
         mwOrKn6nGF/lPztrU/EKbkAtlo3dpdA/rt7KMPdkuTgvpy/IH5gNLzMCFTTL0VEzwPST
         uE0D1FHa88wToOiv4RFTnaLs/9S3HWyRHOSC8MwgVf0r8lie1OZsFytLJt9NJdR85cpJ
         UnyDW2Cl1CgGt4aMOo4DkmgDbkUs1Xx7a/xCnXZcu9toFVdCs95WRMG3W3DIJr5krknv
         Abw5wVzHv3wDvtJBA8VygJVAlQ7zE3avDVhn7Oll/Pq23lWY2bh1auRbdg+aXLdYACbs
         imZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=uFXituQ06B12e2zWWynC3Nr2GEHQf7cmapGnjyt237Q=;
        b=MNjYvjKnMJ4+qkTwuK5gw1jDHJCj3TEnYyM5nxI2cA50u9clakimIJJeR90iM9N2we
         qylmzOinkTQ03iQrJsEU+vMKbKdM0sarM+l9YwNPjaMnCEkcOcPVOTBUKRamNEIW8WQA
         +c7fVxapUZTKkpOE9+CKcG/Heo6ojjMHYkCMDGRg2p81Tg4QSBwBv3WaAZWmDRf0lxJc
         pINLpDqkY6Dm/8fGvMZCNANkHuHjptiHG+jhn6ZbOEmgyB6gZ24+VXcSpCC/J5lqYQDO
         E6TBk/g2zG+xM9NmHLidCEl7ipRCfTMBCqMuCagaZj1A9TmDaubQ4jDUhTkqB2av6BWm
         tZvg==
X-Gm-Message-State: APjAAAWhRS7sOVWTmAwmBCw/WxKRNJf7M7h8SLnhyAl3rC1DcanBry9X
        xpQ2Lwo0Zz10D74eSUh9qZ8=
X-Google-Smtp-Source: APXvYqxVCG7FQ9fnZfVcI7lF8GLvYDjfWOoUB4FCd17jaWzROPu4nxojDGyKa4JRkRk5p0dVD/Ik9Q==
X-Received: by 2002:adf:eb85:: with SMTP id t5mr14424806wrn.168.1552955442342;
        Mon, 18 Mar 2019 17:30:42 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id m6sm3226663wrr.53.2019.03.18.17.30.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 17:30:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: [RFC/PATCH] point pull requesters to Git Git Gadget
References: <20190312213246.GA6252@sigill.intra.peff.net>
        <xmqqsgvrfsrh.fsf@gitster-ct.c.googlers.com>
        <20190313193909.GB3400@sigill.intra.peff.net>
        <20190313201854.GA5530@sigill.intra.peff.net>
        <xmqqzhps6ghl.fsf@gitster-ct.c.googlers.com>
        <20190318211215.GB29661@sigill.intra.peff.net>
        <20190318214842.GA32487@hank.intra.tgummerer.com>
        <20190318215233.GI29661@sigill.intra.peff.net>
Date:   Tue, 19 Mar 2019 09:30:40 +0900
In-Reply-To: <20190318215233.GI29661@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 18 Mar 2019 17:52:33 -0400")
Message-ID: <xmqq8sxbzowf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Mar 18, 2019 at 09:48:42PM +0000, Thomas Gummerer wrote:
>
>> > It looks like GitGitGadget just uses normal SMTP to submit the messages.
>> > I wonder if normal people using gmail as their SMTP server for
>> > send-email also suffer from this. I've not ever noticed it, but I
>> > don't know how common that setup is.
>> 
>> I am using gmail as my SMTP server with 'git send-email', and it
>> doesn't look like gmail is rewriting anything there, see [*1*] for
>> example.  The date header looks like this:
>> 
>>     Date: Mon, 25 Feb 2019 23:16:04 +0000
>> 
>> Note the +0000 there, compared to the GMT that GitGitGadget uses.
>> Looking at RFC2822, that's the new version of specifying the timezone,
>> while GMT is only defined in the obsolete time and date section.  I
>> guess gmail might just not like that anymore and rewrite it.
>> 
>> So fixing this might not be that hard, and might not involve sleeping
>> while sending the patch series at all.  Changing how the date is
>> calculated in [*2*] might be all that's needed.
>
> Yes, if it really is as simple as just "gmail doesn't like our date
> format, so it rewrites the header", that would be wonderful. Thanks for
> an extra data point.

I use send-email through SMTP MSA at either gmail or pobox depending
on the phase of the moon, and never noticed an issue with the
timestamp we generate.  But I noticed the "GMT" string in the
"original-date" trail in the problem message, which I didn't think
was an timestamp we would generate but somebody else might, and that
was why I quoted it in my message.  It is good that Thomas noticed
it, came up with a conjecture and a pointer to a possible fix ;-)

Thanks, all.

