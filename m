Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CA6EB64D9
	for <git@archiver.kernel.org>; Thu, 29 Jun 2023 19:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjF2Th7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jun 2023 15:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjF2Th5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2023 15:37:57 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D671FE4
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 12:37:56 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6338B20A6A;
        Thu, 29 Jun 2023 15:37:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WiEW8Tcg29kY
        QkZ7sc+OQbuckOgwpHOnkIf467rpmO4=; b=EjjBtPszo66p/2t3Wz1xniZZG6ED
        /TBZ1YGVwEDeZAGdMQ14vPGfs3n3doSLKDvU6qn+GPlT9jXtXID1E+XaqI6lmJbU
        o+IlRgytBBdIe0JAiwbnEh86iUl7I0GZN0DRinFpKfq36dlCErIC/6Z07SkSnqrQ
        cEHKPr/ByYL58Wo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5B8BA20A69;
        Thu, 29 Jun 2023 15:37:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8A7C620A68;
        Thu, 29 Jun 2023 15:37:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 3/3] fsck: mention file path for index errors
References: <Y/hv0MXAyBY3HEo9@coredump.intra.peff.net>
        <Y/hxW9i9GyKblNV4@coredump.intra.peff.net>
        <305ccc55-25e3-6b01-cd86-9a9035839d06@sunshineco.com>
        <20230511161757.GA1973344@coredump.intra.peff.net>
        <CAPig+cQP736+944k40wgE8Vybk=ajD-kLTDHM6Y92dKEeWMB8g@mail.gmail.com>
        <20230511170133.GA1977634@coredump.intra.peff.net>
        <CAPig+cSeQKr-MNN7_44wuGBCYDMm8H+1mi+X6dd-0p2DkFY2sg@mail.gmail.com>
Date:   Thu, 29 Jun 2023 12:37:51 -0700
In-Reply-To: <CAPig+cSeQKr-MNN7_44wuGBCYDMm8H+1mi+X6dd-0p2DkFY2sg@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 29 Jun 2023 14:21:31 -0400")
Message-ID: <xmqqwmzm83g0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 70B3EE8C-16B4-11EE-812D-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, May 11, 2023 at 1:01=E2=80=AFPM Jeff King <peff@peff.net> wrote=
:
>> On Thu, May 11, 2023 at 12:28:45PM -0400, Eric Sunshine wrote:
>> > Yes, s/main/current/ probably would be helpful for future readers of
>> > the code. It's unfortunate that the term "current" can ambiguously
>> > also be read as meaning "the up-to-date index" or "the present-time
>> > index" as opposed to "the index in this directory/worktree", which i=
s
>> > the intention here. But "current" is consistent with the existing
>> > `struct worktree.is_current`, so hopefully should not be too
>> > confusing.
>>
>> I think in this context it should be pretty clear. Do you want to
>> prepare a patch?
>
> Done. As usual, I forgot to use --in-reply-to=3D<this-thread> when
> sending the patch despite having gone through the effort of looking up
> the relevant message-ID of this thread. Oh well. The patch is here[1].
>
> [1]: https://lore.kernel.org/git/20230629181333.87465-1-ericsunshine@ch=
arter.net/

I've queued your patch on top of the jk/fsck-indices-in-worktrees
topic as-is, but the earlier discussion in the thread shows that
Peff already is in agreement with the change, so I would not mind
amending in his Acked-by: later.

Thanks, anyway.
