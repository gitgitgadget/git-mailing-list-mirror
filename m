Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C368EC433F5
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 21:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 954816101C
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 21:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbhISVXb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Sep 2021 17:23:31 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57515 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhISVXa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Sep 2021 17:23:30 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7204413FE07;
        Sun, 19 Sep 2021 17:22:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=s8IUX8t3A6UQxk3wMCr040t0t
        xhxs4oXOfOiLHIIs64=; b=Lu+ChGDWJQllBjA7jgiCNw/4S9DxY0e2d7EIQA0El
        nfmffC4h1PbeUWfzlGbCiK/L8hDJUWaEaAhLu+HvV+SBh3Th124ujehPeeBUN73X
        EQRAvos9/0ha+4NXcNhk23DI/ShcyriXeoJ4AWlYoYX6S1xCY4DAjNyxH82gXQ9T
        eQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6A8C713FE06;
        Sun, 19 Sep 2021 17:22:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D142713FE04;
        Sun, 19 Sep 2021 17:22:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC] range-diff: make output format more useful for
 "rebase --onto"
References: <xmqqv92yg5y6.fsf@gitster.g> <87r1dmcooj.fsf@evledraar.gmail.com>
Date:   Sun, 19 Sep 2021 14:22:00 -0700
Message-ID: <xmqqr1dkdzwn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A14AEF56-198F-11EC-8BBF-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> As for the proposed output, I'm a bit negative on it, so first, if we'r=
e
> trying to note that two commits are the same wouldn't it be much better
> to just omit the second SHA-1? I.e. consider this variation of your
> proposed output;
>
>      1 =3D 1 a05f02b1d9 a05102bfd9 : t/helper/test-bitmap.c: add  ...
>
> You might eyeball that for a while before discovering that I switched
> the "f" and "1" around, i.e. the SHA-1s look /almost/ the same. Isn't
> this better? (or we could use "++++++++++" to not overlead any meaning
> "----------" has):
>
>      1 =3D 1 a05f02b1d9 ---------- : t/helper/test-bitmap.c: add  ...

It will not serve my purpose at all.  Assuming that the first one
are the equivalent and the later ones are different, the point of
changing the format is to allow an easy cut-and-paste after "git
rebase --onto" to create:

    $ git rebase --onto a05f02b1d9 a05102bfd9

and it is useless to show dashes, as I do not think this would work:

    $ git rebase --onto a05f02b1d9 ----------

;-)
