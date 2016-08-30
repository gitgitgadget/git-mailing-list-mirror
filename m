Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBDD61F859
	for <e@80x24.org>; Tue, 30 Aug 2016 11:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758231AbcH3LIr (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 07:08:47 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36427 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757848AbcH3LIq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 07:08:46 -0400
Received: by mail-wm0-f45.google.com with SMTP id q128so115692221wma.1
        for <git@vger.kernel.org>; Tue, 30 Aug 2016 04:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=BFvfd6NwxVt0HD5KlVsgZP1E7LJ3NVcK9hk7GZ8W/oc=;
        b=0gGrYze7G99oIwCcazVGrwgEvUx3IX/7oHShFg1w1ApZWILVjkBE3buSImroWNjoO3
         a5v1OYQ1scA0E+j1KoVV5Jxh4nSgRWZg+kA5D4vshUIsI8Z1L+zcYamSZGy5igd+5IyU
         qE0BaVgV0A5vJgvefO8OkqmoEdUQDkeyLDiVmqyJ6fkroTamO5pT4g8FrmrTa46KYa+E
         XczwU0X9MHWjxOvM2ZQFN9iOMavOy7d/Swf+DXfAAluq73kTFdXg66NUY1aNf3ph1XFp
         86BhsWnj3IUTqMs2gfmCIyxKw9tZVh7Ajk6OWS9SnxgczdDhneO9Qp+5IKVG8+r0Ijb6
         7Uvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=BFvfd6NwxVt0HD5KlVsgZP1E7LJ3NVcK9hk7GZ8W/oc=;
        b=X1brU74NLCtqciJTlKwk2I3JQC6WMN8f+BDDBA3ef30tjGh2sI1KNa32Z5L389vDmB
         lhXvKkSU8RflXN3RU4jDl+AlV3Ij+QpFsW/Ebk6QefdamvB+rIYxyvGX1UTwfwIBu36I
         TVyVFnpgyUaUusAmCL1eaEYuVYWGrCDAB7gXCc5KsnqY9jReVYOFDvH23EQ43Dr/dS8B
         lRO1gtsd4CfLmm92zinrHNM5D7oBFbwTh7KK9l/jCFJxYz+0qpNRyZhdapMTh7EkL7JF
         n2mtCj66+cdJoFPFv2YOcLRVNvKeWH+64BVlmIHVgmjSM5jDCdXDKSLtRBJflaj9lb3F
         Drxw==
X-Gm-Message-State: AE9vXwO7qbGEo2wiU0Lid8CgrHh2+1661s3LdeEG413iV6Yy2T9z9/M7/wvZORFZ6diQmw==
X-Received: by 10.194.54.37 with SMTP id g5mr3161555wjp.65.1472555325046;
        Tue, 30 Aug 2016 04:08:45 -0700 (PDT)
Received: from [192.168.1.26] (afz108.neoplus.adsl.tpnet.pl. [83.25.155.108])
        by smtp.googlemail.com with ESMTPSA id d8sm3428792wmi.0.2016.08.30.04.08.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Aug 2016 04:08:14 -0700 (PDT)
Subject: Re: [PATCH 05/22] sequencer: allow the sequencer to take custody of
 malloc()ed data
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
 <e4e7eab3d0610faa9d3173a585902e50128d8e15.1472457609.git.johannes.schindelin@gmx.de>
 <733a899a-470b-79b3-b059-b38313a7057d@gmail.com>
 <alpine.DEB.2.20.1608300915470.129229@virtualbox>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <e1cebf74-1592-5ddc-9979-eeffcbf4d788@gmail.com>
Date:   Tue, 30 Aug 2016 13:08:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1608300915470.129229@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Johannes,

W dniu 30.08.2016 o 09:29, Johannes Schindelin pisze:
> On Mon, 29 Aug 2016, Jakub Narębski wrote: 
>> W dniu 29.08.2016 o 10:04, Johannes Schindelin pisze:

>>> +void *sequencer_entrust(struct replay_opts *opts, void *set_me_free_after_use)
>>> +{
>>> +	ALLOC_GROW(opts->owned, opts->owned_nr + 1, opts->owned_alloc);
>>> +	opts->owned[opts->owned_nr++] = set_me_free_after_use;
>>> +
>>> +	return set_me_free_after_use;
>>
>> I was wondering what this 'set_me_free_after_use' parameter is about;
>> wouldn't it be more readable if this parameter was called 'owned_data'
>> or 'owned_ptr'?
> 
> If I read "owned_ptr" as a function's parameter, I would assume that the
> associated memory is owned by the caller. So I would be puzzled reading
> that name.

Right.  Well, it is difficult to come up with a good name for this
parameter that would make sense both in a declaration as an information
for a caller, and in the function itself as information about what it
holds.

In my personal opinion 'set_me_free_after_use' is not the best name,
but I unfortunately do not have a better proposal.  Maybe 'entrust_ptr',
or 'entrusted_data' / 'entrusted_ptr' / 'entrusted'?

There are two hard things in computer science: cache invalidation, 
*naming things*, and off-by-one errors ;-)


P.S. It would be nice to have generic mechanism for taking custody
of data to help libification, either at this or at lower level (on
the level of xstrdup, etc.), but that can safely wait.  It even should
wait, so that we can see that this approach is a good one, before
trying to generalize it.  That should be not a blocker for this series,
IMVHO.

Best,
-- 
Jakub Narębski

