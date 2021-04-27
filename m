Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12922C433B4
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 07:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D17C061177
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 07:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbhD0H2q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 03:28:46 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64030 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbhD0H2p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 03:28:45 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 11C3913384A;
        Tue, 27 Apr 2021 03:28:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z8dFpZnYhUzL35rcWHB4ZCHJ7JYUqHaTZM1OBA
        BZOQ4=; b=gb0C6ZakB2wr/+l5fROrMeESipb5EgO1otNGYzEGniTdgTxH6vDFJ6
        JT/2MAIq6jE/6nrM6hjF2rmrKNrLZBGcySK9MTRyxCM8xqAewpmJQ99qworov4QK
        YINrbwvxxfX3zj3Gf9UiaRn4AYZhLtGWUC+N4e73ubC/KuNTc5lng=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 09D05133849;
        Tue, 27 Apr 2021 03:28:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 46058133847;
        Tue, 27 Apr 2021 03:27:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Shumaker <lukeshu@lukeshu.com>
Cc:     git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Danny Lin <danny0838@gmail.com>,
        "David A . Greene" <greened@obbligato.org>,
        David Aguilar <davvid@gmail.com>,
        Jakub Suder <jakub.suder@gmail.com>,
        James Denholm <nod.helm@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Roger L Strain <roger.strain@swri.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        Luke Shumaker <lukeshu@datawire.io>
Subject: Re: [PATCH 00/30] subtree: clean up, improve UX
References: <20210423194230.1388945-1-lukeshu@lukeshu.com>
        <87wnss2219.wl-lukeshu@lukeshu.com>
Date:   Tue, 27 Apr 2021 16:27:57 +0900
In-Reply-To: <87wnss2219.wl-lukeshu@lukeshu.com> (Luke Shumaker's message of
        "Fri, 23 Apr 2021 14:12:34 -0600")
Message-ID: <xmqqlf94dw5e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 17B3D97E-A72A-11EB-A998-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke Shumaker <lukeshu@lukeshu.com> writes:

> On Fri, 23 Apr 2021 13:42:00 -0600,
> Luke Shumaker wrote:
>>                                                  I promise that
>> there's more work coming on top of it (we've discovered lots of ways
>> to break the "subtree split" algorithm, and come up with fixes for
>> most of them).
>
> Follow-up question: If in that work I changed the shebang from
> "#!/bin/sh" to "#!/usr/bin/env bash" and started using Bash arrays,
> would that be so bad?  Would that be land-able?

I'd rather see "git subtree" tool taken out of my tree and flourish
as a standalone project of its own.

Over its long history, from time to time people stepped in only to
scratch their own itch and then went away.  Without having continued
presense of an area expert (or two) who can give consistent guidance
to the tool's evolution, I feel that Git project itself failed to
give sufficient service to users of "git subtree".

As I won't be that area expert, and we do not seem to be growing
such an area expert who can be responsible for the tool in the long
haul, it probably is a disservice to its users to keep it in my tree
and pretend that it is maintained to the same degree as the rest of
Git.

If those who are interested and/or have stake in the "git subtree"
tool can unite and take its development in their hands, with their
own style, that might be better for the health of the "git subtree"
tool in the long run.

Thanks.



