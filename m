Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1C0C77B7C
	for <git@archiver.kernel.org>; Sat, 27 May 2023 16:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjE0Q3G (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 May 2023 12:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjE0Q3E (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 May 2023 12:29:04 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8DAC9
        for <git@vger.kernel.org>; Sat, 27 May 2023 09:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=iee.email;
        s=2023022100; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:To:Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID; bh=XyhJAp89UQM6fppG0QaT51qbMzmanPHSmd3VBt2d0zY=; b=HnBXex
        6/sgCWFVlSYUHQPAGOF0pef4C1Q2WfTCIUK4qYubRB4+/v2sKgMvnG9gzJjlHunnvrlpLItpk8n4F
        lGvMSD6dWXBJbPhG3oMo5mkTqFhsA+JWA09iGO9yQZ8IA/6D3m3pSEqs4onba2p9vl7xO6/Dch9Ip
        YJCjItOz5tY=;
Received: from host-89-242-64-91.as13285.net ([89.242.64.91] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1q2wmo-0009Is-Bt;
        Sat, 27 May 2023 17:28:59 +0100
Message-ID: <43ff85b1-9f1d-480c-10fa-a856f625e35e@iee.email>
Date:   Sat, 27 May 2023 17:28:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/1] doc: Glossary, describe Flattening
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes.Schindelin@gmx.de, alexhenrie24@gmail.com,
        git@vger.kernel.org, newren@gmail.com, phillip.wood123@gmail.com,
        tao@klerks.biz
References: <xmqq5ybug8s8.fsf@gitster.g>
 <20230513165657.812-1-philipoakley@iee.email> <xmqqh6seaxlk.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqqh6seaxlk.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My somewhat delayed response..
On 15/05/2023 07:59, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.email> writes:
>
>> +[[def_flatten]]flatten::
>> +	Flattening is a common term for the 'linearizing' of a
>> +	selected portion of the <<def_commit_graph_general,commit graph>>.
>> +	Flattening may include excluding commits, or rearranging commits,
>> +	for the linearized sequence.
> Thanks for writing.  I agree that it is a good idea to define the
> verb "flatten".  The above I agree with 100%.
>
> I think I was one of the first ones who used the verb in the context
> of Git; what I wanted to convey with the verb was what it happens
> when you use "am" to rebuild some history made into a series of
> patches using the "format-patch" command on a part of the history.

That is useful context.
>
> When you have materials from two or more topic branches merged to
> your primary integration branch, you would omit the merge commits on
> the integration branch

I think that implicitly such patches can't include any (the
non-existent) 'merge-patches'..

>  and send patches for commits on these topics
> in a linearized way.  Applying these patches one by one will result
> in a linearlized history, containing patches from all of these
> topics (hopefully this is done in a topological order).

and hence chronological order as a secondary effect
>> +	In particular, linkgit:git-log[1] and linkgit:git-show[1] have a
>> +	range of "History Simplification" techniques that affect which
>> +	commits are included, and how they are linearized.
> I didn't think (and I do not yet agree, but I may change my mind
> after thinking about it further) that the history simplification had
> much to do with flattening.

I was looking at the 'linearised' (i.e. an ordered list) viewpoint, as I
didn't have that historic context you mentioned.

>
> Even after a history is simplified (in the sense how rev-list family
> of commands do so), there will still be merge commits left if both
> branches contribute something to the end result.  So unless a merge
> is to cauterize the side branch (i.e. in order to record the fact
> that we already have everything we may want possibly merge to the
> integration branch from the side branch, we create a merge commit
> that merges the branch but does not change the tree from the parent
> commit on the integration branch), history simplification may not
> contribute to "excluding" commits.

In the linear list perspective, the dropping of commits as
'simplification' would be "excluding" them, in exactly the same way that
the patch list had dropped merge commits..

>
>> +	The default linkgit:git-rebase[1] will drop merge commits when it
>> +	flattens history, which also may be unexpected.
> I am tempted to suggest dropping ", which also may be unexpected"
> here.  When learning a new system, there may be things a learner may
> not expect (that is why we have documents),

Cautions and warnings, in my view, should be part of the manual,
especially if they keep coming back to bite folks. "Try it, fail and
lose work" isn't ideal when trying to learn unfamiliar  techniques.

>  so it is not all that
> useful to say "this may not be expected", expecially if we do not
> mention why it behaves that way to clear the "unexpected"-ness.

true.
>
> And in this case, the reason may be obvious and it is OK to be left
> unsaid---"git rebase" (without an option to keep merge commits) was
> designed to be a way to flatten history, and a flattened history by
> definition cannot have any merge commits in it.

as long as we don't conflate it with rev-list family linear listings..
>
>> +	The two common linearization types are chronological (date-time), and
>> +	topological (shape) based orderings. Generation numbering is topological.
> Good.

Thanks.
--
Philip
