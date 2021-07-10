Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05242C07E95
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 23:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5ADC6128C
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 23:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhGJXiH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 19:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhGJXiG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 19:38:06 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA4AC0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 16:35:19 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id s23so3316122oij.0
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 16:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=uEHTupBjql3Y5ECW7uFSjNEnkkGqyhb68qZxFjvfCmE=;
        b=p0J0SX5Prcu+uX+I+Q2cMbdGV7H7zxHvhYkrLDDHdz3P+SzgzFKzo8u5d9xMZ2l/eQ
         hGdYWwY4MaP2xTr/bf6DJ2Xo0NFP+foSNXnHCEmmTmJkQlQtMUezOll6nV1rMzIkBI84
         R4FiyE5QzZY1OJFzLafAqHsYisVqORSP3uVw4wmdpFXtfpyXSUKsWooAK2+muJeyHY2f
         SiSggGj0+Mm4pCAM9Jv6b9M2el9UElbDOoN3dicuJXy1Dp2NpeE2gYYgUUfqTKzwwU2U
         7jGrziV+GgELbY4QvNBPFmr41aBqBNHxdaaWUIRPExd2wngnqlHnNNNVZ7BkqfiABB2M
         Cdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=uEHTupBjql3Y5ECW7uFSjNEnkkGqyhb68qZxFjvfCmE=;
        b=eI7HJ2l8OdNT0stPmQq8MZrsyIwvp+EgsC8Uc421ro65IkNnE7pvE5zsaLP1CTyPIE
         mwA0dqkEvsY+HYZzRePopV2IsqLIf+xVdGlfxc5kgg5bGOxNohVvNjlet3XItjGUQd+D
         /w4YXKFsxQ8D3O5isUGKR/WrwAAKvG2qSePFiLDho2eJi14AcoM0b7O2XI2+mPfcddzB
         XX2kwFPJ5n7sGiYfJsuP+rn3Fa0E7neBWM5MlHUt48CqhBKkz1DxS2TTAI8hyD5VD1Nu
         jv35fy/ffhJy265N94Gtg3B9QNlbs7uUeD/AdDsKXdiF+pRIpYqbIgyqF9dCqYcW5PHS
         K/yw==
X-Gm-Message-State: AOAM531oZTLksQYci5Tdmv/+wX6DX+IAnK5kcNtD/9Y6C1RWnmJN8dJV
        P2QJRUAwUzNj+O57NiFlG6f/e/ewNH4=
X-Google-Smtp-Source: ABdhPJwyhR8j+k+9ZLNCLdACWtJWQa3smIgkfjyOyvKOKxk5sCWBoUQKqPAJtENLBEZLn9hdam3Rtw==
X-Received: by 2002:aca:dbc2:: with SMTP id s185mr4916314oig.6.1625960118995;
        Sat, 10 Jul 2021 16:35:18 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id b16sm2206394oic.5.2021.07.10.16.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 16:35:18 -0700 (PDT)
Date:   Sat, 10 Jul 2021 18:35:17 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Martin <git@mfriebe.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <60ea2eb562f26_2a69208e8@natae.notmuch>
In-Reply-To: <30e4c874-6b87-b03d-fa33-fde5b7e50b2a@mfriebe.de>
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <87wnqaclz8.fsf@osv.gnss.ru>
 <60e5f3981de5f_301437208bc@natae.notmuch>
 <87bl7d3l8r.fsf@osv.gnss.ru>
 <60e61bbd7a37d_3030aa2081a@natae.notmuch>
 <877di13hhe.fsf@osv.gnss.ru>
 <c740a4f0-011f-762e-4f49-f85d1b3abc99@mfriebe.de>
 <60e67389a4adc_306ac1208fd@natae.notmuch>
 <4057b3ac-a77c-0d5f-d3f4-ad781754aae4@mfriebe.de>
 <60e736e72da68_30939020850@natae.notmuch>
 <155308af-42ad-b044-fb37-676251a9b7e1@mfriebe.de>
 <60e762243aab1_30a7b02089@natae.notmuch>
 <2b85a7eb-d0be-65e7-ecbb-1750abf53e53@mfriebe.de>
 <60e79c31aaa72_30b8a4208c1@natae.notmuch>
 <65362688-b65b-661c-20c1-94d7dc2118c7@mfriebe.de>
 <60e874e1c6845_215320861@natae.notmuch>
 <dbfa96f0-558e-ccaf-6e34-6d95c43848b5@mfriebe.de>
 <60e88a4b8592f_16bcb2082b@natae.notmuch>
 <ad58bd54-a9dd-59a9-4fce-f90be469cd60@mfriebe.de>
 <60e9f8d462bd9_7ef20898@natae.notmuch>
 <6f43b36b-abe1-41f2-6138-e820c974b1bd@mfriebe.de>
 <60ea07e3495e8_7ef2081d@natae.notmuch>
 <30e4c874-6b87-b03d-fa33-fde5b7e50b2a@mfriebe.de>
Subject: Re: PATCH: improve git switch documentation
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin wrote:
> On 10/07/2021 22:49, Felipe Contreras wrote:
> > Martin wrote:
> >>   From the docs (and similar on git checkout)
> >>> --force
> >>>
> >>>      An alias for --discard-changes.
> >>> --discard-changes
> >>>
> >>>      Proceed even if the index or the working tree differs from HEAD.
> >>> Both the index and working tree are restored to match the switching
> >>> target. If --recurse-submodules is specified, submodule content is
> >>> also restored to match the switching target. This is used to throw
> >>> away local changes.
> ....
> 
> >> If the working tree is made to match the target, then it can not retain
> >> local changes. That can be concluded.
> >> Yet, it is explicitly mentioned.
> >>
> >> Does it really hurt to mention it?
> > 
> > Yes it does.
> > 
> > Time is the most precious resource we all have. We should not waste the
> > most precious resource of our readers.
> > 
> >    Throw away local changes.
> > 
> > That does a much better job.
> > 
> > If you want to be more explicit, you can add a bit more information:
> > 
> >    Throw away local changes either in the staging area or the working
> >    tree.
> > 
> > Why does the user have to know what HEAD is? And why does it matter that
> > the staging area is held in a file called "index"?
> > 
> > The current explanation is just bad.
> 
> Time is precious, but to really save on it, you have to invest some of it.

Sure.

> About the HEAD/index stuff => that was not at all related to the point I 
> was making.
> But I agree that bit can be shortened
> 
> The thing that I was pointing out, is the last sentence only.
>  >    This is used to throw away local changes.
> 
> But even that can be reduced to your proposal
>  >    Throw away local changes.
> 
> It still supports my point. It does state explicitly that data is (or 
> can be) thrown away.

OK, yeah, it does state explicitly that data is thrown away, but it's
the *last* sentence, when it should be the first, and everything else is
redundant.

> Now, if that can be stated on this option, then all I ask is to add a 
> similar statement (as short as possible) to "-C".
> It should indicate that *commit* may be *dropped".
> Find a better word for dropped: lost, unreachable, removed.....
> 
> Currently only the branch is mentioned.
> Currently nothing does explicitly say that *commits* can be affected.
> 
> At the end of the current or rewritten "-C" doc, add:
>  >     This can drop commits
> 
> 4 words. All that is needed.

OK. I'm not opposed to that, that would definitely be an improvement
from the current text.

What I'm saying is that if we are trying to improve the text, it would
behoove us to consider all other options, and instead if adding a note
at the end (which is correct), reconsider the whole thing to *start*
with what's important:

Instead of this:

  -C <new-branch>::
  --force-create <new-branch>::
    Similar to `--create` except that if `<new-branch>` already
    exists, it will be reset to `<start-point>`. This is a
    convenient shortcut for:
  +
  ------------
  $ git branch -f <new-branch>
  $ git switch <new-branch>
  ------------

Do this:

  -N <branch>::
    Create a new branch like '--new', but if it already exists reset it
    like '--reset'.

I don't know how is that unclear in any way.

> > There's only one person you need to convince.
> > 
> > So, what I suggest you to do is take into consideration all we have
> > discussed and send another patch, because that's ultimately all that
> > matters. Moreover, it usually happens to me that while I write the patch
> > is when finally the previously-discussed ideas start to click.
> 
> Well, I will see to make some time and put something together.
> Might be a bit before I get to it, but that gives some time to think about.

Take your time. One of the good things about open source is that there's
no rush.

Cheers.

-- 
Felipe Contreras
