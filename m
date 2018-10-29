Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DD951F453
	for <e@80x24.org>; Mon, 29 Oct 2018 08:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbeJ2Qwp (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 12:52:45 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:47008 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbeJ2Qwp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 12:52:45 -0400
Received: by mail-ed1-f68.google.com with SMTP id v18-v6so6410374edq.13
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 01:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=c2nj5qjlAhnTgtAvY/N5XUk5FDGdJGd2ko+gyp9fTyk=;
        b=AoZrkViZNjJTS6gTbq9u579Az0y0oIYJ0vnTwbYAhWxJcCmUWJJjBoqhJKGfx955L9
         dWef+jWnnga7j/Yt+7BkB0h7KvV/huichAb+YX8lJ0tjOHQY53cPXhgmkChFECkQuiVt
         MZ4ti3/IaJb8fLKvVK+x5F2+kdAGjggDoqbVhyPE0d/wczFrCW1f5JKfjTcj8I1EeIGk
         VMXuA5CC680m8ctBEUIIy+NyiN2hXlsD5BxSm4yHcBS/X8wjChQrOHfozzgMW2d4/jdu
         uSIVkVjpZDxDJErl1hgYTpcd19/CIe2u6Ya0TJyusumMRzQDCg/iQexOWVPUj/LbZUYb
         vZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=c2nj5qjlAhnTgtAvY/N5XUk5FDGdJGd2ko+gyp9fTyk=;
        b=UxGTKEMr8QtY7MQeFW4yc2zQ5JR1II6iuDGOmWgtayceKTNVZneeIkKhKDGt0RYABB
         tcyC9TJIv51093eCCqN/KKpifm0HeHMOrPIvzuWOJP/WQTy51T07jh47ft7y9YKpOVxN
         LTvratlUcEG+wdoLaBlZ1RsqKR+PiODE1nO2dx4mdYcS0ntcsgDVjWHZO81AW7nWe9jS
         +DVLjEkAIbdUyYc6VghidOidnAdlmI1wKw3xr11SNvcVwMQFJOlcIcqSTermKBC6ldGb
         1cbAcOyMxX6cXygmACPoMW1jzQxCl3XuFCemkq61Jd4jlopOSOrEBodPdLB9a/jIo8ZJ
         MbMA==
X-Gm-Message-State: AGRZ1gJvxfXjtM91hGnqGWBrV0TOHn8XRI9v+39V7o2WhM7R5Snybmdx
        O6m+TjjVTOwlbvAM3qtFr7KDDxbBHf0=
X-Google-Smtp-Source: AJdET5f7TXsJTsR4GIHIhIRdzdWdfisCCOSebXlqQYWwGgUh+NmIcwjhwBfkrXFF3WFJgZmewaGHvQ==
X-Received: by 2002:a05:6402:3d8:: with SMTP id t24mr13114986edw.21.1540800311523;
        Mon, 29 Oct 2018 01:05:11 -0700 (PDT)
Received: from evledraar ([2a02:a450:3911:1:fd59:dbfe:7c38:41f0])
        by smtp.gmail.com with ESMTPSA id e49-v6sm5167054edb.54.2018.10.29.01.05.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 01:05:10 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 7/8] push: add DWYM support for "git push refs/remotes/...:<dst>"
References: <20181026192734.9609-1-avarab@gmail.com> <20181026230741.23321-8-avarab@gmail.com> <xmqq7ei144gn.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqq7ei144gn.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 29 Oct 2018 09:05:03 +0100
Message-ID: <87k1m1kwk0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 29 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> This is the first use of the %N$<fmt> style of printf format in
>> the *.[ch] files in our codebase. It's supported by POSIX[2] and
>> there's existing uses for it in po/*.po files,...
>
> For now, I'll eject this from 'pu', as I had spent way too much time
> trying to make it and other topics work there.

I was compiling with DEVELOPER=1 but as it turns out:

    CFLAGS="-O0" DEVELOPER=1

Wasn't doing what I thought, i.e. we just take 'CFLAGS' from the
command-line and don't add any of the DEVELOPER #leftoverbits to
it. Will fix this and other issues raised.

>     CC remote.o
> remote.c: In function 'show_push_unqualified_ref_name_error':
> remote.c:1035:2: error: $ operand number used after format without operand number [-Werror=format=]
>   error(_("The destination you provided is not a full refname (i.e.,\n"
>   ^~~~~
> cc1: all warnings being treated as errors
> Makefile:2323: recipe for target 'remote.o' failed
> make: *** [remote.o] Error 1

Will fix this and other issues raised. FWIW clang gives a much better
error about the actual issue:

    remote.c:1042:46: error: cannot mix positional and non-positional arguments in format string [-Werror,-Wformat]
                    "- Checking if the <src> being pushed ('%2$s')\n"

I.e. this on top fixes it:

    -               "- Looking for a ref that matches '%s' on the remote side.\n"
    -               "- Checking if the <src> being pushed ('%s')\n"
    +               "- Looking for a ref that matches '%1$s' on the remote side.\n"
    +               "- Checking if the <src> being pushed ('%2$s')\n"

Maybe  this whole thing isn't worth it and I should just do:

    @@ -1042 +1042 @@ static void show_push_unqualified_ref_name_error(const char *dst_value,
    -               "- Checking if the <src> being pushed ('%2$s')\n"
    +               "- Checking if the <src> being pushed ('%s')\n"
    @@ -1047 +1047 @@ static void show_push_unqualified_ref_name_error(const char *dst_value,
    -             dst_value, matched_src_name);
    +             dst_value, matched_src_name, matched_src_name);

But I'm leaning on the side of keeping it for the self-documentation
aspect of "this is a repeated parameter". Your objections to this whole
thing being a stupid idea non-withstanding.
