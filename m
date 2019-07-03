Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50A0B1F461
	for <e@80x24.org>; Wed,  3 Jul 2019 15:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfGCP6U (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 11:58:20 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:40382 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfGCP6T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 11:58:19 -0400
Received: from [192.168.1.22] ([89.243.190.203])
        by smtp.talktalk.net with SMTP
        id iheBh4p44nuQZiheChlNR4; Wed, 03 Jul 2019 16:58:17 +0100
X-Originating-IP: [89.243.190.203]
X-Spam: 0
X-OAuthority: v=2.3 cv=echDgIMH c=1 sm=1 tr=0 a=eLyEXkeXgyqjrUSteAL3aw==:117
 a=eLyEXkeXgyqjrUSteAL3aw==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=5rxgeBVgAAAA:8 a=TCgDnjwaH5mjlof7CVkA:9 a=QEXdDO2ut3YA:10
 a=PwKx63F5tFurRwaNxrlG:22
Subject: Re: Tracking parent branches in Git
To:     Theodore Ts'o <tytso@mit.edu>, Bryan Turner <bturner@atlassian.com>
Cc:     Junio C Hamano <gitster@pobox.com>, rsbecker@nexbridge.com,
        Eric Kulcyk <Eric.kulcyk@microsoft.com>,
        Git Users <git@vger.kernel.org>
References: <DM5PR00MB040845755401A07E5C90251CF1F90@DM5PR00MB0408.namprd00.prod.outlook.com>
 <xmqqpnmt5z19.fsf@gitster-ct.c.googlers.com>
 <CAGyf7-EBs_cRB5R7RyQhX0ZDNqLZWVJEYEtqkGRGJykRqKKTvA@mail.gmail.com>
 <007d01d53049$4db5bec0$e9213c40$@nexbridge.com>
 <77a2b000-f1dc-6f3e-54db-abd227ce6163@iee.org>
 <xmqqef3849v6.fsf@gitster-ct.c.googlers.com>
 <CAGyf7-GhD50Dy0O7JjV4vTyQfFcifyKzeYDS_HtAXy604HxqVQ@mail.gmail.com>
 <20190702192412.GE3032@mit.edu>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <06b74350-0846-91c1-0198-c2bcabd20084@iee.org>
Date:   Wed, 3 Jul 2019 16:58:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190702192412.GE3032@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfJmEmfVRRmRgqnEEuF5Trs54pJP+ec71i1p03d6CDGreUmAR4BQTQfEbhRCjXA5XctwThVElFe3b7t9w68HY4ct+m9vNrtFoCLNQlVlao6pO1n9dJdq3
 +kYKi8T/q4XR/aegrsT2mi1TnIk10CruKXGMU/vhaSOfj2Ds3T047XLa4/b1tLkGa45KAtxt40KWgyVjTHTWSdDWPVSMtSS5WSthqtzRZgwVpzU2AYZr5HID
 MporRdenS/OpgcJivjcs0EFS6cMoBqS9OtGE/vsstzU6JOdRlq1d5jr6AzSU+XYUtjE/kSy01+e+8ZEEWqd6Mx52MHp9ElX7ceu6KAXS09E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/07/2019 20:24, Theodore Ts'o wrote:
> I think the real problem with all of this feature request is that it's
> all presuming a particular workflow, and git is currently*not*
> strongly opinionated about the workflow.
I'd suggest that git does have a clear preference for a workflow that is 
based on the "upstream" view. (e.g. see 'rebase')

While Git tries to avoid being opinionated, it does develop a bias of 
avoiding various common workflows, to the point that they are not even 
well named.

In particular, we have a number of variants of the triangular workflow, 
such as having a personal github fork, and a then also a maintainer's 
repo to complete the triangle [which is even worse for those supporting 
Git-for-Windows because of two level maintenance cascade, with different 
compilation and OS requirements..]. Having three 'origins' is no fun.

There was an attempt to document a triangular flow a while back, but it 
wasn't actually that one. e.g. [1])

The other preference aspect is the tendency to expect users to 'support 
the machine' (e.g. the assume-unchanged file flag, which is commonly 
misunderstood), rather than having a clarity about when Git will support 
the user. Here we (they) are looking for the human readable name of the 
branch that they forked from (and is likely to have been extended 
since), rather than the oid hash of the fork point, though that is 
clearly useful and should be recorded with the branch name as it is 
immutable.

I am cautious about support for Gerrit on the basis that it could 
accidentally reinforce a centralised workflow (to the detriment of 
distributed operation), which should be avoided strongly as a deliberate 
bias.

However the desire to _locally_ record the branch name that the current 
branch was created from is something I would support (which is why I 
suggested the unused branch description...).

Philip

[1] 
https://public-inbox.org/git/5A8F8EE0162B49818813DAEFD68F61DA@PhilipOakley/

(sorry for any delays, I'm still in catch-up mode)
