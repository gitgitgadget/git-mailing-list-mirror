Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52F3D1F404
	for <e@80x24.org>; Tue, 27 Mar 2018 19:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751750AbeC0TLo (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 15:11:44 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:39501 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751187AbeC0TLn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 15:11:43 -0400
Received: by mail-pf0-f193.google.com with SMTP id c78so582726pfj.6
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 12:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lfPE7Ia8A7krtBSvVwcw/8BhjymEtN/m8jOQlNb3yX0=;
        b=N6vCXQ/cekZS10RMDahraVS56Aw0XNzmS481NQrrxSeClUS/gSAmTogYD1BVJWqRb8
         nQiowXTe9b+DkZ9Kuwg5CA4diS7BneNBiOQKgCpLWh7+mgRbrry8KGpVMgU48ZLX07iY
         zBI236Ibf0UYCVNBR/PQuI9jdcz3BwjmJPBupFu/8ar9LYUUxVNmziYxJV4h1WMoW3Ou
         41oIvgVynW0brHeY4VE7EO07b7p5vGcOFvsrpbtIx0BbpxoEDMDyPkxfao4DyzUpTzx8
         a5UGOA9oMEuRqOmMLPJr9w6e9mVs5eEXpzvZ6dNlevHLo7zKMT+0NkZOx6np8IuZXtdl
         8o9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lfPE7Ia8A7krtBSvVwcw/8BhjymEtN/m8jOQlNb3yX0=;
        b=apfyxt5tjgahJxgdFZelgY9jmtMJ3JPnPb8AYJG+nTDFF68ui6DNcyABq7s+dsnXY7
         kTFIjdv1QKrqShuxop2iHGO8EXA6mQAzoyAjQWmRlQMyaQLqETGOcLVH40ZcfAj08jfp
         ouFGjrV3dxtGoH97MZgMMFiqLNlXdZX1n9IbllWyr/drDbzg2lSJ/4WhB7Et6REXa/AY
         VEuWostir49Emc6a2vOfQa8YUClkk8+IqXCYiaO0Ga5hm5MrBA4zfM3I0jKQuCUBsh7n
         8xxMii0WHto1AXcaboqSRl7R8JhOr7cSU6IwilQYcqjuYAOhadd3vaxUqu+dDbUsZnBT
         3/uw==
X-Gm-Message-State: AElRT7EA4M4OfZW6lJMFf+3JIEGzxLOpivQlFSIq3HHcI+pk0HHnmYHb
        U9y7jJv5XPY7FwEAmZX3QeM=
X-Google-Smtp-Source: AIpwx48vR69o8oZHcU9XYlf3I6z+Em0pANts1gtaiVbuYeo5vD/HzWbUEZMwNat0cSLQ5iPIzI21Ig==
X-Received: by 10.101.93.73 with SMTP id e9mr385089pgt.264.1522177902323;
        Tue, 27 Mar 2018 12:11:42 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id v6sm4068479pfm.2.2018.03.27.12.11.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Mar 2018 12:11:41 -0700 (PDT)
Date:   Tue, 27 Mar 2018 12:11:39 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Aaron Greenberg <p@aaronjgreenberg.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH] branch: implement shortcut to delete last branch
Message-ID: <20180327191139.GD4343@aiede.svl.corp.google.com>
References: <1522176390-646-1-git-send-email-p@aaronjgreenberg.com>
 <1522176390-646-2-git-send-email-p@aaronjgreenberg.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522176390-646-2-git-send-email-p@aaronjgreenberg.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Aaron Greenberg wrote:

> This patch gives git-branch the ability to delete the previous
> checked-out branch using the "-" shortcut. This shortcut already exists
> for git-checkout, git-merge, and git-revert. A common workflow is
>
> 1. Do some work on a local topic-branch and push it to a remote.
> 2. 'remote/topic-branch' gets merged in to 'remote/master'.
> 3. Switch back to local master and fetch 'remote/master'.
> 4. Delete previously checked-out local topic-branch.

Thanks for a clear example.

[...]
>  builtin/branch.c  | 3 +++
>  t/t3200-branch.sh | 8 ++++++++
>  2 files changed, 11 insertions(+)
[...]
> With the approvals listed in [*1*] and in accordance with the
> guidelines set out in Documentation/SubmittingPatches, I am submitting
> this patch to be applied upstream.
>
> After work on this patch is done, I'll look into picking up where the
> prior work done in [*2*] left off.
>
> Is there anything else that needs to be done before this can be
> accepted?
>
> [Reference]
>
> *1* https://public-inbox.org/git/1521844835-23956-2-git-send-email-p@aaronjgreenberg.com/
> *2* https://public-inbox.org/git/1488007487-12965-1-git-send-email-kannan.siddharth12@gmail.com/

For the future, please don't use a separate cover letter message in a
single-patch series like this one.  Instead, please put any discussion
that you don't want to go in the commit message after the three-dash
divider in the same message as the patch, like the diffstat.  See the
section "Sending your patches" in Documentation/SubmittingPatches for
more details:

| You often want to add additional explanation about the patch,
| other than the commit message itself.  Place such "cover letter"
| material between the three-dash line and the diffstat.  For
| patches requiring multiple iterations of review and discussion,
| an explanation of changes between each iteration can be kept in
| Git-notes and inserted automatically following the three-dash
| line via `git format-patch --notes`.

That makes it easier for reviewers to see all the information in one
place and in particular can help them in fleshing out the commit
message if it is missing details.

[...]
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 6d0cea9..9e37078 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -221,6 +221,9 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>  		char *target = NULL;
>  		int flags = 0;
>  
> +		if (!strcmp(argv[i], "-"))
> +			argv[i] = "@{-1}";
> +
>  		strbuf_branchname(&bname, argv[i], allowed_interpret);

This makes me wonder: should the "-" shortcut be handled in
strbuf_branchname itself?  That would presumably simplify callers like
this one.

[...]
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -776,6 +776,14 @@ test_expect_success 'deleting currently checked out branch fails' '
>  	test_must_fail git branch -d my7
>  '
>  
> +test_expect_success 'test deleting last branch' '
> +	git checkout -b my7.1 &&

This naming scheme feels likely to conflict with other patches.
How about something like

	git checkout -B previous &&
	git checkout -B new-branch &&
	git show-ref --verify refs/heads/previous &&
	git branch -d - &&
	test_must_fail git show-ref --verify refs/heads/previous

?

> +	git checkout  - &&
> +	test_path_is_file .git/refs/heads/my7.1 &&
> +	git branch -d - &&
> +	test_path_is_missing .git/refs/heads/my7.1

not specific to this test, but this is relying on low-level details
and means that an implementation that e.g. deleted a loose ref but
kept a packed ref would pass the test despite being broken.

Some of the other tests appear to use show-ref, so that might work
well.

No need to act on this, since what you have here is at least
consistent with some of the other tests in the file.  In other words,
it might be even better to address this throughout the file in a
separate patch.

> +'
> +

A few questions that the tests leave unanswered for me:

 1. Does "git branch -d -" refuse to delete an un-merged branch
    like "git branch -d topic" would?  (That seems like a valuable
    thing to test for typo protection reasons.)

 2. What happens if there is no previous branch, as in e.g. a new
    clone?

 3. What does the error message look like when it cannot delete the
    previous branch for whatever reason?  Does it identify the branch
    that can't be deleted?

>  test_expect_success 'test --track without .fetch entries' '
>  	git branch --track my8 &&
>  	test "$(git config branch.my8.remote)" &&

Thanks and hope that helps,
Jonathan
