Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D916C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 19:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3101E21655
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 19:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="key+ZcbK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfLTTiz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 14:38:55 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43257 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbfLTTiy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 14:38:54 -0500
Received: by mail-ot1-f65.google.com with SMTP id p8so13109248oth.10
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 11:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xqxFiv7y2sNLohHFh8OHg8WrhI5j9ZMitBwO1xVr5qk=;
        b=key+ZcbKxJwwBRXcd6vSe3C6EoQ15ghDpBZhbCcOQlK9cCLaajZqYvv3DV21O8ZPHK
         bTrqoUNvDcbLtCX2ZJsQx6ai2uiKhHLNHpPvEQg20ZRNBTElNYc75NWXrc7lpazLyhGh
         9fIMIeG1fYUNE+fVnVcQzCOI6UjbYzpee99u+I5Nuk13pZmgWHxHDQHuyFj16rQTDin7
         SpWadJC8MjKv0U7WcMXQaXKiOT8enam//alyR1uvU6FlFhUt3IJ0Eon+fa+wFD6WMF4E
         6GHnrizRmU38c8CSX0GcOBk+Guo4n7wJVNTMIPpxyJeivuoFLup9Di5mJqcQi29m5Rui
         JX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xqxFiv7y2sNLohHFh8OHg8WrhI5j9ZMitBwO1xVr5qk=;
        b=IFY+BBSRCqW+UBULuhGg556DKw4TwBdcERMzXwldee2uNGtuR0h+iryY/IvK/yiiJw
         hhtQJq2hjjEJAFlTOOOyW+ZCbVZxNe3z5RKCPQyjl1CGHxQ9AhIH+eQfarGY/8LLxymk
         fgdp8n44IZy958+Zv0SMM1gA2Xo081LNTfDuO7+oLEcKOiATx5m1Z5xwV5pXe07lEPxX
         k2ObD+jmTY8qnyYI+2jwHajSEsXhY+AQIHrQLm4X0Bkp4M+T8qm4RRjcEnPDe0Mr7j45
         4VMgdSvt271kBZfaDmwnk5bbxjeShL9J96TM+yN4iugKrP/tkHPXth7TXzah09Z4XmzV
         +PKA==
X-Gm-Message-State: APjAAAU/f5rlAhsTn36tp9gIXTTQMruQh1EV3MDnAmvHLdJ6C2FRLug+
        WVVMqQkw/r9kU9AVnBaeDLV4+sQwLA0Tnk6tNzU=
X-Google-Smtp-Source: APXvYqyXWRzmYY1ycTlmHugNWRPotpdGTnrmy5dFTTNhxju1nGr44lz6xuwuyYYknzdiaT+6Hjv8NAwkXjNqljvk4nA=
X-Received: by 2002:a05:6830:681:: with SMTP id q1mr17188921otr.162.1576870733652;
 Fri, 20 Dec 2019 11:38:53 -0800 (PST)
MIME-Version: 1.0
References: <pull.680.git.git.1576868036.gitgitgadget@gmail.com>
 <e1870f3fee8be6ebbecdd618ae1803afb878e67e.1576868036.git.gitgitgadget@gmail.com>
 <xmqqwoaq94ql.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqwoaq94ql.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 20 Dec 2019 11:38:42 -0800
Message-ID: <CABPp-BFYyF5RbZVuwo8LtDZZQ9KQ2od4FQqQYaeSqNCNKcZXPw@mail.gmail.com>
Subject: Re: [PATCH 1/2] am: pay attention to user-defined context size
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Pavel Roskin <plroskin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 20, 2019 at 11:28 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > am previously only checked gpg-related config options and the default
> > config options while ignoring any diff-related options.  This meant that
> > when users tried to set diff.context to something larger than the
> > default value of 3, it was ignored.  Pay attention to the diff settings
> > too.
>
> Can the benefit brought in by this change demonstrated by a new test
> or two?

Yeah, I'll try to come up with something.  I was originally going to
test 'git -c diff.context=5 rebase', but of course that depends on
Denton's change too to work.

> Puzzled.  "am" accepts whatever patch somebody else prepared and
> has no control over how the incoming "diff" was produced by that
> somebody else.

I was too, but the diff.context change didn't work until I fixed both
format-patch and am to pay attention to diff.context.

> Besides, I do not think it should be affected by any diff_*UI*_config()
> in the first place.

Does that mean that diff.context is checked in the wrong place in
diff.c, and should be moved from git_diff_ui_config() to
git_diff_basic_config()?  (And perhaps the same is true for
diff.algorithm?)
