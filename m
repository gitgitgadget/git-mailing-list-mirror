Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B693BC433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 16:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88D6320756
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 16:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="aosBsJ4w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgHKQId (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 12:08:33 -0400
Received: from mout.web.de ([217.72.192.78]:52631 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728797AbgHKQIc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 12:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1597162106;
        bh=qZGkXpFwY1fDFI5H3n/VW02c0OM7N4JsdebVPrEVPo8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=aosBsJ4wxyntvg2uwR6sRUWzmVAfjp+HwFzLP3HwmSMsoP3xaYea6HCXgL3o0xp8F
         BsQEySOtR8/KOBirAgEnOdLFcNn2Ah7UOfiyeQAWzQIobQ993dHWMEaICAUPmSq8LA
         3aOy6e9i6jTbft6O6JKJIyGNJDdzD5W7tBm6jVJI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lopa3-1kc8g643JL-00gmr9; Tue, 11
 Aug 2020 18:08:26 +0200
Subject: Re: [PATCH 0/11] renaming argv_array
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20200728202124.GA1021264@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <82991f30-fe37-d6d2-ffd5-8b0878f46c83@web.de>
Date:   Tue, 11 Aug 2020 18:08:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200728202124.GA1021264@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PjoKrQ5J2WwS6HJNu1wtiNPDS9gqATHgc4OlG+aHRxuQQB02DXG
 GVVoCkevcoWmyxMuoNRgYG9daM5/TucEO8Qc1enci6gSoWR7cVv/YigUInoBi/gd4fFMc8J
 qtdsKKPS4IlBkktqzipik1EnjRFOobCrrzkdelDzEOxx0tYnFnJs1DSjG5S75RGoZoxO1NR
 yhx/tUGNXVSrp/THiPc3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:73y8A8OjmLA=:dl+mkOjXtNyuhRnSz6Bzaf
 sLy3XRNbFCgwIMnLksGK993MSIQq+o1LeZrRkOqcTCT6z4NsbwOLpqyYZXCwxVCZjjXGUQxIW
 f2FMe09eyfukyB2hslpc8hJgCWn4d2t593wrw5YWiOf4mo8MKBx+MS2A8hZJ8P5KMH+rfs3RN
 x4o/eLg6l1DfNdnTSo0xJAyrBjkc9qPPnDbylaSZfUlNMdoLHkSdh7yYHZjAlxWT7YWyGsj0w
 hkl3b0s3B31zgi4BvSEPC38zLnMp0qqNKZO5cOPEWJUWf5vc53EpGUQCI4rzN9b3pDdwlEIi5
 KHJcMGUjla5hQOIM+yGjstBHm/gUDEnvxP1wh9OFoOiQNo3/CUI4Of3RW/e2QQFqZZwuekdWJ
 e9ha4iKdxeLkRlD+UTfBwvnZtj9GXgm7L26KJQrG0Zdmnpml6mMSCvqXEeGOpNC8/YPkVyczg
 roiopg4sjQuf7j1f3hfwd+oMhGsEP4KMGiIIfhc8DWicyYUMlQsDsO4dSpxUMzS29dpdtcBZ1
 8DoJjE8/Ss5nqxsL234mWY7T15ovJ0ea/Y2by6Cuur/ZrIgNkFGGiuRDB3hOz/YBktX0u7TNV
 QT/obSPHPyK+9q88Vg7M54/dfZeG0uqkiQ4HEjRI9/MX4pmrUYy4+Q2V6OReqfKST+ZJFkQix
 i4E4/i4OH0m2AeWwqMOqeWAStPi0Ls4XdZ7RDOs3kzJp7rv8I98+65T1FTFXlAEnIZIvqB2yp
 Y7bRt0yMH4AJc0ZSpdNywjPfiQEvVP+oPVAI/Zcj2YbcabVrPsGQ48rk3vEMTYiZh8fIAWHa7
 6ppZdPGhLdb0EKmDxPiOqOje8ZGYNRLOBpIOY2UPUSb04rPiOseIFk0VwaLvfuQ6e6rjATFhT
 B4rAzUThD3/LDD0UdFYhf5G8MZcvTUXvpccUprJSOVxFY0NOLbqFPxTULjRJyZBg0vR4Zp4JQ
 Zujac78XPUMrNX+JDrj60sZz4V81IGdNfbuVBlTZVsKzRFRzG06mpnvkJuugj4YeeftBXSLMD
 BguuSl8UfTk7Ie+7mn7HiQlYDkv7VRX2o9yaJMSlEH/KSrysMDXwuK1iX9MOgHRBnGlJxLI6Z
 MbskOaaBRjS2VwTgo1d+d7HYy+PC8KESGm5ug2RN6MkdeDZqUx4l44sQZPBJl9h9qTV/8HIps
 OUStTdNFxd3Za5Mfagu1iR61N3wUfd5N1wmbg5VNyacthvqWfn0mIlEuON/r+JgSOJojALxUM
 svnfkXTuE8vXaSJwZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.07.20 um 22:21 schrieb Jeff King:
> The argv_array data type has turned out to be useful in our code base,
> but the name isn't very good. From patch 2 of this series:
>
>   The name "argv-array" isn't very good, because it describes what the
>   data type can be used for (program argument arrays), not what it
>   actually is (a dynamically-growing string array that maintains a
>   NULL-terminator invariant). This leads to people being hesitant to use
>   it for other cases where it would actually be a good fit. The existing
>   name is also clunky to use. It's overly long, and the name often leads
>   to saying things like "argv.argv" (i.e., the field names overlap with
>   variable names, since they're describing the use, not the type). Let's
>   give it a more neutral name.
>
> This has bugged me for a while, so I decided to finally fix it. It
> wasn't _too_ painful, though I'm sure there will be a little fallout
> with topics in flight.

Just as this landed in master now, https://lobste.rs/ decided to link to
http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2493.pdf, which is a
paper about reserved identifiers in C.  It contains a nice overview.

Anyway, 7.31 of C11 says: "All external names described below are
reserved no matter what headers are included by the program."  And
7.31.13 goes on: "Function names that begin with str, mem, or wcs and a
lowercase letter may be added to the declarations in the <string.h>
header."  So the names of the strvec functions are reserved.

Also how about using Coccinelle and patience to reduce the impact of
such a change next time?  I.e. adding the new thing, providing a
semantic patch for converting old code, waiting a reasonable amount of
time after the last conversion was necessary and then removing the
old thing.

Ren=C3=A9
