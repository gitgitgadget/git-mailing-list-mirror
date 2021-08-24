Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED42CC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 22:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCB976127B
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 22:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbhHXWCX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 18:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhHXWCW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 18:02:22 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21921C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 15:01:38 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id y3so22045069ilm.6
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 15:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r1C3QqrQY7qn6d2ttj9meBil3Nerl5pDSkIC+/vxorg=;
        b=Pl5ddgzTI1wSPHk7E+S2rnTOyjoRdML9zOxYZ0M3dZ/v2F33sUAtLY8jJ1WN00lrOx
         TacvSBP+/qFtRnXCr9bpfWnU+9YygfWd2PdOonEV7AD4xqGUY4o47KBScIDUx4nt9xO5
         x4GqLj0luGTyxyjOFlyGkRnhQNV9wuO3PnYUs6QMNsJ4QwFzqF+ZztL5/g9tkpN2AluM
         PitxFsfXZKhV8j9eVkD9tWA8VE7NJsaN8Ls1EcYxdzKdu+WTDMoW5cWppaU+aB13y1KV
         Hsy7x5ighKcqIiUEHjDhOqcQZ+K5rIZLfh0eZKNx/UvMkxwGHsoARDfrk762D6V9tiDy
         NlFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r1C3QqrQY7qn6d2ttj9meBil3Nerl5pDSkIC+/vxorg=;
        b=aHT4MEY+Ct3MJJ+bFEQ8KOzOux1VhtOQGqFGGLGXtYS8OyoSHXZFzaxPIK8y0NMutm
         2myod81dB+1H+Mro50QKpOqh9bDB/2t2IbfOKAnztNJBkxWXDfkAvQxkyakX9nTfeMAg
         JlIeo/OEDYvo5xGCjgLMBl4Lh3z86+/RvmMDXF2rSZktDZYL6ysm/jMWUxhh66DLl+BI
         yKjK/21U4Q5WquFffVcduL0DqDLF09q+91LkdfUdE8RSi6kl5VRuF0wMipAz49XtypLw
         hGdccHDi86TpdbPhXNyHUYVfYvY05Sxbnl3z0G4H3uIVjCDJDLfaiqSDzdKVgWYGRH4v
         ZnGw==
X-Gm-Message-State: AOAM532Z8lcO3cUOG+l/r23Qfey+MnHv367w8X654UuHHTAFYJBnVUxY
        UgQgHYnkZHI2ropvClSv7gbW8Q==
X-Google-Smtp-Source: ABdhPJzN3wPt6D/Ln/QYwrTsYqrE5BGW4pjgFZdbTLim+lt6oKBctC5rcoKGpEp/+mpJMXEKT5m5Wg==
X-Received: by 2002:a92:d2cd:: with SMTP id w13mr28316342ilg.117.1629842497570;
        Tue, 24 Aug 2021 15:01:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l19sm10652256ilk.26.2021.08.24.15.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 15:01:24 -0700 (PDT)
Date:   Tue, 24 Aug 2021 18:01:02 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v4 05/25] midx: clear auxiliary .rev after replacing the
 MIDX
Message-ID: <YSVsHo2wLhnraBnv@nand.local>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1629821743.git.me@ttaylorr.com>
 <771741844be3570395abfda813ed5ef2fa78332e.1629821743.git.me@ttaylorr.com>
 <xmqqa6l6oafd.fsf@gitster.g>
 <YSVX18UXh9vX+Zhp@nand.local>
 <xmqqr1eimtrp.fsf@gitster.g>
 <YSVjnSDaBXgXvT9W@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YSVjnSDaBXgXvT9W@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 05:24:45PM -0400, Taylor Blau wrote:
> On Tue, Aug 24, 2021 at 02:12:42PM -0700, Junio C Hamano wrote:
> > Taylor Blau <me@ttaylorr.com> writes:
> >
> > >> This needs to take object_dir into account, no?
> > >
> > > Yes and no; clear_midx_files_ext() still takes a pointer to a 'struct
> > > repository' until we pick up [1].
> >
> > I was hoping that [1] will become part of this series as a trivial
> > clean-up and bugfix, perhaps in its early part.
>
> Sure, that works even better. I'll send a reroll incorporating it as
> soon as I finish re-testing.

Hmm, this got me wondering: what should be the behavior be when we run
the multi-pack-index command outside of a Git repository? For example,
in patch 15 we do:

    for (cur = get_multi_pack_index(the_repository); cur; cur = cur->next) {
      if (!strcmp(object_dir, cur->object_dir)) {
        ctx.m = cur;
        break;
      }
    }

but obviously get_multi_pack_index(the_repository) will fail when there
is no repository to begin with.

The real question is whether we should allow munging arbitrary MIDXs, or
restrict the ones we can modify to just our alternates. If we allow the
former, then that code needs to be tweaked. If not, and we only allow
touching alternates, then we need to require a repository for the
multi-pack-index builtin.

Thanks,
Taylor
