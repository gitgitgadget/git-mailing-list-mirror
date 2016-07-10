Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEAA02018E
	for <e@80x24.org>; Sun, 10 Jul 2016 21:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757264AbcGJVBY (ORCPT <rfc822;e@80x24.org>);
	Sun, 10 Jul 2016 17:01:24 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:33670 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757207AbcGJVBY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2016 17:01:24 -0400
Received: by mail-oi0-f41.google.com with SMTP id u201so123718187oie.0
        for <git@vger.kernel.org>; Sun, 10 Jul 2016 14:01:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Ff1e/t8vA41mMtJ4vWtPXuWvrat2ktvL5wDccUIIbbc=;
        b=ZPeC/s0EMI1bkUhWNxIVUsPT1zPEarr14P71sLoXf1MafCmO6bkFk5tlUfiMQ7HUT3
         tGzJtysJV33sklGHq9ZL20KQ8FT7lDVUhrpTK27oG72pbbKnC2q3ql4VAvwz1aHERoCW
         o74cVi3Sm2mogXpkGS5lQcct09SXg+BL9SAV4xXI5jmfWZjXeObG5jPaV6Sa3llJseeK
         V5h0uHODx0L3qaOFSFTp3mixm3cySj+/vIXk7dH8dPpjtNe5+jh6cu6DK9AXUKqtoovB
         yinwxnFcrfA5QsyNX1JmwK4i7/JEsuiuVRUFW3E3uLxPSJ6ZlsyN/wYvtB2QQ3y2ta+C
         JNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Ff1e/t8vA41mMtJ4vWtPXuWvrat2ktvL5wDccUIIbbc=;
        b=MXst7Ngki8sZNsNphwya8e2wiOsHlaH8ZA+MdffyCpHZ/OU06hFyKWt4/+eqx/uRT3
         v/kVTBHK8ZNS7IrUDivDTlr9bmylsUnvZeKIJRdFIjM/OVq5UeC9E0zS4geiWIfUSd7D
         yf/SSCfVNSWs+u6K9B3qTGQEqHSiu9t7phSvzl75UCetTAMHMz2Ip0seh3oSiEnH3HnF
         uNhbqh+TkwoKwXNKEjTs96cNrrD7bvLt3DYGh4KarXq03Enag6rxCSWTX4ln9vWHdTVq
         5KpTS7udxjjVk0hJxEV73SMj+AZ9zG+IOvG8Jh8C1YieGvmRhg/aumJbTCCETp68DfEh
         96HQ==
X-Gm-Message-State: ALyK8tLWgqWgIAfXsYN/TKVON7z/sYhYAq59wp2SHG+SiVDi6fR8n/uGJV+mNMDHs0uFEUpIyqcp8bterDXeqA==
X-Received: by 10.202.207.205 with SMTP id f196mr6914465oig.178.1468184483128;
 Sun, 10 Jul 2016 14:01:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.221.68 with HTTP; Sun, 10 Jul 2016 14:01:22 -0700 (PDT)
In-Reply-To: <87eg712v5o.fsf@linux-m68k.org>
References: <CA+55aFz=sZnABJr6F2yF_xvx6J6fZod6BbiL2OwszEnjjn-dEw@mail.gmail.com>
 <87eg712v5o.fsf@linux-m68k.org>
From:	Linus Torvalds <torvalds@linux-foundation.org>
Date:	Sun, 10 Jul 2016 14:01:22 -0700
X-Google-Sender-Auth: 8latzGuhdpLdUnPZgbGNUGVen0Q
Message-ID: <CA+55aFyJP8FLaBtsMekzQDsCjDbFPa-qUZNHZNpvva2vZTRGgQ@mail.gmail.com>
Subject: Re: Odd git overrflow bug?
To:	Andreas Schwab <schwab@linux-m68k.org>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jul 10, 2016 at 11:41 AM, Andreas Schwab <schwab@linux-m68k.org> wrote:
>
> I've seen that too, but only at the end of bisection, when it tries to
> display the bad commit.

That's apparently what the kernel bug reporter sees too now.

However, I cannot reproduce the problem with the particular kernel
bisect that the reporter is using. Judging by what he bisected things
down to, he must have done

    git bisect start
    git bisect bad 7ed18e2d1b6782989eb399ef79a8cc1a1b583b3c
    git bisect good 7ed18e2d1b6782989eb399ef79a8cc1a1b583b3c^
    git bisect good
    git bisect bad

but that works fine for me.

[ Oops. I tested something. It works for me with current git, but with
git-2.9.0 I get the failure ].

I'll try to figure out why git-2.9.0 fails.

               Linus
