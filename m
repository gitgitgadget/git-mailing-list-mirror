Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF78C04A94
	for <git@archiver.kernel.org>; Tue, 15 Aug 2023 19:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239478AbjHOTCr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Aug 2023 15:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239701AbjHOTCY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2023 15:02:24 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A311FF2
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 12:02:05 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2725C191BFD;
        Tue, 15 Aug 2023 15:01:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LU696S2D1QAveRVvB1weUb5ErU2Jxrce7dDKfF
        xbnnY=; b=yjO5fhHdJGJI+0iOpPgcVzJqLvfLDNVP3/g+Q00ONtYIVETWxKXo0n
        kTwMHFADQLqzb20LLFHW5+AcuJ902AbR0FOm8Xf+zWHqSymwFHsceHWgvhPUckBI
        7jDzMKPHoBffkwjoGngwC2npzIjBfRf3prMrnHWpcCa0rjA8Xy0dc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E1A0191BFC;
        Tue, 15 Aug 2023 15:01:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 84F3E191BFB;
        Tue, 15 Aug 2023 15:01:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andy Koppe <andy.koppe@gmail.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] pretty: add %(decorate[:<options>]) format
References: <20230715103758.3862-1-andy.koppe@gmail.com>
        <20230715160730.4046-1-andy.koppe@gmail.com>
        <kl6l351j22dr.fsf@chooglen-macbookpro.roam.corp.google.com>
        <CAHWeT-ZA8f-TGRwDHixAvi5kddVBbuK8LpVGJ9cjYZMsMk5ODw@mail.gmail.com>
        <xmqq7cpwjhr1.fsf@gitster.g>
        <006574bd-4d53-495e-8cfe-677ede521908@gmail.com>
Date:   Tue, 15 Aug 2023 12:01:11 -0700
In-Reply-To: <006574bd-4d53-495e-8cfe-677ede521908@gmail.com> (Andy Koppe's
        message of "Tue, 15 Aug 2023 19:28:48 +0100")
Message-ID: <xmqq350kjfk8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A34E502-3B9E-11EE-BC2C-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andy Koppe <andy.koppe@gmail.com> writes:

> On 15/08/2023 19:13, Junio C Hamano wrote:
>> If there is 'main' that is different from 'master', that sounds like
>> a problem to me.  This project predates the newer convention that
>> allows the primary branch to be named 'main', but many new folks of
>> course expect to see 'main', so while my primary working areas all
>> call the primary branch 'master', it is pushed out to both names.
>> Or at least I thought I arranged that to happen.
>
> See [1], where main currently is at v2.41.0.
>
> Regards,
> Andy
>
> [1] https://github.com/git/git/tree/main

Ah, that one.  The CI job is unfortunately attached to that tree and
updating 'master' and 'main' with the same commit at the same time
wastes CI cycles, so I had to tentatively stop updating it.

It used to be that 'main' was set to lag behind 'master' by 24 hours
or so to prevent the problem---CI notices that the commit updated
'main' has been already dealt with 24 hours ago at 'master' and
refrains from wasting time on it.  But resurrecting it would still
make folks confused about how 'main' is different from 'master'.
Perhaps it is a good time to remove stale 'main' and keep only
'master' there?



