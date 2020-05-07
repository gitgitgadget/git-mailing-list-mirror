Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B556EC38A24
	for <git@archiver.kernel.org>; Thu,  7 May 2020 18:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6780A2145D
	for <git@archiver.kernel.org>; Thu,  7 May 2020 18:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VCMuaYoO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgEGSRy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 14:17:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64674 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgEGSRx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 14:17:53 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 70BA252781;
        Thu,  7 May 2020 14:17:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=25A/PKppreU+8RhOs3npSkBOjpI=; b=VCMuaY
        oOqSrt4I5dpKPdXbfuELctPmhtdI8inCNnF+peplPqZ/GZXTHgQyzm4liqVMR1Z/
        gKukeKRi90eyYpmB9rtGxOkqj/xXIDfCHB/J4drd8TCHg1p46f7Tpr1nMXDR+Akg
        2OEgwqgyvKHfjXbLv3tg2Ho5h+jcqy8lBW6XY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=t0Og1Kq+tPO48GWez46zqPMNCZmV2UpQ
        QTpAUFhXW9SoHOu4Qb6LcghDicrtG1Tl3Uxp6B+CpZ3G/pjOoB2Us5Dy7dKr+36w
        3THItf6Q9ZnkVyuBkeQpULGvl6ynTAIyJ3NQOXkuum7oNHtn8fzn99B4WGyieWQr
        T4GChjRPQL4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 67AA352780;
        Thu,  7 May 2020 14:17:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E9B4A5277F;
        Thu,  7 May 2020 14:17:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 1/2] CI: limit GitHub Actions to designated branches
References: <20200504233634.GB39798@coredump.intra.peff.net>
        <20200505002055.GC64230@syl.local>
        <20200505164326.GA64077@coredump.intra.peff.net>
        <xmqqo8r2b6y4.fsf@gitster.c.googlers.com>
        <20200505182418.GA66702@coredump.intra.peff.net>
        <20200505210451.GA645290@coredump.intra.peff.net>
        <xmqqlfm69il6.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2005061623520.56@tvgsbejvaqbjf.bet>
        <xmqqeerx81wy.fsf@gitster.c.googlers.com>
        <20200507121727.GA3057274@coredump.intra.peff.net>
        <20200507140208.GA3060463@coredump.intra.peff.net>
Date:   Thu, 07 May 2020 11:17:50 -0700
In-Reply-To: <20200507140208.GA3060463@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 7 May 2020 10:02:08 -0400")
Message-ID: <xmqqimh74njl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0FE76AF6-908F-11EA-BDC3-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, May 07, 2020 at 08:17:27AM -0400, Jeff King wrote:
>
>> > But doesn't this (i.e. uses: actions/github-script) still pay the
>> > cost of spinning up a VM?  How expensive is it to check out a small
>> > tree with a single file, whether it is ref-whitelist or allow-ref?
>> 
>> I suspect this script mechanism may be much cheaper. I don't know the
>> implementation details, but spinning up a nodejs container to run a
>> javascript snippet should be much cheaper than a full ubuntu VM running
>> "git clone" (the clone itself should be super cheap because it's a
>> shallow single-branch clone of a tree with one file in it, but getting
>> there is relatively heavy-weight).
>
> Sorry, this is all complete nonsense. There is no magical nodejs
> container in Actions. You still have to say "runs-on: ubuntu-latest". So
> it's still spinning up that VM and then running inside there.

Ah, I did see "runs-on: ubuntu-latest" in the tutorial for the node
thing, and was very much dissapointed, before I sent that "don't you
still spin up a VM anyway?" response.  Glad to know that I wasn't
totally misreading the documentation, and unhappy that there wasn't
a magic bullet after all X-<.

> and they took 1, 2, and 3 seconds respectively. They spend 2s getting
> the environment set up and the actions loaded. So the API one spent less
> than 1s on the network, but the single-file checkout spent slightly
> more. Given the timing variations I've seen, I wouldn't be surprised if
> it sometimes goes the other way. But even if those numbers are accurate,
> I don't think the cost difference is enough to force our hand either
> way.

Yup, the above tempts me to say "because we are spinning a VM
anyway, why not just run an end-user supplied script and let it
decide?" would be the best approach.

Unless somebody finds a magic bullet, that is, but unfortunately the
nodejs one does not seem to be one.

Thanks.

