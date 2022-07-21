Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA3BC433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 19:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiGUTwE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 15:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiGUTwD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 15:52:03 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4293A2183F
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:52:02 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id v28so2111363qkg.13
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I9h5FaasVSJlaytSbcrzE7tGO9yF1W1/QLLfl7sowME=;
        b=ASwByA/bVsRSHN1lFUiRQ03izWIgYi9f4fDwf/Ryi7oMeetXojn7Cyzi0kIjgaokY5
         ZXSKkInETGPeOaFYPpdaGLTwy4FUNfjsnelIFhWhYcww0orRzqxKJOxx8lFa75jJji8+
         27kRuB62zSKM/KMzSzTb94MH0MDKn8nWsd5SEtFFfMCMEOS/QY8V95Urm7ccQPIG9UpA
         KgZ2Bsu6MtaqBBh1gQU9weHUnH703vCRYNAzYkmce9BLwtPzcw5Tm3++eL/+XdWgn1QZ
         jwyzl7qhr3CoJgTUq4NxBHHGU00164C31LO13RovQMgFmaJO9vfcKtNUTFVNmI1Bojkw
         1uNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I9h5FaasVSJlaytSbcrzE7tGO9yF1W1/QLLfl7sowME=;
        b=ORvZDBJA4/m0doxCmAdt3L51sXFhwuALGixWDKvnlkUuZ2fqKYYSgyh7DZ6eaYhujl
         08vFNMv0CMPeuNayB1RfynMxR3/mvKDkR4Y78s1I6ADZ6gkgyK7Dtl1OUKMSIQGRAyNQ
         VPJo/VrD12iBP5xpoM5YT6FtK0se74aU1SEgBE947fQe88JiR8RToK01V1HlOFURtREI
         DVam3itboTetc4J5osHjypEyzNi8VMGwcDBqo3yqc93y9QYKQS6Zk9CdIeml9UMtxX3P
         RRboaG8AzEDxwMJsEEKr8IhSrjnqrz60ZYKXojWhWaSRuR1NXNFiV1T1U4L85j0oC6K1
         O2MQ==
X-Gm-Message-State: AJIora92LKMOQ68RidhgxTIhwfdHSbISfeV2A+pHYAQpNx3l/kLd4Z9V
        xzyeQpS19B3x8BxrSMk47D3m9TrQTwAj+eeLTUoao+Ac
X-Google-Smtp-Source: AGRyM1uRkFkeIWFVxpWBUMMJJJ4NlYteqIoaKU0xygUTtztye7Ow7FIAwABjhCunbeJaCN93SIEUd/VevIKYKtmRK0k=
X-Received: by 2002:a05:620a:754:b0:6b5:eb92:42e5 with SMTP id
 i20-20020a05620a075400b006b5eb9242e5mr53095qki.183.1658433121271; Thu, 21 Jul
 2022 12:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
 <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com> <e39b2e15ece14ba2b1118ae95e0d90ed60589b41.1658391391.git.gitgitgadget@gmail.com>
 <xmqqsfmulb6w.fsf@gitster.g>
In-Reply-To: <xmqqsfmulb6w.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 21 Jul 2022 12:51:50 -0700
Message-ID: <CABPp-BEddgN5QmFkfejC6jZXMAGTivQBtV8YQ8Jq0EZzPhAM8Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] merge-ort-wrappers: make printed message match the
 one from recursive
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 21, 2022 at 8:47 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> >       if (head && repo_index_has_changes(opt->repo, head, &sb)) {
> > -             fprintf(stderr, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
> > +             struct strbuf err = STRBUF_INIT;
> > +             strbuf_addstr(&err, "error: ");
> > +             strbuf_addf(&err, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
> >                   sb.buf);
> > +             strbuf_addch(&err, '\n');
> > +             fputs(err.buf, stderr);
> > +             strbuf_release(&err);
>
> Makes me wonder why this is not a mere
>
>         error(_("Your local chagnes ... by merge:\n  %s"), sb.buf);
>
> that reuses the exact string.  The err() function in merge-recursive.c
> is strangely complex (and probably buggy---if it is not buffering
> output, it adds "error: " prefix to opt->obuf before calling vaddf
> to add the message, and then sends that to error() to give it
> another "error: " prefix), but all the above does is to send a
> message to standard error stream.

Ah, that would be nicer; thanks for the pointer.  I would still need
to prefix it with an
    strbuf_addch(&sb, '\n');
but two lines certainly beats six.

>
> >               strbuf_release(&sb);
> >               return -1;
> >       }
