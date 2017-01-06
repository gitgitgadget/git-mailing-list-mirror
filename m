Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B0691FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 21:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933212AbdAFV3A (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 16:29:00 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:27131 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755039AbdAFV26 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 16:28:58 -0500
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id Pc4FczNKA46SJPc4FcQJia; Fri, 06 Jan 2017 21:28:56 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=CItoZljD c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=NEAV23lmAAAA:8 a=yMhMjlubAAAA:8 a=9E8L8uwQF7E_yDgRpB0A:9 a=QEXdDO2ut3YA:10
 a=6kGIvZw6iX1k4Y-7sg4_:22 a=Bn2pgwyD2vrAyMmN8A2t:22 a=BKKCjISod1eDJeS0ORpz:22
Message-ID: <49C0981FE7D04AE2AC0BBB011FD74B90@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Robert Dailey" <rcdailey.lists@gmail.com>,
        "Git" <git@vger.kernel.org>
Cc:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
References: <CAHd499BREpaHHyN89a1HchyJiQzPpdo3NSfoLLGVONEmX1m19g@mail.gmail.com>
Subject: Re: Rebasing a branch with merges
Date:   Fri, 6 Jan 2017 21:28:59 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfPIePYOAFt0dOaf8xDWMF/5YkQlLEfQDV5hAB4PUYzkMw1uG9oxTsaga54IMEnhlTU8ihEFeWoZsmVIn++7d2dK0uQ+KBicLzUJNk0fIaap61YAW7Gax
 YyilgA7zyoMshacCbGdlvN53/6F+iGWel37Q9nLyNPXqsakhzy+UZMoxJNwfFfCVCMB8qO//2kLW4cx0hFm+x5maIrtBjdUHAljOygw9TNFcBmsNAl/vGLbv
 jNevY9eaoAZw33GABbD5bQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Robert Dailey" <rcdailey.lists@gmail.com>
> Here's the scenario:
>
> I create a topic branch so one other developer and myself can work on
> a feature that takes 2 weeks to complete. During that 2 week period,
> changes are occurring on master that I need in my topic branch. Since
> I have a collaborator on the branch, I opt for merges instead of
> rebase.
>
> Each day I merge from master to the topic branch, which changes code
> I'm actively working in and requires semantic changes (functions
> renamed, moved, etc).
>
> Once I'm ready to merge the topic branch back into master, I have two
> options (bearing in mind the goal is to keep history as clean as
> possible. Furthermore this implies that the constant merging into
> topic from master has made the topic branch look unwieldy and
> difficult to audit):

a broader question zero;
0. Is the merge always clean? Do you always do a preparatory fixup! to 
ensure that the merge will be clean?

Ensuring that the merge will be clean should greatly simplify your decision 
about process.

>
> 1. Do a squash merge, which keeps history clean but we lose context
> for the important bits (the commits representing units of work that
> contribute to the topic itself).
>
> 2. Do a final rebase prior to merging.
>
> #2 doesn't seem to be possible due to patch ordering. For example, if
> I have real commits after merge commits that depend on those changes
> from master being present as a base at that point in time, the rebase
> will cause the patch before it to no longer include those changes from
> master.

How much of the historic fixups to cover changes on master do you want to 
keep visible? i.e. how many fork-points are truly needed (a. by you, b. by 
the project - personal knowledge vs corporate knowledge).?

>
> Is there a mechanism to rebase in this situation to both achieve a
> clean, linear history for the topic branch and allow fast forward
> merging if desired, while still not causing superfluous conflicts due
> to the merges being omitted during the rebase?
>
> Thanks in advance for any advice in this scenario.
>

Have you looked at @dscho's garden-shears scripts that he uses on 
Git-for-Windows as he has to continuously rebase the Windows specific 
patches on top of the progressing Git master? Very similar issues ;-)

https://github.com/git-for-windows/build-extra/blob/master/shears.sh 
https://blogs.msdn.microsoft.com/visualstudioalm/2016/09/03/whats-new-in-git-for-windows-2-10/ 
(#Fun Facts)

--
Philip 

