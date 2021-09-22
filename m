Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDAFC433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 12:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D6D760E73
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 12:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235458AbhIVMUR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 08:20:17 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:45675 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235425AbhIVMUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 08:20:16 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mT1D2-0000yR-3M; Wed, 22 Sep 2021 13:18:44 +0100
Subject: Re: [PATCH v2] MyFirstContribution: Document --range-diff option when
 writing v2
To:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
References: <20210913194816.51182-1-chooglen@google.com>
 <20210920223226.25877-1-chooglen@google.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <77a8b8d9-4e13-8c5b-c313-512fc7c2c953@iee.email>
Date:   Wed, 22 Sep 2021 13:18:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210920223226.25877-1-chooglen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/09/2021 23:32, Glen Choo wrote:
> In the "Sending v2" section, readers are directed to create v2 patches
> without using --range-diff. However, it is customary to include a
> range-diff against the v1 patches as a reviewer aid.
>
> Update the "Sending v2" section to suggest a simple workflow that uses
> the --range-diff option. Also include some explanation for -v2 and
> --range-diff to help the reader understand the importance.
>
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
> Thanks for the helpful comments on v1! v2 aims to clear up other
> ambiguities from v1 and to propose a specific workflow for readers.
>
> Changes since v1:
>
> * recommend that readers reuse the `psuh` topic branch for v2
> * recommend that readers mark their v1 topic branch
> * add a link to the range-diff docs
> * change the v2 glob pattern to `psuh/v2-*.patch` to match the v1 example
> * explicitly call out the v2 glob pattern so that readers will be extra
>   careful
>
> Interdiff against v1:
>   diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
>   index add1c2bba9..790bf1e8b5 100644
>   --- a/Documentation/MyFirstContribution.txt
>   +++ b/Documentation/MyFirstContribution.txt
>   @@ -1029,27 +1029,29 @@ kidding - be patient!)
>    [[v2-git-send-email]]
>    === Sending v2
>    
>   -Skip ahead to <<reviewing,Responding to Reviews>> for information on how to
>   -handle comments from reviewers. Continue this section when your topic branch is
>   -shaped the way you want it to look for your patchset v2.
>   +This section will focus on how to send a v2 of your patchset. To learn what
>   +should go into v2, skip ahead to <<reviewing,Responding to Reviews>> for
>   +information on how to handle comments from reviewers.
>    
>   -Let's write v2 as its own topic branch, because this will make some things more
>   -convenient later on. Create the `psuh-v2` branch like so:
>   +We'll reuse our `psuh` topic branch for v2. Before we make any changes, we'll
>   +mark the tip of our v1 branch for easy reference:
>    
>    ----
>   -$ git checkout -b psuh-v2 psuh
>   +$ git checkout psuh
>   +$ git branch psuh-v1
>    ----
>    
>   -When you're ready with the next iteration of your patch, the process is fairly
>   -similar to before. Generate your patches again, but with some new flags:
>   +Make your changes with `git rebase -i`. Once you're ready with the next
>   +iteration of your patch, the process is fairly similar to before. Generate your
>   +patches again, but with some new flags:
>    
>    ----
>   -$ git format-patch -v2 --range-diff psuh..psuh-v2 --cover-letter -o psuh/ master..psuh
>   +$ git format-patch -v2 --cover-letter -o psuh/ --range-diff master..psuh-v1 master..
>    ----
>    
>   -The `--range-diff psuh..psuh-v2` parameter tells `format-patch` to include a
>   -range diff between `psuh` and `psuh-v2`. This helps tell reviewers about the
>   -differences between your v1 and v2 patches.
>   +The `--range-diff master..psuh-v1` parameter tells `format-patch` to include a
>   +range-diff between `psuh-v1` and `psuh` (see linkgit:git-range-diff[1]). This
>   +helps tell reviewers about the differences between your v1 and v2 patches.
>    
>    The `-v2` parameter tells `format-patch` to output "v2" patches. For instance,
>    you may notice that your v2 patches, are all named like
>   @@ -1058,8 +1060,10 @@ prefixing them with "[PATCH V2]" instead of "[PATCH]", and your range-diff will
>    be prefaced with "Range-diff against v1".
>    
>    Afer you run this command, `format-patch` will output the patches to the `psuh/`
>   -directory, alongside the v1 patches. That's fine, but be careful when you are
>   -ready to send them.
>   +directory, alongside the v1 patches. Using a single directory makes it easy to
>   +refer to the old v1 patches while proofreading the v2 patches, but you will need
>   +to be careful to send out only the v2 patches. We will use a pattern like
>   +"psuh/v2-*.patch" ("psuh/*.patch" would match v1 and v2 patches).
>    
>    Edit your cover letter again. Now is a good time to mention what's different
>    between your last version and now, if it's something significant. You do not
>   @@ -1097,7 +1101,7 @@ to the command:
>    ----
>    $ git send-email --to=target@example.com
>    		 --in-reply-to="<foo.12345.author@example.com>"
>   -		 psuh/v2*
>   +		 psuh/v2-*.patch
>    ----
>    
>    [[single-patch]]
>
>  Documentation/MyFirstContribution.txt | 41 ++++++++++++++++++++-------
>  1 file changed, 30 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
> index 015cf24631..790bf1e8b5 100644
> --- a/Documentation/MyFirstContribution.txt
> +++ b/Documentation/MyFirstContribution.txt
> @@ -1029,22 +1029,41 @@ kidding - be patient!)
>  [[v2-git-send-email]]
>  === Sending v2
>  
> -Skip ahead to <<reviewing,Responding to Reviews>> for information on how to
> -handle comments from reviewers. Continue this section when your topic branch is
> -shaped the way you want it to look for your patchset v2.
> +This section will focus on how to send a v2 of your patchset. To learn what
> +should go into v2, skip ahead to <<reviewing,Responding to Reviews>> for
> +information on how to handle comments from reviewers.
> +
> +We'll reuse our `psuh` topic branch for v2. Before we make any changes, we'll
> +mark the tip of our v1 branch for easy reference:
>  
> -When you're ready with the next iteration of your patch, the process is fairly
> -similar.
> +----
> +$ git checkout psuh
> +$ git branch psuh-v1
> +----
>  
> -First, generate your v2 patches again:
> +Make your changes with `git rebase -i`. Once you're ready with the next
> +iteration of your patch, the process is fairly similar to before. Generate your
> +patches again, but with some new flags:
>  
>  ----
> -$ git format-patch -v2 --cover-letter -o psuh/ master..psuh
> +$ git format-patch -v2 --cover-letter -o psuh/ --range-diff master..psuh-v1 master..
>  ----
>  
> -This will add your v2 patches, all named like `v2-000n-my-commit-subject.patch`,
> -to the `psuh/` directory. You may notice that they are sitting alongside the v1
> -patches; that's fine, but be careful when you are ready to send them.
> +The `--range-diff master..psuh-v1` parameter tells `format-patch` to include a
> +range-diff between `psuh-v1` and `psuh` (see linkgit:git-range-diff[1]). This
> +helps tell reviewers about the differences between your v1 and v2 patches.
> +
> +The `-v2` parameter tells `format-patch` to output "v2" patches. For instance,
> +you may notice that your v2 patches, are all named like
> +`v2-000n-my-commit-subject.patch`. `-v2` will also format your patches by
> +prefixing them with "[PATCH V2]" instead of "[PATCH]", and your range-diff will
> +be prefaced with "Range-diff against v1".
> +
> +Afer you run this command, `format-patch` will output the patches to the `psuh/`
> +directory, alongside the v1 patches. Using a single directory makes it easy to
> +refer to the old v1 patches while proofreading the v2 patches, but you will need
> +to be careful to send out only the v2 patches. We will use a pattern like
> +"psuh/v2-*.patch" ("psuh/*.patch" would match v1 and v2 patches).

Do we need a line to cover/suggest how the V2 to V3 follow up to further
review commands are tweaked.

This sort of follows from the discussion about keeping the branch `psuh`
as the working branch, and the `-v1`, -`v2`, `-v3` as the record of
former submissions. The range-diff is then tweaked to be `--range-diff
master..psuh-v<N>` where N is the last proper submission (just in case
one version was a not-submitted dud).

(Hmm. Writing that was useful to help clear my thoughts as well ;-)

Thanks for working on this.
-- 
Philip
>  
>  Edit your cover letter again. Now is a good time to mention what's different
>  between your last version and now, if it's something significant. You do not
> @@ -1082,7 +1101,7 @@ to the command:
>  ----
>  $ git send-email --to=target@example.com
>  		 --in-reply-to="<foo.12345.author@example.com>"
> -		 psuh/v2*
> +		 psuh/v2-*.patch
>  ----
>  
>  [[single-patch]]

