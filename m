Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4291EC43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 19:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1628B206A5
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 19:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qWo88U7j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfLKTOP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 14:14:15 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:44130 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfLKTOP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 14:14:15 -0500
Received: by mail-io1-f68.google.com with SMTP id w3so4366596iot.11
        for <git@vger.kernel.org>; Wed, 11 Dec 2019 11:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rfYYJ28tt03Dz1tdx8tUy93FHx/d7Rb51EeJS3ZcNN0=;
        b=qWo88U7jqSBkCAD1CJyQ8jL9Un+ljtl40lQTcYKZG9rOpeqFocyIZcLFGTRxoXJSJ0
         kq0Uymb932HpjdE4Q2nT355y/MhWo1FeSrSqglGuPv50b0WTYz8Tzrh07qSKPhBNfPgW
         GBp4qHPIVFtV1Bsobc2xOlaw5eR/+kqwFaOl9qAycYQwckZGfzqpm9BaAMn6XeqteJXt
         Ni8GCKbvQxCwbHMPADl1fwH8yEnzuHjwm/mrcBhrbOsSRcvmhqTUkTOCztOcsmZdjM5e
         8PFxGBPc2gZAYZVHLeORGZHlX7BGz2BOYxe9ZAqkvju/09ZbvX2BdoE8lLe+5aHeHnPJ
         GoJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rfYYJ28tt03Dz1tdx8tUy93FHx/d7Rb51EeJS3ZcNN0=;
        b=gIIihU8XMOEEz4gnTvA1m8OtZXsVZINc9dAqeNK86Mzbdyc8p/ArSE37WR4vyKikSa
         eTXv3RZ2l5tokWvgCyBnCzfSirLDZHuXNhTxCBx2ZgvRqycj9wxYUqktEnD36yD0SoXk
         ZysnlEsm/W8Bf1lV6u09qR94qx16EV3DgJfP4nfzOJcwKgXljEwOuethQSvvoqANmxLk
         8hD+u24FmtJmLbF3vez4IUokDeNPKF2G4abv6mbnFg3uvp8SeVc8jVeDo6xyXKBDEjg3
         xUw2vzOgrGK37QYAblmc7avZ2VSEUsNzQT/3+QI8jIyhwwEvvi00emAEkrEQAqEVpsk8
         MRuQ==
X-Gm-Message-State: APjAAAUaZnZCmXzXrQo7v7WlYJ5UgFBLOde+7TAlpPkEj7CaIvTg3AC3
        E34OTiT+F06tYd1pa4N0ZLxF6xCG4aafTyUid3A=
X-Google-Smtp-Source: APXvYqzxvAsLL80yLeqK7n6K/BeL8u8LnroYnSX0qvi9ETEUQZioopleqbg2O0VD3tZ4jhwKLwbKGatkJ8EF6cmOcJw=
X-Received: by 2002:a5d:8744:: with SMTP id k4mr4021708iol.227.1576091654303;
 Wed, 11 Dec 2019 11:14:14 -0800 (PST)
MIME-Version: 1.0
References: <20191209103923.21659-1-mirucam@gmail.com> <xmqqo8wepyse.fsf@gitster-ct.c.googlers.com>
 <xmqqh826pyh4.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqh826pyh4.fsf@gitster-ct.c.googlers.com>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Wed, 11 Dec 2019 20:14:03 +0100
Message-ID: <CAN7CjDAYo=AZkVg4X_8iLLWTo43h=BBoOY+Ez-ODL0L_eb8xcg@mail.gmail.com>
Subject: Re: [Outreachy] [PATCH v2] bisect--helper: avoid free-after-use
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

El mi=C3=A9., 11 dic. 2019 a las 18:24, Junio C Hamano
(<gitster@pobox.com>) escribi=C3=B3:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Subject: Re: [Outreachy] [PATCH v2] bisect--helper: avoid free-after-us=
e
>
> It is surprising with multiple mentors, nobody noticed free-after-use
> is perfectly fine---it is use-after-free we would want to avoid.
>

Yes, you are right. I will send another version with the correct title.

Thank you,
Miriam

> > Miriam Rubio <mirucam@gmail.com> writes:
> >
> >> From: Tanushree Tumane <tanushreetumane@gmail.com>
> >>
> >> In 5e82c3dd22a (bisect--helper: `bisect_reset` shell function in C,
> >> 2019-01-02), the `git bisect reset` subcommand was ported to C. When t=
he
> >> call to `git checkout` failed, an error message was reported to the
> >> user.
> >>
> >> However, this error message used the `strbuf` that had just been
> >> released already. Let's switch that around: first use it, then release
> >> it.
> >>
> >> Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> >> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> >> Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
> >> Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> >> ---
> >> This patch is a new version of
> >> https://public-inbox.org/git/20191208172813.16518-1-mirucam@gmail.com/
> >> which itself has been sent previously by Tanushree
> >> (https://public-inbox.org/git/64117cde718f0d56ebfa4c30f4d8fe2155f5cf65=
.1551003074.git.gitgitgadget@gmail.com/).
> >>
> >>  builtin/bisect--helper.c | 7 ++++---
> >>  1 file changed, 4 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> >> index 1fbe156e67..3055b2bb50 100644
> >> --- a/builtin/bisect--helper.c
> >> +++ b/builtin/bisect--helper.c
> >> @@ -169,11 +169,12 @@ static int bisect_reset(const char *commit)
> >>
> >>              argv_array_pushl(&argv, "checkout", branch.buf, "--", NUL=
L);
> >>              if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
> >> +                    error(_("could not check out original"
> >> +                            " HEAD '%s'. Try 'git bisect"
> >> +                            " reset <commit>'."), branch.buf);
> >>                      strbuf_release(&branch);
> >>                      argv_array_clear(&argv);
> >> -                    return error(_("could not check out original"
> >> -                                   " HEAD '%s'. Try 'git bisect"
> >> -                                   " reset <commit>'."), branch.buf);
> >
> > The original obviously was bad X-<.  Will queue.  Thanks.
> >
> >> +                    return -1;
> >>              }
> >>              argv_array_clear(&argv);
> >>      }
