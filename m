Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D51FC4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 13:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D371E2311D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 13:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUCrJjDT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgIYNJh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 09:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbgIYNJh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 09:09:37 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A555C0613CE
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 06:09:36 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id gr14so3592783ejb.1
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 06:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pjxGBjQwyCKou7my6NI6U/a/oA5pH5L+tFXgOAE7PMU=;
        b=TUCrJjDT2bFy15+gLqUbrqfrvyHcFkPcxmcWqyMQw+07zI+yqc8WG8SSkHsHBncdz2
         q5fTayX1zjgdnipN9xr4gWJR7vKULVUEBeoJLST6Ei1RxvYKt9KTMH0wAGlNjjEQNXV6
         suns+upsKIi1eURWT0ZntOOm9GvxJZunV89TUz1rgH0PWbvUMFKmj5sdeIH9Zm9JGbwA
         o1u12IHe1RTgfeiPiHyk+RjoMPdgy73+cY68TRIsPrFmOzCKTp1GmD2J8KaUTcLd8W56
         FyNErQY1oNqHyDLDPJBEUleCoDcg9opQ7BsdKWCE3Vjr1EZkrjvGJv+l0JsnNlzH7mau
         irWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pjxGBjQwyCKou7my6NI6U/a/oA5pH5L+tFXgOAE7PMU=;
        b=uJnKpH65L+NoY1Vx0BxSCb8hnA+UinrnkD+NHhq4p6TCN4SN1ru2ygXY/zZ9FFBbVx
         WB1U+7fLDL/Nn23qUBi39clAY1Fqqg3A/p9eQ+LEzFGb9cXYCwHFfg7192UR/HK1ujaf
         was5RAqJBYbWXnf8btMWgOAoBsPnYjwjoLEinGXjLVSOkxt1yQQ6lB3Unor6KdQJqt0/
         XvCeWRrMuHrimu7y6hsnHvsTd+ilIpu5GJdOsPbUTbgsF4gvIS9Ir0HtZUTCreRawGyv
         RRPWU66cocFHs3yV5knhHO2iGElDbjv8+3I47bU2MX+QS0DymcUtnmuEJu2QbFGUhBfL
         59Ig==
X-Gm-Message-State: AOAM532/odKZsWmZdi/8bNJd8Kc7Snjm7r4q2nI4socDUeNR5zrP3ScG
        LTBekGlKTkGTGzoqA7gk6PRANejglrmbtwf/9ZU=
X-Google-Smtp-Source: ABdhPJxFnUuexh4Ov6VDeUwsieyLixCfbG35blOBhAr9eTqonGN++rgFSGXjhAd4nVZEQlcn/g2mk87/0636ZOP434Y=
X-Received: by 2002:a17:906:2354:: with SMTP id m20mr2531560eja.341.1601039375032;
 Fri, 25 Sep 2020 06:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200923170915.21748-1-chriscool@tuxfamily.org>
 <20200924060344.15541-1-chriscool@tuxfamily.org> <xmqqsgb7m2bq.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqsgb7m2bq.fsf@gitster.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 25 Sep 2020 15:09:23 +0200
Message-ID: <CAP8UFD1zLeeWsmPvwrs-ypZkwirxcEmasqW5mSxbFeqF6-Fntw@mail.gmail.com>
Subject: Re: [PATCH v2] bisect: don't use invalid oid as rev when starting
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 24, 2020 at 8:55 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > -             } else {
> > -                     char *commit_id = xstrfmt("%s^{commit}", arg);
> > -                     if (get_oid(commit_id, &oid) && has_double_dash)
> > -                             die(_("'%s' does not appear to be a valid "
> > -                                   "revision"), arg);
> > -
> > +             } else if (!get_oid_committish(arg, &oid))
>
> This is wrong, I think.  The "_committish" only applies to the fact
> that the disambiguation includes only the objects that are
> committishes, and the result are not peeled---you'll get an
> annotated tag back in oid, if you give it an annotated tag that
> points at a commit.
>
> This is not what ^{commit} does.

Thanks for finding this.

> It may happen to work if the downstream consumers peel objects
> (which are appended to the 'revs' here) down to commit when they are
> used, and if somebody verified that is indeed the case, it would be
> OK, but if this patch is presented as "unlike the previous broken
> one, this is the faithful conversion of the original in shell, so
> there is no need to verify anything outside of the patch context",
> that is a problem.

I agree that it's better if there is no need to verify anything
outside of the patch context. So I agree with your fix.

I am also ok with using "pathspec" in the test description of the new test.

Thanks,
Christian.
