Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB01FC433EF
	for <git@archiver.kernel.org>; Mon, 30 May 2022 17:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiE3Rhz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 May 2022 13:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240245AbiE3Rhv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 May 2022 13:37:51 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63031562EC
        for <git@vger.kernel.org>; Mon, 30 May 2022 10:37:49 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BEC52197196;
        Mon, 30 May 2022 13:37:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=yD/+cvZTONdp
        F32fJTLK5Ru07GDXcFoNuVSmgzYz7/Q=; b=rlsDeawcNYnEegN5leLtXu/1tmTf
        IW6Mx5QixB/ux9cWO9naE+kqxXwSadoJzxS63OId670LZDshRmh8VjWHXZLMVMK3
        w//5jJ56g5xiBrcktKpNKnxJmES//LwKsI2q2L99RK+rJOSxvKPXq0mSmY/NYO0j
        +/AqtvOFMDiHX98=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B75C1197195;
        Mon, 30 May 2022 13:37:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5DC83197194;
        Mon, 30 May 2022 13:37:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v6+ 0/7] js/scalar-diagnose rebased
References: <pull.1128.v6.git.1653145696.gitgitgadget@gmail.com>
        <20220528231118.3504387-1-gitster@pobox.com>
        <nycvar.QRO.7.76.6.2205301205450.349@tvgsbejvaqbjf.bet>
Date:   Mon, 30 May 2022 10:37:43 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2205301205450.349@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 30 May 2022 12:12:46 +0200 (CEST)")
Message-ID: <xmqqwne2x6oo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 371F5118-E03F-11EC-B4B1-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Recent document clarification on the "--prefix" option of the "git
>> archive" command from Ren=C3=A9 serves as a good basis for the
>> documentation of the "--add-virtual-file" option added by this
>> series, so here is my attempt to rebase js/scalar-diagnose topic
>> on it to hopefully help reduce Dscho's workload ;-)
>
> I usually frown upon sending patches on other people's behalf without
> obtaining their consent first [*1*], but in this case I have to admit t=
hat
> I appreciate your help very much.

I understand what you mean.

Consider this as an extended form of the usual notes I send to a
thread to say "ok, based on the discussion I saw on the list, I'll
tweak OP's patch <this way> while queuing; thank you all for
contributing."  The way I try to convey <this way> can range from
words (e.g. when a reviewer points out a typo) to a fixup patch
(e.g. when the necessary update is a bit more involved), and this
time it took a full series with interdiff form.  Of course I do not
have to do any of the above and just leave it up to the OP to pick
up ideas from the discussion while sending updates, but sometimes
it is quicker to skip round-trips.

I do not say "Please holler if I misunderstood the discussion and
correct me, and the OP can always update/override with a rerolled
series." when I send out such a "here is how the version queued
would be different from the original" notice, but I always mean
that, this time included ;-).

Your "frowning upon" is understandable in that it can become a
hostile behaviour towards others, including the maintainer who is
forced to ignore or pick.  It is never fun to be in the position to
always exclude half of the patches posted to the list by
contributors who are competing instead of cooperating, and resending
a tweaked patch to show "here is how I would imagine is a better
version of your series" needs to be done with care.

Thanks.
