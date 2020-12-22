Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E203C433DB
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 19:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C250B20700
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 19:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgLVT4J (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 14:56:09 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57825 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgLVT4J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 14:56:09 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 263B0A1CCE;
        Tue, 22 Dec 2020 14:55:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UWtGNocePuMiaOnpLNelS+0/XMo=; b=W/S3+l
        +HewxhF4Uwb599y71MqVe/YlmqjclZyrzb0hhp+tSeMbtZt4LCER6ht/T78/PpRx
        xGJtfRFGFd5AWhvwflkkRSdli6rcz+PjVDjmpebZe2T8DwMin/YdfvBex7Q47RVG
        7ggT73mrQSK1pjqaf8KomudtiBaWI7sWmDTgw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JdagOk9OH+Wv+6l7LVnJcvNnV2j2zxq0
        FT+ahun2YTYirZO0hajDbPv4Tq4JSlmtORDdDif374QEE/AMZUgmbWUDkhB+fBxR
        NggPuTQNyjrwn/r0E9jjbcASlIsFueWxbM66sL1wVpSnrT9AS08aQQR00GwnzPRS
        xXvIdoVS5xU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1DE6CA1CCD;
        Tue, 22 Dec 2020 14:55:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 81BE7A1CCA;
        Tue, 22 Dec 2020 14:55:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Riesen <alexander.riesen@cetitec.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Config option to set the transport protocol version for
 network fetches
References: <20200916200203.GA37225@coredump.intra.peff.net>
        <20200917132047.GA14771@pflmari>
        <20200917133153.GA3038002@coredump.intra.peff.net>
        <20200917133525.GE8079@pflmari>
        <20200917145142.GA3076467@coredump.intra.peff.net>
        <20200917151730.GG8079@pflmari>
Date:   Tue, 22 Dec 2020 11:55:25 -0800
In-Reply-To: <20200917151730.GG8079@pflmari> (Alex Riesen's message of "Thu,
        17 Sep 2020 17:17:30 +0200")
Message-ID: <xmqq1rfhipjm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A2B1B260-448F-11EB-8EBF-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Riesen <alexander.riesen@cetitec.com> writes:

> Jeff King, Thu, Sep 17, 2020 16:51:42 +0200:
>> No problem, and no rush. I just wanted to make sure those bits didn't
>> get overlooked.
>
> I'll try and do my best :)

If I remember correctly, this discussion started as an introduction
of useful feature, but got stuck at the implementation phase of how
the feature is presented at the UI level after we had general
concensus on the design.

It has been about 3 months; has anything happened that I missed?  It
seems that I kept the thread-starter patch in the 'seen' branch, but
and haven't updated with a later attempt in the discussion.

Thanks.

