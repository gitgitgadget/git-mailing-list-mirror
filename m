Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0E8C433F5
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 22:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbhL1WFs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 17:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbhL1WFs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 17:05:48 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24FFC061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 14:05:47 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id g132so12451987wmg.2
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 14:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WGsFfa/i5nG/CIeZU3RiQ8pDsetnX3YNFxhGnDgHXkA=;
        b=bffI3G4HljkAM/qp5GyzV9G/ltcdZ/JPggMTQHvyaA4cKO6pxScLlZ3U9Cbti2QjU0
         ttYbz0GP+kB7BnhhbyqJWEt6m1j3Hy6TRqZ84JgfO8rc0yDXuR2Tw0iOVkNwDdhif0g5
         9vVjPgJxHZFC8hn7dgQxlKX0ZDxGnEKIqR1dZrOegGT4RY1OO2ohUf+5WfzqhEKDOgWH
         WI76KrJJDOeHwp6qSA9VnUI9+z5X07oNKRJX5RH3KhxGWt2Xi0qcoGsETlG28fYXBBLF
         /LjR6gWugP4Svm6c4hlnx3aPyXcvlMzgJSLDZ07g30fS9CM+oimq5fSgcM+r7368YlBV
         FCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WGsFfa/i5nG/CIeZU3RiQ8pDsetnX3YNFxhGnDgHXkA=;
        b=Z46ibmpbB313BEDXThRqYyfEcR9+sBTZKMHpmrwBLGbPgeeO16KG5T+wrfhnIr+JIy
         grmszPeHpyW6zUglkDh7c3WOL+NMHxgt6tm3300joQU9KeIv6nxwvAEg1eSM5Po0nDfI
         s5v6hfiYNkb4DnPoVn37nAZwPb4YLiWaALQEJsZnli6bhowXJDqsMxrlq0b6YfQmpkLp
         CVrxEDNjA7/JbvWUDG5vZYhZkJ5fOQNUYA2AHLtlzwBF9Y+2YW3r1Z5RhWmf597dUr+P
         pj2JOTFzK9zXVDgiLQX83TiA6lQ0YkwiRFde0AHnFPz0L3AEwNnef0D6OzQyAnWEnMkb
         J4/w==
X-Gm-Message-State: AOAM533nPwJtbM90tuHvSwpU1OL4s90JfMl8WNgNSvSqbOSa8kw8yfCh
        nwx4UQSTvEyvOszQIKzQcMg=
X-Google-Smtp-Source: ABdhPJwdPVmOTYD/OwE8BnhE7v+IQLmQRbHZvWe35eGFmf06U8ElFTHD1ASeSDhRGNH3zmlVuiGi6g==
X-Received: by 2002:a05:600c:4f13:: with SMTP id l19mr19353445wmq.152.1640729146278;
        Tue, 28 Dec 2021 14:05:46 -0800 (PST)
Received: from gmail.com (62-47-8-46.adsl.highway.telekom.at. [62.47.8.46])
        by smtp.gmail.com with ESMTPSA id u3sm24740433wrs.0.2021.12.28.14.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 14:05:45 -0800 (PST)
Date:   Tue, 28 Dec 2021 23:05:43 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>
Subject: Re: [PATCH v2 3/8] ll-merge: make callers responsible for showing
 warnings
Message-ID: <20211228220543.wwoaitcm4luihgvu@gmail.com>
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
 <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com>
 <d5566f5d13605f30be6fd221fc624479cbbd0392.1640419159.git.gitgitgadget@gmail.com>
 <20211228105614.qzmm3hglabtlcsx4@gmail.com>
 <CABPp-BFONtGb5TYUAe2jazuRgKWMsvSJTxSnxrEPM9OYq68Wow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BFONtGb5TYUAe2jazuRgKWMsvSJTxSnxrEPM9OYq68Wow@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 28, 2021 at 11:37:01AM -0800, Elijah Newren wrote:
> On Tue, Dec 28, 2021 at 2:56 AM Johannes Altmanninger <aclopte@gmail.com> wrote:
> >
> > On Sat, Dec 25, 2021 at 07:59:14AM +0000, Elijah Newren via GitGitGadget wrote:
> >
> > So there are 8 callers in total; but only 7 print the warning (including the
> > one in merge-ort which will change in the next commit). I think you missed
> > the call at rerere.c:984 because we ignore its return value.
> 
> Doh, I missed one!  Though, as pointed out by Junio, rerere won't
> operate on binary files and thus can't hit that codepath.  Still, I
> should either have it in both rerere codepaths or neither.

"neither" sounds good

> > > +             if (ret == LL_MERGE_BINARY_CONFLICT)
> > > +                     warning("Cannot merge binary files: %s (%s vs. %s)",
> > > +                             path, "", "");
> >
> > With the next patch, 7/8 callers of ll_merge (almost) immediately print
> > that warning.  Looks fine as is, but does it make sense to introduce a helper
> > function for the common case, or add a flag to ll_merge_options?
> 
> I started by adding a flag, and Peff suggested not doing so (because
> the printing doesn't belong in a "low-level" merge, as ll_merge stands
> for[1]), but instead making the callers responsible.  We could add a
> helper function, outside of ll-merge.[ch], but I'm not sure where to
> put it or what to call it and I'm leaning towards just leaving things
> as-is (well, other than fixing up the important issues you brought up
> before this).

Sure, leaving this sounds fine.  If we can formulate good reasons against
the discarded approaches we should add them to the commit message.  I guess
in this case the small number of call sites is a good indication that it's
probably not worth it.
