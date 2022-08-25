Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A314C04AA5
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 08:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239263AbiHYIX2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Aug 2022 04:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235985AbiHYIXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2022 04:23:25 -0400
Received: from blade-b3-vm-relay.servers.aueb.gr (blade-b3-vm-relay.servers.aueb.gr [195.251.255.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 440C5A572E
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 01:23:21 -0700 (PDT)
Received: from blade-a1-vm-smtp.servers.aueb.gr (blade-a1-vm-smtp.servers.aueb.gr [195.251.255.217])
        by blade-b3-vm-relay.servers.aueb.gr (Postfix) with ESMTP id CA972C18;
        Thu, 25 Aug 2022 11:23:16 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aueb.gr; s=201901;
        t=1661415796; bh=qXawh6lNGRdWGfgaWiqDvZrT3TG2j7oLL1HUo4o0tv0=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=jNjDfvWAMjbLFVPlRq4fgWVlTYsq1OrdRpHs086r14nlE/E4Qhaqb+29PnMA3DBLQ
         b85RP/+rGtzZk5VdXCAgitWftCUAghThp5XTLW0d9dW0mlI9RdOi2PCm/hfSUNsszU
         YgjDdwg+Z9DtSx5VlDOFysnwebeWeMq/HgYE4iv2gO9gl6g7J0lAkN7rJzSVbd3DsJ
         mv287rRgXwhNlfJjaoLZ8ZV9rCKksc5mneJMnJA/p31uSPLOAjV5DRdvmKlGwqe44R
         CfTwqc3C1Mn6ZlqimxIHOvC400SjRCo6c1+5AelcJKBBbiro1Lcck+g/jyr4lp6LyG
         YL7D2yCFkmpog==
Received: from [192.168.136.3] (ppp-2-84-110-115.home.otenet.gr [2.84.110.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dds)
        by blade-a1-vm-smtp.servers.aueb.gr (Postfix) with ESMTPSA id 62EB259F;
        Thu, 25 Aug 2022 11:23:16 +0300 (EEST)
Message-ID: <a30f4979-a5d0-c517-9868-cda783874d5b@aueb.gr>
Date:   Thu, 25 Aug 2022 11:23:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
From:   Diomidis Spinellis <dds@aueb.gr>
Subject: Re: [PATCH v2] grep: fix multibyte regex handling under macOS
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Diomidis Spinellis via GitGitGadget <gitgitgadget@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1313.git.git.1661281689747.gitgitgadget@gmail.com>
 <pull.1313.v2.git.git.1661289990205.gitgitgadget@gmail.com>
 <xmqq5yih79n0.fsf@gitster.g>
Content-Language: el
Organization: Athens University of Economics and Business
Phone:  +30 210 8203621
In-Reply-To: <xmqq5yih79n0.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24-Aug-22 21:56, Junio C Hamano wrote:
> "Diomidis Spinellis via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
>> From: Diomidis Spinellis <dds@aueb.gr>
>>
>> The 2013 commit 29de20504e9 fixed t0070-fundamental.sh under Darwin
>> (macOS) by adopting Git's regex library.  However, this library is
>> compiled with NO_MBSUPPORT, which causes git-grep to work incorrectly
>> on multibyte (e.g. UTF-8) files.  Current macOS versions pass
>> t0070-fundamental.sh with the native macOS regex library, which
>> also supports multibyte characters.
> 
> Very nice to see the last sentence in that paragraph.
> 
>> Signed-off-by: Diomidis Spinellis <dds@aueb.gr>
>> ---
> 
> This part, from here ...

[...]

> ... up to here does not need a separate sign-off.  

Apologies for this.  I was led to believe that gitgitgadget would 
seamlessly interface between GitHub's pull request and the Git project's 
email workflow, but I don't see this happening.  Not sure if this is due 
to a fault in gitgitgadget or due to my misuse of it.  I think 
gitgitgadget expects users not to squash their subsequent commits.  In 
any case, I'm switching to git-send-mail, which provides more visibility 
and control of the process.

>> diff --git a/Makefile b/Makefile
>> index 04d0fd1fe60..d1a98257150 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1427,7 +1427,6 @@ ifeq ($(uname_S),Darwin)
>>   		APPLE_COMMON_CRYPTO = YesPlease
>>   		COMPAT_CFLAGS += -DAPPLE_COMMON_CRYPTO
>>   	endif
>> -	NO_REGEX = YesPlease
>>   	PTHREAD_LIBS =
>>   endif
> 
> I notice that this is the ONLY conditional section in our primary
> Makefile that switches upon the value of $(uname_<anything>).  After
> the dust settles, we should move this whole part to config.mak.uname
> as an unrelated clean-up.
> 
> Alternatively, you can choose to do that (without losing NO_REGEX)
> as a preliminary clean-up patch and then build this "recent Darwin
> has usable regexp library" change on top of it.  I do not have a
> preference either way, other than that we do not want to see that
> done as part of this change "while we are at it".

I was also surprised to see a $(uname) conditional in the Makefile.  I 
prefer to finish the macOS grep UTF-8 bug fix before discussing related 
house cleaning.

>> diff --git a/grep.c b/grep.c
>> index 82eb7da1022..c31657c3da3 100644
>> --- a/grep.c
>> +++ b/grep.c
>> @@ -10,6 +10,8 @@
>>   #include "quote.h"
>>   #include "help.h"
>>   
>> +#include <locale.h>
> 
> Don't ever include system headers in generic *.c files.  The system
> headers on different platforms have subtle ordering restrictions
> among include files and definitions of feature test macros, and all
> those subtleties are supposed to be handled in one central place, in
> the "git-compat-util.h" file.
> 
> A source file specific only to a particular platform is a different
> matter; they can include system headers that exist or are needed
> only on those systems directly.
> 
> So far, "grep.c" has been successfully used for everybody (except
> Darwin), and if it needs touching, that means something is still
> wrong with Darwin.

Thank you for clarifying the division of responsibility among files.  I 
changed the fix accordingly.

> Is is because you are not using gettext()?  I thought our
> gettext.[ch] did consider some folks/platforms do not use system
> gettext() but perhaps its support for such build environment is
> slightly lacking and does not make necessary setlocale() calls.

I believe that grep was working by accident on other platforms, thanks 
to setlocale calls made in gettext.c.  I don't think grep should depend 
on the implementation of gettext.  Thankfully, according to test 
results, it turns out that we can now globally initialize the CTYPE 
locale, making its state available both to gettext.c and grep.c.
