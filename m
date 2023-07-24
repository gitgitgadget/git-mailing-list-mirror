Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496C6C001DF
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 16:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjGXQAo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 12:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjGXQAl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 12:00:41 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C614419A
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 09:00:39 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b70bfc8db5so63936501fa.2
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 09:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690214438; x=1690819238;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DkkEPkhprCO8tU1dlVksM4qdZrovHzItx9KfkDJIRlo=;
        b=YxZLtbgyqwrhik4N0tYijo+URhOQa5WH8NYAHq0eHjTsOvRM8rL15w45Kp+uUDdH1O
         qi04caNT9qDLVhjeiFFyHNujxIS+PwCXpJ2/scpRPVf/Kn3lOl+mj+kj8tCzhrm+qJfo
         zwuCZWjiDC2ZLAcrDio30aYZpnVFHSDVnHG/aM/MceR8MfyDPxDk7D//a62r62EP3U8q
         PZwzGNq9bUVkYYG1Zv3Cz8ZRXRCIUwunYnzQr2Rr8a49qzOY33A87s8HxH2TtRJEPU4Q
         ZPGN0cr0PlDAU2XyKsD59+FHfMXPTwj7ZWei5DM1BvAoIwWDQBjaxuY/0pvtkR+ds3iJ
         bFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690214438; x=1690819238;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DkkEPkhprCO8tU1dlVksM4qdZrovHzItx9KfkDJIRlo=;
        b=MhowbW6Tkc+eyFNA2cMum9xjBxVt8xHVZLC/eCT4sw7q8X+/adr6w+jVciMNX7e+xC
         HbISgRBVVrVPPS+GHWxJKdLrrLSn/PdaKSdoDQzgrJmZjif/YZpOkAw5T/3pMCH2pJ9F
         jFWjNETmudmHshMHDZTIMxRr1vuRh5+2nv7mw2kEfLMi1UXk+9msVBHnrkoyLHkzqGZx
         YqAmkbdmwFopfy27FmrcrTnkf1j5bWcbx1x1/AUF7jPEHR6iuWrc0xkrt+Omr0ZfcFA1
         WXk7wto7UfCx/W4kBmR3QuK64afil1R0cHjn34W5clQmxjMjqUHZSYw1ypY3eSSUuLUL
         m11g==
X-Gm-Message-State: ABy/qLbGxOFYRDeCSIa/5+fDUYAs2IGmHQDvKVH8wG5f6/Gq+eGm7aAj
        EEwptYHhqDX8lAnMyL+ZsDo=
X-Google-Smtp-Source: APBJJlFHDUH8sfGwZOLCchcSPboc+IsKmB5oixlWkNEfjfYWRdwekREcE+dPXaMWfr+AhJMevj4a9Q==
X-Received: by 2002:a2e:7301:0:b0:2b7:202:cca7 with SMTP id o1-20020a2e7301000000b002b70202cca7mr6292248ljc.42.1690214437532;
        Mon, 24 Jul 2023 09:00:37 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.235.211])
        by smtp.gmail.com with ESMTPSA id h14-20020a05600c314e00b003fc3b03e41dsm13564416wmo.0.2023.07.24.09.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 09:00:37 -0700 (PDT)
Message-ID: <ecabaf7d-d5a3-d2d9-2610-87c6a7b2570e@gmail.com>
Date:   Mon, 24 Jul 2023 17:00:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 1/1] sequencer: finish parsing the todo list despite an
 invalid first line
Content-Language: en-US
To:     Alex Henrie <alexhenrie24@gmail.com>, phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, alban.gruin@gmail.com, gitster@pobox.com
References: <20230721060848.35641-1-alexhenrie24@gmail.com>
 <20230722212830.132135-1-alexhenrie24@gmail.com>
 <20230722212830.132135-2-alexhenrie24@gmail.com>
 <0d1c5bfd-3ae5-83f0-a333-bbb8510a973a@gmail.com>
 <CAMMLpeTBBS7FExevcvCWut8wFbcDSDBhUUq+tCaXfOPiY+3GXA@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAMMLpeTBBS7FExevcvCWut8wFbcDSDBhUUq+tCaXfOPiY+3GXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex

On 24/07/2023 16:26, Alex Henrie wrote:
> On Mon, Jul 24, 2023 at 4:02 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> 
>> On 22/07/2023 22:28, Alex Henrie wrote:
>>> Before the todo list is edited it is rewritten to shorten the OIDs of
>>> the commits being picked and to append advice about editing the list.
>>> The exact advice depends on whether the todo list is being edited for
>>> the first time or not. After the todo list has been edited it is
>>> rewritten to lengthen the OIDs of the commits being picked and to remove
>>> the advice. If the edited list cannot be parsed then this last step is
>>> skipped.
>>>
>>> Prior to db81e50724 (rebase-interactive: use todo_list_write_to_file()
>>> in edit_todo_list(), 2019-03-05) if the existing todo list could not be
>>> parsed then the initial rewrite was skipped as well. This had the
>>> unfortunate consequence that if the list could not be parsed after the
>>> initial edit the advice given to the user was wrong when they re-edited
>>> the list. This change relied on todo_list_parse_insn_buffer() returning
>>> the whole todo list even when it cannot be parsed. Unfortunately if the
>>> list starts with a "fixup" command then it will be truncated and the
>>> remaining lines are lost. Fix this by continuing to parse after an
>>> initial "fixup" commit as we do when we see any other invalid line.
>>
>> This version looks great apart from the test being run in an unnecessary
>> subshell which looks like it got left in from the last version. Junio
>> might be able to correct that when he applies the patch.
> 
> I think I see what you mean now: Because this test never performs a
> successful rebase, rebase_setup_and_clean is overkill. I can send a v6
> tonight that uses 'test_when_finished "git rebase --abort"' instead.

I don't mind either way on that particular issue though I agree we could 
just use 'test_when_finished "git rebase --abort"' instead. What I was 
referring to was the subshell that comes after 'rebase_setup_and_clean'. 
The change I was looking for was removing the '(' after 
"rebase_setup_and_clean" at the beginning of the test, removing ')' at 
the end of the test and adjusting the indentation.

+test_expect_success 'the first command cannot be a fixup' '
+	rebase_setup_and_clean fixup-first &&
+	(

This subshell is unnecessary as we're not changing directory or 
exporting any environment variables

+		cat >orig <<-EOF &&
+		fixup $(git log -1 --format="%h %s" B)
+		pick $(git log -1 --format="%h %s" C)
+		EOF
+
+		(

This subshell is required as we're setting GIT_SEQUENCE_EDITOR in the 
environment. We only want that set for the initial rebase. In particular 
we do not want it set when we run "git rebase --edit-todo" below which 
is why we exit the subshell as soon as the initial rebase exits.


Best Wishes

Phillip

+			set_replace_editor orig &&
+			test_must_fail git rebase -i A 2>actual
+		) &&
+		grep "cannot .fixup. without a previous commit" actual &&
+		grep "You can fix this with .git rebase --edit-todo.." actual &&
+		# verify that the todo list has not been truncated
+		grep -v "^#" .git/rebase-merge/git-rebase-todo >actual &&
+		test_cmp orig actual &&
+
+		test_must_fail git rebase --edit-todo 2>actual &&
+		grep "cannot .fixup. without a previous commit" actual &&
+		grep "You can fix this with .git rebase --edit-todo.." actual &&
+		# verify that the todo list has not been truncated
+		grep -v "^#" .git/rebase-merge/git-rebase-todo >actual &&
+		test_cmp orig actual
+	)
+'


> Thanks,
> 
> -Alex
