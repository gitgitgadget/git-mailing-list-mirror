Return-Path: <SRS0=KP1k=5N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7296FC43331
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 17:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4935020714
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 17:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgC1RF5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 13:05:57 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:59794 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbgC1RF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 13:05:57 -0400
Received: from [92.30.123.115] (helo=[192.168.1.38])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jIEuA-0006iI-AJ; Sat, 28 Mar 2020 17:05:54 +0000
Subject: Re: Git alias syntax help
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr0=?= =?UTF-8?B?z4TOv8+C?= 
        <stdedos@gmail.com>
Cc:     git <git@vger.kernel.org>
References: <CAHMHMxWpLAnj3w8DGLMFbfy-A-pBjDxNdMeiM-fyuu-gnZyg+Q@mail.gmail.com>
 <20200114222802.GC3957260@coredump.intra.peff.net>
 <CAHMHMxVajKxjBweG=mps0gLwE1o8M69DvPb1iUQYgLXx0VO5AA@mail.gmail.com>
 <20200115181351.GB4081287@coredump.intra.peff.net>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <941494c1-b082-e003-b169-00d4e39ed2f5@iee.email>
Date:   Sat, 28 Mar 2020 17:05:54 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200115181351.GB4081287@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 15/01/2020 18:13, Jeff King wrote:
> On Wed, Jan 15, 2020 at 01:13:17AM +0200, Σταύρος Ντέντος wrote:
>
>>>> new = "!f() { : git log ; git log \"${1}@{1}..${1}@{0}\" \"$@\" ; } ; f"
>>>> new = !f() { : git log ; git log "${1}@{1}..${1}@{0}" "$@" ; } ; f
>>> Only the first one is correct. In addition to the quotes in the second
>>> one being eaten by the config parser, the unquoted semicolon starts a
>>> comment.
>> Could somehow the latter "become" the correct option?
> Unfortunately not without breaking compatibility of existing config
> files.
>
>> Especially in the case of `!sh`:
>> 1) You need to quote everything after `=` sign ("forced" double quotes), then
>> 2) `sh -c` needs another set (singles are most safe here, I think), and
>> 3) If, for some reason, you need to quote further ("$@" would be a
>> common suspect usually)
> Yes, the quoting can get pretty hairy. If your command is complicated, I
> suggest writing it as a separate script and dropping it into your $PATH
> as git-new. Then "git new" will run it automatically (and it's not even
> any less efficient; it still ends up with a single shell invocation).
>
>> Thank you very much for a complete explaination of all of this .
>>
>> Can some of this be documented somewhere?
>> Are they somewhere and I missed them?
> I think the config syntax around quoting is described in "git help
> config" (see the section Syntax). The shell parts seem out of scope for
> Git's manpages themselves, though it sounds like maybe some examples you
> found could stand to be fixed (and/or to call out the subtlety).
>
>> If nothing more, a link to this e-mail chain either on the wiki (if
>> https://git.wiki.kernel.org/index.php/Aliases is an official page) or
>> on git-alias help (here
>> https://git-scm.com/book/en/v2/Git-Basics-Git-Aliases or in some
>> "advanced" section, which I cannot find)
>>
>> If https://git.wiki.kernel.org/index.php/Aliases is an official page,
>> then: was this written for an earlier version?
>> Could it also be updated?
> I think both of the issues you mentioned have always been true. That
> wiki is open to editing by the world,

I took the liberty of adding a small subsection on quoting based on this
discussion, and adding a link to it. Feedback on my ignorance welcomed ;-)
>  so it's possible that somebody
> just added bad examples (and fixes would be welcome).
>
> I don't know the book content very well. Looking at the page you
> linked, I don't think it says anything _wrong_, but it definitely
> doesn't discuss more advanced alias usage. I suspect that would be a
> welcome addition; they take contributions at
> https://github.com/progit/progit2.
>
> -Peff
Philip

