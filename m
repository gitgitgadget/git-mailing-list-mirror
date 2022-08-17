Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686AAC25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 17:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238340AbiHQReo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 13:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236240AbiHQRem (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 13:34:42 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6C59DB4C
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 10:34:41 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d16so12554515pll.11
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 10:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=2xPN+rK8DqgSL5M4kcKK4en24k3rk3Jt4eY02JP5098=;
        b=FjiJnNQC83bXKfD/MrXhLTHEENkTLGo+5Jep0mhT+1dfnvGElDLr101e98UhTWsq62
         9tS4lsLwSg8wDpGqqIrLtbgoXx54bS/CHs2PLrP3UxnZeAOgp+eRR5Xvtwx+cBh8P7fQ
         4i3LQVwpxzH1Z+tkoYnu5XUwrWSnmelmc7MabCR28VsHfWwaAMgVG9sfmrjCryI2W5Ls
         kJUcoBDvL9k0WBeQEUNXi6HDFA8QBZV6mwZFtutb0vM3TdEPeCw/Z0OxYxQTcpXKg//e
         3x1tz+SLyqLe3T/CJz05IFZm2UcrwD3SkptjSiiMSx/xlyIynjcc+sq3acQG8XvzBXYy
         GhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=2xPN+rK8DqgSL5M4kcKK4en24k3rk3Jt4eY02JP5098=;
        b=kT/ERSVvBAbM566x8Wynggebom+BPoRUZpf1mO8DqXMnVDuIBcQUBnK3llRS02Jujw
         LK63Yrl/1cOmMuEubpz19WONOAvcRZhHX3zZy6LnBlD+XwbCqL9cPMJ7b9DKrP+6GQdc
         hZevkjKfSyCXN3jX3NubR6R5pAQqQKFDfkGf9Cmo913pbvR/PIdptKz5xW0qQkudziu6
         nf5DPir0GRGbphKIhQQFPT07c5iiaD1ewlHvfXa02NJc0h8FVsviqV6fPMbF/WQtNP5g
         Cv3qm1WP0FWxqL0Ltt8UruXK2qwVbGD6SinKYLmm7Z/Vxmi5FBxGojOrMOo3PiVkizbZ
         9ZFQ==
X-Gm-Message-State: ACgBeo3i3K3LCxJPPaDv9Z+f/00bUyNyO++OXuWPwXPaldNAZBd4QvHl
        5neCeAJEXzeIGq/L3VCH3elMTeKFiSh0
X-Google-Smtp-Source: AA6agR7wOAzhYWsbZ03x0/LuuHXDW4Fvwi/1GAfz8hLONXUtol/i2jw0FGIXQv+2vp/EtLILTkHJjw==
X-Received: by 2002:a17:90a:5a84:b0:1f7:ffb5:4adb with SMTP id n4-20020a17090a5a8400b001f7ffb54adbmr4726279pji.20.1660757681428;
        Wed, 17 Aug 2022 10:34:41 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c24d00b00170a6722c79sm171029plg.247.2022.08.17.10.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 10:34:40 -0700 (PDT)
Message-ID: <bc923a75-7d60-1199-40cd-9d5067d6511c@github.com>
Date:   Wed, 17 Aug 2022 10:34:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v1 1/2] builtin/grep.c: add --sparse option
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Cc:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
 <20220817075633.217934-2-shaoxuan.yuan02@gmail.com>
 <80f24382-1188-d450-d1e2-42f68c08e60b@github.com>
 <xmqqh72ayeru.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqqh72ayeru.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Derrick Stolee <derrickstolee@github.com> writes:
> 
>> On 8/17/2022 3:56 AM, Shaoxuan Yuan wrote:
>>> Add a --sparse option to `git-grep`. This option is mainly used to:
>>>
>>> If searching in the index (using --cached):
>>>
>>> With --sparse, proceed the action when the current cache_entry is
>>
>> This phrasing is awkward. It might be better to reframe to describe the
>> _why_ before the _what_
> 
> Thanks for an excellent suggestion.  As a project participant, I
> could guess the motivation, but couldn't link the parts of the
> proposed log message to what I thought was being said X-<.  The
> below is much clearer.
> 
>>   When the '--cached' option is used with the 'git grep' command, the
>>   search is limited to the blobs found in the index, not in the worktree.
>>   If the user has enabled sparse-checkout, this might present more results
>>   than they would like, since the files outside of the sparse-checkout are
>>   unlikely to be important to them.
> 
> Great.  As an explanation of the reasoning behind the design
> decision, I do not think it is bad to go even stronger than "might
> ... would like" and assume or declare that those users who use
> sparse-checkout are the ones who do NOT want to see the parts of the
> tree that are sparsed out.  And based on that assumption, "grep" and
> "grep --cached" should not bother reporting hit from the part that
> the user is not interested in.
> 
> By stating the design and the reasoning behind that decision clearly
> like so, we allow future developers to reconsider the earlier design
> decision more easily.  In 7 years, they may find that the Git users
> in their era use sparse-checkout even when they still care about the
> contents in the sparsed out area, in which case the basic assumption
> behind this change is no longer valid and would allow them to make
> "grep" and "grep --cached" behave differently.
> 
>>   Change the default behavior of 'git grep' to focus on the files within
>>   the sparse-checkout definition. To enable the previous behavior, add a
>>   '--sparse' option to 'git grep' that triggers the old behavior that
>>   inspects paths outside of the sparse-checkout definition when paired
>>   with the '--cached' option.
> 
> Yup.  Is that "--sparse" or "--unsparse"?  We are busting the sparse
> boundary and looking for everything, and calling the option to do so
> "--sparse" somehow feels counter-intuitive, at least to me.

It is a bit unintuitive, but '--sparse' is already used to mean "operate on
SKIP_WORKTREE entries (i.e., pretend the repo isn't a sparse-checkout)" in
both 'add' (0299a69694 (add: implement the --sparse option, 2021-09-24)) and
'rm' (f9786f9b85 (rm: add --sparse option, 2021-09-24)). The
'checkout-index' option '--ignore-skip-worktree-bits' indicates similar
behavior (and is, IMO, similarly confusing with its use of "ignore").

I'm not sure '--unsparse' would fit as an alternative, though, since 'git
grep' isn't really "unsparsifying" the repo (to me, that would imply
updating the index to remove the 'SKIP_WORKTREE' flag). Rather, it's looking
at files that are sparse when, by default, it does not. 

I still like the consistency of '--sparse' with existing similar options in
other commands but, if we want to try something clearer here, maybe
something like '--search-sparse' is more descriptive?

> 
> Thanks.

