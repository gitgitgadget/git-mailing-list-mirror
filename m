Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25446207EC
	for <e@80x24.org>; Thu, 22 Sep 2016 10:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756487AbcIVKGo (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 06:06:44 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:34058 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753004AbcIVKGn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 06:06:43 -0400
Received: by mail-io0-f175.google.com with SMTP id q92so80626928ioi.1
        for <git@vger.kernel.org>; Thu, 22 Sep 2016 03:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AUDd/vAIErsh/6bovd2prWWjZ7FLTHcZZRqZv14/evg=;
        b=Y4O/RumOyzt9PmYKCspV7c8ASX5XAnMFM8kBb3yX07KQXYiQLEp4XYVvv98LUvOgDZ
         6vy1nCMsez0PL0srXhYTKr4mxh+tdLGW5lpWvfOiCHyYjYET/wcHbc4g7fFFlxCIeUN+
         S6dhEXLKgPj+JnHM2xU0Y1K2Ize6nC94LFcH6V7Un7b+xI8XiVeRM8Siy6p9CBw5bEUg
         r0qxeerJa7xuueMBcyL+D9qiUhClqMPtj8cZ5X1ByTKo3SfMpG08AqzkT+XXigRnp/1r
         XenJVpqjixTTXBmytPHunigQC2x58iX0Ee4tIV8CeGzJot7omCMu1aRlb7gJRKqefOD0
         YEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AUDd/vAIErsh/6bovd2prWWjZ7FLTHcZZRqZv14/evg=;
        b=AIbYtJLFPaUNzX6h4K5uA/6JP8fkVnIHWjIMPbGJXx9QH9DSaA7e9GLZ7fVtxPl2eU
         HwUAVOp1fhGsKo+9H0VaCcEAGPCCeMZnfbYDhE7fVUuaEFbzAG+dUG0pewGFMyulgsfV
         +FOwY5sPulT943Y8CkfxtrPOjFK8FBqxprv+YLf7nYQaEiox5KIKD+ZBm8kvSl8oS71E
         vnhqZ+GNBcori1NhtyBmAfQH17ZslhcXDA9pxEiSBNFpEddZjkTF4ieTb3NtcW8Og7No
         Lh9Mq7wsf5RxMn/lh+yCihFwAYMethIo5/AeIWW3Cb0i4pqDuiQdAKyuzHUowPxSU1Jl
         0Mgg==
X-Gm-Message-State: AE9vXwNgyt7rCxzw8DhetOFJFZ92DL6mf/+LTni49gaeusOCZW7UEfakK6lJCZfihitXm0N1jMQOIJcztMPEbA==
X-Received: by 10.107.171.133 with SMTP id u127mr1996317ioe.102.1474538802503;
 Thu, 22 Sep 2016 03:06:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.21.6 with HTTP; Thu, 22 Sep 2016 03:06:11 -0700 (PDT)
In-Reply-To: <xmqqd1jx854z.fsf@gitster.mtv.corp.google.com>
References: <20160908134719.27955-1-pclouds@gmail.com> <20160921112939.3444-1-pclouds@gmail.com>
 <20160921112939.3444-3-pclouds@gmail.com> <xmqqd1jx854z.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 22 Sep 2016 17:06:11 +0700
Message-ID: <CACsJy8BQvo_XSXZ3m8=A=0tik3qPd8k9cyC4G408JK+AhtYStQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] init: do not set core.worktree more often than necessary
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Max Nordlund <max.nordlund@sqore.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 22, 2016 at 1:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> @@ -314,6 +315,8 @@ static void create_object_directory(void)
>>  int set_git_dir_init(const char *git_dir, const char *real_git_dir,
>>                    int exist_ok)
>>  {
>> +     original_git_dir = xstrdup(real_path(git_dir));
>> +
>>       if (real_git_dir) {
>>               struct stat st;
>
> The function being extern bothers me.  The create_default_files()
> function, which is the only thing consumes this variable, is called
> only from init_db(), and I'd prefer to see some way to guarantee
> that everybody who calls init_db() calls set_git_dir_init()
> beforehand.  Right now, cmd_init_db() and cmd_clone() are the only
> ones that call init_db() and they both call set_dir_git_init(); if a
> new caller starts calling init_db() and forgets to call the other
> one, that caller will be buggy.
>
> Perhaps a comment before init_db() to tell callers to always call
> the other one is the least thing necessary?

Good thinking. We could go a step further, baking it as assert() to
catch new/incorrect call sequences automatically.

Or we could combine the two functions init_db() and set_git_dir_init()
into one. I prefer this one, but having problem with finding a good
name for it because the new function would prepare $GIT_DIR for the
entire process and init the repository. Maybe enter_and_init_db(),
enter_and_init_repo()? If no good name is found, I'll go back to
either adding comment or assert().
-- 
Duy
