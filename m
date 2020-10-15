Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7D8C433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 19:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8A68206DD
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 19:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUxEwy5p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391687AbgJOTde (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 15:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbgJOTde (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 15:33:34 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C12C061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 12:33:34 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id s81so4303572oie.13
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 12:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xzTw/3rPf8algxj6xrAaoLMe0P2kZWKVoSQszm5bevU=;
        b=jUxEwy5pBll4DIStEcos2s9f49ZVccciNJD+7dBnVmfI9Q3NdFltXs2x+oWoQRTqCE
         VqAX4kYvxSohvkKk28m/PlFxqlRWcCKOdjkwyvqb3RZaUXNEbfu+U8KijKKFt8sAfBqT
         uyF1PJ+Do/KD84koS7petNqvTb3sh1TJT5ER5pEi7uVB1Fx4vdVApdPiFBOPiaGLNrHF
         2J4kJ8HYd+p9K2+9A32UTQJlXpN1sw2XFgyalnvKCK1NMx8dPNGMsg8kvK9a8DLiCEiv
         bZCnWA7kqmZQ9RTxE+q6MqULn0JvqddtjT+BTyMR2RSK7JIOMdPbYOrHICRU5oprkR+Y
         MBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xzTw/3rPf8algxj6xrAaoLMe0P2kZWKVoSQszm5bevU=;
        b=cW5dtONxZsumvW4EaVDAhyNdZb1uWH9Ht9ycBDWD6xwRszFA8ny7nw4PYrCmvsIo+g
         LhCHfUnX7ld7U7NrtW6ZiogTgvUWOinypV/kZU366eAvd2bfT5KQASqYj3UWO5Wyh4se
         GiFDED71OGRf1HQpPpubgIEy7KeEAw4H9jE0bbl43Ca10smHofEg2PD3BJPiGe118IUL
         QDwdLJfhbJVJqnP/kOeB+lWf8+xqcqnTTJb6mvisnJPeiNezEzkPHebUwa1hkiVdA9zR
         +f+jqer0NChY7iRkj5tgT/7aZP6krwXoJJ6zAan8oUesB4uGbwCJVvuEB1hGS0+v/gXP
         D7rw==
X-Gm-Message-State: AOAM530SL4uzIOv+mGSnVeZ1ZduHkZuTxRaojoNRW1SbWWQLMdm1S9xa
        SXFTGLyp3Hmdze3/fS0jfOKrq28skDPuJAs2nVU=
X-Google-Smtp-Source: ABdhPJxY99aP632IY6DtzX68yaBPaG78SOYS4tgNaOgHlWrJbvlcvz3+xp9EYmODXfcxhyBIPA8QvAoe1QHoEXq4+RU=
X-Received: by 2002:a05:6808:246:: with SMTP id m6mr14366oie.151.1602790413610;
 Thu, 15 Oct 2020 12:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <pull.757.git.1602766160815.gitgitgadget@gmail.com>
 <20201015160725.GA1104947@coredump.intra.peff.net> <xmqqk0vrfi1r.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqk0vrfi1r.fsf@gitster.c.googlers.com>
From:   Nipunn Koorapati <nipunn1313@gmail.com>
Date:   Thu, 15 Oct 2020 20:33:21 +0100
Message-ID: <CAN8Z4-XdDzJL6k4wZqKJt3=mXajycb0oj-f0WSjcLaFCFRmHKA@mail.gmail.com>
Subject: Re: [PATCH] dir.c: fix comments to agree with argument name
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Alex Vandiver <alexmv@dropbox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Happy to update it to use the object based terminology, though I'm not
sure how the desired final result differs from above.
I believe I said "compute oid" in the comment - and it is all in one commit.

gitgitgadget appears to have shown a range-diff from the previous
iteration, but the latest iteration is still one commit.

--Nipunn

On Thu, Oct 15, 2020 at 7:41 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> >> - * If "ss" is not NULL, compute SHA-1 of the exclude file and fill
> >> + * If "oid_stat" is not NULL, compute SHA-1 of the exclude file and fill
> >
> > Makes sense. This changed as part of 4b33e60201 (dir: convert struct
> > sha1_stat to use object_id, 2018-01-28). Perhaps it would likewise make
> > sense to stop saying "SHA-1" here, and just say "hash" (or even "object
> > id", though TBH I think the fact that the hash is the same as an
> > object-id is largely an implementation detail).
>
> I do not quite get your "though TBH", though.  I do agree with you
> that it is an implementation detail that an object is named after
> the hash of its contents, so saying "compute object name" probably
> makes sense in more context than "compute hash" outside the narrow
> parts of the code that actually implements how object names are
> computed.  So I would have expected "because TBH", not "though TBH".
>
> Anyway.  Nipunn, can you fix both of them in the same commit, as
> they are addressing a problem from the same cause (i.e. we are no
> longer SHA-1 centric).
>
> Thanks.
