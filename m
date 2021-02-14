Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35590C433DB
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 11:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDCCA64E08
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 11:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhBNLKj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 06:10:39 -0500
Received: from [93.83.142.38] ([93.83.142.38]:36956 "EHLO localhost"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S229563AbhBNLKj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 06:10:39 -0500
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by localhost (Postfix) with ESMTP id 70D8F1A2F4;
        Sun, 14 Feb 2021 12:10:17 +0100 (CET)
Subject: Re: [PATCH] userdiff: add support for Emacs Lisp
From:   Johannes Sixt <j6t@kdbg.org>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Adam Spiers <git@adamspiers.org>
Cc:     git list <git@vger.kernel.org>,
        Protesilaos Stavrou <info@protesilaos.com>
References: <20210213192447.6114-1-git@adamspiers.org>
 <87wnvbbf2y.fsf@evledraar.gmail.com>
 <aab77ef2-c619-ed87-6c3b-9a1b5ec36f41@kdbg.org>
Message-ID: <b480dc67-6fea-4d4b-8f81-b9d4273e82ea@kdbg.org>
Date:   Sun, 14 Feb 2021 12:10:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <aab77ef2-c619-ed87-6c3b-9a1b5ec36f41@kdbg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.02.21 um 09:12 schrieb Johannes Sixt:
> Am 14.02.21 um 02:41 schrieb Ævar Arnfjörð Bjarmason:
>> Just a cursory "git log -p -- lisp" in emacs.git with your patch shows
>> e.g. lisp/thingatpt.el where forms in a "defun" aren't indented (before
>> it selects the "defun", after with yours it's a "put" in the middle of
>> the function).
> 
> Note that negative matches can be specified. We use the feature in the 
> cpp case to exclude public:/protected:/private: and label: that happen 
> to be not indented. Perhaps that can be useful here?
> 
> Oh, and BTW, what the patterns treat as "function" must not match what 

I meant to say "need not match".

> the language treats as function. The purpose of the hunk header is to 
> spot a place in the source file easily. So, it does not hurt if 
> eval-and-compile forms are captured (as was mentioned in the linked 
> thread) if desired.
> 
>>
>> Yours also changes it from e.g.:
>>
>>      @@ -61,7 +61,7 @@ forward-thing
>>
>> to:
>>
>>      @@ -61,7 +61,7 @@ (defun forward-thing (thing &optional n)
>>
>> Is this really desired in elisp?
> 
> It's common practice to extract the entire line (sans indentation if 
> applicable), not just the function name. Why would somebody want the 
> latter? It doesn't carry as much information as could be possible.
> 
>> I also note how our tests in
>> t4018-diff-funcname.sh are really bad in not testing for this at
>> all. I.e. we just test that we match the right line, not how we extract
>> a match from it.
> 
> Oh, well. These are "semi-automated" tests cases. If you have an idea 
> how to achieve the goal without burdening test writers with lots of 
> subtleties, be my guest. ;)
> 
>>
>> 1. https://lists.gnu.org/archive/html/emacs-devel/2021-02/msg00739.html
>>
> 
> -- Hannes

