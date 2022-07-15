Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BECC43334
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 13:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbiGONUN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 09:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234625AbiGONUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 09:20:09 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C1B774BB
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 06:20:08 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id z132so3861419iof.0
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 06:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mGfVhUcinVVc9ZVO37pW8b5aCQaRgPTEycyhV2fjukQ=;
        b=YnNB4YmwnzAo4yIlvkqNuw13SBvjgx6Ts9VD4KOICaHxBDW8Lrb4945JH8xDpAAV4j
         gig5/3UxtlZG8rwYqBrmdMm4sfZ4ehPefMG1jasH+XVR0AFgm6fAhdCA2TVxnccRm1/y
         asdzZpM9BR/SQHzKPBF4nGvCdbvUsRlif0bIYLHmyn44cH0qjVGgecf4hvtqeO1orKzG
         H/iGgvdwzKKq4GbGFftlP/mjzn7RwhOHDOy/HzzfZF/CJQLbmF/3AwvYV/S9how/3gZM
         XyU5aRQ8Q6di44z59tArR8ebsgcsWoydBOn89IL4jJoctkzmMLB/XXkFn1jbLD187G73
         xTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mGfVhUcinVVc9ZVO37pW8b5aCQaRgPTEycyhV2fjukQ=;
        b=LGO5wpsV6NFOF/8bWy86KMBwUKHyywkdwLAMqda1WTpsCWKgv0XjTZUC1Niuic8MJ7
         YlAx/uNmPj4nE9vAllRgdtKJf7yWGbpUvXCrAk/zQ7B4Hd6CfqENcV2FHAMrKEO2tzmt
         /zfF1LTk6q1Zy6+59UlH7o9W2oDJK9/jhtMmuahktlyKVWs5Zx9wuRY3xHLk7Zwt4+1u
         V3GTxLQVj0xmSWvVOy+in25bvbUDZW2totXEryToB6BnFooZwPRHinjkNcGcn+pw4vvB
         pqbweG0CGLPQC3ePYhMzFH77LdzpYp6x17CpIBP9GzeivbJKr+kwbUw3wcSsOowsjL7F
         yvBA==
X-Gm-Message-State: AJIora8Ey6yK63Wyi5gv0f3Xs87pkeUow9APuBh/ggJxc/9vZmE+PA1M
        5Cim8vq9YCn0I6bgwt2L5MxWgSp8BcLa
X-Google-Smtp-Source: AGRyM1shWQ84iVc6GGGAYp80whfN1H4IBstwOy4TS/PJ3S/z5RhyBY1syRG1NDcBDlGakPc+VQs9UA==
X-Received: by 2002:a05:6638:13cb:b0:33f:336c:34ae with SMTP id i11-20020a05663813cb00b0033f336c34aemr7461542jaj.317.1657891207471;
        Fri, 15 Jul 2022 06:20:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:34ca:20bc:bde7:c407? ([2600:1700:e72:80a0:34ca:20bc:bde7:c407])
        by smtp.gmail.com with ESMTPSA id f6-20020a056e020b4600b002dae42fa5f2sm1688569ilu.56.2022.07.15.06.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 06:20:07 -0700 (PDT)
Message-ID: <fc2e8f9d-0232-4c19-2e4d-9ba6c9b17ab2@github.com>
Date:   Fri, 15 Jul 2022 09:20:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 12/12] sequencer: notify user of --update-refs activity
Content-Language: en-US
To:     phillip.wood@dunelm.org.uk,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
 <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
 <d5cd4b49e46bc2c186c6e89333360a975700c99a.1657631226.git.gitgitgadget@gmail.com>
 <11ff21b9-7169-00c5-95c0-130675ffe2ae@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <11ff21b9-7169-00c5-95c0-130675ffe2ae@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/15/2022 6:12 AM, Phillip Wood wrote:
> On 12/07/2022 14:07, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> When the user runs 'git rebase -i --update-refs', the end message still
>> says only
>>
>>    Successfully rebased and updated <HEAD-ref>.
>>
>> Update the sequencer to collect the successful (and unsuccessful) ref
>> updates due to the --update-refs option, so the end message now says
>>
>>    Successfully rebased and updated <HEAD-ref>.
>>    Updated the following refs with --update-refs:
>>     refs/heads/first
>>     refs/heads/third
>>    Failed to update the following refs with --update-refs:
>>     refs/heads/second
>>
>> To test this output, we need to be very careful to format the expected
>> error to drop the leading tab characters. Also, we need to be aware that
>> the verbose output from 'git rebase' is writing progress lines which
> 
> s/is writing/writes/ ?

That is an improvement. Thanks.
 
>> don't use traditional newlines but clear the line after every progress
>> item is complete.
> 
> I was a bit confused by the reference to "verbose output" in this paragraph. When the user passes --verbose then we do actually use NL, it is when the user does not pass verbose that we use CR instead.

I was mostly thinking that the summary message at the end is only shown
when the command has verbose output (which really means the default of
--no-quiet). There is no current way to have --no-progress --no-quiet
to keep the progress lines out of the output but still have the summary.

>> When opening the error file in an editor, these lines
>> are visible, but when looking at the diff in a terminal those lines
>> disappear because of the characters that delete the previous characters.
>> Use 'sed' to clear those progress lines and clear the tabs so we can get
>> an exact match on our expected output.
> 
> Thanks for the comprehensive commit message and for implementing an excellent suggestion from Elijah. I wonder if it makes sense to distinguish between the current branch and all the others when writing the update message as we do here or if all the refs should just be in a single list. I also think it doesn't matter much and we can change it later if we want.

I'm definitely open to suggestions, but I also think we should start
somewhere and see what users think. Since the mechanisms for updating the
refs are different, I felt it was appropriate to have different error
messages.

>> +    if (!quiet &&
> 
> As you skip adding anything to the strbufs when quiet is true you don't really need this test
> 
>> +        (update_msg.len || error_msg.len)) {
>> +        fprintf(stderr,
>> +            _("Updated the following refs with %s:\n%s"),
>> +            "--update-refs",
>> +            update_msg.buf);
> 
> This will be printed even if all the updates falied

These are good points! Instead, I should arrange this as

	if (update_msg.len)
		/* send the success message. */
	if (error_msg.len)
		/* send the failure message. */

>> +    cat >expect <<-\EOF &&
>> +    Updated the following refs with --update-refs:
>> +        refs/heads/first
>> +        refs/heads/no-conflict-branch
>> +        refs/heads/third
>> +    Failed to update the following refs with --update-refs:
>> +        refs/heads/second
>> +    EOF

(copying this message from earlier in your message for context)

> From the last test it looks like we are already printing something when we fail to update a ref (possibly this comes from the refs backend code) I don't think it hurts to print a summary of them all after that though.

>> +    # Clear "Rebasing (X/Y)" progress lines and drop leading tabs.
>> +    tail -n 6 err >err.last &&
> 
> I'm curious as to why we need tail here but not in the test above.

I think I was trying to avoid testing the error messages from the
ref backend code. I bet that since this tail is here, the 'sed' is
no longer required.

>> +    sed -e "s/Rebasing.*Successfully/Successfully/g" -e "s/^\t//g" \
>> +        <err.last >err.trimmed &&
>> +    test_cmp expect err.trimmed

Thanks!
-Stolee
