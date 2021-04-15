Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB062C433B4
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 15:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2BA861158
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 15:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbhDOPdg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 11:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbhDOPde (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 11:33:34 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0C4C061574
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 08:33:10 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id r5so12345688ilb.2
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 08:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hp104Pq6lV70gnrvnRJ3E/Bi6QVkehhoMefot7jEdZA=;
        b=GZzGbsmamc4HWp4EqTrDeaTkI5r1VctYtPeiXiFlYldsNN4/PjV4Lh7pbU5anP46kt
         s6qtAoXZ1SSH0nHahRhOBPGTd788IVkD94JAvPf0i/3+5xss2CeWuK4o8w6mYwdSsF4H
         ryQKCNKrFbtyCo5G7mlR4tHuXdoLyxRPzfHfrWZU32kZzZIlD6IsJXFjX0RYn/YokA62
         /Eq/pHKxlo6klvd+2wd+iyodnVvCeFEQSZ9rDjrHOLOzyK/a0mKa1ekOvYoG1ZlhI7Gk
         iqlkiA6HOR4HZWSbPnfmBrRTi/kHS18Tg5av5lheqm0sSvhg+LQIwlkZZi4b4H9Bu1Xp
         Jsmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hp104Pq6lV70gnrvnRJ3E/Bi6QVkehhoMefot7jEdZA=;
        b=TAoIhUMfZRUkxQvOz99WCvvcF1/cx96bdvzBlq5wSet/ZMoicHJq0tTU5IpGgA06r4
         U+F/634H2bj10TZY1XIg1elVjle3TOuai4iDIYbSzuR84qxwyN8DilY7TnJ7YCNDaARQ
         1wd7RK/o+jrij30ncSUH0rXgYRv+I4QboSzi0zueoFf1h85ll7Kh0ZJcMv6tIkI96nwI
         RPt2Sm28AlUY6n0JcjTKPWBLzzVJcebGK08cm0V9X5QOdRAZ/lRYvxLhmCCizcx+PlBp
         0cRcvU6Nlxq+W1oPEEBWVKy06s5R44GnrauRLmXoETGX1/rS5Zg/up4N3r+Ju//B/HuK
         rsbg==
X-Gm-Message-State: AOAM531V7/894DhyNtuqgyhw2H8NQBGepUhifqfkp0Ego36mOpTH6e/m
        XvWHUNfOa3N0ZuvD0+lFufjsVlyBze0hZO7Gby8=
X-Google-Smtp-Source: ABdhPJx/dFaV269m6xk1mZ2M0dLYD7LUQ2+88FfWPVIy66zxKq8utOZ2OZBTDop0pPpS7UMlN4yDi8pqZ6q0zSdF5+c=
X-Received: by 2002:a92:d308:: with SMTP id x8mr3213764ila.301.1618500790005;
 Thu, 15 Apr 2021 08:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <pull.913.v8.git.1617975462.gitgitgadget@gmail.com>
 <pull.913.v9.git.1618245568.gitgitgadget@gmail.com> <7f645ec95f48a206311973ee45578ba14ac58b7f.1618245568.git.gitgitgadget@gmail.com>
 <xmqqsg3vb51n.fsf@gitster.g> <CAP8UFD1r2kUaKbjFcRn_FGxz5=hvwY+DHdmPKR61cNdHzBe26A@mail.gmail.com>
 <CAOLTT8TB9UF5z-51pLxdkRUxo5-w2+_U_e1wpDAdzBBmT3Og7w@mail.gmail.com>
 <xmqq35vum1rn.fsf@gitster.g> <CAOLTT8TNK55AprX2tezoX4YjWV31RRyLWc9NJOvidRqqSgBpQQ@mail.gmail.com>
 <xmqqv98oy5bh.fsf@gitster.g>
In-Reply-To: <xmqqv98oy5bh.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 15 Apr 2021 23:32:54 +0800
Message-ID: <CAOLTT8TVAvk_Hdcd27jHz5wWOR6xEMuCeQvDfu48qVDFPN666A@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] [GSOC] trailer: add new .cmd config option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=8815=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=884:33=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> >> So I am waiting to hear why it is not a misfeature.  If it is not,
> >> then surely I am fine to keep it for now and add a workaround later,
> >> but until that happens, I do not think "commit --trailer" can be
> >> used as a way to allow end-users emulate "-s" for their favorite
> >> trailer like helped-by, acked-by, etc.
> >>
> >
> > If it is really necessary to solve this "empty execution" in .cmd,
>
> > Maybe we need to consider two points:
> > * Do we need a new config flag as you said `[implicitExecution =3D fals=
e]`
> > or just drop it? Has anyone been relying on the "empty execution" of
> > .command before? This may be worthy of concern.
>
> Yes, if it is useful sometimes to run the .command or .cmd with
> empty <value> even when nobody asks for it on the command line with
> a "--trailer=3D<key>:<value>" option, then I agree that the users
> should be able to choose between running and not running [*].
>
> > *  Do we need `trailer.<token>.runMode` as Christan said before?
> > I rejected his this suggestion before, and now I regret it a bit.
>
> So far, I haven't heard anything that indicates it is a useful
> behaviour for .command, so my preference is to get rid of the
> behaviour when we introduce .cmd to deprecate .command; yes, until
> we get rid of .command, the behaviour between the two would be
> inconsistent but that is unavoidable when making a bugfix that is
> backward incompatible.
>
> When (and only when) anybody finds a credible use case, we can add a
> mechanism to optionally turn it on (e.g. .runMode).
>
> That is my thinking right at this moment, but that's of course
> subject to change when a use case that would be helped by having
> this extra execution.
>
>
> [Footnote]
>
> * Right now, all I know is that not being able to turn it off makes
>   it impossible to use "git commit --trailer" as a more general
>   substitute for "git commit --signoff" without breaking other
>   trailers (e.g. --trim-empty may get rid of the result of the extra
>   execution, but would remove other trailers that can be
>   legitimately empty).  And making it on by default with
>   configuration would mean that even though we designed .cmd as a
>   better version of the .command feature with its misdesign
>   corrected, we'd inherit one misdesign from it, which defeats one
>   third of the point of introducing the .cmd in the first place ;-)

Perhaps such a modification can meet our temporary needs!

@@ -721,9 +738,10 @@ static void process_command_line_args(struct
list_head *arg_head,
        char *cl_separators =3D xstrfmt("=3D%s", separators);

        /* Add an arg item for each configured trailer with a command */
        list_for_each(pos, &conf_head) {
                item =3D list_entry(pos, struct arg_item, list);
-               if (item->conf.cmd || item->conf.command)
+               if (item->conf.command)

I'm so busy today that I probably haven't had time to put this into a
patch today,
If this solution is reasonable, I will send a new version of the patch tomo=
rrow.
As you said, first solve the misfeature, and we can add [trailer.runMode] l=
ater.

Thanks, Junio!
--
ZheNing Hu
