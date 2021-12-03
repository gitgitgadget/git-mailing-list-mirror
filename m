Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7892DC433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 11:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244471AbhLCLfv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 06:35:51 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:33598 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243608AbhLCLfv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 06:35:51 -0500
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mt6nh-0002Wr-8g; Fri, 03 Dec 2021 11:32:26 +0000
Message-ID: <b9bfd60b-9e4e-caa6-9836-e0f0e984a997@iee.email>
Date:   Fri, 3 Dec 2021 11:32:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [RFC PATCH 0/1] making --set-upstream have default arguments
Content-Language: en-GB
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        git@vger.kernel.org
References: <20211202144354.17416-1-chakrabortyabhradeep79@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <20211202144354.17416-1-chakrabortyabhradeep79@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/12/2021 14:43, Abhradeep Chakraborty wrote:
> To track a upstream branch from a local branch we need to pass
> <repository> and <refspec> to --set-upstream (in case of git push)
> or to --set-upstream-to (in case of git branch). In most cases,
> users track the upstream branch with the same name as the local
> branch they are currently on. For example, users most of the time
> do 'git push <repository> <current_branch_refspec>'.
>
> So, it would be great if 'git push -u' by default do this. This
> patch series address this. The patches of this patch-set set
> some default values for <repository> and <refspec> if they are
> not given. It first tries to get the value of <repository> from
> 'branch.<current_branch>.remote'. If not then it will set the
> value of <repository> as 'origin'. <refspec>'s value would be
> the short name of the current branch.

Can we protect the expectations of a user with a `pushDefault` setting?
If the user has one set, then the upstream won't be where they push in a
triangular repo workflow.

Philip
>
> The first patch implements it for push command. However, before
> moving to the 'git branch' part, it would be great to have
> discussions about the proposed changes in this patch and whether
> the current changes are the best way to address it or not.
>
> Abhradeep Chakraborty (1):
>   push: make '-u' have default arguments
>
>  Documentation/git-push.txt |  6 +++++
>  builtin/push.c             | 48 ++++++++++++++++++++++++++++----------
>  t/t5523-push-upstream.sh   | 11 +++++++++
>  3 files changed, 53 insertions(+), 12 deletions(-)
>

