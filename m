Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7C721F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 08:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbeKNSMN (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 13:12:13 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:36726 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728391AbeKNSMN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 13:12:13 -0500
Received: by mail-it1-f194.google.com with SMTP id w7-v6so22616763itd.1
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 00:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yEn+xUAaTiVdTFlwjwKMX7ZMxffRUZecOInY2MbyhBw=;
        b=bnOT9xc/Ux5XGDJbnmxUEY+KY1h4qa6LVBQbXyr785vKKTmzEZg3axkFZA/t3m7s7g
         Cxx0bWVkclsc64xnar757iBpzm10SOpl8EWtK4wmLQzfARaz9VtjiQo1Irup2L8Cd4CX
         vc6pKvowc8ZXiUTh/9y9lNO3tKbuNIXyu0d0ewoa+1CbtUUm/83F7f+dt602ypxy2gMS
         vdAb9BdZUCqseCXXbFEY3palDwJSB1IUsjVuO9ALVq/BoJrHtJEw/xI8YdrvOsCtKy1l
         1x4Z48Jw+vkzTBbFQs+zLZK4UUD89BlTLKNA0OLloa8DvZIebY2oPv73RhdWenHDnkR4
         nBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yEn+xUAaTiVdTFlwjwKMX7ZMxffRUZecOInY2MbyhBw=;
        b=FA5BAajttYGIetrwcp/qU8bqV0ntNoaCvzxphwSRCw2Dy6kTahoV8K/Jm+hTrW63WL
         uuHSBrHAuw9LwjrZkNMTiFVuW9rCq95aMVlBoQIPN7W3I9cBlWcVig76fvngLOcQV0ST
         A7oA5ncvkpnTuSBCiJOtZynPeAe3ogqaVaOK2IQwF61Mwzy+jm1ZZsSyZXqK1crAvcM1
         lKh7FzQDX2iihLnr62V5b2F35uDjf927OWUIiGufo89FOadlQVa50ZA9S89r5zdwyTxy
         FFl2jAT2krVPXktzuWmRuZ/d7gt9GQQH7gzJJoeagLYaGlYEv69vyXUW+nMI56kq9nVY
         Qs6A==
X-Gm-Message-State: AGRZ1gLBEfQa21sc0lb069JSsMDbr8zYwXkgpmk1w9/w7K8hIGsXUFPy
        aZeZqr1I7fXE/pjLfvnUcFM=
X-Google-Smtp-Source: AJdET5cE9lKlHVIsHld/v1MyKdQc/vMucSKrYKF8m3UQbFsGAfDn0QslttvVXmCIUSsf6zY/q2Nhig==
X-Received: by 2002:a24:1706:: with SMTP id 6-v6mr1210726ith.16.1542183004095;
        Wed, 14 Nov 2018 00:10:04 -0800 (PST)
Received: from archbookpro.localdomain (ktnron0919w-lp140-01-76-68-143-166.dsl.bell.ca. [76.68.143.166])
        by smtp.gmail.com with ESMTPSA id q9sm609217ioh.32.2018.11.14.00.10.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 00:10:03 -0800 (PST)
Date:   Wed, 14 Nov 2018 03:10:01 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Fix scissors bug during merge conflict
Message-ID: <20181114081001.GA1348@archbookpro.localdomain>
References: <cover.1542172724.git.liu.denton@gmail.com>
 <xmqq1s7onlic.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1s7onlic.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 14, 2018 at 04:52:59PM +0900, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > With this fix, the message becomes the following:
> >
> > 	Merge branch 'master' into new
> >
> > 	# ------------------------ >8 ------------------------
> > 	# Do not modify or remove the line above.
> > 	# Everything below it will be ignored.
> > 	#
> > 	# Conflicts:
> > 	#	a
> 
> I have a mixed feeling about this change and I certainly would not
> call it a "fix".
> 
> The reason why we give the list of conflicted paths that is
> commented out is to remind the user of them in order to help them
> describe what area of the codebase had overlapping changes, why, and
> how the overlap was resolved, which is relevant information when
> somebody else later needs to dig into the history to understand how
> the code came into today's shape and why.  For that reason, if a
> careless user left conflicts list behind without describing these
> details about the merge, it might be better to have the unexplained
> list in the merge than nothing.
> 

The reason why I implemented it this way is because the default
cleanup setting (strip) produces this message:

	Merge branch 'master' into new

	# Conflicts:
	#	a
	#
	# It looks like you may be committing a merge.
	# If this is not correct, please remove the file
	#	.git/MERGE_HEAD
	# and try again.


	# Please enter the commit message for your changes. Lines starting
	# with '#' will be ignored, and an empty message aborts the commit.
	#
	# On branch new
	# All conflicts fixed but you are still merging.
	#
	# Changes to be committed:
	#	modified:   a
	#

Which makes it seem like the `Conflicts:` section should be removed by
default.

> In theory, the above argument applies the same way for the paths to
> be committed, but the list is fairly trivial to recreate with "git
> diff $it^!", unlike "which paths had conflict", which can only be
> found out by recreating the auto-merge.  So in practice, the paths
> that had conflicts is more worth showing than the paths that were
> modified.
> 
> So, I dunno.  If we value the "more expensive list to reproduce",
> the fix might be not to place it (and possibly the comments and
> everything under the scissors line) behind a "# " comment char on
> the line, without moving its position.

If I understood correctly, then I have no strong opinions between
uncommenting the Conflicts section by default and this change; I just
think it'd be nice to have behaviour that's consistent.

> 
> .
> 
> 
