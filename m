Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EF2C433F5
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 17:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiJJRDQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 13:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiJJRC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 13:02:59 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F47A760F0
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 10:02:55 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 48E34142618;
        Mon, 10 Oct 2022 13:02:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UOVjgNYB14V51xHZzCKE7AY68rSDD0zHOIOrX3
        TzP8w=; b=QWnudth8aB1x7Sc39A2/EBO3ontta4BPhnCUDWP8ASPe8RA0EhXiNS
        kdvq9k8LY49ZGVR0ZRJOoU4TDbCak0JREpx50HBlrkvXM9FD3lnah8gkDGPGZiiJ
        VzMTJSh3pZxUgkdCIcgDm/JcDthxg7wScqmn0FxHVMvhlcf/dHq2s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E634142615;
        Mon, 10 Oct 2022 13:02:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 96ADA142614;
        Mon, 10 Oct 2022 13:02:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     rsbecker@nexbridge.com, 'orygaw' <orygaw@protonmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: Git BUG 2.37.3 and 2.38.0
References: <o2ijhZAUIi7nPTwQmsJfpvPIEeLbhvn1AP8rhW2hCNbC380Z2ogDHzZigqJsHI6RwphsIZR3OSJSy-wYvyWv5un632tKynHKFLFPLPEDH2g=@protonmail.com>
        <037801d8dcbe$9d585b20$d8091160$@nexbridge.com>
        <Y0Q+v0s5BPYEPq2K@nand.local>
Date:   Mon, 10 Oct 2022 10:02:52 -0700
In-Reply-To: <Y0Q+v0s5BPYEPq2K@nand.local> (Taylor Blau's message of "Mon, 10
        Oct 2022 11:48:15 -0400")
Message-ID: <xmqqlepn4nnn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 614636BE-48BD-11ED-8D14-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Mon, Oct 10, 2022 at 11:40:18AM -0400, rsbecker@nexbridge.com wrote:
>> I can confirm a similar situation on Cygwin at 2.38.0.
>>
>> $ git log -1 --invert-grep
>> commit 5385d4b84047b3c42cde36f1fab83ac57df17ca8 (HEAD -> topic, origin/topic)
>> Author: Me <yesme@domain.com>
>> Date:   Sun Oct 9 22:26:47 2022 -0400
>>
>>     rms.yaml: add path variable definition
>> Segmentation fault (core dumped)
>
> Thanks, both. I can reproduce it, too. A quick bisection points to
> f41fb662f5 (revisions API: have release_revisions() release
> "grep_filter", 2022-04-13), which appears probable.
>
> I'll push up a patch shortly which fixes this issue.

Thanks.
