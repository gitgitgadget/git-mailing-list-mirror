Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A06541F461
	for <e@80x24.org>; Tue,  2 Jul 2019 09:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfGBJXy (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 05:23:54 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:24142 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfGBJXy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 05:23:54 -0400
Received: from [192.168.1.22] ([89.243.190.203])
        by smtp.talktalk.net with SMTP
        id iF0vhn4POWIpciF0vhUa0z; Tue, 02 Jul 2019 10:23:49 +0100
X-Originating-IP: [89.243.190.203]
X-Spam: 0
X-OAuthority: v=2.3 cv=W6NGqiek c=1 sm=1 tr=0 a=eLyEXkeXgyqjrUSteAL3aw==:117
 a=eLyEXkeXgyqjrUSteAL3aw==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=Dx4yW56zAAAA:8 a=ybZZDoGAAAAA:8 a=yMhMjlubAAAA:8
 a=0EVWFJeoAAAA:8 a=2gtJI2pkY7uqWnXTUHAA:9 a=QEXdDO2ut3YA:10
 a=X_u8qhY6y2Nm79co_leF:22 a=0RhZnL1DYvcuLYC8JZ5M:22
Subject: Re: Tracking parent branches in Git
To:     rsbecker@nexbridge.com, 'Bryan Turner' <bturner@atlassian.com>,
        'Junio C Hamano' <gitster@pobox.com>
Cc:     'Eric Kulcyk' <Eric.kulcyk@microsoft.com>, git@vger.kernel.org
References: <DM5PR00MB040845755401A07E5C90251CF1F90@DM5PR00MB0408.namprd00.prod.outlook.com>
 <xmqqpnmt5z19.fsf@gitster-ct.c.googlers.com>
 <CAGyf7-EBs_cRB5R7RyQhX0ZDNqLZWVJEYEtqkGRGJykRqKKTvA@mail.gmail.com>
 <007d01d53049$4db5bec0$e9213c40$@nexbridge.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <77a2b000-f1dc-6f3e-54db-abd227ce6163@iee.org>
Date:   Tue, 2 Jul 2019 10:23:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <007d01d53049$4db5bec0$e9213c40$@nexbridge.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfFNAfIHR+9kMuInLw720uTMKHJH91m9PVbfobeq2rDdQsj3f9b06RcE8/m0u2aw/vXtx3Jl5yaukNt4EQgjEkcr4MndFGC60lYS4C2rUmhD/UZgCrdEg
 0D5lAlwKjbWGCW5jgtyRbxCl2woil9Tw31YcvTbN2JF408AJ/mK+eNrcXnPLESzRAMkEysgBcehgV1+oM2uAGGk2WvXJKBGh7H7UUQiCKkFxNrj1fPX0OPd0
 remoQdD7B8A6AWtzsYZ+uL1jCROB9UjsAX8gFCSbZ14zqKWsF5sOYnEgkLpPUyBXMcLW0GW+TjUaadFSJhcYyA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/07/2019 21:12, rsbecker@nexbridge.com wrote:
> On July 1, 2019 3:48 PM, Bryan Turner wrote:
> On Mon, Jul 1, 2019 at 12:35 PM Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Kulcyk <Eric.kulcyk@microsoft.com> writes:
>>
>> [Overly long lines are not appreciated around here.]
>>
>>> We would like to track parent branches so that creating pull
>>> requests can automatically determine the correct branch to merge
>>> against.  I understand that this would require tracking more
>>> information than is currently available right now in git.  Also, it
>>> seems that if some cases, it is not possible to determine a parent
>>> branch, in which case it would just be empty/null.
>> Do you mean by "parent branch" what people usually call "upstream
>> branch" (i.e. when that branch on the other side gains more commits
>> independent from what you have been working on, then you would want to
>> rebase your work on top of the updated state of that branch on the
>> other side) around here?
> I suspect the question is in regards to "What branch did I create my local branch from?", especially given the pull request reference.
>
> In other words, when I locally do:
> git checkout --no-track -b bturner-some-bugfix origin/release/5.16
>
> release/5.16 is the "parent branch" of my bugfix branch and, when I push my branch and try to open a pull request, release/5.16 is a _likely_ target for where I'd want to merge it. There may be a remote in the name, a la "origin" in my example, or it might be created on top of some other local branch. It's a common feature request for Bitbucket Server[1], for example, to automatically select the "right"
> target branch for a new pull request based on the ancestry of the branch in question--except branches have no ancestry. (This sort of metadata could potentially offer some benefits for building commit graphs (referring to UI treatments for visualizing the DAG, rather than Git's "commit-graph" functionality), depending on how it was implemented, since it would make branch points more stable.)
>
> Since branches are ephemeral names and have no intrinsic metadata of their own (unlike, say, annotated tags or commits), I suspect implementing something like this may be more complicated than it might initially appear, especially if said metadata needs to be communicated to remote repositories (which implies it might require changes to the wire protocol as well).
>
> Best regards,
> Bryan Turner
>
> [1] https://jira.atlassian.com/browse/BSERV-7116
>
>> Perhaps "git help glossary", look
>> for "upstream branch" and start from there?  The entry mentions the
>> configuration variables used to keep track of that information, which
>> are described in "git help config", I think.
>>
>>> If I made a change to track the parent branch for each branch, would
>>> this feature be accepted/welcomed as part of git, even if it off by
>>> default?
>> Regardless of what is being proposed, this is often not a very useful
>> question.  Something worth doing for yourself is worth doing whether
>> others also find it useful ;-)  And others usually do not have enough
>> information to judge if such a change is welcome until seeing it in a
>> bit more concrete form.
> Was there not, at some point in recent history (2019), a discussion about storing extra arbitrary data associated with a branch or other objects? My thought for satisfying what Eric was originally proposing is to store the root commit associated with the original branch HEAD when checkout -b/branch was done to create the branch. Presumably another datum could store the branch that the branch HEAD was on, but that may not be unique - which is a root part of the problem with this request, although it might be something that the user could select/specify - not sure how - at branch creation.
>
> But aside from that both of the above are transient relative to the new branch and by the time you wanted to create a Pull Request, the information you originally wanted could irrelevant - at least to git. If I was the product manager on this, I would suggest going to GitLab, GitHub, or BitBucket and asking for some augmented capability of branch creation, that stores the data for future Pull Request management - instead of doing this in core git because of the transient nature of the relationship between a branch and a commit.
>
> My $0.02.
> Randall
>
 From the Git side, maybe one could simply populate the branch 
description with the commit oid and branched-from name at the time of 
branch creation (no doubt set as a core.option).
The field is already there and almost never used - there's no easy way 
(via git command) to populate the description anyway. Plus its a local 
field, keeping Git distributed.
--
Philip
