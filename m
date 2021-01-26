Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575DAC433E6
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 20:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B8BC206D4
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 20:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731270AbhAZFFS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:05:18 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61261 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbhAZCh1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 21:37:27 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EFFA3A5381;
        Mon, 25 Jan 2021 21:36:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=YgOMORdCFtivDFstYsH3rrCgPlM=; b=ku2lrdqsHHan90DDo4Cx
        62QG0IvWp6ekKIC8/9i3V3KTwBBBtoD2g9n2yf6IafqWXYKMZs8A+wX+CfZMXJwm
        ngy0kKTHr/OZVL9oFmEac3SaQQkltQRmfi9Y/fuiIfi6/y0VkmeAWoVh+8bxUBXb
        HlV8uPLJuxc8+GqVONfYuaM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=cyxfaXgttSXPwPYJbZjyrvHxx0t01p7NVhbiXcDOvDLNYE
        Q+ST9lszHQ+OhDdW44BdtTSU8rK71tNWV1YrbOIrKOCZAps52zLhc8fEP5NwBWMA
        KGh4dODXQ5iCwqa2eXX8hIINU1v4/NHJw3WJu9ycX6T81Flq9IfCI9y1jl9Uk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E8AF2A5380;
        Mon, 25 Jan 2021 21:36:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7D868A537E;
        Mon, 25 Jan 2021 21:36:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, jrnieder@gmail.com,
        peff@peff.net
Subject: Re: [PATCH v3 00/10] pack-revindex: introduce on-disk '.rev' format
References: <cover.1610129989.git.me@ttaylorr.com>
        <cover.1611617819.git.me@ttaylorr.com>
X-Gnus-Delayed: Tue, 26 Jan 2021 02:30:40 -0800
Date:   Mon, 25 Jan 2021 18:36:43 -0800
Message-ID: <xmqq7do04e6c.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 54555076-5F7F-11EB-982C-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Here is a third reroll of my series to introduce an on-disk format for the
> reverse index. Since the first series (to introduce a new API) has been merged
> to 'next', this series has been rebased onto 'next', too.

Ehh, does that mean you are OK to see the remainder of 'next' to
take this topic hostage?

Unless you use some new features that came from other topics in
'next', I'd discourage such a rebasing.  If the API topic gained
some fix-up patches on top since it was merged to 'next', it is
perfectly sensible to rebase this series on top of the updated API
topic---it does not change the fact that this topic is dependent on
the API topic.

As it happens that the API topic is now in 'master', none of the
above complaint should actually apply, even if this new round of
patches do not cleanly apply to the tip of the API topic, as long as
they apply cleanly to tonight's 'master'.  It will make the topic
ineligible to be merged later to 'maint', but this is a new feature,
so nothing is lost.

So, I'll try to apply them first on top of the tip of the API topic,
which is at 779412b9 (for_each_object_in_pack(): clarify pack vs
index ordering, 2021-01-14), and if I do not feel like spending time
to resolve conflicts, I'll then try to apply them on top of tonight's
master.  We'll see what happens.

Thanks.
