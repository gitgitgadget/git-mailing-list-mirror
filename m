Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C73C920954
	for <e@80x24.org>; Tue,  5 Dec 2017 03:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752362AbdLEDg4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 22:36:56 -0500
Received: from mail-it0-f43.google.com ([209.85.214.43]:37917 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752344AbdLEDgz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 22:36:55 -0500
Received: by mail-it0-f43.google.com with SMTP id r6so11968529itr.3
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 19:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6jk9uDMQmIpTYRcpoRGsjddDIq47jRYJm1jKpGV45og=;
        b=lochIBmt7G0MBPI9i2iel1iwVt+akqd0G+KtHbowBp0LcdBCOj4uIOJJi5hXrGlu5C
         nnR5JTztNbkbqwMu653JiWHqIQl8Kc3vWRzWZACWN8EyCHLLK/KwmTTp9aFkvfOl9+PT
         tE0AMCX4qnvWzGIHbf5tqDXXSoEbpPoTu/0FUFP91r9A0SwBeskzGNGgIJ466W0HWcT2
         EaUwf4izutl8KJusGH4Lhn1S66+RkKEgVM8TkYnVIHkJNdYjJJfPLT3giC43CC0DDCFL
         zukt0+SDIeZIohN0n2Qv6JCK3edrSOT80/R9YdUhBZjLxOgfVKf5ir4lWCtofLBZDpyk
         4zyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6jk9uDMQmIpTYRcpoRGsjddDIq47jRYJm1jKpGV45og=;
        b=LAoytWxEwO6KNUtUr71fhJcyEIc9p5UyHgP5UUzsaktRGW4ilyKV546e2QATzNAdSG
         lO/8d1sug9IX5elBUYUnhSnE+Dyb4icerGmaJ1iPcV8cnUUNYchkOQxzx3vOYrmaYmcP
         7+YG3blB8slALduGHEQGfeDKc1hiq7ncBvMuwEkh3Mm7m19yXtc7JRXgJSOVh6JpSSot
         QekUWpWcDBoiwlktAgo6YigEF7lYGBllowAYelelrQQMk1l9TWyu/M1sYrImR39smwg7
         nuSYn7579DVnl+kkXfvhK1ono+ItMKB4fj9fGqWBdkyLGjUP2CIMDi0K23UbhBO0BcbM
         Q/jA==
X-Gm-Message-State: AJaThX700fRrnbzHdOZHZB0XoH26aIBnN5AWLJzEt0KxC1MQqiuEXOxP
        AsKWee1Pxy1HkgxN0yz6T6o=
X-Google-Smtp-Source: AGs4zMaragTTESvtGFYZQlBI0XmzijhydfzGPbb+1uCxoTxdMYZbt5vHNCji2ydO09YbdBYr8ARqUw==
X-Received: by 10.107.33.71 with SMTP id h68mr25333431ioh.167.1512445014990;
        Mon, 04 Dec 2017 19:36:54 -0800 (PST)
Received: from [192.168.3.104] (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id e205sm4542374ita.6.2017.12.04.19.36.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Dec 2017 19:36:54 -0800 (PST)
Subject: Re: [PATCH v2 4/9] rebase -i: refactor transform_todo_ids
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, peff@peff.net
References: <20171127045514.25647-1-liambeguin@gmail.com>
 <20171203221721.16462-1-liambeguin@gmail.com>
 <20171203221721.16462-5-liambeguin@gmail.com>
 <alpine.DEB.2.21.1.1712041541000.98586@virtualbox>
 <xmqq4lp6o4p4.fsf@gitster.mtv.corp.google.com>
From:   liam Beguin <liambeguin@gmail.com>
Message-ID: <ddb4bc14-0598-aaab-af1c-e3a714a6c49b@gmail.com>
Date:   Mon, 4 Dec 2017 22:36:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqq4lp6o4p4.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 04/12/17 11:09 AM, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> On Sun, 3 Dec 2017, Liam Beguin wrote:
>>
>>> The transform_todo_ids function is a little hard to read. Lets try
>>> to make it easier by using more of the strbuf API. Also, since we'll
>>> soon be adding command abbreviations, let's rename the function so
>>> it's name reflects that change.
>>
>> I am not really a fan of the new name, and would prefer the old one, but
>> that's only a nit, not a reason to reject the patch.
> 
> FWIW, I do think the new name goes backwards.  The command uses to
> remember what operations are to be carried out in which order using
> a thing, and the name of that thing "todo list".  We also called it
> the "instruction sheet", and "insn" was a good term to call one item
> on that sheet among other items.
> 

Good point on saying this name change is going backwards.

> But recent commits in the area are pushing us to call it "todo list"
> consistently.  An element in that list should be called "todo".
> 
> A "todo" consists of two parts, "what operation is done" part and
> "using what commit object" part.  The original implementation of
> this function affected only the latter part, and in that light, the
> original name transform_todo_ids() is understandable.  Now you are
> planning to make it modify both parts, not just "ids", so it is
> understandable that you would want to rename it.  But I do not think
> "insn" matches the recent trend.  It even risks misunderstanding
> (i.e. xfrm_todo_ids() is about modifying "using what commit" part,
> so perhaps xfrm_todo_insns() is about modifying "what operation is
> done" part---but that is different from what you want to do, which
> is to update _both_ halves).
> 

You're right! We do want the name to reflect that we intend to change
both halves and not only the command.

> Calling it just transform_todo() would probably be more in line with
> the reason why you wanted to rename it in the first place.
> 

Good suggestion. Would transform_todos() work too? I'll send an update
tomorrow.
Thanks, 

Liam
