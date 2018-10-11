Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,URIBL_ABUSE_SURBL shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86D9F1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 07:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeJKOcK (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 10:32:10 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34081 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeJKOcK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 10:32:10 -0400
Received: by mail-lj1-f194.google.com with SMTP id j17-v6so7226764lja.1
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 00:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XSflUduTvfHIYXcemx/yGfVDoOEvxErj0o9YsUgZvQI=;
        b=cEIdA/gGq725AaZFVbTiL2RGCRCkKRl+4YJ3jwg85WXv+F3Dytk/C32vzAlNurv/Y3
         APG8Qncq2cG0hoN4q7ZQYcjCCJECoIz+E8SgyGLBzF2X5I97YDCh6xUv24k6+lfFQBuN
         XQrkQqtdRqu9A3PChFgfMipbsKin117t5fGp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XSflUduTvfHIYXcemx/yGfVDoOEvxErj0o9YsUgZvQI=;
        b=rpqNoJWbfpda9iSBXU0Du72ulObJgXUfixjoAPs8vBb8hxuRfDodP3dRwzZtyeqx48
         r9yYYiuLwZKy3rR+hNl6lLhuO2qEY66EqrJHq1W+tWX9XZMPLFKw4xwchIpW+Tb2eNpy
         2LS09OWcMfj5cYKNBeZ580eFRKa3W7L/PqaYhwFdzgPktHCgDBR6KgpaAhsJM5FDEXbu
         CF68+O4Pciaq/0/cdSgDtJVq2Km6H/jj03KQM3q/ar3DFHEw4nwrT3RtlM2AyOAWed/9
         e19hNpkBzOEIqOd3W1tecxvh1AhYRgHEwy3h3pbZc0rnfINUh1qDU2woKs8Ry41dD6Cf
         sJVA==
X-Gm-Message-State: ABuFfogELLicteo9FWNdqPzeiE0Ul19pTeP6aSCsGMS1f6vfBdhxT/dc
        J4hZexdpujos2j+toVpRyk6c9noX9nQ=
X-Google-Smtp-Source: ACcGV60ZVnrNM9miXPYXsrUxhvaROOURjmhbjK51M/nUtLjtNTmhses8XGAbpssUvYJRaRFXozVJag==
X-Received: by 2002:a2e:908b:: with SMTP id l11-v6mr294587ljg.25.1539241573223;
        Thu, 11 Oct 2018 00:06:13 -0700 (PDT)
Received: from [192.168.0.189] (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id y84-v6sm5491710lfa.21.2018.10.11.00.06.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 00:06:12 -0700 (PDT)
Subject: Re: [PATCH 2/3] send-email: only consider lines containing @ or <>
 for automatic Cc'ing
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
References: <20181010111351.5045-1-rv@rasmusvillemoes.dk>
 <20181010111351.5045-3-rv@rasmusvillemoes.dk>
 <871s8yez74.fsf@evledraar.gmail.com>
 <7b03da07-4301-1b42-b8a2-a29e4e1f80d0@rasmusvillemoes.dk>
 <xmqqk1mpggpq.fsf@gitster-ct.c.googlers.com>
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
Message-ID: <f5c401a6-f329-1076-ab4b-2f52915047bf@rasmusvillemoes.dk>
Date:   Thu, 11 Oct 2018 09:06:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqk1mpggpq.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-10-11 08:06, Junio C Hamano wrote:
> Rasmus Villemoes <rv@rasmusvillemoes.dk> writes:
> 
>> I considered that (and also had a version where I simply insisted on a @
>> being present), but that means the user no longer would get prompted
>> about the cases where the address was just slightly obfuscated, e.g. the
>>
>> Cc: John Doe <john at doe.com>
>>
>> cases, which would be a regression, I guess. So I do want to pass such
>> cases through, and have them be dealt with when process_address_list
>> gets called.
> 
> We are only tightening with this patch, and we were passing any
> random things through with the original code anyway, so without
> [PATCH 3/3], this step must be making it only better, but I have to
> wonder one thing.
> 
> You keep saying "get prompted" but are we sure we always stop and
> ask (and preferrably---fail and abort when the end user is not
> available at the terminal to interact) when we have such a
> questionable address?
> 

I dunno. I guess I've never considered non-interactive use of
send-email. But the ask() in validate_address does have default q[uit],
which I suppose gets used if stdin is /dev/null? I did do an experiment
adding a bunch of the random odd patterns found in kernel commit
messages to see how send-email reacted before/after this, and the only
things that got filtered away (i.e., no longer prompted about) were
things where the user probably couldn't easily fix it anyway. In the
cases where there was a "Cc: stable" that might be fixed to the proper
stable@vger.kernel.org, the logic in extract_valid_address simply saw
that as a local address, so we didn't use to be prompted, but simply
sent to stable@localhost. Now we simply don't pass that through. So, for
non-interactive use, I guess the effect of this patch is to allow more
cases to complete succesfully, since we filter away (some) cases where
extract_valid_address would cause us to prompt (and thus quit).

So, it seems you're ok with this tightening, but some comment on the
non-interactive use case should be made in the commit log? Or am I
misunderstanding?

Thanks,
Rasmus
