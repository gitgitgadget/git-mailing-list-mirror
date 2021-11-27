Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F33C433FE
	for <git@archiver.kernel.org>; Sat, 27 Nov 2021 19:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236014AbhK0Th5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Nov 2021 14:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbhK0Tf4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Nov 2021 14:35:56 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16B1C061746;
        Sat, 27 Nov 2021 11:32:41 -0800 (PST)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1mr3R8-0002C8-Je; Sat, 27 Nov 2021 20:32:38 +0100
Message-ID: <42ff6b8d-0b7c-12e0-4648-a9232b0f577c@leemhuis.info>
Date:   Sat, 27 Nov 2021 20:32:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-BS
To:     Eric Wong <e@80x24.org>
Cc:     workflows@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, git@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Kees Cook <keescook@chromium.org>
References: <cover.1637566224.git.linux@leemhuis.info>
 <6b760115ecdd3687d4b82680b284f55a04f3ad90.1637566224.git.linux@leemhuis.info>
 <20211123185237.M476855@dcvr>
 <12cefa81-495b-3083-5f19-b319c704ebf7@leemhuis.info>
 <20211126171141.GA21826@dcvr>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [RFC PATCH v1 1/1] docs: add the new commit-msg tags 'Reported:'
 and 'Reviewed:'
In-Reply-To: <20211126171141.GA21826@dcvr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1638041562;6ca12670;
X-HE-SMSGID: 1mr3R8-0002C8-Je
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26.11.21 18:11, Eric Wong wrote:
> Thorsten Leemhuis <linux@leemhuis.info> wrote:
>> Ccing Linus Walleij, who added this, and Kees, who apparently came up
>> with this originally.
>>
>> On 23.11.21 19:52, Eric Wong wrote:
>>> Thorsten Leemhuis <linux@leemhuis.info> wrote:
>>>> diff --git a/Documentation/maintainer/configure-git.rst b/Documentation/maintainer/configure-git.rst
>>>> index 80ae5030a590..8429d45d661c 100644
>>>> --- a/Documentation/maintainer/configure-git.rst
>>>> +++ b/Documentation/maintainer/configure-git.rst
>>>
>>> <snip>, +cc git@vger
>>>
>>>> @@ -56,7 +56,7 @@ by adding the following hook into your git:
>>>>  	$ cat >.git/hooks/applypatch-msg <<'EOF'
>>>>  	#!/bin/sh
>>>>  	. git-sh-setup
>>>> -	perl -pi -e 's|^Message-Id:\s*<?([^>]+)>?$|Link: https://lore.kernel.org/r/$1|g;' "$1"
>>>> +	perl -pi -e 's|^Message-Id:\s*<?([^>]+)>?$|Reviewed: https://lore.kernel.org/r/$1|g;' "$1"
>>>
>>> Side note: that regexp should match "Message-ID" case-insensitively.
>>> git send-email is an outlier in its capitalization of "Message-Id",
>>> most RFCs capitalize it "Message-ID", as do common MUAs.
>>
>> Argh :-/
>>
>> It's still totally unclear if that or a similar patch will be accepted.
>> And even if it is: the "don't do two different things in one commit"
>> rule might not be that strict enforced when it comes to the Linux
>> kernel's docs, but changing this regexp as part of another patch crosses
>> the line.
>>
>> IOW: we afaics need a separate patch to make the regexp
>> case-insensitively. Eric, do you want to submit one, as you brought it
>> up? Or are there any other volunteers?
> 
> I suggest you turn this into a 2 patch series to avoid conflicts
> for a trivial change.  I don't even have a kernel worktree handy
> at the moment (ENOSPC :x)

:-D

Will do this in a couple of days, unless Linus or Kees speak up.

Just to be sure I'll do what you expect to be done: I assume you want to see
it changed like this?

-	perl -pi -e 's|^Message-Id:\s*<?([^>]+)>?$|Link: https://lore.kernel.org/r/$1|g;' "$1"
+	perl -pi -e 's|^Message-I[dD]:\s*<?([^>]+)>?$|Link: https://lore.kernel.org/r/$1|g;' "$1"

Or are there even more variants of Message-ID out there known that
need to be taken into account?

Ciao, Thorsten
