Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C465CC433E7
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 11:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4A74206FA
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 11:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="phz8zva1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgIALl7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 07:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbgIALhm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 07:37:42 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F414C061245
        for <git@vger.kernel.org>; Tue,  1 Sep 2020 04:37:42 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m8so633428pfh.3
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 04:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=S3TBF1siDHqeOJ2bLpiFyaS3fCbK91HdCDP+gPuKiCg=;
        b=phz8zva1jhWzELEUBK+1flsY+QOaLRW7WqTzMC+zQOYonGiOJFntP/LRxJZBu7f9pB
         dBsnje7Q7bmdZKtZel7fZg1zFNirfgkt0V6F1j9raur5gOSSzPMg8W7pAPqNTJfFLRO/
         7NrQSkjNkObZRBU7Q9fTE1gREtdxqwJwyrFzyMxbii/J4dDIrgrPH5RvBl+Irkv7sHEr
         rnvxhyHC/d96hauKOgsJEbch6AXyMlkPzVDVwymjs4lQwTCN8wQsfFfAxbQqDizcBRgS
         SakTnqDXraxhALQW1G5ovzjNYUOJaKRNgVysvgWFOjYlhffuTpjBb0JBAdS1JSTRHFYa
         r99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=S3TBF1siDHqeOJ2bLpiFyaS3fCbK91HdCDP+gPuKiCg=;
        b=j8aAQ2LH/b/P8i1dQpFcuWXPRWXGO1xwQCGCi9snoFcHCqorKlpyw8bPmFaxTmIRe4
         bOmaLPnp1Mpj+FSM5AViZ/s3EidGw2CNtewwoDiQG6JFjBt7IejbguwLNCL/V8u3oaOU
         ZstsAW/4IGRAgEXvv+8Y0rbQb60E/o0svSJw/gAvanpZ4VAquw981jW63MgZ2EhO3iUA
         osOxAEru90FzFS9lLnqjvj2h/Ne2FEpgzqgXMuY1nQtfmM+3KnwZVST5F6+NcGbvhbZ7
         hST6WW6hTQoVONHRKeEhRGDHsKGDvl2l8ECPb/TOXwL0Wm6Ih0DnQZwIE4muY/IXQov6
         h4PQ==
X-Gm-Message-State: AOAM530vccXp7sbi+V9l7cfUzLpvvRuFdiTeU3Z0tTjAOXdL2HKEY6mr
        O24huEcc+EtVIZbblMrnh7I=
X-Google-Smtp-Source: ABdhPJyhbpO4XAohU1cfDHAxfn2ec2MVRQp6UYg14SdO+B2wT9lKRhTCoODVuWBsZA/8UGD8A+ItzQ==
X-Received: by 2002:a62:2cc2:: with SMTP id s185mr1487981pfs.10.1598960261686;
        Tue, 01 Sep 2020 04:37:41 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:79b:52ed:48f6:b1a4:ca3c:754b])
        by smtp.gmail.com with ESMTPSA id g9sm1669876pfr.172.2020.09.01.04.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 04:37:40 -0700 (PDT)
Date:   Tue, 1 Sep 2020 17:05:24 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     abhishekkumar8222@gmail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, stolee@gmail.com
Subject: Re: [PATCH v3 03/11] commit-graph: consolidate fill_commit_graph_info
Message-ID: <20200901113524.GD10388@Abhishek-Arch>
Reply-To: 85mu2jc75c.fsf@gmail.com
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
 <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
 <18d5864f81e89585cc94cd12eca166a9d8b929a5.1597509583.git.gitgitgadget@gmail.com>
 <857dtuo71v.fsf@gmail.com>
 <20200821041124.GA39355@Abhishek-Arch>
 <85mu2jc75c.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85mu2jc75c.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 25, 2020 at 01:11:11PM +0200, Jakub Narębski wrote:
> Hello,
> 
> ...
> 
> All right.
> 
> We might want to add here the information that we also move loading the
> commit date from the commit-graph file from fill_commit_in_graph() down
> the [new] call chain into fill_commit_graph_info().  The commit date
> would be needed in fill_commit_graph_info() in the next commit to
> compute corrected commit date out of corrected commit date offset, and
> store it as generation number.
> 
> 
> NOTE that this means that if we switch to storing 64-bit corrected
> commit date directly in the commit-graph file, instead of storing 32-bit
> offsets, neither this Move Statement Into Function Out of Caller
> refactoring nor change to the 'generate tar with future mtime' test
> would be necessary.
> 
> >
> > The test 'generate tar with future mtime' creates a commit with commit
> > time of (2 ^ 36 + 1) seconds since EPOCH. The CDAT chunk provides
> > 34-bits for storing commiter date, thus committer time overflows into
> > generation number (within CDAT chunk) and has undefined behavior.
> >
> > The test used to pass as fill_commit_graph_info() would not set struct
> > member `date` of struct commit and loads committer date from the object
> > database, generating a tar file with the expected mtime.
> 
> I guess that in the case of generating a tar file we would read the
> commit out of 'object database', and then only add commit-graph specific
> info with fill_commit_graph_info().  Possibly because we need more
> information that commit-graph provides for a commit.
> 
> >
> > However, with corrected commit date, we will load the committer date
> > from CDAT chunk (truncated to lower 34-bits) to populate the generation
> > number. Thus, fill_commit_graph_info() sets date and generates tar file
> > with the truncated mtime and the test fails.
> >
> > Let's fix the test by setting a timestamp of (2 ^ 34 - 1) seconds, which
> > will not be truncated.
> 
> Now I got interested why the value of (2 ^ 36 + 1) seconds since EPOCH
> was used.
> 
> The commit that introduced the 'generate tar with future mtime' test,
> namely e51217e15 (t5000: test tar files that overflow ustar headers,
> 30-06-2016), says:
> 
> 	The ustar format only has room for 11 (or 12, depending on
> 	some implementations) octal digits for the size and mtime of
> 	each file. For values larger than this, we have to add pax
> 	extended headers to specify the real data, and git does not
> 	yet know how to do so.
> 
> 	Before fixing that, let's start off with some test
> 	infrastructure [...]
> 
> The value of 2 ^ 36 equals 2 ^ 3*12 = (2 ^ 3) ^ 12 = 8 ^ 12.
> So we need the value of (2 ^ 36 + 1) for this test do do its job.
> Possibly the value of 8 ^ 11 + 1 = 2 ^ 33 + 1 would be enough
> (if we skip testing "some implementations").
> 
> So I think to make this test more clear (for inquisitive minds) we
> should set a timestamp of (2 ^ 33 + 1), not (2 ^ 34 - 1) seconds
> since EPOCH.  Maybe even add a variant of this test that uses the
> origial value of (2 ^ 36 + 1) seconds since EPOCH, but turns off
> use of serialized commit-graph.

That's pretty interesting! I didn't look into this either, will modify
the existing test and add a new test for it.

Thanks for investigating this further.

> 
> I'm sorry for not checking this earlier.
> 
> Best,
> -- 
> Jakub Narębski

Thanks
- Abhishek
