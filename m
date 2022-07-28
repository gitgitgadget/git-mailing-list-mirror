Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FABC04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 09:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbiG1Jkq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 05:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbiG1Jkp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 05:40:45 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6BCB49E
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 02:40:44 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id m7so1048604qkk.6
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 02:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=bZ0owSPVOF626MNgOjhx6xybCmiv9/QF+3FONn3/nGU=;
        b=dUNUKkId+nw/DklIxlm4TyN00Fh5LejXj887GIXSVzRGf4LAlfnfHSODrVbAKpfhM1
         BBEcT6hYwZ0lNoX3VoFVjJT6Qe7JZsiP4WajEaWbFEAs4fHghfBHlfK3ekhQ6a1RK/k4
         3kE4+cWwlb7CbuPFc1bJ9VosFgRaFO5K/+RBxBVF2/f/+NBp2IqehJ/EwjOUVQLXnpyp
         Fur29pBofCk6GJvXhCiP44chS64gJqDoegDFMpG0dtPUJzxZjRrkeJUt3ouC0z34vjj0
         T5/riMvDXyh1cuihQzQvtIMgybFkiUYb0HG4YhjOcOCXU51KWspDx98hgfN2Ay/yGVLG
         K2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=bZ0owSPVOF626MNgOjhx6xybCmiv9/QF+3FONn3/nGU=;
        b=n0n6J4i1R5K3Ri7uD3sxOdtJMaAtUjR5BNzXPw7ph2s08UTVSN7noiTlwINf79+dl0
         SM3OwkQD0lsYiCBf+HQIIrTutF93pWvENg4yoFL9dEDq2EvPFMTN0fRYsS/WoEKfB3/X
         pLAz4WrM8XDscnwjXG9i36A7YKfn1l/zGcdeWmhjgZ4xG3AE834EdybSdTWyBAsrwFuI
         z6b4KwMiC3IcDraKpVS10jtEDA2ISOLJEql1SESJQLeDu0PF4x+5hYyTjjVrCXYY3r4V
         dh5yqg0hhKaECS1Ghs1D5kYRklMLOh8+N4m4cyxe+nBaGC7+mkPumkVekbjev7r7+ERx
         DYPA==
X-Gm-Message-State: AJIora8hbP/lvVQoc6EsV1p1NMfohl4w/n00yjFWhJvj859npsQDt2fp
        m60rWSoqY5ZGJBtb6Rz1zcXEIqAAH/qo51Iy
X-Google-Smtp-Source: AGRyM1sYLesASRyL4f9HilnrYnEXSyl+ClwubRUs8ChiM7Yx8hR6BqOehj7a4d+TDeNlWtfaJPX6rQ==
X-Received: by 2002:a37:9744:0:b0:6b5:4fee:5ffe with SMTP id z65-20020a379744000000b006b54fee5ffemr19255711qkd.692.1659001243417;
        Thu, 28 Jul 2022 02:40:43 -0700 (PDT)
Received: from ?IPV6:2605:2a00:9005:dead::3ac? ([2605:2a00:9005:dead::3ac])
        by smtp.gmail.com with ESMTPSA id y194-20020a3764cb000000b006b61b34d2c2sm240420qkb.42.2022.07.28.02.40.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 02:40:43 -0700 (PDT)
Message-ID: <1e454493-ca57-ca2e-7d82-7333a769817e@gmail.com>
Date:   Thu, 28 Jul 2022 05:40:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Johannes Sixt <j6t@kdbg.org>,
        CH <ch-and-git.vger.kernel.org@ch.pkts.ca>
Cc:     git@vger.kernel.org
References: <f5a49da29fd0e5577083f1006d394158@ch.pkts.ca>
 <4b09bf98-dae2-491e-9858-801a9bcdd2fa@kdbg.org>
From:   Thomas Guyot <tguyot@gmail.com>
Subject: Re: Feature request: better error messages when UTF-8 bites
In-Reply-To: <4b09bf98-dae2-491e-9858-801a9bcdd2fa@kdbg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-07-28 01:42, Johannes Sixt wrote:
> Am 27.07.22 um 22:21 schrieb CH:
>> Somehow when copying and pasting a commit from a website to the command
>> line, a UTF-8 Byte Order Mark (BOM)
>> [https://en.wikipedia.org/wiki/Byte_order_mark] was appended to one of
>> the commit ids.  BOMs are invisible, as are many other UTF-8 code
>> points.  The upshot was that Git didn't like it, and complained bitterly:
>>
>>> $ strace -etrace=execve -s 200 git diff
>>> 038179704f0066aa815d5429221cf381ff4ef289
>>> 47346a462d8ba40b9a8b073e351c362522c46aa6
>>>
>>> execve("/usr/bin/git", ["git", "diff",
>>> "038179704f0066aa815d5429221cf381ff4ef289\357\273\277",
>>> "47346a462d8ba40b9a8b073e351c362522c46aa6"], 0x7fffec3c4bb0 /* 80 vars
>>> */) = 0
>>>
>>> fatal: ambiguous argument '038179704f0066aa815d5429221cf381ff4ef289':
>>> unknown revision or path not in the working tree.
>>> Use '--' to separate paths from revisions, like this:
>>> 'git <command> [<revision>...] -- [<file>...]'
>>> +++ exited with 128 +++
>> Feature request:
>> ================
>>
>> When printing the "fatal: ambiguous argument '......': ....", perhaps
>> escape (url or otherwise) the ambiguous argument when printing it in the
>> error message, or maybe add a sentence about non-ASCII characters being
>> found.
> That's not going to fly, IMHO, because when I type
>
>     git diff todo/René
>
> I would not want to see
>
> fatal: ambiguous argument 'todo/Ren\303\251': unknown ...

This is actually already MUCH better that the OP's example. In his 
example he has a string that looks like a 40-char hash, and git 
complains without showing any of the Unicode gibberish attached to that 
sha1. It would be better if at least it printed something in ASCII with 
escaped bytes in the error message.

Moreover this isn't even close to the issue above - he's talking about a 
no-op, non-printing Unicode marker that crept in. While I do think it 
shouldn't be an issue, it shouldn't even have been passed to git. IMHO 
it should have been stripped by the browser itself on copy, or by the 
terminal on paste... FWIW I'm using rxvt-unicode, and copying this from 
the terminal doesn't copy the marker but pasting the marker copied from 
Chrome is passed on to bash and git.

NB: I also though what if the shell handled it, but that isn't even 
really a character so not technically suitable for $IFS, and even if we 
considered that option it wouldn't really play well with POSIX's 
definition of $IFS - how to tell for example between a single Unicode 
codepoint and a list of binary characters? There is just no definition 
of wide chars for $IFS, not in POSIX nor in recent versions of Bash AFAIK.


TL;DR; the issue is IMHO on the browser side, which shouldn't include 
the marker in the copied text, or maybe on the terminal, BUT when passed 
on to git it should at least print the escaped Unicode chars in the 
error, otherwise it's just too confusing for the user.


BTW you actually raise another issue - I do think for file paths git 
could either recompose (NFC) or decompose (NFD) the strings on storage 
and comparison (which should probably be an option... the current 
default for 2.30.2 is to treat them and print them as binary (escaped on 
print). Consider the following when using core.quotePath=false:

$ touch "nfc_$(printf '\xf4')"
$ touch "nfd_$(printf '\x6f\xcc\x82')"
$ git add nf[cd]*
$ git status
On branch test
Changes to be committed:
   (use "git restore --staged <file>..." to unstage)
     new file:   nfc_ô
     new file:   nfd_ô

I'm not sure how the Unicode will be translated here, it might depend on 
the mail client if they even's get sent as-is, but both shows the exact 
same file name, one in NFD and one in NFC format.

Both are canonically equivalent and reversible. It appears MacOS already 
decompose (NFD?) filenames by default and git provides an option to 
recompose the characters (core.precomposeUnicode) which, according to 
the manual, is not even usable on Linux...

More on Unicode normalization: https://unicode.org/reports/tr15/

--
Thomas
