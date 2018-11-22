Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF2811F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 01:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388776AbeKVLrx (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 06:47:53 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:34135 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbeKVLrw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 06:47:52 -0500
Received: by mail-it1-f195.google.com with SMTP id x124so14153722itd.1
        for <git@vger.kernel.org>; Wed, 21 Nov 2018 17:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0xP2DG8s+GsRPs+DvHZD4+FY4CjWiOXD0qrzIhN5WfQ=;
        b=AoiLJ6oxSJgXKNnp1VGNkS9H2kQeImJLmZFhkgLMlQVVYpVbfSvaQ+TCWmZXmIzdn4
         xKbRvT9m0UQBlfQDahFG9Modi0ZJKGDmWNEPy26MzEeyZSsja/JHX6zZL7sF1kVUlQvP
         RXKJa4ZVDcrQ3cVbBvFkDPG72S17xZPGeQUIvkITPGFaS4tZWFD//NkN2K72rxQrR2T3
         72+jM5Cn0eCXP6QsSml/QpNKIww0Bd9UHtkUWzgZYF65Y7ncBNF0r3cN5WsS6vl4o6CX
         5EaV1ZCgr2BU2CUtxH80baTIp4TAroUS/ekfEbSzh+kZD8iJEVnMlECXE+h7AhZ0xv4X
         u0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0xP2DG8s+GsRPs+DvHZD4+FY4CjWiOXD0qrzIhN5WfQ=;
        b=hupA0/DDQpFxcHMViART/DrtcmV6gS1f1wGA8tTuU0uoNB+xcmb1JlT/uT9Q33li1u
         TsrUHHKfine726nRtPTtmz+NiAN2vIUzT5Ej1/dXSG8/xBZAx/Q4X7jJ9+V9E4q4pybz
         ivxDhotrgqmraof8dOTWSYzH+koMQrNVLN5MxrkM/ohGjqUEAVgZJ9SzjANyJcslADg7
         2xY1e5iB9c8jGMOrIFO/Vl453qXBBSEHi14RjrdZitTKr0AeXWc1YpY2z3ZFIyKYkO0C
         C/J7rVJFwi43AKc+A0kSeB1kikSPDSd6WUWZUkzqyWsAx4EwIVRDgAwqiqVRZebNhbWG
         Hsjw==
X-Gm-Message-State: AA+aEWag9Fchm0Bg4LX4x/tu7E0hfg2x5/4SmLto+nT8m8nmLp4E0QkS
        V6S3Y7iL5mdrAYFhvlUD06Q=
X-Google-Smtp-Source: AJdET5eCUvOR+jsvJeUbvnPjdGSOrZ1LIqk2Lu+jbZSB/4uj7Zrx62VNlawZ39s4YwoWcqlwjyfh9A==
X-Received: by 2002:a24:6f4a:: with SMTP id x71-v6mr7772163itb.60.1542849058255;
        Wed, 21 Nov 2018 17:10:58 -0800 (PST)
Received: from archbookpro.localdomain (ktnron0919w-lp140-01-76-68-143-166.dsl.bell.ca. [76.68.143.166])
        by smtp.gmail.com with ESMTPSA id u5-v6sm14489398iob.83.2018.11.21.17.10.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 17:10:57 -0800 (PST)
Date:   Wed, 21 Nov 2018 20:10:55 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com
Subject: Re: [PATCH v4 0/2] Fix scissors bug during merge conflict
Message-ID: <20181122011055.GA1584@archbookpro.localdomain>
References: <cover.1542496915.git.liu.denton@gmail.com>
 <cover.1542768902.git.liu.denton@gmail.com>
 <xmqqefbe7otv.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqefbe7otv.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 21, 2018 at 06:38:20PM +0900, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > Changes since V3:
> > 	* Add patch to cleanup 'merge --squash c3 with c7' test in t7600
> > 	* Use test_i18ncmp instead of test_cmp to pass GETTEXT_POISON tests
> 
> Queued. Thanks, both.

I just realised that there is a slight problem with the proposed change.
When we do a merge and there are no merge conflicts, at the end of the
merge, we get dropped into an editor with this text:

	Merge branch 'master' into new

	# Please enter a commit message to explain why this merge is necessary,
	# especially if it merges an updated upstream into a topic branch.
	#
	# Lines starting with '#' will be ignored, and an empty message aborts
	# the commit.

Note that in git-merge, the cleanup only removes commented lines and
this cannot be configured to be scissors or whatever else. I think that
the fact that it's not configurable isn't a problem; most hardcore
commit message editing happens in git-commit anyway.

However, since we taught git-merge the --cleanup option, this might be
misleading for the end-user since they would expect the MERGE_MSG to be
cleaned up as specified.

I see two resolutions for this. We can either rename --cleanup more
precisely so users won't be confused (perhaps something like
--merge-conflict-scissors but a lot more snappy) or we can actually make
git-merge respect the cleanup option and post-process the message
according to the specified cleanup rule.

I would personally think the first option is better than the second but
I'd like to hear your thoughts.

Thanks!
