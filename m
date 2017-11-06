Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF01820A10
	for <e@80x24.org>; Mon,  6 Nov 2017 18:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932491AbdKFShI (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 13:37:08 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:50963 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754146AbdKFShG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 13:37:06 -0500
Received: by mail-io0-f182.google.com with SMTP id 97so16715342iok.7
        for <git@vger.kernel.org>; Mon, 06 Nov 2017 10:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hDoK2uEc2hJG5xWCz7cW0zGwI5N2mEL0iOkaLi3xsTM=;
        b=hVRDozghgSOocvb3LYjVC4xCfrfUQyCdXMg1lcLfbq/dLGu4cHUxgBgiXqbffkvcGl
         Bclih+USTrBKh3M7D1BNFr6LXlttcroBbA6PO45JFzNi1i9MqVCuea4NbTOz7D9ouJW7
         z0aFu85zF250mpBgmD77KZsLtJLhwkEI/giDxZ9bbTus6BNKMWvA5py4tf/6iJMJ31tp
         lReqZWXzg+rqY5AdYEJMeAG2SPTQV2ncNt5Kcl1JIrySt/o3NYvehRr2tQz1j/pfh1yD
         sgdCOUNs1KRSgxWRyiIoqKp3mwkOJrUq5wnWPIteiW2s2i76LTD8tZHvN8tyI1QiRi6e
         2Q9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hDoK2uEc2hJG5xWCz7cW0zGwI5N2mEL0iOkaLi3xsTM=;
        b=FyCzN0BfRzgKvWhZercC16WVhYlTlWLPt0IXKFD7RZxosJblszEKt4MwMrnNpejcMj
         AxC5Dg7C+pnu/wQcK50xwbpfNPz2GFhPGIgeQEMiZGJ5Ajj0UPJvKfzoqHTCOYtmSyYw
         +UeaUOuk7mf4EqqL/hwIEiX3eya35aRmDDv6nkjxfL+MntDcTolvdP2u5Ft1ziWMECFP
         yRVE8txYobX7/MS3cBeYKIGsAciKz5agPF2oS9BGmA6TYh8GCTjZtcQDYHa3AzKuloTm
         qcIXgiJlUIcsUe5Qw9KyCOELORfKQsr78Xc6DUV3xXnu4VguwBZ+wP47rGng/R4k55yf
         a7rg==
X-Gm-Message-State: AJaThX5pZ40YNkSVVKfjKVq+3gMG+b81ReGVDM4PlwTOTAWDT2rswU8m
        0TSKlf5sX9JB/tfXnDR60Q9nvg==
X-Google-Smtp-Source: ABhQp+QrtbE/TW711gl6q+SGf0PRyD0a3eFsUMuU7GPey6MtzQUAuIYimcdgwUDQSbqGpu1DdFCcBg==
X-Received: by 10.107.199.132 with SMTP id x126mr12900248iof.264.1509993425251;
        Mon, 06 Nov 2017 10:37:05 -0800 (PST)
Received: from google.com ([2620:0:100e:422:c487:838c:3a00:2278])
        by smtp.gmail.com with ESMTPSA id b96sm4686085itd.4.2017.11.06.10.37.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 06 Nov 2017 10:37:04 -0800 (PST)
Date:   Mon, 6 Nov 2017 10:37:02 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Orgad Shaneh <orgads@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Subject: Re: Regression[2.14.3->2.15]: Interactive rebase fails if submodule
 is modified
Message-ID: <20171106183702.GA131418@google.com>
References: <CAGHpTBJTm=3f_VCnNLeE=V4CwvC6dM8qCmGRPDap6rszcpb65A@mail.gmail.com>
 <alpine.DEB.2.21.1.1711031658190.6482@virtualbox>
 <alpine.DEB.2.21.1.1711031711530.6482@virtualbox>
 <CAGHpTB+23H=iC_uv0K=GajnCBHSVRsUYgGFUn9-bAdcX=azL-w@mail.gmail.com>
 <CAGHpTBJFR2Y+Sg-xQzBpC6qu+NKPDSYyMwSe9Py9FtD2-bRAXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGHpTBJFR2Y+Sg-xQzBpC6qu+NKPDSYyMwSe9Py9FtD2-bRAXg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/05, Orgad Shaneh wrote:
> On Sat, Nov 4, 2017 at 8:04 PM, Orgad Shaneh <orgads@gmail.com> wrote:
> > On Fri, Nov 3, 2017 at 6:20 PM, Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> >> Hi Orgad,
> >>
> >> On Fri, 3 Nov 2017, Johannes Schindelin wrote:
> >>
> >>> On Thu, 2 Nov 2017, Orgad Shaneh wrote:
> >>>
> >>> > I can't reproduce this with a minimal example, but it happens in my project.
> >>
> >> Whoa, I somehow overlooked the "can't". Sorry.
> >>
> >> I inserted a `git diff-files` here, and it printed exactly what I
> >> expected:
> >>
> >> ++ git diff-files
> >> :160000 160000 62cab94c8d8cf047bbb60c12def559339300efa4 0000000000000000000000000000000000000000 M      sub
> >>
> >>> +             git rebase -i HEAD^^
> >>> +     )
> >>> +'
> >>
> >> There must be something else going wrong that we did not replicate here.
> >> Maybe the `error: cannot rebase: You have unstaged changes.` message was
> >> caused not by a change in the submodule? Could you run `git diff-files`
> >> before the rebase?
> >
> > It's the same before and during the rebase:
> > $ git diff-files
> > :160000 160000 c840225a7cf6bb2ec64da9d35d2c29210bc5e5e8
> > 0000000000000000000000000000000000000000 M      sub
> >
> >
> >>
> >> This does *not* refresh the index, but maybe that is what is going wrong;
> >> you could call `git update-index --refresh` before the rebase and see
> >> whether that works around the issue?
> >
> > Nope.
> >
> > If I run git submodule update, then rebase --continue works fine, so
> > it's definitely somehow caused by the submodule.
> 
> I just checked out v2.15.0.windows.1 and reverted ff6f1f564c - it
> solves the problem. I still have no idea how to minimally reproduce
> (in my project it's easily reproducible) :)
> 

After reading your bug report and the fact that you weren't able to
reproduce it outside of your project I think i figured out what is
happening.  Before ff6f1f564c the gitmodules file wasn't being loaded
unless a codepath explicitly wanted to work with submodules.  Now they
are being lazy-loaded so if you call into the submodule config subsystem
it'll work without having to have initialized it before.  I suspect
that the submodule which is causing the failure has a
"submodule.<name>.ignore" entry in the .gitmodules file or somewhere in
your repositories config (I actually suspect the latter based on the
code path).

When rebase calls into the diff machinery to see if there are unstaged
changes it explicitly requests that submodule's be ignored, but this
desired gets overridden by your repository's config, clearing the
ignored flag and making rebase actually pay attention to the fact that
the submodule has changes in it.

I don't have a patch available to for you to test just yet (but I'll
have some time later today to write one up) but could you verify that
(1) you have an ignore entry for the submodule in question in your
config and (2) removing it from your config avoids the failure?  If
that's the case then we would be able to put together a reproducible
recipe for this failure.

-- 
Brandon Williams
