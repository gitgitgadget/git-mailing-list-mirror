Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 702E21F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 23:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731001AbfJCXRU (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 19:17:20 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63551 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbfJCXRU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 19:17:20 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 99C32943F5;
        Thu,  3 Oct 2019 19:17:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pV5kugm7UihvvPDY1M0TW7XRiqU=; b=ToxEee
        Ry6NCRvIzAF4uxXpBKHRSwwKNSrgV+Sv1JOB4/y5xbfCc+rBhuRsM9yTg5vUJwKD
        j1H1DtyMjCj7CLVevPf0Z4s0Kdm7rjzt9MussiDXASeMTd7f/liFGBnsbtZeGT8j
        uA8ph1nnyZAwb++7k6tv6DSDK/r3U3iQ4+Czk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=B33oDaZriAvqTeDTygej1OJTSNSZ66E5
        Z9XKCHVVEybTL2EzWtzNRLRNrj7ldN46+0evXN0J1mlChwZImPF9+zDI+JjUXeW1
        3WyoWMsrrx4zqx/u4p0/YjLFYtH63gz4ZTC7zvzYaV5hoX/ZF8atNv8VVzulAhau
        qD3c3M/FS8o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 90D6A943F4;
        Thu,  3 Oct 2019 19:17:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BD88C943F3;
        Thu,  3 Oct 2019 19:17:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     William Baker via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, williamtbakeremail@gmail.com,
        stolee@gmail.com, jeffhost@microsoft.com
Subject: Re: [PATCH 0/1] fsmonitor: don't fill bitmap with entries to be removed
References: <pull.372.git.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.1910032306380.46@tvgsbejvaqbjf.bet>
Date:   Fri, 04 Oct 2019 08:17:13 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1910032306380.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 3 Oct 2019 23:08:24 +0200 (CEST)")
Message-ID: <xmqqd0fda07a.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F020FD50-E633-11E9-9A72-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi all,
>
> On Thu, 3 Oct 2019, William Baker via GitGitGadget wrote:
>
>> This patch series fixes a segfault that I encountered while testing
>> fsmonitor. Under some circumstances, the fsmonitor extension was being
>> written with too many bits, and subsequent git commands would segfault when
>> trying to apply the bits to the index.
>>
>> As part of these changes I've added some BUG checks that would have helped
>> catch this problem sooner. Special thanks to Dscho for pointing me in the
>> right direction and suggesting a test that can reproduce the issue.
>>
>> Thanks, William
>
> Please note that I was involved with the development of this patch,
> reviewed a couple of iterations internally and am implictly okay with
> this first public iteration.

IOW, "Reviewed-by: dscho".  That's good to hear.

THanks.
