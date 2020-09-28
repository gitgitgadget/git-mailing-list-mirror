Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB6DC2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 19:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E952D2074A
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 19:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ugq9GLuG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgI1TeK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 15:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgI1TeH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 15:34:07 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730E7C061755
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 12:34:06 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t14so1742359pgl.10
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 12:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Ob8MCVFItLBYoZQW4NLrYPTraB3/A83Gt62FeTg9nBQ=;
        b=ugq9GLuGzrJyr8aKSXB6QWFNPDH+BwWVA9yW1pova7nx8kmzKhl5tM1OmnajujhX+f
         BVeTZNnfOW+u0yGTaIeM2et2EyTSkX0kSb1jLSjjykfa99TH8EsajqIDfJF8/Ek18pbp
         3tGjIRAZdDmTwMMio0UtOwp398a6DDXT5Ow0Jw4qb7HAZoqq5XMR17jBn7N35LHYATYQ
         fO4fBPneUU0al2FTwK+Bj44tVCf27hXx5pS+FvpOgw0hHaKiy9dlkf0PeSvnJGNJgt1t
         hWqIyK/0bwI6qD9I6jSxE2wJZvUHLib1nBVtRv2sZmt+SM7uaqRC3DPiC/8BXnDoCQg3
         CnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Ob8MCVFItLBYoZQW4NLrYPTraB3/A83Gt62FeTg9nBQ=;
        b=OxLftVVz1XdulzUAcdP9FYTt0PMvX8H4BUmqX7w5F8f2kbgVqsM5tI5g/ejONdy3LN
         jygqNCA+ZDQ8N+CAj9Xf3ptVyLaQ9+ogvHDrEquITW1SjpoeOdtvzgTYE2K/emfTf1xn
         004V0uwVXOiQcoq8iS9n/zHzk7cno4H9evWeCJjirEaRKaiAGx1SK7EYuyF9a1jsjl+W
         NPDb5AKpsx8Pnx+txwliymNwRKUq+jv34/iPdokdhVORdj3lsrRz2VHZ+dRtXCNq0sip
         MfAA//Rbvd+VmPg4vumeY7+XQUXOX9Rj0E/hmouGhBZtHBsfKqkJCo4erdwIUzongbne
         n6fA==
X-Gm-Message-State: AOAM532utZbPv24PnzeP1eGLd5RsUHV9cze1eNRFHvTVXv8e98PnJT7r
        SyVGByYjS04aSI8OPxB1QKw=
X-Google-Smtp-Source: ABdhPJxlXB9L8SVMdU7i3I8A18sNGdzVmx53J8BcuvRB8UbZ9wzhRxoPmgE4jleq5A4sRKIwHacVaQ==
X-Received: by 2002:a63:165c:: with SMTP id 28mr442981pgw.302.1601321645852;
        Mon, 28 Sep 2020 12:34:05 -0700 (PDT)
Received: from mail.clickyotomy.dev ([124.123.106.216])
        by smtp.gmail.com with ESMTPSA id j25sm371175pfn.212.2020.09.28.12.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 12:34:05 -0700 (PDT)
Date:   Tue, 29 Sep 2020 01:04:00 +0530
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v8 0/3] push: add "--[no-]force-if-includes"
Message-ID: <20200928193400.GA88208@mail.clickyotomy.dev>
References: <20200926114626.28823-1-shrinidhi.kaushik@gmail.com>
 <20200927141747.78047-1-shrinidhi.kaushik@gmail.com>
 <xmqqtuvhn6yx.fsf@gitster.c.googlers.com>
 <20200928174619.GB24813@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200928174619.GB24813@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On 09/28/2020 19:46, SZEDER Gábor wrote:
> On Mon, Sep 28, 2020 at 10:31:34AM -0700, Junio C Hamano wrote:
> > Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:
> > 
> > > Add a new option: "--force-if-includes" to "git-push" where forced
> > > updates are allowed only if the tip of the remote-tracking ref has
> > > been integrated locally, by verifying if the tip of the remote-tracking
> > > ref -- on which a local branch has based on -- is reachable from at
> > > least one of the "reflog" entries of the branch about to be updated
> > > by force on the remote.
> > 
> > https://travis-ci.org/github/git/git/jobs/730962458 is a build of
> > 'seen' with this topic, and the same 'seen' without this topic is
> > https://travis-ci.org/github/git/git/builds/730857608 that passes
> > all the jobs.  It is curious why one particular job fails while
> > others in the same build is OK.
> 
> That build runs the test suite with a bunch of GIT_TEST_* knobs
> enabled, and the last two tests added in this series fail when run as:
> 
>   GIT_TEST_COMMIT_GRAPH=1 ./t5533-push-cas.sh
 
Thanks for the heads-up. It turns out that "in_merge_bases_many()"
returns different results depending on "GIT_TEST_COMMIT_GRAPH".
Initially I thought that it might be related to batching the entries,
but that is not the case.

One of the tests that is failing is:
  cd src &&
  git switch branch &&
  test_commit I &&
  git switch master &&
  test_commit J &&
  git pull --rebase origin master &&
  git push --force-if-includes --force-with-lease="master"

Here, we are testing to check if forced updates are allowed after
the remote changes have been incorporated locally, which is true
in this case and should pass.

"in_merge_bases_many()" used in the check as follows:

  for (chunk = list.items; chunk < list.items + list.nr; chunk += size) {
	  size = list.items + list.nr - chunk;
	  if (MERGE_BASES_BATCH_SIZE < size)
	        size = MERGE_BASES_BATCH_SIZE;

	  if ((ret = in_merge_bases_many(commit, size, chunk)))
	        break;
  }

In "repo_in_merge_bases_many()" [1], the following condition evaluates
to true when "GIT_TEST_COMMIT_GRAPH" is 1.

	generation = commit_graph_generation(commit);
	if (generation > min_generation)
		return ret;

Unfortunately, I am unfamiliar with the code, and not sure why this
happens; I remember Junio mention [2] something about generation
numbers could it be related to that?

A possible "workaround" is to use "in_merge_bases()" for each of the
commits we collect in the list, and the tests seem to pass with
"GIT_TEST_COMMIT_GRAPH" being set; but I wonder if that's the right
way to fix this.

[1] https://git.kernel.org/pub/scm/git/git.git/tree/commit-reach.c#n319
[2] https://public-inbox.org/git/xmqqft7djzz0.fsf@gitster.c.googlers.com/

Thanks.
-- 
Srinidhi Kaushik
