Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C46DB20D0C
	for <e@80x24.org>; Thu, 22 Jun 2017 18:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753566AbdFVSUI (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 14:20:08 -0400
Received: from mout.web.de ([212.227.17.12]:49638 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753397AbdFVSUH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 14:20:07 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M1G68-1ddhkD28Nc-00tCeM; Thu, 22
 Jun 2017 20:19:41 +0200
Subject: Re: [BUG] add_again() off-by-one error in custom format
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <xmqqtw3j68rc.fsf@gitster.mtv.corp.google.com>
 <99d19e5a-9f79-9c1e-3a23-7b2437b04ce9@web.de>
 <xmqqwp8f4mb2.fsf@gitster.mtv.corp.google.com>
 <dae96f72-761c-3ed1-4567-0933acc7618a@web.de>
 <20170615055654.efvsouhr3leszz3i@sigill.intra.peff.net>
 <ec36f9fa-5f3e-b511-3985-3d0301b4847f@web.de>
 <20170615132532.nivmj22dctowxssm@sigill.intra.peff.net>
 <b0bc9dab-bd93-c321-9f2e-f1621f857708@web.de>
 <20170618114923.bffmbr5dqe4oivyw@sigill.intra.peff.net>
 <96c26ba2-8548-1693-e803-3a3434ae3a62@web.de>
 <20170618135623.3b27zhzdxur6gpg3@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <87848e2d-9766-7dad-62cf-ded0c18f6dc3@web.de>
Date:   Thu, 22 Jun 2017 20:19:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20170618135623.3b27zhzdxur6gpg3@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:vBhMvKTV/5U5nUVettP5ByJiusNu2sas0R/AyJmG1hJoOk0YfUY
 5Q1mHT6CgUKlzkPe0tYMxxKhisGbMat6wzEYZ4WUa62lvkrS8l6Ryk1um8nVFLWq8LGKU/v
 D+JQIaRZhBL/vzMFOLhZiFd5ZYH2rEH+mXVoOMnQZ/Z6cY7aL1Vxk52KQH/CGauaLZ/B1z6
 hN5/CtLcvgsNC7ko9umvA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DA/Wb5jtBEE=:jqmPHL3Qj4J9630QWzdEZJ
 bGOWrx/VQzYVTgR81BQR1AtwC8DsbiI3gPb5DJpvU/uML5Qkuwy49Om/2d6rilw8W99v8HnbA
 jowtdodU7j+uVFyqejNmLFGLg22CnkoTL6x9ZTQlvECuHmbnIDj2EhFLj+6vACYfpGZjP2FDw
 U7oHlUMmgU6QvtEwFP0rNP6mvQCcDXKJNN3HHvXx0qW63eoLGDC7hzmqmK4qYfoBfnweSmujG
 YIikYZKEyplPrYecdpQB5UMR2xAK85JgmPygBIw18vIioWZRotSBeOgk+Wteskn+hD5SRKbxy
 Nq9/8CUki+ynzh2HNxejk7uSjlNqAhC8P8nv3xYaFyNdb3wt7jbGNuOAlg+sXXlZz8cxJ7tko
 SMhG/hI8V6sgBSyzOZIXF67lnScnfDFsb+aIokU5BLQCg1foN8OotItHfGJ5CzcGTndF+yBL1
 PTlgFStjg5Zhf8Uz9Nz8zeWWSWkVA0LM7G5LDXUKbJ20uM1wwaMaDJXoUjldT8HpiY/W7k2Gp
 XMrWbjc1hzLIRzEI2nRqA1miaNl9Nk66Kx7tM4Irm2vQNS/OC6+kjmEMAkhI1PUKInPj45W9M
 PS/sq4m2e08Y2LSZx5ytAX02rwRqeZwz0PPptgjYRDIalE71gcgaDjIaHbE64+gmVmpZ06KLJ
 TGtT/O6We0ixapfOB/XZmOnUSM5S/oaSmarWh1hFBvB+9NiBY5dIkRAmZOL0I74pX60DMUJAq
 dnsknwnjborGPbfBgjgNv/FRzYpnx2l8SeZgLxFDu9OdLZ7k+OiHEruNGkrbbucGnG9WU7DVs
 uGnp/ka
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.06.2017 um 15:56 schrieb Jeff King:
> On Sun, Jun 18, 2017 at 02:59:04PM +0200, René Scharfe wrote:
> 
>>>> @@ -1586,6 +1587,9 @@ extern struct alternate_object_database {
>>>>    	struct strbuf scratch;
>>>>    	size_t base_len;
>>>> +	uint32_t loose_objects_subdir_bitmap[8];
>>>
>>> Is it worth the complexity of having an actual bitmap and not just an
>>> array of char? I guess it's not _that_ complex to access the bits, but
>>> there are a lot of magic numbers involved.
>>
>> That would be 224 bytes more per alternate_object_database, and we'd
>> gain simpler code.  Hmm.  We could add some bitmap helper macros, but
>> you're probably right that the first version should use the simplest
>> form for representing small bitmaps that we currently have.
> 
> I'd be OK with keeping it if we could reduce the number of magic
> numbers. E.g,. rather than 32 elsewhere use:
> 
>    (sizeof(*loose_objects_subdir_bitmap) * CHAR_BIT)

We have a bitsizeof macro for that.

> and similarly rather than 8 here use
> 
>    256 / sizeof(*loose_objects_subdir_bitmap) / CHAR_BIT

If we're pretending not to know the number of bits in a byte then we
need to round up, and we have DIV_ROUND_UP for that. :)

> There's also already a bitmap data structure in ewah/bitmap.c. It's a
> little bit overkill, though, because it mallocs and will grow the bitmap
> as needed.

Yes, I feel that's too big a hammer for this purpose.

There is another example of a bitmap in shallow_c (just search for
"32").  It would benefit from the macros mentioned above.  That
might make it easier to switch to the native word size (unsigned int)
instead of using uint32_t everywhere.

But perhaps this one is actually a candidate for using EWAH, depending
on the number of refs the code is supposed to handle.

>>>> +static void read_loose_object_subdir(struct alternate_object_database *alt,
>>>> +				     int subdir_nr)
>>>
>>> I think it's nice to pull this out into a helper function. I do wonder
>>> if it should just be reusing for_each_loose_file_in_objdir(). You'd just
>>> need to expose the in_obj_subdir() variant publicly.
>>>
>>> It does do slightly more than we need (for the callbacks it actually
>>> builds the filename), but I doubt memcpy()ing a few bytes would be
>>> measurable.
>>
>> Good point.  The function also copies the common first two hex digits
>> for each entry.  But all that extra work is certainly dwarfed by the
>> readdir calls.
> 
> Yes. You're welcome to micro-optimize that implementation if you want. ;)

My knee-jerk reaction was that this would lead to ugliness, but on
second look it might actually be doable.  Will check, but I don't
expect much of a speedup.

René
