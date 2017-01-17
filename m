Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D83A220756
	for <e@80x24.org>; Tue, 17 Jan 2017 22:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751205AbdAQWbP (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 17:31:15 -0500
Received: from mail-it0-f52.google.com ([209.85.214.52]:34700 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbdAQWbM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 17:31:12 -0500
Received: by mail-it0-f52.google.com with SMTP id k200so15376037itb.1
        for <git@vger.kernel.org>; Tue, 17 Jan 2017 14:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8LD+tZfJoumfpNfc7w5aF48WdG9G8uqqZ9a1UUr6EDQ=;
        b=liqUvg7GaQ5eL0KaSCr70nsUU8f2YCYBl2SitS/0mIrgEHV9MWlBsgbPhe1BzhXPDl
         FprbCDRIM87qCylOUKQtVkpAnMqmG24RoLgCzjFi04BgmhxaP0U9xac7GEc29N82jHrX
         gOp/tHY2HymfYK2kb463RlEXQrvYqMzgkqbNSkCrisg/GN8WWZWiofufqvl/izjbnr9F
         d1FLDPztUWCuC0SdY1OLJbbGR87bzw/3EHKcV0tSS/W/rSeMhxbq7bgC98p/fbl34/ZI
         czUWXZ7pSqpwex7boDoh+tihY588oBSNcAEqeTQNf2kT3VT3evFKhq2Pse7tDJDrrdeq
         sVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8LD+tZfJoumfpNfc7w5aF48WdG9G8uqqZ9a1UUr6EDQ=;
        b=WRBJFPYHzaDKSWlmYaC4L6bFSYdX9TuUGHI4qE/HwRgvgqZLj8z4piUp6nMTwSCMWB
         6aW0d2sQP+cC4nN2qjamN1plEyEj35mXMVGmsbiuRnmkYnYgtA+1o3VHZQmY2WJPQP87
         BP0s+92SsQiKW1/Lk6a+dA6B+suaKUK21hUeW+/yQnF47a1MvXhrWgN4ddSFFNW8Y6v7
         zw+9H+Z8Ag3Ztrq11U5PSS5JhF/YxAO/2sNOHXF5WtxdoSJmSe9+WfjWZYm68Q2oApoK
         q0PQV8i9B63ogDElxL9dtPwZ89zg3VPl8X6gJcmHxnRfKykSz91hQg2uSlUekkZa278f
         J4Fw==
X-Gm-Message-State: AIkVDXIvyiMXNxg9ceXNBBbypr/Zd6pZGek/KGvS36gNOMl9RrfglRlJPCspRVklFnWh1osm0DigRGWuYVL+k+cr
X-Received: by 10.36.4.2 with SMTP id 2mr21034199itb.116.1484691815803; Tue,
 17 Jan 2017 14:23:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Tue, 17 Jan 2017 14:23:35 -0800 (PST)
In-Reply-To: <2381666.1DSVtKRIH5@mfick1-lnx>
References: <20170113155253.1644-1-benpeart@microsoft.com> <CAJo=hJumYXTRN_B3iZdmcpomp7wJ+UPcikxGb6rn9W=uJeYmfw@mail.gmail.com>
 <002501d2710b$af74c4d0$0e5e4e70$@gmail.com> <2381666.1DSVtKRIH5@mfick1-lnx>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 17 Jan 2017 14:23:35 -0800
Message-ID: <CAGZ79kbWHHOj5x=SqSvUPdXtyYZUqDBnPG+erfZHsUkA8Cv-NA@mail.gmail.com>
Subject: Re: [RFC] Add support for downloading blobs on demand
To:     Martin Fick <mfick@codeaurora.org>
Cc:     Ben Peart <peartben@gmail.com>, Shawn Pearce <spearce@spearce.org>,
        git <git@vger.kernel.org>, benpeart@microsoft.com
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 17, 2017 at 2:05 PM, Martin Fick <mfick@codeaurora.org> wrote:
> On Tuesday, January 17, 2017 04:50:13 PM Ben Peart wrote:
>> While large files can be a real problem, our biggest issue
>> today is having a lot (millions!) of source files when
>> any individual developer only needs a small percentage of
>> them.  Git with 3+ million local files just doesn't
>> perform well.
>
> Honestly, this sounds like a problem better dealt with by
> using git subtree or git submodules, have you considered
> that?
>
> -Martin
>

I cannot speak for subtrees as I have very little knowledge on them.
But there you also have the problem that *someone* has to have a
whole tree? (e.g. the build bot)

submodules however comes with a couple of things attached, both
positive as well as negative points:

* it offers ACLs along the way. ($user may not be allowed to
  clone all submodules, but only those related to the work)
* The conceptual understanding of git just got a lot harder.
  ("Yo dawg, I heard you like git, so I put git repos inside
  other git repos"), it is not easy to come up with reasonable
  defaults for all usecases, so the everyday user still has to
  have some understanding of submodules.
* typical cheap in-tree operations may become very expensive:
  -> moving a file from one location to another (in another
     submodule) adds overhead, no rename detection.
* We are actively working on submodules, so there is
  some momentum going already.
* our experiments with Android show that e.g. fetching (even
  if you have all of Android) becomes a lot faster for everyday
  usage as only a few repositories change each day). This
  comparision was against the repo tool, that we currently
  use for Android. I do not know how it would compare against
  single repo Git, as having such a large repository seemed
  complicated.
* the support for submodules in Git is already there, though
  not polished. The positive side is to have already a good base,
  the negative side is to have support current use cases.

Stefan
