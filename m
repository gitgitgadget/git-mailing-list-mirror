Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4296C433F5
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 22:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiAGWBY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 17:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiAGWBX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 17:01:23 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD454C06173E
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 14:01:23 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id g22so6612758pgn.1
        for <git@vger.kernel.org>; Fri, 07 Jan 2022 14:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=14JJ0wqICV1Ln2F7D0GKtr7mThaPF2Nk2JdfIx+8rOk=;
        b=beZH7b9W6BEuS5T5pH1x31DUSOx9LGWW/C5a1eJDNA2gtcnoGRGWHv0ttqVDxwWxW9
         VpqxH1x3K/cmTS1T68uxC7cV5Z6HkfvIcRydfCBxzoowmSJ7EeiJ6Sug0fdk7y9U93ci
         H4pu2+xv6wmygIa9LyXklUATJgGQyGZKdKrDKUUCZGGd5G+J2R4GtpeSGAXLDYqlVlrI
         4X4WihAU7qXvUKZPa0rpuCYObpNP7sL+/jM72B11Vr2uNvvjISOV+RrlIEHtCiirN0Cg
         Dk/bFYGiJxMBkJoUyKt7Hg9qQHXjDalecz3vZDe/W2kNQ8TbhxzHJq6bxkY3g6Z7Jl7y
         ePRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=14JJ0wqICV1Ln2F7D0GKtr7mThaPF2Nk2JdfIx+8rOk=;
        b=yistga6yAmPrAOeK7OG5Lah8NS/a1LRWatLe3S7Zq1ADyqobw6dzxcXyqoD7NA3+3x
         aDmbhv2XfB1EGy3l/iqwbQQ/6/4Mht2wLHrFRAaZ7w1nhTR+pUx3TidPt9FvecTZpFc1
         f8InkFeMOWsRn54rqsoM/p2QziBSH6ZNeFAyMPwiX/del7QhZc7klPDLlqpkoH6+3KqA
         WryxVb0py91dkyA5ZnokTYtTnR5L0uVOBG9ddf0CT9LHNuIEFAYRrrPpy7B1hecHBFoF
         LB72xj+9i0aXl9W4GTd31NPvq+bQpGeOemyhGY44A8XKKS/6AE5Xg/IgTv/GPYMQ9Xn3
         zCNg==
X-Gm-Message-State: AOAM530i67nRpob2/kaDgQDerOz8p4M/vyMmm3/fzkozTwygGbIkebfj
        8Fytt3OgKsfQd7qs4IX+fFBHLE7aLCWNKQ==
X-Google-Smtp-Source: ABdhPJwl5IUaZJlFxUifsu9b4ho4yPIGUrdbNdAcx+OE8/KoTXRR0v3k+NmOl0QHOdALvW40gUw97Q==
X-Received: by 2002:a05:6a00:1819:b0:4ba:eaa6:d1b8 with SMTP id y25-20020a056a00181900b004baeaa6d1b8mr66115021pfa.78.1641592882966;
        Fri, 07 Jan 2022 14:01:22 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:3205:d63a:54aa:9c9d])
        by smtp.gmail.com with ESMTPSA id mw7sm6483556pjb.45.2022.01.07.14.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 14:01:22 -0800 (PST)
Date:   Fri, 7 Jan 2022 14:01:17 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v6 00/17] hook.[ch]: new library to run hooks + simple
 hook conversion
Message-ID: <Ydi4LbluVDTfaNGG@google.com>
References: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com>
 <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
 <Ydi1IHDE7PIybKmB@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ydi1IHDE7PIybKmB@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 07, 2022 at 01:48:16PM -0800, Emily Shaffer wrote:
> 
> On Wed, Dec 22, 2021 at 04:59:26AM +0100, Ævar Arnfjörð Bjarmason wrote:
> > 
> > A trivial update to v5 to rebase it past conflicts with topics that
> > recently landed on "master". For v5 see:
> > https://lore.kernel.org/git/cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com/
> 
> One note, which is not so useful for this time, but might be useful in
> the future:
> 
> It seems that in order to understand the purpose of this series and what
> it's building for, you need to be me or be you (and therefore be aware
> of the history of the series), or you need to go back through the
> breadcrumbs and eventually read my huge config-based-hooks 30-patch
> series (or at least the cover letter). Which sort of defeats the purpose
> of splitting the series up into smaller reviewable chunks.
> 
> Next time it might be nice to add a quick summary of the whole goal,
> which part of that goal this series is, and a link to the longer cover
> letter/older series? But again, for this time, I think it is probably
> too late, especially since this series looked pretty good to me.
> 
> Per-patch reviews to follow momentarily.

Left a couple nits here and there, but it all looks fine for me. Some
comments that I thought I had turned out to be invalid once I read the
series a second time... ;)

For all patches, but especially Ævar's,
Reviewed-by: Emily Shaffer <emilyshaffer@google.com>

I think that's stronger than an ACK for mine, but either way, for my
own patches:
Acked-by: Emily Shaffer <emilyshaffer@google.com>

Thanks. I'd be excited to see this go in.

 - Emily
