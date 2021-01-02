Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA3FC433E6
	for <git@archiver.kernel.org>; Sat,  2 Jan 2021 22:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEF8720798
	for <git@archiver.kernel.org>; Sat,  2 Jan 2021 22:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbhABWCp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Jan 2021 17:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbhABWCo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jan 2021 17:02:44 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2AEC061573
        for <git@vger.kernel.org>; Sat,  2 Jan 2021 14:02:03 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id a109so22664616otc.1
        for <git@vger.kernel.org>; Sat, 02 Jan 2021 14:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=dPY3phGHoIHCTZIggA8gFba1ukM/mCOPd3rygYsDeb0=;
        b=bBypEbwozg6bg39fNHKuNh/GRWa4WDsB3eKtvTW6qM0GGN69AEAbm9wYy2R+BnkWsS
         /WuMoxnk05p5JEHZ2oZLyeRUq+QffhA+CBnSH1Wse8i+O+Z8vtJSP4aZTHXgjtgXCaD2
         MDnMj+w2cFp4nxui8NWrjSpTiz5DCbD3OGqEdmM0QPMau4JUNoO6Ic+UjVoOw+ObJ/KR
         QFxn1wICICJuVS0kmLvPDsodWJ6caNOZ3dcyppNOe2J12ute1sw2Pgta44ddui6oOCCN
         CtOh3eREIIlBM2En2ighL2DGsuYdTrrlvHFlbBzS4IVU6f3m4G6Nq6AKxMqrP3ohsw6M
         H11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=dPY3phGHoIHCTZIggA8gFba1ukM/mCOPd3rygYsDeb0=;
        b=EBjQOmejW2rnYwu0gxmi/mw87/k/vBLVVwBlF9mYuTRxGwBAUP2lOCjgHGYnU+iISP
         DOYdVZhjM/JGFyIfp/Q0D/yyvfwH7RGc7JhoAjedz2KKMHpyNjVUctQtk6QpOK7vP94y
         RufQsTzc5gRaSylecJXj7Kl+v3xMonFOimtPG9y1I/ACThm5Vtswn8TBip6/NQWTg3t0
         IHy2aQStmfIPLx6wtoeXBevka0tmgOkwx6yvwEo1EzJ+VSXaCp7CccrhNwrQgh4SLCdg
         awgP4J5qrdHwXNNVPXLhFtxqyfTjpcqjOKk+K6LX9tlz7JokkPGEPcWIsbCZCNR2QDHs
         hgMg==
X-Gm-Message-State: AOAM533U2YpOnmJnYwujeqefeHOWWXex7eWh5LNr9M2pd9l3PuyRZGWg
        OehUZ2smtmZE0Le//LD9dAholYcyLYz/bQ==
X-Google-Smtp-Source: ABdhPJys8bXnGsJ6vuke2bCn87HrmnqOMrdUYfUXiiHk524EHSTqQrZZKWcza2MEknFKGYW43omyVQ==
X-Received: by 2002:a9d:1d41:: with SMTP id m59mr48216203otm.100.1609624923189;
        Sat, 02 Jan 2021 14:02:03 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id f25sm12379984oou.39.2021.01.02.14.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jan 2021 14:02:02 -0800 (PST)
Date:   Sat, 02 Jan 2021 16:02:01 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Yaroslav Nikitenko <metst13@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <5ff0ed59489bd_a76d2082f@natae.notmuch>
In-Reply-To: <CA+RLzGArUrxC-Kbng3qGpRZUrZXKZj3zD3Hcut=XrUY-i-eYAw@mail.gmail.com>
References: <CA+RLzGCtp2T=8DG74geBs67X5vUvhwRP4FMZ6MJv+E+Pj=YbWw@mail.gmail.com>
 <5ff0c58422038_90dc208ea@natae.notmuch>
 <CA+RLzGArUrxC-Kbng3qGpRZUrZXKZj3zD3Hcut=XrUY-i-eYAw@mail.gmail.com>
Subject: Re: git-dir requires work-tree; documentation improvements for
 working directory
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yaroslav Nikitenko wrote:
> 2021-01-02 22:12 GMT+03:00, Felipe Contreras <felipe.contreras@gmail.com>:
> > Yaroslav Nikitenko wrote:
> >> I use git to manage my dotfiles with this command:
> >>
> >>     git --git-dir=/home/yaroslav/.cfg/ --work-tree=/home/yaroslav
> >
> > I do precisely the same thing.
> >
> >> When reading documentation, I noticed two issues.
> >>
> >> 1) The command doesn't work without --work-tree (even from the top
> >> level directory, which is my home directory).
> >>
> >>     [~]$ git --git-dir=/home/yaroslav/.cfg/ status
> >>     fatal: this operation must be run in a work tree
> >
> > That's weird. It works fine here (although I don't see why I would want
> > that).
> 
> BTW, how do you do that in your case?

I have an alias:

  alias config='git --git-dir=$HOME/.config/dotfiles/.git/ --work-tree=$HOME'

So, when I'm in my $HOME, I can do:

  config status

> > If you remove all your configuration does it still fail?
> 
> It starts to work when I remove my .cfg/config. I've no idea why it
> happens. Here is its contents:
> 
> $ more .cfg/config
> [core]
> 	repositoryformatversion = 0
> 	filemode = true
> 	bare = true

That's the difference: my core.bare is false.

I do have a checked out work-tree because that's the only way I could
get some commands to work, for example `git rebase`, even though I don't
use that work-tree.

I'm not sure if it makes sense to not assume '.' is the work-tree when
'core.bare=true', but I think it does make sense, so maybe just turn
that off.

Cheers.

-- 
Felipe Contreras
