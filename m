Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E0F61F454
	for <e@80x24.org>; Fri,  8 Nov 2019 21:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfKHVrR (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 16:47:17 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38325 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfKHVrR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 16:47:17 -0500
Received: by mail-pf1-f196.google.com with SMTP id c13so5602321pfp.5
        for <git@vger.kernel.org>; Fri, 08 Nov 2019 13:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f1YX0pTKZVk8sC5A5KGOGfTqsI1gWJcfUu6oOeCsYwg=;
        b=kbwCkJqo71oqBrDBI419NbrjHnT0eROKYlcpIkd/xdoMWd/+FrfZpLrUnHtuPyb90E
         U3EXIEerF01ZtiYFveibsosUHcfeKmFa7zwq83Y3BkShwjlS4sAe1HxClOywJrqOReEy
         fJ2aRvm/KUP/BsddjqXgGwGeeKljaAWYB8SVhPLKWvY9iVILGgYsVPhotrtd6VA40NnF
         XmsB2WIR0l65flO5ECI5bjTDxglc6SvzSMYx4KguYTj+mGscVrPknM7DHBE2O7Jtvo0b
         kFK42awkJqbB19gMLPlcD/2ejT8QCEKoct469U8GKKQV0jyr+c7o3ZLYcfqdQW0j7Ovu
         TnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f1YX0pTKZVk8sC5A5KGOGfTqsI1gWJcfUu6oOeCsYwg=;
        b=pX4nTpi8FMTg88IzGli4Zdcy1Wiw+C9hmOE16hBmesdIAVGrOL6K0d5v0Z3IEngEQC
         jL4UzMvmV+ItD9kz87U+Ch2pcJDwe/ZIutyi9Tsjxmw16Tc4zZsfVOhuqin14KH8Ri6X
         YYqH76elaARJhheydcawaQ4LP2d22IkEqsoVkwBfoDplUE8WSltgspymvSxL78X7SLlB
         SFnHw0jy7c9dowtiXlmlckHWcl/f52f2T4oTG4wnKbcpqBxVY1CG/+KJG5RR9oDifo2k
         vifowkmql71tOwX3zU9vZ977LQYWzBQW3sQ/AJZjUtknoKpNxh7qMp4bXa0Lo413GAxs
         dx3Q==
X-Gm-Message-State: APjAAAXHFhtw3sMIeRQCwso0mW+gBqFpnzrtauwyYAM/32ho+F7ZaCLY
        f/kkPhivIiBFZFFOwODBnnGHPgHL
X-Google-Smtp-Source: APXvYqxW5Wi3vWMLXXtCtpWg+WfZJ6xyzvbVddt6UFQkt+Pxim6STW1fLo4uPR+TCKK+Zq6H7TDjnA==
X-Received: by 2002:a62:6404:: with SMTP id y4mr14246839pfb.170.1573249634929;
        Fri, 08 Nov 2019 13:47:14 -0800 (PST)
Received: from generichostname ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id i187sm8548612pfc.177.2019.11.08.13.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 13:47:14 -0800 (PST)
Date:   Fri, 8 Nov 2019 13:47:11 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 07/10] t4205: cover `git log --reflog -z` blindspot
Message-ID: <20191108214711.GA27310@generichostname>
References: <cover.1572897736.git.liu.denton@gmail.com>
 <cover.1573241590.git.liu.denton@gmail.com>
 <b5950823ce90dd2476f002ed0370b7e0099a4d85.1573241590.git.liu.denton@gmail.com>
 <CAPig+cQDMSwP5-D-=LgjBPH2kJK16Fv4c619Pg6OTU95CQ9sgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cQDMSwP5-D-=LgjBPH2kJK16Fv4c619Pg6OTU95CQ9sgw@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Fri, Nov 08, 2019 at 03:36:25PM -0500, Eric Sunshine wrote:

[...]

>     for r in $(git rev-list --reflog)
>     do
>         git show -s --pretty="$p" "$r" &&
>         printf "\0" || return 1
>     done >expect &&
> 
> For completeness, the above example also drops the unnecessary 'revs'
> variable, uses double quotes rather than single when interpolating $p,
> and makes the loop early-exit a bit more idiomatic.

The reason why I pulled out `revs` was because putting the rev-list
within the for-loop would cause its exit code to be lost if it ever
failed. Since I've been cleaning up test scripts to not lose exit codes
from git commands, I figured it'd be a bad idea to introduce an instance
here ;)

Thanks for the other two suggestions, though. I didn't know that you
could write it like that.

> > +       git log -z --pretty=oneline --reflog >actual &&
> > +       # no trailing NUL
> 
> To what is this comment referring?

I wanted to point out how in the oneline case, the trailing NUL is
already included, unlike in the multiple cases, so we don't need to
output another one.

I'll rewrite this as

	# the trailing NUL is already produced so we don't need to
	# output another one

Thanks for your feedback,

Denton
