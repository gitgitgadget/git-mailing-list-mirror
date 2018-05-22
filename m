Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B104E1F51C
	for <e@80x24.org>; Tue, 22 May 2018 18:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751624AbeEVSoo (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 14:44:44 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41723 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751436AbeEVSon (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 14:44:43 -0400
Received: by mail-pl0-f66.google.com with SMTP id az12-v6so11416695plb.8
        for <git@vger.kernel.org>; Tue, 22 May 2018 11:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1u3dNNBsNDx+kx/eZK25QDIoFG+RkgupDFz5Tgd2Go8=;
        b=DtihzMINOWCs5/jK06Fm1K9ia68kG9pftg17aVDfOdVnLKpNo5xiSEjsZtGbvLIDmK
         M84hX10jJ+6qaA6mM9nE/neGa/85ShsHMnxNyGwbFiIeKtJ9q8TsCjKjwuB1aoXCakZz
         c2ruoFCkIolbKCzEwBTeyzgNm0JlUA353XHf0qfQxfe6RXB6DST2B5cqBZBIGVh291xt
         j3GUCjbrgwsrdqjYvgxYeg3G4MlX/TTIR3oAvfGHArWZKjw4qC+RMGoDDuiUhkCnqSp1
         ta+OB4XTWAnzDK6m/jt069PIOka2n1Kt+4FedSm7n5dAf1rnVRV6XKWc+mtWf7YZ5Vj2
         l2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1u3dNNBsNDx+kx/eZK25QDIoFG+RkgupDFz5Tgd2Go8=;
        b=QiDEJIN40mVGw6MjzQq2aMirfM+pASyuQjM8zScSjp/by6odi67wAhKvJ7tgSWUTH+
         gCslE99eWZ44T3Z9GzO/X/AYuF8zvpy/Nu39B15pFMmotdHUOBuNW8lDjWZ+ZjdhNOpS
         eBXOwzzFi0Oz1CCmq+sPjZVAxSXZ+hiR3kzF1BhS0d1/chaQvKZJ44sdItA2+o2ANlbJ
         wvGVERglpIInYgCQgt74Fo/3okKAhjlAHE50vLnTyCPtl84BHD/rhCr3XJZNvsAX5lKt
         GbJvpns9CIGAbextEADrn1rOm8eiWRzc6vTU6O/GQ5lzkd1auUIzenmvDq9/ptzP97zf
         ilqA==
X-Gm-Message-State: ALKqPwfVLbGmvJqq6QqvoDVdaFgzZ9k05RCxAUKOSbrT8hinwUBAc+Sh
        8qzwnfmDadSK6tZMAREpv+OgyQ==
X-Google-Smtp-Source: AB8JxZrRYn3M0QXk/59ClNn4CV5RjyYq1wCHyxvIxEMExsPWg8oD7RH5sYjSong/MtqS87b2l1DW1w==
X-Received: by 2002:a17:902:7082:: with SMTP id z2-v6mr25489561plk.373.1527014682857;
        Tue, 22 May 2018 11:44:42 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id b6-v6sm36154188pfe.34.2018.05.22.11.44.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 May 2018 11:44:41 -0700 (PDT)
Date:   Tue, 22 May 2018 11:44:40 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [RFC PATCH] fetch-pack: space out sent "haves" in negotiation
Message-Id: <20180522114440.0b1aa23a780efe6a68770d9b@google.com>
In-Reply-To: <CAGZ79kb96Fxf1OBbnqmAtAm_EA5y9+0NKcNqhKjXhavWe6WzWA@mail.gmail.com>
References: <20180521204340.260572-1-jonathantanmy@google.com>
        <CAGZ79kb96Fxf1OBbnqmAtAm_EA5y9+0NKcNqhKjXhavWe6WzWA@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 21 May 2018 15:57:18 -0700
Stefan Beller <sbeller@google.com> wrote:

> In an ideal world, the server and client would both estimate the potential
> reduction of the packfile to send, and base the decision if to continue
> negotiating on the trade off if the packfile reduction savings are greater
> than the cost of negotiation (in terms of bandwidth or time).
> (e.g. the server could keep track of the "potential largest packfile to
> sent" as well as the "potential smallest packfile to sent" given the
> state of negotiation. And as soon as the difference between those
> two packs is smaller than the size of one round of negotiation,
> it is better to stop and just sent the large file).
> 
> You state that you do not want to change the server side, and stick to
> the current protocol, which makes this ideal world scenario moot, but
> shifts the problem to "picking haves more intelligently".

Thanks for thinking about this!

This requires a modification on the server side, as you said, but this
sounds like a good idea that can be combined with the approach in my
patch - once we've found a match, instead of the client restarting the
fine walk, the server could then send the hashes of the commits between
its tip and the match (or some subset thereof) and the client can send
the specific hashes it has.

> > I'm not sure if this is the best way,
> 
> I think it is the best for a short term gain, as the picking algorithm is
> not part of the protocol, so it can be easily extended/reverted/improved
> as we go. So I would continue this way.

That's true in that this can be subsequently modified without backwards
incompatibility - the only issue is the opportunity cost of the author
and reviewer's time and effort.

> > (1) The implementation that I have
> >
> > This patch contains some drop-in code that passes all existing tests,
> > but the new negotiation algorithm is not tested.
> >
> > To mitigate the effect of skipping, I included functionality wherein
> > the client will retry the commits in a skip if the server ACKs the
> > destination of the skip, but this is currently imperfect - in
> > particular, the server might end the negotiation early, and the commits
> > retried in my current implementation are a superset due to the fact that
> > I didn't store the commits in the skip.
> 
> So we start with exponential hops, fall back to linear probing and then
> "make off by one errors" in the linear probes?

I wouldn't characterize the errors as "off by one errors". They are
more like...let me use a diagram:

A
|\
B D
| |
C E

Suppose we know that the server does not have A, has C, and may or may
not have E (we sent "have E" but didn't get a response yet). My method
restarts the walk at all the parents of A (that is, B and D), but D is
irrelevant to the situation (and should not be walked over - this is the
error).

> > (3) Other ways of improving negotiation
> >
> > If we're prepared to commit-walk a significant part of the entire local
> > repo (as we are, in the situation I described in the first paragraph),
> 
> > and if we have access to corresponding remote-tracking information,
> 
> This is a dangerous assumption, as not everyone is having a 1:1 relationship
> with their remote server (for e.g. code review), but there are these triangle
> workflows in the kernel community for example, where you push in one
> remote direction and (re-)obtain the history merged into the bigger picture
> from another remote. And these two remotes are not special to each other
> on the client side.

Precisely for this reason (where the local repo could have obtained a
remote's commits through means other than through the remote - in this
case, written by the local repo's user themself) I wanted to include
both ancestors and descendants of the remote tracking tip.

> This patch is moving the algorithm driving the selection of new
> commits to pick to
> a new file, but there is no new algorithm, yet?
> As hinted at from (1), this is smarter than what we did before by
> picking commits
> non-linearly but with some sort of exponential back off, how does it end the
> exponential phase?

In this patch, I wrote the new algorithm and deleted the old one. I
think the answer to your question is that the exponential phase never
ends. If what you mean is what happens when we reach a parentless commit
- we will emit it (that is, send "have X") regardless of how many
commits have been skipped.

> The way forward out of RFC state, might be to separate the introduction of a new
> improved algorithm and the refactoring. So first move code literally into the
> fetch-negotiator file, and then add improvements in there, or is it
> just not worth
> the refactoring and directly put in the new algorithm?

You're proposing that if I proceed with this, I split the patch into 2 -
one to move the negotiation algorithm, and one to update it? If yes,
normally I would agree, but the current negotiation algorithm is not
very sophisticated (and does not take up much code), so I think it's not
worth it.

> Another use case we discussed was "open-ended bisection", where you know
> you are in a bad state and "once upon a time it worked", and now you are tasked
> to find the offending commit. To find such a commit, you probably
> would also start
> with such an exponential back off until you run into a "good frontier"
> of commits
> and then use conventional bisect to narrow down the exact commit.

That's true.

> > +struct fetch_negotiator {
> > +       struct sent_commit **sent_commits;
> > +       size_t sent_commit_nr, sent_commit_alloc;
> > +       struct prio_queue candidates;
> > +};
> 
> Maybe we can just declare the struct fetch_negotiator here and not
> define it, such that nobody outside the actual implementation tries
> to access its internals?

That's possible - I wanted to allow allocation of this on the stack (to
save a malloc), but perhaps that's over-optimization.

> > +/*
> > + * Iterate through the commits invoked with fetch_negotiator_ack. The negotiator
> > + * makes an effort to remove redundant commits from the list.
> > + *
> > + * This is useful for stateless connections, in which information about what the
> > + * client knows needs to be replayed in every request.
> 
> So even if we do not use the skip commit logic, this would be a benefit for any
> http(-v0) and v2 users of the protocol?

It would conserve bandwidth, yes, but storing all the commits sent with
additional metadata for each would require more memory.
