Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B808CC35247
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 21:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B0F120720
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 21:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R91hnwUa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgBFVF4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 16:05:56 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43322 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbgBFVF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 16:05:56 -0500
Received: by mail-wr1-f65.google.com with SMTP id z9so65490wrs.10
        for <git@vger.kernel.org>; Thu, 06 Feb 2020 13:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5VsEJKXEnWoCGcnTvHDnaKoiXwLt8sxAeDY8ZcW9VXI=;
        b=R91hnwUag0+L7XsGoOhyyilp1noHiObB4Fb3Ytk7/H+4NZvrTkuDhziaYYbBr/4Yrn
         FxEVw02zFJixDB2BRHP6b4GXIvJudn6dnRk1DH+TGLzceTedq21HcNUcJMc7QJFM7zRk
         T8vT77zys9GHUYrrsGIHfejVaJs3bUuqVpiXO59CjELaYXcqfCO7q2P07/n7GnM0Z7Jc
         pr5BcvgcV8qU8a9DGtB0ysv7HEl6ju1Y27X9vCCVXSGJ8lhRh6Suyt4CDsREL7DxhT3s
         Etf1Ncqa+NyxJeyG6zHlaRhSpqmdUZfPqr4OETfNLLBnqq+Znj5SzeVQ72/pLDvbtSjc
         833w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5VsEJKXEnWoCGcnTvHDnaKoiXwLt8sxAeDY8ZcW9VXI=;
        b=CYu3N06VmDuSdD8MVBoQioDdcl3nFjHyjsKaqaoIzGea9rN2LA5D6BAtQprrbHrJN6
         bp6nHbz8pe6BPT+TwDVNyWbnmhhqDiFTsA9zkdu+VlTgW/NnDWPLAICGcCgHiGtCDrMJ
         lKQD/U96rpEztPheyV3wucx+sgTQE/APyoPkyR6etBaVxaFzHyEbsupFjka1qmatRVV2
         xHxGtbzccsICP6GQsNmN8Rflmzjj30ZZMAKIff3daW+GXnKMULdeZ+nrC+7vHY+bBzfz
         inH31tMWCZIdg3sE92R2ZpU1A/WL4j7cTGsVFF6DytBllWDL/UDT5vLewkVb9IC5xsh5
         20tQ==
X-Gm-Message-State: APjAAAUYyalL/Ocfe6KaR8CHSUNM2HUM0MLDdGASSp7gwtA2DnM2qQDh
        HjGCY+vGfw63bPoN9xF0abxiZRaX
X-Google-Smtp-Source: APXvYqzZc4l405JtQtKn7ih+wsx3TrSdd44a06Unzed3PrNDCdkGYWpH6enNoKAy/OSYLj7S24lJUQ==
X-Received: by 2002:a5d:4cc9:: with SMTP id c9mr5660476wrt.70.1581023153100;
        Thu, 06 Feb 2020 13:05:53 -0800 (PST)
Received: from [192.168.1.240] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id w20sm753974wmk.34.2020.02.06.13.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 13:05:52 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Feb 2020, #01; Wed, 5)
To:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <xmqqpnesfw74.fsf@gitster-ct.c.googlers.com>
 <CABPp-BF0SO92wxY-dM14Vxv6BGA5=T=CicdwbiaZ7c9w6-j2jQ@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <9a9b7605-9705-2317-6e0a-0d620842f95a@gmail.com>
Date:   Thu, 6 Feb 2020 21:05:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CABPp-BF0SO92wxY-dM14Vxv6BGA5=T=CicdwbiaZ7c9w6-j2jQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/02/2020 01:32, Elijah Newren wrote:
> On Wed, Feb 5, 2020 at 3:36 PM Junio C Hamano <gitster@pobox.com> wrote:
>> * en/fill-directory-exponential (2020-01-31) 6 commits
>>   - t7063: blindly accept diffs
>>   - dir: replace exponential algorithm with a linear one
>>   - dir: refactor treat_directory to clarify control flow
>>   - dir: fix confusion based on variable tense
>>   - dir: fix broken comment
>>   - dir: consolidate treat_path() and treat_one_path()
>>   (this branch uses en/fill-directory-fixes-more.)
>>
>>   The directory traversal code had redundant recursive calls which
>>   made its performance characteristics exponential wrt the depth of
>>   the tree, which was corrected.
>>
>>   Still RFC?
>>   cf. <pull.700.v2.git.git.1580495486.gitgitgadget@gmail.com>
> 
> Yes, definitely.  (At least) Two things before it's ready to advance:
>    1) Either the last commit needs to be squashed down, or if it's
> wrong, the code modified to handle the untracked-cache bits correctly.
> I'm hoping someone who's familiar with the untracked-cache (or even
> the index format) can sanity check this piece or even just provide a
> pointer or two about its purpose, design, etc.
>    2) This is a somewhat significant change to how fill_directory()
> works, and it's very hard to be confident that nothing is broken by
> it.  See the commit message of the second to last commit.  I would
> really appreciate another pair of eyes.
> 
> If no one responds within a week or so with pointers on the
> untracked-cache, then I'll dig back in and try to figure out what I
> can.  I'm not sure if anyone will review the general fill_directory()
> stuff; we may just have to bite the bullet at some point by merging it
> and then watch out for problems.  I'll at least look over it all once
> again when I look at the untracked-cache stuff before submitting the
> next re-roll.
> 
> 
>> * en/rebase-backend (2020-01-17) 19 commits
>>   - rebase: change the default backend from "am" to "merge"
>>   - rebase: make the backend configurable via config setting
>>   - rebase tests: repeat some tests using the merge backend instead of am
>>   - rebase tests: mark tests specific to the am-backend with --am
>>   - rebase: drop '-i' from the reflog for interactive-based rebases
>>   - git-prompt: change the prompt for interactive-based rebases
>>   - rebase: add an --am option
>>   - rebase: move incompatibility checks between backend options a bit earlier
>>   - git-rebase.txt: add more details about behavioral differences of backends
>>   - rebase: allow more types of rebases to fast-forward
>>   - t3432: make these tests work with either am or merge backends
>>   - rebase: fix handling of restrict_revision
>>   - rebase: make sure to pass along the quiet flag to the sequencer
>>   - rebase, sequencer: remove the broken GIT_QUIET handling
>>   - t3406: simplify an already simple test
>>   - rebase (interactive-backend): fix handling of commits that become empty
>>   - rebase (interactive-backend): make --keep-empty the default
>>   - t3404: directly test the behavior of interest
>>   - git-rebase.txt: update description of --allow-empty-message
>>
>>   "git rebase" has learned to use the sequencer backend by default,
>>   while allowing "--am" option to go back to the traditional "am"
>>   backend.
>>
>>   Waiting for reviews and/or Acks.
>>   cf. <CABPp-BHONuRyt8VJqRuoCF2rGYZ5EhH9KJXQZ3NO69rYwA5J3g@mail.gmail.com>
> 
> I would like to give Phillip a bit more time for a final review since
> he said he'd try to review v4, but it's also been a few weeks and I
> don't want to delay indefinitely.  So if he hasn't responded by your
> next "What's cooking", I'll probably ask that we just merge it down to
> next at that time.

I'm sorry I haven't reviewed them yet, it's at the top of my list but 
unfortunately I've been wiped out for the last couple of weeks so 
haven't been able to do it (I was going to look at them today but fell 
asleep instead...). I'll try and look at them by the middle of next week 
if I can, I don't want to hold them up any longer than that.

Best Wishes

Phillip
