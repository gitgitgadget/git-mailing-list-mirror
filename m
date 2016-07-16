Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C659A203BD
	for <e@80x24.org>; Sat, 16 Jul 2016 06:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbcGPG2h (ORCPT <rfc822;e@80x24.org>);
	Sat, 16 Jul 2016 02:28:37 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36374 "EHLO
	mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbcGPG2f (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2016 02:28:35 -0400
Received: by mail-it0-f68.google.com with SMTP id h190so2611404ith.3
        for <git@vger.kernel.org>; Fri, 15 Jul 2016 23:28:35 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LI7D7J4zzJ0yX+0gnTLUhpZfkjVeuHIa837h/x8kSIU=;
        b=eFeqEjA3cjiQryu7vFVl3wUsdp5TWwbS5n/5yUMZyJkR4gUkYm5zx33p8z5gF0E0b9
         PxwXHg1LT5ie7pou3LRGqanRLLwOd4ILFD5XS8joSDHdc7+QjVSeOwN403cRZBsO6CyN
         NukO9LV3aPcpe3WlRwJQd/HpSBGefmtElvjqv4WX7p6WaUSjRoBXb9W1joOvplP9fHgF
         byzjjWDFNO2DYm+Zt50/qdkg4SAOxc6UMvPzhL6c5lQ9opfYyC6hDpe3pf/45zh3YYj5
         gQCzI91kicbFz5jPcTeNzFLnFIe4Sv1kdWWbDQrxYlU43r+1l/4tX7jfaBoI00HjyG5v
         oJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LI7D7J4zzJ0yX+0gnTLUhpZfkjVeuHIa837h/x8kSIU=;
        b=LZ8TcJNBGGPfuhzuYp7kPC4Vn8iYV8NtbxZS+X36YJni5J2DZntVmnAlQCyVHI1u6e
         6JX3VydJrERKvvvOOv90TbS+MLx4o5jIfkBmErOXIe/Wa6mHTV+Ikml6MoWvpZmv+1gE
         ipKTJ9WJQMR10fUAQzc8GzLCR9wen67xhIdr2hYCjXTp9hzO6gc53h7Z2VeJ20tn0HdO
         k+zFC0hC8hw1KbdyxIye9mOk/W6VXIIYlb5rYQRPCztZnQGCzujv+f6Rlu8ZR/LzyvdC
         9/LxoUpJuTqpBrUGaw3HfMh7VbLyT6JxiCR1BQ8sdWWn1yqr1aQUtO97J2i1C36DTYs6
         qdog==
X-Gm-Message-State: ALyK8tIQnMKLDYEH45ahCnGNnrvWdCHVEm2MUGfVcOj9H4AbtbRRxV8ThOkeJuYsWiHuydBjfyLkVGIcmlU4Bw==
X-Received: by 10.36.84.79 with SMTP id t76mr39751151ita.63.1468650515076;
 Fri, 15 Jul 2016 23:28:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Fri, 15 Jul 2016 23:28:05 -0700 (PDT)
In-Reply-To: <xmqqlh13onik.fsf@gitster.mtv.corp.google.com>
References: <xmqq7fcoot6t.fsf@gitster.mtv.corp.google.com> <20160714204357.2628-1-gitster@pobox.com>
 <20160714204357.2628-3-gitster@pobox.com> <20160714222047.GA21868@sigill.intra.peff.net>
 <xmqqlh13onik.fsf@gitster.mtv.corp.google.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Sat, 16 Jul 2016 08:28:05 +0200
Message-ID: <CACsJy8BMn=1SqU5zpALm1KAPwjFjnbm43aaf-FKH6vdAzHjS5g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] archive-tar: huge offset and future timestamps
 would not work on 32-bit
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 15, 2016 at 12:36 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Thu, Jul 14, 2016 at 01:43:57PM -0700, Junio C Hamano wrote:
>>
>>> As we are not yet moving everything to size_t but still using ulong
>>> internally when talking about the size of object, platforms with
>>> 32-bit long will not be able to produce tar archive with 4GB+ file,
>>> and cannot grok 077777777777UL as a constant.  Disable the extended
>>> header feature and do not test it on them.
>>
>> I tried testing this in a VM with 32-bit Debian. It fixes the build
>> problems, but t5000 still fails.
>
> Thanks for testing.  I need to find some time hunting for (or
> building) an environment to do that myself.

If you are on a distro with multilib, building git with "CFLAGS=-m32
LDFLAGS=-m32" should do it. That's how i tested the 32-bit offset
truncation thing. I may pursue the docker thing soon. At least then
you only need to install docker and just build/test (zero docker
configuration, assuming all the relevant kernel options are enabled).
-- 
Duy
