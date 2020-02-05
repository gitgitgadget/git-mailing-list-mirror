Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE807C35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 20:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D9B20720
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 20:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=monsieurbiz.com header.i=@monsieurbiz.com header.b="ACxeB+EQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgBEULt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 15:11:49 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42133 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgBEULt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 15:11:49 -0500
Received: by mail-lj1-f193.google.com with SMTP id d10so3614613ljl.9
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 12:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monsieurbiz.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YYgN9dbnrsNXCkQ30Z4Efaheg6KzihHqwwe95XWhPTk=;
        b=ACxeB+EQiIQjWJ547/PaXr6Z0XpT/uSFTTTqjXiK1Kb4dFUtGg22/VQAricSXEgO2U
         Cs3gaLF+hUc+qfhcz7Yt3dbp9d+NXPk48pCERjdjioMWURseCo9LImLv2n7eH3ykb6cG
         0L7rrm+phcBn91kFbPPj6BOBVW7SGrkV4uwO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YYgN9dbnrsNXCkQ30Z4Efaheg6KzihHqwwe95XWhPTk=;
        b=o9o9I7hYzUsTexQeV+qOzJsQNMvJcalg5EKpkMttacYOgjH1S7tOkSFHjKjNeyg3wE
         IvaHnbJeTfOejHT05eR73si7P87SXBqe55HDDdVraF0BL1/5JpsWLUcZTu+oYwTO65ng
         SsAiZn5Rg6YByLCIwVMHOjnS9TQBGxhCLgXD96f9NLQWO9ZuHh7fKp38WAbXJhyj9mMU
         tsJWxNUAwcNvM4I09a4oDl5URpyQcmd9sxo6+GYdUgSzExPwBn3p72UwAjvoJxX6Hi+J
         AE7WdO2yUfh2yFUqTHccDmFr3WkRmdg1GEvVpcDSqkqt5TMTj0OmYxbuW/3VH8MzD3w+
         qVkQ==
X-Gm-Message-State: APjAAAV2nVmqNti6OvlF6rsCadHYPnO5Gy5YU0Ll/uIh95sslQLj6X5y
        DkC9VUUtR525PBptmDlFz36OyvKExBfrUXrhbWWcJg==
X-Google-Smtp-Source: APXvYqz3T7kK/PV5Aby5yTXQ/cb0vcPiPBZFlCBPgKVYv/nuMzjU5UgVhBPrvcxaR/4DFSeHPhfu7uYWOqv0JLmqjXA=
X-Received: by 2002:a05:651c:299:: with SMTP id b25mr21972643ljo.1.1580933505823;
 Wed, 05 Feb 2020 12:11:45 -0800 (PST)
MIME-Version: 1.0
References: <010201671ebf523a-da55f2d8-876a-4b3b-a6fe-29d790bed2c1-000000@eu-west-1.amazonses.com>
 <0102017015765b98-e2e26f61-dd07-4a32-a72f-2d7b2159fffe-000000@eu-west-1.amazonses.com>
 <xmqqv9ok6fa1.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqv9ok6fa1.fsf@gitster-ct.c.googlers.com>
From:   Jacques Bodin-Hullin <j.bodinhullin@monsieurbiz.com>
Date:   Wed, 5 Feb 2020 21:11:09 +0100
Message-ID: <CAAwZSqCN9WShN4e-0i1Q0CwonPda_bysGjwyQcQC6-JC_U_KTg@mail.gmail.com>
Subject: Re: [PATCH] parse-options: lose an unnecessary space in an error message
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Actually I prefer to keep the parentheses, it makes better sense to me.
It feels correct with them when I speak it loudly, incorrect without.

BR,

Jacques

--=20
Monsieur Biz
@jacquesbh
+33 (0)6 75 54 11 97
GPG : https://keybase.io/jacquesbh


Le mer. 5 f=C3=A9vr. 2020 =C3=A0 19:49, Junio C Hamano <gitster@pobox.com> =
a =C3=A9crit :
>
> Jacques Bodin-Hullin <j.bodinhullin@monsieurbiz.com> writes:
>
> > Signed-off-by: Jacques Bodin-Hullin <j.bodinhullin@monsieurbiz.com>
> > ---
> >  parse-options.c          | 4 ++--
> >  t/t0040-parse-options.sh | 4 ++--
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/parse-options.c b/parse-options.c
> > index b42f54d48b96c..71dbe84d896b4 100644
> > --- a/parse-options.c
> > +++ b/parse-options.c
> > @@ -420,7 +420,7 @@ static void check_typos(const char *arg, const stru=
ct option *options)
> >               return;
> >
> >       if (starts_with(arg, "no-")) {
> > -             error(_("did you mean `--%s` (with two dashes ?)"), arg);
> > +             error(_("did you mean `--%s` (with two dashes)?"), arg);
>
> Makes sense.  Not just there is an extra SP before the question
> mark, the question mark is about the whole sentence, so pushing
> it out of the parentheses also is a good change.
>
> We might even want to lose the parentheses altogether, i.e.
>
>         did you mean `--%s` with two dashes?
>
> Hmm?
>
> Thanks.
