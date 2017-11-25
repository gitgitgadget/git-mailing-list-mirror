Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D10620954
	for <e@80x24.org>; Sat, 25 Nov 2017 20:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751557AbdKYUkO (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 15:40:14 -0500
Received: from elephants.elehost.com ([216.66.27.132]:30095 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751453AbdKYUkN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Nov 2017 15:40:13 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.136.74])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id vAPKdwIA076900
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 25 Nov 2017 15:39:59 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Thomas Gummerer'" <t.gummerer@gmail.com>,
        "'Paul Smith'" <paul@mad-scientist.net>
Cc:     <git@vger.kernel.org>
References: <mailto:20171118224706.13810-1-t.gummerer@gmail.com> <20171122223020.2780-1-t.gummerer@gmail.com> <20171122223020.2780-5-t.gummerer@gmail.com> <xmqq1skonoaw.fsf@gitster.mtv.corp.google.com> <20171125175010.GB14993@hank> <1511634365.2847.211.camel@mad-scientist.net> <20171125200615.GA4344@hank>
In-Reply-To: <20171125200615.GA4344@hank>
Subject: RE: [PATCH v4 4/4] worktree: make add <path> dwim
Date:   Sat, 25 Nov 2017 15:39:52 -0500
Message-ID: <004401d3662d$8f099e10$ad1cda30$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGEnX00pXwLwvrZI7vHKMRm0k2hVAEInd6cAuUq5+YCw2SqUAKzXrZtAZvXXh0CwZDp6KNVDjWA
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On November 25, 2017 3:06 PM Thomas Gummerer wrote:
<big snip>
>however we currently document one behaviour, which I would like to change
(I usually have branches
>without a / in that I want to look at) we currently document one behaviour,
which I'd like to change.  So 
>in that case we are a bit worried about backwards compatibility, and how
this will affect current users
>that have a certain expectation of how the command is supposed to work,
hence the discussion of
>whether to hide the new behaviour behind a flag or not.

>Either way, if we do put the behaviour behind a flag, I'll also add a
configuration variable, which can
>be set to enable the new behaviour so one doesn't have to type out the flag
all the time.

To be consistent with other commands, you could put path after -- and the
ambiguity with refs containing '/' goes away, as refs before the -- would
always be considered refs while after you have paths.

What I don't like is the current add syntax of:
git worktree add [-f] [--detach] [--checkout] [--lock] [-b <new-branch>]
<path> [<branch>]

where the path-spec precedes branch making things a bit icky. It might be
better to have an alternate syntax of:

git worktree add [-f] [--detach] [--checkout] [--lock] [-b <new-branch>]
<path> [<branch>]
git worktree add [-f] [--detach] [--checkout] [--lock] [-b <new-branch>]
[<branch>] -- <path>

But since we only have one path, that may be redundant. Just a thought, as
-- avoids a lot of interpretation evils. While we're here, I wonder whether
<branch> should be changed to <ref-spec> for more general use. Consider
release identifiers using tags, and using the tag instead of branch to
define commit on which the worktree is based.

Cheers,
Randall

-- Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)/NonStop(211288444200000000) 
-- In my real life, I talk too much.





