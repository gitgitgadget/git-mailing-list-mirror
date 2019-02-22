Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C405820248
	for <e@80x24.org>; Fri, 22 Feb 2019 17:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfBVRtr (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 12:49:47 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44231 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfBVRtr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 12:49:47 -0500
Received: by mail-wr1-f67.google.com with SMTP id w2so3258229wrt.11
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 09:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=48prnI7ICAJvaxl/1irMGseD6K35ciekiMhV5LneKOw=;
        b=hIMDPUeg+gwGLlrhukDKn4UNWswWB9IA9rJbV3mwwz9yzV5p5LtmwG5hZ/ZXjfa+u4
         BCBlY/+8vTS5R7AAGXVnMbH6yUpFeZIiR5VP7mpIlhg1VnI8QKZSedg5suk8cabULdDB
         R95BOusTIjNZdAoreXXHc7ss9xRz0jBSnSnyPQyBJUhtZE7/JUF/SvDHMIZhHwm94vET
         3de7NwPY7EvUUvHICfPUin/UjXNHfybT89AAtXT0xvAoZXUtBc2zeR4wNn1yp9jfVqCG
         I5lKg07GDzpMxY70tDj6kyyXbpYNmW05TbTuF/A530+nNXQhkkmQg6DlxNcbJpqz0L7H
         jlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=48prnI7ICAJvaxl/1irMGseD6K35ciekiMhV5LneKOw=;
        b=PD5jpRumQKymUuHJTIJ54MgoeDCrjW4LKCvYJjwTvOlguSkyixcOE39ESztwqFMN93
         xzhWOD0GV005jvHWMpLlv8G00UCGJ/1Br5XOl/wlpZ/IfJWwZc4U3r7XJrewC09/01vM
         sj1BRGasSKPKa9BAsQu79ZC/xDR5lnbarJrj38i1YvgEaXIdj+GFss+2X047t0ZOKXJh
         RnoxyPybLYs8yjPbyl4/P+BMs6xCJl9ENOWV8lXJKOET7TXcrak6tiwVo3J62yKzkyEd
         HxRNVxYA4nZRN+A/0N72lWHH1fQeh2C4Yhmh4+LAbutivEmnKAGvjBR/qiLGLYPdiEWD
         9FmQ==
X-Gm-Message-State: AHQUAuZ33Y4veSdo0kTOLC4nqph0I/jcikaJjYNo0nJdE/omUSxgCI/R
        6SI6uL4GHEapn8pWEEwK/Jo=
X-Google-Smtp-Source: AHgI3IZG9YsOBp2GRHVTtiSyVyZ9BWU7tsuJ9Hwjn9hOFRSjAvcUU5VgbmCyh8lPAe1GYMluYnhHbQ==
X-Received: by 2002:adf:e58f:: with SMTP id l15mr2999071wrm.309.1550857785254;
        Fri, 22 Feb 2019 09:49:45 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h71sm2789862wme.20.2019.02.22.09.49.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 09:49:44 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Bartosz Baranowski <bbaranow@redhat.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] bisect: make diff-tree output prettier
References: <20190222061949.GA9875@sigill.intra.peff.net>
        <20190222062327.GC10248@sigill.intra.peff.net>
Date:   Fri, 22 Feb 2019 09:49:44 -0800
In-Reply-To: <20190222062327.GC10248@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 22 Feb 2019 01:23:28 -0500")
Message-ID: <xmqqsgwfr9vr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> After completing a bisection, we print out the commit we found using an
> internal version of diff-tree. The result is aesthetically lacking:
>
>   - it shows a raw diff, which is generally less informative for human
>     readers than "--stat --summary" (which we already decided was nice
>     for humans in format-patch's output).
>
>   - by not abbreviating hashes, the result is likely to wrap on most
>     people's terminals
>
>   - we don't use "-r", so if the commit touched files in a directory,
>     you only get to see the top-level directory mentioned
>
>   - we don't specify "--cc" or similar, so merges print nothing (not
>     even the commit message!)
>
> Even though bisect might be driven by scripts, there's no reason to
> consider this part of the output as machine-readable (if anything, the
> initial "$hash is the first bad commit" might be parsed, but we won't
> touch that here). Let's make it prettier and more informative for a
> human reading the output.

Sounds very sensible.  One potential point that makes me worried is
this move might tempt people to make the output even larger (e.g. a
full diff with "--patch" is overkill if done unconditionally).

> While we're tweaking the options, let's also switch to using the diff
> "ui" config. If we're accepting that this is human-readable output, then
> we should respect the user's options for how to display it.
> ...
> If we do care about the change in exit code from bisect, then it
> probably does make sense to go with an external process. Then it can
> happily die on the corruption, while bisect continues with the rest of
> the high-level operation. I'm not sure it really matters much, though.
> Once your repository is corrupted, all bets are off. It's nice that we
> can bisect in such a state at all.

This is about showing the very final message after finding which one
is the culprit.  Is there any other "clean-up" action we need to do
after showing the message?  I do not care too much about the exit
code from the bisection, but if dying from diff-tree can interfere
with such a clean-up, that would bother me a lot more, and at that
point, given especially that this is not a performance sensitive
thing at all (it is not even invoked log(n) times---just once at the
end), moving to external process may make it a lot simpler and
cleaner.

