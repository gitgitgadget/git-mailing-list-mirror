Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE62CC433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 15:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8907561360
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 15:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbhKQPlf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 10:41:35 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:33395 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229647AbhKQPld (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 10:41:33 -0500
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mnN15-0009Cc-80; Wed, 17 Nov 2021 15:38:32 +0000
Message-ID: <37ef900a-d9bf-1941-75eb-ea8556e2ba8c@iee.email>
Date:   Wed, 17 Nov 2021 15:38:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: Config spec for git
Content-Language: en-GB
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Wallace, Brooke T (US 349D-Affiliate)" 
        <brooke.t.wallace@jpl.nasa.gov>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <D5EE9939-F639-4E69-BD81-10B05EC43A8E@jpl.nasa.gov>
 <211117.86fsrv6jq7.gmgdl@evledraar.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <211117.86fsrv6jq7.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/11/2021 12:32, Ævar Arnfjörð Bjarmason wrote:
> On Wed, Nov 17 2021, Wallace, Brooke T (US 349D-Affiliate) wrote:
>
>> Has any one considered adding a config spec feature to Git or does Git alreadt have some way to support the same features?
>>
>> I've been using Git for a while now for small projects but taking on a
>> new larger project I've come to realize that Git does not have config
>> specs and so seems to be missing an important feature for managing
>> large projects.
>>
>> We use configuration specs to select directories from a common code
>> base (repo) and map them into different baselines to creat multiple
>> product builds with different feature sets. We used this feature in
>> VCSs such as Clearcase and Perforce. Ultimately this allows us to
>> manage the repo in one directory structure and create product builds
>> with a different one. For example the repo has multiple directories
>> for different products/targets, but a baseline, the workspace, has
>> only one target directory always with the same name mapped to the same
>> location. Obviously the corresponding directories in the repo have
>> different names.
>>
>> Git supports the notion of submodules, but I see no way to map a
>> submodule directory to a different name, remove unwanted subdirs of a
>> submodule, or map a submodule over a subdirectory of the primary
>> repo. Config specs also allow you to specify a specific branch or
>> version that you want to map to your workspace independent of other
>> directories, branches and versions.
>>
>> I suppose it may be possible to achieve the same result by treating
>> the primary repo as the configspec. But I feel like there are some
>> features config specs support that i do not have using submodules, but
>> might need down the road.
>>
>> I can see that omitting, obscuring, or overwriting parts of a repo
>> would not play well with the commit id. So I imagine there could be
>> some real complications trying to add support for the notion of a
>> flexible config spec.
>>
>> Appreciate any comments/feedback
> I understand all the terms involved in your E-Mail except "config spec",
> so on the first couple of readings I was thoroughly confused.
>
> I gather from some Google searching that you may be referring to
> ClearCase SCM jargon:
> https://en.wikipedia.org/wiki/Rational_ClearCase#The_configuration_specification
> &
> https://www.ibm.com/docs/en/rational-clearcase/8.0.0?topic=views-how-config-spec-works
>
> From your description it seems like you're talking about some
> combination of the work-in-progress "sparse checkout" feature, and a
> feature to compose arbitrary subdirectories and overlays of existing
> repositories.
>
> As far as I know nobody's working on the latter, although I suppose some
> clever combination of submodules and sparse checkouts might make it
> possible.
>
> All of that's really a shot in the dark, I think I'm probably not the
> only one who'd benefit from a description of what you'd expect a "config
> spec" to do for you that doesn't assume pre-existing knowledge of the
> term.
>
> More generally it's a very common initial migration stategy between
> SCM's and X SCM -> Git in particular to first consider how you could 1=1
> map existing behavior to Git.
>
> Those sorts of migrations are generally much more painful in the longer
> term than considering how you'd map the software or assets you have to
> Git if you were starting out today, which may be something to think
> about.
Also intrigued, I tried "mapping clearcase config spec to Git" in my
search engine to see what it came up with.

There's a YouTube webinar  "ClearCase to Git - November 2016"
https://www.youtube.com/watch?v=z2odE0CKxCQ  which looked like it may
help clarify issues.
Then there are a few StackOverflow Q&As that may help with terminology.
https://stackoverflow.com/questions/763099/flexible-vs-static-branching-git-vs-clearcase-accurev
https://stackoverflow.com/questions/28280685/toward-an-ideal-workflow-with-clearcase-and-git

It feels like your config specs are like feature branches, but that what
is missing (from Git, relative to the config spec) is a merge strategy
that can define which particular files/folders are merged at the one
time, rather than the current 'all files' being merged. This desire has
come up a few times when large (corporate?)  projects need to merge
large independent feature branches that will need different specialists
to handle different groups of files (i.e. partial merges, e.g. [1]), but
that hasn't been implemented (yet) as it would need someone to think it
through and work on it.
--
Philip
[1]
https://lore.kernel.org/git/BY5PR19MB3400EB9AD87DFE612AFD5CC390810@BY5PR19MB3400.namprd19.prod.outlook.com/

Collaborative conflict resolution feature request

