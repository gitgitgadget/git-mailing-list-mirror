Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B18CC433EF
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 20:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20CF86103D
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 20:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhJRUuV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Oct 2021 16:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhJRUuU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Oct 2021 16:50:20 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8036FC06161C
        for <git@vger.kernel.org>; Mon, 18 Oct 2021 13:48:08 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id l10-20020a17090ac58a00b001a04b92a5d4so8964743pjt.8
        for <git@vger.kernel.org>; Mon, 18 Oct 2021 13:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ucKOTjRAI1peInu1UtIjWMR4jAM/HANJOtGFExv2noM=;
        b=Mo1KODTIdWKaI5Gg7UPYcoHdVRldvt4a7xgGL8blbes+r/UT80WbSqevGGkLM8IcbE
         j8+U5URZvmeT7aHDY1jxxa9o6qpbSrEK6f43ynPqUhXn0hztKY+wJCUTZMMUiLAGo1XU
         0oUP6jokTIJyyA3p0Zjb1tt+Rtrt4B+/9bjlGRYBMlX3vBbniqU8jMtbgcbsu00SItzI
         ZLKcbnUoY2NEpFONJXwUu8d1luRgRCQ6WomzIBbk3PfvByMs5TDLUJq00WvjDsyazohP
         GN9BXoyRmvcqAixtrFo2Q7ybV79x+br0e/AFahdf/0YVEZ5oBpjcLw2obADPvUW16BB2
         ziog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ucKOTjRAI1peInu1UtIjWMR4jAM/HANJOtGFExv2noM=;
        b=wqZuO5nQAHn0MbJG46KmTJodQdMYBFbijaEOs4+dtkPi4kkq0nNORH66A8CzyWjmeZ
         rJyGRr/ETwqU8H96TYFaNFSuXGCzUCOc1V+2zUxFq4iKFMpw8ifumAhplXq1OU8skVA8
         R7yRynEodfeaf1lqT87jd8+zCkjyLnW6FITlaTw3bnihr0K56HrnaRBc0PvNzaDxC5zF
         fFEWOR1EV4LEjtyiQJBUf2dME/CUn4hJ8OOAnmKLUc60MZtKTfNcOLnDKdSO3H/XT57A
         jDKjVNwS24Mk81CUpf+ytFbGCmZPn1D0Zsob2MPQjHYMtv8afcoxMIzXMn71NcWlXHoo
         ORLQ==
X-Gm-Message-State: AOAM533dgMxi80O8rwT9Q3LB6QCbtbu4BPcCcypdBEu0zAdsDyWvqIIW
        I8V+ZDFLwqNoK3SMmOVCFBZClgq2NAtyF6LFNZ1q
X-Google-Smtp-Source: ABdhPJygESt7rnEJ1Q35r3zb0jwMPymOWDw65T2+KiEP0A4f8KBRdIgjf5heyBjJgTCUGnOCGicd3UXSZCNwKFtKQV2/
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:ec14:: with SMTP id
 l20mr188537pjy.0.1634590087743; Mon, 18 Oct 2021 13:48:07 -0700 (PDT)
Date:   Mon, 18 Oct 2021 13:48:03 -0700
In-Reply-To: <cover.1634077795.git.jonathantanmy@google.com>
Message-Id: <20211018204803.75088-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1634077795.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: Re: [RFC PATCH 0/2] Conditional config includes based on remote URL
From:   Jonathan Tan <jonathantanmy@google.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After some in-office discussion, here are the alternatives as I see it:

 (1) Introduce a "includeAfterIf" (or "deferIncludeIf", or some other
     name) command that is executed after all config files are read. (If
     there are multiple, they are executed in order of appearance.)
     Files included by this mechanism cannot directly or indirectly
     contain another "includeAfterIf". This is the same as what was
     introduced in this patch set, except for the name of the directive.

 (2) Leave the name as "includeIf", and when it is encountered with a
     remote-URL condition: continue parsing the config files, skipping
     all "includeIf hasRemoteUrl", only looking for remote.*.url. After
     that, resume the reading of config files at the first "includeIf
     hasRemoteUrl", using the prior remote.*.url information gathered to
     determine which files to include when "includeIf hasRemoteUrl" is
     encountered. Files included by this mechanism cannot contain any
     "remote.*.url" variables.

In all cases, the include is executed if at least one remote URL
matches.

There are other ideas including:

 (3) remote.*.url must appear before a "includeIf hasRemoteUrl" that
     wants to match it. (But this doesn't fit our use case, in which a
     repo config has the URL but a system or user config has the
     include.)

 (4) "includeIf hasRemoteUrl" triggers a search of the repo config just
     for remote.*.url. (I think this out-of-order config search is more
     complicated than (2), though.)

For (2), I think that prohibiting "remote.*.url" from any "includeIf
hasRemoteUrl" files sidesteps questions like "what happens when an
included file overrides the URL that made us include this file in the
first place" or "what happens if an included file includes a
remote.*.url that validates or invalidates a prior or subsequent file",
because now that cannot happen at all. My main concern with this
prohibition was that if we were to introduce another similar condition
(say, one based on remote names), what would happen? But I think this is
solvable - make the prohibitions based only on all the conditions that
the actually used, so if the user only uses conditions on remote URLs,
then the user can still set refspecs (for example), even after the
remote-name-condition feature is introduced in Git.

For (1), it is simpler in concept (and also in implementation, I think).
The user just needs to know that certain includes are on-the-spot and
certain includes (the ones with "after" in the name) are deferred - in
particular, if a config variable isn't the value they expect, they'll
need to check that it wasn't introduced in an includeAfterIf file. (And
the user also needs to figure out that if they want to override such a
variable, they'll need to make their own includeAfterIf with an
always-true condition.)

From the prior replies, I think that people will be more interested in
(2) as it preserves the "last config wins" rule, and I'm inclined to go
for (2) too. I'll see if others have any other opinions, and if not I'll
see how the implementation of (2) will look like.
