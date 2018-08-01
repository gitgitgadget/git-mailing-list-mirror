Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFAE51F597
	for <e@80x24.org>; Wed,  1 Aug 2018 15:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389779AbeHARDf (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 13:03:35 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:52407 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389762AbeHARDe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 13:03:34 -0400
Received: by mail-it0-f66.google.com with SMTP id d9-v6so10133454itf.2
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 08:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DMTHhSwErjSw5Auot4RHeAt9AnsAmhg4u6My5bpqOy0=;
        b=QwJov0Q/b4S7KNM/f3QlzyGr6C+wn9w4ikQgWb2IIW9opi/pDPnWfSgnNEDLu9rtb3
         FQIqkWqg4nU/wKzKNkVLYj/bhzdj81JDXUG78GHF3kDXb7ONcs9bsb06lu2cXF5oMP18
         7sl7llRXWiPgcZOFzmbUl3IsiZ+hSJoBIQQTPIDBoGFOi2nepIzJ+xRZyje/OQwW448k
         F1wAMDPw0Duc7Zxo5W7jr1SRahCCP/BgP4+tYPyLMnsI7kSFG6yHQyP0illahh/w2Gnq
         O97pPpq0LN1wJmFacksHOon1KS1Ixm63i/Fq7Fkd45t5mKosDabpIDXWBfYTB4TFSM6U
         5NEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DMTHhSwErjSw5Auot4RHeAt9AnsAmhg4u6My5bpqOy0=;
        b=g9TYA+BsfqI38uivh99VGTLO0dOSihP2e7t/Jx3UZCZiaPW9pc8poY1qdqN2Mpol21
         DF8PYRPsGQr5+kpdG66hABWQPRSc8w+cNXV0tSojhUoDhfR1Trhaz/f6/03vPX7xrcsz
         8V11QajKUuRWaGek0o5BKfoKCGii6NZMbgModmWHYUUY/XmTa/69A0LMnq8k9a0jwbuh
         2zQe5E8yPO+beMaEUbG/D0A+Fm2KBmbxS7y7+4ZL06/Sv36cV1fY0PWjb3BV0fw5bZne
         5+tfMm/71+c7Pf4l9c5ifaqSpX3GxFCst2NzzEJrPuxiD5K7y9fDoLvE78l++SlVbk0e
         P1zA==
X-Gm-Message-State: AOUpUlE6AxhWep0oH2zMjM/vlDDned1dTeMvr6zn8EeVPwlz3c5h3LFL
        OrLoV2BMoWpAEF2BM2hmtMkwgKoLP020K8kUPLF90Q==
X-Google-Smtp-Source: AAOMgpdLYtheL27phmyCh63ENwBSnLLPjLdhQQm+dnpVdMqxJGlc+Pib0rqT5mBQ3LYMlEt8MnGXh+Lkf0Tufs/Mkjs=
X-Received: by 2002:a24:c888:: with SMTP id w130-v6mr4106902itf.78.1533136643294;
 Wed, 01 Aug 2018 08:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180729092759.GA14484@sigill.intra.peff.net> <20180730152756.15012-1-pclouds@gmail.com>
 <xmqqk1pbb4m2.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqk1pbb4m2.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 1 Aug 2018 17:16:56 +0200
Message-ID: <CACsJy8A_uZM7nUmyERNHJMya0EyRQYTV7Dp2ikLznxnbOQU6tw@mail.gmail.com>
Subject: Re: [PATCH/RFC] clone: report duplicate entries on case-insensitive filesystems
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Pawe=C5=82_Paruzel?= <pawelparuzel95@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 31, 2018 at 9:13 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
> > Another thing we probably should do is catch in "git checkout" too,
> > not just "git clone" since your linux/unix colleage colleague may
> > accidentally add some files that your mac/windows machine is not very
> > happy with.
>
> Then you would catch it not in checkout but in add, no?

No because the guy who added these may have done it on a
case-sensitive filesystem. Only later when his friend fetches new
changes on a case-insensitive filesytem, the problem becomes real. If
in this scenario, core.ignore is enforced on all machines, then yes we
could catch it at "git add" (and we should already do that or we have
a bug). At least in open source project setting, I think enforcing
core.ignore will not work.
--=20
Duy
