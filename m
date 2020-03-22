Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4ADC4332B
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 16:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC1D20724
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 16:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Eoeqc9Au"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgCVQD2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 12:03:28 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:34241 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgCVQD2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 12:03:28 -0400
Received: by mail-pj1-f65.google.com with SMTP id q16so4904540pje.1
        for <git@vger.kernel.org>; Sun, 22 Mar 2020 09:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b0JZDBkrsZ/qGSrS/fRl1qQP+5APZ0pkOmpje94I9h8=;
        b=Eoeqc9AumRfY5kHxdWwc2ApAirqWKD54DGwB+wHXiyU9lLV/eIS9RdIWE+/iI7iHFE
         HSVc2hD0CmCa+bWMjkCsqd7dSYAAJFK2XCO9ZGwKGNBwloCcRN+sKz7TEbNFCiPw+T+K
         MWD9z/lDnlIOaA1X0j2F4v2QfSiYb7gKS9QwUMDrbX89IP53Ok3rhBVuatmUm1NMTmgG
         Q4keMy796hIcEhJxpsNIeufHqaa9L7eFg29Jx5sKsD6wkFk4c19MPk597N/rgJdu5QSP
         0BLpG3+V81ZkcbiKwxRFMAQgfv3jkkq/TgYsCbHDI4VjCt3cwX6emdzLY6aTMsesE4D7
         5U7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b0JZDBkrsZ/qGSrS/fRl1qQP+5APZ0pkOmpje94I9h8=;
        b=PfvdK6knMVIpNPY0ERqYqJ8Bx8Ka+AkE8MzbiGkyST+06n78EfAc3rXgIAFpl3eNZd
         ZAdWK0v05XVmJ5g9XyBgqWDhGwA++vExpkNgHmvBd+wLL4HatVP6IJgeXpitMdr2GaCX
         Wba4awy6xcF1WaAvvM0v5FEMnLZ9yOMGaRKIbwOTOYffP1WYs+0GR9cb1KT98qzA9XDz
         ldUr6jKzR6WGmquuDvNpa8xkJG+axAKtrLf2POtE1KadHeXZBhnCYDW9EOwcLsYASive
         CaoaWv78o5//cD1PBQCSmAnPIoJ/v/9H5sQPIuzRBteqGZGg8O1bOU0uLs96d9KclVwZ
         D/dg==
X-Gm-Message-State: ANhLgQ3j+f7B0EeHtazoVOG4VCerNmwOOtb+dRxIKwiSqVNW6PSBKpdn
        IXc6xAxQmqgFSbmu5shXrjiovZQfij4=
X-Google-Smtp-Source: ADFU+vt9jredoHKJGJWuEjvPOitoruoywqS3RwE6T1eEbs+h9bbm6U+JWCf6zbHhir/btB+Yei6tig==
X-Received: by 2002:a17:90a:9f44:: with SMTP id q4mr1905746pjv.41.1584893006386;
        Sun, 22 Mar 2020 09:03:26 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id i137sm1734776pfe.217.2020.03.22.09.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 09:03:25 -0700 (PDT)
Date:   Sun, 22 Mar 2020 10:03:24 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, jonathantanmy@google.com,
        christian.couder@gmail.com, git@jeffhostetler.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 0/2] Slightly simplify partial clone user experience
Message-ID: <20200322160324.GA53845@syl.local>
References: <pull.586.git.1584638887.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.586.git.1584638887.gitgitgadget@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 19, 2020 at 05:28:05PM +0000, Derrick Stolee via GitGitGadget wrote:
> This was something discussed briefly at the contributor summit: users will
> have a hard time remembering git clone --filter=blob:none <url>.

I think that this is probably my fault :).

I was saying at the contributor summit that I think I may have created
more confusion than clarity when I was describing how to use partial
clones in my last release blog post.

In that post, I introduced partial clones by asking and answering the
following series of four questions.

  1. What do you do when your repository is too large? Partial clones.
  2. How do you only fetch down some of the objects? Object filters.
  3. How do you restrict which parts of your working copy are populated?
     Write to '.git/info/sparse-checkout'.
  4. Simplify things even further by using 'git sparse-checkout' instead.

I think that some of the criticism was along the lines of "you said that
partial clones would be easy, but nothing in the steps 2-4 is
straightforward".

I think that things would have been much clearer if I said:

  If your repository is too large to clone all at once, or has a
  checkout footprint that is too big, you can issue a partial clone
  against it by writing the following:

    $ git clone --filter=blob:none --sparse /path/to/your/repo

> This series simply adds a --partial option that is equivalent to
> --filter=blob:none, with the ability to specify a size using
> --partial=<size> that is equivalent to --filter=blob:limit=<size>.

I think that I have mixed feelings about this, too. On the one hand, it
irrefutably makes the above incantation a lot easier to write out and
remember. On the other hand, I worry about it locking in options that we
don't want to keep around forever, like adding more filters, changing
some rules about sparse checkout and so on.

Maybe these concerns aren't well-founded, and that we're not likely to
change either of those anytime soon. But, I'd rather be wrong and not be
squatting '--partial[=<n>]' than not.

> While going to the git clone documentation to add this option, I noticed
> that there is no reference to the --filter option there, nor any discussion
> of partial clone. I resolved the former.
>
> REQUEST FOR HELP: If anyone out there is looking for an opportunity to
> contribute documentation, I feel there is a need to include a section in the
> git clone documentation devoted to partial clone. Hopefully such a section
> would include answers to these questions:
>
>  1. What is a partial clone?
>  2. Why would I want a partial clone?
>  3. How do I need to be careful when using a partial clone?
>
> I don't have time to write such a document right now, which is why I'm
> asking for help if anyone is looking for a non-code way to contribute to the
> project.

This seems like a worthy goal outside of this series, and I would
certainly love to have some more documentation in this area.

> Thanks, -Stolee
>
> Derrick Stolee (2):
>   partial-clone: set default filter with --partial
>   clone: document --partial and --filter options
>
>  Documentation/git-clone.txt   | 15 ++++++++++++-
>  list-objects-filter-options.c | 18 +++++++++++++++
>  list-objects-filter-options.h |  8 ++++++-
>  t/t5616-partial-clone.sh      | 42 ++++++++++++++++++++++++++---------
>  4 files changed, 71 insertions(+), 12 deletions(-)
>
>
> base-commit: 6c85aac65fb455af85745130ce35ddae4678db84
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-586%2Fderrickstolee%2Fpartial-clone-ux-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-586/derrickstolee/partial-clone-ux-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/586
> --
> gitgitgadget

Thanks,
Taylor
