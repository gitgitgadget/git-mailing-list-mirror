Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E142C2D0F4
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 19:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE5120771
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 19:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vd509SiW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgDHTqp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 15:46:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55756 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgDHTqp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 15:46:45 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BAA1E4FBAC;
        Wed,  8 Apr 2020 15:46:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GY16CHu8tRSKtuTTVbgtWEMXGiY=; b=vd509S
        iWlZWnAjG1tdkRiwm2DV3qixuisQPxOmtbV4MmFIuVQRSyyZWq/1613D0yjEA3Ml
        B7xZUgL082OunfxX4S7nUSuoq1hAWNMStclFkj5+eT3h4d06WhwQHpaKEgLumfDD
        igTTWJt4sY6YW5pJsR6qWKbTC992wBrUqT4NY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FClxuAgu7O980tTkvG1PC3ubfrAU7W3w
        6bKB490AllawSv8uxnyDtEUQ25O5FfKFOJrwFFLKLGRbygyX085LyBcHaSPQBDK9
        uDAhn87IvpNicbJhHfmBVZtYjYxEXQND5tcSY1d4kAagj4OrmuWvD17evNJAc1Wv
        BV1o4VCfZF8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B138F4FBAB;
        Wed,  8 Apr 2020 15:46:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3EEC74FBA9;
        Wed,  8 Apr 2020 15:46:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] revision: --include-diversions adds helpful merges
References: <pull.599.git.1586308923544.gitgitgadget@gmail.com>
        <xmqqv9mapxw9.fsf@gitster.c.googlers.com>
        <5f1c6868-303c-ccc1-553e-e54d0fa8e24f@gmail.com>
        <74562b04-b1ce-cad4-da18-4af030a3dc29@gmail.com>
Date:   Wed, 08 Apr 2020 12:46:41 -0700
In-Reply-To: <74562b04-b1ce-cad4-da18-4af030a3dc29@gmail.com> (Derrick
        Stolee's message of "Wed, 8 Apr 2020 11:28:53 -0400")
Message-ID: <xmqqzhbloj4u.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ABA07FC0-79D1-11EA-9AC9-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 4/7/2020 9:39 PM, Derrick Stolee wrote:
>> On 4/7/2020 9:30 PM, Junio C Hamano wrote:
>>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>
>>>>     This --include-diversions option could use a better name.
>>>
>>> True, but I do not think of a better (or for that matter a worse)
>>> one.  
>
> Here are some alternative names:
>
> 	--audit-merges
> 	--audit-trunk
> 	--first-merges
> 	--subtle-merges
> 	--more-merges
>
> The "audit" name implies some of the intent: we are trying to
> audit which merge commits introduced these changes. The --audit-trunk
> implies we are using a trunk-based workflow where parent order is
> critical. However, "trunk" may be confusing when there are multiple
> long-lived branches.

Our features written with the intent to be useful for one purpose
often end up being used for purposes other than what the feature was
originally written for (the "--pickaxe" has always been a bitter
example of this for me).

For that reason, I am a bit hesitant to endorse "audit" exactly
because of the implication of "intent".

We usually try to give a single simplest history that explains how
the current content in the path came to be.  For that, commit M in
the illustration in your original message does not really help when
we ignore which parent chain owns the history, but in practice, many
workflows treat the first parent chain as something special, so we
want to show, not just the individual changes that matter, where the
changes are introduced in the first-parent chain.

I wonder if there is a simple-enough phrase to convey what the
latter half of above sentence says.  "include" and "keep" are both
good verbs---normally we discard these merges, because they do not
contribute at the level of individual changes, but with the option,
we "include" or "keep" these merges in the output.  It's not like
we keep _all_ the merges, but selected merges only.  How do we
decide which merges to keep?

I guess your "--first-merges" came from such a line of thought, and
is the closest among the five to what I have in mind, but it drops
too many words and loses too much meaning.  

"--keep-first-parent-merges", perhaps?




