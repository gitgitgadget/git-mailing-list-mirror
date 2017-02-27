Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 549981F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 22:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751422AbdB0WfJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 17:35:09 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34113 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbdB0WfI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 17:35:08 -0500
Received: by mail-pg0-f68.google.com with SMTP id s67so2339002pgb.1
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 14:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=e2E/HixhCBZuAiB0m8Ryu7E8cE9OzCnyIWzKkdqoZm8=;
        b=qqR0oibBNhtkHMuE8hnmhwRvolEhkKVUlY9qiR4mFd/mkcm4YfPkYHBJAKVOxO+DvL
         US/XwJB61N3zy/qVIpcEBfs7z2gF2gt+BzJyIPlz3WGIVgJqdQFxeCY9Tekn3+uY8k4K
         3MY56Dovtk6i2qUqdRv5IEaxPY47fOYRmne+eZAnquga8DflNuqMddHD2asoUdkYovmb
         Uomw8mMUB+Wtx2S3pd5yM2dlisCBCxpSdYWXBXhDPYa7QnpppqmtGMOzD/iudhk8MeOS
         8bKe95TRi4NT5MG03jHnXpSs+XnHn+E2YmWYalstt+MZFJuToVspqPmhDd+GbNEFihd7
         wZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=e2E/HixhCBZuAiB0m8Ryu7E8cE9OzCnyIWzKkdqoZm8=;
        b=G6egP00N38cY7t/pkqTnFBb3HUDmVYj9/wXXhsdA7U25w2Ql+p2aL48/vc5yHDNZsR
         uQfDX0S+AWOyv5PMc2V30PVYdKYWonjRKJ/vl5ZWw7UIGaHTVOwixynEPZzDnn90dNjw
         LFt4w7Jscn3OcpQcHIwIiHQBODdHvx3x1fk6pinVG6AxkjbTK1UInPHKuVsV6Any6qWy
         kYToUtoHCM2l7SRIQtVyFHVQZ0A2y4/f3sLqUR7hSi8gWmP+wEapccKIwB3BG6EyTAyH
         7++b4G6bNmew8cS0Qyl9Vn53T8Ruhe8mtzqSD0kCjZenUwAphoQu0fnd0O4IgbDkALin
         0hMQ==
X-Gm-Message-State: AMke39nipmNul6VjeIfOcjRmSxIQDtkP04urb3ryKur+eEJjfehv7ZoHwZPE9cWY627MXQ==
X-Received: by 10.98.88.133 with SMTP id m127mr23763587pfb.155.1488234796725;
        Mon, 27 Feb 2017 14:33:16 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:c953:ec42:862e:1e81])
        by smtp.gmail.com with ESMTPSA id g27sm32448661pfk.95.2017.02.27.14.33.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 14:33:15 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        Michal Zalewski <lcamtuf@google.com>
Subject: Re: [PATCH 2/2] apply: handle assertion failure gracefully
References: <20170225101307.24067-1-vegard.nossum@oracle.com>
        <20170225101307.24067-2-vegard.nossum@oracle.com>
        <a5626d97-e644-65b5-2fd3-41ce870f85a6@web.de>
        <xmqqmvd7wgc7.fsf@gitster.mtv.corp.google.com>
        <f191e3a8-a55b-7030-ebbb-3f46c74fdc94@web.de>
Date:   Mon, 27 Feb 2017 14:33:15 -0800
In-Reply-To: <f191e3a8-a55b-7030-ebbb-3f46c74fdc94@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Mon, 27 Feb 2017 23:18:03 +0100")
Message-ID: <xmqq1sujnu1g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Am 27.02.2017 um 21:04 schrieb Junio C Hamano:
>> René Scharfe <l.s.r@web.de> writes:
>>
>>>> diff --git a/apply.c b/apply.c
>>>> index cbf7cc7f2..9219d2737 100644
>>>> --- a/apply.c
>>>> +++ b/apply.c
>>>> @@ -3652,7 +3652,6 @@ static int check_preimage(struct apply_state *state,
>>>>  	if (!old_name)
>>>>  		return 0;
>>>>
>>>> -	assert(patch->is_new <= 0);
>>>
>>> 5c47f4c6 (builtin-apply: accept patch to an empty file) added that
>>> line. Its intent was to handle diffs that contain an old name even for
>>> a file that's created.  Citing from its commit message: "When we
>>> cannot be sure by parsing the patch that it is not a creation patch,
>>> we shouldn't complain when if there is no such a file."  Why not stop
>>> complaining also in case we happen to know for sure that it's a
>>> creation patch? I.e., why not replace the assert() with:
>>>
>>> 	if (patch->is_new == 1)
>>> 		goto is_new;
>>>
>>>>  	previous = previous_patch(state, patch, &status);
>>
>> When the caller does know is_new is true, old_name must be made/left
>> NULL.  That is the invariant this assert is checking to catch an
>> error in the calling code.
>
> There are some places in apply.c that set ->is_new to 1, but none of
> them set ->old_name to NULL at the same time.

I thought all of these are flipping ->is_new that used to be -1
(unknown) to (now we know it is new), and sets only new_name without
doing anything to old_name, because they know originally both names
are set to NULL.

> Having to keep these two members in sync sounds iffy anyway.  Perhaps
> accessors can help, e.g. a setter which frees old_name when is_new is
> set to 1, or a getter which returns NULL for old_name if is_new is 1.

Definitely, the setter would make it harder to make the mistake.
