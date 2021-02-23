Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738DCC433E6
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 01:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C4FA64E61
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 01:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhBWBZ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 20:25:57 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59447 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbhBWBZD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 20:25:03 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 53355B6889;
        Mon, 22 Feb 2021 20:24:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HhFP9mrfH/YQoQMX7uKSfM4F7D4=; b=wRN/At
        acwPfy4fKHEWp2yCMwOoZtskYJKDRByOuceklJDAv4N8HLiUQcGSPwZjOWMXOvca
        g+OfLNCCvpMo00FwD3kV07G3QApO5AaUNbUq2PvDyFBsau5tliqSDitddpuVShTc
        L29f58xTF3+tRV0ie8U6F0L20ADpmriXCCrVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=esuQhZN5+HIi/MoEGLwgDHeL0gBNTzNX
        wMfkXYl/oaNdDQ0XvlTHj/P4l+aUz9Mw/3jKM1w/9ec7fAnERe19sGFVUeyT7Lb2
        6K+oQLSV/vXkVy8CoKKXWFvJBnT89GDuHy6WI0GaGBQgRVdSL8MpudeXXVWDE2o7
        XYHHDlVKVJA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4663EB6888;
        Mon, 22 Feb 2021 20:24:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AA00DB6887;
        Mon, 22 Feb 2021 20:24:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Wang Yugui <wangyugui@e16-tech.com>, git@vger.kernel.org
Subject: Re: [PATCH] docs/format-patch: mention handling of merges
References: <20210222211621.0C5D.409509F4@e16-tech.com>
        <YDQ27qbbblPfLCpU@coredump.intra.peff.net>
        <YDQ5YIeXGiR5nvLH@coredump.intra.peff.net>
        <xmqqv9aj65na.fsf@gitster.g>
        <YDRA6RJdnFne2EBw@coredump.intra.peff.net>
Date:   Mon, 22 Feb 2021 17:24:16 -0800
In-Reply-To: <YDRA6RJdnFne2EBw@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 22 Feb 2021 18:40:25 -0500")
Message-ID: <xmqqblcb60fz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D8FF2EF8-7575-11EB-996C-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> That seems worse to me, because "it is impossible" implies that this
> can never be changed. But I don't think that's true. We might one day
> output something useful for merges.

Fair enough.  You are more optimistic than I am ;-)

> I think one could argue that any merge information (including conflict
> resolution) works against the root notion of format-patch, which is a
> set of changes that can be applied on a range of basesa.

That's true and it was the primary motive for omiting merges.

> But even that I
> would be hesitant to commit to (since --base exists now).

I am not quite sure what --base has to throw into the equation.  The
information --base gives is often useful when I want to learn where
the patches were taken from, but that does not restrict where the
patches are actually applied to in any meaningful way (iow, "on a
range of bases" part is not affected).

