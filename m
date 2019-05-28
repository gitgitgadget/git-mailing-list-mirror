Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33D091F462
	for <e@80x24.org>; Tue, 28 May 2019 17:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfE1ROK (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 13:14:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65038 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfE1ROK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 13:14:10 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ECF90143C08;
        Tue, 28 May 2019 13:14:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+hnOdDRVOJzDgEHjlF19LGqt51g=; b=R0cbwS
        piP4rp6zvzxMS2TAgoo3x30FzvXaR53ljgnWMY/Idt/2wb9JsoiX075VSnH7ODpx
        uCFchYsAYVdULzWPCXpk1tZT4YtR0C/slGT8iTs/TfhS2gWkZ2dvvnNKv4OA84Si
        VYr3WdWi83xe3uNxxhfKQUYiaslMSSy/HGXeM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ThX4abCXvar54d81hHL6kn1OKrujuSe3
        zja8nB/G415YdRPUyPuFDR8vq1G6d88tZaVHbmQwnckUSzIQUhjy1VYbua/PoIaB
        xcLHdSFMseYQSn1SKTU4ioCeeDetFpEQl7+00aI7WiGhrDhjINUM9Ztoy3Zuw5RN
        y1yc5Q6xAKU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E5A6D143C04;
        Tue, 28 May 2019 13:14:07 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5E205143C02;
        Tue, 28 May 2019 13:14:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff King <peff@peff.net>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/1] trace2: fix tracing when NO_PTHREADS is defined
References: <pull.222.git.gitgitgadget@gmail.com>
        <20190521212744.GC14807@sigill.intra.peff.net>
        <97796007-db6e-f2ea-91ae-3113b74e4ae9@jeffhostetler.com>
Date:   Tue, 28 May 2019 10:14:05 -0700
In-Reply-To: <97796007-db6e-f2ea-91ae-3113b74e4ae9@jeffhostetler.com> (Jeff
        Hostetler's message of "Wed, 22 May 2019 09:23:39 -0400")
Message-ID: <xmqqv9xu33j6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 005C41DE-816C-11E9-B526-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> For now, I've guarded my usage of pthread_getspecific() in the trace2
> (similar to what index-pack does), so its not urgent that we update it.
> And I'd rather we take this simple trace2 fix now and not try to combine
> it with fixes for the pthread macros.  Especially now as we're in the RC
> cycle for 2.22.
>
> I'll make a note to revisit the pthread code after 2.22.

Thanks, both.  The above direction makes sense for me, too.

