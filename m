Return-Path: <SRS0=eCeC=CH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FE6C433E2
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 04:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBBCF207DA
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 04:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="kMmm5HCO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgH2E2R (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Aug 2020 00:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgH2E2P (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Aug 2020 00:28:15 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5991C061264
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 21:28:14 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id t6so1032665ljk.9
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 21:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J0D/oOLJc5cI8qr2ewIIi3MUU0SVFypsm4E8/9m8Tz0=;
        b=kMmm5HCOrA42DRTcnw6wbHuKb1uHIL6i5CfwLDBrgrMlp4jm5/W3w0eNjqZP9xy3sN
         lvl2M9bl8heftD/Rsd7oEF3CAATcTWlEOBxf/gzPpeBWbbtlF/5NGJLYw6lt6BJiRk5y
         3JqLI6OQfd31LV/msp129CSFLR/y/uPG/pmMqLLSMtq6jMIm9M2xNwU1ahqFMH7aNhpD
         brgC6HOuS3iBge2+sjJ7Uwe1H57Blia4VTqJQiWRy3o9aSDcDpu21rHny0G0vhQlsSUg
         O6g45i5VlJtHsMcQUlDLIZoI+9R0081GFB68m84ffbxlQ5Ft5Gy5LNgn3rhB3nMKDF9d
         6o0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J0D/oOLJc5cI8qr2ewIIi3MUU0SVFypsm4E8/9m8Tz0=;
        b=PJ5kmsndNZ5f8I4Tw/wBbvZB9opuFGDeJVuZbvlVQ8z0uhSkFEowUSrqqjqzHipA0N
         eCNdq7mMxPLrTkrRTQZQuNdYPZzwJ/WlHYH1x2ZKKiTc5zeGe5e71ldF3l0B+K6DRgIz
         5LX+SIz7FNF0rzFOd3DOzZIdi+Z43F2AqHerjawEvKwlUeiMnyS6niA/nLLU3+dWedAb
         bBQ8fNCpExGlC+NzR8738y8gLxePsOdE06omXTaauZSAYyCGB4aDe5FsElsJU4ZkdVYj
         vI5kmmyQFL8JVI08vAsn2CNA3OQdPONmeJ3fBge+IB+bY8rslduffK5jwm85C7cEgZoc
         R2rQ==
X-Gm-Message-State: AOAM532GhBsYLDNv0ttXPjzN4GmTtvkPvbKTt0ToyMZInu0WaOnnE/p7
        /tFUziBOH/7Y+en9QWdp1fhGA89ooELd8jS0pbHdqg==
X-Google-Smtp-Source: ABdhPJxVLnsmIGN4HHCEM3iSMre+B/uoAQqzouJbKkOzPlvTOmTNN7y8bJzA1WjVScPMRID22mU6qgzwQzEBq4CNakc=
X-Received: by 2002:a2e:920c:: with SMTP id k12mr829755ljg.29.1598675293292;
 Fri, 28 Aug 2020 21:28:13 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqh7snpxy1.fsf@gitster.c.googlers.com> <CABPp-BHCVWWFDL2kpWymNuX_t4anX2Xw-xiTK8N+MdrBoopERg@mail.gmail.com>
In-Reply-To: <CABPp-BHCVWWFDL2kpWymNuX_t4anX2Xw-xiTK8N+MdrBoopERg@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sat, 29 Aug 2020 01:28:02 -0300
Message-ID: <CAHd-oW75wy07jo+pZzqjkzYekMWVSp0DmEVNQLG8GyTPNLZ1bQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2020, #07; Thu, 27)
To:     Elijah Newren <newren@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Elijah

On Thu, Aug 27, 2020 at 11:16 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Thu, Aug 27, 2020 at 2:46 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > * mt/grep-sparse-checkout (2020-06-12) 6 commits
> >  - config: add setting to ignore sparsity patterns in some cmds
> >  - grep: honor sparse checkout patterns
> >  - config: correctly read worktree configs in submodules
> >  - t/helper/test-config: facilitate addition of new cli options
> >  - t/helper/test-config: return exit codes consistently
> >  - doc: grep: unify info on configuration variables
> >
> >  "git grep" has been tweaked to be limited to the sparse checkout
> >  paths.
> >
> >  Review needed on 4/6; otherwise looking sane.
> >  cf. <CABPp-BGdEyEeajYZj_rdxp=MyEQdszuyjVTax=hhYj3fOtRQUQ@mail.gmail.com>
>
> Kinda disappointed to see this stalled out; especially after so much
> work put into it.  This spawned lots of other side discussions and a
> topic or two outside this series as well.  I really like the overall
> result we came up with out of this series and would like to see it
> land [...]

Yeah, I would also really like to see it land :) Thanks to your last
rounds of review, I think we got to a much better design regarding
each grep case.

>  [...] If we can't get more reviewers, maybe we just merge it down
> anyway?  But, in an attempt to prod some review...
>
> Jonathan: I pinged you in chat about this series some time ago and you
> said you'd take a look and comment.  I can't find a reference
> anywhere, but maybe you talked with Matheus in IRC somewhere?  Do you
> recall?
>
> Matheus: Do you have any outstanding items for this series or is it
> good as far as you know?

Hm, I don't have anything else planned to add.

Just one minor aesthetic consideration: should we perhaps eliminate
the sparse-checkout.c file (and the accompanying header) from the last
patch? This file contains only one function; It was created with the
idea of being later populated by another parallel series [1]. However,
if we only have this function for now, should we move it elsewhere?
I'm not sure where, though. Maybe to config.c, together with
git_config_get_index_threads() and others?

[1]: https://lore.kernel.org/git/2188577cd848d7cee77f06f1ad2b181864e5e36d.1588857462.git.gitgitgadget@gmail.com/
