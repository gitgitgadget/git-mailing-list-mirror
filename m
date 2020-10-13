Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E171C433DF
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 13:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08CAF22CAF
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 13:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkDVY5EG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbgJMNPr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 09:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgJMNPq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 09:15:46 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7337AC0613D0
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 06:15:46 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e17so23964065wru.12
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 06:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=udR9JXuHXoMA7VEwC+8otrcJ/uwHllkHkafb1DT+mH8=;
        b=NkDVY5EGXga0Pl102SN4BxC6MSaHitIlIkCruzMdYL8I0MAS+5+Y9eYTxxRWQRUHLp
         B6SKnXp1MUebxBLHnVeh51WTL0HqyM0wq/COJ5acR4C+IsbQMFQiY/pLMK8SAyDdglX2
         +LmuahkxVXGeCnh8tHqV8Fv+n8NV9JKnlPeZh/Xd+2abEcF4ry6N4R2qeuUd0R+ov5KM
         SYjS9i7nnKLCkE3d2hTN/EdfYK3RMzotQXltRGupMB1/VN22seJdEaPzTCsFe3wchfrS
         JFybnzY5MLbswRJZ/753OSWrG8X4eCcZCqVhltr2ergZshoRXVEVf2WnpWxJBKwKbxzM
         piMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=udR9JXuHXoMA7VEwC+8otrcJ/uwHllkHkafb1DT+mH8=;
        b=Z3FOZF84OdRSTOWvu+u+1INEp/QCO5aBwPQN7mtnp9nIHR3SodAbLNtKcCB2WxLKmn
         Otu4EJmdBN1KyVdGV5jBWkTh5V0AMba5kq3H1i91zVz73Jfk1CimaQHpZHFtNnXVJ6r3
         Mxu/oa3D1abbwdvZhfF1lA8DZOFtWDJPkZ2C0N8dQ/JhGkWZS3gUzRk/CobvFHAqNQqw
         tYPuaki0zotha48lP8EI/xmAUTJvSFLmhjYSnPZ8405x2CC/jAKxv6PDE7IqHhQbc1dD
         5DMhEoVX4XSR9EBJLrP5aeYPCqYVrRklNfgl5AfBOphEpIFWpPoccYKsFnvAnkjFOh9E
         kolg==
X-Gm-Message-State: AOAM530V4bSOi9UqScKnXbNUiFJvlbR6IfmY0XejJ1lRyNZLzDyDILa7
        k9CiXS9TurrPomMxC2lPD0IhHg3VR/E=
X-Google-Smtp-Source: ABdhPJzARjfB/rHzXq7KSWeJ7N+ZoutydRBxXBGgclbtM70hzvlgWBMtAbguZppmhBDgt6qePSud+Q==
X-Received: by 2002:a5d:4083:: with SMTP id o3mr7389883wrp.44.1602594945066;
        Tue, 13 Oct 2020 06:15:45 -0700 (PDT)
Received: from [192.168.1.240] (39.16.7.51.dyn.plus.net. [51.7.16.39])
        by smtp.gmail.com with ESMTPSA id a127sm32465920wmh.13.2020.10.13.06.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 06:15:44 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/2] sequencer: fix gpg option passed to merge
 subcommand
To:     =?UTF-8?Q?Samuel_=c4=8cavoj?= <samuel@cavoj.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
References: <20201012234901.1356948-1-samuel@cavoj.net>
 <92b32c0a-68ef-f0f2-48d4-ddb3e1cc7245@gmail.com>
 <20201013104346.oyjvlcnqhuuzkpzh@fastboi.localdomain>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <4571911c-bb2c-935a-e0bf-5f9cbccd341e@gmail.com>
Date:   Tue, 13 Oct 2020 14:15:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201013104346.oyjvlcnqhuuzkpzh@fastboi.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Samuel

On 13/10/2020 11:43, Samuel Čavoj wrote:
> Hi Phillip,
> 
> On 13.10.2020 10:55, Phillip Wood wrote:
>> Hi Samuel
>>
>> Thanks for re-rolling this
>>
>> On 13/10/2020 00:49, Samuel Čavoj wrote:
>>> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>>>
>>> When performing a rebase with --rebase-merges using either a custom
>>> strategy specified with -s or an octopus merge, and at the same time
>>> having gpgsign enabled (either rebase -S or config commit.gpgsign), the
>>> operation would fail on making the merge commit.
>>
>> Small nit-pick: I think it worked fine with if commit.gpgsign was set and
>> the user did not pass -S or --no-gpg-sign because merge would sign the
>> commits as commit.gpgsign was set, it was only if the user passed a gpg
>> signing option to rebase that we had problems. I'm not sure it's worth a
>> re-roll just for that though
> 
> This is not the case. That's how I encountered the problem initially, I
> have commit.gpgsign set to true globally. I ran a rebase -ir, over an
> octopus merge and then it would fail with an error in the lines of 'not
> something we can merge'. I later found out it didn't happen on my
> laptop, where gpgsign is not set, so that's what gave it away. In either
> case, I did not pass neither -S nor --no-gpg-sign to rebase.
> 
> Yes, _if_ the merge command went through, it would have choosen the
> correct signing behaviour (i.e. the default), but the merge died,
> because an empty string was being passed to it as one of the commits to
> merge.

Oh sorry for some reason I thought we just ignored opts->gpg_sign before 
your patch I'd forgotten we actually passed it without the '-S' - thanks 
for correcting me.

> off-topic p.s.:
> My mail server does not currently have a proper rDNS record (yeah yeah,
> I know) and for this reason, gmx.net drops my emails unconditionally.

It was dropping my emails sent from a gmail account a few weeks back

> As
> such, I am unable to send emails directly to Johannes.Schindelin@gmx.de,
> without major hackery, anyway. I am dropping him from Cc, as to prevent
> sad mailservers. I hope these messages reach him via the mailing list.

He's subscribed to the list so hopefully will see them that way

Best Wishes

Phillip

> Regards,
> Samuel
> 
>>
>> Best Wishes
>>
>> Phillip
>>
>>> Instead of "-S%s" with
>>> the key id substituted, only the bare key id would get passed to the
>>> underlying merge command, which tried to interpret it as a ref.
>>>
>>> Fix the issue and add a test case as suggested by Johannes Schindelin.
>>>
>>> Signed-off-by: Samuel Čavoj <samuel@cavoj.net>
>>> ---
>>> changed v1 -> v2:
>>>       added test case
>>> ---
>>>    sequencer.c                | 2 +-
>>>    t/t3435-rebase-gpg-sign.sh | 6 ++++++
>>>    2 files changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/sequencer.c b/sequencer.c
>>> index 00acb12496..88ccff4838 100644
>>> --- a/sequencer.c
>>> +++ b/sequencer.c
>>> @@ -3677,7 +3677,7 @@ static int do_merge(struct repository *r,
>>>    		strvec_push(&cmd.args, "-F");
>>>    		strvec_push(&cmd.args, git_path_merge_msg(r));
>>>    		if (opts->gpg_sign)
>>> -			strvec_push(&cmd.args, opts->gpg_sign);
>>> +			strvec_pushf(&cmd.args, "-S%s", opts->gpg_sign);
>>>    		/* Add the tips to be merged */
>>>    		for (j = to_merge; j; j = j->next)
>>> diff --git a/t/t3435-rebase-gpg-sign.sh b/t/t3435-rebase-gpg-sign.sh
>>> index b47c59c190..f70b280f5c 100755
>>> --- a/t/t3435-rebase-gpg-sign.sh
>>> +++ b/t/t3435-rebase-gpg-sign.sh
>>> @@ -68,4 +68,10 @@ test_expect_failure 'rebase -p --no-gpg-sign override commit.gpgsign' '
>>>    	test_must_fail git verify-commit HEAD
>>>    '
>>> +test_expect_success 'rebase -r, GPG and merge strategies' '
>>> +	git reset --hard merged &&
>>> +	git rebase -fr --gpg-sign -s resolve --root &&
>>> +	git verify-commit HEAD
>>> +'
>>> +
>>>    test_done
>>>
>>
