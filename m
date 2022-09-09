Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B74ECAAA1
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 22:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiIIWku (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 18:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiIIWks (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 18:40:48 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4161975381
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 15:40:45 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id t11-20020a05683014cb00b0063734a2a786so1960434otq.11
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 15:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=CVmKCJnmVCU+ltFiGPpip0tnN4g6OZ/vfRKWMw3Mz68=;
        b=Xa3zuyCiNHQPLkVYzbAuH12UI0x7zuXbTWMVE8YEUnDfb2uKJfwvGvJhizrqgFtkBJ
         x11Ai6VY6BHCL+ruMTHwCC+rWhfL+4PA21XSFxOGW3AZezmKNuPnd7OJixp4UnfgmalU
         fN/ZHUS//yk0se2HZI+ePrzJUtrxWa5CYAmSPD5Ne8MeD+YqRGe1cQ4Q7DUzT+Sgztcr
         m7yn4xM7B2Z5QkrJytlSNCGAH+tkFRvhE5CULHlhvVxGWfFbzyjqWCS/AqZGEydU4cQ2
         pej5kggSPCD0p9fC4+6ZMlFQe4EZLYc7YMe5Y79Ib2DcbaNCyxcCF32nOP1bIvA0MEZa
         U3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=CVmKCJnmVCU+ltFiGPpip0tnN4g6OZ/vfRKWMw3Mz68=;
        b=q/zJbTIxWlz9wg6yo3b+TIXVvCOEJiDhkok2qNNDjxb/yELwPCL7OuIHmaxMFG0RVz
         cIJYEegieOLcinm11uRjUeqttzGF+j6Zq1GwRA1++XfJOPIgQjriuk6IHS54NP3m1bXm
         qxYoqbTdlPWiZt395sXgjb6ELBXOt8Ue6wxF0Df4bA563RFoizk6vx2aargKrSlqhdSW
         GSTA0Af9wPeaNi6Z8wQwb+Sz8qyerprchw+djz1V48P3espVjWZ6EY4+NRM/myrgRD6M
         eZQ1Gx0IGmpsDH78Ky+00U4PEsSbsdEBjeUZj2vEPn/EbO63NKKWGmxpls1Z331GMZnE
         bLUQ==
X-Gm-Message-State: ACgBeo3rsFYDXzwES8BsGuonoLlzuQrkw7H0mnBZ9hGry7OlowQCpK/9
        0e9z8qQ9C+h3eX2gBJQhkC5TtlYK+O8=
X-Google-Smtp-Source: AA6agR7LKURcx68prONYoaTaSV6cTgbp1MbwQs5MMILQEnAHdrSuo16cjMPDL6ZkdVp/0a6A7WX+ow==
X-Received: by 2002:a9d:7984:0:b0:638:877e:5607 with SMTP id h4-20020a9d7984000000b00638877e5607mr5971098otm.258.1662763244411;
        Fri, 09 Sep 2022 15:40:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:5a60:7720:c83c:a2f4:b9ca:4098? ([2600:1700:5a60:7720:c83c:a2f4:b9ca:4098])
        by smtp.gmail.com with ESMTPSA id x28-20020a056870a79c00b00127616039e7sm1220837oao.29.2022.09.09.15.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 15:40:44 -0700 (PDT)
Message-ID: <150fabf7-0b5b-9029-0d60-f83885c0cc41@gmail.com>
Date:   Fri, 9 Sep 2022 15:40:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2] builtin/mv.c: fix possible segfault in add_slash()
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     derrickstolee@github.com, git@vger.kernel.org, peff@peff.net,
        vdye@github.com
References: <20220908230223.239970-1-shaoxuan.yuan02@gmail.com>
 <20220909194458.264735-1-shaoxuan.yuan02@gmail.com>
 <xmqqo7voiaaf.fsf@gitster.g>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
In-Reply-To: <xmqqo7voiaaf.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/9/2022 1:04 PM, Junio C Hamano wrote:
> Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> writes:
> 
>> A possible segfault was introduced in c08830de41 (mv: check if
>> <destination> is a SKIP_WORKTREE_DIR, 2022-08-09).
>>
>> When running t7001 with SANITIZE=address, problem appears when running:
>>
>> 	git mv path1/path2/ .
>> or
>> 	git mv directory ../
>> or
>> 	any <destination> that makes dest_path[0] an empty string.
>>
>> The add_slash() call could segfault when dest_path[0] is an empty string,
>> because it was accessing a null value in such case.
> 
> Terminology.  The relevant preimage is
> 
>>  	size_t len = strlen(path);
>> -	if (path[len - 1] != '/') {
> 
> An access to path[-1] is an out-of-bounds access.

Thanks for the term, new thing learned :-)

>> Change add_slash() to check the path argument is a non-empty string
>> before accessing its value. If the path is empty, return it as-is.
> 
> That is not wrong per-se, but...
> 
>> Explanation:
> 
> ... you'd need this funny label here.  If this is where your
> explanation begins, what was the reader reading before it? ;-)
> 
> The logic would flow more naturally if you added your "explanation"
> material between "what is wrong in the current code" and "what to do
> to fix it", perhaps like so:

Indeed, explanation before action sounds more reasonable.

> 	... could segfault when path argument to it is an empty
> 	string, because it makes an out-of-bounds read to decide if
> 	an extra slash '/' needs to be appended to it.
> 
> 	As add_slash() is used to make sure that a valid pathname to
> 	a file in the given directory can be made by appending a
> 	filename after the value returned from it, if path is an
> 	empty string, we want to return it as-is.  The path to a
> 	file "F" in the top-level of the working tree (i.e.
> 	path=="") is formed by appending "F" after "" (i.e. path)
> 	without any slash in between.
> 
> 	So, just like the case where a non-empty path already ends
> 	with a slash, return an empty path as-is.
> 

Thanks for the paraphrase, I put it in the v3 just sent.

>> diff --git a/builtin/mv.c b/builtin/mv.c
>> index 2d64c1e80f..3413ad1c9b 100644
>> --- a/builtin/mv.c
>> +++ b/builtin/mv.c
>> @@ -71,7 +71,7 @@ static const char **internal_prefix_pathspec(const char *prefix,
>>  static const char *add_slash(const char *path)
>>  {
>>  	size_t len = strlen(path);
>> -	if (path[len - 1] != '/') {
>> +	if (len && path[len - 1] != '/') {
>>  		char *with_slash = xmalloc(st_add(len, 2));
>>  		memcpy(with_slash, path, len);
>>  		with_slash[len++] = '/';
> 
> Yup.  It cannot be seen in the patch but the post-context of this
> hunk just returns path as-is, which is what we want to happen.

Yes.

Thanks,
Shaoxuan
