Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D28C25B0E
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 17:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236729AbiHPRDg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 13:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236723AbiHPRDd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 13:03:33 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA60E2B637
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 10:03:30 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id p12-20020a7bcc8c000000b003a5360f218fso9716722wma.3
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 10:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=WYNFAwVtbZVB4KHERwgr3uO4HaeapOU5K5Mn5/ASilA=;
        b=o900ij/gAVr7Q00oojVwMv98ED6pgan9SZ4ck2O/xoInYSL96AFiFh4TDW0iPemDUd
         +OOmRnvtf1e1ZJtFGp3jfK4QptdQeka8o8PdEkaWRqkNoDOHBrYeFKdoc6eNnQmr3xRn
         4mTZL0Fng9FNTnkFLFABbJT4bUk1j8jTk/UfLuwPi0aFdMq3zdmF3AxUDuWxtnQjr6sn
         dwigHfuwcPKdUyn+b1r9mVrs8GlxmT1pOk16bkoYtclEAWZ4nsE/rSJwx78PsFxxBWcb
         Wv4s4uxjt73WccRNDajp0ZU2jRUC/0P2jsMwugXfj459e7m7UcGRv05OGybglg281JmM
         L1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=WYNFAwVtbZVB4KHERwgr3uO4HaeapOU5K5Mn5/ASilA=;
        b=eKLgtgsnyy+2VEN8L/gDE6dud1Jxw9cRZIOhby6712xz/7FoI4G8+ilpyVJJYPql5F
         eE3l1XF3HtBVopT/TgmUf3dMXJb5hoda3RGUo7DG2OnYEvmBPLQxWK11gKJnuAQxyGIH
         V+gVVNzLNLqJjosdolcDh6sf5Cv70JnJwExXGgdknDEzdRyxWhSW2RpU2PvMDV4fi/9s
         Udh3tgda+5ALh9jh5WJnwhNWoQCEan0JVNHdl/OO5XaHyqbrIv08M2uZe5at4aZVOj7q
         loec1BmhNQLYWdjI6dp9t7xwoh2SnTljB5wVC+KM0/fBpfkxRN0A/MbDefQnca6Gaz0d
         hoJQ==
X-Gm-Message-State: ACgBeo3wKG5+en9xToXepshp4WVHb/lS7h02hHU8LDUMuMS8FK0Rjisb
        /iVzw5GKj11yxqgTxw04JPIcEax3myJZUQ==
X-Google-Smtp-Source: AA6agR6lEB8TJ+stj+aPiNuPoNjh76Al9XeOJ6WZ0QwN/bPUydg7M8j0jXg7AOCsxGPtwvN+p30jBA==
X-Received: by 2002:a7b:cd01:0:b0:3a5:3a71:86ff with SMTP id f1-20020a7bcd01000000b003a53a7186ffmr13855681wmj.43.1660669409285;
        Tue, 16 Aug 2022 10:03:29 -0700 (PDT)
Received: from [192.168.2.52] (68.83-213-117.dynamic.clientes.euskaltel.es. [83.213.117.68])
        by smtp.gmail.com with ESMTPSA id q29-20020adfab1d000000b002206ba7430bsm9467655wrc.15.2022.08.16.10.03.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 10:03:28 -0700 (PDT)
Subject: Re: [PATCH] branch: allow "-" as a short-hand for "previous branch"
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Rub=c3=a9n_Justo_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.1315.git.1659910949556.gitgitgadget@gmail.com>
 <xmqq4jymvllq.fsf@gitster.g> <9693b83f-551e-e579-b267-af1d633dc381@gmail.com>
 <9so90892-25nr-0s4o-q98n-2qo76r3s89p3@tzk.qr>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <986564d9-4d49-b1ef-e2e0-65d6f67f9e79@gmail.com>
Date:   Tue, 16 Aug 2022 19:03:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <9so90892-25nr-0s4o-q98n-2qo76r3s89p3@tzk.qr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On 8/16/22 11:31 AM, Johannes Schindelin wrote:

>> $ git merge - old-branch
>> merge: - - not something we can merge
> 
> This is confusing me: how is the patch supporting `git branch -d -`
> aligned with the presented `git merge` invocations?

"merge" supports multiple objects to be specified, but "-" only is 
accepted if just one argument is specified, as Junio did it in:

commit 4e8115fff135a09f75020083f51722e7e35eb6e9
Author: Junio C Hamano <gitster@pobox.com>
Date:   Thu Apr 7 15:57:57 2011 -0700

     merge: allow "-" as a short-hand for "previous branch"

     Just like "git checkout -" is a short-hand for "git checkout @{-1}" to
     conveniently switch back to the previous branch, "git merge -" is a
     short-hand for "git merge @{-1}" to conveniently merge the previous 
branch.

     It will allow me to say:

         $ git checkout -b au/topic
         $ git am -s ./+au-topic.mbox
         $ git checkout pu
         $ git merge -

     which is an extremely typical and repetitive operation during my 
git day.

     Signed-off-by: Junio C Hamano <gitster@pobox.com>

diff --git a/builtin/merge.c b/builtin/merge.c
index d54e7ddbb1..0bdd19a137 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1062,9 +1062,12 @@ int cmd_merge(int argc, const char **argv, const 
char *prefix)
         if (!allow_fast_forward && fast_forward_only)
                 die(_("You cannot combine --no-ff with --ff-only."));

-       if (!argc && !abort_current_merge && default_to_upstream)
-               argc = setup_with_upstream(&argv);
-
+       if (!abort_current_merge) {
+               if (!argc && default_to_upstream)
+                       argc = setup_with_upstream(&argv);
+               else if (argc == 1 && !strcmp(argv[0], "-"))
+                       argv[0] = "@{-1}";
+       }
         if (!argc)
                 usage_with_options(builtin_merge_usage,
                         builtin_merge_options);



So I aligned "branch -d" (or "delete-branch") with that.

The other two commands that already support "-", also works the same way:

$ git checkout -B - default
fatal: '-' is not a valid branch name

$ git rebase default -
fatal: no such branch/commit '-'

To summarize, my goal is to allow:

$ git checkout work_to_review
$ git checkout -
$ git merge - # or git rebase -
$ git branch -d -

Makes sense to me...

I've updated the commit message with a more specific message and removed 
the braces, jic.
