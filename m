Return-Path: <SRS0=BQqG=A5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94AAC433E1
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 19:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A215020724
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 19:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian-com.20150623.gappssmtp.com header.i=@atlassian-com.20150623.gappssmtp.com header.b="AxqKr/yQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgGRTZE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jul 2020 15:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbgGRTZE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jul 2020 15:25:04 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FB7C0619D2
        for <git@vger.kernel.org>; Sat, 18 Jul 2020 12:25:03 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id y2so13758203ioy.3
        for <git@vger.kernel.org>; Sat, 18 Jul 2020 12:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QHAZr88rP4KNqfm0CD5UjWr+6ZVn4Sy4x5TaBE64WTU=;
        b=AxqKr/yQUJwhy5rwpd41sLUlkn1h0pS8WIw7yWgVDILjuZOmMVI8kyEjmPb5+Y/cWw
         12fZ0ScTTcgHi0zoXiRaPvwUTmS3Q3+EIotaDFdW9DqGTDt6TGyOEpRXNjWxpw8AZIYk
         2vUCB0rP0rBMEbGnCSym1irHmc43MmtlMeKXl9a0jH5jYY0v3D+havE3Y9dvs+qMOcf5
         MFHCJbdRoMp71m+5h2eTW/ydBYEf/rv1WRhrj5/moGoWBBzPifrHhvdRBGg+8j7TDNdK
         DhZHC9kdK4wXlxp4AUUx5dLSwq2I+r1/6qKY5P5mP23yiexuqXfSDmfdNMPFUNCxmxNq
         19rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QHAZr88rP4KNqfm0CD5UjWr+6ZVn4Sy4x5TaBE64WTU=;
        b=FRSmbv0u1IxPv4MJK/Gcv7CQzXuJ49d5UGoleGULjCiFR7WPziEC7gURtLwOHFHoR6
         z4iGaRHqNKhRfznm2mDK66ctyBZsBdtxgKvswOv+OlGtKBmh1vBDNxqx/lDEHZNO4Zvr
         2A7KyqCXEF5W5h28yFc0fBBp2ZNSiPgqcXnTWX89TE2PIEMlEGT1SEvBdO+JQfjYo8Jz
         4wHmW4X8DBDTOuSsh6dOz7GsjIHIOKZ+Mt9aR2g23QFq/Dh6JEoouvzXR/BYm2tB10gb
         VbolRa8Hjg3g69JPH8wWkcceC6wA/o82+sGzQ0XnQ4Fgr3ZE3Hg5BNzkQv40YxV2kLWW
         UFTQ==
X-Gm-Message-State: AOAM533QTRLg4HDpfRBYCrX9n/lnphJcQZMGw7yUOJcPEaGMqWTgFfSM
        5YdGkPuz+r7UF1xzg++topLjy25Dng8KFBzgrTs4sk8sHyQ=
X-Google-Smtp-Source: ABdhPJwIstzWNzzuXAtemsDiGIOVtJ7hXnYffQM9n1QCK9cT5FbHYJR96hOBms28DMFjLBcRqCi+lELneWF3oM78i4g=
X-Received: by 2002:a6b:5b0e:: with SMTP id v14mr15576931ioh.145.1595100302590;
 Sat, 18 Jul 2020 12:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <015101d65d27$dee4e9a0$9caebce0$@pdinc.us> <edc9f4ca70bfcb7a94f4c9d44f03e71efbab12ee.camel@mad-scientist.net>
In-Reply-To: <edc9f4ca70bfcb7a94f4c9d44f03e71efbab12ee.camel@mad-scientist.net>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Sat, 18 Jul 2020 12:24:57 -0700
Message-ID: <CAGyf7-ERkSG-SbOMf4tUa+A7-cURUY2aLGxPXAfqst06si__+Q@mail.gmail.com>
Subject: Re: [off topic] Git hook and integration for JIRA
To:     paul@mad-scientist.net
Cc:     Jason Pyeron <jpyeron@pdinc.us>, Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 18, 2020 at 10:30 AM Paul Smith <paul@mad-scientist.net> wrote:
>
> On Sat, 2020-07-18 at 13:21 -0400, Jason Pyeron wrote:
> > An non-ideal implementation [2] looks like a comment. While the
> > native implementation [4] shows up in a nicely organized section of
> > the issue page.
>
> Indeed this is off-topic but AIUI, there is no magic needed to get your
> commits to show up in the *Development* sidebar of a JIRA issue.  All
> you have to do is mention the JIRA in your commit message; if JIRA is
> configured to be able to scan your Git repository it will create those
> links on its own.  I'm not sure if it only hooks up commits which show
> the JIRA issue ID in the first line, or anywhere in the commit message.
>
> In any event at $DAYJOB this is how it works (we do have an on-prem
> install of JIRA though, we don't use the hosted version... maybe that
> has fewer features).

I work for Atlassian as the principal developer for Bitbucket Server
for my $DAYJOB, so I wanted to jump in and clarify that that's not
quite how it actually works. Jira, whether Cloud, Server or Data
Center, doesn't scan Git repositories; repository management software,
like Bitbucket Server or Github or Gitlab, integrate with Jira and,
when they create or receive new commits, they send information about
those commits to Jira. (This is how everything on the Development tab
in Jira works. Builds, branches, Bitbucket pull requests, Crucible
reviews, all of it based on summary information sent by the respective
source system for Jira to record and show.)

Perhaps something like the BigBrassBand app adds repository
scanning/indexing into Jira directly, but out of the box Jira doesn't
have any functionality along that line.

> All roads seem to lead to the non FOSS BigBrassBand [5] git integration plugin. I do not see a non-profit license and it will not fit the (lack of) budget.

I don't think the payload format for populating commit information on
Jira's Development panel is secret (clearly it's been shared with
other organizations to facilitate building and maintaining their
integrations), but I'm also not sure how well-documented it is. I'm
not sure whether you have any development capacity for a
build-your-own solution, but I could investigate what documentation
there is that can be shared if you'd like.

One other thing I'll note is that Bitbucket Cloud (bitbucket.org) also
has Jira integration support (for both Cloud and Server versions of
Jira) and, unlike Bitbucket Server or Data Center, does not require
you to maintain the server. I'd imagine github.com and gitlab.org also
have support, though I don't know whether it's a paid or free feature
for them. I'm not sure whether any of those hosting providers might be
a possible approach, but I thought I'd mention them.

Best regards,
Bryan Turner
