Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E617C433EF
	for <git@archiver.kernel.org>; Sun, 10 Oct 2021 20:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32EAF60E9C
	for <git@archiver.kernel.org>; Sun, 10 Oct 2021 20:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhJJURn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Oct 2021 16:17:43 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:26032 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229758AbhJJURn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Oct 2021 16:17:43 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4HSCq24FRYz5tl9;
        Sun, 10 Oct 2021 22:15:42 +0200 (CEST)
Subject: Re: [PATCH v2 0/5] Fun with cpp word regex
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Sixt via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.1054.git.1633589461.gitgitgadget@gmail.com>
 <pull.1054.v2.git.1633720197.gitgitgadget@gmail.com>
 <87r1cvmg0c.fsf@evledraar.gmail.com>
 <25363715-dc39-1f18-a937-f715b106f529@kdbg.org>
 <87mtnjm416.fsf@evledraar.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <27a4476a-4743-b798-b3fa-ce068472143b@kdbg.org>
Date:   Sun, 10 Oct 2021 22:15:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <87mtnjm416.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.10.21 um 02:00 schrieb Ævar Arnfjörð Bjarmason:
> For an example of something we do a bit badly with the cpp driver is
> parts of my 66f5f6dca95 (C style: use standard style for "TRANSLATORS"
> comments, 2017-05-11).
> 
> I.e. there I was changing a comment format, and added a full stop to a
> sentence, the word-diff is:
> 
>         /*
>          {+*+} TRANSLATORS: here is a comment that explains the string to
>          {+*+} be translated, that follows immediately after [-it-]{+it.+}
>          */
> 
> Even though it has nothing to do with C syntax per-se that would be much more useful as:
> 
>         /*
>          {+*+} TRANSLATORS: here is a comment that explains the string to
>          {+*+} be translated, that follows immediately after it{+.+}
>          */
> 
> I.e. treating a "." at the end of a word specially isn't C or C++
> syntax, but it's absolutely input that the cpp driver *is* getting and
> should be if possible be handling well.

FWIW, I wondered why the cpp driver should not handle this case as you
expect it, and the answer is that it actually does when this comment
appears in a C file. This particular word-diff occurs in
Documentation/CodingGuidelines and that is not covered by the cpp driver.

-- Hannes
