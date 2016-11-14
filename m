Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3F9A1F858
	for <e@80x24.org>; Mon, 14 Nov 2016 19:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934507AbcKNTIZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 14:08:25 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:33393 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753133AbcKNTIY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 14:08:24 -0500
Received: by mail-pg0-f49.google.com with SMTP id 3so57188165pgd.0
        for <git@vger.kernel.org>; Mon, 14 Nov 2016 11:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=ntRp92lzoANm+1XdkQ6k97NuptaIp5xfHfW3VmrGXRQ=;
        b=FjH6hQ30twGw8Agq6eqZW7jhXfC5zQl3Xfyoi2hcVnOaN7cMnMPAjtC9FhutzPRel3
         FEC6w2KSdFGlxPx6cW9kMjhHoDHnJTQlj87ySx3EonyQAjEDBh8x8u3pNh0AjFjn8wKf
         McakrWf9yV5HMZORVtGLAl/ez45edaYKpfMA9rZTSRwZb2Ohc9EE8e3NxWyxGMxZ/kVH
         F4lTOTEZcxTMfqh0PBZrB6Wi1fSddSAyLJudc5prAgpRPcQ0CRf8+7kgyz9TUPwZW1eH
         OHnw7AMuzxK5w0+tJlktxtr46DMCgIdlEFTZJIvbE92ySq5/Za5NdrQEw1S8wDgZWaH5
         XTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=ntRp92lzoANm+1XdkQ6k97NuptaIp5xfHfW3VmrGXRQ=;
        b=F57WiIjOAbcDtGH+seG86dBrKPbwZanVr0bl3BPPXH5Fox/sLX2MexYRXJAjBW0IQd
         buuvR193vavcYxBZL+COCZgG6a4Tsn4G88U9Vf/1cO7rJUZIwbPFgaf0w0CAmMhxenhT
         q1TdLG7oBT0hhCffre2zv8XQbQt+nWQbmaBcf99p8rNyE9I3yAJc2qgZ9ssGAgIcLTK5
         gKUED89RwEegFSKmYyzJP/rtwJer54EJ0mV7r9GF9w1z0a1fLvXYUxDEmuvskqIo430b
         H2ZA1ejh57CwcImeRDAnv5v3oEDSKYPNNhUjH2vB7QLjMuBqpmmsXKagjTYeQ/W9V9Fk
         s6Sw==
X-Gm-Message-State: ABUngveBRqR0yYGydfh7aDTiAecW+dzVrxLO8EK1y57ON5d9V/FBIxABdJT1k2tRdxpYuZFe
X-Received: by 10.99.167.67 with SMTP id w3mr71929789pgo.1.1479150503243;
        Mon, 14 Nov 2016 11:08:23 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:1c50:6e1d:7dd:6ec1])
        by smtp.gmail.com with ESMTPSA id g82sm36996177pfb.43.2016.11.14.11.08.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Nov 2016 11:08:22 -0800 (PST)
Subject: Re: [PATCH v3 5/6] grep: enable recurse-submodules to work on <tree>
 objects
To:     Junio C Hamano <gitster@pobox.com>
References: <1477953496-103596-1-git-send-email-bmwill@google.com>
 <1478908273-190166-1-git-send-email-bmwill@google.com>
 <1478908273-190166-6-git-send-email-bmwill@google.com>
 <xmqqk2c6x79c.fsf@gitster.mtv.corp.google.com>
 <c83066bc-5b2b-998c-7e22-c4fccbaba5de@google.com>
 <xmqqfumtyjoy.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <5a60b630-15fc-6b63-fb03-25aa0d1ef081@google.com>
Date:   Mon, 14 Nov 2016 11:08:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqfumtyjoy.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/14/2016 10:56 AM, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
>
>>>> to:
>>>> HEAD:file
>>>> HEAD:sub/file
>>>>
>>>> Signed-off-by: Brandon Williams <bmwill@google.com>
>>>> ---
>>>
>>> Unrelated tangent, but this makes readers wonder what the updated
>>> trailer code would do to the last paragraph ;-).  Does it behave
>>> sensibly (with some sane definition of sensibleness)?
>>>
>>> I am guessing that it would, because neither To: or HEAD: is what we
>>> normally recognize as a known trailer block element.
>>
>> Yes, it behaves sensibly :-) because "Signed-off-by:" is preceded by a
>> blank line, so the trailer block consists only of that line.
>
> Oh, that was not what I was wondering.  Imagine Brandon writing his
> message that ends in these three questionable lines and then running
> "commit -s --amend" to add his sign-off---that was the case I was
> wondering.

Ah, I see. In that case, it would consider the last block as a trailer 
block and attach it directly:

   to:
   HEAD:file
   HEAD:sub/file
   Signed-off-by: ...

It is true that neither to: nor HEAD: are known trailers, but my patch 
set accepts trailer blocks that are 100% well-formed regardless of 
whether the trailers are known (to provide backwards compatibility with 
git-interpret-trailers, and to satisfy the certain use cases that I 
brought up). The "known trailer" check is used when the trailer block is 
not 100% well-formed.

This issue can be avoided if those lines were indented with at least one 
space or at least one tab.
