Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC28EB64DC
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 16:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjGUQfG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 12:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjGUQer (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 12:34:47 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632933A87
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 09:34:25 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5F0361A8B9E;
        Fri, 21 Jul 2023 12:33:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=RRYxj6ZK0Vzd
        iPIk5/DrhsGefRQ3FCHf7FabwHTdbMc=; b=FU4/xiZCP1nGxETC7/IEkWLE6ojX
        15YD0OFqUc96PT5jiFhAwdjtJkD6kgIk2+buqh0muPTU1TDrUlXQr2mHhco6aal9
        V8dtw2kpuIbMsivw79rNY7QdkvB/TcDpat0BNYjlvVjmxthKEk1OioXUwiRAlbZA
        cClnhoK5fyh1ZvQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 54E301A8B9D;
        Fri, 21 Jul 2023 12:33:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B27D51A8B9C;
        Fri, 21 Jul 2023 12:33:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Chris Torek <chris.torek@gmail.com>
Cc:     rsbecker@nexbridge.com, git@vger.kernel.org
Subject: Re: [BUG?] Confusion with git stash list
References: <046c01d9bbeb$a8680bc0$f9382340$@nexbridge.com>
        <CAPx1GvcxdJhAQA=sDJ7reu+shaeuzz+-xZKOoD0ZNo89hOgmbw@mail.gmail.com>
Date:   Fri, 21 Jul 2023 09:33:26 -0700
In-Reply-To: <CAPx1GvcxdJhAQA=sDJ7reu+shaeuzz+-xZKOoD0ZNo89hOgmbw@mail.gmail.com>
        (Chris Torek's message of "Fri, 21 Jul 2023 09:09:11 -0700")
Message-ID: <xmqqedl1w7ft.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5209C6F0-27E4-11EE-BFE8-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chris Torek <chris.torek@gmail.com> writes:

> On Fri, Jul 21, 2023 at 9:05=E2=80=AFAM <rsbecker@nexbridge.com> wrote:
>> It is simple to set up. You do need at least one stash, but the conten=
ts are
>> irrelevant. So given any repository, use git stash push. Then use git =
stash
>> list --all.
>
> The `git stash list` command is secretly just a front end to `git log`
> that inserts particular options, so `--all` is passed to `git log` and
> does what it does. That's why you see what you see (remember
> that `git stash list` includes `-g` / `--walk-reflogs` so `--all` here
> means "all reflogs").
>
> Whether this is *intended* is another question, but to stop it,
> `git stash` would have to notice and alter / remove `--all` before
> passing the rest of the command on to `git log`.

I do not think it was intended, but falls within the realm of "do
not do it, if it hurts" ;-)
