Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E9AC001B0
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 10:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbjGXKIk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 06:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbjGXKID (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 06:08:03 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607F74EC1
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 03:00:36 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fba8e2aa52so39522695e9.1
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 03:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690192792; x=1690797592;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=77E+GYu7NhNNYACI9+hSFJKjLEfmt6PZMO2zb2kVc1A=;
        b=c3tlxNI2KJWmtU6hqjTUtCqwMZ0HMHEbuOcSyw7EFeqXqrM99EPUVotF1bO3ieUgil
         2LlrTazT6PSONePuZezLE7SugNOkKdBHLC7tk1iEFr/I5Bnf2l5HULBmhliPhyKjck3s
         yC0ejZO8NqR0RSJDwLRd4i7nCjjEiPQpbrZkIH8+RBb/4FlFcfjq9uRJX5cABj2zmJ4M
         Jle5pHc/a68Dh96XI0h2fxrYFIcHITxFq4ALB9/06PrdAmzFZZ2FJJKcZBe6GK0nlWUE
         VWEaHbl+HYZLEptr+WtxaMBMoz4N2PQLP33xAW7sZ9KU/pJI0t0NceaSW/jaM3pqLzZ2
         qAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690192792; x=1690797592;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=77E+GYu7NhNNYACI9+hSFJKjLEfmt6PZMO2zb2kVc1A=;
        b=c609fyOSKzDUMOv6lLqjJkw4Sg+cqaYhySzjMdNMaMVobd7uxXL4ar1Opajb7IPhYZ
         2JQ1ndK7GP6EeZbmRcM/dkHa/SMuVrzGFt7hZqb/TYEg0fW3tkrtE840wI0P2Nl26O+A
         k2jfhz63fIdI1XdyXbr4RFMuBNUGUsJ8+yyrP3w+6hHJP1KYXpzBCtGheb6YsMqJCcz4
         oVXDb7DLiwOjMFlZ+1RFjxnn/9ple0nVgLaFvdgmxn9OlH0IPtqxJwzj4S/PPDed1Wa1
         QBspsTs0znwYttDzdMRVS0keV4/B3oplWT7RN9A1ZqGvRaOK6Wb+pf5DilWrhASMuf7e
         u7LQ==
X-Gm-Message-State: ABy/qLZOeQIC8Q89miB7Bx6N5AOvViJgUNAqke7oDbVoYK+4GnCU3yRu
        7NachpXyy1+X7UzcWp3GEgQ=
X-Google-Smtp-Source: APBJJlFb9CCWvMc9NuLeYdun6ADAvdy3X8w2FS6cXohPlvoZB9PChvG+L2LboJ/HNw+6KT19iwq2Hg==
X-Received: by 2002:a1c:7710:0:b0:3fd:129d:b721 with SMTP id t16-20020a1c7710000000b003fd129db721mr7095579wmi.16.1690192792236;
        Mon, 24 Jul 2023 02:59:52 -0700 (PDT)
Received: from [192.168.1.195] ([90.242.235.211])
        by smtp.googlemail.com with ESMTPSA id d11-20020a1c730b000000b003fc00892c13sm9679696wmb.35.2023.07.24.02.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 02:59:51 -0700 (PDT)
Message-ID: <6dbd02ca-9587-f797-f2d3-035fc2d9efc0@gmail.com>
Date:   Mon, 24 Jul 2023 10:59:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Lost files after git stash && git stash pop
Content-Language: en-US
To:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        phillip.wood@dunelm.org.uk
Cc:     Till Friebe <friebetill@gmail.com>, git@vger.kernel.org
References: <5260C6A0-C53C-4F6D-B899-6AD8601F8458@gmail.com>
 <20230722214433.3xfoebf7my5wsihf@tb-raspi4>
 <a373a659-a232-77cb-a177-a517b1f228f4@gmail.com>
 <20230723205239.5snlakmd5ocy67q2@tb-raspi4>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230723205239.5snlakmd5ocy67q2@tb-raspi4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Torsten

On 23/07/2023 21:52, Torsten Bögershausen wrote:
>> I think whenever git overwrites an untracked file without the user passing
>> some option indicating that they want to do so it is a bug.
> 
> OK, agreed after reading the next sentence.
> 
>> For example "git
>> checkout" refuses to overwrite untracked files by default. Sadly this seems
>> to be a known bug in do_push_stash() where we are using "git reset --hard"
>> to remove the stashed changes from the working copy. This was documented in
>> 94b7f1563a (Comment important codepaths regarding nuking untracked
>> files/dirs, 2021-09-27). The stash implementation does a lot of necessary
>> forking of subprocesses, in this case I think it would be better to call
>> unpack_trees() directly with UNPACK_RESET_PROTECT_UNTRACKED.
> 
> Thanks for the fast response.
> 
> This is not an area of Git, where I have much understanding of the code.
> But is seems as if pop_stash() in builtin/stash.c
> (and the called functions) seems to be the problem here ?

Confusingly it is creating the stash that deletes the untracked file because
it recreates README/README. do_push_stash() in builtin/stash.c is the culprit
I think. I had hoped the diff below would fix the problem but it does not
seem to and breaks half a dozen test cases that seem to rely on removing
untracked files. Unfortunately I don't really have time to dig any
further at the moment.

Best Wishes

Phillip


diff --git a/builtin/stash.c b/builtin/stash.c
index fe64cde9ce3..c8bbfe56d26 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -29,6 +29,8 @@
  #include "exec-cmd.h"
  #include "reflog.h"
  #include "add-interactive.h"
+#include "reset.h"
+#include "submodule.h"
  
  #define INCLUDE_ALL_FILES 2
  
@@ -336,7 +338,7 @@ static int apply_cached(struct strbuf *out)
         return pipe_command(&cp, out->buf, out->len, NULL, 0, NULL, 0);
  }
  
-static int reset_head(void)
+static int stash_reset_head(void)
  {
         struct child_process cp = CHILD_PROCESS_INIT;
  
@@ -569,7 +571,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
                                                 get_index_file(), 0, NULL))
                                 return error(_("could not save index tree"));
  
-                       reset_head();
+                       stash_reset_head();
                         discard_index(&the_index);
                         repo_read_index(the_repository);
                 }
@@ -1649,12 +1651,14 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
                                 goto done;
                         }
                 } else {
-                       struct child_process cp = CHILD_PROCESS_INIT;
-                       cp.git_cmd = 1;
-                       /* BUG: this nukes untracked files in the way */
-                       strvec_pushl(&cp.args, "reset", "--hard", "-q",
-                                    "--no-recurse-submodules", NULL);
-                       if (run_command(&cp)) {
+                       struct reset_head_opts opts = {
+                               .flags = RESET_HEAD_HARD,
+                       };
+
+                       if (should_update_submodules())
+                               BUG("stash should not update submodules");
+
+                       if (reset_head(the_repository, &opts)) {
                                 ret = -1;
                                 goto done;
                         }

