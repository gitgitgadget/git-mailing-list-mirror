Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC97C00528
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 18:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjHASrp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 14:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjHASrm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 14:47:42 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116B526AD
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 11:47:14 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe1fc8768aso26246975e9.1
        for <git@vger.kernel.org>; Tue, 01 Aug 2023 11:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690915630; x=1691520430;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KoJbsXdtC94642B8pqjaKbuqCfARwKS5CzehJHcUl8I=;
        b=INifGgxDHLwj9msoUQz5f2lXrND9zc3Zp8EzVu04f2Yx+cGmdTsQVEgJcGfU1DwhDS
         XbvrGr+V6x+FOJjtIPLbYJGnI5rFMaQLXIV+3cO+9KRgKCFffIDmZFyO6MMgyS6wzGgX
         ojcHzu3TgXA8GaLYEzZoHR8zX+dEgsFulcqL0eb/A6HQkWuPnXFUnDIgYCiYgnDz3HDZ
         5hTdC1gtDbrc6pEMsG7a2pLCAA8y9/l+QCAtRMWNAfe1qfPxeeincitwvlnq5s1d9yJ/
         3fcCLNccUsQJ83N/aery0rHJTkVXQMrcQh0ivrMHiG8HDpR3Eft5pjY8qkJYciPULI5h
         2m6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690915630; x=1691520430;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KoJbsXdtC94642B8pqjaKbuqCfARwKS5CzehJHcUl8I=;
        b=QHdRsB15lmxdabApyc0C46EU1btPiawAAXM9ivXnIcLON4VakVXfOGP+TkjdPi1YfS
         MiMweUkBAO8C6fGTtyTjr4IP0lb0fHX/mK0Hk/ry3aEUOamTC0ujJgq6CMI6UcX079N6
         JLB0GqABTIUyrVQ1gwCtqtZnVb4QHb7IcQlblI7xynoCxKvv8LkCj3enslnrUN/wmQw8
         qZ0tiaMeAp7usqjZH0vIi6eesWip3wdo96yWcxJxjIpQKY99OvvGITi5Mr7DyZqgTsWg
         vrdwlUyrkgy7Y0lidnpMaPoi2dqZlwwdmGXOWZ7ULdGUrhr+7BhSrmsLx+xyPmzbHusZ
         h5Xw==
X-Gm-Message-State: ABy/qLaclRpTHuzyHiF4unDtS10xjmfHmcd89yl5gU8P8GUNMZtAo0ae
        FZp9+BIpPC7ylNAI/6BDXnE=
X-Google-Smtp-Source: APBJJlE+TgR6iNv2P6M7Sjqw/SEdVVDNctQr9Y+TZLMD4Eio6BHO+F4iqOEFj2N8pctlcOsJFc3KIQ==
X-Received: by 2002:a1c:7703:0:b0:3fe:207c:1aea with SMTP id t3-20020a1c7703000000b003fe207c1aeamr3158284wmi.23.1690915630264;
        Tue, 01 Aug 2023 11:47:10 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.235.211])
        by smtp.gmail.com with ESMTPSA id f9-20020a7bc8c9000000b003fa96fe2bd9sm17376236wml.22.2023.08.01.11.47.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 11:47:10 -0700 (PDT)
Message-ID: <8588c7d5-6ba1-7916-4131-bcf388452254@gmail.com>
Date:   Tue, 1 Aug 2023 19:47:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/7] rebase -i: remove patch file after conflict
 resolution
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Haller <lists@haller-berlin.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
 <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
 <e2a758eb4a5df0fab189b3dd235a1651a0c10342.1690903412.git.gitgitgadget@gmail.com>
 <xmqq5y5yd6d7.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqq5y5yd6d7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/08/2023 18:23, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> When a rebase stops for the user to resolve conflicts it writes a patch
>> for the conflicting commit to .git/rebase-merge/patch. This file has
>> been written since the introduction of "git-rebase-interactive.sh" in
>> 1b1dce4bae7 (Teach rebase an interactive mode, 2007-06-25). I assume the
>> idea was to enable the user inspect the conflicting commit in the same
>> way as they could for the patch based rebase. This file should be
>> deleted when the rebase continues as if the rebase stops for a failed
>> "exec" command or a "break" command it is confusing to the user if there
>> is a stale patch lying around from an unrelated command.
> 
> Unlike the previous step, this describes the change in end-user
> observable behaviour *and* asserts that it is an intended change.

There is no intended change in the observable behavior in the previous 
patch.

> Very good.
> 
>> As the path is
>> now used in two different places rebase_path_patch() is added and used
>> to obtain the path for the patch.
> 
> The get_dir() function gives different paths, between "rebase-merge"
> (for "rebase -i") and "sequencer" (for everything else), and that is
> the parent directory of "/patch" output make_patch() uses.

Good point - the patch file is only ever created by "rebase -i". I'll 
add the assertion you suggest below.

Best Wishes

Phillip

> error_with_patch() is the only caller of make_patch(), and
> error_with_patch() is called by
> 
>   error_failed_squash() - called from pick_commits()
>   pick_commits() - when TODO_EDIT stops the sequence, or
> 		  a non fix-up insn failed when is_rebase_i(), or
> 		  a merge insn failed, or
> 		  a reschedule happened.
> 
> Are we sure that it is the right thing to do to hardcode
> "rebase-merge/patch"?  Unless "rebase -i" is the only thing that
> calls pick_commits() and reaches error_with_patch() to cause
> make_patch() to be called, this changes the behaviour for cases the
> tests added by this patch do not cover, doesn't it?
> 
> I would feel safer if this change is accompanied by something like
 >
> diff --git i/sequencer.c w/sequencer.c
> index cc9821ece2..a5ec8538fa 100644
> --- i/sequencer.c
> +++ w/sequencer.c
> @@ -3502,6 +3502,9 @@ static int make_patch(struct repository *r,
>   	char hex[GIT_MAX_HEXSZ + 1];
>   	int res = 0;
>   
> +	if (!is_rebase_i(opts))
> +		BUG("make-patch should only be triggered during rebase -i");
> +
>   	oid_to_hex_r(hex, &commit->object.oid);
>   	if (write_message(hex, strlen(hex), rebase_path_stopped_sha(), 1) < 0)
>   		return -1;
> 
> to make sure that future changes to "git cherry-pick A..B" that
> makes it easier to edit .git/sequencer/todo and tweak "pick" into
> "edit" (aka "git cherry-pick -i") would not happen unless the author
> of such a change considerts its ramifications first.
> 
> Alternatively, we could still introduce a handy path function, but
> call it sequencer_path_patch() that does get_dir() + "/patch", i.e.
> return different paths honoring is_rebase_i(), to make sure we will
> behave the same way as before.  That might be safer.
> 
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   sequencer.c                | 13 +++++++++----
>>   t/t3418-rebase-continue.sh | 18 ++++++++++++++++++
>>   2 files changed, 27 insertions(+), 4 deletions(-)
>>
>> diff --git a/sequencer.c b/sequencer.c
>> index de66bda9d5b..70b0a7023b0 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -4659,6 +4663,7 @@ static int pick_commits(struct repository *r,
>>   	unlink(rebase_path_message());
>>   	unlink(rebase_path_stopped_sha());
>>   	unlink(rebase_path_amend());
>> +	unlink(rebase_path_patch());
>>   
>>   	while (todo_list->current < todo_list->nr) {
>>   		struct todo_item *item = todo_list->items + todo_list->current;
> 
> Other hunks are about "get_dir() + /patch" -> "rebase_path_patch()",
> but this hunk is about the intended behaviour change.  We clear the
> leftover patch file from the previous round before we enter the loop
> to process new insn from the list, which makes sense.
> 
>> diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
>> index 2d0789e554b..261e7cd754c 100755
>> --- a/t/t3418-rebase-continue.sh
>> +++ b/t/t3418-rebase-continue.sh
>> @@ -244,6 +244,24 @@ test_expect_success 'the todo command "break" works' '
>>   	test_path_is_file execed
>>   '
>>   
>> +test_expect_success 'patch file is removed before break command' '
>> +	test_when_finished "git rebase --abort" &&
>> +	cat >todo <<-\EOF &&
>> +	pick commit-new-file-F2-on-topic-branch
>> +	break
>> +	EOF
>> +
>> +	(
>> +		set_replace_editor todo &&
>> +		test_must_fail git rebase -i --onto commit-new-file-F2 HEAD
>> +	) &&
>> +	test_path_is_file .git/rebase-merge/patch &&
>> +	echo 22>F2 &&
>> +	git add F2 &&
>> +	git rebase --continue &&
>> +	test_path_is_missing .git/rebase-merge/patch
>> +'
>> +
>>   test_expect_success '--reschedule-failed-exec' '
>>   	test_when_finished "git rebase --abort" &&
>>   	test_must_fail git rebase -x false --reschedule-failed-exec HEAD^ &&
