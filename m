Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B18C77B73
	for <git@archiver.kernel.org>; Sat, 27 May 2023 16:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjE0Qqk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 May 2023 12:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjE0Qqi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 May 2023 12:46:38 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2039412A
        for <git@vger.kernel.org>; Sat, 27 May 2023 09:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=iee.email;
        s=2023022100; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:To:Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID; bh=HMhfo4nsstF0tNc6HnTwQdVUR5p8Y8Q3M9Djz+IBNZk=; b=UF/qoe
        neLUJaAt6YW+ZY+BdS3P8iEwz3mZcx4GLtGXei3Cm4PhDwOdkdkOW/g/pa3exzCual115D6qWtdGk
        BE8Q2xm7HoYfFvIFIflHPmbeMlTU90cPFll1BEbT6P1AXzIFEzo9b8e9OETLQS+wGHSzQmYl2YJhN
        f5JrVtQzujU=;
Received: from host-89-242-64-91.as13285.net ([89.242.64.91] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1q2x3m-0004Jy-8b;
        Sat, 27 May 2023 17:46:31 +0100
Message-ID: <5bca2615-21e6-34fa-bb22-519acd74cbbd@iee.email>
Date:   Sat, 27 May 2023 17:46:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/1] doc: Glossary, describe Flattening
Content-Language: en-GB
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        alexhenrie24@gmail.com, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>, tao@klerks.biz,
        Junio C Hamano <gitster@pobox.com>
References: <xmqq5ybug8s8.fsf@gitster.g>
 <20230513165657.812-1-philipoakley@iee.email>
 <90871d5e-2838-4026-bd83-ab259f7b18dc@app.fastmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <90871d5e-2838-4026-bd83-ab259f7b18dc@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/05/2023 22:35, Kristoffer Haugsbakk wrote:
> Hi
> 
> On Sat, May 13, 2023, at 18:56, Philip Oakley wrote:
>> Clarify the term 'flatten' and the unexpected effects that the user
>> may come across, such as discussed in [1] and [2].
> 
> Nice to see this effort. I would like more “labels” such as this one to
> conceptualize things because sometimes it feels that Git concepts are
> just handled bottom-up.

It would be good to get a list of those concepts that could benefit from
better explanations. These conceptual views (and misunderstandings)
often only emerge after a period of usage.

>  Specifically in the case of rebase it seems that
> (judging by things like StackOverflow) the pedagogy amounts to
> explaining how rebase *works* (without factoring in `--rebase-merges`)
> and then explaining how that in turn means that a linearization kind of
> “falls out” of that process. And then it seems that you are expected to
> remember that bottom-up explanation without putting any kind of label on
> it; it’s just what it is.

It's not helped by the default settings for some commands being
opinionated as to the workflow of the creators (see also 'pull';-).

Other cases are simply 'new' so falling into the 'naming is hard'
phlogiston camp (staging area concept comes to mind).

> 
>> +[[def_flatten]]flatten::
>> +	Flattening is a common term for the 'linearizing' of a
>> +	selected portion of the <<def_commit_graph_general,commit graph>>.
>> +	Flattening may include excluding commits, or rearranging commits,
>> +	for the linearized sequence.
>> +	In particular, linkgit:git-log[1] and linkgit:git-show[1] have a
>> +	range of "History Simplification" techniques that affect which
>> +	commits are included, and how they are linearized.
>> +	The default linkgit:git-rebase[1] will drop merge commits when it
>> +	flattens history, which also may be unexpected.
>> +	The two common linearization types are chronological (date-time), and
>> +	topological (shape) based orderings. Generation numbering is topological.
> 
> When I first read this I thought, ah, so this is an explanation of how
> linearized rebases are born. But this part also mentions history
> viewing. Then I thought: does my history viewing (git-log(1)) work the
> same as shuffling around changes into new (and linearized) commits? And
> can git-rebase-(1) move between chronological and topological and
> ordering? 

I had latched on to the 'linearise' (ordered list of commits)
perspective which fits both rebase (merge commits dropped) and the
history simplification (uninteresting commits dropped) viewpoint, both
of which can give people trouble of the missing commits.

(see also reply to Junio)

>  But these two things feel different to me (just a feeling,
> UX-wise). So after reading this I am left wondering if different parts
> of this paragraph apply *only* to history viewing and to rebase
> (“rewriting”).
> 
> Again, this is just how I immediately read this paragraph as a user.

Thanks for the feedback. Especially the first reading perspective. It's
all too easy for writers to feel that explaining away a confusion has
solved the problem.

I'll probably tighten 'flatten' to be for rebase only on the basis of a
patch list, without merges. Not sure what to do about the two types of
re-list linearisations just yet.
--
Philip

