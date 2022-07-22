Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B8CCCA47F
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 12:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbiGVMsQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 08:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235031AbiGVMsO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 08:48:14 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFF29A5FD
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 05:48:13 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id o1so3468336qkg.9
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 05:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1GBpj1sYsOz6J8JYfaY/SSfrM64y2+CbmBooXmDeuns=;
        b=argBbLJUd2iWQKVq6F0cWMLUrXB3bXfDPX07bIH384VvesUTqxynoK4+k4pOwXcZmI
         mREZv0P5wWV3e22ti5ERsAopyI54nR2KDOya2fEh7JpBSUfqrNtYaVVkJ4uwbt2+iB+g
         6Z2NPE8SLOJOfMvrpC21gBQBwuahmp8n60IqECE0qnDbGNmQPLMeazz24K0uYZxn/DEX
         jH//m4LpB5PkxDkLLN3mxChCziP+6Pp1JU88ghCdTMCl22mrkv9fvHfXxaNTiv5mgMOw
         dTXT9+aIt58fNbIrHqGmBTl0IvI9pfup9LQw7R52YdHZ/OjsE5U4rLVmkbdtLBvfdajb
         OgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1GBpj1sYsOz6J8JYfaY/SSfrM64y2+CbmBooXmDeuns=;
        b=0iCLTQ+G31ovP1yDG/mv/rjbJpBT+A8ufd1ayo1EQoGdnPmIQxZoyjZtrpEdZ1J3lL
         7Pl23RaFflWPriYvc/WL3800fnvYOMg3NWW8L6bShb6fd1/7Xkg2le6/JdjjVS5dgZJu
         fRHPdVAv/JvxSjzMN5pOIkDH7EBCyJDEhfc5ukz2sXd7vzOR2w4xon/G8tssWq1UCSb5
         MUJyzZcz/t59/lY1Cr6cEFyei3Thgs/RnXsHa2VvUujm//b5NyuY0e3ZdmzobWu7ASqY
         pnLY++QTgyeRDWgSOVn8uzowGY/9fmDToxR8yzLNk1VpYdrF8H/KywROGYL3Pgi5w7DO
         t3mA==
X-Gm-Message-State: AJIora8C5nW7vbDILdzmNrfcwXCsdN7+SPXLoLgjVSQSpeiG4nr+f0Kd
        f5nwvYxWsuoFuk3Vm5G2t2kR
X-Google-Smtp-Source: AGRyM1t5PkyIXBFsi4KMiQbypNJVw8oXBh+b1Jo53+vE8XHLDVQptQWisGd/UB6wqns3TQEghZiSgw==
X-Received: by 2002:a05:620a:1707:b0:6b5:f93a:ee54 with SMTP id az7-20020a05620a170700b006b5f93aee54mr397331qkb.158.1658494092164;
        Fri, 22 Jul 2022 05:48:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:89e1:7440:c819:d192? ([2600:1700:e72:80a0:89e1:7440:c819:d192])
        by smtp.gmail.com with ESMTPSA id j16-20020a05620a289000b006b5763bffebsm3301164qkp.34.2022.07.22.05.48.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 05:48:11 -0700 (PDT)
Message-ID: <25ca0c62-e3b4-e96a-4c44-285bcfef2143@github.com>
Date:   Fri, 22 Jul 2022 08:48:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 4/7] mv: check if <destination> is a SKIP_WORKTREE_DIR
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     vdye@github.com, gitster@pobox.com, git@vger.kernel.org
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220719132809.409247-5-shaoxuan.yuan02@gmail.com>
 <95263c88-6894-87bb-4d52-84d8d1cc5671@github.com>
 <ab96cbe0-f256-ea5e-8356-db11d2b773f4@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <ab96cbe0-f256-ea5e-8356-db11d2b773f4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/21/2022 10:13 AM, Shaoxuan Yuan wrote:
> On 7/20/2022 1:59 AM, Derrick Stolee wrote:
>> On 7/19/2022 9:28 AM, Shaoxuan Yuan wrote:
>>> Also add a `dst_w_slash` to reuse the result from `add_slash()`, which
>>> was everywhere and can be simplified.
>>
>>>      else if (!lstat(dest_path[0], &st) &&
>>>              S_ISDIR(st.st_mode)) {
>>> -        dest_path[0] = add_slash(dest_path[0]);
>>> -        destination = internal_prefix_pathspec(dest_path[0], argv, argc, DUP_BASENAME);
>>> +        destination = internal_prefix_pathspec(dst_w_slash, argv, argc, DUP_BASENAME);
>>
>> Hm. I find it interesting how this works even if the directory is _not_
>> present in the index. Is there a test that checks this kind of setup?
>>
>>     git init &&
>>     >file &&
>>     git add file &&
>>     git commit -m init &&
>>     mkdir dir &&
>>     git mv file dir/
>>
>> Locally, this indeed works with the following 'git status' detail:
>>
>>         renamed:    file -> dir/file
> 
> In my impression, 'git-mv' does not seem to care about whether the
> <destination> directory is in index? Given that `rename()` works so
> long as the directory is in the working tree, and `rename_index_entry_at()`
> cares even less about the <destination> dir?

Right. Instead of changing the behavior, I'm asking you to double-check that
this behavior is tested. If not, then please add a test.

>>> +    if (dst_w_slash != dest_path[0])
>>> +        free((char *)dst_w_slash);
>>
>> Good that you are freeing this here. You might also want to set it to NULL
>> just in case.
> 
> I was using the `FREE_AND_NULL()` macro, but I wasn't sure since other
> places in 'git-mv' only use `free()`. Though I think it is better to
> `FREE_AND_NULL()`.

free() is generally the way to go if it is clear that the variable
is about to go out-of-scope and could not possibly be referenced
again. Since there is a lot more of the current code block to go,
nulling the variable is good defensive programming.

Thanks,
-Stolee
