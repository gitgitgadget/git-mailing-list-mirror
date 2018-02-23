Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71C0F1F404
	for <e@80x24.org>; Fri, 23 Feb 2018 15:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752036AbeBWPpE (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 10:45:04 -0500
Received: from mail-qk0-f169.google.com ([209.85.220.169]:40537 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752195AbeBWPpB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 10:45:01 -0500
Received: by mail-qk0-f169.google.com with SMTP id o25so5726578qkl.7
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 07:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=caWctYYdOpBNtM0VFs9yKIBLjoEJQvgROklaJnp0TOI=;
        b=JKDRKY93iU60nnB/xqRONChfq/AsunZkZryCrrOr6qUOw0MZ3zHVkmX1i/RrPeYQAe
         eTweNFZ1+/YyeXsY8JCPZopPw6DkanqgFx0dqn3BgW15Hg1R8FdShJIItP2VcG0Q6ZqX
         92L+3CO0xcqdvPf1Ssjd7gGTZfn0+iTDxBnzRuNVl+lxWIvr7SHRPdsnPXqc6It/xArk
         zJAUGe9VsGUGs5rj/mUWXEyp5oPHByPsJG+2mtOlgICg5DXEp8ic9k6s4oz/Z9aKZS7N
         4xLah4NsoaImMtrMesb91qP3XTGeV3M1JUDTuME30+Q2QhjWQRloN5toRhesTW2GmQdN
         +WlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=caWctYYdOpBNtM0VFs9yKIBLjoEJQvgROklaJnp0TOI=;
        b=b5NgOVRkB51mBQjQafaJ9ItpawHgbOq/SaOfitlH0PAkHAJhKYJ2BbDNFTJSu/gicq
         hbgwJYhEehhb6v21L4OhmoDxD6J/aV/+fiYpZi08Bzc+W7avKi6lAHHDELzoXH/lpZaz
         mQZF1MNUiqVOC3Izw3CyIyo3fRkxw7eHSkrlEgJ28rY/Jq/0B0Oud2Rcrx/HPM+tgCDH
         71cWdhzeenvGWq+BOZj6eu2YMUaxTeFcuw+ppTZEv2fDdT+YUxgbSGw57HcNfjupISSO
         Z773ldxY4YdX+z665XCvHLlJaC/e6O6gxAlK6XjolKLVUdFgn2nyquFLv6AWv0QsnQMd
         wbag==
X-Gm-Message-State: APf1xPDxXCaxk8KkVcvI/146ybveKUJo5EoN5ZqBLfPHD0r0OtWKPYvs
        Gx5+xHLNLBpA4Rn1N0hx+ws=
X-Google-Smtp-Source: AG47ELteInUtRLvL9kwcGo4UrDo4uAipb53Bx036csSCbl+CuetKoUcc+jJz7TyiOXow9C4cVvOUtg==
X-Received: by 10.55.104.150 with SMTP id d144mr3205046qkc.71.1519400700042;
        Fri, 23 Feb 2018 07:45:00 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id q19sm600578qki.61.2018.02.23.07.44.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Feb 2018 07:44:58 -0800 (PST)
Subject: Re: [PATCH v4 02/13] graph: add commit graph design document
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, peff@peff.net,
        jonathantanmy@google.com, szeder.dev@gmail.com, sbeller@google.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
 <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
 <1519066406-81663-3-git-send-email-dstolee@microsoft.com>
 <xmqq1shf2v8d.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <de1d2550-afb4-d3d4-663c-b0a60411dcdd@gmail.com>
Date:   Fri, 23 Feb 2018 10:44:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqq1shf2v8d.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/20/2018 4:42 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
>> +2. Walking the entire graph to avoid topological order mistakes.
> You have at least one more mention of "topological order mistakes"
> below, but we commonly refer to this issue and blame it for "clock
> skew".  Using the word highlights that there is no "mistake" in topo
> order algorithm and mistakes are in the commit timestamps.

I'll drop the word "mistakes" and instead here say:

   2. Walking the entire graph to satisfy topological order constraints.

and later say

   This heuristic is currently used whenever the computation is allowed to
   violate topological relationships due to clock skew (such as "git log"
   with default order), but is not used when the topological order is
   required (such as merge base calculations, "git log --graph").

>
>> +In practice, we expect some commits to be created recently and not stored
>> +in the commit graph. We can treat these commits as having "infinite"
>> +generation number and walk until reaching commits with known generation
>> +number.
> Hmm, "pretend infinity" is an interesting approach---I need to think
> about it a bit more if it is sufficient.

Since we require the commit graph file to be closed under reachability, 
the commits reachable from the file all have "finite" generation number.

>
>> +- .graph files are managed only by the 'commit-graph' builtin. These are not
>> +  updated automatically during clone, fetch, repack, or creating new commits.
> OK.  s/builtin/subcommand/; it does not make much difference if it
> is a built-in or standalone command.
>
>> +- There is no 'verify' subcommand for the 'commit-graph' builtin to verify
>> +  the contents of the graph file agree with the contents in the ODB.
> I am not entirely sure about the merit of going into this level of
> detail.  Being able to use only a single file looks like a more
> fundamental design limitation, which deserves to be decribed in this
> section, and we could ship the subsystem with that limitation.
>
> But the lack of verify that can be called from fsck is merely the
> matter of not the subsystem being mature enough (to be written,
> reviewed and tested) and not a fundamental one, and we will not be
> shipping the subsystem until that limitation is lifted.
>
> So I'd guess that we prefer this bullet item to be in the commit log
> message, not here, that describes the current status of the
> development (as opposed to the state of the subsystem).

I was treating this design document as a living document that will be 
updated as the feature matures. It is difficult to time when to discuss 
these limitations, since in this commit the graph feature is not 
implemented at all. But, it is important to have _some_ design document 
before continuing to implement the feature.

I can remove this bullet, but I'm not sure which commit message would be 
appropriate to contain that information.

I do intend to remove these limitations and future work bullets as they 
are implemented in later patches.

>
>> +- Generation numbers are not computed in the current version. The file
>> +  format supports storing them, along with a mechanism to upgrade from
>> +  a file without generation numbers to one that uses them.
> Exactly the same comment as above applies to this item.
>
>> +- The commit graph is currently incompatible with commit grafts. This can be
>> +  remedied by duplicating or refactoring the current graft logic.
> Hmm.  Can it be lifted without first allowing us to use more than
> one commit graph file (i.e. one for "traverse while honoring the
> grafts", the other for "traverse while ignoring the grafts")?

I consider this list unordered, but will move this bullet to the top and 
replace its first sentence with:

   The commit graph feature currently does not honor commit grafts.

>
>> +- After computing and storing generation numbers, we must make graph
>> +  walks aware of generation numbers to gain the performance benefits they
>> +  enable. This will mostly be accomplished by swapping a commit-date-ordered
>> +  priority queue with one ordered by generation number. The following
>> +  operations are important candidates:
>> +
>> +    - paint_down_to_common()
>> +    - 'log --topo-order'
> Yes.
>
>> +- The graph currently only adds commits to a previously existing graph.
>> +  When writing a new graph, we could check that the ODB still contains
>> +  the commits and choose to remove the commits that are deleted from the
>> +  ODB. For performance reasons, this check should remain optional.
> The last sentence is somehow unconvincing.  It probably is not
> appropriate for the "Future Work" section to be making a hurried
> design decision before having any working verification code to run
> benchmark on.

I'll remove this entire block, since it is not relevant starting at v4. 
I dropped this "additive only" step in v4 and forgot to remove the bullet.

>
>> +- Currently, parse_commit_gently() requires filling in the root tree
>> +  object for a commit. This passes through lookup_tree() and consequently
>> +  lookup_object(). Also, it calls lookup_commit() when loading the parents.
>> +  These method calls check the ODB for object existence, even if the
>> +  consumer does not need the content. For example, we do not need the
>> +  tree contents when computing merge bases. Now that commit parsing is
>> +  removed from the computation time, these lookup operations are the
>> +  slowest operations keeping graph walks from being fast. Consider
>> +  loading these objects without verifying their existence in the ODB and
>> +  only loading them fully when consumers need them. Consider a method
>> +  such as "ensure_tree_loaded(commit)" that fully loads a tree before
>> +  using commit->tree.
> Very good idea.

I will likely submit an orthogonal patch that does this, as it will save 
time even without the commit graph. The time spent in 'lookup_tree()' is 
less significant when the majority of the time is spent parsing commits, 
but it is still 1-2% in some cases.

>
>> +- The current design uses the 'commit-graph' builtin to generate the graph.
>> +  When this feature stabilizes enough to recommend to most users, we should
>> +  add automatic graph writes to common operations that create many commits.
>> +  For example, one coulde compute a graph on 'clone', 'fetch', or 'repack'
>> +  commands.
> s/coulde/could/.
>
> Also do not forget "fsck" that calls "verify".  That is more urgent
> than intergration with any other subcommand.

Noted.

>
>> +- A server could provide a commit graph file as part of the network protocol
>> +  to avoid extra calculations by clients.
> We need to assess the riskiness and threat models regarding this, if
> we really want to follow this "could" through.  I would imagine that
> the cost for verification is comparable to the cost for regenerating,
> in which case it may not be worth doing this _unless_ the user opts
> into it saying that the other side over the wire is trusted without
> any reservation.

I agree. There is a certain level of trust that is required here.

Thanks,
-Stolee
