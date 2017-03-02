Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB0101F5FB
	for <e@80x24.org>; Thu,  2 Mar 2017 21:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751150AbdCBVSz (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 16:18:55 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:34905 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbdCBVSy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 16:18:54 -0500
Received: by mail-it0-f67.google.com with SMTP id 203so280283ith.2
        for <git@vger.kernel.org>; Thu, 02 Mar 2017 13:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=HuG5ysYsqLFjfem2AMNhV7M8RqAMVZvu2w155viqLgo=;
        b=hciiJOlvo9a5fq3T3a6dqBNFnHym2f19w186o6v78jnvRcKom9uVscK0VsZmVzAOiE
         cz5uyduMALu22LIwI+V9RW8LKM4KOHK1fnggvmWqtxOfm+aScSav+2E3TNdLUXLUpYbx
         0k0G3JjrLVPb6EMLnkayDondhqER66eKlK+RTmyu+JIRX95maLKy2w455eiKia9LMuOM
         0lj1REicx8NDuWe9cUscy0sMtmJskNAofE5fM0w20VJWugS8f09j83ghJNR35QanLWKe
         yNlqI/ASias/OxjwEP3UPdeArSu3Q+48onn82jDeMjjcs/A5jmuly0F0BIXwoa0WsU55
         o8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=HuG5ysYsqLFjfem2AMNhV7M8RqAMVZvu2w155viqLgo=;
        b=OVwsBR9J2CfyOMuWE5iaerKbwAU4ZfIQvHD85TGGSdtVAz03q2tXAzkh3Fo3ZKXjW/
         qYPfOKajPD3NVBEVZtZRM1gcRZNIuQBxHgvUg7XehygeO5YV2uD1TlBUkG/3m12xydXh
         E9zvp9IZPYas9n7vnkIUIbCiJAZJxedln2qnN5UCnhtlEQNLQgLU5Q7YNRSpFxgcfDbQ
         tfq3nJYUt41A9kEKuJrCgEHAslKZLfSgpunNKm5yxmCtRXA+OQi0n0QJm6+LeBR2CVth
         YqBNOy8ZBJwi274YZkMdBhXhR4XvY5laz5JZeZ55zoPQuoVwTdAgAO0uN3KRm3fns86F
         1Twg==
X-Gm-Message-State: AMke39mb3SUEU7iFAuflt2om4J2DlrDVxFA7vLAnEIgfi84BXirtBasy0MRItUOEQ45nXA==
X-Received: by 10.36.206.2 with SMTP id v2mr404468itg.74.1488489463894;
        Thu, 02 Mar 2017 13:17:43 -0800 (PST)
Received: from prospect.localdomain (wcnat-96-27.wheaton.edu. [209.147.96.27])
        by smtp.gmail.com with ESMTPSA id o191sm3858082iod.11.2017.03.02.13.17.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Mar 2017 13:17:43 -0800 (PST)
Date:   Thu, 2 Mar 2017 15:18:04 -0600
From:   "Devin J. Pohly" <djpohly@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 3/4] filter-branch: fix --prune-empty on parentless
 commits
Message-ID: <20170302211804.GB3490@prospect.localdomain>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Charles Bailey <cbailey32@bloomberg.net>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
References: <20170223082736.31283-1-djpohly@gmail.com>
 <20170223082736.31283-3-djpohly@gmail.com>
 <xmqqbmts7gjm.fsf@gitster.mtv.corp.google.com>
 <20170223213333.GA3490@prospect.localdomain>
 <xmqqshmvbhe5.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqshmvbhe5.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 02, 2017 at 11:36:18AM -0800, Junio C Hamano wrote:
> "Devin J. Pohly" <djpohly@gmail.com> writes:
> 
> > I think your point is interesting too, though.  If a commit is also
> > TREESAME to its parent(s?) in the _pre-filtered_ branch, it seems
> > reasonable that someone might want to leave it in the filtered branch as
> > an empty commit while pruning empt*ied* commits.  I would imagine that
> > as another option (--prune-newly-empty?).
> 
> I was hoping to hear from others who may care about filter-branch to
> comment on this topic to help me decide, but I haven't heard
> anything, so here is my tentative thinking.
> 
> I am leaning to:
> 
>  * Take your series as-is, which would mean --prune-empty will
>    change the behaviour to unconditionally lose the empty root.
> 
>  * Then, people who care deeply about it can add a new option that
>    prunes commits that become empty while keeping the originally
>    empty ones.
> 
> Thoughts?

Sounds good to me.  I would be willing to work on a new option if needed
(to "atone" for changing existing behavior), so you can loop me in if
there are any complaints.

-- 
<><
