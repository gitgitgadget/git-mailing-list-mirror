Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20661C47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 22:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0E65206B8
	for <git@archiver.kernel.org>; Tue,  5 May 2020 22:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApBaMpO7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbgEEWVc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 18:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbgEEWVb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 18:21:31 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C351C061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 15:21:31 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id f13so4555301wrm.13
        for <git@vger.kernel.org>; Tue, 05 May 2020 15:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=q7v9sdNlsFf2ubilkV6ygCEFR42THcx2NQ9IXx6QIXQ=;
        b=ApBaMpO7HsRBmgdSRugrEplZt7Xx+RzrJcS4FCdTaVzE0Z6b3Ld1JwNIwH5y4JkDNg
         Q+2VUFbT9lr24ceRmCa+Mt8efZCxmooeTdJ8lHPPdaCLbuQim+tjXWCMHLfbY2Hmy1QK
         rtw6ZCPGAueB+nARMak+FMsnbEN7A2BMM0c3L/9q06N53z3btqGgyifthiwTps71O4Ce
         ok2uY6KTSfqF1J25LxqhSADzI2F96fkAi9VTIOnk8/nwex1Xz5S84Au7kCq/6sD11a6e
         gGIS4Y64dkw7Dod1F0Zvj2Ikz6DXDa50jKzM2DJ3/NZ15XzcPYQvTJ5wa5g1m6KYdqZ9
         WUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=q7v9sdNlsFf2ubilkV6ygCEFR42THcx2NQ9IXx6QIXQ=;
        b=AcEBIG7wHpJC2mEH0Hetq9+b2Gg595W1w2MHO4KAatzm4QN6tzU47VYFlwbXCdpEQC
         bxBZ/zBNgLRRJlGMMvktS3TsH2uH8v8kB1LW4mj7LxtVeLfK3F1udOfYqjwrvGCtJ3Yt
         B+wEPsnjWENxyV4Kuhzlb3afH5jZ2Mv6IBR/ADWIjR/w339tJe1agBjgyo9+uy797X8K
         vG636E9VoqXvBLcQ+VTLJ6xllH65aRYreI8AIMv+NL7MrH2LMrJK7sVTJSQpbfhgiRv/
         JkfAnb4e+v0WHGmoLgZc77IiIEwdofxAz/1bCGOPrckQAOBiPrBxpscowYbAaeLMzBu6
         D/mg==
X-Gm-Message-State: AGi0PuYqoY0CzW8CkqDWQwLY0Q+/Asn3i5K/h84Njwd/snzdWRYmTim2
        aOYhPY7zQxwoNRvAXvrq3gJDSDFmmWNqtmc8oBG31A0Zxio=
X-Google-Smtp-Source: APiQypLKZU+Qv39Wt5ka37u3j6UyJSB4X+BglrPpGJWoOoHaRP0pgPhLA24eE0KIaTl4/3iakAf4ODRqnEFZGPQ7z1Q=
X-Received: by 2002:a5d:4a0b:: with SMTP id m11mr5900945wrq.211.1588717289039;
 Tue, 05 May 2020 15:21:29 -0700 (PDT)
MIME-Version: 1.0
From:   Roman Gelfand <rgelfand2@gmail.com>
Date:   Tue, 5 May 2020 18:21:17 -0400
Message-ID: <CAJbW+rmN=QPDm0myka1=iOpvzqe2kN-yk8GisdH2VDLRc1ReHw@mail.gmail.com>
Subject: GIT Branch Maintenance
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I am in a process of designing a git strategy for our vs solution.
The vs solution is a legacy asp .net webforms app which is enormous.
CI is out of the question because of cumbersome db source  setup.  So,
we are pretty much relying on integration testing.  We have roughly 6
people on development team.  Each of developers are assigned separate
feature.  Sometimes, a feature spans several releases.

Here are the branches:
Master - source that made it to prod
Feature - checked out from master Head.  The Head represents previous release.
QA - synchronized with master at the beginning of release development.
Upon completion, each active Feature branch is merged into QA.
Bugfix - in case of bug in current development, QA branch is checked
out to bugfix branch.  Upon completion, it is merged back into QA
branch.

Over time these master and qa branches will be enormous.  How do I
keep it concise preserving detailed history in case I need to hunt
down a specific commit?

Any help is appreciated.

Thanks in advance.
