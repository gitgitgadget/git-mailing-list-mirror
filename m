Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A807120380
	for <e@80x24.org>; Thu, 23 May 2019 12:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730684AbfEWMyA (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 08:54:00 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:32981 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729698AbfEWMyA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 08:54:00 -0400
Received: by mail-qt1-f195.google.com with SMTP id z5so181164qtb.0
        for <git@vger.kernel.org>; Thu, 23 May 2019 05:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gEzKKeAX7dP9FasgAm3GA9ngkdZu8WiAKPoGFCot+aE=;
        b=Pe+cPr5eb3m7Gv2+euP3Kcs4wCa61UmbL83VT5Or3xbxtCfFdI0MhCTOWezORw+bur
         I88HVifMuH6jq8CQch57BwMva1K40Pp4r/qo1yXrCOfD/6FwUJehzWeM40rPSXWdSU2z
         clXWpv7owl5wh5Gx7lA1CbcrUZkIR487n1nhfNeTVkOCnWvu43JJP9oWNrn8eMiOMB2a
         bmOV3qCD1BYBmwygts3MLPrxu8sDmOeLMC/YUNmPLPlEbEUFTA5AJ+5Auqb4mgWiX6Ef
         C75h+bTVCU+pCbLUKsW8hJ9LmC3RoVjs6t7IfhMWJlJOyWcq6bChBFlpBQDM5N4NGnNp
         JnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gEzKKeAX7dP9FasgAm3GA9ngkdZu8WiAKPoGFCot+aE=;
        b=rwU1Wtjpre5ombx9dJIIu6MMJSH9VVHqRVPUJsTXMO7QT/8K+a5LRL0XdMFBsHCXI1
         y9j8+VFn/grzDKHueN52roFKHx2RCyVvCavOkl6TjMtRPOg3lj6Yb9rf+qtp0X7uB4rF
         p+hguY78fpsg8MJyE/FnQ9GGI7H8tQHIg1+tPj7dEk4rCtzOxehpMdIOJhaqnZzcY0Vf
         radpZcbX43ROSihPf4G43es4H/Lzog+AqXsbTND0cf4M10mSPzq4ybirLDOm+Kz7E8rt
         r3v19cGU7Xpu6DZM+hgic3TKKhkKH2p14QBeuvXYTatqzrHPBdLCGBsLJCK4zKwLpfUy
         bwqw==
X-Gm-Message-State: APjAAAWeaJCMSesC970Y1aP9VxD7v9+NMKokAdxqPKJbUFouMDmb7wlP
        oBhmpNw1hIqacYxclla2ZI/CZrnmeWo=
X-Google-Smtp-Source: APXvYqyO37gzlNx6Y8aqL4Oe70iyXFSwQBQzNXPCF+bVstZ9tNCeplAD/jH09YG/jbwv/eq5x2eLxg==
X-Received: by 2002:ac8:5409:: with SMTP id b9mr78855627qtq.326.1558616038701;
        Thu, 23 May 2019 05:53:58 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:2932:ade9:ad1d:97b8? ([2001:4898:a800:1010:da67:ade9:ad1d:97b8])
        by smtp.gmail.com with ESMTPSA id s12sm13393933qkm.38.2019.05.23.05.53.57
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 05:53:57 -0700 (PDT)
Subject: Re: [PATCH v3] repack: enable bitmaps by default on bare repos
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        git@vger.kernel.org
References: <20190214043743.GB19183@sigill.intra.peff.net>
 <20190309024944.zcbwgvn52jsw2a2e@dcvr>
 <20190310233956.GB3059@sigill.intra.peff.net>
 <20190312031303.5tutut7zzvxne5dw@dcvr>
 <20190312104954.GA2023@sigill.intra.peff.net>
 <20190313015133.n7f7lyujnlwfytre@dcvr>
 <20190313145417.GA24101@sigill.intra.peff.net>
 <20190314091254.nescpfp3n6mbjpmh@dcvr> <87zhoz8b9o.fsf@evledraar.gmail.com>
 <20190410225721.GA32262@sigill.intra.peff.net>
 <20190523113031.GA17448@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1e0d216b-5e68-faff-883c-778a04f55bde@gmail.com>
Date:   Thu, 23 May 2019 08:53:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <20190523113031.GA17448@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/23/2019 7:30 AM, Jeff King wrote:
> On Wed, Apr 10, 2019 at 06:57:21PM -0400, Jeff King wrote:
> 
>>   2. The answer we get from a bitmap versus a regular traversal are not
>>      apples-to-apples equivalent. The regular traversal walks down to
>>      the UNINTERESTING commits, marks the boundaries trees and blobs as
>>      UNINTERESTING, and then adds in all the interesting trees and blobs
>>      minus the UNINTERESTING parts. So it can sometimes give the wrong
>>      answer, claiming something is interesting when it is not.
>>
>>      Whereas with bitmaps we fill in the trees and blobs as we walk, and
>>      you get the true answer. But it means we may open up a lot more
>>      trees than the equivalent traversal would.
>>
>>      So one thing I've never really experimented with (and indeed, never
>>      really thought about until writing this email) is that the bitmaps
>>      could try to do that looser style of traversal, knowing that we
>>      might err on the side of calling things interesting in a few cases.
>>      But hopefully spending a lot less time opening trees.
>>
>>      I'm not even 100% sure what that would look like in code, but just
>>      thinking about it from a high level, I don't there's a particular
>>      mathematical reason it couldn't work.
> 
> I spent a while thinking and experimenting with this tonight. The result
> is the patch below. Ævar, do you still have a copy of the repo that
> misbehaved? I'd be curious to see how it fares.

This patch caught my attention, and I think I understand some of the issues
at hand. I'm not well-versed specifically in Git's bitmap implementation.
The fundamental ideas are there, but my perspective is biased by my own
independent bitmap implementation for Azure Repos. What worked there may not
work at all here.

> Finding the right trees to explore is a little tricky with bitmaps.  In
> a normal traversal, we consider the "edges" to be worth exploring.
> I.e., the places where an UNINTERESTING commit is the parent of an
> interesting one.

This is the "commit frontier" which I bring up again below.

> But with bitmaps, we don't have that information in the same way,
> because we're trying to avoid walking the commits in the first place. So
> e.g., in a history like this:
> 
>   A--B--C
>       \
>        D
> 
> Let's imagine we're computing "C..D", and that D has a bitmap on disk
> but C does not.

(As I read your discussion below, I'm confused. For "C..D", C is a have
and D is a want. We should explore all the haves _first_, then walk the
wants, right?)

> When we visit D, we'll see that it has a bitmap, fill in
> the results in our cumulative "want" bitmap, and then stop walking its
> parents (because we know everything they could tell us already).

I may be misreading something, but we would construct _a_ bitmap for C
by walking its reachable objects until hitting a bitmap we know about.
Perhaps A or B have a bitmap to start the construction. If we never
construct a bitmap for C, then we don't know what to remove from the "D"
bitmap to show the difference.

If "C" is not even in the bitmap pack, then we don't use bitmaps for
this calculation because of this condition:

        /*
         * if we have a HAVES list, but none of those haves is contained
         * in the packfile that has a bitmap, we don't have anything to
         * optimize here
         */
        if (haves && !in_bitmapped_pack(bitmap_git, haves))
                goto cleanup;

> Then we visit C. It's not bitmapped, so we keep walking. Unlike a normal
> traversal, we can't stop walking even though there are only
> UNINTERESTING commits left, because we have to fill the complete bitmap,
> including A and B (and you can imagine there might be thousands of
> ancestors of A, too). The reason is that we skipped adding ancestors of
> D when we saw its bitmap, so no still_interesting() cutoff will work
> there.
> 
> But how do we know that it's worth looking into the tree of "B"? If we
> assume we visit commits before their ancestors (because of the commit
> timestamp ordering), then we'd see that "B" is in the "want" bitmap
> already, which makes it worth visiting its tree.
> 
> Unfortunately we'd then continue on to "A", and it would _also_ look
> interesting, because it's also in the "want" bitmap. We don't have an
> easy way of knowing that "A" is basically already covered by "B", and is
> therefore not worth pursuing. In this example, we could pass down a bit
> from B to A as we traverse. But you can imagine another interesting
> commit branched from A, which _would_ make A's tree worth considering.
> 
> Fundamentally, as soon as we load a bitmap and stop traversing, we lose
> all information about the graph structure.
> 
> So the patch below just looks at every tree that might be worth
> exploring (so both "A" and "B" here, but not "C"). That shouldn't be any
> _worse_ than what the current code does (because it looks at all the
> trees). It appears to behave correctly, at least so far as passing the
> test suite. Running p5310 and p5311 against git.git and linux.git, it
> seems to perform worse. I'm not quite sure why that is (i.e., if I
> screwed up something in the implementation, or if the algorithm is
> fundamentally worse).

I'm of the opinion that the old method was better. It followed a very clear
three-step process:

 1. Compute the "haves" bitmap.

 2. Compute the "wants" bitmap, but don't explore into the "haves" bitmap.

 3. Subtract the "haves" bitmap from the "wants" (in case we added bits to
    the wants before they were in the haves).

But there is hope in your idea to improve some cases. As noted, we give up
if all of the haves are not in the bitmapped pack. By starting with a
commit walk, we can find the "commit frontier," which is the set of commits
that are explored by paint_down_to_common(). In this case, the set {B, C, D}.

After walking commits and finding a set of UNINTERESTING commits, we could
look for any UNINTERESTING commits that have bitmaps (or simply are in the
bitmapped pack) and use those to see our "haves" bitmap. So, if B has a
bitmap, but C is too new for the bitmap, then we can still create the haves
based on B and then take a bitmap diff "D minus B".

In fact, using the "merge base set" for the diff reflects what the non-bitmap
algorithm does in this case. It ignores C and only explores B.

I learned a lot looking at both versions of this method side-by-side. Thanks!

-Stolee
