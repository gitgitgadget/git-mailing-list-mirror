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
	by dcvr.yhbt.net (Postfix) with ESMTP id AE8A71F461
	for <e@80x24.org>; Wed,  3 Jul 2019 18:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfGCS7E (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 14:59:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36177 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfGCS7D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 14:59:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id r7so1722669pfl.3
        for <git@vger.kernel.org>; Wed, 03 Jul 2019 11:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=N7H1cG5q2KGmaEANwBOmA17WPB7yYRU3IQkpTaT1V9Q=;
        b=Xnc7GQRISOnIViVS5mF6XywWld2bPknD1NCYfLQVLBbPGd+pca3JBjmhxeJgmgEXhD
         6SEJGGOxGxpAMzkgPdbhQx7gflcH+GpvRpm4dyH2+7L8iJSgeoUxNKOClvWnMTLzED5u
         qIGjFdKVe2RF1FLKhE6goBwDwaA2Reer6qp0mWzuzRfP87QgeJ9owkPDFWLYeUJeBe7W
         x9kEpnzTEG2Pl9yFuaCZGWaYK6+3ksfqsdWjeCFn1CMF7U8beN+voNf9cFcU2nwaOtdA
         T1jo+DaJcEjLz3j6uqmFtShpk9gCFSG1tKnHe/dTPhhunSaCWRfRNpe0Vc54uFlSmvuV
         VhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=N7H1cG5q2KGmaEANwBOmA17WPB7yYRU3IQkpTaT1V9Q=;
        b=DVjEx1KAiyTpN+bUg6KGxgNwsFC4cxrfI6dGSxR0b3AJitWaQNSAMjP5cX+AHGyJE7
         2zBTviEyOu+SjwhELERm3fPADkTVURx7tI/uvbDiOcbOZD7EUctrvLd1HPHO1vgr6SD5
         HlfeyvPYacl3fxJMD0rA9ozjlN7s7fqp5iogfamUPEn9XOnUz8dJgjCY/sQEAmJTgMGE
         HGade8rJb1dN/jZSoGshlTqLj0ww6tPputlJ5CIyMU7ebY4VlTQsqmCP8mnUzZFoV32q
         0dP4hejwb4hIGTEyKOhwY543LGUrwsZZZwuujVAp3Y4VKz1MW7hGFrR6mAE9+Xo+Sf/O
         rAmg==
X-Gm-Message-State: APjAAAVh9i3iKqNWk6djOZuEJT88GFFfWTrdaNM/a+Nr8D6Q4OOA6uH1
        oefQog546WQzZRTwfPSWYdx17g==
X-Google-Smtp-Source: APXvYqzQFOy85VE8JcoUtNHUiJwdWYpqnD7AdwGi8QWvXK27CC5GjQyeOU/75Tu1GFLU0Y/nuGGQIQ==
X-Received: by 2002:a17:90a:246f:: with SMTP id h102mr14347445pje.126.1562180342834;
        Wed, 03 Jul 2019 11:59:02 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id i14sm7385822pfk.0.2019.07.03.11.59.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 11:59:02 -0700 (PDT)
Date:   Wed, 3 Jul 2019 11:58:57 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] transport-helper: enforce atomic in push_refs_with_push
Message-ID: <20190703185857.GD121233@google.com>
References: <20190702005340.66615-1-emilyshaffer@google.com>
 <xmqqa7dw2k49.fsf@gitster-ct.c.googlers.com>
 <20190703091030.GP21574@szeder.dev>
 <xmqqblyb0yw6.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqblyb0yw6.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 03, 2019 at 11:13:45AM -0700, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > On Tue, Jul 02, 2019 at 02:37:42PM -0700, Junio C Hamano wrote:
> >> > +test_expect_success 'push --atomic shows all failed refs' '
> >> > +	# Make up/master, up/allrefs
> >> > +	d=$HTTPD_DOCUMENT_ROOT_PATH/atomic-failed-refs.git &&
> >> > +	git init --bare "$d" &&
> >> > +	git --git-dir="$d" config http.receivepack true &&
> >> > +	up="$HTTPD_URL"/smart/atomic-failed-refs.git &&
> >> > +	test_commit allrefs1 &&
> >> > +	test_commit allrefs2 &&
> >> > +	git branch allrefs &&
> >> > +	git push "$up" master allrefs &&
> >> > +	# Make master and allrefs incompatible with up/master, up/allrefs
> >> > +	git checkout allrefs &&
> >> > +	git reset --hard HEAD^ &&
> >> > +	git checkout master &&
> >> > +	git reset --hard HEAD^ &&
> >> > +	# --atomic should complain about both master and allrefs
> >> > +	test_must_fail git push --atomic "$up" master allrefs >&output &&
> >> 
> >> Don't rely on ">&output", which is an unnecessary bash-ism here.  It
> >> breaks test run under shells like dash.
> >> 
> >> 	>output 2>&1
> >> 
> >> should be OK.
> >
> > '2>output' would be a tad better, because those refs should be printed
> > to stderr.
> 
> Yeah; there are many existing uses of ">output 2>&1" in the same
> script and I was following the suit.  There also are 2>err and I
> agree that it is more appropriate in this case.

Oh, this is a good point. I'll change it, thanks both.
