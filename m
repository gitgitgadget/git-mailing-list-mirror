Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF37C433E7
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 15:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 704C522201
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 15:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgJNPK0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 11:10:26 -0400
Received: from dd36226.kasserver.com ([85.13.153.21]:58186 "EHLO
        dd36226.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgJNPK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 11:10:26 -0400
Received: from client3368.fritz.box (i5C745714.versanet.de [92.116.87.20])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id 79A3C3C0B29;
        Wed, 14 Oct 2020 17:10:24 +0200 (CEST)
Subject: Re: [PATCH] Fix zsh installation instructions
To:     Junio C Hamano <gitster@pobox.com>,
        Alexey via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Alexey <lesha.ogonkov@gmail.com>
References: <pull.814.git.git.1593687080695.gitgitgadget@gmail.com>
 <xmqqr1to8dv9.fsf@gitster.c.googlers.com>
From:   Stefan Haller <lists@haller-berlin.de>
Message-ID: <abc4ab95-ed65-1d6b-e964-73734c08cda9@haller-berlin.de>
Date:   Wed, 14 Oct 2020 17:10:23 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <xmqqr1to8dv9.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07.07.20 0:42, Junio C Hamano wrote:
>> From: Alexey <lesha.ogonkov@gmail.com>
> 
> Thanks.
> 
> Any zsh users raise their hands?  Does this change look sane?

Sorry for the late reply, I only saw this now.

Yes, the change is sane. The wrong file extension (.zsh vs. .bash) was a 
documentation bug that I had noticed myself, but forgot to submit a 
patch for.

The other hunk (adding compinit) is not so important to me; I suppose it 
was not in the original version because most zsh users already have this 
in their .zshrc anyway. But it's not wrong, and doesn't hurt to have 
here, I guess.

Best,
Stefan


>> - Fix wrong script in completion configuration. zsh wants bash completion
>>    path here, not path to itself.
>> - Add `compinit` autoload command, since whole thing didn't work
>>    if it is not loaded.
>>
>> Signed-off-by: Alexey <lesha.ogonkov@gmail.com>
>> ---
>>      Fix zsh installation instructions
>>      
>>       * Fix wrong script in completion configuration. zsh wants bash
>>         completion path here, not path to itself.
>>       * Add compinit autoload command, since whole thing didn't work if it is
>>         not loaded.
>>
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-814%2Fogonkov%2Fpatch-1-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-814/ogonkov/patch-1-v1
>> Pull-Request: https://github.com/git/git/pull/814
>>
>>   contrib/completion/git-completion.zsh | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
>> index ce47e86b60..107869036d 100644
>> --- a/contrib/completion/git-completion.zsh
>> +++ b/contrib/completion/git-completion.zsh
>> @@ -9,13 +9,14 @@
>>   #
>>   # If your script is somewhere else, you can configure it on your ~/.zshrc:
>>   #
>> -#  zstyle ':completion:*:*:git:*' script ~/.git-completion.zsh
>> +#  zstyle ':completion:*:*:git:*' script ~/.git-completion.bash
>>   #
>>   # The recommended way to install this script is to make a copy of it in
>>   # ~/.zsh/ directory as ~/.zsh/git-completion.zsh and then add the following
>>   # to your ~/.zshrc file:
>>   #
>>   #  fpath=(~/.zsh $fpath)
>> +#  autoload -Uz compinit && compinit
>>   
>>   complete ()
>>   {
>>
>> base-commit: a08a83db2bf27f015bec9a435f6d73e223c21c5e
> 
