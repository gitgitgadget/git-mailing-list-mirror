Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D6ED2047F
	for <e@80x24.org>; Mon,  7 Aug 2017 18:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbdHGS3b (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 14:29:31 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:34479 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbdHGS3a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 14:29:30 -0400
Received: by mail-qk0-f172.google.com with SMTP id u139so7415492qka.1
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 11:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YHOpRVZ581AQCp5i6od62oFvI9jpIGLQQJjtAJKs4RY=;
        b=q5J4ruqRh8CiVt6gviNEvFEFldLm/Kmw5+g8ECWGd5RA8tWiVaQZusSxLKYDG2MfKa
         yGLY7b0FaaOOyY02Pc/rlNngz7l1XJp2jW/e/hVBlJCJ53wjKDakjAUHu/WA8bhqVv7c
         Qij0nF9fInSFSS+uTFpLiPXeE+eDPak0WfxDvpB0Co8N32M8BcRFvOErD7kIPrh+ddc4
         j8aWMb5ZIa0x6XKHixCNTbnIza3sB65ksDqv739NuRJcqYUTqGPTZuGyycbZMzIgowSE
         Fr/v5djFk5EFh/lDCVhpo4+pzr/+hrO8h8jevG73KJ3wG8WHEZ4dUNjsaexiiWi5IkIG
         iI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YHOpRVZ581AQCp5i6od62oFvI9jpIGLQQJjtAJKs4RY=;
        b=Upl9Jbiq7uMwgSVok6xOxlGXaTWJNNeqqaec+tvCjUrwrQZ3xoutGLJ7WIuDQpfiBD
         hFRQSYKFK+XJ1RKWm4QDie5l7UVOo+0WBBjRD7tjr8WX2IuhVknsXJOn9nZMA+2WpjZQ
         SpykLAm9mmoVxDQuznVzToZef//0F5mDZouYMoW4oWIlkiN8JwKCaIB/5zd97iO/LJeS
         9GvsF2uFpwRon9z4/vezdbLy9rjf23C4YaFh3FDjQ4jtQNuidlryxNLWVIGGgfsUFfhw
         /H14wn9AMWD1hTZ6Q7gWU/Wp5hzeMxB/yCwpeg8lARPTm9KKLo3ePhw1HWQkdWolkdUi
         gdrA==
X-Gm-Message-State: AHYfb5inDjJBa1DKjDDgOmQgx7F0kHxS+vbPisMV1JxKHijfKtJr42pI
        RtQxd/Hd0IEvSQ==
X-Received: by 10.55.49.11 with SMTP id x11mr2015931qkx.224.1502130569507;
        Mon, 07 Aug 2017 11:29:29 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id h42sm6151648qtb.97.2017.08.07.11.29.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Aug 2017 11:29:29 -0700 (PDT)
Subject: Re: [PATCH for NEXT v3 2/2] sub-process: refactor handshake to common
 function
To:     Jonathan Tan <jonathantanmy@google.com>,
        Lars Schneider <larsxschneider@gmail.com>
Cc:     benpeart@microsoft.com, git@vger.kernel.org, bmwill@google.com,
        gitster@pobox.com
References: <cover.1501092795.git.jonathantanmy@google.com>
 <20170724213810.29831-1-jonathantanmy@google.com>
 <cover.1501092795.git.jonathantanmy@google.com>
 <6327579311fdb941a11b6d452318777a3c42ee65.1501092795.git.jonathantanmy@google.com>
 <323E470B-994B-4AD8-9F30-588C2B97A845@gmail.com>
 <20170807102136.30b23023@twelve2.svl.corp.google.com>
 <2BEA5CEF-44C9-45DC-A462-579864790EDB@gmail.com>
 <20170807111708.2d745df2@twelve2.svl.corp.google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <142c1757-d366-61fe-ffa8-a398bdfd8c03@gmail.com>
Date:   Mon, 7 Aug 2017 14:29:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170807111708.2d745df2@twelve2.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/7/2017 2:17 PM, Jonathan Tan wrote:
> On Mon, 7 Aug 2017 19:51:04 +0200
> Lars Schneider <larsxschneider@gmail.com> wrote:
> 
>>
>>> On 07 Aug 2017, at 19:21, Jonathan Tan <jonathantanmy@google.com> wrote:
>>>
>>> On Sun, 6 Aug 2017 21:58:24 +0200
>>> Lars Schneider <larsxschneider@gmail.com> wrote:
>>>
>>>>> +	struct cmd2process *entry = (struct cmd2process *)subprocess;
>>>>> +	return subprocess_handshake(subprocess, "git-filter", versions, NULL,
>>>>> +				    capabilities,
>>>>> +				    &entry->supported_capabilities);
>>>>
>>>> Wouldn't it make sense to add `supported_capabilities` to `struct subprocess_entry` ?
>>>
>>> The members of "struct subprocess_entry" are not supposed to be accessed
>>> directly, according to the documentation. If we relaxed that, then we
>>> could do this, but before that I think it's better to let the caller
>>> handle it.
>>
>> @Ben: You wrote that " Members should not be accessed directly.":
>> https://github.com/git/git/commit/99605d62e8e7e568035dc953b24b79b3d52f0522#diff-c1655ad5d68943a3dc5bfae8c98466f2R22
>> Can you give me a hint why?
>>

It's just good object oriented design of providing a layer of 
abstraction between the implementation details and the use of the 
class/object/API.  I was following the model in api-hashmap.txt but 
there are many other examples of where we don't do this.

Perhaps providing a function that returns the property you want to 
access (similar to subprocess_get_child_process) would work.

>> @Jonathan: What do you mean by "it's better to let the caller handle it"
> 
> Let the caller provide their own place to store the capabilities, I
> mean, instead of (say) using a field as you describe and an accessor
> method.
> 
> I don't feel strongly about this, though.
> 
>>> It does, but so does chosen_version. This is meant to allow the caller
>>> to pass NULL to this function.
>>
>> Hm. I think every protocol should be versioned otherwise we could run
>> into trouble in the long run.
>>
>> TBH I wouldn't support NULL in that case in the first place. If you
>> want to support it then I think we should document it.
> 
> Note that this NULL is for the chosen version as chosen by the server,
> not the versions declared as supported by the client.
> 
> The protocol is versioned. Some users (e.g. the filter mechanism) of
> this subprocess thing would want to pass NULL because they only support
> one version and the subprocess thing already ensures that the server
> report that it supports one of the versions sent.
> 
