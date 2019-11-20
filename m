Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDEAC432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 18:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30AF620878
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 18:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFnkYgeQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfKTSHO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 13:07:14 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34693 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbfKTSHO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 13:07:14 -0500
Received: by mail-pg1-f195.google.com with SMTP id z188so123072pgb.1
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 10:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h1SlSQWbcHLXMgveYncVhv0a7SokG7W+GmdcJYxfSvg=;
        b=ZFnkYgeQuqPVT6dOaUA8aXNt/Qfb9L+GcC7vtj+Voyu1QMQUL4njkBG5oPMwQ+i3yL
         DQ+VCEXhdEFuZgpbg3VlrePodd55f4eSC+QCss6sFKeDO8p/RW4x/M6zpN5tEPPjs2TK
         AuHZN9P/b2dugjm+KclMEwtEtTCXMDtmOHI7gy8S0EIFtmJPsZxgt+O67PRcfg6OI6BB
         OkqW3xRy76puHNGwYvbvNF8OWy3JsoCTZcSLKAbG3mKm0M4+lPUEU8lZMm385ccisvjx
         voy87Cd6GwDpQD7BEUfV+Wk+jDdRYhsNC3585bTjEKPsWutqAnttkO1VCUJ5eZG7mkBl
         OAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h1SlSQWbcHLXMgveYncVhv0a7SokG7W+GmdcJYxfSvg=;
        b=FWzidIcYv5eki8hDUfdFIPqifN5ihQ7sRu1+acxyWoqk2FD3FQvcgoRqQk96q3sWeg
         6z4aSKHjDpCsbxjtcvjWODYsL9FFsyFRWv7IWy7tMxetZWSufXxRfRLpquKzGIgE2Erz
         +uAhxhEewL6l3HV7WNE8R5VBT2ZrZuJYphpkX5aAWn89ZD5um63EX6BFso4A4EDMKISY
         lzaY6hnO9eDOdjh4c8VOsUSiZyIg72HNTCoBz+AZJwfnTsnfUUL6pcf0Sx0jyqhidonh
         x+2tVVAC4VfKtVJxmRqmXfT/lMW3x9w2ut0FyYJh2+WX/yrzheJHii5V3PR1mmVIW7ik
         jsow==
X-Gm-Message-State: APjAAAUvjxzX1U79NZxd9dysBaVNB1MYqWZB3aEAMn8y+i2HtlPUbEuS
        6rYzoSsamywwABgf0ME249V+LIjT
X-Google-Smtp-Source: APXvYqySe991yOVnE/0RGew4sPJall1oU1M/3uvEe6TkL6ctXQAKQryN6rY0mGhpVVri8R5d9INByg==
X-Received: by 2002:a63:2151:: with SMTP id s17mr4767690pgm.46.1574273233320;
        Wed, 20 Nov 2019 10:07:13 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id u65sm29628pfb.35.2019.11.20.10.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 10:07:12 -0800 (PST)
Date:   Wed, 20 Nov 2019 10:07:09 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christoph Berg <myon@debian.org>, git@vger.kernel.org
Subject: Re: git clone git clone some://url
Message-ID: <20191120180709.GA63368@generichostname>
References: <20191119141537.GD18924@msg.df7cb.de>
 <xmqqimnfcikf.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqimnfcikf.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 20, 2019 at 12:50:24PM +0900, Junio C Hamano wrote:
> Christoph Berg <myon@debian.org> writes:
> 
> > On some git hosting sites [*], if you copy the repository URL, you'll
> > actually get "git clone some://url" in the cut buffer. When you then
> > proceed to do "git clone <paste>" in the next terminal window, the
> > command executed is actually this:
> >
> > $ git clone git clone some://url
> > fatal: Too many arguments.
> 
> Or
> 
>     $ git git clone some://usr
>     $ git git git diff

That's why I have `git config alias.git !git` set. It's saved me seconds
of my life from having to retype these lines. ;)

Unfortunately, I don't think we can take a similar approach for the
`git clone git clone ...` case.

> ;-)
> 
> I seriously doubt "git" should do anything funky when fed such
> command lines.
> 
