Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C94C433DF
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 14:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39C5A207E8
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 14:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="soF9ky7x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgFZOdf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 10:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgFZOde (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 10:33:34 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79534C03E979
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 07:33:34 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f7so6735071wrw.1
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 07:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0BHuWgfKRqKsk/99S7L25I69Renv9PtJxoCvtpGYwo4=;
        b=soF9ky7x30fmdXQmjPA90kIfSX2smBMYyhDFidn+wFMmBuRUWWbVwnkpMmnYBpjVp1
         PRZbLfwag2WANZAniCuVdPep5aOna41RngZpXiZxvgZhuvSq57mJtVG6w5UeFSLzRf5z
         0BteBUntmKmmm2eQ+1A9yOu+Yq8nSsY7CqCN46eTOAzN+uL59JObG0FnrHyChzGdbY3h
         Gpiob3UI7ltTFn+pyNXpSRnh4l4M+TQ8TxEotPBWzzhh/SIgGPheu1tr3R2i5WIuK39H
         mni5E9EzLb4PIWtMGc+pRhx5nljCU5Jgw4E5az+sO03bMx7llmbokPeSr7iExo8kP0iZ
         ZYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:from:to:cc:references
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0BHuWgfKRqKsk/99S7L25I69Renv9PtJxoCvtpGYwo4=;
        b=q9nFstoEMYVh72wT3Hn2fVK95QUoRZBDENNVSZZrgM7UaJ3ekf7qvlPYn2JOrGPTAa
         ZoNYPZk9Uq9kOPYYcm7uqo8qgSVS6hDvkHWYpvNnPrTbOzsZ8XS5MamDW/lKoSb4aEpE
         fWOnkrjNf9oGrrtnfo6O9jYPyF9bp5SV5C3tFFGxStdf8Hkj0Ixk0lgDYsEydBRXqfcp
         mqaQHGUjffHnUq978UitZ9uW7SNShoRUUkAimmPov4iLcVxE0er2wnGjrkFn46Jb8Cij
         nnGXBepgWomMyhiU2F1n0NLNRmcIuqfS1lgSlm0AehZ4dpn4oRvABW5nP6tClbP2QEVG
         odzg==
X-Gm-Message-State: AOAM5318xRVsejcByEY7NqlGQCX0EhVKozBzD3MZM2zEqXuSF5V6fWDT
        rb+7V8fFIDAea2HQqyT3AHs=
X-Google-Smtp-Source: ABdhPJwy4N2++imKenVRYkaCKfx/imFLUy6XUtj5V82a+lcdIeaY/M34IedlffUNtoW7MoscBBSUYA==
X-Received: by 2002:a5d:664a:: with SMTP id f10mr4120017wrw.300.1593182013257;
        Fri, 26 Jun 2020 07:33:33 -0700 (PDT)
Received: from [192.168.1.240] (226.20.198.146.dyn.plus.net. [146.198.20.226])
        by smtp.gmail.com with ESMTPSA id 12sm4552548wmg.6.2020.06.26.07.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2020 07:33:32 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH v1 02/17] merge-one-file: rewrite in C
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20200625121953.16991-1-alban.gruin@gmail.com>
 <20200625121953.16991-3-alban.gruin@gmail.com>
 <80af2da7-d943-94ef-999a-7035bbec0f0d@gmail.com>
 <32ce88bd-14ce-0cd4-b938-285a95302cae@gmail.com>
Message-ID: <1e1dfe42-ab62-103a-e213-cfa42f5d9792@gmail.com>
Date:   Fri, 26 Jun 2020 15:33:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <32ce88bd-14ce-0cd4-b938-285a95302cae@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/06/2020 19:17, Phillip Wood wrote:
> On 25/06/2020 16:16, Phillip Wood wrote:
>> Hi Alban
>>
>> I think this series is a great idea
>>
>> On 25/06/2020 13:19, Alban Gruin wrote:
>>> This rewrites `git merge-one-file' from shell to C.  This port is very
>>> straightforward: it keeps using external processes to edit the index,
>>> for instance.  Errors are also displayed with fprintf() instead of
>>> error().  Both of these will be addressed in the next few commits,
>>> leading to its libification so its main function can be used from other
>>> commands directly.
>>>
>>> This also fixes a bug present in the original script: instead of
>>> checking if a _regular_ file exists when a file exists in the branch to
>>> merge, but not in our branch, the rewritten version checks if a file of
>>> any kind (ie. a directory, ...) exists.  This fixes the tests t6035.14,
>>> where the branch to merge had a new file, `a/b', but our branch had a
>>> directory there; it should have failed because a directory exists, but
>>> it did not because there was no regular file called `a/b'.  This test is
>>> now marked as successful.
>>> [...]
>>> +static int merge_one_file(const struct object_id *orig_blob,
>>> +              const struct object_id *our_blob,
>>> +              const struct object_id *their_blob, const char *path,
>>> +              unsigned int orig_mode, unsigned int our_mode, unsigned
>>> int their_mode)
>>> +{
>>> +    if (orig_blob &&
>>> +        ((our_blob && oideq(orig_blob, our_blob)) ||
>>> +         (their_blob && oideq(orig_blob, their_blob))))
>>> +        return merge_one_file_deleted(orig_blob, our_blob,
>>> their_blob, path,
>>> +                          orig_mode, our_mode, their_mode);
>>
>> It would be nice to preserve the comments from the script as I find they
>> help a lot in understanding which case each piece of code is handling.
>> The code above appears to be handling deletions but does not appear to
>> check that one side is actually missing. Shouldn't it be something like
>>
>> if (orig_blob &&
>>      ((!their_blob && (our_blob && oideq(orig_blob, our_blob))) ||
>>       (!our_blob && (their_blob && oideq(orig_blob, their_blob))))
>>
>> Maybe this could do with a test case
> 
> The reason your version works is that if only one side has changed
> read-tree will have done the merge itself so this only gets called if
> one side has been deleted. However the original script printed an error
> if someone accidentally called when the content had changed in only one
> side and there were no mode changes. I think we want to keep that behavior.

Actually I think the original probably handles this case by calling 'git 
merge-file'

Best Wishes

Phillip

> In the future we could probably update this to also handle the cases
> that read-tree normally takes care of rather than erroring out but I
> don't think it is a high priority.
> 
> Best Wishes
> 
> Phillip
> 
