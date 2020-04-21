Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B4CC54FD0
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 16:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48DF5206E9
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 16:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587486002;
	bh=u7OBAmv+DKZt3xWMSwW8BS85h1hjm4uhoWB7tSzsEoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xOD9cKKuhxaiuIgAmi5EZVheBFLbcx+CMf08hyr9SPiCcvr7bahLjzds6hLeAphLf
	 svdXxwXwal6Bs6+lFYaLqLppsu9jybJfyhK6th9Je2p7NfHM2sO4AWc95EwXkm4gN+
	 ZLA3XtPZ5HngS6kd0O8gre6x0MWNVn3F6a7CVsSY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgDUQUB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726012AbgDUQUA (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Apr 2020 12:20:00 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F36CC061A10
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 09:19:59 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id x66so15082081qkd.9
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 09:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=QBwlfDtFatHbMSsrKzLhBY2J7Ssx8lU7yfFuyw4M/1E=;
        b=RktSOY3Kcv+GFCcbr1q/PIYPfe3e6V69kLEcdxYmwmWE0rRX7eCgb+OKdYENUIK/Zw
         r84/TkbhB+1aedULcEY6yfrRLGmSr01D6+1ELqVY/iWnf4lP0jzko6cpgBAt+KVU3bYK
         4bRGHNDaa9B8BcnEFgjyp1rg9Edjx3xD9iVOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=QBwlfDtFatHbMSsrKzLhBY2J7Ssx8lU7yfFuyw4M/1E=;
        b=M9BZLdcVgyRkbpqkoh+E4pkkQV7/Bnl/7vb7WIYjNFl2lEVMsmPxdYvI3OBzfOtUzo
         XNbYeFz+gQ26OwabE5LJ/PnULPmxUyH3ajydY6wYHCNkbgFRLTIdPqo1mm4/r+eCxG2r
         9ieuDh5t6bFrlROrFo2v5bTRr7MyNgJfPffAZbn2xYwWqIN/U26hiJMy++cXZrhezwJ8
         Du/fQI5+zFKq9iCip661+jSmSG6VJDyDgkUbBxB0iSZ6exXItnSp8pVnQ2p8fa55j7b1
         X18aKxwe7AEb+ZMmojz1y54y5HucZ6h/Kcr3e7OJSVWfp5kmiAvUR9Uznjo9sjds+myr
         m01Q==
X-Gm-Message-State: AGi0PubQ1tSzCqIj6Y1Y5Al7RMTTz7T7sKVpJgb5BQGzzOsQjmyIGWgF
        v1f/q7E1/gylIMTqGeU7xr/5ow==
X-Google-Smtp-Source: APiQypL0L6arjtdsclIKOV2+uqMCy4tNeNiCvLqkhoDL3oMXOI9u31tveW9qEJSALnz21LI1+sIrrg==
X-Received: by 2002:a37:6511:: with SMTP id z17mr20837591qkb.405.1587485998714;
        Tue, 21 Apr 2020 09:19:58 -0700 (PDT)
Received: from chatter.i7.local (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id v187sm2021380qkc.29.2020.04.21.09.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 09:19:58 -0700 (PDT)
Date:   Tue, 21 Apr 2020 12:19:56 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Christoph Anton Mitterer <calestyo@scientia.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: how to (integrity) verify a whole git repo
Message-ID: <20200421161956.45slynbgkkom3qc3@chatter.i7.local>
Mail-Followup-To: Christoph Anton Mitterer <calestyo@scientia.net>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
References: <acb9a2da98bce7ea3044cbf37c92163497f7e9e2.camel@scientia.net>
 <20200421065301.GH96152@google.com>
 <be69ed1bade98cb7e414c2713fe0d6b5cadd7172.camel@scientia.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <be69ed1bade98cb7e414c2713fe0d6b5cadd7172.camel@scientia.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 21, 2020 at 04:42:16PM +0200, Christoph Anton Mitterer wrote:
> Taking again the kernel as an example:
> If I clone the repo (or fsck it later), than all I know is that there
> was no corruption, if the all the tips are correct, since they start
> the chain of hash sums to all other objects.

Notably, there is normally only one branch in torvalds/linux.git, and 
that's "master". So, there's only one tip.

> But an attacker could have just forged these tips.
> So for checking authenticity, I need to verify some signatures on them
> 
> Now if I check e.g. Linus signature on tag v5.6; I should know that
> everything earlier (in the tree, not chronologically) to that tag are
> authentic.

Yes, verifying a signature on a tag tells you that all commits are 
bit-for-bit exactly the same as on Linus's workstation where he created 
the signature.

> But not e.g. any commits on top of v.5.6 (which aren't either signed
> themselves or protected by another tag "above" them).

This is mostly true, yes.

> Neither any commits never reached from v.5.6, e.g. later stable patches
> like anything from above v.5.5 (which is again below v.5.6) up to 
> v.5.5.13, which is not.

Stable commits would be in the stable tree, and those tags are signed by 
Greg Kroah-Hartman.

> So from my understanding, to use only commits that are authentic by the
> kernel upstream developers, I'd need verify all these tips.. and throw
> away everything which is not reachable by one of them.
> 
> Is that somehow possible?

You probably don't care about commits that arrive between releases, so 
effectively you are already doing that? Even if you have loose objects 
that aren't reachable from your current tip (e.g. you only care about 
objects in the stable branch linux-5.6.y), it's not like they are going 
to "poison" your tree, so removing them is just a garbage collection 
operation at best.

## Minor attestation rant

I would argue that your premise of "authenticity" is wrong. The best 
that we are currently able to offer is a guarantee that, at the point 
where the tag was signed, the tree is bit-for-bit exact to the tree the 
way it exists on Linus Torvalds' (or Greg KH's) workstation.

However, both Linus and Greg merge code from tens of thousands of other 
contributors and it's important to keep in mind that their tag 
signatures do not offer any kind of attestation proof of the code's 
actual authorship or origin. Looking for such proof would be 
near-impossible -- even if we had a universally accepted mechanism to do 
cryptographic attestation of all patches and commits, normal maintainer 
operations would necessarily break this chain:

- maintainers insert their own trailers into commit messages
  (Signed-off-by, Tested-by, Acked-by, etc).
- maintainers reorder and edit patches that they receive from individual 
  contributors -- for typos, minor stylistical cleanups, extra comments, 
  etc.
- maintainers routinely rebase patches they receive before they can 
  submit them to be merged into mainline.

Full code attestation is possible in projects where all commits are 
forks and merges -- for example, many Git**b/Gerrit projects could be 
set up to require full cryptographic attestation of commits, if all 
operations are forks, pull requests, and merges. However, it would be 
impossible to force this development paradigm onto the Linux kernel -- 
it would be extremely disruptive and require massive individual effort 
to overhaul every maintainer's workflow. Furthermore, many maintainers 
would reject this approach because they would disagree about the main 
premise behind the effort -- that cryptographically signing every commit 
offers enough tangible benefit to be worth it.

Let me expound on the last point. There are some 15,000 personas who 
have committed code to the Linux kernel (a persona could be the same 
person committing code from different commercial entities -- 
jdoe@google.com vs jdoe@redhat.com). Even if we assume that each commit 
is signed, we then must have a way to perform some kind of meaningful 
verification, right?

- Where do we get all the public keys required for such a task?
- How do we handle cases where a key has expired or worse, has been 
  revoked by the developer? This can't invalidate their past commits, 
  because it's impossible to re-sign those.
- How do we bootstrap distributed trust without relying on someone being 
  a Fundamentally Non-corruptible Person? It's certainly not me -- I 
  have close relatives living under, shall we say, regimes with loose 
  standards when it comes to personal freedoms.
- How much trust should we be putting into cryptographic signatures?  
  Linux developers aren't necessarily that much better about keeping 
  their workstations protected against malicious attacks, so they are 
  just as vulnerable to having their private keys stolen as anyone else.

For this reason, Linux maintainers use either a zero-trust approach, or 
a last-leg trust approach:

- Submaintainers don't put much trust into *who* wrote the code and 
  review all submissions they receive as potentially containing security 
  bugs (intentional or not); their job is to review the code and pass it 
  up the chain to maintainers.
- if maintainers receive pull requests from submaintainers, then they 
  *may* check cryptographic signatures on the trees they pull. I am 
  trying to encourage all maintainers to do this, and I've been working 
  to introduce patch attestation so that maintainers preferring to work 
  with patch series as opposed to pull requests can have similar 
  functionality.
- Linus checks all signatures on trees he pulls from non-kernel.org 
  locations. Unfortunately, I've not been able to convince him that he 
  should check them on stuff he pulls from kernel.org as well (and he 
  has his own reasons for that).

So, all of this is to say that as the person cloning linux.git you are 
merely the last link in the chain of "trusting the maintainer before 
you." In your case that maintainer is Linus (or Greg KH), and you have 
to agree that, in the end, "having a tree that is bit-for-bit identical 
with what Linus has" is a pretty good assurance that it's as "authentic 
Linux" as it gets.

-K
