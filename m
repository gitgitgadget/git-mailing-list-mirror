Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED70C56202
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 18:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28EC821D7F
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 18:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oKc1ITli"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404814AbgKZSNk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Nov 2020 13:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404196AbgKZSNj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Nov 2020 13:13:39 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981A9C0613D4
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 10:13:39 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id y74so3093071oia.11
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 10:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IlYA0qb7ytFjktD7h1K87bJXWygNJbvVXJE3zNIH3Ls=;
        b=oKc1ITli4yzG+BY16+kNkUYkqdNfIzrPlOw/unMJx6OXsftnYAxwH5q6xJ3Bl1+uxQ
         obFiuJey4VKUI4pUtdxygsYiOb2ibtJnHh2b1MaYZddDagb08CSUzBefAGM5TSeXD/Tu
         TGpTFR3K17MyHpIbe8ltiv3NoYnGfv9bWr/R3li03/jARNOtb4VrIhB1758wigbzzgGR
         0TBiw1rWfwwgPVHiVgsCyxGR+WgZPa9vY+KUjvVMAvsMrKUOtz2s7P982s0NSv63LxVY
         uUzByGh/6orURL0Pe+1CWXC38RNsNxyK2ZRWb8AP2AribouHDxrDmi41m30MSK6tnlop
         1Cjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IlYA0qb7ytFjktD7h1K87bJXWygNJbvVXJE3zNIH3Ls=;
        b=fn4Kc4h6DexvW+KHsSvsjVQFTNef+XDP4qr4yJPBoQfBZofry4dIW381NWiYNHWA4l
         3KFNnd8vtN9n24UVdwHqUbAdbYcNj6B9ImbJDbbIDTLfN46g187tGhY5loD+Gp/sNQdH
         zTq0p/Co2f22GCcp6EKUKkNSDYy3PnjvqiaI5lG1DJHjZ6SCWIFlpMGcEkFAk8WT0Sd0
         PmjEjLfg33+781naZX3q1whoPdq5jXjRLZ0OKeGr9tQZCJMRYQiwjtEidamPm5vUwmxy
         dyQd3/oDgCJ99GKxN4Fvhyte+eNUO00DPUy9X/vgyBjyVUrxZyHO/mnwywWedkbbh+tr
         EU0g==
X-Gm-Message-State: AOAM531EUYjaX9rmVuVG8Gqm+DBWsGgP2I4k8w0GO8JrU1dI5EHoWEGl
        jsQu8Tjf3IfYRbdGWm3y7dvtF9JDhws0a7FyvT9oZ90wFjg=
X-Google-Smtp-Source: ABdhPJyBVobdjHLd65CzKoKq9IlNcpfZSN0P4YAXMox5y4MSv6ycYtvtBiQdlolcROFQRBjRkE1PSilW/XgJV/WbXgU=
X-Received: by 2002:a54:4704:: with SMTP id k4mr2882484oik.39.1606414418926;
 Thu, 26 Nov 2020 10:13:38 -0800 (PST)
MIME-Version: 1.0
References: <CABPp-BHa21aeXwzykyQAtGd3rzOiE++Gozu7umOSYihc_145iA@mail.gmail.com>
 <20201125020701.956393-1-jonathantanmy@google.com>
In-Reply-To: <20201125020701.956393-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 26 Nov 2020 10:13:27 -0800
Message-ID: <CABPp-BEfqrT7B=Mu=LWpi3GYkP0SRLFFjPVkca8krairry3iew@mail.gmail.com>
Subject: Re: [PATCH v2 15/20] merge-ort: step 3 of tree writing -- handling
 subdirectories as we go
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 24, 2020 at 6:07 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > For now, I'll keep the code as-is, but add more comments to both the
> > data structure and the code.  If I've missed something about how I
> > could make use of your BEGIN_TREE idea, let me know and I'll look at
> > it again.
>
> In collect_merge_info_callback(), you call setup_path_info() to add to
> opt->priv->paths, then call traverse_trees() (which recursively calls
> collect_merge_info_callback()). I was thinking that in addition to doing
> that, you could call setup_path_info() a second time, but teach it to
> add a synthetic path (maybe have a special bit in struct conflict_info
> or something like that) that indicates "this is the end of the tree".
> Subsequent code can notice that bit and not do the normal processing,
> but instead do end-of-tree processing.

So, I realized that I already had end-of-tree markers -- the
directories themselves.  But due to some other weirdness in how I had
built up the processing, the existence of those markers was both
obscured, and deliberately side-stepped.  So, I did a little
restructuring so we can use these as actual end-of-tree markers more
directly.

> Having said that, maybe it will turn out that your additional comments
> in v3 will be clearer, and we wouldn't need the synthetic entry.

Hopefully it's clearer now, but the entries aren't synthetic.  My big
opt->priv->paths strmap with all full relative paths contained all
files _and_ directories already, and now I just use the directory
markers more directly.  Hopefully the extra comments help too.
