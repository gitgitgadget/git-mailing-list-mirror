Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4EEC35280
	for <git@archiver.kernel.org>; Thu,  7 May 2020 23:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7045021473
	for <git@archiver.kernel.org>; Thu,  7 May 2020 23:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgEGXbv convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 7 May 2020 19:31:51 -0400
Received: from elephants.elehost.com ([216.66.27.132]:19917 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgEGXbv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 19:31:51 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 047NVkPM018068
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 May 2020 19:31:47 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Alexander Mills'" <alexander.d.mills@gmail.com>,
        <git@vger.kernel.org>
References: <CA+KyZp7TELrswPjNgB99BXXHEXi5pRr5bO3g_wy7zBvv1R4Kww@mail.gmail.com>
In-Reply-To: <CA+KyZp7TELrswPjNgB99BXXHEXi5pRr5bO3g_wy7zBvv1R4Kww@mail.gmail.com>
Subject: RE: check if one branch contains another branch
Date:   Thu, 7 May 2020 19:31:40 -0400
Message-ID: <06da01d624c7$acb17090$061451b0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKqYtZUUutFRLKWsEN64q/0APyDsqb0x+Ag
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 7, 2020 6:59 PM Alexander Mills, Wrote:
> To: git@vger.kernel.org
> Subject: check if one branch contains another branch
> 
> I am looking for a command:
> 
> 1>  if branch x contains branch y
> 
> right now all I can find is
> 
> 2> if current branch contains commit y
> 
> can someone please accomplish #1 ?
> Crazy hard to find an answer to #1 online.
> The user case is to delete old local branches by comparing them with the
> remote integration branch.
> 
> more info if needed:
> https://stackoverflow.com/questions/61669056/how-to-determine-if-
> integration-branch-contains-feature-branch

Looking at this slightly differently, if you try to delete a branch, git branch -d feature-branch, and the branch has not been merged, then the delete will fail. A simple way of looking at it is if the HEAD of the branch has no successor commits then it is not merged (not 100% decisive, but git branch -d is). It is not really that a branch has been merged, but that a commit has successors, meaning that it has been merged. However, unless you are using GitLab, a git merge --squash will not answer your question even if the branch was merged.

A better way of looking at this is in terms of Pull (GitHub, BitBucket) or Merge (GitLab) requests. Has there been a Pull Request for a branch and has the branch been closed? Meaning that when you do a git fetch --prune, your merged/deleted branches go away unless you are on that branch. Looking at the Pull Request history is much more useful in determining whether a branch has been integrated into a main development branch or production branch in a GitFlow process.

It is a different way of looking at the problem, but IMHO, a more representative way when taking developers and deployment into account.

Regards,
Randall

