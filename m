Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DE0C433DF
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 16:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0271F2087E
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 16:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="i3WqRl0c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403764AbgJLQdy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 12:33:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58000 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgJLQdx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 12:33:53 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DC5768BD3B;
        Mon, 12 Oct 2020 12:33:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=aTKzo2LJIvWb
        TMJqYAuobKHFEfQ=; b=i3WqRl0crL3XJzZ7NRVp6RmOnMiVzY10JQVqERWm1NCq
        fBymiqujUzGqj6bYriSXt3ds9rhby3c/nbzoObqX+CfffWkIwaPIXAMp9LaGr1qG
        VSa6IExm3HvFxqJhs8rSCLN+tdH6o2VfZZyCEVdNE/iELzz2wDZ6KcVuL9jQ8BA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=vjfrYV
        ikfE2kTfVoh1rMg6w/4QaQeFYHeUfFaX+leMGI6YpFw8Cm1D6R4KuVPUYz7a887P
        vE1HGKjKrwGkiIrp/J0Mr6xV0svBHm5t0xOrDvO5jHu0frWnwwHH9pN7CyRBLsFB
        9iU6kQD+tC+4W7Rk4IZvmcX4AgoVxZoCZJxZQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D43A88BD3A;
        Mon, 12 Oct 2020 12:33:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 61BF18BD38;
        Mon, 12 Oct 2020 12:33:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.29.0-rc1
References: <xmqq7drzv1bn.fsf@gitster.c.googlers.com>
        <ce8f482f-9a78-6867-38ae-601bcc2c9f66@web.de>
Date:   Mon, 12 Oct 2020 09:33:50 -0700
In-Reply-To: <ce8f482f-9a78-6867-38ae-601bcc2c9f66@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 10 Oct 2020 18:45:07 +0200")
Message-ID: <xmqqmu0rqu8h.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B61B2594-0CA8-11EB-B21B-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> The option --add-file in rc1 is peculiar in that it captures the value
> of --prefix at the time of left-to-right parsing.  I don't know any
> other option that does that.

If you do not count the early design of "git update-index", where
you could do funky things like

    git update-cache must-exist --add new-file

to affect the way each path argument is taken, that is ;-)

I am not sure if that is a useful feature, but I do not see a reason
to add more code just to forbid giving the prefix argument multiple
times.  As the main archive contents taken out of tree use just the
single "--prefix", I suspect nobody would even imagine giving
multiple "--prefix".

> It gives users a way to craft in-archive
> paths, but simply adding them with their original path (just normalized
> to use slashes as directory separators) would probably suffice.
>
> The option serves a niche use case, so this weirdness might be bearable=
,
> but I wouldn't have expected it to be merged without debate.  Perhaps
> we want to slap an "experimental" label on it?

I have no strong opinion on this.

If this "feature" were experimental and if the experiment turns out
to be a failure, would we have a viable alternative definition?

Perhaps "--add-file names an untracked file in the working tree and
the single '--prefix' that is used for entries that come from the
tree object is applied"?  Or perhaps remove --add-file entirely as a
failed experiment?

