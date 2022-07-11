Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31384C43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 23:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiGKXUm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 19:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiGKXUl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 19:20:41 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F25E37F99
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 16:20:40 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id v6so5076244qkh.2
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 16:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=GkJtpcxpqEc6gg66HljeOqc/7SYl3FFQeijAp8YkoJo=;
        b=gYVVJ1CAUyLYwyLbSF+BkTsLQqGFM8GztmxnkoysdW+HSBwdBEgF4i6Nfh883ENd4q
         neYgKOcsnnVGpRImmn4VFtNtG0mGvwh83qTjl0LC5x179xUvTiZNhD6K4tQYCmDNQ3Qh
         qygBpTlyG/3uZLahH7gCVirmzuUPnSZ1UCIr7j5FeZSJkO83o+SavBDU9VWSQD7GAHYE
         bqCyGaT3iOMK+L+kN1uEzBmTrfuSfbv696NSYh/c5B65/JoVSKtU+nn5R2VzImkB9amv
         xreujW8cvmE5uPBb/wM/YTdkLk8U6uenvSRIMj0c5XjJ2fL9UAtypMsxKIOXoawwDun+
         NivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=GkJtpcxpqEc6gg66HljeOqc/7SYl3FFQeijAp8YkoJo=;
        b=TWuM6j0S3YcD8UBzOFvkgvJIbDgyaB/qari/6riPsnY3c+AxF1rvJS6GG5iLCkyg6h
         Fny1RENwwM9gfN3frzJQGKHgkaFtDjpl9EgstmjmnIAkG0mCwPZ6pjuno7qL9QnhAUU7
         9M7PsFULItU1GqBuBxsckyZZvUs4dZr2JNX+O8slohh/YYTKwGgTVREs0zvoukhTJq+h
         /Pswtw60c3Y75ryuWH8jqsjEOKBnT8pfwsqlnvppy7bOxPWZAYKx0jIpkYOFdt9PA7HK
         CSSGWBH3T9ZYYY2Pnop5SGLPAhZchga/sf39kBRh5rJihDTM0QdCMA0sJ614e3xCqHSC
         LZ9g==
X-Gm-Message-State: AJIora/cMxTzxIrNo++ap1ROomLJ+yM7S80xU0Uxd+B72ACMV/i+VR3L
        z2kYQebrGtlvE9yaET3DKvI=
X-Google-Smtp-Source: AGRyM1tV8DwoEiiur9h+TyGDm1G+8Yo2R095f6JmbS8ZK7HN2jz7HdBNyJqKl4kC5rxVqNL1UrssOA==
X-Received: by 2002:a05:620a:4914:b0:6af:3011:585f with SMTP id ed20-20020a05620a491400b006af3011585fmr12747952qkb.245.1657581639383;
        Mon, 11 Jul 2022 16:20:39 -0700 (PDT)
Received: from ?IPV6:2605:2a00:8000:dead:55a4:52ad:2bdc:5b8c? ([2605:2a00:8000:dead:55a4:52ad:2bdc:5b8c])
        by smtp.gmail.com with ESMTPSA id l15-20020a05620a28cf00b006a70f581243sm7866157qkp.93.2022.07.11.16.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 16:20:39 -0700 (PDT)
Message-ID: <ba1eb825-89cf-84c0-864e-5307376ccba1@gmail.com>
Date:   Mon, 11 Jul 2022 19:20:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Gerriko io <gerriko.iot@gmail.com>, git@vger.kernel.org
References: <CALF=2AMDTa48sYdrPjc_i9UyaZfvGKhR9OvknYfLywgtj8AM_g@mail.gmail.com>
 <YsyYtOIpIU29OMN/@tapette.crustytoothpaste.net>
From:   Thomas Guyot <tguyot@gmail.com>
Subject: Re: Revert and reset and very damaging Git commands
In-Reply-To: <YsyYtOIpIU29OMN/@tapette.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-07-11 17:40, brian m. carlson wrote:
> On 2022-07-11 at 19:52:05, Gerriko io wrote:
> Gosh this is not good.
>> Why are these commands bypassing all the fundamentals of a computer
>> OS. Surely if a file is deleted it should end up in the computer's
>> rubbish bin. Not deleted permanently without a trace.
> In general, the programmatic interfaces used to create and delete files
> don't use the user trash can.  That's because many programs create and
> delete extremely large numbers of temporary files (Git included) and it
> would be silly to expose those to the user, since the user trash can is
> designed to handle files that the user specifically might want to
> recover.  There is also no standard portable interface for placing files
> into the user trash can, while there are standard portable interfaces
> for actually removing files.
>
> Also, traditionally, on Unix systems, deleting files has happened
> without prompting, and Git is designed for Unix systems.

I'd like to add that in only very few cases git will remove untracked 
files that haven't even been added to the index - for example git clean 
-f (-f is force), as it's designed to remove untracked files.

In the case of reset, it could effectively wipe untracked files but only 
if you reset to a revision that has these same paths, else it would not 
touch untracked files at all.

Added files would however be affected but as pointed out earlier they 
are already in your object store and can be recovered using git fsck.

If unsure about a command, especially with a name like "clean" or 
"reset", all command are documented and the man page can be usually read 
using:

git <command> --help

--
Thomas
