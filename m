Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AD1C433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 17:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347326AbiCXR2J (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 13:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352341AbiCXR2D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 13:28:03 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC03A8881
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 10:26:30 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BDB9E12B799;
        Thu, 24 Mar 2022 13:26:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=y/PfPzyUmKa2
        FvToh5erMC4sqd2OxY+6NagQaiS/dQw=; b=S3ugVfR1qDKWEndvusTUTQUb4CWF
        ijpPmKRNI3Ulbyz+Kv2geONxxwlfbcD1QWV4pbkYhCBSlIRB8gZ7EBNhdFL+hTDJ
        fi+gyYaY93O/0lNnVWOM0nTWM3kV+GCDwCv97JPF/oMSCxYFtT9/HUmxLJ8vFjpm
        FG+ksryXt9ATNuk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B519C12B798;
        Thu, 24 Mar 2022 13:26:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2A8AC12B797;
        Thu, 24 Mar 2022 13:26:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: A "why TAP?" manifesto
References: <patch-1.1-47b236139e6-20220323T204410Z-avarab@gmail.com>
        <nycvar.QRO.7.76.6.2203241434360.388@tvgsbejvaqbjf.bet>
        <220324.8635j7nyvw.gmgdl@evledraar.gmail.com>
Date:   Thu, 24 Mar 2022 10:26:28 -0700
In-Reply-To: <220324.8635j7nyvw.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 24 Mar 2022 14:48:42 +0100")
Message-ID: <xmqqczibjm7v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8A647830-AB97-11EC-AABE-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> =3D=3D It "can be parsed"
> =3D=3D Human readable
> =3D=3D It's trivial to produce
> =3D=3D It's more flexible
> =3D=3D It doesn't matter if nobody else uses it
> =3D=3D Everyone uses it

I agree with all of what you said above.

But do non-human readers really want to read output from an
"--immediate" session?  Don't they rather see the whole thing?

The only "Huh?" I had with the original patch that started the
thread was that TAP output currently does not work well with the
"--verbose" option, and I've never run our tests with the
"--immediate" option without the "--verbose" option to see where and
how the first breakage happens and what is left behind in the trash
directory, i.e. to bootstrap an interactive debugging session.

But not being useful for the use case of human reader running
interactively to get the leftover state does not mean improvement
for other use cases is not welcome.

> I think if you did the legwork of trying to make those formats represen=
t
> our "--verbose -x" output in a machine-readable way and tried to
> roundtrip that parsed output (which I have done for TAP) that you'd fin=
d
> it somewhere between "much, much harder" and "impossible" to do the sam=
e
> for those other formats in the context of our test suite.
>
> So yes, I agree that there's a lack of focus here, and we should put
> more wood behind fewer arrows in terms of making our test output
> machine-parsable.
>
> The [2] I mentioned above shows the sorts of wins we can get from that,
> i.e. emitting *only* the lines of test output relevant to the specific
> failures we had.
>
> That's really useful, and something you inherently can't do with the
> sort of approach you're going for in your [1] series.
>
> At least not without buffering the whole thing & parsing it, at which
> point you're back to square #1 in terms of fixing the sorts of issues
> noted in "Handling the long-tail of machine-readability" above.
>
> 1. https://lore.kernel.org/git/pull.1117.git.1643050574.gitgitgadget@gm=
ail.com/
> 2. https://lore.kernel.org/git/220302.86mti87cj2.gmgdl@evledraar.gmail.=
com/
