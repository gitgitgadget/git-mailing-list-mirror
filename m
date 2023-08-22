Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF06EE49AA
	for <git@archiver.kernel.org>; Tue, 22 Aug 2023 04:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbjHVEFz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Aug 2023 00:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjHVEFy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2023 00:05:54 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5478187
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 21:05:52 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bdbbede5d4so31530535ad.2
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 21:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trimble.com; s=google; t=1692677152; x=1693281952;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/c7p4wsXYvHbfTLiIp1hb+p/dVB6GEAS59Tz7v07TA4=;
        b=WB/8dZGK7fdTitX49ecIl5myq2mD0dfFB/mnKcc7IWIKRdP+PXhIDE0OnVB1J9sEwU
         8mLt29l8FklWsPSjvW79FMtM1FmGAcUkDzUesBUtspZ5t38GIBb9pJS5yRsbQXpfcNtY
         lenVVkBPEmXsNjLh7ydHbZ4kecNZ3bSaZsrts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692677152; x=1693281952;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/c7p4wsXYvHbfTLiIp1hb+p/dVB6GEAS59Tz7v07TA4=;
        b=VngAr/nzH0Kxg9PkfEAU38JhqRft2NZgoJsChZ6joIXaQwKY44F0qkj7vi1XAU5k35
         lOsc9FlU8wqGNSAAWQ3ZlpwSNGEx2T82aVY9UL88EXQIT1mjy8KyeXyhJtltTgyIutz1
         lkxbMFKy7n+bBYyTzIzZ4mEe3lh0m4FB1/S5VsFDXerIm7bbUQRsFXPrsM8WkDRLvyIi
         N2tE+lQsp4pXNVHlDXixrsA+t1nGCG/z0dtdFx3/DxlrotHzO9i2u9lL9QOM9/aHN6JK
         gBVBuF2RIblU+SHCb3gCEQv+EGMsHRvQ4I+KmclYmkCHxj5ZURjj/0xPHbYuRjtwnRCL
         MEMg==
X-Gm-Message-State: AOJu0YyIYa9JUSF5mdyTxCYl1kYJPBxr+WMD/Wk79INlpCN7tnKnrBw/
        ZfPClgD8Lewi5NuMppUmMdtNkr72Gs3dHwIoKJmK3A==
X-Google-Smtp-Source: AGHT+IHEyC+9Z/VPlRDz+dE3xDjhycKK778pVxmfldSCEI18OtXchE+oyNBr7iFYP7Kv7rQv3q0tyQ==
X-Received: by 2002:a17:902:d342:b0:1bf:6ad7:228b with SMTP id l2-20020a170902d34200b001bf6ad7228bmr7420127plk.8.1692677152073;
        Mon, 21 Aug 2023 21:05:52 -0700 (PDT)
Received: from GSINGLE-NZ-DE.ap.trimblecorp.net ([155.63.200.2])
        by smtp.gmail.com with ESMTPSA id f5-20020a170902684500b001bf6ea340b3sm4221423pln.116.2023.08.21.21.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 21:05:51 -0700 (PDT)
From:   "U-AP\\GSingleton" <grant_singleton@trimble.com>
X-Google-Original-From: "U-AP\\GSingleton" <GSingleton@GSINGLE-NZ-DE.ap.trimblecorp.net>
Date:   Tue, 22 Aug 2023 16:05:47 +1200
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: Corrupt repo with force push when using a reference repo
Message-ID: <ZOQ0GxPn-anJlLxQ@GSINGLE-NZ-DE.ap.trimblecorp.net>
References: <MN2PR03MB5072F08C68E7F32C9F5AC866A614A@MN2PR03MB5072.namprd03.prod.outlook.com>
 <ZNwkh47mBJxcSYkm@tapette.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZNwkh47mBJxcSYkm@tapette.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 16, 2023 at 01:21:11AM +0000, brian m. carlson wrote:
> On 2023-08-15 at 04:05:34, Grant Singleton wrote:
> > Thank you for filling out a Git bug report!
> > Please answer the following questions to help us understand your issue.
> > 
> > What did you do before the bug happened? (Steps to reproduce your issue)
> > 
> > With 3 clones of a repo, one on branch-a one a mirror,  another using the mirror as a reference repo on branch-b, do the following
> > 
> > # in the repo on branch-a, make a change, commit and push
> > cd bad-object-test
> > echo $(( RANDOM % 1000 + 1 )) > file.txt
> > git ci -am "change a file"
> > git push
> > 
> > # do a git fetch in the reference repo
> > cd ../bad-object-test.git/
> > git fetch
> > 
> > # do a git pull in the repo on branch-b
> > cd ../bad-object-test-with-reference-repo/
> > git pull
> > 
> > # All good so far
> > 
> > # in the repo on branch-a, discard HEAD and force push
> > cd ../bad-object-test
> > git reset --hard HEAD~1
> > git push --force
> > 
> > # do a git fetch in the reference repo and then prune loose objects
> > cd ../bad-object-test.git/
> > git fetch
> > git prune -v --expire=now
> 
> When you clone using --shared or --reference, you implicitly depend on
> the objects in the referenced repository existing without being pruned
> for the integrity of the repository.
> 
> The manual page for git clone says this:
> 
>   NOTE: this is a possibly dangerous operation; do not use it unless you
>   understand what it does. If you clone your repository using this
>   option and then delete branches (or use any other Git command that
>   makes any existing commit unreferenced) in the source repository, some
>   objects may become unreferenced (or dangling). These objects may be
>   removed by normal Git operations (such as git commit) which
>   automatically call git maintenance run --auto. (See
>   git‐maintenance(1).) If these objects are removed and were referenced
>   by the cloned repository, then the cloned repository will become
>   corrupt.
> 
> If you want to change the references in any non-fast-forward way or do
> any sort of GC or pruning in the reference repository, you need to run
> `git repack -a` in the non-reference repository to repack all of the
> objects in that repository and dissociate it from the reference
> repository.
> 
> In general, unless you are _very_ sure you know what you're doing, you
> usually want to use `--dissociate` with `--reference` such that you
> detach immediately.
> -- 
> brian m. carlson (he/him or they/them)
> Toronto, Ontario, CA

Ok, sorry and thanks, I should have read more of the documentation.

For some context, we're doing this on a bunch of Jenkins agents for our
CI/CD pipeline on a somewhat bloating monolithic repo. We have 30-40
clones on each machine, so the reference repos save us a lot of network
traffic, time to fetch and disk space.

So IIUC I can do a `git repack -kad` in the reference repo to pack loose
objects and keep unreachable commits that may be referenced by other
repos using the reference repo.

Grant Singleton
Christchurch, New Zealand

