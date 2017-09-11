Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E6521FAD6
	for <e@80x24.org>; Mon, 11 Sep 2017 12:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751672AbdIKMeq (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Sep 2017 08:34:46 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35997 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751013AbdIKMep (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2017 08:34:45 -0400
Received: by mail-qk0-f195.google.com with SMTP id i14so5311776qke.3
        for <git@vger.kernel.org>; Mon, 11 Sep 2017 05:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hDQlLCrOHAxxpcAF5h8U6ZB3lRWhkKEb5/dN4lW/WDc=;
        b=mKiJpFJpfD4NgopVoFDjptVhS9zGG+fAY190ZRQUxcz6vTyU8GPuGBfpUe/1ihnZ4D
         wD8DhuoGBS3JAN1YPWm2ZVP2UvWxgM8cToQaZ8b4tLpYPac1EMWiImvhXBVVWfkjfCWF
         YB3+QxqTBT0eWqnSxm83jbKsxaXN/I7j8S7UYdfojBqRp0j8GS6hAAhPfht2T4kILreu
         xFqUYztARqSaWxWERyYDBSD3GH5TM1xGTxCVL9V9QIR0OzaiOjuWJNHY8YQeVFvVFb/z
         AtQBGTSPu5lIYmjwOqG8lHlRv5JXPmhgHVK9uYtL4huAQCFCjawgsZ7LX+XLQ4nwFmrB
         wNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hDQlLCrOHAxxpcAF5h8U6ZB3lRWhkKEb5/dN4lW/WDc=;
        b=e4Pb6nM/JqHeeVyAnghDnT46cII3NL8rTWIGEsabdve7bVN8GWPUcOKMnxNC2uZbdf
         8WLrKOQ02EFKQSg1g2yJXZxhOpjMbzYtgYhybD03v6X879bszbg517Kgn4DIVtSKrLbp
         nLzkCKb72Zxe5s7eD9XBfCKebzi1hCrecHuLQqnOEDLnAwG0qtEpu+FhZUw2FQs0OQvE
         rYnHLbHL+4NfMGBWSSfQDKOhFahhqyJ3bK5dNyHsel+/ZcDiPyhuoEtcaXUTlZ691lUc
         eQ/het795/ZGx2pX/auhlZWhJM+uEheGb7CAFvZnskx58LGesIuGOOLwevyMvdty4QnS
         DtVA==
X-Gm-Message-State: AHPjjUjEIjy8RYq2LPm56AVL6Fyt0Yit/6XcbaIAqBkGpgrmrHeS9dVw
        uwyuHlWHB69zRA==
X-Google-Smtp-Source: AOwi7QBeu10rzRpkmBKaDiAq23HcovyIaTD0GV46SSlG9DcHBCkPJN1sWhNC3uzKrNZoK8sU01pfog==
X-Received: by 10.55.76.134 with SMTP id z128mr15604657qka.346.1505133284088;
        Mon, 11 Sep 2017 05:34:44 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id x194sm6287996qkx.74.2017.09.11.05.34.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Sep 2017 05:34:42 -0700 (PDT)
Subject: Re: [PATCH v2] sub-process: print the cmd when a capability is
 unsupported
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
References: <20170816124036.25236-1-chriscool@tuxfamily.org>
 <758d36a7-8066-7e1a-30d0-62baf2796520@gmail.com>
 <xmqq4lt7pir9.fsf@gitster.mtv.corp.google.com>
 <xmqqshgri3dv.fsf@gitster.mtv.corp.google.com>
 <xmqqlgll5300.fsf@gitster.mtv.corp.google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <29df9cf1-c75e-9d0f-7163-aee4ebec4527@gmail.com>
Date:   Mon, 11 Sep 2017 08:34:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqlgll5300.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/10/2017 11:27 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> I still think we would want to turn warning() to die(), but it
>> probably is better to do so in a separate follow-up patch.  That
>> will give us a good place to record the reason why the current "just
>> call a warning() and pretend as if nothing bad happend" is wrong.
> 
> And here is such an update.  It seems that pretty much all comments
> in the original thread were "warning is wrong--we should die here",
> but nobody seems to have bothered following it through.
> 
> cf. <20170815111725.5d009b66@twelve2.svl.corp.google.com>
> 
> -- >8 --
> Subject: [PATCH] subprocess: loudly die when subprocess asks for an unsupported capability
> 
> The handshake_capabilities() function first advertises the set of
> capabilities it supports, so that the other side can pick and choose
> which ones to use and ask us to enable in its response.  Then we
> read the response that tells us what choice the other side made.  If
> we saw something that we never advertised, that indicates one of two
> things.  The other side, i.e. the "upgraded" filter, is not paying
> attention of the capabilities advertisement, and asking something
> its correct operation relies on, but we are not capable of giving
> that unknown feature and operate without it, so after that point the
> exchange of data is a garbage-in-garbage-out.  Or the other side
> wanted to ask for one of the capabilities we advertised, but the
> code has typo and their wish to enable a capability that its correct
> operation relies on is not understood on this end.  The result is
> the same garbage-in-garbage-out.
> 
> Instead of sweeping such a potential bug under the rug, die loudly
> when we see a request for an unsupported capability in order to
> force sloppily-written filter scripts to get corrected.
> 

The documentation states "Git expects to read a list of desired
capabilities, ***which must be a subset of the supported capabilities 
list*** and a flush packet as response:"

Anything else is clearly a bug so a "die" is more appropriate than a 
warning.

Patch looks good.  Thanks for making sure this didn't fall through the 
cracks.

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   sub-process.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sub-process.c b/sub-process.c
> index fcc4832c14..ec9a51b7b1 100644
> --- a/sub-process.c
> +++ b/sub-process.c
> @@ -181,8 +181,8 @@ static int handshake_capabilities(struct child_process *process,
>   			if (supported_capabilities)
>   				*supported_capabilities |= capabilities[i].flag;
>   		} else {
> -			warning("subprocess '%s' requested unsupported capability '%s'",
> -				process->argv[0], p);
> +			die("subprocess '%s' requested unsupported capability '%s'",
> +			    process->argv[0], p);
>   		}
>   	}
>   
> 
