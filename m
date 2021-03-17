Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E73C433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 06:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D27B64F92
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 06:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhCQGGc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 02:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbhCQGGN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 02:06:13 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF977C06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 23:06:13 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so466380otb.7
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 23:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fQN52B5j5gyezxKJqzTLrJbX0OAO5kfqe+SU4RCN8b4=;
        b=T5xqOIYg3JMIzEg2HfOKu0A1BJkqZbzer8KT4U/snbkfvfz+Xfcn137/AbKeIv7J7k
         m/kRcR0q/U+d8G1MNSmWvdrTHJf5ybx6Uvjv4cxzJa+n9yhzeOdX0GZA5/TOlWtxtCep
         gU8KqOwD+Rg2gm40Go5HV2ElfhCYuZCGw2Xf09MAqHwTMvnj0rvWDtIZPzfPUpTesW9K
         7zaYd4AJAgQ1dRb+c7Qq/Ty0oSq/ukbYJQQSZ86Fuqtr3Tt/pDKTczMUaFAyQeuGANWz
         gMHB00eD1/eaE6RSw/k8Z9bK1LLUer1HC9rnNNn5OdTJaInDeIYaX+C/E9HJfEtZp8D8
         wu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fQN52B5j5gyezxKJqzTLrJbX0OAO5kfqe+SU4RCN8b4=;
        b=npIod3QB+FWXOsoFueHEqStHT1v84ft5nACGINfbUuvlWzvM5VuGSongJmrxmBp8MI
         5tbSS1pjeFxBtD7sxpHxW4V/lo1Phb2M966W64hjoPAuAOpCH458mWp21vrsAmvXatJA
         MD3VMGVTYVDybScg60C3H1hUJJbAzOWSvVMyOiNNnugTtP6A95HWcjuKpnILgg5OOhHW
         nKw3WkIrkLR1TIpHvTlR8mNjZHh30joVCNgZ0swDIch73ZnYuF30yS4Ng63cuFY6qZ/S
         7SKMFqCv+vuI6Och7w44mfPAmgnXmYVfCLMiUCCe7J1TU57EKV06+jaSiwUm5VHkmn0A
         NZiQ==
X-Gm-Message-State: AOAM533QLId3DDCXwiHSIWWNmV5YsaJnqOU89FvWea01RYJQHVtjKZCh
        bkwT2aoxcDSkRqtBROIgeG5zDyvH+ofYtxrhaZ0=
X-Google-Smtp-Source: ABdhPJyDNjLBc2TryanYfVXc3rzegHTuuTGpsjPROCTXGFVDttg7Uh+dkfy6+WwB96/XieVFjbZP/PtZw/5s95PiHLw=
X-Received: by 2002:a05:6830:17d7:: with SMTP id p23mr2013621ota.164.1615961173228;
 Tue, 16 Mar 2021 23:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.901.v8.git.1615813658.gitgitgadget@gmail.com>
 <pull.901.v9.git.1615891183320.gitgitgadget@gmail.com> <20210317052641.GA8212@konoha>
In-Reply-To: <20210317052641.GA8212@konoha>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 17 Mar 2021 14:06:01 +0800
Message-ID: <CAOLTT8RaGiMudqn7ezV_fJUg01pZZUPyx9xSaFwSzX255MbpSw@mail.gmail.com>
Subject: Re: [PATCH v9] [GSOC] commit: add --trailer option
To:     Shourya Shukla <periperidip@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <periperidip@gmail.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8817=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=881:26=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On 16/03 10:39, ZheNing Hu via GitGitGadget wrote:
>
> Hey ZheNing!
>
>
> I have been away for a while and directly seeing a V9 of this patch
> feels great! Its good that you have worked upon the patch. The above
> approach seems good to me!
>
Hi! :-)
> >       /*
> >        * Reject an attempt to record a non-merge empty commit without
> >        * explicit --allow-empty. In the cherry-pick case, it may be
> > @@ -1507,6 +1528,7 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
> >               OPT_STRING(0, "fixup", &fixup_message, N_("commit"), N_("=
use autosquash formatted message to fixup specified commit")),
> >               OPT_STRING(0, "squash", &squash_message, N_("commit"), N_=
("use autosquash formatted message to squash specified commit")),
> >               OPT_BOOL(0, "reset-author", &renew_authorship, N_("the co=
mmit is authored by me now (used with -C/-c/--amend)")),
> > +             OPT_CALLBACK_F(0, "trailer", NULL, N_("trailer"), N_("tra=
iler(s) to add"), PARSE_OPT_NONEG, opt_pass_trailer),
>
> I feel that a better option description could be offered? Maybe
> something like: 'add custom trailer(s)'.
>

Feel ok.

>
> >               OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-b=
y trailer")),
> >               OPT_FILENAME('t', "template", &template_file, N_("use spe=
cified template file")),
> >               OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commi=
t")),
>
> I have not yet gone through the the V2-V8s but I have a comment not
> associated with the contents of the patch. I feel that you should wait a
> little before posting a new version of the patch. I see that V4-V8 are
> put up in almost 3 hour gaps. This isn't technically wrong or prohibited
> by the communication rules of the List but I feel that posting a patch
> in such short intervals makes it hard to review and unnecessarily
> increases the versions of the patch. The reviewer lags behind the patch
> series in fact.
>
> What you could do instead is post one patch per day instead of 3-4 in
> one single day so that your patches get thorough reviews. This way, you
> won't create 3-4 new versions of the patch containing not-so-many
> significant changes. You get me?
>

Get it. Especially seeing =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason give me co=
mments
behind the new iterations I posted, I knew that I might be sending new
versions too frequently.

> Also, in your reply on the V1 here:
> https://lore.kernel.org/git/CAOLTT8SpAOj51jqYUYqYwXaVKSn1fANvetauaG0z4eti=
BMzVEw@mail.gmail.com/
>
> I read:
>
> > It's exactly what you said.
> > My lack of English sometimes limits my expression.
>
> It is okay please do not worry. Neither do we have English as our first
> language nor have we ever communicated this much with an English
> speaking audience online. I struggled initially too especially with many
> American terms used here. You will get the hang of it soon.
>
> Keep contributing!
>

Thank you for your encouragement. Many people come to discuss and
share some ideas in English with me every day. It is a cool thing in itself=
.

> Regards,
> Shourya Shukla
>

Regards,
ZheNing Hu
