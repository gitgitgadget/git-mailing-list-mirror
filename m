Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFBAC433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 14:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FB3761165
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 14:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhJ2O5A (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 10:57:00 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:48473 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229549AbhJ2O47 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 29 Oct 2021 10:56:59 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id F03963201E83;
        Fri, 29 Oct 2021 10:54:29 -0400 (EDT)
Received: from imap45 ([10.202.2.95])
  by compute1.internal (MEProxy); Fri, 29 Oct 2021 10:54:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=owlfolio.org; h=
        mime-version:message-id:in-reply-to:references:date:from:to
        :subject:content-type; s=fm1; bh=3NoUJzQkGZEypIiavW9zedOQ+h3u27Y
        3ZREBYrW0X98=; b=hFW0ng0U3yBN+UZL+lWcFqZYznrF8Von6S0kqGPxyQkAZhf
        KHmgLeYhmzt2QdFPqP8jaG5ey+RTBr62fk9KxJRlsH5oWlaryvHftrpI6KwKHPYl
        7i1E2RJEYQJ814Z4NSSjTkfY2JHSyaxVpwJcKXZFXVRwtZxztC/dGwaQXKxGtRa/
        d7l/gCbclL4Wpp3ok3E9e/hAOM1Mzr08p3lXZdFndeUcN5I5CNb3VP/kTWFXrwul
        QRjezDb4e/iI+H18apkB+s6XVOL4l7pusTM5lRuhIEkY3eid61grdcbV0i8mWX04
        1pzbwhwM2pNTPzlqyfnEEEPTMp8Jln4iHBQFtvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=3NoUJz
        QkGZEypIiavW9zedOQ+h3u27Y3ZREBYrW0X98=; b=f/iXwsok3E7KIqdyOjKBuW
        MNBdJMOPbehZCyF1SPZh8hlURsUgloWuPv8GN60+jNGaiM2VqSYbKa2+Mq8Zhvsl
        wWW+cKROFE1k7ZjPISdBrF0bRJKuz5F/y56ze0Ml4RLUNizXCEzv9mPUeOsjiNKw
        39tezZjURc/MiAPv60sYpbZ8CS5spQaa8o24KdDWMwi6STd6oQknzyg1Bpre3bWV
        0Y5Zcs410FVbE41X9mlCSjAZYDTpwFlocok5ly0CVMxxHr/kCKCGvHvM9UgJPsRq
        SnO4AR2QeP923Rfj9ObCZDMzF22Nd8AmqcnXlFYOBPtLmGXtQY84tdEO2/iHuDkQ
        ==
X-ME-Sender: <xms:JQt8YSZiaPi-BwXf32Ee0m1Bf4CYh7HISDMFLpOZ1w_168rQxIvPRg>
    <xme:JQt8YVYKnkMM6UxEhxFd1IJDm7UD2DQtQkMpng5lHBMfJPfVenVS6Qmm1FRS0oU07
    H_SU0rUmkc_1IDgUNs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdeghedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdgkrggt
    khcuhggvihhnsggvrhhgfdcuoeiirggtkhesohiflhhfohhlihhordhorhhgqeenucggtf
    frrghtthgvrhhnpefhuefhveeuffetfffgjeetgfekkeehfedtfeelgfehffffveehkeel
    fefgheffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpeiirggtkhesohiflhhfohhlihhordhorhhg
X-ME-Proxy: <xmx:JQt8Yc8CPNo4CrVVYlPdQ7zOALC9GlqU0p22vFO6F077klpLupPRaw>
    <xmx:JQt8YUqYyjOYw6Xoh3-RrKX9iK-lYe1kRY4DqkDMzCwfOfBIU_DONw>
    <xmx:JQt8YdoXkd6mkw2ULAV-9Q8jSY-IQcNY-WGaepZZQGfQ695bKEfaig>
    <xmx:JQt8YekoD0X54cc3UAJr0lppYxH36X7OfPFywbRFrOg5r09OmOimyA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 02F5A24A0074; Fri, 29 Oct 2021 10:54:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1369-gd055fb5e7c-fm-20211018.002-gd055fb5e
Mime-Version: 1.0
Message-Id: <6d8642e9-71f7-4a83-9791-880d04f67d17@www.fastmail.com>
In-Reply-To: <63238.1635515736@cvs.openbsd.org>
References: <a0371f24-d8d3-07d9-83a3-00a4bf22c0f5@gmail.com>
 <73ac38a2-c287-4cc1-4e9c-0f9766ac4c0c@gmail.com>
 <00d501d7ccbe$0169c340$043d49c0$@nexbridge.com>
 <63238.1635515736@cvs.openbsd.org>
Date:   Fri, 29 Oct 2021 10:53:53 -0400
From:   "Zack Weinberg" <zack@owlfolio.org>
To:     "Theo de Raadt" <deraadt@openbsd.org>, rsbecker@nexbridge.com,
        "'Alejandro Colomar (man-pages)'" <alx.manpages@gmail.com>,
        'linux-man' <linux-man@vger.kernel.org>, tech@openbsd.org,
        "Florian Weimer" <libc-alpha@sourceware.org>, git@vger.kernel.org
Subject: Re: Is getpass(3) really obsolete?
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 29, 2021, at 9:55 AM, Theo de Raadt wrote:
> <rsbecker@nexbridge.com> wrote:
>> On October 29, 2021 7:29 AM, Alejandro Colomar wrote:
>> > On 10/29/21 13:15, Alejandro Colomar wrote:
>> > > Hi,
>> > >
>> > > As the manual pages says, SUSv2 marked it as LEGACY, and POSIX doesn't
>> > > have it at all.  The manual page goes further and says "This function
>> > > is obsolete. Do not use it." in its first lines.
...
> The community finally had the balls to get rid of gets(3).
>
> getpass(3) shares the same flaw, that the buffer size isn't passed.
> This has been an issue in the past

I was about to post exactly the same thing.  getpass(3) is not deprecated because there's a better replacement, it's deprecated because it's _unsafe_.  The glibc implementation wraps getline(3) and therefore  doesn't truncate the passphrase or overflow a fixed-size buffer, no matter how long the input is, but portable code cannot rely on that.  And come to think of it, using getline(3) means that prefixes of the passphrase may be left lying around in malloc's free lists.

(getpass also cannot be made thread safe, due to recycling of a static buffer, but a program in which multiple threads are racing to prompt the user for passwords would be a UX disaster anyway, so I don't think that's a critical flaw the way it is for e.g. strtok(3).)

The Linux manpage project's documentation is, as I understand it, for Linux with glibc _first_, but not _only_; it should not describe this function as not-deprecated just because glibc has patched its worst problems and doesn't offer any better API.

> readpassphrase(3) has a few too many features/extensions for my taste, but
> at least it is harder to abuse.

I am inclined to agree that readpassphrase has too many knobs, and I can't think of any legitimate present-day use for several of them, which is not a good property for an API handling security-critical data.  Also, it relies on the caller to size the buffer for the passphrase, and therefore risks truncating people's passphrases.

With my libxcrypt hat on I've thought a bit about replacements for getpass.  The conclusion I came to is that the easy changes are all putting lipstick on a pig, and if I was going to work on this at all I was going to design a privilege-separated authentication service that could be asked to take over a tty, read a passphrase, check it, and return just success or failure to the caller.  Neither the passphrase itself, nor any strings derived from it, would ever be in the caller's address space.  But this is obviously well out of scope for the C library.

zw
