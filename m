Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D56CC433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7405860524
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhJ2VPJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 17:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhJ2VPI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 17:15:08 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B023AC061570
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 14:12:39 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d13so18573838wrf.11
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 14:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=L1tDgnfP8DBTa6zImxEdo9yIDhxVLzuDobqSqtE4o3g=;
        b=YCm/dMD8MfODOicZVZzSSIYFArxx0BpOsvMXOeqfws2tVjEkSpgwmWwQmp/bLRVMQz
         LOtLeGnbcLjdWOW8OhN0twHboAlsmQ3wR/lo+oL3YjsM2jnrVplHRuirX0lEkyJPqeUk
         ElEsqp6yIWFzI+D6hgZMZmbeXskSl3BerH/Dum4C9lgyMQmX9ff0obqAZclrWsYvH7o+
         DN3cG9rRwmYLqEey4TEbLoh0HD1N54xJfcFIVTyewGPxdcpBav7fjLC3B6ITbJ28m9SM
         gMtWzu5EOar68lgnBBSr0EAA9U+6d1Nn/n47G1+4MUUyOFZ9rwIKhn60yW4C1Q/MTkCo
         sWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=L1tDgnfP8DBTa6zImxEdo9yIDhxVLzuDobqSqtE4o3g=;
        b=kbCqH6TUoeOqIAME8kmOTdfpJl1mcr7pxr28wiFaU1vE/7CPF7yIEJGvFnJFqgsNcC
         1lZkl+QHIQEVjmfYS7lw1nUHCKW5QelcwIMHrM7HlAkteSplgAgnkR2GaTr6X4TTmIJe
         47mdBGTOjgsTL3k3QN+XouyDawhFmoJDfxEof2gn/w7cVFokUQU/bLM4rmYM8sanqjtj
         7o92kaglkwP9fVrFl0jTI+n1CCj9v2p09P38FZiTBo7AFpvir36aR6g6KRXqUCPc5h5p
         LAnRhHuT23J1ddp+sc+fZJUikvcBptHXIaZL27C7o3e7r8G2VFF0fVJ2a4yh7qYfdpOd
         KvoQ==
X-Gm-Message-State: AOAM532RHLkfCmtKDCTn9P+clF9eaMBh1n4HKhafBzIZvdT5MjctJh+0
        RQarjybWsRn8gqstdpaG2sY=
X-Google-Smtp-Source: ABdhPJyGwQMLV2ATHHBLw6uSI0dFecBH+v1hrji0MNYAg0aJUW3noJ/AbtemajwtEUK39hLOrYvvUA==
X-Received: by 2002:adf:fc49:: with SMTP id e9mr17306977wrs.130.1635541958275;
        Fri, 29 Oct 2021 14:12:38 -0700 (PDT)
Received: from [172.20.119.151] (cgn-213-196-213-29.nc.de. [213.196.213.29])
        by smtp.gmail.com with ESMTPSA id j10sm6496114wrx.94.2021.10.29.14.12.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Oct 2021 14:12:38 -0700 (PDT)
Date:   Fri, 29 Oct 2021 23:12:16 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmail.com>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 0/8] Allow clean/smudge filters to handle huge files
 in the LLP64 data model
In-Reply-To: <nycvar.QRO.7.76.6.2110292239170.56@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2110292311200.56@tvgsbejvaqbjf.bet>
References: <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>        <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com> <xmqqk0hvllxp.fsf@gitster.g> <nycvar.QRO.7.76.6.2110292239170.56@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Re-sending, as it seems that the Git mailing list is causing trouble
again, at least I do not see this on lore.kernel.org/git]


On Fri, 29 Oct 2021, Johannes Schindelin wrote:

> Hi Junio,
> 
> On Fri, 29 Oct 2021, Junio C Hamano wrote:
> 
> > "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> > writes:
> > 
> > > This patch series came in via the Git for Windows fork
> > > [https://github.com/git-for-windows/git/pull/3487], and I intend to merge it
> > > before v2.34.0-rc0, therefore I appreciate every careful review you gentle
> > > people can spare.
> > 
> > It is way too late for my tree to go in before -rc0, but the patches
> > in the last round, with the "Changes since v2" description below,
> > all sound sensible, including the decision to stop here, instead of
> > doing "everything should be either size_t or intmax_t" conversion.
> 
> Thank you for your careful review, it definitely helped with polishing the
> patches.
> 
> > 7/8 did not apply for me to the tip of 'master', but "am -3" wiggled
> > it in.  You may want to double check the results.
> 
> Right, I purposefully based the patches on v2.32.0 so they would merge
> cleanly into Git for Windows' `main` branch.
> 
> I should have clarified that I was talking about merging that PR into Git
> for Windows before the -rc0 ;-)
> 
> Speaking of which, -rc0 is still coming, right? ;-)
> https://tinyurl.com/gitcal still claims that it was scheduled for
> yesterday.
> 
> > As the primary author of the series, given the cover title matches the
> > title of one step in the series, seems to be Matt, let me queue them
> > under mc/clean-smudge-with-llp64 topic.
> 
> Absolutely. Matt was in the driving seat, I was just reviewing and helping
> here and there, and then shepherding the patch series upstream. It was my
> decision to start upstreaming before merging it into Git for Windows, but
> the plan was all along to get this into Git for Windows v2.34.0 because
> there are Git LFS users using Windows who are eagerly awaiting this fix.
> 
> I am not aware of any other popular platform using the LLP64 data model,
> therefore I do not even think that these patches have to be fast-tracked
> into Git v2.34.0, next cycle would be good enough. Unless you are aware of
> other such platforms that do not rely on the Git for Windows fork, but on
> Git built from your repository?
> 
> Ciao,
> Dscho
> 
