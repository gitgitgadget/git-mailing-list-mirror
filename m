Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5A5C2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 21:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABF1A61164
	for <git@archiver.kernel.org>; Sat, 22 May 2021 21:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhEVVYK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 17:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbhEVVYK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 17:24:10 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0E6C061574
        for <git@vger.kernel.org>; Sat, 22 May 2021 14:22:44 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id n3-20020a9d74030000b029035e65d0a0b8so36742otk.9
        for <git@vger.kernel.org>; Sat, 22 May 2021 14:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=1PxtNpswyPEsBCa98Hd4Mt1c87Oc6eNLTLy52eAzHcs=;
        b=UoCLYWsa/u+ot/W/pgVSLjKJnumPj//OMyck86ruk5Z/me8vXf+zFSly6ld7nALsMY
         RG634oQRQ5BRut/jvWj0vqO6OOHOqFaQAmI+BnAQFNwaai6R9/kq+j39u8JxLGYlhJga
         rfyiZn9+y5d7Zrpl3ALjali72Q7diBBCZbMRz66yVvcfqq9ig+KIqLcquGQO+hluobX1
         rZkvia5iWzgZoDSX+SvYkAptiLqGiFu4inkQ/5mgH29ViiuT7DutP+RCIgez0Ph6JVZY
         SQo8XrEFgJ1l2SkjOlbxDTyYesEN8EDyTXlDHaWztu6nS6KQPTiwN5IR0xmTjJhDC4Hp
         6TnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=1PxtNpswyPEsBCa98Hd4Mt1c87Oc6eNLTLy52eAzHcs=;
        b=ZlFdpIAByI2TqEb7uMc2HZq4gph0XhedAvnpcjLvrQwUQ6iws1E9LPodb9T3WIn3gg
         owtN2eFeuoKaudJpY+uE4V+8123iaNYzqfykn/sPa+nqwQacZjfNUFAWyasgKFsul7fI
         kByseuUSjvlec6HyIN+Xk82clURWobSLfWi5XrLRdLITddxUhDRaGbM9apjDP/JBgc9c
         9FgQoYp57PvoadI6yZSMVOHusugaz21+VJzKC7wOgL+W155l3XF1C0hS3/1dEddr2HE4
         vHRIptUdsPi9omt16WBLwqyuCA3EBZat+ez66uFFhuOEkLLWnuUvp4Hs72z68EF/lOCi
         X8lg==
X-Gm-Message-State: AOAM532zAvug6YbODBMB5ZqDBTIKhm11IVJSH55wtUJHbytzA7HmiogP
        gVAiOM040xI/KS+oGXlFxwX1Ova6VdBxfQ==
X-Google-Smtp-Source: ABdhPJyIknseiV7hcbE5leeoeR+AY3zxkpOgp3RmA2cNFMWd8fxa7ahV0r6H02NH9HbAntU1Mdv+3w==
X-Received: by 2002:a05:6830:1e15:: with SMTP id s21mr13088873otr.144.1621718563793;
        Sat, 22 May 2021 14:22:43 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id x9sm1826618oto.79.2021.05.22.14.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 14:22:43 -0700 (PDT)
Date:   Sat, 22 May 2021 16:22:42 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Josh Steadmon <steadmon@google.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Message-ID: <60a976221c390_857e920812@natae.notmuch>
In-Reply-To: <xmqqfsyfqhkq.fsf@gitster.g>
References: <YKWggLGDhTOY+lcy@google.com>
 <60a5afeeb13b4_1d8f2208a5@natae.notmuch>
 <CAMMLpeScunGg5WM4N90vG+yN3tOATqhsL2iRLsJ43ksNyTx_wQ@mail.gmail.com>
 <dc14c50d-c626-19f8-e615-52ca3c9051dc@zytor.com>
 <xmqqfsyfqhkq.fsf@gitster.g>
Subject: Re: RFC: error codes on exit
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
> > On 5/21/21 9:53 AM, Alex Henrie wrote:
> >> On Wed, May 19, 2021 at 6:40 PM Felipe Contreras
> >> <felipe.contreras@gmail.com> wrote:
> >>>
> >>> It's good to not include many initial codes, but I would start with at
> >>> least three:
> >>>
> >>>    OK = 0,
> >>>    UNKNOWN = 1,
> >>>    NORMAL = 2,
> >> If you go that route, could you please pick a word other than
> >> "normal"
> >> to describe errors that are not entirely unexpected? I'm worried that
> >> someone will see "normal" and use it instead of "OK" to indicate
> >> success.
> >> 
> >
> > <sysexits.h>
> 
> Is the value assignment standardized across systems?

I think his intention was to suggest to use that list as inspiration...
As in have USAGE, NOINPUT, UNAVAILABE, etc.

I would prefer to start with something easy... UNKNOWN = 1, USUAL = 2.

-- 
Felipe Contreras
