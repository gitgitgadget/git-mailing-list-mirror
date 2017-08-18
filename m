Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B915208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 19:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751609AbdHRTKl (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 15:10:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53639 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750984AbdHRTKk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 15:10:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0087D97A68;
        Fri, 18 Aug 2017 15:10:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OYwXhHHq63BwrUEN2L1w+NH6beE=; b=WTKNSF
        k8S6HXF57Ptx2sWErEqT8OxzKwWlSlyD0hE6MUalnaK+q2EZmCr2vOtvuwr7rgHY
        rMlqSDwAPLVzjX2cOyBkGEK0D3Zrc05Ii/7pIR7Aoseq7YL9Gk0WwQAjv9IrLFwS
        5s1VB6tlasi96na8va8z+3FVjIVqHoB3Ohazc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bSm4nn/TnVamRzyMBILBbPuCaO2qzr+q
        TngVjHBdQ+/ZGxf5WgFArM5uRGoobQxbGtqIP9WbfODD9rBKH+ykQln6q/70P6p/
        Tg3llacxQEVePT2G3hMcT6BdKV1pXq6+vT3gvA0t8jw/EKhFrC1M3gglEwts6KZe
        azoMuBG2Tmg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EB6BE97A67;
        Fri, 18 Aug 2017 15:10:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5FA8697A65;
        Fri, 18 Aug 2017 15:10:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Submodule regression in 2.14?
References: <4283F0B0-BC1C-4ED1-8126-7E512D84484B@gmail.com>
        <CAGZ79kajWhEOtqZLrYSAVhM_ZLDiQd9DP9GeL+J=tqach5V65A@mail.gmail.com>
        <FCB6097F-9F8D-4FDD-A8CE-D936C9CE62E7@gmail.com>
        <CAGZ79kb-ReME6qbDy-Q12-d=B=f6odUW_D1bAmegP4AY2AyntQ@mail.gmail.com>
        <D784E926-9FC7-4508-9632-225138679CDF@gmail.com>
        <CAGZ79kaC-rtfp-AMdpkpCycgk568eU2y-JDGwdoSK_E=oUJo-w@mail.gmail.com>
Date:   Fri, 18 Aug 2017 12:10:38 -0700
In-Reply-To: <CAGZ79kaC-rtfp-AMdpkpCycgk568eU2y-JDGwdoSK_E=oUJo-w@mail.gmail.com>
        (Stefan Beller's message of "Fri, 18 Aug 2017 10:16:14 -0700")
Message-ID: <xmqqpobsbsk1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EC3DF6E2-8448-11E7-BA1D-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> In the past "submodule.<name>.update=none" was an easy way
>> to selectively disable certain Submodules.
>>
>> How would I do this with Git 2.14?
>
>     submodule.<name>.active = false
>
>> My gut feeling is that all commands should respect the
>> "submodule.<name>.update=none" setting.
>
> Well my gut feeling was that the "update" part of the name
> reponds to the subcommand, not the generic action.
>
> For example when you set update=none, git-status,
> recursive git-diff still reported the submodule.

Both status and diff are read-only operations, so this smells like a
bit bogus argument made by comparing apples and oranges.

I think Lars is more interested in operations that actually affects
the state of submodules by updating them---"submodule update" may be
a prime example as it goes down to run fetch, pull and/or checkout.
It may have been the only thing that affected the state of
submodules before the "--recurse-submodules" option was added to
commands that affect the state of the (super)project, but I would
think that it is not so wrong to expect that these state-affecting
operations running in the "recurse into submodules" mode to honor
"do not update this submodule" that used to be honored only by
"submodule update".
