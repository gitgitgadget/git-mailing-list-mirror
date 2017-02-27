Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01C831F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 23:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751529AbdB0X2e (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 18:28:34 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34851 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbdB0X2c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 18:28:32 -0500
Received: by mail-pg0-f65.google.com with SMTP id 1so2494230pgz.2
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 15:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=XK+OlxCGjK020HUH66NYyGiJe7ZQ/swBCp308bAT5Iw=;
        b=tf0S3tz3C4igyOfnxLU6vRwHaDf2th/XbeHgM5KHNEsLSJBeUzbYLVv3ncIgCSrCox
         RKq8q/XKAm+Zi6tnyIU781dRadzPymoWg8229qOFVpWbkpYWspEfsmUb6OjyV5X1o5eo
         TnWW9wLKmC+76TO+mCZHS/d7TEU6LxS68q1ZhfwCF52b2+s9zN+biPpPqM8ubBdSHFhf
         ZQikQ5BN+D5U70brIllYY68Jpqn9FzlaAi1LYZNCEOKnPyFeoOgf3D0x9SFYxAa19hEz
         8I4SNnTIN79FTY7eyIvwwAaMSaxjbxp80wHdvZgOPW58ILQDNvnCteB6pAKhiUglXGDW
         BUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=XK+OlxCGjK020HUH66NYyGiJe7ZQ/swBCp308bAT5Iw=;
        b=T540NKzpzB4xh/HhKas44GtFXPaWX4xZkZA+9jFoqLEbgDyUnL6Bx8tD2QUOhsRsP7
         ftIq2Q6yqIziRWZfWAQCv26j8b1VhGXFJfhpohRoN/Ci7Mui6l7kn0ufgBtubRati6Gu
         5FAvHSXiPg5h6Wj3IA8U5bnS+RWrS0O59cu0BkOB43t3BCt2yEiJ3pHQB6ocGMoY3b8W
         dzy3xAqN+Wgot6yc4R3cDg44ciU2LYpNBlN/PeOQR/W4E8O8mLhLaIEWXE0k0N77VV1S
         dW47uiqvBiNBd5urgU+KP+OYtgT1ryI+msiCVrOADfNchb6a7/a85FrhrEgEUg7hde1S
         F02w==
X-Gm-Message-State: AMke39m/rRnWMh4lHK+jY1YYdZpxf1fu22GIBMcWwpdMRp5vNpoKLQOLEw+jpBLtVypwWw==
X-Received: by 10.99.114.70 with SMTP id c6mr24007306pgn.163.1488236338386;
        Mon, 27 Feb 2017 14:58:58 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:c953:ec42:862e:1e81])
        by smtp.gmail.com with ESMTPSA id h14sm32816247pgn.41.2017.02.27.14.58.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 14:58:57 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        sunny@sunbase.org,
        Jakub =?utf-8?Q?Nar?= =?utf-8?Q?=C4=99bski?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v7 4/6] stash: teach 'push' (and 'create_stash') to honor pathspec
References: <20170219110313.24070-1-t.gummerer@gmail.com>
        <20170225213306.2410-1-t.gummerer@gmail.com>
        <20170225213306.2410-5-t.gummerer@gmail.com>
        <xmqq60jvwewc.fsf@gitster.mtv.corp.google.com>
        <20170227215627.GB17065@hank>
Date:   Mon, 27 Feb 2017 14:58:57 -0800
In-Reply-To: <20170227215627.GB17065@hank> (Thomas Gummerer's message of "Mon,
        27 Feb 2017 21:56:27 +0000")
Message-ID: <xmqq8tormea6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> On 02/27, Junio C Hamano wrote:
>> Thomas Gummerer <t.gummerer@gmail.com> writes:
>> 
>> > +	test -n "$untracked" || git ls-files --error-unmatch -- "$@" >/dev/null || exit 1
>> 
>> This silent "exit 1" made me scratch my head, but --error-unmatch
>> would have already given an error message, like
>> 
>>     error: pathspec 'no such' did not match any file(s) known to git.
>>     Did you forget to 'git add'?
>> 
>> so that would be OK.
>
> Yeah exactly, the plan was to let --error-unmatch print the error
> message, as it's better at giving a good error message than we could
> easily do here I think.
>
> Maybe this deserves a comment so others won't have the same doubts
> about this line?

Nah, I do not think so.  It probably is obvious for those who write
(and read) "--error-unmatch".  I was just being slow to realize that
the sole point of that option was to complain ;-)
