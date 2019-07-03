Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84EE71F461
	for <e@80x24.org>; Wed,  3 Jul 2019 19:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfGCTBY (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 15:01:24 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36147 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfGCTBY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 15:01:24 -0400
Received: by mail-pl1-f194.google.com with SMTP id k8so1731535plt.3
        for <git@vger.kernel.org>; Wed, 03 Jul 2019 12:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n3IzS2LcApA61GkJ0lkF2YTJ5O4QOCUFWdsPYEqlyxc=;
        b=Gs4vvvjQ/T+pdGiMowWhBEuxOpbYR99HfQ4WCh6tDGRjjhfAZ/SgAp81ao3ZM2i+Bf
         yeK5kjl7L19p57CpgNJ04TcypIAbDPRrpiLyaQqWZ9hgFGnKo/yN5ShpK15sPBM8hpjF
         WO5tMSe/olfFEJC2AYpddRvjrtIHr6a39JE8QcQRd4tPwWZZgbB5ncwMG4PpBdKI490s
         yFM+CbYt9ppgQX/Gfh7oLBd8LkDBctO4OoNDwUA14owvnh+lcC9Usb/k0lj8Dm7pNUiN
         mukYliwzLo4CYIlpPHC+EFkWxpNEQOWyTeCJHgf1OXBDi4F7dKNQCiXzpgRUQ2UTgaAM
         iLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n3IzS2LcApA61GkJ0lkF2YTJ5O4QOCUFWdsPYEqlyxc=;
        b=d9wCoPDBZglyTU7jUHMS0SPTCMn42sD1mp/Ag3Y0LTL+E6YEGwr45GHnvZx4ikYIGl
         +eq86eVZZbMy/kgliL6iQPZtqRR6JH7RWpgyiDdxNKfaLY6/+ki68g6Z8N+xdjm/8gqa
         EnrxbVmhGT8L7aWh37Z18lrhnA/VZ4RAc+DOLcjrq2uyftXqhyDqhIbQD8Gp8ARqMCk+
         NRZaQVVAkVnEw15Ko37My0uIiyVuMel1JZaG3iHjK0iy7UgrtBOeBV81OawY7VOjpOOG
         OZnf3e5oboKM2C63Ps9OjmgGF19rWDwaIMO/ggS4OdTBPgQ+SPkLsyAISJHdY20fm5j+
         2cCQ==
X-Gm-Message-State: APjAAAWQ5I+/rt2y4KxAgck31ocAqEQnC0+2ul0qFwPtSYoWqfTfKoCI
        SvvbbHWmkr75Np0VTtCxlljlxw==
X-Google-Smtp-Source: APXvYqzPUV2KHqsvIOW5d47iZMxslvRo5G+cH4OU+Qsf/9HUyXSTwlNqpNLIxHyxTyo/pa0Gu9dawA==
X-Received: by 2002:a17:902:9a49:: with SMTP id x9mr32840718plv.282.1562180483181;
        Wed, 03 Jul 2019 12:01:23 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id x1sm2638446pjo.4.2019.07.03.12.01.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 12:01:22 -0700 (PDT)
Date:   Wed, 3 Jul 2019 12:01:18 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] transport-helper: enforce atomic in push_refs_with_push
Message-ID: <20190703190118.GE121233@google.com>
References: <20190702005340.66615-1-emilyshaffer@google.com>
 <nycvar.QRO.7.76.6.1907021540330.48@tvgsbejvaqbjf.bet>
 <20190703185535.GC121233@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703185535.GC121233@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > > > +'
> > > +
> > > +test_expect_success 'push --atomic shows all failed refs' '
> > > +	# Make up/master, up/allrefs
> > > +	d=$HTTPD_DOCUMENT_ROOT_PATH/atomic-failed-refs.git &&
> > > +	git init --bare "$d" &&
> > > +	git --git-dir="$d" config http.receivepack true &&
> > > +	up="$HTTPD_URL"/smart/atomic-failed-refs.git &&
> > > +	test_commit allrefs1 &&
> > > +	test_commit allrefs2 &&
> > > +	git branch allrefs &&
> > > +	git push "$up" master allrefs &&
> > > +	# Make master and allrefs incompatible with up/master, up/allrefs
> > > +	git checkout allrefs &&
> > > +	git reset --hard HEAD^ &&
> > > +	git checkout master &&
> > > +	git reset --hard HEAD^ &&
> > > +	# --atomic should complain about both master and allrefs
> > > +	test_must_fail git push --atomic "$up" master allrefs >&output &&
> > > +	grep master output &&
> > > +	grep allrefs output
> > > +'
> > 
> > I have the impression that the setup these two new test cases perform are
> > _very_ similar, making it most likely that a combined test case would be
> > more succinct, yet still complete and easily readable.
> 
> (Junio replied to this downthread... I have more to ask too.)

Oops, I misremembered which comment he had replied to. Yeah, I'll think
about this and reword.

Reroll to come shortly. Thanks, all.

 - Emily
