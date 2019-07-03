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
	by dcvr.yhbt.net (Postfix) with ESMTP id 19DC71F461
	for <e@80x24.org>; Wed,  3 Jul 2019 00:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfGCAjj (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 20:39:39 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33705 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbfGCAji (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 20:39:38 -0400
Received: by mail-oi1-f193.google.com with SMTP id u15so601740oiv.0
        for <git@vger.kernel.org>; Tue, 02 Jul 2019 17:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=347HD6HdyKqVx6da31m1H18BtUZgkRay65g4pm3DnU8=;
        b=it8mdk4HXWwmLbIR7VVpmNWQHvVgfWZNB2HnyHlF6zxlX5a1fUmftcmr+92gltf7No
         SfTU2xn2Qqmlr6Cp+2Js4AJLiJFtFvBjgk7djSEoiARBJqgO9PtZCiBmhzO8QoMb95xd
         wEYwoEkTnscJczsuPGVl06X6ZdonWY77IL9rUtL1/o5sT3Vp9VX65mm5dv6lmSpx2mbq
         fg5r/GwEkPV/98Bf+TsXXZxZaiL49oEHXW0fvVG7O8adKu6Z31lzCK6lk9DKYaW+4c1L
         aiJuDN/3PFB0HmfWIy2i8Q43VdWyFttQ2I1/w4tm6MnvVLLlIkH5byj5/LwYtSYahqHh
         jjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=347HD6HdyKqVx6da31m1H18BtUZgkRay65g4pm3DnU8=;
        b=mbvlKRgcwzm6zQAGjc5vKUDtQlzJkbxAvLPOG5sLStJXB4xz6NS9TvyXIitKQ7k/8W
         neRd+OVUiILV/HlnqEuWvYXgNgMUGsZee7n6aatJb4ZwPHPJBoMVOxQlZQhhYcsqQsDw
         WDTvWxu2p3XePLGJZL1JppwXPlae0O9xF1zei7jvhblr7yniGEmOTWjL6wH0TLEiljK0
         yieVDwUWb9hgZzZY4fmahWBgTxeJtzRFxd44QxoKNFkDl7a09nAVvgtF3OSiQAiht1jG
         upCo7HSIG5j9WheJbG+9TVwaxHchuVX2BJpxN62h2b369An59RNU3pfKrJaR4bHY8kkW
         Nvmg==
X-Gm-Message-State: APjAAAU/o2MuWMdQS5DVxdIK4bBxQ9DDRV4uHMSDmpTrcUNzeOdHXUxo
        OlQoHvqBrnlM6z3/NEA6yGpwyxKEdA3soA==
X-Google-Smtp-Source: APXvYqyOea9E9eti9Ia8k32l6pxFX8pWakuCKkE+LC3G44kTR6VdX99eUCaJJZEBD9qWPBh/C7e6Gg==
X-Received: by 2002:a65:62ca:: with SMTP id m10mr33301741pgv.57.1562112529442;
        Tue, 02 Jul 2019 17:08:49 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id w187sm221201pfb.4.2019.07.02.17.08.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 17:08:48 -0700 (PDT)
Date:   Tue, 2 Jul 2019 17:08:44 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] transport-helper: enforce atomic in push_refs_with_push
Message-ID: <20190703000844.GA121233@google.com>
References: <20190702005340.66615-1-emilyshaffer@google.com>
 <xmqqa7dw2k49.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa7dw2k49.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 02, 2019 at 02:37:42PM -0700, Junio C Hamano wrote:
> >  
> > +test_expect_success 'push --atomic also prevents branch creation' '
> > +	# Make up/master
> > +	d=$HTTPD_DOCUMENT_ROOT_PATH/atomic-branches.git &&
> > +	git init --bare "$d" &&
> > +	git --git-dir="$d" config http.receivepack true &&
> > +	up="$HTTPD_URL"/smart/atomic-branches.git &&
> > +	test_commit atomic1 &&
> > +	test_commit atomic2 &&
> > +	git push "$up" master &&
> > +	# Make master incompatible with up/master
> > +	git reset --hard HEAD^ &&
> > +	# Add a new branch
> > +	git branch atomic &&
> > +	# --atomic should roll back creation of up/atomic
> > +	test_must_fail git push --atomic "$up" master atomic &&
> > +	git ls-remote "$up" >up-remotes &&
> > +	test_must_fail grep atomic up-remotes
> 
> Don't use test_must_fail on non-git things.  We are not in the
> business of catching segfaulting system programs.

Done:
  ! grep atomic up-remotes

> 
> > +'
> > +
> > +test_expect_success 'push --atomic shows all failed refs' '
> > +	# Make up/master, up/allrefs
> > +	d=$HTTPD_DOCUMENT_ROOT_PATH/atomic-failed-refs.git &&
> > +	git init --bare "$d" &&
> > +	git --git-dir="$d" config http.receivepack true &&
> > +	up="$HTTPD_URL"/smart/atomic-failed-refs.git &&
> > +	test_commit allrefs1 &&
> > +	test_commit allrefs2 &&
> > +	git branch allrefs &&
> > +	git push "$up" master allrefs &&
> > +	# Make master and allrefs incompatible with up/master, up/allrefs
> > +	git checkout allrefs &&
> > +	git reset --hard HEAD^ &&
> > +	git checkout master &&
> > +	git reset --hard HEAD^ &&
> > +	# --atomic should complain about both master and allrefs
> > +	test_must_fail git push --atomic "$up" master allrefs >&output &&
> 
> Don't rely on ">&output", which is an unnecessary bash-ism here.  It
> breaks test run under shells like dash.
> 
> 	>output 2>&1
> 
> should be OK.

Done.

> 
> > +	grep master output &&
> > +	grep allrefs output
> > +'
> > +
> > +test_expect_success 'push --atomic indicates collateral failures' '
> > +	# Make up/master, up/collateral
> > +	d=$HTTPD_DOCUMENT_ROOT_PATH/atomic-collateral.git &&
> > +	git init --bare "$d" &&
> > +	git --git-dir="$d" config http.receivepack true &&
> > +	up="$HTTPD_URL"/smart/atomic-collateral.git &&
> > +	test_commit collateral1 &&
> > +	test_commit collateral2 &&
> > +	git branch collateral &&
> > +	git push "$up" master collateral &&
> > +	# Make master incompatible with up/master
> > +	git reset --hard HEAD^ &&
> > +	# --atomic should mention collateral was OK but failed anyway
> > +	test_must_fail git push --atomic "$up" master collateral >&output &&
> 
> Ditto.

Done.

 - Emily
