Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C2BC4332B
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 20:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76EB520724
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 20:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TFtNjQO6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgCTUn5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 16:43:57 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57272 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgCTUn5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 16:43:57 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E01B8C7763;
        Fri, 20 Mar 2020 16:43:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NGkquJEHWPexc77o3MdM+qFYnCY=; b=TFtNjQ
        O6REVLd6xiMTBckT+/H0250v18qLulH6BF2GXbJxDhgofu1OO3SjCVEOzUClRjWp
        gSj3kY/jSnfiyF8cEMoSOyHmlMUEVyva0/7C//SRbXyChMsTb4p9dqdXxoSrFgk5
        zumwGpFmraNOwXv1GSxIEk+3TGF6s42aQ/e2U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sof9R2YCjVanrKiT6qZodKU/i5//W2TY
        oJ7KJU4i2IHo9m0bU1vOCINv42sVUvq689gZCjDiheYodEH1TpSQfeOIwNzcA5Yi
        TvzTEPzQxZU0vj8zn9JXMLGh6iVuGHSqrp5amEYddTlromHa2B+4TWR3nrNX1Spx
        fBtfMn/wi5Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D841BC7762;
        Fri, 20 Mar 2020 16:43:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 26DDCC7760;
        Fri, 20 Mar 2020 16:43:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, jrnieder@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2] config: set pack.useSparse=true by default
References: <pull.585.git.1584583110914.gitgitgadget@gmail.com>
        <pull.585.v2.git.1584707247753.gitgitgadget@gmail.com>
Date:   Fri, 20 Mar 2020 13:43:52 -0700
In-Reply-To: <pull.585.v2.git.1584707247753.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Fri, 20 Mar 2020 12:27:27
        +0000")
Message-ID: <xmqqmu8abvuf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 83597048-6AEB-11EA-AD72-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     Here is a small patch to convert pack.useSparse to true by default. It's
>     been released for over a year, so the feature is quite stable.

I would not say anything more than "its' been released for over a
year, so the feature is known not to cause problems when it is not
enabled (in other words, we coded our if/else correctly)", unless
some telemetry tells us that significant number of users with widely
differing use patterns have enabled it and are not seeing much
negative effect.  And we can tell if it is stable only if we flip
the default.

> I'm submitting this now to allow it to cook for a while during the
> next release cycle.

I agree that it is about time to see if flipping of default would be
a good move for users whose usage patterns are unlike VFS for Git by
cooking a change like this in 'next', definitely at least a cycle
but possible a bit more, and it is a good idea to have it at the
beginning of the next cycle.  Very much appreciated.

Thanks.
