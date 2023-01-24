Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6A0C25B4E
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 13:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbjAXNQn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 08:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbjAXNQm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 08:16:42 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98E113D7E
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 05:16:40 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ud5so38945395ejc.4
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 05:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r/yfiXbq7IW0jxnra/A2NFF4/0S6YyEiUxuqmCQReis=;
        b=AIPakq8EM7oiPOENpontQU6rGRxukr7gyNLaXNBJG72GHjnhMCOjoxzPb/U5kgQcZy
         +ID7Hg+JKhKCMt8njyN9jsIV++a2EibjfB3hbFHX8C4KmnNHO2Ix9FuJb5ACHa3pXNSB
         JLvie4OmpbM2wTZsBN7c/XN7SuzMIjkeJLtWrrMgrnwBKZypHMVzGd33VQTb4EWO+aOY
         RbMVYqHOCQY0GDSBJomnw/DPbIQzvutt5BwlDovhqaR/O1aoM708XpPdRm1OKSkOx8x9
         egrHIOvx89P/LGxKCjyO/yX3QX9llICPSe50F2UojBYsSAa67aQGo+HnSzJyE+5xp8hV
         VsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/yfiXbq7IW0jxnra/A2NFF4/0S6YyEiUxuqmCQReis=;
        b=IvCgu5cT13gdXtSh+trLNxcjJO/GD00wFs0irswWwaLQYq/t1Abgk/z3chJS07Vw+9
         TTFpwAofmYR2qB14hgm/OtAY/maTChpfj80OSShQtTp94e/HfdpHshsEC62i2fNUO8gv
         kKTQvLzkcNku2CubbChXH/z2w1fTK8VxrCBM6Pnk9Plg2K62PpQ3egifS3Y3lN4neYMf
         r+HvQXpHwIoHk3SfZRQN9MmIamhrgnW4ldw1D+AuWVEvgHiYplbH/2vloauhhTHBzQaj
         RTu0kgVxapy2nnJacsVqywU6o2R9d27sdmlH6DysnycUFyhea1nqhn/4itINBPLoGSGE
         bb8w==
X-Gm-Message-State: AFqh2koaFUfsS6ra/iJ0oCwtWVGGCLiwAEdjMcg/nYHXE5ZP9ESja7Mj
        LviWus0N+vLCON44SYqKZIk=
X-Google-Smtp-Source: AMrXdXsZSXB2srbf3gP5jEeGkjd9GSHOb4qmeprbwocmITPh70WOFL64elxBZ5onMRYk8QffTv/MPg==
X-Received: by 2002:a17:906:7f05:b0:86c:e53a:d20b with SMTP id d5-20020a1709067f0500b0086ce53ad20bmr26383286ejr.21.1674566199261;
        Tue, 24 Jan 2023 05:16:39 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id l4-20020a170906078400b008711cab8875sm872668ejc.216.2023.01.24.05.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 05:16:38 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <7b9ee972-2680-2e1b-bef3-201d8a1e4bdd@dunelm.org.uk>
Date:   Tue, 24 Jan 2023 13:16:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 5/9] rebase: add coverage of other incompatible options
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <pull.1466.v3.git.1674266126.gitgitgadget@gmail.com>
 <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
 <5e4851e611ee18112bd71939ee900e02a8d590c5.1674367961.git.gitgitgadget@gmail.com>
 <759fb313-ce88-4eb7-96c0-4adeb75ca9f9@dunelm.org.uk>
 <CABPp-BE+wRgjmWknARQpNsdUFjNOz0ND9wgx_-_RTyK+EwJjXA@mail.gmail.com>
 <83d27162-59d4-d8c0-fde3-f522630d024d@dunelm.org.uk>
In-Reply-To: <83d27162-59d4-d8c0-fde3-f522630d024d@dunelm.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>>> Signed-off-by: Elijah Newren <newren@gmail.com>
>>>> --- a/builtin/rebase.c
>>>> +++ b/builtin/rebase.c
>>>> @@ -1224,6 +1224,26 @@ int cmd_rebase(int argc, const char **argv, 
>>>> const char *prefix)
>>>>                if (options.fork_point < 0)
>>>>                        options.fork_point = 0;
>>>>        }
>>>> +     /*
>>>> +      * The apply backend does not support 
>>>> --[no-]reapply-cherry-picks.
>>>> +      * The behavior it implements by default is equivalent to
>>>> +      * --no-reapply-cherry-picks (due to passing --cherry-picks to
>>>> +      * format-patch), but --keep-base alters the upstream such 
>>>> that no
>>>> +      * cherry-picks can be found (effectively making it act like
>>>> +      * --reapply-cherry-picks).
>>>> +      *
>>>> +      * Now, if the user does specify --[no-]reapply-cherry-picks, but
>>>> +      * does so in such a way that options.reapply_cherry_picks ==
>>>> +      * keep_base, then the behavior they get will match what they
>>>> +      * expect despite options.reapply_cherry_picks being ignored.  We
>>>> +      * could just allow the flag in that case, but it seems better to
>>>> +      * just alert the user that they've specified a flag that the
>>>> +      * backend ignores.
>>>> +      */
>>>
>>> I'm a bit confused by this. --keep-base works with either
>>> --reapply-cherry-picks (which is the default if --keep-base is given) or
>>> --no-reapply-cherry-picks. Just below this hunk we have
>>>
>>>          if (options.reapply_cherry_picks < 0)
>>>                  options.reapply_cherry_picks = keep_base;
>>>
>>> So we only set options.reapply_cherry_picks to match keep_base if the
>>> user did not specify -[-no]-reapply-cherry-picks on the commandline.
>>
>> options.reapply_cherry_picks is totally ignored by the apply backend,
>> regardless of whether it's set by the user or the setup code in
>> builtin/rebase.c.  And if we have an option which is ignored, isn't it
>> nicer to provide an error message to the user if they tried to set it?
>>
>> Said another way, while users could start with these command lines:
>>
>>      (Y) git rebase --whitespace=fix
>>      (Z) git rebase --whitespace=fix --keep-base
>>
>> and modify them to include flags that would be ignored, we could allow:
>>
>>      (A) git rebase --whitespace=fix --no-reapply-cherry-picks
>>      (B) git rebase --whitespace=fix --keep-base --reapply-cherry-picks
>>
>> But we could not allow commands like
>>
>>      (C) git rebase --whitespace=fix --reapply-cherry-picks
>>      (D) git rebase --whitespace=fix --keep-base 
>> --no-reapply-cherry-picks
> 
> (C) is already an error
> (D) is currently allowed and I think works as expected (--keep-base only 
> implies --reapply-cherry-picks, the user is free to override that with 
> --no-reapply-cherry-picks) so I don't see why we'd want to make it an 
> error.
> 
>> For all four cases (A)-(D), the apply backend will ignore whatever
>> --[no-]reapply-cherry-picks flag is provided.
> 
> For (D) the flag is respected, (C) errors out, the other cases 
> correspond to the default so it's like saying
> 
>      git rebase --merge --no-reapply-cherry-picks
> 
> ignores the flag.

On reflection that is only true for (B). I agree that we should error 
out on (A) which we don't at the moment.

I'd support a change that errors out on (A) and (C) but continues to 
allow (B) and (D). I think we can do that with the diff below

Best Wishes

Phillip

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 1481c5b6a5..66aef356b8 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1230,12 +1230,6 @@ int cmd_rebase(int argc, const char **argv, const 
char *prefix)
                  if (options.fork_point < 0)
                          options.fork_point = 0;
          }
-        /*
-         * --keep-base defaults to --reapply-cherry-picks to avoid losing
-         * commits when using this option.
-         */
-        if (options.reapply_cherry_picks < 0)
-                options.reapply_cherry_picks = keep_base;

          if (options.root && options.fork_point > 0)
                  die(_("options '%s' and '%s' cannot be used 
together"), "--root", "--fork-point");
@@ -1412,11 +1406,17 @@ int cmd_rebase(int argc, const char **argv, 
const char *prefix)
          if (options.empty != EMPTY_UNSPECIFIED)
                  imply_merge(&options, "--empty");

-        /*
-         * --keep-base implements --reapply-cherry-picks by altering 
upstream so
-         * it works with both backends.
-         */
-        if (options.reapply_cherry_picks && !keep_base)
+        if (options.reapply_cherry_picks < 0)
+                /*
+                 * --keep-base defaults to --reapply-cherry-picks to
+                 * avoid losing commits when using this option.
+                 */
+                options.reapply_cherry_picks = keep_base;
+        else if (!keep_base)
+                /*
+                 * --keep-base implements --reapply-cherry-picks by
+                 * altering upstream so it works with both backends.
+                 */
                  imply_merge(&options, "--reapply-cherry-picks");

          if (gpg_sign)
