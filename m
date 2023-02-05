Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CE7C636CC
	for <git@archiver.kernel.org>; Sun,  5 Feb 2023 06:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjBEGuL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Feb 2023 01:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjBEGuK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2023 01:50:10 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837A8206AF
        for <git@vger.kernel.org>; Sat,  4 Feb 2023 22:50:09 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id f15-20020a17090ac28f00b00230a32f0c9eso1020226pjt.4
        for <git@vger.kernel.org>; Sat, 04 Feb 2023 22:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+nkxFOvjckhI8hvD5rKhkyYEwNXRn9wYNl405HyvxF8=;
        b=mtPdL0w3Mmyjl5p2XwPPpR0xOuoDMY+OQS6Ha1BisJS0jwHeqCHN+Ehr3YX81tZ8Jn
         DfWiNSBK6VgmyW1TM7e2DnOPDKjavAHpnMUcxifWdFmQ5UzpbcPSFBWczNGxdPZ3V16+
         MXnjfCBgRSwNoP3DiBP5lqOjvoNu82i/ZBpv6eYNPxbY2HFoW2CrjhLbibBfETLjNevp
         cxqH5LdeliHm43h0Gb+HbjoVJiRSiEBZQ3Krn7jQm4/7mAJCoCarwn3mRrMsJABsxESu
         Vaz3jDHYvGIY+F71EEwnHP0tMJO0KgDtuEbbyPED/LnZKZd6MdOoyPiMkf4GBP65ktYJ
         JnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+nkxFOvjckhI8hvD5rKhkyYEwNXRn9wYNl405HyvxF8=;
        b=q3saYZS1qTdp6zahPFYlf4Q2CV9oD4eerJP5swFEf/sTG41/pyOwdXQDZX/FQt1arc
         /PPsFC5/SP8voo8ku4a3B9/RANSLUAmCEAxJZ5CXCs5DJ5pMSgmxnftf3qU2sZBt3Ozo
         m8DzJp0ISlIoSGgg7l5qPkormzV1YzmTBRwlkrib+06eZeUPztkwqQQyQBzRHTuAnFy/
         C6DOlfv+91XdbDvrDvyXeucj/EGLK13+qoTEpBNAD/0KSHdiFcYL6guhO9Bp+dxuXww/
         M6XIt1T3hhvo0IJpRhVSRdXggVOBiFJ+iMXT4jG/N54pkmF99fdbRzin85CfGhavaDrb
         jhFg==
X-Gm-Message-State: AO0yUKW+Nca/ANyDKIFhCd2bCKWkpxgqysfwznZvmtO5fufuf3uA29uW
        ekUwKneLNs2daTSfg2QHAgBm0xXzYq2WydQMnkI=
X-Google-Smtp-Source: AK7set9hTWgXuYR4cgBFvwJeURCb5DXMEAqNGWS6lNk/ORwcXWc2mgnvXuXazz95x9taRnaGokE2/LMtjhFYZgtvL60=
X-Received: by 2002:a17:90a:3d08:b0:22c:380c:58d7 with SMTP id
 h8-20020a17090a3d0800b0022c380c58d7mr2129255pjc.117.1675579808942; Sat, 04
 Feb 2023 22:50:08 -0800 (PST)
MIME-Version: 1.0
References: <pull.1443.git.git.1674914650588.gitgitgadget@gmail.com> <CAPig+cQPLMrUKp0aqLCknSYCs5TAso-VSBYsQbGZ8g8wgY2Liw@mail.gmail.com>
In-Reply-To: <CAPig+cQPLMrUKp0aqLCknSYCs5TAso-VSBYsQbGZ8g8wgY2Liw@mail.gmail.com>
From:   M Hickford <mirth.hickford@gmail.com>
Date:   Sun, 5 Feb 2023 06:49:29 +0000
Message-ID: <CAGJzqsnoTo=B3hiD7LtPRUG22TtkOOsZW2XMiptHa+6Ax9PEBg@mail.gmail.com>
Subject: Re: [PATCH] credential: new attribute password_expiry_utc
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, M Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Eric for the review

On Mon, 30 Jan 2023 at 00:59, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Sat, Jan 28, 2023 at 9:08 AM M Hickford via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > If password has expired, credential fill no longer returns early,
> > so later helpers can generate a fresh credential. This is backwards
> > compatible -- no change in behaviour with helpers that discard the
> > expiry attribute. The expiry logic is entirely in the git credential
> > layer; compatible helpers simply store and return the expiry
> > attribute verbatim.
> >
> > Store new attribute in cache.
> >
> > Signed-off-by: M Hickford <mirth.hickford@gmail.com>
>
> Just a few comments in addition to those already provided by Junio...
>
> > diff --git a/credential.c b/credential.c
> > @@ -234,11 +236,23 @@ int credential_read(struct credential *c, FILE *fp)
> > +               // if expiry date has passed, ignore password and expiry fields
> > +               if (c->password_expiry_utc != 0 && time(NULL) > c->password_expiry_utc) {
> > +                       trace_printf(_("Password has expired.\n"));
>
> Using `_(...)` marks a string for localization, but doing so is
> undesirable for debugging messages which are meant for the developer,
> not the end user (and it creates extra work for translators). No
> existing[1] trace_printf() calls in the codebase use `_(...)`.

Done in patch v3.

>
> [1]: Unfortunately, a couple examples exist in
> Documentation/MyFirstObjectWalk.txt using `_(...)` but they should be
> removed.
>
> > @@ -269,6 +283,13 @@ void credential_write(const struct credential *c, FILE *fp)
> > +       if (c->password_expiry_utc != 0) {
> > +               int length = snprintf( NULL, 0, "%ld", c->password_expiry_utc);
> > +               char* str = malloc( length + 1 );
>
> Style in this project is `char *str`, not `char* str`. Also, drop
> spaces around function arguments:
>
>     char *str = malloc(length + 1);
>
> > +               snprintf( str, length + 1, "%ld", c->password_expiry_utc );
>
> Same.
>
> > +               credential_write_item(fp, "password_expiry_utc", str, 0);
> > +               free(str);
> > +       }
>
> xstrfmt() from strbuf.h can help simplify this entire block:
>
>     char *s = xstrfmt("%ld", c->password_expiry_utc);
>     credential_write_item(fp, "password_expiry_utc", str, 0);
>     free(s);

Neat. Done in patch v3.
