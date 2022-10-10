Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0123C433FE
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 16:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiJJQWx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 12:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiJJQWv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 12:22:51 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A94C44566
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 09:22:51 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id e62so13552814yba.6
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 09:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H706fcF+VZR4u1YjFxiTlauf+0AidtG92XOat8r3HLw=;
        b=cZFCxs9bA2rthgauVgxCbQWllqjgRlOlEBcUvCZCNshcgtAXbDFA58y/MucYAdI5Gm
         iAh/2qQAqpPUct6nZn3meo6KhwvxugB8RkG8bc+Ynz8xhPiYIsppgPXoONd/q1QIa9Qt
         RkYe9KekKyWUb5LlbK5YsWbtPLsoprMDjwsiIHPQRpayCXDmJI7vcfo0oJHPX+KEbpTa
         mk+GY72J8Nlxfx2tV/LKJ5PHcnRrVMJmVW9oGv5YYAdX7Oy0lMparDSuN7U8m4SfpqC8
         lvMwNyI50+jke39PK6BqNh8Rs6D09AlUTyk760fwaYpGr71zoVnX//2bYXiiUR5g+EXG
         1MMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H706fcF+VZR4u1YjFxiTlauf+0AidtG92XOat8r3HLw=;
        b=OaHQSTcOXj/JXTiW/ClHmZhJYitdO26HwB/kTSPoXsnG7Ugx8ZlIQ7j2r7tDfIlLEi
         233uzaWM8tV8EhNz9XRD3GdrfCtIyoLLpAmr3rl0o/kWAEuINDNnklHU7osW6NZKalkp
         3A2YvjLBov6VQqbFTGVoEwYq2YMmuZVCJspYIE2caHRJ6jU0Pi82s7d9QB238WH5q/Zs
         VZyT5IgMx4H+FnedYKUrTlgxOSIF1UHGUCh8bVzCAchMr9y2dLHWlFfB3VFsTxTTgW+1
         PGC2IqdI9upPVKnK0olCgtsJbSViV+2QCJ0vjA/eNCLeqsBRz1SMvlSbjwqMvDC8aews
         pm6g==
X-Gm-Message-State: ACrzQf0dO89fUhd6JrlGQW0I/vm7xJ306M+buXJgPXmCPuGb65f/NW/U
        2sKwMseihq3onPgoAOSKY+LKaaueRKSVUrB3hxhcYpqizLs=
X-Google-Smtp-Source: AMsMyM4BOLaWdKU2fA0SAB6Mh07r8wfc5+KR0H/WuNbn/FSmQwfSV7+lBJFvKhzrTqWzpZ2UemFbhDy32G+XJVnNqaY=
X-Received: by 2002:a25:2fc8:0:b0:6bf:7267:3114 with SMTP id
 v191-20020a252fc8000000b006bf72673114mr15362123ybv.447.1665418970535; Mon, 10
 Oct 2022 09:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <CA+PPyiEvfkqZYq6uESMt3QYnfMDZDmPbGiQ5Qkeb77rtLV5Aug@mail.gmail.com>
 <CAP8UFD1o5qxSvbV05DK_J=zbU=D_+HS0Q2ufEFSQVaBoWw_7Ow@mail.gmail.com> <CA+PPyiF5KK6p7rv57YL_wsDO+WPifoRp1oe0F-6mo5NxLAwDWw@mail.gmail.com>
In-Reply-To: <CA+PPyiF5KK6p7rv57YL_wsDO+WPifoRp1oe0F-6mo5NxLAwDWw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 10 Oct 2022 18:22:39 +0200
Message-ID: <CAP8UFD26PY-53vZNZJzCRNiqaVB4fd=AvBtVuvMQP9p8Oqj82Q@mail.gmail.com>
Subject: Re: [Outreachy] internship contribution
To:     NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Cc:     git@vger.kernel.org, Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2022 at 2:19 PM NSENGIYUMVA WILBERFORCE
<nsengiyumvawilberforce@gmail.com> wrote:
>
> I see most of the articles are UNIX based, does it mean that I should
> have a UNIX based operating system in order to contribute?
> Currently, I have windows installed 11 on my PC

You can install a Linux virtual machine on your PC and develop in this
virtual machine, or you can install the Git for Windows SDK from:

https://gitforwindows.org/#contribute

It might be best to install both development environments. I will not
be able to help you much with development environment issues if you
develop on Windows, but if it works for you, that could be Ok,
especially if you use GitGitGadget too.
