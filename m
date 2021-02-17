Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5A0C433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 02:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA51764E6B
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 02:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhBQCOT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 21:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhBQCOQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 21:14:16 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8A5C061574
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 18:13:34 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id g5so16256054ejt.2
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 18:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=bFaCcYiEag7UM7iAQep2RWx6rUTA6lOHrEiqqx2v+yE=;
        b=saFYA7W0KWZEeM+rP9vZd79U2/jmrNOqgLLhgtPqBnZTp6CSsWoQiEncIIOqF7KNqk
         PcI47M8uufAQY3BT/Q9Ho8UXb5ot9A0vqXwIy6SQDcX77oW5znQKDkO4VUzCRV1n1eAg
         U14ANFykW/rk1pD7uGJBIhwo3UYifDhGtCZ4idmdrWPgX8X/pJNY/7Yy0v2275BK0R2w
         qnsigHXznaCXleR/o8J8f8yTWlRN/o4PAahwFkW9/2gWqXZwJApyb+lIcV2FDaBaW7au
         J0YvEIER7VC7vko/47hn2X/6ywfmgkmmNXbyUcRChQ6KBxpTmWwLjb0M6YvDwKSljM4x
         fgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=bFaCcYiEag7UM7iAQep2RWx6rUTA6lOHrEiqqx2v+yE=;
        b=c6J+8brgN2QSs78s35EuBbx6Vkq/qDjiFg6eGxLkY/PleyTEZFIvwIzkJqgB3WuYML
         bAKqgh6KWNc2eKos8lI3E3I/kgZr7ElbwpPadTIbgsX9UFnXr+/MZJawyBa/4NPOjyyM
         Ug8Xk5cCwkYRZj/+yT4jtemvVQWirBGC/UYI3tZZBIAKdqrtLmnCiMsVf/xoSAw1Yh6G
         9U8GTDzT3vblEsjWeas1k2Mz1RtK8VrC1SgCtaYA0aVOio7VhGqdMrrV84pf3VEDcZMB
         qD7QPaACpBdAPxk7W8/MxHaIaIo5qR7SG0LTfwIO+c4osC/2U+mPwvSUK5EZnAGOZ9Ov
         ijeg==
X-Gm-Message-State: AOAM5334QpiXmn+7w/LqqhuK4rZGFZMGow2C4d7rIV2MM7NbmAowfy7G
        2oGm8Mj9GePZhrDVtqJHiKc=
X-Google-Smtp-Source: ABdhPJyq+pDkoSc4Y8wkeeLIxwc68tj7lxd0MteTXyXRFgIAorbkod66sKTOSKjTg+y2kbQkptG0ag==
X-Received: by 2002:a17:906:6d5:: with SMTP id v21mr22817207ejb.282.1613528013596;
        Tue, 16 Feb 2021 18:13:33 -0800 (PST)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id p16sm283322edw.44.2021.02.16.18.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 18:13:32 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 09/27] userdiff tests: match full hunk headers
References: <20210215005236.11313-1-avarab@gmail.com>
 <20210215154427.32693-10-avarab@gmail.com>
 <4bd7bb84-3b75-258e-b488-f66dff6ba6b5@kdbg.org>
 <xmqqsg5vrhha.fsf@gitster.c.googlers.com> <xmqqim6rmox1.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqim6rmox1.fsf@gitster.g>
Date:   Wed, 17 Feb 2021 03:13:32 +0100
Message-ID: <875z2ra1bn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 17 2021, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> +		sed -ne "s/^@@[^@]*@@//p" actual |
>> +		if test -n "$HEAD"
>> +		then
>> +			grep -F "$HEAD"
>
> I think this should also use "-x" (match the whole line) if it is
> portable enough; the option should be available in POSIX.1 but we
> haven't used it anywhere in our test suite.

Isn't that just test_cmp with no debug output when it fails? Noted in
https://lore.kernel.org/git/87h7mba3h3.fsf@evledraar.gmail.com/

>> +		else
>> +			grep "^.*RIGHT"
>> +		fi
>> +	'
>>  done

