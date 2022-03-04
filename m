Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA39FC433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 03:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbiCDD5h (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 22:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiCDD5f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 22:57:35 -0500
Received: from mail-41103.protonmail.ch (mail-41103.protonmail.ch [185.70.41.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EA417F6B0
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 19:56:49 -0800 (PST)
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-41103.protonmail.ch (Postfix) with ESMTPS id 4K8vDb3n49z4wxwG
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 03:56:47 +0000 (UTC)
Authentication-Results: mail-41103.protonmail.ch;
        dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="iuzNAKKm"
Date:   Fri, 04 Mar 2022 03:56:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1646366202;
        bh=rMnWW469fXGSZnVvg4lhCZKpZCssA4YmXqvuvItmKHg=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=iuzNAKKmFtEsGVvzYIH3/uiaDv+85EGw/JbPQwRwQLnuJXsQiR3DwVTyhU0UQ51ha
         fPLIfM8Io5lbiS44xCOFwuDVLuIQ7ZQtGLhMsNjA3rFc5cf1xT1kL8vcevYdIWiT3K
         X7qY1oEbXh8SZf9fJG5G57AEJNg5Wfa09oG9iAPjmjy1tyUP0ZTNKIKAAj5pLpw1mC
         Tdu7VHukg8RszfmYtq+5Z+EhJq+9o3TFzEFEwvy97PiBZwhWSKU2hZ06qdklERi+kR
         U8ZMpJOEl8DTv88DHIY4d7ISJmmtp+2jGn+rp7BfPW1j6TiMQHBqWhV2hLzAIQpWbw
         JPWV+5cZd0IrA==
To:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
From:   Matheus Felipe <matheusfelipeog@protonmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Matheus Felipe via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Reply-To: Matheus Felipe <matheusfelipeog@protonmail.com>
Subject: Re: [PATCH] fix: include the type flag in the cli docs
Message-ID: <Uywg4gVveJ2mBefUUQDfm4i2U4gv2dk_MDNu1GhqklSMya5McKJ7n8enKWDFq_mWrfWlSDlxwSVBNwEAuq27osjfDNJziIy0EIE0nsVmsqM=@protonmail.com>
In-Reply-To: <220228.86a6ea38z9.gmgdl@evledraar.gmail.com>
References: <pull.1220.git.git.1645853661519.gitgitgadget@gmail.com> <f171e157-7dbc-b07e-7164-c62e2427fbe2@gmail.com> <xmqqilt03xat.fsf@gitster.g> <220228.86a6ea38z9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On 26/02/22 12.34, Matheus Felipe via GitGitGadget wrote:
>
> > From: Matheus Felipe matheusfelipeog@protonmail.com
> > When the `git config --global --help` command is invoked,
> > the cli documentation is shown in the terminal with a small
> > error in one of the values of the Type group, which is the
> > absence of the type flag in the `--type` argument.
> > This commit fixes that.
>
> What about the commit message below?
>
> ```
> The usage help for --type option of `git config` is missing `type`
> in the argument placeholder (`<>`). Add it.
> ```

This commit message just got better, thanks. I will update with this messag=
e.

> > - OPT_CALLBACK('t', "type", &type, "", N_("value is given this type"), =
option_parse_type),
> > + OPT_CALLBACK('t', "type", &type, N_("type"), N_("value is given this =
type"), option_parse_type),
>
> The help should be `give the value the specified type`.

About the help message, I believe the current one is adequate, as Junio C H=
amano well described.

It is also worth remembering that PR proposes a change from "" to "type" on=
ly, as recalled by =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason.

