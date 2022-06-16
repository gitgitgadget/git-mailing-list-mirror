Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78BBC43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 13:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376805AbiFPNv3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 09:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbiFPNv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 09:51:27 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B5941328
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 06:51:26 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id e11so1575368pfj.5
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 06:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/HPfDLWt6mDcdbCGcZ5Jk/ESD3yTMYWEZ4pIPbXwCGU=;
        b=nwUfRy8KeH5tU6xCQBfJFSPctVnkZmttqyiRUToAQUHdWJc44f2w3ptarI8z3uE1Em
         Fjf1f0qvEQpwfJBCfJUxcbyjRCHCoI4mboN+mIsXmmh3qqhmy1dKibrsF4K6s9jKh7qk
         vnmik1riH5vfcQ3A3JRktAtXSRfftuNEpQ86IZEgVoZm6mJ5gFh6DQ63DGdygF8thWlr
         nm0arHxRTCYg0pcPRT9hrq2NmXg2VWaYp04zmDFTQ2iyvUnpV9SJ1qW1AxKFiSFz/J39
         4fC8ukvtchW6YE6ONR6/Ay85dl4OO+SSrCN7MJsD0aW87kOdq2hZHfAag4k5i18Ny5MT
         4eLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/HPfDLWt6mDcdbCGcZ5Jk/ESD3yTMYWEZ4pIPbXwCGU=;
        b=7XQyOgiofqk9ujry5u7DDLh5AtQUY4CVBWLm3WgANSrQmE2qxX6i9FhfwBZLFqS04T
         2iGiSb2Qq9tjHOARDMoNyaWhQXpcmUYJQgjk1Rx1qfJHGTmtzfEbzI9eJeGo+hgiB+L/
         yaakPOYp5T+1oDDfrkdnnResr1MPbtD2uPWAlPjPQEk1doxM21EppmMr6jz4yYQo8FbG
         2VsrmIxwBgXCnFmamBkxUrcjZqxPdG7gYR8tMykHGFyqrkcAkO1LDT0Ok85KsXmVfk5G
         7Tj4EqGGYIqO05ZzdB2k8kwnAX80ojLLlOoS7zsOrug9bRi1s8kQif6xlA1Se1cAfQF6
         v1Ug==
X-Gm-Message-State: AJIora/YTxpRxs5CzczXvDLHfQfR2Lsp2Sc50DZZEImqWGpFOk4Dumr2
        FuxBEoonU1mhrBHQOZHX0BojCmpgC0FfWqrWNQw=
X-Google-Smtp-Source: AGRyM1tFbdc55C+lL7B2dUEZAoXAlSEYIMaTil56ZramIaFSIWiZiCVBVIkh1d3Tq4TAb9azdCn2HL3cAIV9p4LwmIA=
X-Received: by 2002:a05:6a00:16c7:b0:520:6ede:2539 with SMTP id
 l7-20020a056a0016c700b005206ede2539mr4832240pfc.46.1655387485905; Thu, 16 Jun
 2022 06:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220527100804.209890-1-shaoxuan.yuan02@gmail.com> <20220527100804.209890-6-shaoxuan.yuan02@gmail.com>
 <077a0579-903e-32ad-029c-48572d471c84@github.com> <xmqq8rqm3fxa.fsf@gitster.g>
 <d0ac1bea-6d98-140c-0e46-d7569e80b29d@github.com>
In-Reply-To: <d0ac1bea-6d98-140c-0e46-d7569e80b29d@github.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Thu, 16 Jun 2022 21:51:11 +0800
Message-ID: <CAJyCBOQGAL9aGW+Gxv8sZH9T_tB6_pdeLNwmNgqPhz7cMdZrbA@mail.gmail.com>
Subject: Re: [WIP v2 5/5] mv: use update_sparsity() after touching sparse contents
To:     Victoria Dye <vdye@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        derrickstolee@github.com, newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 28, 2022 at 5:24 AM Victoria Dye <vdye@github.com> wrote:
>
> Junio C Hamano wrote:
> > Victoria Dye <vdye@github.com> writes:
> >
> >> Note that you'll also probably need to check out the file(s) (if moving into
> >> the cone) or remove them from disk (if moving out of cone). If you don't,
> >> files moved into cone will appear "deleted" on-disk, and files moved
> >> out-of-cone that still appear on disk will have 'SKIP_WORKTREE'
> >> automatically disabled (see [1]).
> >
> > Does it also imply that we should forbid "git mv" of a dirty path
> > out of the cone?  Or is that too draconian and it suffices to tweak
> > the rule slightly to "remove from the worktree when moving a clean
> > path out of cone", perhaps?  When a dirty path is moved out of cone,
> > we would trigger the "SKIP_WORKTREE automatically disabled" behaviour
> > and that would be a good thing, I imagine?
> >
>
> I like the idea of the modified rule as an option since it *does* complete
> the move in accordance with '--force', but doesn't result in silently lost
> information.
>
> An alternative might be 'mv' refusing to move a modified file out-of-cone
> (despite '--force'), printing something like
> 'WARNING_SPARSE_NOT_UPTODATE_FILE' ("Path 'x' not uptodate; will not remove
> from working tree").
>
> I'm not sure which would provide a more vs. less frustrating experience, but
> both are at least safe in terms of preserving unstaged changes.

For me, the alternative provides a less frustrating experience.

Since it is more explicit (giving a message and directly saying NO).
Also, the `sparse-checkout` users should expect the moved file to be
missing in the working tree, as opposed to being present.

And the tweaked rule suggested by Junio [1] might need an extra
 `git sparse-checkout reapply` to re-sparsify the file that moved out-of-cone
after staging its change?

[1] https://lore.kernel.org/git/xmqq8rqm3fxa.fsf@gitster.g/
-- 
Thanks & Regards,
Shaoxuan
