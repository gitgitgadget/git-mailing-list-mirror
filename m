Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A8DC4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 16:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 210426101A
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 16:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhHSQ65 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 12:58:57 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57035 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbhHSQ65 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 12:58:57 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EA1EF156C7C;
        Thu, 19 Aug 2021 12:58:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nDSYpem0fe4Ih9WPukcwHug4Rrll02ggpgiHJf
        c79gs=; b=is2hafXC1wBvQBIv9vdFgmvQjMd6W0qy0wkt+/tfBwvks7HuQ9asGn
        gZwOyxCgKyedVF/TaDlQngE9tdPsv3iXUfSsdcx1wDodk1Ooc3LTLwBzl8oH0R3b
        wBux7D0qV4t+X+lv7aGpfrYmplIFk2EzCuY30h6yOBtxdnbLchzMg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E2832156C7B;
        Thu, 19 Aug 2021 12:58:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 36627156C78;
        Thu, 19 Aug 2021 12:58:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Thomas De Zeeuw <thomas@slight.dev>
Subject: Re: [PATCH] diff-lib: ignore all outsider if --relative asked
References: <40BE2EF2-0AF3-45BA-9880-8A6011B38D03@slight.dev>
        <bc7eda4ed8d52072b929a4af6e4e4ed7478ef9d6.1629361733.git.congdanhqx@gmail.com>
        <CAPUEspg+LUP59DJ+Z-AqKW0hfz=AbMfvOTFLe1rT5g5auV7gdA@mail.gmail.com>
Date:   Thu, 19 Aug 2021 09:58:16 -0700
In-Reply-To: <CAPUEspg+LUP59DJ+Z-AqKW0hfz=AbMfvOTFLe1rT5g5auV7gdA@mail.gmail.com>
        (Carlo Arenas's message of "Thu, 19 Aug 2021 02:02:43 -0700")
Message-ID: <xmqqsfz52wyf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A6DDF5F6-010E-11EC-B148-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> My only concern is that it seems this has been broken for a while
> (couldn't bisect, but AFAIK the first implementation did filter like
> this one does), so some people might be expecting the broken
> behaviour.

I do not think it is likely.

It only shows changes to unmerged paths outside the current
directory, which does not sound all that useful.
