Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5E3C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 11:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236310AbhLILEc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 06:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbhLILEb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 06:04:31 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FACC061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 03:00:58 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id v11so8950402wrw.10
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 03:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8K18yxweY4gFUc5IPSjf6KUr1KTvjVNeucp6N+wAMbI=;
        b=hkIj+jHsCKPlQC/hMQxhi/Hi8OM8m59IWnBokRAmZlaPGJjnlbDhOfZWk8aTJ1PdhB
         pE/aJNp5Le1l6IZ+biaEHfTD2e5ob8hRigJarnalrG4C5mZFj0kXfuR4pymKFQd2hAJ/
         5hjnhneJHoUqKn4r+48B43U1iYNFFYmO//DsLo5YWQ2qlWUelcfhhTFyWDy2yoKO2L0p
         tjrC0gOxb8MNL4AMNbBalGvhoNsa6QAV+phWgNrMelXqHGhEuE4+sIjiwgHSUBI8p2D+
         VGgUXzbK+PhDj6oNJbswSJlbDV5GQEhB4rGIVXzz/cOu8CqPxfnMhO0w5ubbrq/hR3xl
         XDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8K18yxweY4gFUc5IPSjf6KUr1KTvjVNeucp6N+wAMbI=;
        b=1p5YHIEGiWprQZudXocAK77wi2UK92EJdrifk7JdvFrLM/J3GyME07wfXnT1Bv2FjV
         9O62YUfFVaNMwrUNRD8aiDCau95op6dp1b/rY///1HeFcBXStkjzEZa1oetSpawHc7bB
         Ymt/CuIuO7K+a1HPuJ7jY4VLRon454v57/4jpoPNT815UgoynRPLqfFJBQsD/P7QLUiz
         vxyX1cBKpR9TyFusRfSXeC3wvMSOdjQJJbzHjOBX1TI6acGPC9a9unF8Mem4WobTbCrJ
         3DEBS7Ndfsh3Pgo6zCsJhpZBFrJsuSG3+R2d8P6Qpfq19DqY2bT6aZFZgF1ANkj2XUNz
         wn/w==
X-Gm-Message-State: AOAM532Kd75DJ9mAL8wFC2YB5/qcKFxLLVzauaqtq+S0oS8UyxJ/z5tA
        9G5woKdndfQcfQfDRjfZVGc=
X-Google-Smtp-Source: ABdhPJxg1rCZ/kZvloaZBCLEEM8TF15dB8gKvYh70yn7oO22d6rtmLTcGVT5aqbdM/sikFL98kB76w==
X-Received: by 2002:adf:f8c3:: with SMTP id f3mr5528981wrq.495.1639047656876;
        Thu, 09 Dec 2021 03:00:56 -0800 (PST)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id w15sm5403722wrk.77.2021.12.09.03.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 03:00:56 -0800 (PST)
Message-ID: <f245f2b7-ca00-5497-3d1d-658c4c0fbcb6@gmail.com>
Date:   Thu, 9 Dec 2021 11:00:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] git-compat-util(msvc): C11 does not imply support for
 zero-sized arrays
Content-Language: en-GB-large
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.1094.git.1638823724410.gitgitgadget@gmail.com>
 <20211206222539.GA27821@neerajsi-x1.localdomain>
 <nycvar.QRO.7.76.6.2112072217280.90@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <nycvar.QRO.7.76.6.2112072217280.90@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 07/12/2021 21:33, Johannes Schindelin wrote:
> Hi Neeraj,
> 
> On Mon, 6 Dec 2021, Neeraj Singh wrote:
> 
>> I'm a little confused by this issue. Looks like an empty flex array
>> is supported here: https://godbolt.org/z/j3ndYTEfx.
> 
> It is somewhat strange, but understandable, that the empty flex array at
> the end of a struct isn't triggering a compile error. But having a field
> _after_ that empty flex array _does_ trigger a compile error:
> 
> struct MyStruct {
>      int x;
>      int flexA[];
>      char string[256];
> };
> 
> Note the added `string` field.

Having a field after the flex array is a violation of the C standard. 
Section 6.7.2.1:
    ... the last member of a structure with more than one named member
    may have incomplete array type, such a structure (and any union
    containing, possibly recursively, a member that is such a structure)
    shall not be a member of a structure or an element of an array.

Note that the wording also forbids

struct A {
	int x;
	char flex[];
};

struct B {
	struct A a; /* This is forbidden */
};

There was a proposal a few years ago to relax that restriction [1] but 
it does not seem to be in the latest draft standard.

None of this helps fix the problem, but it does explain why MSVC complains.

Best Wishes

Phillip

[1] http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2083.htm

> See https://godbolt.org/z/TbcYhEW5d, it says:
> 
> 	<source>(5): error C2229: struct 'MyStruct' has an illegal zero-sized array
> 	Compiler returned: 2
> 
>> (Note that I'm passing /TC to force C compilation).
> 
> Yes, `/TC` is one of the flags we pass to MSVC. For more details, see
> https://github.com/git-for-windows/git/runs/4389081542?check_suite_focus=true#step:9:125
> 
>> Also, heap_fsentry doesn't appear to use a flex array in current sources.
> 
> It does, but it is admittedly a bit convoluted and not very easy to see.
> The definition of `heap_fsentry` is
> [this](https://github.com/git-for-windows/git/blob/v2.34.1.windows.1/compat/win32/fscache.c#L77-L80):
> 
> 	struct heap_fsentry {
> 		struct fsentry ent;
> 		char dummy[MAX_LONG_PATH];
> 	};
> 
> No flex array here, right? But wait, there is a `struct fsentry`. Let's
> look at
> [that](https://github.com/git-for-windows/git/blob/v2.34.1.windows.1/compat/win32/fscache.c#L43-L74):
> 
> 	struct fsentry {
> 		struct hashmap_entry ent;
> 		[...]
> 		/*
> 		 * Name of the entry. For directory listings: relative path of the
> 		 * directory, without trailing '/' (empty for cwd()). For file
> 		 * entries:
> 		 * name of the file. Typically points to the end of the structure
> 		 * if
> 		 * the fsentry is allocated on the heap (see fsentry_alloc), or to
> 		 * a
> 		 * local variable if on the stack (see fsentry_init).
> 		 */
> 		struct dirent dirent;
> 	};
> 
> Still no flex array, right? But wait, there is a `struct dirent`. Let's
> [see](https://github.com/git-for-windows/git/blob/v2.34.1.windows.1/compat/win32/dirent.h#L9-L12):
> 
> 	struct dirent {
> 		unsigned char d_type; /* file type to prevent lstat after readdir */
> 		char d_name[FLEX_ARRAY]; /* file name */
> 	};
> 
> Finally! We see the flex array.
> 
> Now, you may ask why is this even correct? How can you have an empty-sized
> field in a struct that is inside another struct that is inside yet another
> struct _and then followed by another field_?
> 
> The reason why this is correct and intended is that `struct dirent`
> intentionally leaves the length of the `d_name` undefined, to leave it to
> the implementation whether a fixed-size buffer is used or a
> specifically-allocated one of the exact correct size for a _specific_
> directory entry.
> 
> In FSCache, we want to allocate a large-enough buffer to fit _any_ file
> name, and it should not only contain the metadata in `struct dirent`, but
> additionally some FSCache-specific metadata.
> 
> Therefore, `struct fsentry` is kind of a subclass of `struct dirent`, and
> `struct heap_fsentry` is kind of a subclass of something that does not
> exist, a `struct dirent` that offers enough space to fit _any_ legal
> `d_name` (that is what that `dummy` field is for, it is not actually
> intended to be accessed except via `d_name`).
> 
>> If it does start using it, there issue may actually be elsewhere besides
>> the struct definition (it could be just a badly targeted compiler error).
>> We have code like `struct heap_fsentry key[2];`.  That declaration can't
>> work with a flex array.
> 
> I hope my explanation above made sense to you.
> 
> Admittedly, it is slightly icky code, but honestly, I do not have any
> splendid idea how to make it less complicated to understand. Do you?
> 
> Ciao,
> Dscho
> 
