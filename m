Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D31420193
	for <e@80x24.org>; Thu, 27 Oct 2016 20:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934542AbcJ0U5c (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 16:57:32 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:36022 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751152AbcJ0U5b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 16:57:31 -0400
Received: by mail-qk0-f175.google.com with SMTP id o68so63208846qkf.3
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 13:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FEQd41xA8loVu3k79pS3EtfPEPYXlDakce3AID01Vzs=;
        b=SNwacD4ZVyucTrr8zBk/pPtRT/bMIRpHzSxLTywSPWwBazIXccbDNKrcq0hGIOL1gk
         Ul9q/2bDNJWZXCVD8LzYFwOhK3/sX0uHTrRwC1yxs5NVbK1ZMJPqGYqje4bQPZx2gaYV
         N2XD3hXoWBFrypzPNbA262tESHcWqiqUGhcBtrK8vWQ3ow4PM65qnsWt4+wm+MufOPPJ
         cRcp9xNqLY0gB8q6QKFD6fALOaU7rQKF8NdVZoUO+k0f4mC4XiT6G2SmgMP1CnLjE7ea
         dbMv2ncEjSVRvnZpbTebXBCOYBcJzm0ZQQmXaWiXtyPrStCAATz+1xSSUc9YgQaabnY0
         4ywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FEQd41xA8loVu3k79pS3EtfPEPYXlDakce3AID01Vzs=;
        b=DE5pUcMYtY0B/BfisGdltAJW4R29Cee8koDIxz4Ojv8ouXIwze6czldxgY3jCAPrXB
         4YdREIUUPWNxQoz1nZi+nFK3hT1QeRT5/KBcHkva46peiZ+mTu9FbgIC49CH0T9Y/eW0
         95joPTZcYmr6MWf7thY9mH523JPX9yvdvZahuXipQ1f5M0S9O3bYCVooSHQDFXZSqkW2
         gHlNnTqqe4AYuAzosM4jZDazMOCPvLhGBS8bRigP51DeJKhJn3H8PlFQnYvZqmmROZHP
         AsRfyZUq/68oKcfrjFVT+Yp/EX8V00g1Z/bThibV9Mc34rwLbP5N/GJ3c0t7kRxzQDoW
         +QYQ==
X-Gm-Message-State: ABUngvf1vdKGlgV8dEUzEiz5j6lz2EI6pgxNaH2lsgwic+3UmgvUpRkiXQRPaBXZsANw0Td3e064mEw3nZYVM8K3
X-Received: by 10.55.184.2 with SMTP id i2mr8360180qkf.47.1477601850424; Thu,
 27 Oct 2016 13:57:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Thu, 27 Oct 2016 13:57:30 -0700 (PDT)
In-Reply-To: <CAGZ79ka_zr_NXKoxC45swFrj168fP6S7_nQ1jjcfPOtTN4Jd1A@mail.gmail.com>
References: <20161022233225.8883-1-sbeller@google.com> <20161022233225.8883-18-sbeller@google.com>
 <0425fea3-3419-c265-b964-f5a309b867fa@ramsayjones.plus.com> <CAGZ79ka_zr_NXKoxC45swFrj168fP6S7_nQ1jjcfPOtTN4Jd1A@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 27 Oct 2016 13:57:30 -0700
Message-ID: <CAGZ79kb+BRPPA8NGKXq_9cb_ob9CK0vkuX0gZV7-qJ-pcYVCzg@mail.gmail.com>
Subject: Re: [PATCH 17/36] attr: expose validity check for attribute names
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 24, 2016 at 2:07 PM, Stefan Beller <sbeller@google.com> wrote:
> On Sun, Oct 23, 2016 at 8:07 AM, Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
>>
>>
>> On 23/10/16 00:32, Stefan Beller wrote:
>>> From: Junio C Hamano <gitster@pobox.com>
>>>
>>> Export attr_name_valid() function, and a helper function that
>>> returns the message to be given when a given <name, len> pair
>>> is not a good name for an attribute.
>>>
>>> We could later update the message to exactly spell out what the
>>> rules for a good attribute name are, etc.
>>>
>>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>>> Signed-off-by: Stefan Beller <sbeller@google.com>
>>> ---
>>
>> [snip]
>>
>>> +extern int attr_name_valid(const char *name, size_t namelen);
>>> +extern void invalid_attr_name_message(struct strbuf *, const char *, int);
>>> +
>>
>> The symbol 'attr_name_valid()' is not used outside of attr.c, even
>> by the end of this series. Do you expect this function to be used
>> in any future series? (The export is deliberate and it certainly
>> seems like it should be part of the public interface, but ...)
>>

refactoring this series again, I will make use of attr_name_valid
outside of attr.c, so I'll keep this patch.
