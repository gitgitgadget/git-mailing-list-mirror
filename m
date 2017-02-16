Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAFA41FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 18:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932948AbdBPSLj (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 13:11:39 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34016 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932423AbdBPSLi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 13:11:38 -0500
Received: by mail-pg0-f66.google.com with SMTP id v184so2591237pgv.1
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 10:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=X8B4WWBI9wNIxLsplDOtnmUeQVBUiJLKCu+P7WwLrTs=;
        b=NORCwx0C68n4P1s6lzuU8YxvyL+SLuBftdi0YivOz1i65mapvn5vRuQMFhb/Bi1JtZ
         +3kq1C+AeqZKZC5SxgB94W9ona7/gmjbirvnYu7V9HZWFmpMhi/lm3qWqFiCnRhSzBKC
         NDlTTYB3MtJuVnmNaAumt9LNnUq26tWqZqBZawQCWnsIIJ1OfEobHJB+vG8NZw4k5/BY
         87aN+WwpBZmjk1jsYy6G+z32Hi0J1Ah07mlGwN9c9zL5hSC5SaWdEMvIs6kz98UxYokN
         uNU+nIRiNrq1heu34gBLOX0wrJecs0dbRQy8/IVpn1++G9abUVRUGHQJUcOaVnezw8ZO
         0cLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=X8B4WWBI9wNIxLsplDOtnmUeQVBUiJLKCu+P7WwLrTs=;
        b=GbNMK0SKkSKxWsN5z1w5IJOLecY6ua0WViZ90HqSPw1ja+KjWBFjeuIbvT2YhaKaZd
         KDRvROlFqhDvxFlhEay9IpzwBIR71Dxd8EyohUpMoHKdb/qwnZOtDWTp35IPsKVeiITf
         QXJy1AWY8oZWQClRyTMZJaSqC0ZwtktssCWtPzausQ5M8IQqjZRkM43dsPQTCUeRkNrt
         2IyxCpZgpiRaoggokrY+VViQtxmowB9skilmDHVmHxBFxQDeHMY5ds5H3XwjUdjB2VgF
         9OmwxnZZvrM0am7oF8xuBjL734fST1wQtG2s/nS+Vd3mw2Bh0Qhef+aPhmXBocgvr7NX
         TwKg==
X-Gm-Message-State: AMke39k5TXT++43MIB/TLsex8WN/O/pibDc955RnWAnI2tvBqU35r4ZSQmdauL96z28Bfg==
X-Received: by 10.98.53.65 with SMTP id c62mr4211217pfa.58.1487268697736;
        Thu, 16 Feb 2017 10:11:37 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:9476:4c5c:6ee4:ba3])
        by smtp.gmail.com with ESMTPSA id y82sm14853565pff.132.2017.02.16.10.11.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 16 Feb 2017 10:11:36 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     Siddharth Kannan <kannan.siddharth12@gmail.com>,
        git@vger.kernel.org, pranit.bauva@gmail.com, peff@peff.net,
        pclouds@gmail.com, sandals@crustytoothpaste.ath.cx
Subject: Re: [PATCH 1/4 v4] revision.c: do not update argv with unknown option
References: <1487258054-32292-1-git-send-email-kannan.siddharth12@gmail.com>
        <1487258054-32292-2-git-send-email-kannan.siddharth12@gmail.com>
        <vpqwpcqm69k.fsf@anie.imag.fr>
Date:   Thu, 16 Feb 2017 10:11:35 -0800
In-Reply-To: <vpqwpcqm69k.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
        16 Feb 2017 17:48:07 +0100")
Message-ID: <xmqqwpcqxay0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Siddharth Kannan <kannan.siddharth12@gmail.com> writes:
>
>> handle_revision_opt() tries to recognize and handle the given argument. If an
>> option was unknown to it, it used to add the option to unkv[(*unkc)++].  This
>> increment of unkc causes the variable in the caller to change.
>>
>> Teach handle_revision_opt to not update unknown arguments inside unkc anymore.
>> This is now the responsibility of the caller.
>>
>> There are two callers of this function:
>>
>> 1. setup_revision: Changes have been made so that setup_revision will now
>> update the unknown option in argv
>
> You're writting "Changes have been made", but I did not see any up to
> this point in the series.

Actually, I think you misread the patch and explanation.
handle_revision_opt() used to be responsible for stuffing unknown
ones to unkv[] array passed from the caller even when it returns 0
(i.e. "I do not know what they are" case, as opposed to "I know what
they are, I am not handling them here and leaving them in unkv[]"
case--the latter returns non-zero).  The first hunk makes the
function stop doing so, and to compensate, the second hunk, which is
in setup_revisions() that calls the function, now makes the caller
do the equivalent "argv[left++] = arg" there after it receives 0.

So "Changes have been made" to setup_revisions() to compensate for
the change of behaviour in the called function.

The enumerated point 2. (not in your response) explains why such a
corresponding compensatory change is not there for the other caller
of this function whose behaviour has changed.

> We write patch series so that they are bisectable, i.e. each commit
> should be correct (compileable, pass tests, consistent
> documentation, ...). Here, it seems you are introducing a breakage to
> repair it later.

That is a very good point to stress, but 1. is exactly to avoid
breakage in this individual step (and 2. is an explanation why the
change does not break the other caller).
