Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DE871F462
	for <e@80x24.org>; Sun,  2 Jun 2019 20:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfFBUL5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Jun 2019 16:11:57 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:31097 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfFBUL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jun 2019 16:11:56 -0400
Received: from [192.168.1.22] ([78.148.161.28])
        by smtp.talktalk.net with SMTP
        id XWpdhwERWniZTXWpdh8FZT; Sun, 02 Jun 2019 21:11:53 +0100
X-Originating-IP: [78.148.161.28]
X-Spam: 0
X-OAuthority: v=2.3 cv=B8HHL9lM c=1 sm=1 tr=0 a=ujKALdKAi7z8notBBWqKeA==:117
 a=ujKALdKAi7z8notBBWqKeA==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=wI8L9_C0ardc258JGGMA:9 a=QEXdDO2ut3YA:10
Subject: Re: change inside PR not reflected in the resulting squash commit
To:     ARAM MALIACHI <maliachi.aram@gmail.com>, git@vger.kernel.org,
        v-armal@microsoft.com
References: <CAOkV5k19NupZ3L=2QiRuYer8-gMBFM9TKuW5RR2zzHhnVmfZ6w@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <7a6d8cf4-91e8-7cf2-bcc6-9b3a1a2f4382@iee.org>
Date:   Sun, 2 Jun 2019 21:11:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAOkV5k19NupZ3L=2QiRuYer8-gMBFM9TKuW5RR2zzHhnVmfZ6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfBZqQJ0SndMP04Qh2VH+zumak/XGxzlIjlCDZa4mp4e99Sh00+Qm5jWLmC7dxdGikbmwbT8bh3n2dQUqBHnWMeBdbKZHVe8zMWE93KXtOXyDLAUjlEP4
 C2tdQrvBJGoiAlJuJCQB/aSo1F2dfqdJ76eTmSleG0kTa+vC5YMJEvXSqa1FuDWl5MsmFodVVWOJKL5jBnWhHjsKfane4HTQCLJyxvhkNT5RB/aQD8lGxRl0
 X6wT6mCIykllSpnQorYQFA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Maliachi,
It's a quiet night. I'll have a go...
I have spaced out your text..

On 31/05/2019 22:03, ARAM MALIACHI wrote:
> I’m an Azure DevOps support engineer for Microsoft. Prior to composing
> this communication to the Git team I had a conversation with the
> Product Group from Azure DevOps stating this could be expected
> behavior, truth is they didn’t take the time to analyze this with me
> stating our PR system does nothing extra to the regular Git tool.
PR systems can add extra processing steps which allow the flow to be 
more complex that at first glance. Not sure which PR admin system this 
one is..
> However I’m still suspicions about it since I consider myself advanced
> in Git workflows.
> Customer completed a PR from release/Pl4S1R4 into master. PR's id 5238.
This will be a series at a specific base commit.
> Several commits made up this PR: 15 approximately were added to the
> source branch release/Pl4S1R4 while the PR was active.
extras, extras, opportunity for confusion...
> 2 out of 15 commits made the exact same change to the exact same file
> on the exact same lines.
Be wary of terminology here. If the _final_ series was linear without 
merges, then such diffs don't exist, hence the assumption is fallacious.
>   One of these two commits was committed to
> source branch directly
So you have a 'side' branch change, and the PR later merges with this.
>   and the other one is a squash merge commit that
> resulted from another PR completion
A further 'side' branch (for the squash series), and later merges into 
the PR.
>   to source branch coming from a 3rd
> branch while the original PR 5238 was active.

> Specifically commits [descending order]:
> 13ade36d - squash commit of a third branch coming into source branch
> 42940662 - commit made directly to the source branch
> Specifically, both commits include along many changes the following
> change to file /src/components/Layout/Menu.vue on line 80 and line 91
> Original version of file line 80 and 91:
> 80   {{menuOptions.NETWORK}} {{'v'}}
> 91   {{network.name}} {{'v'}}
> Resulting version of the file in line 80 and 91 for both commits:
> 80   {{menuOptions.NETWORK}}
> 91   {{network.name}}
I.e. you have clean (non) merges! they all agree on the right final 
answer. These merges have other content, so have sufficient diffs to 
look interestingly complete, while their earlier commits on the side 
have diffs that give you to think that there are identical changes 
within the PR (rather than being outside of the series)

Have a look at the new "--rebase-merges" (and the discussion threads) 
for some of the issues about bringing in disparate changes via merging in.
> The weird thing which raises a flag for me is that making the same
> change to the exact same file 2 times wouldn't even be possible at all
> since first change would make its current status the desired one and
> therefore the next commit with the same change wouldn't even highlight
> the lines as change. I believe this could be due to the nature of the
> second commit coming from a PR completion [squash] where maybe the
> file was kept unchanged.
I guess it is a time flow disconnect (things you thought static 
changed), and perhaps history simplification (the graphs missed 
important bits) that has caused the confusion (assuming I have 
understood the problem statement, and guessed right as to the 
awkwardness of explaining it)
> What I would expect here is that the PR would read the file and would
> ignore the second change made by squash commit since this exact change
> had already taken place previously.
> Above all this despite the PR having 2 commits highlighting the exact
> same change on a file, the resulting squash commit ignored them both
> and showed the lines 80 and 91 in the affected file as untouched.
> I carefully verified with cx that no other commit would 'revert' this
> two changes or even edit the file /src/components/Layout/Menu.vue
> again so it seems like the system indeed ignored them both on its own.
> Note that other changes to different lines of the affected file were
> recorded correctly in the resulting squash commit once PR was
> completed.
>
> Due to the complexity of cx's environment, I haven't been able to
> reproduce the issue myself, but the proof is inside the PR stored in
> cx's Project.
It should be able to make a toy example with a similar profile. just 
make sure that you have a full DAG covering the three PR series (master 
branch initial state, PR5238, squash-PR, direct commit PR, final state) 
You'll only need a few commits on each. It will be a worthwhile learning 
exercise for you, and to show to colleagues.
--
Philip
PS I could be wrong.
