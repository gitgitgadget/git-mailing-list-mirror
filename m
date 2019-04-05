Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2ADC920248
	for <e@80x24.org>; Fri,  5 Apr 2019 00:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbfDEAJm (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 20:09:42 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44121 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729831AbfDEAJl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 20:09:41 -0400
Received: by mail-pg1-f196.google.com with SMTP id i2so2039937pgj.11
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 17:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZbgCM9EGF4lpdcMXfNuPsdC2BOVUDXImMGA9wQUCtKU=;
        b=UOcB4vFFf8BwAwBSB+js+bN3GLRskRCd0I6zF3Gy/RKQwEi6s5aNJ55NLB7BVDn8Si
         qRnCgDOJPP0O3lfHQk5nJTNmAxe7ajU1uBN3OSoGR3zPEKRBGq/jRybg6y6dxVUz9atD
         xbk6heVPxgfcUuWEOM6+3YJ9F6YSxVafSq1cN4IQZFWpeoupZTnQ4jfTa52haAmQim8j
         771KaWY2XjmqxEs2RhrKgdk80RcFwM4gHQnyYjytwWUgZfdr4C1I0oUNfDNLplda3dyC
         tRcWfZLRq1NZfSMXgMzTwqAiKzLbjl5whdF17zsQ4P8lxs7ulHUBAYtz61Yg4QYPuYCr
         iYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=ZbgCM9EGF4lpdcMXfNuPsdC2BOVUDXImMGA9wQUCtKU=;
        b=HMK5P9owOZ1gaCANONmNcVYZsiwpCFFbIIBmDFKoY+Clyj9fMdZPlDQNGkOJWXRAy/
         LRk9LnPqCZc1icl4sXL2r8qq8Zf4UKALlcn0KjadJFV6jtkaKoFszC7i3j3eST/X8UFO
         ckxFgnsicLdAovom/dFwum9nvy08Qldd8No+05GihUtt+3ksbpc55dz/JW5DlTinrnDP
         bOzXHH6ytDVJw+jtb0pTC8zrV8OOJmTonUQomn8yOu5cmLvuDZfQFYfCKl/cmuCzQdNJ
         7NrPulFythp6bQD2a98na6o84gxch82+krgHPCl7brQAVpAVQa/7mATtHsRRCwKdBB0d
         e0Tw==
X-Gm-Message-State: APjAAAUi1Wb7ENGupBBPMlLXUh7Be091CRT5R0n/L8Iov1IpkLMshVC/
        sCRaYRRLyk4mHVIn16PEfYoXpg==
X-Google-Smtp-Source: APXvYqwonSD/6Pe6/GCGrkXlVcLVFM1D5yJQdjhyv3iyy16kGKvRhftm4zs9zVRdLIy/5g/0z7mOAg==
X-Received: by 2002:a63:5f05:: with SMTP id t5mr8525676pgb.176.1554422980466;
        Thu, 04 Apr 2019 17:09:40 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id i10sm30197377pfj.7.2019.04.04.17.09.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 17:09:39 -0700 (PDT)
Date:   Thu, 4 Apr 2019 17:09:34 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, jrnieder@gmail.com
Subject: Re: [PATCH v2] rev-list: exclude promisor objects at walk time
Message-ID: <20190405000934.GH60888@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        jonathantanmy@google.com, jrnieder@gmail.com
References: <6de682d5e48186970644569586fc6613763d5caa.1554312374.git.steadmon@google.com>
 <9f327d6d8dc5e71eb0039aef3ac76ea16c2adab3.1554417917.git.steadmon@google.com>
 <20190404230759.GA26623@sigill.intra.peff.net>
 <20190404234726.GG60888@google.com>
 <20190405000001.GA20793@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405000001.GA20793@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.04.04 20:00, Jeff King wrote:
> On Thu, Apr 04, 2019 at 04:47:26PM -0700, Josh Steadmon wrote:
> 
> > > Did you (or anybody else) have any thoughts on the case where a given
> > > object is referred to both by a promisor and a non-promisor (and we
> > > don't have it)? That's the "shortcut" I think we're taking here: we
> > > would no longer realize that it's available via the promisor when we
> > > traverse to it from the non-promisor. I'm just not clear on whether that
> > > can ever happen.
> > 
> > I am not sure either. In process_blob() and process_tree() there are
> > additional checks for whether missing blobs/trees are promisor objects
> > using is_promisor_object()...  but if we call that we undo the
> > performance gains from this change.
> 
> Hmm. That might be a good outcome, though. If it never happens, we're
> fast. If it does happen, then our worst case is that we fall back to the
> current slower-but-more-thorough check. (And I think that happens with
> your patch, without us having to do anything further).
> 
> > > One other possible small optimization: we don't look up the object
> > > unless the caller asked to exclude promisors, which is good. But we
> > > could also keep a single flag for "is there a promisor pack at all?".
> > > When there isn't, we know there's no point in looking for the object.
> > [...]
> > I'm not necessarily opposed, but I'm leaning towards the "won't matter
> > much" side.
> > 
> > Where would such a flag live, in this case, and who would be responsible
> > for initializing it? I guess it would only matter for rev-list, so we
> > could initialize it in cmd_rev_list() if --exclude-promisor-objects is
> > passed?
> 
> The check is really something like:
> 
>   int have_promisor_pack() {
> 	for (p = packed_git; p; p = p->next) {
> 		if (p->pack_promisor)
> 			return 1;
> 	}
> 	return 0;
>   }
> 
> That could be lazily cached as a single bit, but it would need to be
> reset whenever we call reprepare_packed_git().
> 
> Let's just punt on it for now. I'm not convinced it would actually yield
> any benefit, unless we have a partial-clone repo that doesn't have any
> promisor packs (but then, I suspect whatever un-partial'd it should
> probably be resetting the partial flag in the config).
> 
> > > I didn't see any tweaks to the callers, which makes sense; we're already
> > > passing --exclude-promisor-objects as necessary. Which means by itself,
> > > this patch should be making things faster, right? Do you have timings to
> > > show that off?
> > 
> > Yeah, for a partial clone of a large-ish Android repo [1], we see the
> > connectivity check go from >180s to ~7s.
> 
> Those are nice numbers. :) Worth mentioning in the commit message, I
> think. How does it compare to your earlier patch? I'd hope they're about
> the same.

Thanks, will include them in the v3 commit message. Unfortunately it's
hard to compare against v1, because v1 doesn't call rev-list at all, and
thus we don't have a good measurement in the trace / trace2 output. The
rev-list timing has been pretty consistent at just a bit over 3 minutes,
but the overall clone takes anywhere from 12-20 minutes, so any
difference between v1 and v2 performance just gets lost in the noise. If
I get a chance on Monday I may go back to v1 and add some timing.
