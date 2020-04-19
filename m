Return-Path: <SRS0=ylBF=6D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D6BC2BA2B
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 04:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0A4921744
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 04:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBMnJSn9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgDSEeZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Apr 2020 00:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725763AbgDSEeY (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 19 Apr 2020 00:34:24 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A771C061A0C
        for <git@vger.kernel.org>; Sat, 18 Apr 2020 21:34:24 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id y185so3826962vsy.8
        for <git@vger.kernel.org>; Sat, 18 Apr 2020 21:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o4bwdgF23o0Vn56XKelnEA2q0AmkFte6ARcCge0SOP8=;
        b=mBMnJSn96HhprVjexXhpR3xTNhu9cPQCiU1fvnVes+RH/lJCp5zH3L8R8UPbVzWx13
         jduE2NuYnScoZ2WXzd5rykoMzc8u1rZgzStvK+qrdWQ2Y3Ow/7cmRggiOFCjhWRzOiZ1
         Ykb1IipCggOLsUmSEZ8yZFuiJhlQEUue25RYwPxi/llh0NbxruFRDwoDKvbPWbl79aPA
         MDkhpE9q6teVtKYNGZfc7N1EOU1mpTsmUI+8GL7gjlk9Y9LQqdUNRMY5bvDpN7gGe0Gn
         odLaE2rQROTR9ctGanoYggipM7AsBYyWW/fcdr0JNNobCjYmZ+DpE8czNUPvsGIlHy0m
         umKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o4bwdgF23o0Vn56XKelnEA2q0AmkFte6ARcCge0SOP8=;
        b=JqcZO1Hc0MachRmgE7XF95gvAujiGjiSVZpykEZtNds1NZeLfPKuk1xN2TDP/mJXeC
         Wk8tuaLDUbkKbp3wFuE95Wg6PmQT+imOGoD+ISnOdwVaB2Q6KBgPhrPsrKNexdawJe2i
         RiUkySxJZJkg0P1uWKVbh6MEI1Q2XfILFFVOdWKKEtP0xpPwX36D2Od/JuSw0kEQ7oLR
         OuC4D8Cn302aGKv18PWsw53Pk/2mGSteFwHKl17ao9CtvXMbatRiO/4hJXTTwUQoQnJm
         x5ogKh0N8kryfkqYwH6NHtpc+aDkzsrFbyOoMLxfpBLG+1l88RMgDchhIPcLpS3cblOh
         o+zw==
X-Gm-Message-State: AGi0PuZX7GeJft7/NeaIa3imyJZq8RqXnz4XuMjfSDr774U3gkSxYDXN
        9Eh9P4TjZrUpSje7TuCrLQfm1axMlPQj57utLnU=
X-Google-Smtp-Source: APiQypLHzFbiXl4DuFovLvfEn+RL+t4PmVcd8WWBCrONMfV7jv4fd66fpS6BgX/gIsNxttbAis3xOT/XoLaRznh+P7I=
X-Received: by 2002:a67:e911:: with SMTP id c17mr7399427vso.46.1587270862618;
 Sat, 18 Apr 2020 21:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200418035449.9450-1-congdanhqx@gmail.com> <CAN0heSppn6BBX4V1T1qgKc4XP+8i6qbcEqd1_3NqWQtZJLaJww@mail.gmail.com>
 <xmqqk12ctmm1.fsf@gitster.c.googlers.com> <20200419024805.GC9169@danh.dev>
In-Reply-To: <20200419024805.GC9169@danh.dev>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 19 Apr 2020 06:34:10 +0200
Message-ID: <CAN0heSoj9fwpx5WbME+Oew-7NLfBfQCfAKissix+wnFk0UW5uw@mail.gmail.com>
Subject: Re: [PATCH] mailinfo.c::convert_to_utf8: reuse strlen info
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 19 Apr 2020 at 04:48, Danh Doan <congdanhqx@gmail.com> wrote:
>
> On 2020-04-18 16:12:06-0700, Junio C Hamano <gitster@pobox.com> wrote:
> > Martin =C3=85gren <martin.agren@gmail.com> writes:
> >
> > > This is equivalent as long as `line->len` is equal to
> > > `strlen(line->buf)`, which it will be (should be) because it's a
> > > strbuf. Ok.
> >
> > For the guarantee to hold true, line->buf[0..line->len] should not
> > have any '\0' byte in it.

Yes. I sort of assumed it shouldn't ("because strbuf"), but it's a good
question. Especially considering this is about various encodings..

This assumption that "strlen is length so the conversion is a no-op"
could potentially be broken both for input (line->len) and output
(out_len).

> > This helper has two callers, but in either case, it needs to be
> > prepared to work on output of decode_[bq]_segment().  Is there code
> > anywhere that guarntees that the decoding won't stuff '\0' in the
> > line?
>
> the current code allows NUL character in utf-8 [bq]-encoded string
> in this function (early return) and its caller,
> and report an error later:
>
>         error: a NUL byte in commit log message not allowed.
>
> meanwhile, if the email was sent in other encoding, the current code
> discards everything after NUL in that line,
> thus silently accept broken commit message.

My knee-jerk reaction to Junio's question was along the same line:
surely if we could have a NUL in there, the current `strlen()` would use
it as an excuse to silently truncate the string, either before
processing or afterwards. Thanks for looking into that more.

> Attached is the faulty patch in ISO-8859-1, which was used to
> demonstrate my words.
> The current code will make a commit with only "=C3=81b" in the body,
> while the new code rightly claims we have a faulty email.

Good find.

Martin
