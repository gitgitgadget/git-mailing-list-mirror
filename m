Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B583BC433EF
	for <git@archiver.kernel.org>; Thu, 28 Apr 2022 21:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352006AbiD1VLT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Apr 2022 17:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352011AbiD1VLR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Apr 2022 17:11:17 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87A6C12C2
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 14:08:01 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 723A717DF87;
        Thu, 28 Apr 2022 17:08:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2hGX+BuwBGbq7vOg5f4qLjaYEzi8Q+l38Ofpen
        Rz71M=; b=tMASGTKkGzPX08Tj5QeR+jEWVdzvx2iMBGTK7ATawewFoU3TPtUWBm
        L493xs3B2U9BuCu2/eVB18yX23LpRh1QTvjs7VxgNK/sdUdxShJkx+6Zu2IRr2++
        UgVo4M52T0hiiNCA7oAz/ED/o85cjKT7gyatc1nHxiNXRAsRA5oH8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6CD1E17DF86;
        Thu, 28 Apr 2022 17:08:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F2AB417DF81;
        Thu, 28 Apr 2022 17:07:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] t: add tests for safe.directory when running
 with sudo
References: <20220428033544.68188-1-carenas@gmail.com>
        <20220428105852.94449-1-carenas@gmail.com>
        <20220428105852.94449-4-carenas@gmail.com>
        <xmqq7d79du6c.fsf@gitster.g>
        <CAPUEspiCjQRiaOcvSVgS5cZ9q=o6YeZgjp5s3BRZEByD=9Un2Q@mail.gmail.com>
Date:   Thu, 28 Apr 2022 14:07:56 -0700
In-Reply-To: <CAPUEspiCjQRiaOcvSVgS5cZ9q=o6YeZgjp5s3BRZEByD=9Un2Q@mail.gmail.com>
        (Carlo Arenas's message of "Thu, 28 Apr 2022 14:02:24 -0700")
Message-ID: <xmqqv8usex1v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 479AA5CC-C737-11EC-BBD4-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

>> Overall, I like the simplicity and clarity of "do not start this
>> test as 'root'" in the previous round much better.
>
> I disagree, and think that the fact that the second test changes
> behaviour with this series proves my point.

I do not know which second test you are talking about, but anyway.

> Either Way those issues are orthogonal to this change and would be
> happy to discuss again after v3 which is still not ready and will be
> posted most likely as an RFC including as much as can from the
> feedback provided so far.

Sure. Looking forward to seeing a version that does *NOT* abuse
prerequisite mechanism.  We are interested in testing an ordinary
user becoming root via sudo in these tests, so reject whoever starts
the test under 'root' upfront like in the earlier round.

Thanks.
