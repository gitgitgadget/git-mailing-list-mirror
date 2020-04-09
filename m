Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3803C2BA2B
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 15:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2BFA20769
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 15:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bodtu9ei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgDIP4q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 11:56:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64062 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbgDIP4q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 11:56:46 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 110386653A;
        Thu,  9 Apr 2020 11:56:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZRk2d3/hKDAc6DdUHRj7JC+/sIc=; b=bodtu9
        eiao8zMIl+y6c1JJuZjUtvO2G4KNKcz5G7vjTEZa+SwLslc9gy5ong3N2sUHcc9A
        iCZzbt0Zt65cdoTej8KKAracP7unP0uEdplm9LCser1KjDaiqD19/fcUwbz/5Uhi
        2eWItEbVUhJCsXThlG0BPmMjFVKo0Xie3v4wE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MM5+CHXruaaAXAsY3gwoPeGttcKiMt5W
        xFkcqW4CARHYTgtaKV/2N3/4uVTczz9hasN/lJLPLzVOA+SAZUWIj0c9RT7YcjTf
        GmglshMCwgk0S5+7+iZyeJ5fKMEf+v+/xziShs9K5CVKW0mL1l4M3bpr2IcoJti2
        2uD9eFHZCzo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 04BDF66539;
        Thu,  9 Apr 2020 11:56:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 61C4A66538;
        Thu,  9 Apr 2020 11:56:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] revision: --include-diversions adds helpful merges
References: <pull.599.git.1586308923544.gitgitgadget@gmail.com>
        <xmqqv9mapxw9.fsf@gitster.c.googlers.com>
        <5f1c6868-303c-ccc1-553e-e54d0fa8e24f@gmail.com>
        <74562b04-b1ce-cad4-da18-4af030a3dc29@gmail.com>
        <xmqqzhbloj4u.fsf@gitster.c.googlers.com>
        <20200408200526.GA2270445@coredump.intra.peff.net>
        <9eab6c60-3c99-d6ac-9206-02ce37f7a479@gmail.com>
        <xmqqv9m9oe2p.fsf@gitster.c.googlers.com>
        <91fafa17-c58f-dcd0-320d-48c4512561f6@gmail.com>
        <xmqqimi9o705.fsf@gitster.c.googlers.com>
        <7d84fc45-786f-7a2e-5889-ef26916627ef@iee.email>
Date:   Thu, 09 Apr 2020 08:56:42 -0700
In-Reply-To: <7d84fc45-786f-7a2e-5889-ef26916627ef@iee.email> (Philip Oakley's
        message of "Thu, 9 Apr 2020 15:28:15 +0100")
Message-ID: <xmqqeeswodol.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B54863CC-7A7A-11EA-AFB7-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

>> Yes, but "redirect", "switch", "detour", or "divert" do not quite
>> mean "merging in a real change", at least to me.
>>
>>> I'll just submit my v2 as-is, which includes a significant change to
>>> the documentation that should make things more clear.
>> Thanks.
> Can I suggest "--side-merges" as a possible descriptor for these
> non-mainline diversions?
>
> My thesaurus had suggested detour and sidetracked, which led to the
> side-merge view.

Ahh, sorry Derrick for being slow and thanks Philip for repeating
"diversion", as the word did not click for me at all when I saw the
patch and wrote my response.

But I think it started slowly to dawn on me.  

Does it come from the worldview where we want to follow the "trunk"
but because when we notice at a merge that we got everything that
matters to us from a side branch, we switch the track out of the
mainline and from then on follow that side branch?  Switching the
track and following the side branch happens silently with the
default "history simplification", but the new feature shows where
that side-tracking happens more prominently---is that where the
words "divert" etc. come from?

Then I can understand how these candidate words may have place in
describing the situation we want to use the feature; I am not yet
convinced any of the concrete option names floated on the thread (or
what I can come up with right now) would be clear to our target
audiences, but at least I am not as confused as I was before.

Thanks.
