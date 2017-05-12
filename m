Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E51EF1FF34
	for <e@80x24.org>; Fri, 12 May 2017 17:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758325AbdELR3Z (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 13:29:25 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:36770 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758078AbdELR3X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 13:29:23 -0400
Received: by mail-pg0-f52.google.com with SMTP id x64so13801527pgd.3
        for <git@vger.kernel.org>; Fri, 12 May 2017 10:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PKN6C4ahEjBBwwPjhYdgQOGNu/+75QYA8fBZ8OEy5Rs=;
        b=f9Xd8jKtg3q8kd7Kay+cGUndyJVHtCvvAWX53UBBGMFHQHr1pOC11xeGB9KTMDoOZm
         KnAmyGv1Whf7hHGlliMmA2b3dmv6FbjMyuzaa83EAe5aFDhwpuddGH1Kd7OUA2lG4a3e
         0Ecpn/8GBqr4lXD1f2q8TqjmuLc77LIkWC2IiuW7Chvgnm+Nq/pWvPuH3Og1pkIrXMkg
         CKnfh8xM9Bz9y0K1OgIiq9JUXvRADEtpon04zPtX21IVUnH7fKkLFjB/7EpHEau8+wJp
         H13+OabtBtlGYiezyl1I45m7S0yFIBwK5USBAoUimSxI4vnvy82dax8E2IxrcBK585l7
         u5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PKN6C4ahEjBBwwPjhYdgQOGNu/+75QYA8fBZ8OEy5Rs=;
        b=eCGWzgM5tfo77QeijWml0nQVczTxYfU4w9LrkChEbkQlt959kNeQ/DFwz2SZgjYE+6
         PsxDdVhLk7oi3XrJk0zmdnJJ5yEHA7fmTBnFw54uSvhKS202wDclD4oYj6reu37Sr0T6
         AZ4J+1GnjoUC1y2tO0t+1CXKZchV9I8mtbH8TG6nB1g+lF+3RuS5YQU+UgdsgLFj4h5s
         xYTdK7+/BO09+F6tJNkwjM2X3e16CcnugVeX3YlgUgONWcGFOVfwEuwQlwB+kbWMpNDX
         b71SEED1ocOB4Kf60h4wqPsu2fTR97IxZKIh5wrkBW3gOfPNnpCPXXwmQeXKgYzEprjw
         O34g==
X-Gm-Message-State: AODbwcCMRMdQ64+SJwZTEQuRNfXa1GV1Z2us8cKxr9WFO/dkC7QxbWBn
        +1TRh7TxcduRYnjo
X-Received: by 10.84.224.77 with SMTP id a13mr7394572plt.132.1494610162674;
        Fri, 12 May 2017 10:29:22 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:c4e0:75e9:f5fc:bc05])
        by smtp.gmail.com with ESMTPSA id p62sm5698749pfp.48.2017.05.12.10.29.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 12 May 2017 10:29:21 -0700 (PDT)
Date:   Fri, 12 May 2017 10:29:20 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, j6t@kdbg.org
Subject: Re: [PATCH v2 0/6] convert pathspec.c to take an index parameter
Message-ID: <20170512172920.GB98586@google.com>
References: <20170509191805.176266-1-bmwill@google.com>
 <20170511220427.192627-1-bmwill@google.com>
 <xmqqh90q7ige.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh90q7ige.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/12, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > The main difference in v2 is that instead of piping through an index_state
> > struct into parse_pathspec, I ripped out the logic that needed to access the
> > index and either removed it completely if it wasn't needed anymore (stripping
> > submodule slash) or factored it out into its own function which can be called
> > after initializing a pathspec object (dying if a path descends into a
> > submodule).
> >
> > Brandon Williams (6):
> >   pathspec: provide a more descriptive die message
> >   submodule: add die_in_unpopulated_submodule function
> >   pathspec: remove PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE flag
> >   ls-files: prevent prune_cache from overeagerly pruning submodules
> >   pathspec: remove PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP
> >   pathspec: convert find_pathspecs_matching_against_index to take an
> >     index
> 
> This was (perhaps surprisingly) quite a pleasant read, even compared
> to the other approach ;-).

Glad you think so! Thanks!

-- 
Brandon Williams
