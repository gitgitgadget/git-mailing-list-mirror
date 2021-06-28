Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282F4C48BC2
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 02:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A5DA619B2
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 02:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbhF1C1U (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Jun 2021 22:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbhF1C1U (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jun 2021 22:27:20 -0400
Received: from act-MTAout5.csiro.au (act-mtaout5.csiro.au [IPv6:2405:b000:e00:257::7:42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41B1C061574
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 19:24:54 -0700 (PDT)
IronPort-SDR: K9BPmIY9cmQkOnAj2wQIqf5sgAUTiXXB6KpRXx8XWAgjXsmj6EclfZz7xI45Xe51qu08izMFm2
 mPhwpvQdHWCA==
X-SBRS: 4.0
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AtenD1KN/jK+A9MBcTyb155DYdb4zR+YMi2?=
 =?us-ascii?q?TDiHofdfUFSKClfp6V8cjzjSWE8Ar5K0tQ4uxoWZPwC080kKQa3WB/B8bFYO?=
 =?us-ascii?q?CLghrKEGgA1/qu/9SDIVyGygc1784JGMIeaOEYZWIKyvoSizPIdurIteP3l5?=
 =?us-ascii?q?xA8t2uq0uFIzsaCZ1I3kNcMEK2A0d2TA5JCd4SD5yH/PdKoDKmZDA+ctm7Lm?=
 =?us-ascii?q?NtZZmOm/T70LbdJTIWDR8u7weDyRmy7qThLhSe1hACFxtS3LYZ93TfmQCR3N?=
 =?us-ascii?q?Ttjxj78G6T64bg1eUXpDLT8KoBOCVKsLlWFtzYsHfoWG2mYczGgNl6mpDq1L?=
 =?us-ascii?q?9gqqi3n/5pBbUP15qWRBDynfKl4Xid7B8+r3Dl0lOWmn3lvIjwQy87EdNIgc?=
 =?us-ascii?q?ZDfgLe8FdIhqAL7Etn5RPsi3NsN2K2oM093am6azh60k6v5XYym+8aiHJSFY?=
 =?us-ascii?q?MYdb9KtIQauEdYCo0JEi724J0uVLAGNrCV2N9GNVeBK3zJtGhmx9KhGnw1Ax?=
 =?us-ascii?q?edW0AH/siYySJfknx1x1YRgMYfgnAD/pQgTIQs3ZWMDk2prsA6ciYyV9M3OA?=
 =?us-ascii?q?4se7rHNoX9e2O/DIvJGyWYKEguAQO8l3fY2sRL2N2X?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2G+AQCzMdlgjA9OdpJagQmBV4MNbIU?=
 =?us-ascii?q?ziQSIOi0Dm06BfAsBAQEPQQQBAYRSAoJyJjQJDgIEAQEBEgEBBgEBAQEBBgQ?=
 =?us-ascii?q?CAhABAQEBKUOFOwEHMoZPAQIDIxUbNgsYAgImAgJXEwgBAYJtgwcBqxuBMoE?=
 =?us-ascii?q?BhGaDWIFjgRAqjWo3gVVEgTwPgm0+hRGCSoJkBIMVgRaBCG8RaC+eUVqcQiw?=
 =?us-ascii?q?HgyOBLgucRgYOBRYQlRqQbrUZhVOBVIIVMxofgz5PGQ6DPYgKgnGOQjRqAgY?=
 =?us-ascii?q?KAQEDCYwsAQE?=
X-IPAS-Result: =?us-ascii?q?A2G+AQCzMdlgjA9OdpJagQmBV4MNbIUziQSIOi0Dm06Bf?=
 =?us-ascii?q?AsBAQEPQQQBAYRSAoJyJjQJDgIEAQEBEgEBBgEBAQEBBgQCAhABAQEBKUOFO?=
 =?us-ascii?q?wEHMoZPAQIDIxUbNgsYAgImAgJXEwgBAYJtgwcBqxuBMoEBhGaDWIFjgRAqj?=
 =?us-ascii?q?Wo3gVVEgTwPgm0+hRGCSoJkBIMVgRaBCG8RaC+eUVqcQiwHgyOBLgucRgYOB?=
 =?us-ascii?q?RYQlRqQbrUZhVOBVIIVMxofgz5PGQ6DPYgKgnGOQjRqAgYKAQEDCYwsAQE?=
Received: from mail-server.pawsey.org.au (HELO prod-mail.pawsey.org.au) ([146.118.78.15])
  by act-ironport-int.csiro.au with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 12:24:51 +1000
Received: from [192.168.42.112] (unknown [1.126.195.180])
        by prod-mail.pawsey.org.au (Postfix) with ESMTPSA id D555531AFEBC
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 10:24:50 +0800 (AWST)
Subject: Re: Definition of "the Git repository"
To:     git@vger.kernel.org
References: <7dd55e85-38eb-7346-ff10-7124102cd22b@pawsey.org.au>
 <435b0150-cd9f-32ce-7a07-3057ef20662a@iee.email>
From:   Kevin Buckley <Kevin.Buckley@pawsey.org.au>
Message-ID: <12dd4f05-456f-c763-441e-5bb16634306a@pawsey.org.au>
Date:   Mon, 28 Jun 2021 10:24:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <435b0150-cd9f-32ce-7a07-3057ef20662a@iee.email>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021/06/26 04:48, Philip Oakley wrote:
>
> ... One can also include in the generic 'repository' the
> various special .git* files that are [user] added to the main source
> directory.
> 
> But it gets worse. In the .git directory there is the 'objects' ...

I don't believe it does get worse, indeed, I am not convinced that it
is as bad as your observation on the semantics might suggest.

Everything within the .git directory "belongs", in my way of thinking,
to the "repository", that is, the directory that gets created when git
is (init)ialised.

For me, the 'objects", the 'ref/heads', the "staging area' and the like,
also lie within the repository.

As for any anciliary files, that control how the git commands actually
process any data in the "working directory" beyond the defaults, some
of them, eg the global commands, will typically exist outside of the
working directory: below one's home directory, and, of course, there
are the system-wide files, typically below /etc.

Given then, that we can have Git-related files, for any given working
directory, below /etc, below the user's home directory, and within the
working directory itself, perhaps it is the whole "computer" which
should be referred to as "the repository"?

Furthermore, even in the case of anciliary files typically found within
the working directory, and I'm thinking of .gitignore as the obvious
example, even the directives in that can be overriden on the command
line, as well as complemented by files outside of the working directory.


I am tempted to say that even if the definition of a "repository" can't
be agreed on, or rather, easily determined by inspection, then at least
the corresponding working directory can be, however, the fact that one
has  access to EnvVars and corresponding command line arguments such as
--git-dir=<path>, --work-tree=<path>, would suggest that it could be
harder for the novice to get their head around things, however, as it is
typicaly clear what the working directory is (the top level directory
containing the files you are working on, under the control of Git),
calling that same directory the "repository" seems, to me anyway, to add
to any confusion, that a Git novice may have.

Given the can of worms that this question has opened up, although I'm
getting the feeling that it has long since been opened, I still maintain
that it would be less confusing, at least for a novice, for the working
directory to be identified and for a previously non-existent directory,
that gets created by the 'git init', to be referred to as the repository,
so as to make a distinction.

Kevin
