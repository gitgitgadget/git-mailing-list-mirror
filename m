Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CF6B1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 05:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfKOFFB (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 00:05:01 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62035 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfKOFFB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 00:05:01 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D32CC9B179;
        Fri, 15 Nov 2019 00:04:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aZpRFyO8XAEZseRwlSLg/Pk6y8w=; b=hLNv4x
        Be3s7hl+JC03V0InbLDWXk/ZjehN7cdDsGD2EWhfBUlhRD50BTUWVL/irhvCVq+O
        04a7xhV5bXrmzmJ7Myy3RnqqbICcQnxNwmUags71+iu0qJGEvytX2OCv8YAuCa/E
        rRi3hUPFIP2c130QAe+jLZ/VlU1O/ZtYal2Rk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QXOdHwubnI5zVw9bU0njxNV97yIABOSk
        eAxOkFIqW3TKAFANZV3RZSKxDNwgzykfJSTNBj6YQR3Rcb5aThIJkzxFWoSrXuAh
        FKvTtW9JsvvdQJWlYnB9DBmZzcbr69sIvyerSdrqikSBIEVFjGWHwjFI+35Mc8XO
        0hpJPsR83HU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CAD219B178;
        Fri, 15 Nov 2019 00:04:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 043FA9B177;
        Fri, 15 Nov 2019 00:04:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     William Baker <williamtbakeremail@gmail.com>
Cc:     Kevin Willford <Kevin.Willford@microsoft.com>,
        Utsav Shah via GitGitGadget <gitgitgadget@gmail.com>,
        William Baker <William.Baker@microsoft.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Utsav Shah <ukshah2@illinois.edu>
Subject: Re: [PATCH 0/1] fsmonitor: skip sanity check if the index is split
References: <pull.458.git.1573196960.gitgitgadget@gmail.com>
        <xmqqh83bjig6.fsf@gitster-ct.c.googlers.com>
        <xmqqa793jhne.fsf@gitster-ct.c.googlers.com>
        <BN6PR21MB07869E8D1DCAF189C4E472A891740@BN6PR21MB0786.namprd21.prod.outlook.com>
        <xmqqzhh0d0ma.fsf@gitster-ct.c.googlers.com>
        <beb5a2b4-f07c-c3fd-9e68-dbee85fba2ee@gmail.com>
Date:   Fri, 15 Nov 2019 14:04:53 +0900
In-Reply-To: <beb5a2b4-f07c-c3fd-9e68-dbee85fba2ee@gmail.com> (William Baker's
        message of "Thu, 14 Nov 2019 08:41:25 -0800")
Message-ID: <xmqqh83591ca.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7726EB3C-0765-11EA-B423-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

William Baker <williamtbakeremail@gmail.com> writes:

> On 11/12/19 5:30 PM, Junio C Hamano wrote:
>> Thanks.  Here is what I came up with to tie the loose ends of this
>> thread.
>>  ...
>
> This looks good to me.

Thanks.
