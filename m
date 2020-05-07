Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27879C35280
	for <git@archiver.kernel.org>; Thu,  7 May 2020 23:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0325120870
	for <git@archiver.kernel.org>; Thu,  7 May 2020 23:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cU9htQls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgEGXP2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 19:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726518AbgEGXP1 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 19:15:27 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6F5C05BD43
        for <git@vger.kernel.org>; Thu,  7 May 2020 16:15:26 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t2so5923010lfc.3
        for <git@vger.kernel.org>; Thu, 07 May 2020 16:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tkFxu699PkVTQozK9sn1LUI7HeCuCVTRkTs8qBOpPJA=;
        b=cU9htQls1IAaRMM7ygFtKmMc2CBNV3hmKxa/NrK7bXFl+uGlAgSjmkkx0cs7+3MwpE
         54QPiP9n5roA0P+P5cA8q+mzueSk9S3l07uFoOpF/fOkAigzgkkPcrB8qh0qnksurT82
         3+aCWZpQDKhA6CCHHD5uTZcqoqJTASGqtCOmcTE+m1E4qEQtuMYryNLOzZe+CStHaWHE
         b1ciP983dVkxtnvFFiFqb91QO88yCuWzN4D5aNgXXwe9vEp+NRhCmffPXVoGgq6FAbeG
         KOp8/3kp4EJKmXILXyDFPEBEv20qZvcrAqB4p9LI2OI/heAK2EbjHgll4TZlmVD2+NRk
         ATgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tkFxu699PkVTQozK9sn1LUI7HeCuCVTRkTs8qBOpPJA=;
        b=EYuhTVqTY2KQfJpsVCE77PXcRlYuR6QuDeMeFPrcshVir+p4H2hZGHl/epMNtC8Xax
         IV9mQc3a29q53UwRNKTWIihxT26nH3WR+kEyI0eA3poXzWB0XL1c5IQW+1BxUZgyPajH
         LjBmDa3JLOzO0c86cMjTP2x4KvxpGRxE1F1lFW+u/iFpkCuqfp9cfGpr3XdwpQH4w6xi
         Sxi9tkMkqDP4nvvgta1CMfCSntyoSlvxTYrAWrJ0jDIl5dBUU6YBNrCMLghvN55gGNnz
         Snhf+otTjOhuD3znsI+hwjibgbZKpQ9n/SudQgV8Zm6OSrnJZ+Iz8HALOKniLBvjeQjB
         mTOQ==
X-Gm-Message-State: AGi0PuYxI7a0UKFErv14d8cHpubZMW8QQ8A/4x9FInbWDHbcU6wKuWpQ
        SAZIy7FFbn5wqP9k4a1sDeM26MeDBsUYCinJdm4lOxFIZfs=
X-Google-Smtp-Source: APiQypKQ7n4KRuDnHBf0x8UNwYehe2YltCywDM+q02F4XvpCy3NHtzvE8pUIaWakAbMpsSBWSRp/Z5RTBnVgjnlIyRo=
X-Received: by 2002:a05:6512:321b:: with SMTP id d27mr10352029lfe.58.1588893324287;
 Thu, 07 May 2020 16:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <CA+KyZp7TELrswPjNgB99BXXHEXi5pRr5bO3g_wy7zBvv1R4Kww@mail.gmail.com>
 <xmqq1rnv2vi2.fsf@gitster.c.googlers.com> <CA+KyZp6pvqqNnOOj0ap9ekPdv9mZg2u_NQuwFgMXfwfV17SrYQ@mail.gmail.com>
In-Reply-To: <CA+KyZp6pvqqNnOOj0ap9ekPdv9mZg2u_NQuwFgMXfwfV17SrYQ@mail.gmail.com>
From:   Alexander Mills <alexander.d.mills@gmail.com>
Date:   Thu, 7 May 2020 16:15:12 -0700
Message-ID: <CA+KyZp6CBJse9jRYowgkaRctuRU4mnFz3TVwkKTwkZWkjj3GTA@mail.gmail.com>
Subject: Re: check if one branch contains another branch
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I tried this:

git checkout origin/dev
# now in detached head state
git branch --contains "$(git rev-parse "$feature_branch")"

and I got this output:
<name of feature branch>

not sure what that means

On Thu, May 7, 2020 at 4:12 PM Alexander Mills
<alexander.d.mills@gmail.com> wrote:
>
> so it would be:
>
> feature_branch='my_branch'  # the branch that I want to ensure is
> completely merged into origin/dev
> git merge-base  origin/dev --is-ancestor "$feature_branch"
>
> that won't work?  since git merge-base only works with current branch?
>
> On Thu, May 7, 2020 at 4:08 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Alexander Mills <alexander.d.mills@gmail.com> writes:
> >
> > > I am looking for a command:
> > >
> > > 1>  if branch x contains branch y
> > >
> > > right now all I can find is
> > >
> > > 2> if current branch contains commit y
> > >
> > > can someone please accomplish #1 ?
> >
> > Study "git merge-base --is-ancestor" perhaps?
>
>
>
> --
> Alexander D. Mills
> New cell phone # (415)730-1805
> linkedin.com/in/alexanderdmills



-- 
Alexander D. Mills
New cell phone # (415)730-1805
linkedin.com/in/alexanderdmills
