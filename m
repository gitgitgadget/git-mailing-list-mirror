Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDBE81F461
	for <e@80x24.org>; Mon,  1 Jul 2019 12:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbfGAMZR (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 08:25:17 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44986 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbfGAMZQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 08:25:16 -0400
Received: by mail-qk1-f195.google.com with SMTP id p144so10733246qke.11
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 05:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QVI/3eK/SntC0HTd1jeFNI5jB81V89nxhSvD+uuQovk=;
        b=RtqnSfIbdw9oOW+OSd7XZiY1U6oRlknVjU+rL3eu3Q1Nv2LJeH0xIDXZv4MadNUac6
         ccCHsPSVnRipJS0dJqMp41npSf8gZPAbySkOjgcR9P/0g56RO3HOqg06mWL7Emzn1FCI
         yE3vIhvUfjhSH2MmStHf6FEkntn16YowEvFI+xkZflo2vvQNR87CCYLzn65UOWrqjNrq
         TTtyKIND5K2lERuhxire5klVVrrWNjvx9OTuT5bCnMRSSrw/EkzBCFmJDDKS+jDiaNFe
         hF+cfta7mi8ikWGxdxcUp5rlWAdkiKL/JF5QpqkG+yX+O0yxeH9aaxeuYc3LD18lE4ln
         Jh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QVI/3eK/SntC0HTd1jeFNI5jB81V89nxhSvD+uuQovk=;
        b=XkFu3fqoUwQql9/+iPocH67A/cliVWWF8Ps9iSqx+ngKtWo1LFj9fOAQodK8MQFsFO
         Ild3e1l9JAEhjIKTeevu0PJV82/QmlvLOGrVHM05Yd4FhDLgS6KOMO2rc1kskBnYDOYv
         U7UmB6CdSvYVUh2v7TK94ZG/8AUWWslTR0RtCNOQfw8rRorLQyJYEIfcJsHaibNcSKEz
         7JXuHGZBlTI+BOxWfDI4mlSyjd0DjSrbwXnC3X+WmCEuD1YOiHn+1CqyT3KBTN0BnWbv
         Ky2XVQZopdD555Ncw4rp/at3nDvMIobxRMLbHc8sm8VcBqSHv1K2CjWBi/qHporNRg0V
         Z6wA==
X-Gm-Message-State: APjAAAWU+zybFrIBnu6FuwrMoWYr2q6xhcbYyaQOrg+pFZKKtYPLPmAe
        OqVQTU9XR2ApejLR6s9U+QE=
X-Google-Smtp-Source: APXvYqxs8lDaUm0wKubAKJOQJkSMG9BhYUvfB9P4mFnm757ajd89n1JbpD+LU0t9WUZOOkVnHX8bDg==
X-Received: by 2002:a37:97c1:: with SMTP id z184mr11289003qkd.198.1561983915799;
        Mon, 01 Jul 2019 05:25:15 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:8d39:716e:a6fa:35c4? ([2001:4898:a800:1012:3e6d:716e:a6fa:35c4])
        by smtp.gmail.com with ESMTPSA id v41sm5403165qta.78.2019.07.01.05.25.15
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 05:25:15 -0700 (PDT)
Subject: Re: [PATCH] check_everything_connected: assume alternate ref tips are
 valid
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
References: <20190628101131.GA22862@sigill.intra.peff.net>
 <601d8561-6e24-559c-6fbb-fa25a7389fa0@gmail.com>
 <20190629074348.GA5080@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <418213f2-82d6-f7bd-7379-7f20f0e83084@gmail.com>
Date:   Mon, 1 Jul 2019 08:25:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190629074348.GA5080@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/29/2019 3:43 AM, Jeff King wrote:
> On Fri, Jun 28, 2019 at 08:51:04AM -0400, Derrick Stolee wrote:
> 
>> On 6/28/2019 6:11 AM, Jeff King wrote:
>>> When we receive a remote ref update to sha1 "X", we want to check that
>>> we have all of the objects needed by "X". We can assume that our
>>> repository is not currently corrupted, and therefore if we have a ref
>>> pointing at "Y", we have all of its objects. So we can stop our
>>> traversal from "X" as soon as we hit "Y".
>>>
>>> If we make the same non-corruption assumption about any repositories we
>>> use to store alternates, then we can also use their ref tips to shorten
>>> the traversal.
>>
>> I was confused by this paragraph, because I didn't know about
>> for_each_alternate_ref() and how refs_From_alternate_cb() will
>> strip the "/objects" and append "/refs" to check refs if they
>> exist. All of that logic is in transport.c but used by
>> fetch-pack.c and builtin/receive-pack.c. But now we are adding
>> to revision.c, so the restriction to "this helps data transfer"
>> is getting murkier.
> 
> Using it for data transfer is still the main thing for our internal
> calls, but I think it's worth exposing it for general use via rev-list.
> I imagine it would mostly be for poking around and debugging, but it
> should allow things like:
> 
>   # what do we have that our alternate does not
>   git rev-list --all --not --alternate-refs

So this is an example where the alternate refs are being used without
any network activity.

>> Is this something that should be extracted to the object-store
>> layer? Or is it so tricky to use that we shouldn't make it too
>> easy to fall into a bad pattern?
> 
> I'm not sure what you have in mind, exactly. If you are asking whether
> there are more places that alternate refs could be used, I can't think
> of any. If you are asking whether this is in the wrong place, no, I
> think it's the right place. :)

Just double-checking that it is appropriate for revision.c to take
dependence on transport.h instead of moving the alternate ref stuff
into a different header file. I trust your opinion.

-Stolee
