Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2488C28CF5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 17:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237263AbiAZRnk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 12:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbiAZRnj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 12:43:39 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44D4C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 09:43:38 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d7so200514plr.12
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 09:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xCr7AZOeyGWuph8AIAwdhdEOp2lNLGTgvIg6xHef9gs=;
        b=LVGX/f6m16hXmTQzgD7rCCZ6891du3Mt9m3VZupgRoAvwj5sTdtw6UU5FyJDT/f9QN
         tTlAYqzjEdrzrpSzE1Ri8Hip8LjIV+1dZ9zwttO3HpaLrrO4ip42NzLgRl31TlCFdDev
         dQkDlJHV8zCq+tpIQyzaDE1avkh6zpcew89CluWVNq2UZGCXqvIv19YfL5ybCz+NeBJU
         3FRjm+5xsfe387G15rd+hdRrmP6YzAiAxfXVvQvZZ9xUr9NG+wHzSNXjgNmxFEpabkMg
         xl96igUU7+UM5itZsz+Yc9AW83WHRXF1dVb5Nk8lx4aj0HPyR5rPw5fOlO0Qrdtnqf2V
         b6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xCr7AZOeyGWuph8AIAwdhdEOp2lNLGTgvIg6xHef9gs=;
        b=moT7s0o1EZnhMIObl7ZYkPsDmeIQ8ZiW//+R4iJ8Wf/vyx3RTOwdRCJB06o8y5BndG
         a7LNX/E6dka8A+ShGXTrQdmeYEh51Aq+mLBaCUwD2sKeakp7QE1J7b77Rxn163tXbkTN
         y3QNbRo1yxkaa4Zcvj3kA/pkbMcHUPtZm6Dr59JAHTqRdFgmk85bDgDnsZjvJEnCnwPZ
         JJVNZ/uMoSNMU6EBLlsz0eqn5MqUlvGKcIxXcDIVydtOfvYVClZIoGDyKYMyX2YMPU4Q
         FsTfT6wBarKtwXFH0vBAtfN5K/VM+xlVyE7sKUhEnS5jv/e7u7rsn+loPrmAW/NosxbU
         yJ0A==
X-Gm-Message-State: AOAM5330eKZvjOQaOHfetAuURzRH+qKfFyoNBkJ9u+4/xxhPgCWWGzOv
        vNSPrG8smAelrW3bYQwl+672TA==
X-Google-Smtp-Source: ABdhPJzIWTOVx11vxAro4XYG5sWuC3PVa5p5TQtSEPucsGvrxRWWipXoQIHWSsVY/Qm6ARnSiDpsMQ==
X-Received: by 2002:a17:902:ce8d:: with SMTP id f13mr83101plg.53.1643219017878;
        Wed, 26 Jan 2022 09:43:37 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:6aef:b12a:4316:e953])
        by smtp.gmail.com with ESMTPSA id 189sm2644352pfg.142.2022.01.26.09.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 09:43:36 -0800 (PST)
Date:   Wed, 26 Jan 2022 09:43:30 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        gitscale@google.com
Subject: Re: Submodule UX overhaul update (was: What's cooking in git.git
 (Jan 2022, #07; Mon, 24))
Message-ID: <YfGIQpJJ3qGro+FM@google.com>
References: <xmqq35lc53e9.fsf@gitster.g>
 <YfBTRuPrGGjepe+D@google.com>
 <CADi-XoThCqfvPnBd0p6yAhrtotK_3z2pQQMugWPsYpHLbXge7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADi-XoThCqfvPnBd0p6yAhrtotK_3z2pQQMugWPsYpHLbXge7w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 26, 2022 at 10:05:38PM +0530, Atharva Raykar wrote:
> 
> On Wed, Jan 26, 2022 at 2:02 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> >
> > Finally finding the time to write up another "what's cooking as pertain
> > to overhauling submodules UX" reply.
> >
> > [...]
> > >  Rewrite of "git submodule update" in C.
> > >
> > >  Expecting a reroll?
> > >  cf. <YWiXL+plA7GHfuVv@google.com>
> > >  source: <20211013051805.45662-10-raykar.ath@gmail.com>
> >
> > Sounds like Glen is interested in this series with regard to some edge
> > cases about cloning newly added submodules during a 'git fetch
> > --recurse-submodules'. I'm curious to hear from Atharva about the status
> > of this work :)
> 
> Hi!
> I'll preface by saying that I haven't had the time to keep this up to date
> with the other submodule developments.
> 
> My recollection was that this series had some small conflicts with
> es/superproject-aware-submodules. The last thing I had done was to
> rebase this on top of es/superproject-aware-submodules [0] and try to
> fix those conflicts. I had not rerolled that branch as a patch series yet,
> because I had thought that superproject-aware-submodules was still
> in flux.

Thanks! That makes sense. Oof. :(

> 
> I won't be able to actively work on this in the near future. Feel free to
> pick this up in case this patch is a blocker for yours or Glen's work.

Thanks for the update - that helps!

 - Emily

> 
> [0] https://github.com/tfidfwastaken/git/commits/submodule-update-on-es-superproject-aware
