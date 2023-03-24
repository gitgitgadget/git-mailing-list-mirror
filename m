Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6457DC6FD1C
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 14:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjCXOwu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 10:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjCXOws (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 10:52:48 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C09C178
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 07:52:47 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r11so2039331wrr.12
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 07:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679669565;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wl5Fr1uWOVuYMszTO5YZ/NljHSjC6nqYsjMdtoicHRY=;
        b=BhG844iErkeLRaqaavoXBbZaZqItcMNFWUYkKeaVTnyugmFm5Jeyt9KK2/7NeMLZN+
         b86SMkn4cFICffH2SvE6ekj78Xdu5NMeBA6xkF+gTxtHXJkE+RC2jF6wxZ5CCYdhHozy
         NE9ZyQqwZ9yhFyG7rIcS1QYmzfMb+siTW48kpyiNjsxL9PYXebmobSqsqDA47P/zrUVf
         jFP5siWIlk9nTDdw2frVcFRnrMs2mbhwl8AErQ8Cb8O8YIc8Y4eAy1eDACeLB46Qxsm4
         ASaU8vKOxgZiD9JryhCFvrg6eaxacEJ+yks0aKtab/JX7L1CtWXR3eVIKUCEM+wSBRs6
         VNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679669565;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wl5Fr1uWOVuYMszTO5YZ/NljHSjC6nqYsjMdtoicHRY=;
        b=tqzC29whYKzUEk6c8BGlLzlfbkTAvAdEXbAn6Sa4i3MBYKWpFzbbnN9gu+O5KbEvgA
         ETIialoB6B453mXEK5pCZIpdianEgSYN7iMgFllOxoWkwo5HAfWTAwvbnr4bTiDiG0pO
         6QooC5kuePmxtjsAcsCjfBCUN+YsxB8tD6lkbZz3Gn1OM4OW3PUzmgPlk7ZGEsayL2K6
         9pOxtOLOQmNJVLaiee4mHNzzzJZdLg+1qx4dpqpjPpYZsiXe8RCnRcF6QlU2skbWATTN
         9+A7A1PnxHKU9z1GOR4XcTAks5yhv2YufRreoZygksowjftBJr0mAaPqqQTkX5RIfI5O
         /lwQ==
X-Gm-Message-State: AAQBX9f32q6VW+zdX5uvWd5+hDWzzCnozWE07XByZ3ccNfUSO7hhzGA7
        t0iDodVpdywZaAwmityzhaM=
X-Google-Smtp-Source: AKy350YeZt40uInnZTANerKhiA0IudeB6ppiYxtog93dBfB5dhf5En5DClTIYCAtVzHvaw+VKynexw==
X-Received: by 2002:adf:f288:0:b0:2db:11f3:f7ee with SMTP id k8-20020adff288000000b002db11f3f7eemr2560580wro.63.1679669565554;
        Fri, 24 Mar 2023 07:52:45 -0700 (PDT)
Received: from [192.168.1.212] ([90.253.29.198])
        by smtp.gmail.com with ESMTPSA id e18-20020a056000121200b002d24a188b64sm18536304wrx.112.2023.03.24.07.52.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 07:52:45 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <830fe4e6-b2a3-d8ad-a415-1d385e759961@dunelm.org.uk>
Date:   Fri, 24 Mar 2023 14:52:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v8 3/3] rebase: add a config option for --rebase-merges
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        tao@klerks.biz, newren@gmail.com, Johannes.Schindelin@gmx.de,
        sorganov@gmail.com, chooglen@google.com, calvinwan@google.com,
        jonathantanmy@google.com, felipe.contreras@gmail.com
References: <20230312210456.92364-1-alexhenrie24@gmail.com>
 <20230320055955.461138-1-alexhenrie24@gmail.com>
 <20230320055955.461138-4-alexhenrie24@gmail.com>
 <f062165f-2e59-67b5-ebff-b029c29dd4d6@dunelm.org.uk>
 <xmqqttyb8fxw.fsf@gitster.g>
In-Reply-To: <xmqqttyb8fxw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 23/03/2023 18:45, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>> @@ -1514,13 +1542,15 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>>>    				break;
>>>      		if (i >= 0 || options.type == REBASE_APPLY) {
>>> -			if (is_merge(&options))
>>> -				die(_("apply options and merge options "
>>> -					  "cannot be used together"));
>>
>> This isn't a new change but having thought about it I'm not sure
>> moving this code is a good idea. If the user runs
>>
>> 	git -c rebase.updateRefs=true rebase --whitespace=fix --exec "make test"
>>
>> then instead of getting an message saying that they cannot use apply
>> and merge options together they'll get a message suggesting they pass
>> --no-update-refs which wont fix the problem for them.
> 
> Hmph.  Instead of dying here, ...
> 
>>> +			if (options.autosquash == -1 && options.config_autosquash == 1)
>>>    				die(_("apply options are incompatible with rebase.autoSquash.  Consider adding --no-autosquash"));
>>> +			else if (options.rebase_merges == -1 && options.config_rebase_merges == 1)
>>> +				die(_("apply options are incompatible with rebase.rebaseMerges.  Consider adding --no-rebase-merges"));
>>>    			else if (options.update_refs == -1 && options.config_update_refs == 1)
>>>    				die(_("apply options are incompatible with rebase.updateRefs.  Consider adding --no-update-refs"));
> 
> ... we get caught here, and the next one is not triggered.
> 
>>> +			else if (is_merge(&options))
>>> +				die(_("apply options and merge options "
>>> +					  "cannot be used together"));
>>>    			else
>>>    				options.type = REBASE_APPLY;
> 
> What's the reason why "cannot be used together" is moved to the last
> in the chain?
> 
> The first two new conditions in this chain try to catch an
> invocation with some apply-specific command line option
> (e.g. "--whitespace=fix") when used with configuration variables
> specific to the merge-backend (e.g. "rebase.merges") and suggest
> overriding the configuration from the command line, and I suspect
> that the motivation behind this change is that their error messages
> are more specific than the generic "apply and merge do not mix".
> 
> But are these two new errors and hints universally a good suggestion
> to make?  I actually think a command line option forcing us to use
> the apply backend should simply silently ignore (aka "override")
> configuration variables that take effect only when we are using the
> merge-backend.  "git rebase --whitespace=fix --rebase-merges",
> giving both from the command line, is making conflicting and
> unsatisfyable request, and it is worth giving an error message.
> 
> But if you configure rebase.autosquash only because you want to it
> to be in effect for your invocations of "git rebase -i", you
> shouldn't have to override it from the command line when you say
> "git rebase" or "git rebase --whitespace=fix", should you?

I think there are two conflicting viewpoints here which depend on what 
one thinks the user wants when they set these configuration variables. 
As I understand it Elijah's thinking was that if the user set 
rebase.autosquash they'd be surprised when their fixup commits were not 
squashed by

	git rebase --whitespace=fix

and that's why his patch series changed things to error out.

The other point of view is that the user expects that these 
configuration variables to apply only when they are using the "merge" 
backend and so we should not error out.

Personally I lean a little more towards the latter but I don't feel that 
strongly about it and can see an argument for having either behavior. I 
do think we should leave the ordering alone though so the user gets a 
useful error message in the case of "git rebase --exec 'make test' 
--whitespace=fix"

Best Wishes

Phillip

> Thanks.
