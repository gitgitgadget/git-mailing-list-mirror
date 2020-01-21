Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063FBC2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 17:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5BCA20882
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 17:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="R5/HgKig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbgAURxu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 12:53:50 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59336 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgAURxt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 12:53:49 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AEE2A56DAE;
        Tue, 21 Jan 2020 12:53:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=e2UzFOrzBLvi
        yBKt0EftbCBz76U=; b=R5/HgKigK6/u8KYEHt/SXJgxOYdabULvMn6A2bhyCmx6
        FRoh8X3YCTVtg5UIO1lTGR/7nWACefGG4Z0R6iSmISHpwxL0xqlgXIyACafUFXDy
        h/GXCdkN+O8QKKSzHxZ6Dlh/ftlUjpnKGT0vSWBQYyIpMgE1NgmwOiL4Np+IoYY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=HlPsu/
        dNY+5ZZfiK6cEWl7ol3V/ADKlCddg7M9/lvR2Cw/3EYhLPtFKaWGSGUDqg4p6ZwP
        wxHpVvjaYrmR6AF6swzY7aV1FhKTNy7Nl0DjZMF3oTyF/E3bPk4vFOwQz+EgnBus
        GOu7ZwSTMS5BbA5+VrAzBj/Oi77HAXdZS5VUs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A5AEA56DAD;
        Tue, 21 Jan 2020 12:53:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0D2FD56DAC;
        Tue, 21 Jan 2020 12:53:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>, jrnieder@gmail.com,
        git@vger.kernel.org
Subject: Re: Patchwork instance "Submitter" attribution and GitGitGadget
References: <75987318-A9A7-4235-8B1D-315B29B644E8@gmail.com>
        <nycvar.QRO.7.76.6.2001201314580.46@tvgsbejvaqbjf.bet>
Date:   Tue, 21 Jan 2020 09:53:45 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2001201314580.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 20 Jan 2020 13:16:02 +0100 (CET)")
Message-ID: <xmqqiml4bsra.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F911F45C-3C76-11EA-825A-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sat, 18 Jan 2020, Philippe Blain wrote:
>
>> I=E2=80=99ve noticed that all (I think) patch series sent to the list =
using
>> Gitgitgadget are attributed to Dscho (Submitter is "Johannes Schindeli=
n
>> via GitGitGadget") on the patchwork instance [1]. I don=E2=80=99t know=
 if you
>> are aware of that or if there=E2=80=99s a way to fix it in patchwork=E2=
=80=A6
>
> Right now, it shows "Lucius Hu via GitGitGadget". Clearly, patchwork us=
es
> only the email address as identifier, being unprepared to accept that t=
he
> same email address might be used by multiple contributors.

Would it help to use the "Sender:" header?  IIUC right now GGG
records its name on "From:" with its e-mail and a human-readable
name derived from the author of the ptach, but if it can record the
true author on "From:" and leave GGG's name on the "Sender:", would
patchwork use the "From:" side of the identity instead?

If that works, it would have an additional benefit of not having to
add the in-body "From:" to override the mail-header "From:", to avoid
attributing the authorship to GGG.


