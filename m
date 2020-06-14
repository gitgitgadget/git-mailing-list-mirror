Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB2BC433DF
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 00:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62D3E20739
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 00:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4jL9RJK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgFNAmB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Jun 2020 20:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgFNAmB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jun 2020 20:42:01 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2116C03E96F
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 17:42:00 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id e8so2691240ooi.11
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 17:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OrNonoqzSJD5hxxrBv/jYuYGFYVy2vbdjfg/GEb99dw=;
        b=T4jL9RJKgAiK2hso8gnjmYF7yJp519/OYwD47HB5VKEZTq14cA7XMR5/xf9nYoQ0iW
         kGS6hq2sjyiQfX6dYtEFTCvJ7wtZPCMBa6eNxgpRpP3FW8XOq8LBqnXou7CWa3Lb4Y8V
         B9Xzndiro9oywIwmxBGsvtvVncg6V3RBQwY0km/FP6ols4mAruRS/+cV8UUl1bGo0tPb
         674mFN2QY7jKbG43W/Qbj0uzQepuB1Qa0TPX30nHXAlJTROtivY0JPFSqQtPsR2ml6QG
         2YvUXIKm6RoGpnJatwVqGcq7Bnu1M+g+k2HW/no6SxjXXVIrHBpnSUopnHNlxI/9gDp6
         K8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OrNonoqzSJD5hxxrBv/jYuYGFYVy2vbdjfg/GEb99dw=;
        b=B+3VQcVsOqgNIxAdAek/8QR+XNRx8G8SDgZcSuw7q3cnHklCLEo0BcMnxIYr8foNl7
         IHAmdElEFt4VCnxCxNRqgUIjjlzmnspOqomYuDtvh3FNheeZsj/pOYtH2fhvniF3qTWu
         QVAcgqz+LbNS7TmxNcdj/devPYQKQIY2pQq27pUSmXLmO3R0ZrhPuyHBhbcPx7d9eFop
         PFP+Qbzw0OZFN20yRrdT0jc7g+pzOA5GB2vqeK6dPTrNmd4SnfWK9DbrLJOnRy0F5a9C
         aEhdmjPwJlqnEgQHSpKykmc4MpmPtn7KE2HRDKJtsARJ/4uHHorFLeWn430p/gwyhH+y
         oU3g==
X-Gm-Message-State: AOAM530+mfbBo82Y8DFstBVw2ec/IfnY4tql8wKOgVy/U/PbgkU8NoGf
        UwquGgwvuNFBhSgLiDbBYV9Go0yY/OLC1i+ywl27zOhP
X-Google-Smtp-Source: ABdhPJwCuLmXSMeYvimrgaXt0HUrqnLKGR6EUp27/5GywxGacrGus4Lgw4jpq2wL4p2K3JxvkBpTgOU5PZ90TyXNNPw=
X-Received: by 2002:a4a:8507:: with SMTP id k7mr16415423ooh.32.1592095319907;
 Sat, 13 Jun 2020 17:41:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
 <20200505231641.GH6530@camp.crustytoothpaste.net> <nycvar.QRO.7.76.6.2006091126540.482@ZVAVAG-DN14RQO.ybpnyqbznva>
 <20200611115215.GQ21462@kitsune.suse.cz> <CAGA3LAfpoXDQryOPGg3g-4brpUcSAhL_2VOw8oy6D2ffp64hag@mail.gmail.com>
 <f27450d8-59a1-dc0b-f741-c8c883b95fe0@gmail.com> <bef39243-806f-7c4a-c3d1-f3500ec377be@iee.email>
In-Reply-To: <bef39243-806f-7c4a-c3d1-f3500ec377be@iee.email>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 13 Jun 2020 17:41:48 -0700
Message-ID: <CABPp-BHF7KDLw7_VtSokpOuOr_tX2DTNu31B58P83R3HK=YVvA@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Don Goodman-Wilson <don@goodman-wilson.com>,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 12, 2020 at 6:23 AM Philip Oakley <philipoakley@iee.email> wrot=
e:
>
> On 11/06/2020 13:52, Derrick Stolee wrote:
> > On 6/11/2020 7:59 AM, Don Goodman-Wilson wrote:
> >> On Thu, Jun 11, 2020 at 1:52 PM Michal Such=C3=A1nek <msuchanek@suse.d=
e> wrote:
> >>> Indeed, the flexibility to choose the name of the default branch can =
be
> >>> helpful for projects with specific naming, especially non-english
> >>> speaking projects.
> >>>
> >>> To that end I would suggest adding -b argument to git init to be able=
 to
> >>> choose the default branch name per project. This should select the
> >>> initial branch name and also write the it as the default branch name =
in
> >>> the repo configuration (if git continues to treat the default branch
> >>> specially).
> >>>
> >>> This can be used in documentation to use the new name immediately
> >>> without breaking existing workflows that rely on the 'master' branch.
> >> I _really_ like this idea (and your reasoning). Seconded.
> > Yes, adding a -b|--branch option would be an excellent addition to
> > the config option.
> >
> >
> Is their also an option to also add an option to `git clone` to (re)set
> the default branch name offered by the upstream to that provided?
>
> Alternatively provide a `--no-checkout` option for the clone so that
> either no actual checkout is performed, or maybe that a detached head
> checkout is performed so that users can name their default branch
> appropriately.

Good news: git clone already has a `--no-checkout` option (with `-n`
being the short option form for it).
