Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B82EC433E0
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 06:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2384864EBA
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 06:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbhBYGGO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 01:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235513AbhBYGEA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 01:04:00 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811BCC061793
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 22:01:48 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id q20so2895487pfu.8
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 22:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0+6Ud/XiTDS6Hmd6DPovjwUCQOHrZgYMZZXUMw8HPsQ=;
        b=vIzc92/os2gzwSKfh7DxsmKFaO+xNr/EcB/22aw3ts/x+uj73tFFqj7bayv2AfSWuz
         1QGLskUgWE+PYJyQFBL3MMTWuuON+cpSfSr7NSnXKs5kcqWgEWAv82iN8egCr6plt3a7
         dFtK/FOq1Q92cxC0ED3OL7ivU0RVZLMojCBwQEJb8tI8orRr0c59HbcKR8UVoosE0OWD
         up/STZvk3k0wmvJsJZaZOvpTmN0OaAHozA78V2Y5ZU3V93pNHwUGmWmVfIlEZqFRzMqk
         92xeSEhlkua8qAcUsRJpzTTkZawWQiAPUE3TF4yQtthzpIJzvRBG9/e+pWRFNfUiLCCf
         XHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0+6Ud/XiTDS6Hmd6DPovjwUCQOHrZgYMZZXUMw8HPsQ=;
        b=euIpfQ52BmiQkreoG0sKyfSdzqOiZkYXp3xb2LxddsD/Q3C+YX/g8EuCJXBDsgvOdh
         0W2d1wzaUviZsKZh+vwKCYk7BM0njH5iCTLaKTZJAuCX7eCZietElCN5TeN7HB2/0yBJ
         YG84+KO5KSD4ta9WMz4czu9menxYHEX+DQshzn4u9JdHAJK0WS24atNiSFk8xsa7PnKA
         5wCoX29InHCnHFbfI8dFNUdgea5psxjYK7bctKgCa/Vhi5tvEkvZw1R9HbP4W5IgSNXz
         EOv2TeAelpRfB0uZKidsD5im4fimCsziZs8zGzCQ9bWE3xrY9qJVDhfCI0uO9fvadnd1
         3sxg==
X-Gm-Message-State: AOAM533+u8SDlq4J2W2KAkl3QX4QyN80Eg1RskWLWrIv/lC5lEIRfMrA
        ylKjZGrRZcXUoG+2fVddfX/jgOH4nKI8pMvJbCg=
X-Google-Smtp-Source: ABdhPJzYtRhhHsNfNNkYNbq//UdBLSksvZBHRdHHh5Xmc/m0ifBhdnDXb/mFNB+tjtPr+yEuqhyY+wwkhYNZm6+uvWQ=
X-Received: by 2002:a62:7c15:0:b029:1ed:9e29:5998 with SMTP id
 x21-20020a627c150000b02901ed9e295998mr1738870pfc.22.1614232908015; Wed, 24
 Feb 2021 22:01:48 -0800 (PST)
MIME-Version: 1.0
References: <CAGgn8PdU1GE_CZdGUpJWKzygd0O+Yn2BnAFGmPfKAxFpoVoqUA@mail.gmail.com>
 <YDROhhrM5qJti1ir@coredump.intra.peff.net> <YDVo0kGYODP0JjqT@coredump.intra.peff.net>
 <CAGgn8PcPtLNtZTmMqKKTmH3KOezkr-jY7aTEDA-0dvYWuzid9A@mail.gmail.com>
 <YDa/EupbrNa62r+D@coredump.intra.peff.net> <YDc3dinQ37FY8fhD@ncase>
In-Reply-To: <YDc3dinQ37FY8fhD@ncase>
From:   Yaron Wittenstein <yaron.wittenstein@gmail.com>
Date:   Thu, 25 Feb 2021 08:01:11 +0200
Message-ID: <CAGgn8PfdGBuB29Gxba6OmhSagjqwH2DNUv9XyJnXUhcKpJZBsA@mail.gmail.com>
Subject: Re: [QUESTION] Tracking HEAD changes?
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for the clarification!

Is there any plan to support such a case in the future?

Also, I've observed that the "post-index-change" hook is being
triggered before calling the "reference-transaction" hook (with the
"prepared" state).
It seems not intuitive to me since the index and working dirs are
being updated before approving the transaction.
(the HEAD still points to an "old" reference while the
"post-index-change" hook is executing).

Thank you,
   Yaron

On Thu, Feb 25, 2021 at 7:37 AM Patrick Steinhardt <ps@pks.im> wrote:
>
> On Wed, Feb 24, 2021 at 04:03:14PM -0500, Jeff King wrote:
> > On Wed, Feb 24, 2021 at 10:21:55PM +0200, Yaron Wittenstein wrote:
> >
> > > That indeed seems to do the trick.
> > > I've done a little experiment and saw that when doing git reset the
> > > hook gets called.
> > >
> > > However, when switching branches the hook doesn't execute :(
> > >
> > > I don't understand if it's intentional, since when I've moved to a new
> > > branch HEAD pointed to another commit id.
> > > The only workaround I see here is using the post-checkout hook in addition.
> >
> > Hmm, I would have thought that the branch switch would trigger the hooks
> > because they're updating HEAD. I wonder if that is a bug (or lack of
> > feature :) ) in the transaction hooks, or something Patrick did
> > intentionally.
> >
> > -Peff
>
> It was done semi-intentionally, or at least with the knowledge that
> symrefs aren't covered. This is mostly because they're not covered by
> the reference transaction mechanism itself.
>
> But this again reminds me that I still have to update the documentation
> of the hook to at least make it more explicit what's currently covered
> and what's not.
>
> Patrick
