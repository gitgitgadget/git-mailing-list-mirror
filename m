Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 321701FF6D
	for <e@80x24.org>; Thu,  1 Dec 2016 19:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757688AbcLATQH (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 14:16:07 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36094 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbcLATQG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 14:16:06 -0500
Received: by mail-pf0-f178.google.com with SMTP id 189so47615284pfz.3
        for <git@vger.kernel.org>; Thu, 01 Dec 2016 11:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fzRNrol6qWMSHi9nuY0IHItV3vE0dPNvMfXO8piXHQY=;
        b=AV1YhHZPPPdjkYXsBmIUDxyX0BuyYgSR5oR2pFnNYsS1UOH8gysrkJgHiwyU9ROWx6
         8ucXc1GUpCN5wIFDbqn9OpGkby0Ta/aEzliT5i2qyRyt1644nwyqU2OJalDp9UkJbCnz
         VcIaMonkBaJ1J9uZ69eRbW/Ryp58+xnv+lhlQcXIAZGoy5Ij/VDuSdiAfH6qHTqX45Rw
         jcWHH8oQv7mMX1bSUDWcrEQv6US8twIw9iIarNOwD28xlxLM7ZVEiIi6Oo4SUuLNZywg
         XnWf9sj9/nuKynRF6As3lV1lgvII/e9sGTYow3y7Q8jdiALIq317V5NXQIkuESlYF7nW
         vUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fzRNrol6qWMSHi9nuY0IHItV3vE0dPNvMfXO8piXHQY=;
        b=gJqxevP1igNl7wUGWqG7WEZpCSLg69FyELCFdhbp39/Bq59ciSeJAZElHm1y242sne
         sLuNSLuJEnUK3arH7D3G/UGcU8TwBOOuGnp5wSFHHjtqegQ+AnKuhJipwgEHLHdnLmvf
         H/tAcbQ8C8d/WELhaj6fFTyK4Rk21S8Ske9FyaB7AGM+5Yzts4um2uyIay3N8P3CuUm6
         Sx+cStUvNOIgM4wmDelv99wyvIOYgspRDXu/sfw9y8PXUji3GxRw9h6P8ab8HqSEM7u8
         Fm0m7T529qyBKXQ8+uX9JgwFb/7xcCtzjRpkKYRAqyECPLwW3XEZaf13NSdUGS/ugjzb
         p8Tw==
X-Gm-Message-State: AKaTC022zWY1c5BquqDRmdQvMqMUsfya/fBb8kbjJXfz5W8d1yvQTmMbUv7ZChv+cpQj5omS
X-Received: by 10.84.194.37 with SMTP id g34mr87629940pld.36.1480619765389;
        Thu, 01 Dec 2016 11:16:05 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:2ce9:cac6:1258:bbf3])
        by smtp.gmail.com with ESMTPSA id y134sm1878025pfg.81.2016.12.01.11.16.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Dec 2016 11:16:04 -0800 (PST)
Date:   Thu, 1 Dec 2016 11:16:03 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        sbeller@google.com, jonathantanmy@google.com
Subject: Re: [PATCH v6 1/6] submodules: add helper functions to determine
 presence of submodules
Message-ID: <20161201191603.GB54082@google.com>
References: <1479840397-68264-1-git-send-email-bmwill@google.com>
 <1480555714-186183-1-git-send-email-bmwill@google.com>
 <1480555714-186183-2-git-send-email-bmwill@google.com>
 <20161201042926.mr2qdta7hviizcya@sigill.intra.peff.net>
 <xmqqwpfja3nk.fsf@gitster.mtv.corp.google.com>
 <20161201190925.xi2z7vauxyf3yxyc@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161201190925.xi2z7vauxyf3yxyc@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/01, Jeff King wrote:
> On Thu, Dec 01, 2016 at 10:46:23AM -0800, Junio C Hamano wrote:
> 
> > > mkpath() is generally an unsafe function because it uses a static
> > > buffer, but it's handy and safe for handing values to syscalls like
> > > this.
> > 
> > I think your "unsafe" is not about thread-safety but about "the
> > caller cannot rely on returned value staying valid for long haul".
> > If this change since v5 is about thread-safety, I am not sure if it
> > is safe to use mkpath here.
> 
> Oh, good point. I meant "staying valid", but somehow totally forgot that
> we cared about thread reentrancy here. As if I hadn't just spent an hour
> debugging a thread problem.
> 
> My suggestion is clearly nonsense.
> 
> > I am a bit wary of making the check too sketchy like this, but this
> > is not about determining if a random "path" that has ".git" in a
> > superproject working tree is a submodule or not (that information
> > primarily comes from the superproject index), so I tend to agree
> > with the patch that it is sufficient to check presence of ".git"
> > alone.
> 
> The real danger is that it is a different check than the child process
> is going to use, so they may disagree (see the almost-infinite-loop
> discussion elsewhere).
> 
> It feels quite hacky, but checking:
> 
>   if (is_git_directory(suspect))
> 	return 1; /* actual git dir */
>   if (!stat(suspect, &st) && S_ISREG(st.st_mode))
> 	return 1; /* gitfile; may or may not be valid */
>   return 0;
> 
> is a little more robust, because the child process will happily skip a
> non-repo ".git" and keep walking back up to the superproject. Whereas if
> it sees any ".git" file, even if it is bogus, it will barf then and
> there.
> 
> I'm actually not sure if that latter behavior is a bug or not. I don't
> think it was really planned out, and it obviously is inconsistent with
> the other repo-discovery cases. But it is a convenient side effect for
> submodules, and I doubt anybody is bothered by it in practice.
> 
> -Peff

I think this more robust check is probably a good idea, that way we
don't step into a submodule with a .git directory that isn't really a
.git dir.

-- 
Brandon Williams
