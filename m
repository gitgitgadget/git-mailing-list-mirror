Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8560C4332F
	for <git@archiver.kernel.org>; Sun, 13 Nov 2022 21:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbiKMV1Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Nov 2022 16:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbiKMV1J (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Nov 2022 16:27:09 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931F9B7C2
        for <git@vger.kernel.org>; Sun, 13 Nov 2022 13:26:58 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id g24so8450935plq.3
        for <git@vger.kernel.org>; Sun, 13 Nov 2022 13:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/v2lpeU83pG5fRM8/0seH+O9QHRrskZvCRLrX935RfE=;
        b=IccAdCSv/nNXw5QOgjV6XCnRIX1Zdbl9rjJVn381xpxJhD1+fYWODE3EDcaIim2XXz
         04JazD4q6gV/qTyI5hszUmU37ZioW/EcqHcjFvAtDxTEyb9TOYRNvFxNDKoiVVL2V/Qj
         MjrYczBmX/7CR4VoBu8cEWgjx1xPuiB1+5rmM0tJNAa9PHLHBTTop1N/PauVdTKbun+l
         wAT1VAWbHTCAm/34w3YErbuzyfqjqvjLAaNYtp1W2HnK0uKggFX03n1X2GpcfLBXYvCM
         4NnN0NmYSmYPXUn7POTdfqfah764Oan+i1/YUSfDfhOqYC402FEiNCBDUDtHovId81Pb
         zV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/v2lpeU83pG5fRM8/0seH+O9QHRrskZvCRLrX935RfE=;
        b=UgjDl0M9cR3NRJi7QwJPC3ZeokUOARfWJPW3WyIfqQFb1v7eqLOY5FMQmFCJArfvPt
         j345RwGPYRr9efM+vnkcPeqzCfK7BJuyCSwzQez2M01WzmlRAv7/tso8E0q1EBIViF8B
         KjS4yilG4ajjObLU5RAIMZuTmMLPs5rpToWJ9mtJIseOIRPwWqDsNqAp+wAP6W1t2Ngg
         Gvs0xdiD7Pc93jE8FT/4iAzPOuZVpFA2VLAC/0+DIXwA59yNAvY7p/LnNb/YV+xekaET
         qe9sIO4BwO8Nr96o0svhoflWneBx/W1vlmRZpapvPBw2cjFN5oCYRFexxmecczqbI5vn
         8yRQ==
X-Gm-Message-State: ANoB5pkrhHYh/sWBAVUsFvavf98ICIQoSdXAzbKodkWqdDVAdrRolKqN
        9LdVnN//I24th7MJTosPzXy75w1vy8+BeQ==
X-Google-Smtp-Source: AA0mqf6oogmCi7KWrGe6C8j0ZnxVETE6qzYfHMi1b0320n/OD6k4DuSk5UmUTOV8qYXEoScYnehBKQ==
X-Received: by 2002:a17:902:7448:b0:186:7006:9a5f with SMTP id e8-20020a170902744800b0018670069a5fmr11395237plt.117.1668374817698;
        Sun, 13 Nov 2022 13:26:57 -0800 (PST)
Received: from ?IPV6:2409:4043:4c81:51c0:8e7b:5efe:71ba:3c2f? ([2409:4043:4c81:51c0:8e7b:5efe:71ba:3c2f])
        by smtp.gmail.com with ESMTPSA id b12-20020a170903228c00b00186b0ac12c5sm5625861plh.172.2022.11.13.13.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Nov 2022 13:26:57 -0800 (PST)
Message-ID: <a446840e-7a6d-984b-ac15-f6359a18595a@gmail.com>
Date:   Mon, 14 Nov 2022 02:56:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] doc/cat-file: allow --use-mailmap for --batch options
Content-Language: en-US
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, johncai86@gmail.com
References: <20220923193543.58635-1-siddharthasthana31@gmail.com>
 <20221029092513.73982-1-siddharthasthana31@gmail.com>
 <CAP8UFD2vLnE8Suf259RWQk2fcq+gDFTi+cDr9mrbidY49n3Lzw@mail.gmail.com>
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <CAP8UFD2vLnE8Suf259RWQk2fcq+gDFTi+cDr9mrbidY49n3Lzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 31/10/22 16:24, Christian Couder wrote:
> On Sat, Oct 29, 2022 at 11:25 AM Siddharth Asthana
> <siddharthasthana31@gmail.com> wrote:
>>
>> The command git cat-file can now use the mailmap mechanism to replace
>> idents with their canonical versions for commit and tag objects. There
>> are several options like `--batch`, `--batch-check` and
>> `--batch-command` that can be combined with `--use-mailmap`. But, the
>> documentation for `--batch`, `--batch-check` and `--batch-command`
>> doesn't say so. This patch fixes that documentation.
>>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: John Cai <johncai86@gmail.com>
>> Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
>> ---
>>
>> This patch was previously sent as the first patch of a 3 patch series for
>> adding the mailmap support in git cat-file options:
>> https://lore.kernel.org/git/20220916205946.178925-2-siddharthasthana31@gmail.com/
> 
> I think Taylor is probably right that there should be a version number
> at the start of the subject line if the patch has already been sent
> many times with the same subject and mostly the same content to the
> list.
> 
>> Changes in v2:
>> - Fixed the names in trailers in the commit message
>> - Updated the documentation to clearly state that the `--batch-check`,
>>    `--batch-command` and `--batch` options can only be used with
>>    `--textconv`, `--filters` or `--use-mailmap`.
>> - Fixed formatting
>>
>> Changes in v3:
>> - Fixed formatting
>>
>> Changes in v4:
>> - Fixed some grammatical errors
> 
> The version number should logically be "v4" according to the above.
> 
>>   Documentation/git-cat-file.txt | 45 ++++++++++++++++++++++++----------
>>   1 file changed, 32 insertions(+), 13 deletions(-)
>>
>> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
>> index ec30b5c574..db2bba9b65 100644
>> --- a/Documentation/git-cat-file.txt
>> +++ b/Documentation/git-cat-file.txt
>> @@ -89,26 +89,45 @@ OPTIONS
>>   --batch::
>>   --batch=<format>::
>>          Print object information and contents for each object provided
>> -       on stdin.  May not be combined with any other options or arguments
>> -       except `--textconv` or `--filters`, in which case the input lines
>> -       also need to specify the path, separated by whitespace.  See the
>> -       section `BATCH OUTPUT` below for details.
>> +       on stdin. May not be combined with any other options or arguments
>> +       except --textconv, --filters, or --use-mailmap.
>> +       +
>> +       * When used with `--textconv` or `--filters`, the input lines
>> +         must specify the path, separated by whitespace. See the section
>> +         `BATCH OUTPUT` below for details.
>> +       +
>> +       * When used with `--use-mailmap`, the info command shows the size
>> +         of the object as if the identities recorded in it were replaced
>> +         by the mailmap mechanism.
> 
> Sorry to realize this only at this point but actually I think the
> `info` command is only available when the `--batch-command` option is
> used, not when the `--batch` option is used.
> 
> As the `--batch` option prints both object information (which includes
> the size) and contents (which includes the idents), I think something
> like the following should be used here:
> 
>         * When used with `--use-mailmap`, for commit and tag objects, the
>            contents part of the output shows the identities replaced using the
>            mailmap mechanism, while the information part of the output shows
>            the size of the object as if it actually recorded the replacement
>            identities.
> 
>>   --batch-check::
>>   --batch-check=<format>::
>> -       Print object information for each object provided on stdin.  May
>> -       not be combined with any other options or arguments except
>> -       `--textconv` or `--filters`, in which case the input lines also
>> -       need to specify the path, separated by whitespace.  See the
>> -       section `BATCH OUTPUT` below for details.
>> +       Print object information for each object provided on stdin. May not be
>> +       combined with any other options or arguments except --textconv, --filters
>> +       or --use-mailmap.
>> +       +
>> +       * When used with `--textconv` or `--filters`, the input lines must
>> +        specify the path, separated by whitespace. See the section
>> +        `BATCH OUTPUT` below for details.
>> +       +
>> +       * When used with `--use-mailmap`, the info command shows the size
>> +         of the object as if the identities recorded in it were replaced
>> +         by the mailmap mechanism.
> 
> Same remark about the `info` command as above.
> 
> As the `--batch-check` option prints only object information (which
> includes the size), I think something like the following should be
> used here:
> 
>         * When used with `--use-mailmap`, for commit and tag objects, the
>            printed object information shows the size of the object as if the
>            identities recorded in it were replaced by the mailmap mechanism.
> 
>>   --batch-command::
>>   --batch-command=<format>::
>>          Enter a command mode that reads commands and arguments from stdin. May
>> -       only be combined with `--buffer`, `--textconv` or `--filters`. In the
>> -       case of `--textconv` or `--filters`, the input lines also need to specify
>> -       the path, separated by whitespace. See the section `BATCH OUTPUT` below
>> -       for details.
>> +       only be combined with `--buffer`, `--textconv`, `--use-mailmap` or
>> +       `--filters`.
>> +       +
>> +       * When used with `--textconv` or `--filters`, the input lines must
>> +         specify the path, separated by whitespace. See the section
>> +         `BATCH OUTPUT` below for details.
>> +       +
>> +       * When used with `--use-mailmap`, the info command shows the size
>> +         of the object as if the identities recorded in it were replaced
>> +         by the mailmap mechanism.
> 
> s/info command/`info` command/
> 
> And I think it could be interesting to add:
> 
>    - that it happens only for commits and tags, and
>    - that when the `contents` command is used the idents are replaced.
> 
> So maybe something like:
> 
>         * When used with `--use-mailmap`, for commit and tag objects, the
>           `contents` command shows the identities replaced using the
>            mailmap mechanism, while the `info` command shows the size
>            of the object as if it actually recorded the replacement
>            identities.
> 
> Also this will become true only after your other patch series will be
> merged. Which means that you should say somewhere that either
> 
>    - this patch should be merged only after the other patch series is merged, or
>    - it's a bug that the `info` command doesn't show the size of the
> updated object and this is going to be fixed soon by the other patch
> series anyway.
> 
> Thanks for working on finishing this!
> Christian.

Thanks a ton for the review Christian :) Will make the suggested changes 
and send the v4 patch series.
