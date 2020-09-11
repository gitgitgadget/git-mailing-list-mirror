Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F32C43461
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 13:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3051620770
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 13:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWIUzaOm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgIKNW4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 09:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgIKNUY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 09:20:24 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB18CC061756
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 06:20:03 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j2so11464621wrx.7
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 06:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:reply-to:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lkzI4fmJgGLtynvKt2BccEk4/mcg0685C5iIB8etrNQ=;
        b=GWIUzaOmQHJa9RMQx7G3M+Fgl/Ex35HLuWuWpmbZD6CvsaJmKc3HiRcMiivfHHXqd6
         SdGP7YhlwEUJQcBRpKJWezTv3kZ2WRvEUtVdHsT9sRktn0s+ctHx3Yf5mF1uk0688KGV
         MsVE5RlVfZYO5qKKK7H2d+yzjYwNzaXE16+5b12wXCxSVg1Cic+7Znvk3orjgckUYdA/
         Ax6BHpXRgWtp3c8Sw7cBFrwUGeI4ehQlDC1tGPKtSKpil4+z8m8rDec1aI9Q9j77Gm0K
         qAuGDzAtc2EdG+35unp6vhN9YhfbnbSTi2OTlYh1BuchV2TmF6cKQR3iPH9OV7WDnWqT
         x13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:reply-to:references:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lkzI4fmJgGLtynvKt2BccEk4/mcg0685C5iIB8etrNQ=;
        b=BXcjQ5jVsPzx9sfAfOKIJv2KdhigMk/0woygqgLMUIWQIUmG4ToB9GWpWkaTeamUp0
         LF6+RCsHOst/Qw12FA61mpbjJ3w9eDTfL7Nf1+Pl1MC9h4SIPP4VTIBSTyQWJC0W/qy7
         +5QzZSiqiBUBd1wH+tWPDHFo2+8xoqYK9m6cHCvp08t76uckmdCXERQ/nFaQ7sAM3rhq
         pVQDjBXDczZ929Ii2vgvrZdY1mk3nSYUFTTIGyE7/xBHdFdfBCL4XJHG+XiusjXsgqQq
         6kuTwRYzg+DNHYKGQ8ZzT8uhhrV2rk3mVeFYrp/pIXWJzw/JjH+4gqJQ4f184Ajvu8OS
         Je1Q==
X-Gm-Message-State: AOAM530Vu6tdivZ55SRiYqn6dnlifPCFXP51INjvSURI79OQdRIQDE4+
        EjNR9OCwFS/nMgcaNqAyVtmEWA/q9vA=
X-Google-Smtp-Source: ABdhPJxBt+Tq/9LP9mXuNVYIXSeQkS0kZ+fI+RHuDWuW0IgF8cWxga1WcajVbIlm2uzG5hksVmdT9Q==
X-Received: by 2002:adf:dd0b:: with SMTP id a11mr2021842wrm.422.1599830402004;
        Fri, 11 Sep 2020 06:20:02 -0700 (PDT)
Received: from [192.168.1.201] (151.252.189.80.dyn.plus.net. [80.189.252.151])
        by smtp.googlemail.com with ESMTPSA id h5sm5321793wrc.45.2020.09.11.06.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 06:20:01 -0700 (PDT)
Subject: Re: [PATCH v4 9/9] run_commit_hook: take strvec instead of varargs
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Reply-To: phillip.wood@dunelm.org.uk
References: <20200909004939.1942347-1-emilyshaffer@google.com>
 <20200909004939.1942347-10-emilyshaffer@google.com>
 <6ed77ee3-4d75-9ef9-0621-13a056e8ca14@gmail.com>
Message-ID: <753f9bef-29ae-88b7-336e-fd799ffd1e9a@gmail.com>
Date:   Fri, 11 Sep 2020 14:20:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <6ed77ee3-4d75-9ef9-0621-13a056e8ca14@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/09/2020 15:16, Phillip Wood wrote:
> Hi Emily
> 
> On 09/09/2020 01:49, Emily Shaffer wrote:
>> Taking varargs in run_commit_hook() led to some bizarre patterns, like
>> callers using two string variables (which may or may not be filled) to
>> express different argument lists for the commit hooks. Because
>> run_commit_hook() no longer needs to call a variadic function for the
>> hook run itself, we can use strvec to make the calling code more
>> conventional.
>>
>> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
>> ---
>>   builtin/commit.c | 46 +++++++++++++++++++++++-----------------------
>>   builtin/merge.c  | 20 ++++++++++++++++----
>>   commit.c         | 13 ++-----------
>>   commit.h         |  5 +++--
>>   sequencer.c      | 15 ++++++++-------
>>   5 files changed, 52 insertions(+), 47 deletions(-)
>>
>> diff --git a/builtin/commit.c b/builtin/commit.c
>> index a19c6478eb..f029d4f5ac 100644
>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -691,8 +691,7 @@ static int prepare_to_commit(const char 
>> *index_file, const char *prefix,
>>       struct strbuf committer_ident = STRBUF_INIT;
>>       int committable;
>>       struct strbuf sb = STRBUF_INIT;
>> -    const char *hook_arg1 = NULL;
>> -    const char *hook_arg2 = NULL;
>> +    struct strvec hook_args = STRVEC_INIT;
>>       int clean_message_contents = (cleanup_mode != 
>> COMMIT_MSG_CLEANUP_NONE);
>>       int old_display_comment_prefix;
>>       int merge_contains_scissors = 0;
>> @@ -700,7 +699,8 @@ static int prepare_to_commit(const char 
>> *index_file, const char *prefix,
>>       /* This checks and barfs if author is badly specified */
>>       determine_author_info(author_ident);
>> -    if (!no_verify && run_commit_hook(use_editor, index_file, 
>> "pre-commit", NULL))
>> +    if (!no_verify && run_commit_hook(use_editor, index_file, 
>> "pre-commit",
>> +                      &hook_args))
>>           return 0;
>>       if (squash_message) {
>> @@ -722,27 +722,28 @@ static int prepare_to_commit(const char 
>> *index_file, const char *prefix,
>>           }
>>       }
>> +    strvec_push(&hook_args, git_path_commit_editmsg());
> 
> This is a long way from the call where we use hook_args. With the 
> variadic interface it is clear by looking at the call to 
> run_commit_hook() what the first argument is and that is always the same.
> 
>>       if (have_option_m && !fixup_message) {
>>           strbuf_addbuf(&sb, &message);
>> -        hook_arg1 = "message";
>> +        strvec_push(&hook_args, "message");
>>       } else if (logfile && !strcmp(logfile, "-")) {
>>           if (isatty(0))
>>               fprintf(stderr, _("(reading log message from standard 
>> input)\n"));
>>           if (strbuf_read(&sb, 0, 0) < 0)
>>               die_errno(_("could not read log from standard input"));
>> -        hook_arg1 = "message";
>> +        strvec_push(&hook_args, "message");
>>       } else if (logfile) {
>>           if (strbuf_read_file(&sb, logfile, 0) < 0)
>>               die_errno(_("could not read log file '%s'"),
>>                     logfile);
>> -        hook_arg1 = "message";
>> +        strvec_push(&hook_args, "message");
>>       } else if (use_message) {
>>           char *buffer;
>>           buffer = strstr(use_message_buffer, "\n\n");
>>           if (buffer)
>>               strbuf_addstr(&sb, skip_blank_lines(buffer + 2));
>> -        hook_arg1 = "commit";
>> -        hook_arg2 = use_message;
>> +        strvec_pushl(&hook_args, "commit", use_message, NULL);
>>       } else if (fixup_message) {
>>           struct pretty_print_context ctx = {0};
>>           struct commit *commit;
>> @@ -754,7 +755,7 @@ static int prepare_to_commit(const char 
>> *index_file, const char *prefix,
>>                         &sb, &ctx);
>>           if (have_option_m)
>>               strbuf_addbuf(&sb, &message);
>> -        hook_arg1 = "message";
>> +        strvec_push(&hook_args, "message");
>>       } else if (!stat(git_path_merge_msg(the_repository), &statbuf)) {
>>           size_t merge_msg_start;
>> @@ -765,9 +766,9 @@ static int prepare_to_commit(const char 
>> *index_file, const char *prefix,
>>           if (!stat(git_path_squash_msg(the_repository), &statbuf)) {
>>               if (strbuf_read_file(&sb, 
>> git_path_squash_msg(the_repository), 0) < 0)
>>                   die_errno(_("could not read SQUASH_MSG"));
>> -            hook_arg1 = "squash";
>> +            strvec_push(&hook_args, "squash");
>>           } else
>> -            hook_arg1 = "merge";
>> +            strvec_push(&hook_args, "merge");
>>           merge_msg_start = sb.len;
>>           if (strbuf_read_file(&sb, 
>> git_path_merge_msg(the_repository), 0) < 0)
>> @@ -781,11 +782,11 @@ static int prepare_to_commit(const char 
>> *index_file, const char *prefix,
>>       } else if (!stat(git_path_squash_msg(the_repository), &statbuf)) {
>>           if (strbuf_read_file(&sb, 
>> git_path_squash_msg(the_repository), 0) < 0)
>>               die_errno(_("could not read SQUASH_MSG"));
>> -        hook_arg1 = "squash";
>> +        strvec_push(&hook_args, "squash");
>>       } else if (template_file) {
>>           if (strbuf_read_file(&sb, template_file, 0) < 0)
>>               die_errno(_("could not read '%s'"), template_file);
>> -        hook_arg1 = "template";
>> +        strvec_push(&hook_args, "template");
>>           clean_message_contents = 0;
>>       }
>> @@ -794,11 +795,9 @@ static int prepare_to_commit(const char 
>> *index_file, const char *prefix,
>>        * just set the argument(s) to the prepare-commit-msg hook.
>>        */
>>       else if (whence == FROM_MERGE)
>> -        hook_arg1 = "merge";
>> -    else if (is_from_cherry_pick(whence) || whence == 
>> FROM_REBASE_PICK) {
>> -        hook_arg1 = "commit";
>> -        hook_arg2 = "CHERRY_PICK_HEAD";
>> -    }
>> +        strvec_push(&hook_args, "merge");
>> +    else if (is_from_cherry_pick(whence) || whence == FROM_REBASE_PICK)
>> +        strvec_pushl(&hook_args, "commit", "CHERRY_PICK_HEAD", NULL);
>>       if (squash_message) {
>>           /*
>> @@ -806,8 +805,8 @@ static int prepare_to_commit(const char 
>> *index_file, const char *prefix,
>>            * then we're possibly hijacking other commit log options.
>>            * Reset the hook args to tell the real story.
>>            */
>> -        hook_arg1 = "message";
>> -        hook_arg2 = "";
>> +        strvec_clear(&hook_args);
>> +        strvec_pushl(&hook_args, git_path_commit_editmsg(), 
>> "message", NULL);
> 
> It's a shame we have to clear the strvec and remember to re-add 
> git_path_commit_editmsg() here.
> 
>>       }
>>       s->fp = fopen_for_writing(git_path_commit_editmsg());
>> @@ -1001,8 +1000,7 @@ static int prepare_to_commit(const char 
>> *index_file, const char *prefix,
>>           return 0;
>>       }
>> -    if (run_commit_hook(use_editor, index_file, "prepare-commit-msg",
>> -                git_path_commit_editmsg(), hook_arg1, hook_arg2, NULL))
>> +    if (run_commit_hook(use_editor, index_file, "prepare-commit-msg", 
>> &hook_args))
>>           return 0;
>>       if (use_editor) {
>> @@ -1017,8 +1015,10 @@ static int prepare_to_commit(const char 
>> *index_file, const char *prefix,
>>           strvec_clear(&env);
>>       }
>> +    strvec_clear(&hook_args);
>> +    strvec_push(&hook_args, git_path_commit_editmsg());
>>       if (!no_verify &&
>> -        run_commit_hook(use_editor, index_file, "commit-msg", 
>> git_path_commit_editmsg(), NULL)) {
>> +        run_commit_hook(use_editor, index_file, "commit-msg", 
>> &hook_args)) {
>>           return 0;
>>       }
 >[...]
> 
> I don't have a strong opinion about these changes (though I'm not 
> particularly enthusiastic). Having to push the arguments in order is not 
> particularly convenient and the use of strvec_pushl() means we are 
> replacing a small number of variadic calls to run_commit_hook() with a 
> larger number of calls to a different variadic interface.

On reflection I think it is the conversion in builtin/commit.c rather 
than the change in the API that makes me uncomfortable. If it kept 
`hook_arg1` and `hook_arg2` and just did

strvec_push(&hook_args, git_path_commit_editmsg())\
strvec_push(&hook_args, hook_arg1);
if (hook_arg2)
	strvec_push(&hook_args, hook_arg2);
run_commit_hook(..., &hook_args);

It would keep the fixed first argument near the call to 
run_commit_hook() and avoid the problem of having to clear hook_args in 
the hunk at line 806.

Thank you for adding the last couple of patches that show an example 
conversion, it is really helpful to see how the API would be used.

Best Wishes

Phillip

> Best Wishes
> 
> Phillip
> 
>>       } else {
>> -        arg1 = "message";
>> +        strvec_push(&args, "message");
>>       }
>> -    if (run_commit_hook(0, r->index_file, "prepare-commit-msg", name,
>> -                arg1, arg2, NULL))
>> +    if (run_commit_hook(0, r->index_file, "prepare-commit-msg", &args))
>>           ret = error(_("'prepare-commit-msg' hook failed"));
>> +    strvec_clear(&args);
>>       return ret;
>>   }
>>

