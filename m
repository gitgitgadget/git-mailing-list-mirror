Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071DDC433DF
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 21:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B067A207DE
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 21:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Yr2aw4ng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgHSVF5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 17:05:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57218 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgHSVF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 17:05:57 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C98B86B3D;
        Wed, 19 Aug 2020 17:05:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QJYQVr+odr4ThpqTwqHLZQKKQAQ=; b=Yr2aw4
        ngYHzCzd14gnQ+vtL2gmFwD4bmwA93kIN7b+YzlBNMqp2CEULjnTz9hfq9MqkLWG
        BhgLbFm4Y5U34iSmW1xnDWjiwGOkNhe6gynBdsPXJ5nFA3J9CmWqPyxVgjA4UQuf
        IoWwIHMq5WtWAcMrqUzEglFDCcxZSEEclLyiw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MgAMDwOifBWh0a6HMynrLEZM8Q66Pfbj
        wTbCfdFfyHW98hsuF5sRoRXBvBuLUfLfXJn6d0BGNsmTdRlrGTS+Eu7Qc3Ubqrg+
        t8sLlS2Ep5o/a2ai2RsbwxngJ/BkIXiXjHbPvGiakSHVpibC7lUhIj11KMmnNDu3
        VfAlomfrIjs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 11FBB86B3C;
        Wed, 19 Aug 2020 17:05:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8401386B3B;
        Wed, 19 Aug 2020 17:05:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ryan Zoeller <rtzoeller@rtzoeller.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] parse-options: add --git-completion-helper-all
References: <20200819175047.692962-1-rtzoeller@rtzoeller.com>
        <20200819175047.692962-2-rtzoeller@rtzoeller.com>
        <xmqqeeo2togj.fsf@gitster.c.googlers.com>
        <a51ff9bb-47df-63ce-0b7f-508e064f4e3f@rtzoeller.com>
Date:   Wed, 19 Aug 2020 14:05:52 -0700
In-Reply-To: <a51ff9bb-47df-63ce-0b7f-508e064f4e3f@rtzoeller.com> (Ryan
        Zoeller's message of "Wed, 19 Aug 2020 20:51:11 +0000")
Message-ID: <xmqq5z9etkgf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C48D1FF6-E25F-11EA-BACA-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ryan Zoeller <rtzoeller@rtzoeller.com> writes:

> On 8/19/20 2:39 PM, Junio C Hamano wrote:
>> 
>> Ryan Zoeller <rtzoeller@rtzoeller.com> writes:
>> 
>>> --git-completion-helper excludes hidden options, such as --allow-empty
>>> for git commit. This is typically helpful, but occasionally we want
>>> auto-completion for obscure flags.
>> 
>> Hits from "git grep -B2 OPT_NOCOMPLETE" tells me that these are
>> mostly unsafe options.  Those who accept the risk by saying
>> "complete all" should be allowed to see them.
>> 
>> The same with OPT_HIDDEN (including OPT_HIDDEN_<TYPE>) gives us a
>> mixed bag.  Many are unsafe, some are uncommon and the rest are
>> discouraged, or old synonym to some other option that does get
>> completed.  I am not sure if letting them be completed is an overall
>> win or makes the output from "git cmd --<TAB><TAB>" too noisy.
>
> If options marked OPT_HIDDEN are considered too internal to
> meaningfully expose, I'm happy to hide them. I defaulted to
> "show everything", and backing off from that is easy enough.

I think with the current state of HIDDEN which is applied unevenly
and for different purposes, the only sensible thing to do for the
"complete-all" operation is to show them.  If we audit all uses of
hidden and allocate different bit for the reason why they are marked
to be hidden, it may become possible for "complete-all" to be more
intelligent about them (e.g. not showing old synonyms that exist
only for helping muscle memory, while showing others), but before
that, I do not think it makes sense to hide them all.

> You're not misreading it; I apparently neglected to test the completion
> for '--no-' options with '--git-completion-helper', only
> '--git-completion-helper-all'. I'll apply the same show_all logic
> to this function.

That makes sense.

> I'm inclined to be repetitive in order to keep
> '--git-completion-helper-all' intact, e.g. for grepping.

Good reasoning.

Thanks.
