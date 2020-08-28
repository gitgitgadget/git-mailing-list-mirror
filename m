Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE333C433E6
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 21:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7888C2075B
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 21:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XEeoKQjA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgH1VAK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 17:00:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51965 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgH1VAH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 17:00:07 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B4902685E0;
        Fri, 28 Aug 2020 17:00:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=36QDCwHsoZ3Hgl2wUjOEiXeeh9A=; b=XEeoKQ
        jAi3UcuEquUm+XnnFn0iiiN8/c/Pq/TUdnPWX2FFWzuz3G3f6S09/NLixNLSqsbm
        KkqZ2iFkE5LCLW92HXJDWascGR8UTGD7vs7yaXoU4uQLU1kIlKgm4wB19A/k8lTZ
        jwZD7u7yokTRoy+xMH5KjhFSeKn9BwA7Wba/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oyppYT7q6jl+vZzwD59OrQtw8HGe5Kie
        p31RghldPFngJJYBcfQa14VxpyQqTsRz48zbUIKCCgTrTvUTPuYJbaqhaYxRCKtR
        kUjycSQ3WrIix74NXZPAzdlrjLsZjpN2ZpVDRV6hDSEqU/N971w+PDLkv/PP0BX1
        oV2rgS+agTw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 72A78685DE;
        Fri, 28 Aug 2020 17:00:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B40B1685D7;
        Fri, 28 Aug 2020 17:00:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Drew DeVault" <sir@cmpwn.com>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        <git@vger.kernel.org>
Subject: Re: [PATCH] send-email: do not prompt for In-Reply-To
References: <C58UKAYKF1ZY.V5LLW3DY1KAY@homura>
Date:   Fri, 28 Aug 2020 14:00:00 -0700
In-Reply-To: <C58UKAYKF1ZY.V5LLW3DY1KAY@homura> (Drew DeVault's message of
        "Fri, 28 Aug 2020 14:39:02 -0400")
Message-ID: <xmqqk0xio59r.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 70945CE8-E971-11EA-A549-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Drew DeVault" <sir@cmpwn.com> writes:

> "You can give an empty answer if you are not responding to any message"
> could confuse users, because they might think -v2 is a "response", or
> maybe they've written the patch in response to a discussion on the
> -users mailing list, or any other number of reasons.

"Type the value you would have given to --in-reply-to command line
option (if you forgot to use it), or leave this field empty"
perhaps?  Those who do not know should be able to learn what
"--in-reply-to" is.  A prompt help is not the place to do a
documentation.

> I hate to be a nuisance over such a seemingly simple problem, but there
> are a lot of new users who are struggling here and I care about their
> struggle. What path should we take to fixing this issue for them?

The ideal way would be to craft step (0) well enough so that new
users trigger the To: prompt in the first place, which would
automatically make the problem disappear ;-)

