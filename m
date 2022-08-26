Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CC0ECAAD4
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 16:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243678AbiHZQNb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 12:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbiHZQN3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 12:13:29 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B437CBFEAA
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 09:13:28 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id x19so116072pfr.1
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 09:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc;
        bh=NY+Lg6LHbTGr6rjYjkvsuRQq07ZNJMY4JAZ76g0GzOU=;
        b=Nv2atkqLIPgeOG5juOR3FnTq7nXN/tpyUHkOgcfA/iI7VA6WiqstmxbFpe/mO9UvcY
         aJXyRV8WLfOZQtA7zYILVbFC5i3yTo9b4d+h4NpUioo9O2UdkSgwFoYiIuzpySsNnUMd
         d6+9g8TCaTznJQANcXYVoSoO9R4ceIGElIBmz0LxouJxwHtu/iOoQF2Izve6eN8XxfUK
         PScD+61uLIXI5qxUCNtfrRFrvZLmdjJJZZ78EKIKLpA2IuO+I5uyGJxQf4xR2vyLuuQC
         a+bGrwEF/l24iuyDb+0euAKEFPZrFEvl5fBJ4/k4CHr9yqxH7ZhwYAaPdctsRo3Pzr9+
         zFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc;
        bh=NY+Lg6LHbTGr6rjYjkvsuRQq07ZNJMY4JAZ76g0GzOU=;
        b=RtTC2gbZE54y6kZhvHgNs8kdGa6XGxtKzL/YLMlbiLCV7sBZPKnjYDrhxbXjy3RR8O
         LnioQ+BL3wHvafpwwjeCOZQxPHaVuqA/noqNA5cacUr/Fob7DMOqBKcQP+D0+T4LWqrC
         UtpkcP9xNk/+oifNlSctEW+IoT2g2QqYYUoBJ8cxqWf2KGlfcsXVyKfB/mCMZXTXQlM3
         E7xEsmC44wmWPBdcJAtrm1nSGs0PvYH6fHvzYcjoa8p4d0hCsQVGqdPVsjWdl407Afdc
         d5w/wYvX+ZLlvr+1/nlH2xYNIWsBBeKimZatNV7/u6blbeRCMBPsC3ALaZCtnhZ0NDNP
         xCOg==
X-Gm-Message-State: ACgBeo2UyCYt3ArRYfyQX9Jtb7SrREzTOs3FxGeMHdpSEm0qHGEc+OJf
        8IIK8sKtAimeuyAhsw352CiE9/E7ACk=
X-Google-Smtp-Source: AA6agR7e1wnT95kKckqhJ96f5IB10tvPAyCAlTcoSn9RlzTm+kzBBITCCxfBkPpmIGn//k8/dKoHng==
X-Received: by 2002:a05:6a00:1907:b0:534:f2ef:e8fe with SMTP id y7-20020a056a00190700b00534f2efe8femr4527313pfi.65.1661530407979;
        Fri, 26 Aug 2022 09:13:27 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id j12-20020a170902da8c00b0016784c93f23sm1805487plx.197.2022.08.26.09.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 09:13:27 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Javier Mora <cousteaulecommandant@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Potential problems with url.<base>.insteadOf
References: <CAH1-q0iPsnkypiF=2LRgXwNqE_+R0gj706FCKgqGEUum+OAhQg@mail.gmail.com>
Date:   Fri, 26 Aug 2022 09:13:27 -0700
In-Reply-To: <CAH1-q0iPsnkypiF=2LRgXwNqE_+R0gj706FCKgqGEUum+OAhQg@mail.gmail.com>
        (Javier Mora's message of "Fri, 26 Aug 2022 01:47:08 +0200")
Message-ID: <xmqq7d2v0yqg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Javier Mora <cousteaulecommandant@gmail.com> writes:

> The choice of `url.<replacement>.insteadOf <original>` as a way to
> replace URLs is not only a bit confusing, as it has already been
> discussed[1], but also presents some problems and makes it impossible
> to achieve certain configurations.
> [1] https://public-inbox.org/git/20181122173109.GI28192@sigill.intra.peff.net/
>
> SCENARIO 1:
> I want to replace all references to the (now defunct)
> 'http://example.org/' to the new server, 'http://example.com/'.
>
> OK, that is easy (even if a bit counter-intuitive).  Just do:
> git config url.'http://example.com/'.insteadOf 'http://example.org/'
>
> SCENARIO 2:
> I want to replace BOTH 'http://example.org/' and 'http://example.net/'
> with 'http://example.com/'.

So, you want to end up with

    [url "http://example.com/"]
	insteadOf = http://example.org
	insteadOf = http://example.net

but you cannot get there with only "git config VARIABLE VALUE",
because that syntax is used to clear the existing values for
VARIRABLE before setting it to VALUE.

Have you tried

    $ git config url.http://example.com/.insteadof http://example.org

that clears existing values for url.http://example.com/.insteadof
and sets it to "http://example.org", then immediately follow it with

    $ git config --add url.http://example.com/.insteadof http://example.net

that keeps existing values for url.http://example.com/.insteadof
and adds another value to the same variable?


