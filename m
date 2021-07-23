Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B41C4320E
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 16:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39BDB60EB5
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 16:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhGWPkq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 11:40:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60447 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhGWPkk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 11:40:40 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E4D06D3C9F;
        Fri, 23 Jul 2021 12:21:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=HgiJBt1SYoeu
        8XAr3MEyrNe15XkrNUGefhKjWJan/3s=; b=hGI7FEe3v+jvH2xABMRapR23SB9d
        bYhA2Sbb1sIBIOSpxoDW+3NRsc8mR5dqabuOG0snd3plaROgkyrlHs33zxZB7i3u
        lrJM8RXGAxaJJJ23FP7fJDQef2avqh5cc2N1Z1yt4pgwCRwsARr/XjosbOS2G+4E
        qFN4gpr0IgDE7lk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D9FC3D3C9C;
        Fri, 23 Jul 2021 12:21:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 604BBD3C9B;
        Fri, 23 Jul 2021 12:21:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>,
        "Tom G . Christensen" <tgc@jupiterrise.com>,
        Mischa POSLAWSKY <git@shiar.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/5] drop support for ancient curl
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
        <cover-0.5-00000000000-20210721T220402Z-avarab@gmail.com>
        <YPqW8lAcwno3j7Fq@coredump.intra.peff.net>
Date:   Fri, 23 Jul 2021 09:21:11 -0700
In-Reply-To: <YPqW8lAcwno3j7Fq@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 23 Jul 2021 06:16:18 -0400")
Message-ID: <xmqqo8atovbc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FF04BBAE-EBD1-11EB-9F95-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Jul 22, 2021 at 12:22:11AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>
>> This series is a re-roll of patches found in Peff's GitHub repo at
>> jk/no-ancient-curl, which were already-rebased versions of those
>> patches. His original on-list version had his Signed-off-by, but the
>> range-diff is against that branch, hence the addition of
>> Signed-off-by in the range-diff.
>
> Heh, OK. It's a little surprising to see random junk pulled out of my
> GitHub repo, but in this case I was holding onto them with the intent o=
f
> eventually resending after more time passed.
>
> So I'm happy to see these cleaned up and posted. I think what's on that
> branch should be good-ish, in the sense that I've been rebasing it
> forward as part of my daily routine, and it's part of the build that I
> use day-to-day. Though apparently I never applied the CURLOPT_POST301
> fix. :-/

Thanks.

> I know my S-o-b was on the originals to the list, but just to make
> clear: I am fine with using them on the rebased versions you grabbed.

Good.  S-o-b is merely "I can let the project use it" and does not
say "I agree this is (still) relevant in the context of the code
this is being submitted to", so the above note is very much
appreciated.

> So modulo the commit message tweaks that Junio suggested, this all look=
s
> fine. I actually think my original "#error on too-old curl" is still
> reasonable. Yes, people whose distro has backported all of these
> features could possibly still use it. But in that case they likely know
> what's going on and can rip out the #error. It seems much more likely
> to me that it _won't_ work, and they'll get confused by obscure errors
> when they try to use an old curl.
>
> But I don't feel too stronlgy about it either way.

Me neither.  Those who are vanilla would not be helped by having it,
as their build would fail if their cURL is too old anyway even
without it.  Those who backported would have a build that may or may
not work, but diagnosing it is part of the job of backporting their
cURL anyway.  So in practice, I think "#error if you are older than
X" primarily would serve documentation purposes (which may be worth
doing, but requirements listed in INSTALL would probably be a better
alternative anyway).

Thanks.
