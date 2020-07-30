Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCEDC433DF
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 13:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 783B8206D8
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 13:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJYFOlmY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbgG3NbI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 09:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgG3NbH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 09:31:07 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC88C061794
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 06:31:06 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id v22so14364314qtq.8
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 06:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GEA0Jfx+01+f1zcqW7DZFkMQzt32EvIq0Rp8Tt1FiRM=;
        b=GJYFOlmYwS5KmqSn3kAXxW3dLkkTh7CdgQcsAiYbBEIW14MW9pv0WjgjfB/pU0DFec
         rn35vL5EKCKaluOguB4XKLKaaVTcRBbHaQ3l4+udB+XMqFr7oVkzIK3UglHWlKQawe3g
         HKmHCRlxTw84s2WaIPk793h0PFSkHTywlVpjrX12/mliY6djsCkLnd7CjnFFYeO+C/Qu
         FkJ1NXS299JgVLjoc0k1H7iMhgB5z10zNaTxKi+W2QO9s5NiwcNH1TRT9fdynh8JuIZR
         knmXusacLTFCQSjwHAb+XCBcO8/+uxkcDGn+eLepwjX+VUh6CBuuxAJ6waMVzNxhYozi
         n1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GEA0Jfx+01+f1zcqW7DZFkMQzt32EvIq0Rp8Tt1FiRM=;
        b=b9MVSkGrF92VvDj0USMvESofOfz8JNL6dfdm2VVhblrtSeBk+K9av0zBKZ8z6/hZrh
         r6jNEJHyByhmHIxcKM5tzZfAxlLBx09PdVWXHN1pRBLNk9fWBLp4paLWPBEqDt+31UGi
         4gV/4s8q2Z3f1bMARLEMwPfn9ZUso9/BSMtmzlW/Fd/Zmr2Ea+vFtytMD9wFWBEvjqNz
         PdCDKwP3VkXoO3jMJwft5BYj+scToxD+MP0h36EPks2/sLDL/X33FK2sU+J6ys/pB7vB
         7cl53FnaggGHEAASpnBFtYnWUjklJkeyh7x5ItbOV4hXJOFCGo7RltqihusYJKL3qVfy
         dVEA==
X-Gm-Message-State: AOAM530NMUPQCJv9Z5v9qD6AQjHHxg+EK7sbrV5dJhw2IX1iK8F56Noh
        qqDRvMsZR291Ig4jnapnhHw=
X-Google-Smtp-Source: ABdhPJxJajaucYmxiLA3hlHcAhwcbxRpTfzYwUX00OsCXabbPxiLZnxJU1inRlBuDvsn1fFKoGjK9A==
X-Received: by 2002:ac8:2fa8:: with SMTP id l37mr3024067qta.366.1596115865514;
        Thu, 30 Jul 2020 06:31:05 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:7cc2:825e:4cec:e949? ([2600:1700:e72:80a0:7cc2:825e:4cec:e949])
        by smtp.gmail.com with ESMTPSA id p53sm4677379qtc.85.2020.07.30.06.31.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 06:31:04 -0700 (PDT)
Subject: Re: [PATCH v2 03/18] maintenance: replace run_auto_gc()
From:   Derrick Stolee <stolee@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <f164d1a0b4363eb6eb174e90e88211829f8a1d55.1595527000.git.gitgitgadget@gmail.com>
 <xmqqblk6q8ws.fsf@gitster.c.googlers.com>
 <9aadb889-007a-c973-c59c-a471436368bb@gmail.com>
Message-ID: <5757360f-a9e5-0bd2-b933-7efddee29cf6@gmail.com>
Date:   Thu, 30 Jul 2020 09:31:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:79.0) Gecko/20100101
 Thunderbird/79.0
MIME-Version: 1.0
In-Reply-To: <9aadb889-007a-c973-c59c-a471436368bb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/30/2020 9:29 AM, Derrick Stolee wrote:
> On 7/23/2020 4:21 PM, Junio C Hamano wrote:
>> Don't we want to replace all _gc_ with _maintenance_ in this
>> function?  I think the first business before we can do so would be
>> to rethink if spelling out "maintenance" fully in code is a good
>> idea in the first space.  It would make names for variables,
>> structures and fields unnecessarily long without contributing to
>> ease of understanding an iota, and a easy-to-remember short-form or
>> an abbreviation may be needed.  Using a short-form/abbreviation
>> wouldn't worsen the end-user experience, and not the developer
>> experience for that matter.
>>
>> If we choose "gc" as the short-hand, most of the change in this step
>> would become unnecessary.  I also do not mind if we some other words
>> or word-fragment (perhaps "maint"???) is chosen.
> 
> Yes, I should have noticed that. Also, with Peff's feedback from
> another thread, the method can look a bit simpler this way:

It would help if I actually _compile_ code before sending it.
Here is the fixed version:

int run_auto_maintenance(int quiet)
{
	struct child_process maint = CHILD_PROCESS_INIT;
	maint.git_cmd = 1;

	argv_array_pushl(&maint.args, "maintenance", "run", "--auto", NULL);
	if (quiet)
		argv_array_push(&maint.args, "--quiet");
	else
		argv_array_push(&maint.args, "--no-quiet");

	return run_command(&maint);
}

