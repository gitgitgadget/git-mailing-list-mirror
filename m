Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9834E1F597
	for <e@80x24.org>; Wed, 27 Jun 2018 18:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934556AbeF0SJd (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 14:09:33 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37588 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932159AbeF0SJc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 14:09:32 -0400
Received: by mail-wr0-f193.google.com with SMTP id k6-v6so2951657wrp.4
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 11:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pt1JaK06VZJ9udVKSBrBKV6UKKg01pKjzStYFARGGUI=;
        b=gc4JexIKfxVpWAlc5Rwg2oE/FTF1jTby4TAefNvr9DcC/B3ACwfmm5PoIEeD2OPGE5
         AcOZq5KMt+Sg69op5+CgZgQz2xIsp89wpTblM41YoAJU69ebVAkGHyhkubgrNWoQuFnM
         HAoNZPeTqq+TonWXeE/XnkJz7swEZR9jqa11EyD3Htl8nnWsIaq9zhi9RNFXa3q4zVNX
         WL1Mfz1LGMGnzz44161rtpi/HnW66nK5F3LrKfraG98u4v5MnDcuuOrBaXZL54nY93CP
         gEa406DtFCNC1hrLEAgXJnel8wTD2mVInYCzCnIjGBGP6FL8+VQR/SDf2D6NpUDTWFAx
         fIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pt1JaK06VZJ9udVKSBrBKV6UKKg01pKjzStYFARGGUI=;
        b=rr9qOaV4cXbQ53+MJlPzAg/eVIpGsrR1QS77VY3TbuUCD0/WYi6DJSq4bah9+lTqKC
         xaXEppLCpwADJHDCGagMOxsFyYXyab9+Qggz8znKAglI58LpaKzEoSGYTrOBxd7Lop8U
         YhX2ecTI5Y7VGvIlIH9O+Mkn7LHHRDqjqTVmDdXOMntsWJcN4ihvwXZCmVPc0Ee9g0aV
         U6dwkeolJWMsk1zm3rAIuHAfETHLBMqOgjd6JqJ6+uP3xo1vsfoyv1Zb1F04XxaCUKjC
         WcJMoQyYhadYQOhGKeMnvK0TuoEGiV7Y32jGyIjxAgGaU3Sqi5p7eSGi6Wba0KBUmP10
         pGQw==
X-Gm-Message-State: APt69E31iZ9h8z9xsGkMjGQt0oCYRvZ3gExnsVA7f/pllKgShbuz1Dfv
        /Qtb7n3QvoxyMtAR8H/TivA=
X-Google-Smtp-Source: AAOMgpecPa+EAo2rHV/YJ/jXFptcdVdzngIk3LUzE8uOhuZjydpNlykpmdlaUGWnWAEwPfOT6dd6YQ==
X-Received: by 2002:adf:b111:: with SMTP id l17-v6mr6089642wra.269.1530122971389;
        Wed, 27 Jun 2018 11:09:31 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v15-v6sm5710289wrq.37.2018.06.27.11.09.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 11:09:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, sbeller@google.com,
        jnareb@gmail.com, marten.agren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v7 21/22] gc: automatically write commit-graph files
References: <20180608135548.216405-1-dstolee@microsoft.com>
        <20180627132447.142473-1-dstolee@microsoft.com>
        <20180627132447.142473-22-dstolee@microsoft.com>
Date:   Wed, 27 Jun 2018 11:09:30 -0700
In-Reply-To: <20180627132447.142473-22-dstolee@microsoft.com> (Derrick
        Stolee's message of "Wed, 27 Jun 2018 09:24:46 -0400")
Message-ID: <xmqqr2ksf6ed.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> @@ -40,6 +41,7 @@ static int aggressive_depth = 50;
>  static int aggressive_window = 250;
>  static int gc_auto_threshold = 6700;
>  static int gc_auto_pack_limit = 50;
> +static int gc_write_commit_graph = 0;

Please avoid unnecessary (and undesirable) explicit initialization
to 0.  Instead, let BSS to handle it by leaving " = 0" out.

> +test_expect_success 'check that gc computes commit-graph' '
> +	cd "$TRASH_DIRECTORY/full" &&
> +	git commit --allow-empty -m "blank" &&
> +	git commit-graph write --reachable &&
> +	cp $objdir/info/commit-graph commit-graph-before-gc &&
> +	git reset --hard HEAD~1 &&
> +	git config gc.writeCommitGraph true &&
> +	git gc &&
> +	cp $objdir/info/commit-graph commit-graph-after-gc &&
> +	! test_cmp commit-graph-before-gc commit-graph-after-gc &&

The set of commits in the commit graph will chanbe by discarding the
(old) tip commit, so the fact that the contents of the file changed
across gc proves that "commit-graph write" was triggered during gc.

Come to think of it, do we promise to end-users (in docs etc.) that
commit-graph covers *ONLY* commits reachable from refs and HEAD?  I
am wondering what should happen if "git gc" here does not prune the
reflog for HEAD---wouldn't we want to reuse the properties of the
commit we are discarding when it comes back (e.g. you push, then
reset back, and the next pull makes it reappear in your repository)?

I guess what I am really questioning is if it is sensible to define
"--reachable" as "starting at all refs", unlike the usual connectivity
rules "gc" uses, especially when this is run from inside "gc".

> +	git commit-graph write --reachable &&
> +	test_cmp commit-graph-after-gc $objdir/info/commit-graph

This says that running "commit-graph write" twice without changing
the topology MUST yield byte-for-byte identical commit-graph file.

Is that a reasonable requirement on the future implementation?  I am
wondering if there will arise a situation where you need to store
records in "some" fixed order but two records compare "the same" and
tie-breaking them to give stable sort is expensive, or something
like that, which would benefit if you leave an escape hatch to allow
two logically identical graphs expressed bitwise differently.

> +'
> +
>  # the verify tests below expect the commit-graph to contain
>  # exactly the commits reachable from the commits/8 branch.
>  # If the file changes the set of commits in the list, then the
