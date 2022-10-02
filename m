Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D58C433F5
	for <git@archiver.kernel.org>; Sun,  2 Oct 2022 04:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiJBEwJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Oct 2022 00:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiJBEwI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Oct 2022 00:52:08 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4124363F
        for <git@vger.kernel.org>; Sat,  1 Oct 2022 21:52:06 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c24so7166865plo.3
        for <git@vger.kernel.org>; Sat, 01 Oct 2022 21:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=OYvOXG4DsIGP4GRXhnCgN+mORRcVOm3rBwYAHNcuxwg=;
        b=FXTCrCIPYC/2Re4TiLp4f45Ko6G/nTSGQOEEwXnpi9X8OIchZ9OoqGpbcrKLCWJYjS
         lA7RPqJk/YcfU3sS682hG6BDYXFOqVS/wl8rl6JJl9p6BNoIG1Ktu/j1GcS+GoBzSDCT
         HzHe9nY287QIpZkN56VKhB8aklPwvlZQDsJbuXRUg/pWKGTE0dnUk1z9nsTyobrZtwcj
         sJd9Q9dgOSaX5i4ns09DeIhQ0p457zmHT6pD4JPgfWE144MmDsXRmPhxBnbdg7kMUYN5
         bmCshkH9eoYt95jBvvApbodPb8zjJlVFsa6FrMe2ICc/74apy7igAYGJn8a8u8EV4nph
         lFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=OYvOXG4DsIGP4GRXhnCgN+mORRcVOm3rBwYAHNcuxwg=;
        b=6I68lWFH0wnlAbqpkzR6ZUU7mKrrmCgfpvHxVm6XhlCtAtZdgClugP/8A8mwOfcySq
         Jf46cIvVooJt5ro3Kbsbvcv8xfqgHyHQ3190DgaObtu5GIg5jOlxTLdm/4bfkcvwQDQn
         WGQfk3LI3UoZanFBAFG/MImqEcD4W40BWPLxIkIUgDGEFC2xpZS/bKOZY4zulen0LELw
         KtyDHvpBw9LBOZy7LcOJjcmjSnua88IJwDyxWlP4TY9IrSsRaXUKJUXIPTz1rIP0bg17
         xm3RIPGC/cM91JA0ykScLYlYBowH5WU5EKCfz+h5QhhE0zMwd6Od9rwW6XsVwj07Z8/N
         o5GQ==
X-Gm-Message-State: ACrzQf0Ivanr3tMf2/CTwZQvxPTVWZN07g0vvSJyXLHN+MZG8dLIysho
        lg1FRoCP+vHrPcha3qbKHTiOztq2XEg=
X-Google-Smtp-Source: AMsMyM4QdgyhgSXoRrwmSBO3yQcXgsa4mgQ99pJ6b7p5pt6Qtf24QMgmvlypbwrwAgUMKa2VD6sO5A==
X-Received: by 2002:a17:902:cec9:b0:178:1da5:1075 with SMTP id d9-20020a170902cec900b001781da51075mr16912411plg.136.1664686325441;
        Sat, 01 Oct 2022 21:52:05 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id i62-20020a626d41000000b0053e468a78a8sm4630401pfc.158.2022.10.01.21.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 21:52:04 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 21/36] doc txt & -h consistency: add missing options
 and labels
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
        <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
        <patch-v3-21.36-1713227d497-20220930T180415Z-avarab@gmail.com>
        <xmqqwn9j2xmu.fsf@gitster.g> <xmqqczbbyuqj.fsf@gitster.g>
Date:   Sat, 01 Oct 2022 21:52:04 -0700
In-Reply-To: <xmqqczbbyuqj.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
        01 Oct 2022 16:44:36 -0700")
Message-ID: <xmqq35c6zv2j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Instead of going over the patches in the rest of the series, I think
> we'd probably need to step back a bit and give ourselves a general
> guideline.  

Having said that, I am a bit torn on the next step.

The updates done in this series stops way short to make the usage
strings conform to the proposed guideline.  We could include such
changes to make them conform, but that would make the series that is
already long even longer, which is not what I want to see.

My preference is to go in the other direction, i.e. make NO attempt
to improve usage strings in this series, the only change we will
make would be, except for documenting the coding guideline and
adding tests that ensure usage strings in the code and in the
document match for majority of commands, are to make sure the code
and the doc match (IOW, if an existing option is not described in
either, we leave it to a later round to add it, as long as the code
and the doc consistently fail to describe it).  That may allow us to
make this series shorter than it currently is, hopefully?  I dunno.

And a fix to the proposed guideline.

>  * The usage string for a command with a large number of options can
>    and should use "[<options>]" placeholder in the SYNOPSIS and
>    "usage:" lines, i.e. "git cmd [<options>]", and let the
>    DESCRIPTION section (in documentation) and the option listing (in
>    the output from usage_with_options() function).

"... list and explain them" is missing from the end.
