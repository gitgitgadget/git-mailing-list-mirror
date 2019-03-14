Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7523320248
	for <e@80x24.org>; Thu, 14 Mar 2019 11:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfCNLAr (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 07:00:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41701 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbfCNLAr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 07:00:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id p1so5330999wrs.8
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 04:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vVBzPrc5z4zN1iDnfb7Ut3vHSMj3/adLQVl3Y9wylfc=;
        b=YIq63V/3PptHFWf+ThmYUYgmRE3E95HlKtEwp/osF6vjhSqlJcnOOy2AD7YQZnP+H8
         QAAhFBMiSFuR6jNynwBbB+/q1I2fmh+l4F17suyLtNk4DwotO6Di4iydw54JIT2BxKeb
         /LcggSKUg1mH9KM3wZpYOrP3jcDpJNDtxkQ6tVdyVj+wAUzDNe2rALAB6O+R3HvWFvPs
         xQJT0R5PU4QI+WLvGygjRMShFYaK/wgUIdwyZOf8TEQsukhO21QpsLpwCy5RsEt/Klmu
         j/uOPXSJZjOYekAdSv8Dx7S1EdK6NbFtPpmNmMP+UfCfdXe7t4oWwCi18SdKLTZpuPOF
         UbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vVBzPrc5z4zN1iDnfb7Ut3vHSMj3/adLQVl3Y9wylfc=;
        b=Y5K5SNvWbGjoPXz7WAlpM35/nz1QPjOsVjQlFB6TdPr3U7r8XQMQC8ab17mkZKNs+/
         ZkQNeKUbGZjL6BStE2hCsbuTZr20DgaFJEhMYrAeje4XlUCfJU0KGpZrIKaJyE7vo8xx
         2IZJCH/YBIFNlZm5W3yEmbliV9FTMpUZM42tgWUm0fQuEsZgp3PHWs+x4E6S68oNONdU
         biPjVdT4nD6CSBY0ArMLZ7O0kxgyPHhKcBh1bQgJAVXfUWMVTvwP4PNB9hHC7kBltCYV
         mi6vbvvsxF1Y0NN+Aw3N09osEmwQR5YN4EkGwIbnRYM6Rr3IMeV/PztBQPMDTdSoa9ud
         J22A==
X-Gm-Message-State: APjAAAVAjolpx/28SWc6roYThE3YHO/QK8j4twzvcLrTuF/9mP9RZ+YH
        tjryjcs2D+53uH3Tw9WSMyk=
X-Google-Smtp-Source: APXvYqxJmyNOsWpschVZ6AjBcFr5OelxGUgD0JIVaIeqFVQi633n1Gexwzw8mTYQBTEMUSLI7bS5Sg==
X-Received: by 2002:adf:e2ca:: with SMTP id d10mr23620430wrj.250.1552561244660;
        Thu, 14 Mar 2019 04:00:44 -0700 (PDT)
Received: from [192.168.2.201] (host-89-242-186-210.as13285.net. [89.242.186.210])
        by smtp.googlemail.com with ESMTPSA id w10sm23864816wrn.32.2019.03.14.04.00.43
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 04:00:44 -0700 (PDT)
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command
 'switch'
To:     Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <20190208090401.14793-1-pclouds@gmail.com>
 <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-11-pclouds@gmail.com>
 <CABPp-BEBudobnduipQrSvyQWQ7Hb4WmmoptCQ+FyY8BRPp7_ZA@mail.gmail.com>
 <ca6f8e4b-d60c-877c-52e7-fb91c99cd3a5@gmail.com>
 <CABPp-BFoL_U=bzON4SEMaQSKU2TKwnOgNqjt5MUaOejTKGUJxw@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <78628256-79dc-3036-c57b-a96797ceb120@gmail.com>
Date:   Thu, 14 Mar 2019 11:00:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <CABPp-BFoL_U=bzON4SEMaQSKU2TKwnOgNqjt5MUaOejTKGUJxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/03/2019 16:43, Elijah Newren wrote:
> On Tue, Mar 12, 2019 at 4:06 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> Hi Elijah
>>
>> On 11/03/2019 17:54, Elijah Newren wrote:
>>> A few other comments that I thought of while responding elsewhere in
>>> the thread that didn't make sense to include elsewhere...
>>>
>>> On Fri, Mar 8, 2019 at 2:00 AM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
>>>>
>>>> +-m::
>>>> +--merge::
>>>> +       If you have local modifications to one or more files that are
>>>> +       different between the current branch and the branch to which
>>>> +       you are switching, the command refuses to switch branches in
>>>> +       order to preserve your modifications in context.  However,
>>>> +       with this option, a three-way merge between the current
>>>> +       branch, your working tree contents, and the new branch is
>>>> +       done, and you will be on the new branch.
>>>> ++
>>>> +When a merge conflict happens, the index entries for conflicting
>>>> +paths are left unmerged, and you need to resolve the conflicts
>>>> +and mark the resolved paths with `git add` (or `git rm` if the merge
>>>> +should result in deletion of the path).
>>>
>>> Now that Phillip highlighted issues with -m and -f, it's hard not to
>>> wonder about other corner cases.  For example, what if the user made
>>> some changes, staged them, then made more changes, then tried to 'git
>>> checkout -m <other branch>'?  That's no longer a three-way merge, but
>>> four way.  How does that work?  Does it just rely on merge-recursive's
>>> (poorly defined) choice of when to bail out and when to permit such
>>> craziness?
>>
>> If the two-way merge fails then it does 'git add -u' before calling
>> merge_recursive(), then any merged paths are reset to the new HEAD
>> (which throws away newly added files, it should keep anything that is
>> not in HEAD or HEAD@{1}). So any staged changes are lost.
> 
> Ah, so roughly
>   * git add -u
>   * uncommitted_tree=$(git write-tree)
>   * git reset --hard
>   * git checkout $other_branch
>   * git merge-recursive $old_branch -- $other_branch $uncommitted_tree
>   * git reset --mixed HEAD

Something like that (I think it skips the reset and checkout and does
git merge-recursive $old_branch -- $uncommitted_tree $other_branch
and then updating HEAD)

> This at least gives well defined behavior, even if somewhat suboptimal
> in relation to losing staged changes (especially when those staged
> changes were new files).
> 
> I wonder if it'd be nicer, after I get my don't-touch-the-working-tree
> merge rewrite done, to instead do something like:
>   * Write the beginning index to a tree; call it $tree_0
>   * Note whether any working tree files differ from the index, add
> these all to a temporary index and write to to a tree; call it
> $tree_1.
>   * Do a three way in-memory merge of $old_branch with $other_branch
> and $tree_0; call it $merged_tree if there are no conflicts
>   * If $tree_0 == $tree_1, checkout the new branch and update the
> index and working tree to reflect the merge result.
>   * If $tree_0 != $tree_1 and there were any conflicts, abort telling
> the user they need to either unstage or stage changes first (we don't
> want to confuse users with a merge of a merge).
>   * Switch to the new branch, and update the index to match $merged_tree
>   * Do a three way in-memory merge of $old_branch with $merged_tree
> and $tree_1, writing the results (including any conflicts) to the
> working tree afterward.

As much as it annoys me to have to clear conflicts from the index after
a `checkout` or `stash pop` I'm wary of updating the working tree with
conflicts without marking those paths as unmerged in the index. Marking
them prevents the user from accidentally committing files with
unresolved conflicts. It is also easier for the user to find the
conflicts if they're marked as unmerged in the index, they can use `diff
--cc` and recreate them if they need to start over with the resolution.

> 
> Pros of this method:
>   * We don't lose newly staged files
>   * We don't lose user's carefully staged entries for existing files either
> Cons of this method:
>   * It may abort with an error if the user has a mix of both staged
> and unstaged changes (in particular, it will do so if the user's
> staged changes conflict with some difference in the new branch)

I think it's a good way of preserving any unstaged changes, it is
probably good that the user is warned ahead of time that their staged
changes would be lost.

> Thoughts?
> 
>>
>>>> +--orphan <new-branch>::
>>>> +       Create a new 'orphan' branch, named `<new-branch>`, started from
>>>> +       `<start-point>` and switch to it. See explanation of the same
>>>> +       option in linkgit:git-checkout[1] for details.
>>>
>>> Sigh...does this mean --orphan will remain broken?  It has always
>>> driven me crazy that it leaves you with a fully populated rather than
>>> an empty index.
>>
>> I've always thought that was weird.
>>
>>> It seemed broken to me before I figured out the
>>> special usecase,
>>
>> I haven't figured it out yet - what is it?
> 
> It's a presumption that despite the fact that you want a new branch,
> and one with no history to boot, that for some reason you want all the
> previous branch's current contents.  In particular, you can think of
> it as a way to squash all the history of an existing branch into a
> single commit in a new branch.
> 
> Knowing of this usecase doesn't make it bother me any less when I want
> to create a new unrelated empty branch; it seems like it took the
> esoteric usecase over the common one to me, but I'm biased.  It makes
> me feel better than neither you nor Eric could understand this
> behavior of --orphan either.

Thanks for the explanation, I agree it seems like a more esoteric use case.

Best Wishes

Phillip

