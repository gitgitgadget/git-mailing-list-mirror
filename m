Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8D211F453
	for <e@80x24.org>; Thu,  2 May 2019 13:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfEBN0R (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 09:26:17 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42960 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfEBN0R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 09:26:17 -0400
Received: by mail-qk1-f196.google.com with SMTP id x19so1385123qki.9
        for <git@vger.kernel.org>; Thu, 02 May 2019 06:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UOS6txvplzKSH56fPr1ttCc1PXEo5FLGUIcDP6s2B2Y=;
        b=o7rsgCH4i5/oKVKs/Mv7l67kLZ1H1twqM0XGppqA55WXU3ZciCy7KsRxyAVNSQkjtC
         jGR3jxWZzLvM2uLQvTBWB4IK5rF5h35Lwpz+daiGwdUdbJWKzFz48lAvuH/g+0uEsuGe
         9S/9AjJOYv0j/MlSppxnHSSfnr5ZywcYwZQwIQcdu3sBQT261CNsfZ7VPGlq/GDWXsy7
         T7pbD9nHYbH74keO7hQ6gUdbPHLRuCoqoXPuV5V7A2XjmMFxtQGMEjndVfdI88n+mS8H
         /OhJA1/Qq+LCUWLnww2jxpV8BRT9EkZtuWljYvUX8GZULmrXAHzA352dYCPX1F5RO1z9
         M7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UOS6txvplzKSH56fPr1ttCc1PXEo5FLGUIcDP6s2B2Y=;
        b=qudY5UgUW3oy3BpbqYP+wonl6+MdPVI9wyKT1eWP+DVqDX3462LOfdu5HX4WGKqUUJ
         JQ5UAIzFrHGFsxI2hjYAfAuCywR7O+PNCWTpbbp23EbDfCMNIXdGHbwW89ySBpxVJUwC
         7RTOqxY7IyoAJaEvEveUX0YZTdA0nrNtME9uK/Y6Hu2/ZPyAjwa9ZBAQp5wzSk/KbKMs
         MDIoFIZiCglxBCsgpoFNuA2Vj1CX8dJk6vD+oSf1G9CrHgTWSoQ4JHHe/63dpJY2rD5h
         Zrcb4GphdRrX6cAxvfSfmPyDPS8MKhBW5gFg00J23BUFPdLICu0HAKPYQg0zytMfg+mG
         bJ0g==
X-Gm-Message-State: APjAAAWZ7iLI1H0Q4IoxS4ASlMGKxQhjoJR+/19IUvlaMrqM9oehtbpB
        baCeWDBkOWhxk90wUAPrcHE=
X-Google-Smtp-Source: APXvYqyY1BP36pDWlfpVIz/eJE6grmTgWdiziMZ+5Uo04GyiQPATeAhfr4zF8/yDVVU2W9Lx5YI7+Q==
X-Received: by 2002:a05:620a:1359:: with SMTP id c25mr2809931qkl.52.1556803575975;
        Thu, 02 May 2019 06:26:15 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:347e:1c90:5ef8:d4bc? ([2001:4898:8010:2:1db2:1c90:5ef8:d4bc])
        by smtp.gmail.com with ESMTPSA id q56sm2287693qtk.72.2019.05.02.06.26.14
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 06:26:14 -0700 (PDT)
Subject: Re: [PATCH v3 0/6] Create commit-graph file format v2
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        Junio C Hamano <gitster@pobox.com>
References: <pull.112.v2.git.gitgitgadget@gmail.com>
 <pull.112.v3.git.gitgitgadget@gmail.com> <87lfzprkfc.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bb0c22f9-9d0b-0fa6-e826-8e2ac146c6f9@gmail.com>
Date:   Thu, 2 May 2019 09:26:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <87lfzprkfc.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/1/2019 4:25 PM, Ævar Arnfjörð Bjarmason wrote:
> I won't repeat my outstanding v2 feedback about v1 & v2
> incompatibilities, except to say that I'd in principle be fine with
> having a v2 format the way this series is adding it. I.e. saying "here
> it is, it's never written by default, we'll figure out these compat
> issues later".
> 
> My only objection/nit on that point would be that the current
> docs/commit messages should make some mention of the really bad
> interactions between v1 and v2 on different git versions.

Good idea to add some warnings in the docs to say something like
"version 2 is not supported by Git 2.2x and earlier".

> However, having written this again I really don't understand why we need
> a v2 of this format at all.

[snip]

> How about we instead just don't change the header? I.e.:
> 
>  * Let's just live with "1" as the marker for SHA-1.
> 
>    Yeah it would be cute to use 0x73686131 instead like "struct
>    git_hash_algo", but we can live with a 1=0x73686131 ("sha1"),
>    2=0x73323536 ("s256") mapping somewhere. It's not like we're going to
>    be running into the 255 limit of hash algorithms Git will support any
>    time soon.

This was the intended direction of using the 1-byte value before, but
we have a preferred plan to use the 4-byte value in all future file formats.

>  * Don't add the reachability index version *to the header* or change
>    the reserved byte to be an error (see [1] again).

Since we can make the "corrected commit date" offset for a commit be
strictly larger than the offset of a parent, we can make it so an old client
will not give incorrect values when we use the new values. The only downside
would be that we would fail on 'git commit-graph verify' since the offsets
are not actually generation numbers in all cases.

> Instead we just add these things to new "chunks" as appropriate. As this
> patch of mine shows we can easily do that, and it doesn't error out on
> any existing version of git:
> https://github.com/avar/git/commit/3fca63e12a9d38867d4bc0a8a25d419c00a09d95

I like the idea of a "metadata" chunk. This can be useful for a lot of things.
If we start the chunk with a "number of items" and only append items to the
list, we can dynamically grow the chunk as we add values.

> I now can't imagine a situation where we'd ever need to change the
> format. We have 32 bits of chunk ids to play with, and can have 255 of
> these chunks at a time, and unknown chunks are ignored by existing
> versions and future version.

The solutions you have discussed work for 2 of the 3 problems at hand.
The incremental file format is a high-value feature, but _would_ break
existing clients if they don't understand the extra data. Unless I am
missing something for how to succeed here.

> 1. See feedback on the v2 patch in
>    https://public-inbox.org/git/87muk6q98k.fsf@evledraar.gmail.com/

My response [2] to that message includes the discussion of the
incremental file format.

[2] https://public-inbox.org/git/87muk6q98k.fsf@evledraar.gmail.com/


