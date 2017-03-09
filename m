Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BAF5202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 19:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754526AbdCITOf (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 14:14:35 -0500
Received: from mail-ua0-f174.google.com ([209.85.217.174]:36737 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753196AbdCITOe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 14:14:34 -0500
Received: by mail-ua0-f174.google.com with SMTP id 72so90583020uaf.3
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 11:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=42HTtMyhyTtqhkhwkrtyE4Hgl13AXTBoyVAv5j8h6EQ=;
        b=M1JhJdUkUVCXPRLUgs2HP2tb7TkfvjabEajuQIKLTSRkEjmMZfPBVIFrIvU4+DF1eT
         WvTHkW7Pi+5qTXlAMY9mlXQPqCDilpAyqtcv8MNPY2RZndoxzI4MADiZGNWtyeIpcs/S
         9tXZHCto1/7zr/QZtc4ONUDT3S/8ziYYEsGtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=42HTtMyhyTtqhkhwkrtyE4Hgl13AXTBoyVAv5j8h6EQ=;
        b=rgxpnh3yOp2Wy3qEU8ghQLtLkhX9qUiePVWsDItLSoxvf2vHVUXM4nIIjLM0WA9RKG
         ngDE2iqgZVqOwdjfrYPKcNvxpOFEFsxLxyxwRaUPcBeSxOwgqsIsC7x6UDOhSLyLLXJg
         lHiFIyQVn8knW76rAgyvE39HQyBhnsrdl9oMLqwp+hEaF2BfYs//Ft5TQpyTJ/UAlsyw
         2+N92E2JVPpv+5HCl4pEK+2oOCCKZpwgdbLMhYK/cQ2ZNEue1K78vyC8xT8GlFRfj6BW
         Y8SV9qLE+5OD9p5TH/Twmj+GQ5/G//QcOCOxTrCI7Sn0/HFUmr4+6OCZhNX8YnQoGxul
         94GQ==
X-Gm-Message-State: AMke39kViJ+1WRLOCktdtO5IQ4fomD5wljmkbZrdTZSXXVj4ZZLK66JixCyTZXunFjZLyrrfgwc+Gm4uYYCwZQ==
X-Received: by 10.176.91.69 with SMTP id v5mr7753092uae.144.1489086872790;
 Thu, 09 Mar 2017 11:14:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.103.125.7 with HTTP; Thu, 9 Mar 2017 11:14:12 -0800 (PST)
In-Reply-To: <20170307001709.GC26789@aiede.mtv.corp.google.com>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com> <20170307001709.GC26789@aiede.mtv.corp.google.com>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Thu, 9 Mar 2017 11:14:12 -0800
Message-ID: <CAJo=hJtoX9=AyLHHpUJS7fueV9ciZ_MNpnEPHUz8Whui6g9F0A@mail.gmail.com>
Subject: Re: RFC v3: Another proposed hash function transition plan
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, bmwill@google.com,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 6, 2017 at 4:17 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Linus Torvalds wrote:
>> On Fri, Mar 3, 2017 at 5:12 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>
>>> This document is still in flux but I thought it best to send it out
>>> early to start getting feedback.
>>
>> This actually looks very reasonable if you can implement it cleanly
>> enough.
>
> Thanks for the kind words on what had quite a few flaws still.  Here's
> a new draft.  I think the next version will be a patch against
> Documentation/technical/.

FWIW, I like this approach.

> Alongside the packfile, a sha3 repository stores a bidirectional
> mapping between sha3 and sha1 object names. The mapping is generated
> locally and can be verified using "git fsck". Object lookups use this
> mapping to allow naming objects using either their sha1 and sha3 names
> interchangeably.

I saw some discussion about using LevelDB for this mapping table. I
think any existing database may be overkill.

For packs, you may be able to simplify by having only one file
(pack-*.msha1) that maps SHA-1 to pack offset; idx v2. The CRC32 table
in v2 is unnecessary, but you need the 64 bit offset support.

SHA-1 to SHA-3: lookup SHA-1 in .msha1, reverse .idx, find offset to
read the SHA-3.
SHA-3 to SHA-1: lookup SHA-3 in .idx, and reverse the .msha1 file to
translate offset to SHA-1.


For loose objects, the loose object directories should have only
O(4000) entries before auto gc is strongly encouraging
packing/pruning. With 256 shards, each given directory has O(16) loose
objects in it. When writing a SHA-3 loose object, Git could also
append a line "$sha3 $sha1\n" to objects/${first_byte}/sha1, which
GC/prune rewrites to remove entries. With O(16) objects in a
directory, these files should only have O(16) entries in them.

SHA-3 to SHA-1: open objects/${sha3_first_byte}/sha1 and scan until a
match is found.
SHA-1 to SHA-3: brute force read 256 files. Callers performing this
mapping may load all 256 files into a table in memory.
