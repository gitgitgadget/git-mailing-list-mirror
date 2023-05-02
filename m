Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7BCC77B7E
	for <git@archiver.kernel.org>; Tue,  2 May 2023 06:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbjEBGAC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 02:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEBGAB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 02:00:01 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EB4273F
        for <git@vger.kernel.org>; Mon,  1 May 2023 22:59:59 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-54c905139deso680427eaf.2
        for <git@vger.kernel.org>; Mon, 01 May 2023 22:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683007199; x=1685599199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JF7JgW+0igxfBJvS/9ndjnC9ebM05xjIH+rsFjadTKA=;
        b=gF1EBa+AXHUpUnxx2eCvFWth3+gZ1qaeOOrlETYbFJg7IXIgxVdRrrtS0d7B9STF5Q
         jOD8o2SnDcP2XtSY6Rr7JYqlDkzvq8IuXdaG0o0sH+fJphh7499vZCo+CKtJxS4qvo+0
         hpxHi3Fia37k+HJaTytPDkbVXbHB904DiTE9aGcrPFH+jtJ6W5QCOSnF69KrQJCiqzsV
         yChhUSkGc6s80PShIQBA8HRBmLQtDdz/tSTsHtLSq8HUOdMZW+m146+NM4RHGIPRjILj
         EcxHLlgI3TqLLeAuTedpCVDr75h1/F96z2ufDtFe/KZItceX1RwkRUOzMAxNxZUwjniA
         2Kjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683007199; x=1685599199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JF7JgW+0igxfBJvS/9ndjnC9ebM05xjIH+rsFjadTKA=;
        b=ZwJrpcRreZW18CD4Gs2Qwd7usB7lZJVvZndFvkIDom/rxVjlsqeU0Shn7Y9Ab8NVd5
         Sp5lJQDTq2EUQAieAiUVGRkhO9PAUZnq+QyYkBQ6m+tPbqxCtzqmzUE1tFolzG7+/ic9
         m96yoy2g+Aau06B9hKfCcKjmWwUJ0K1d++iV8Wc30Ym2wPmOmNpryaf1GqmqlO1VXBnX
         /5LG+Qm8cYyuj3PAIRD757TWHCD8b2u6yZTPKCBRfYiy4t9dFlv06UGoUNYN52TL2p5Y
         J6CWEvhSOtVdqZVgwTrOgJDldyQdRgm47eYq9PUS2qiqck5eCDO61WHoJrLvZCk4hN6b
         1wIw==
X-Gm-Message-State: AC+VfDw1drrimUkSULgeuSMlNkXDKm6pkN6XArKMTEndvu9tH821t1H6
        B2c3XeqSsiBmPnmqOAERuuPyHV1+y82ebiJhBis=
X-Google-Smtp-Source: ACHHUZ5JpZBAsUTu8euoQXtZh8bAsV0krdd83NJCSdMIxQDbQPkY3ujkqHIw3Etreo0Z6dqdCcp7fSw+F9DJVyrch78=
X-Received: by 2002:a4a:d0a5:0:b0:545:bd13:18cc with SMTP id
 t5-20020a4ad0a5000000b00545bd1318ccmr7282704oor.8.1683007198718; Mon, 01 May
 2023 22:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230501023533.35370-1-alexhenrie24@gmail.com>
 <20230501023533.35370-2-alexhenrie24@gmail.com> <20230502041725.7zbv3i4srdb7fqrg@tb-raspi4>
In-Reply-To: <20230502041725.7zbv3i4srdb7fqrg@tb-raspi4>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Mon, 1 May 2023 23:59:22 -0600
Message-ID: <CAMMLpeTNn_q_+pkOqjgPJBsB=s8EOTbngMJD7NXVo=rC8JWgwg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] docs: rewrite the documentation of the text and
 eol attributes
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org, eyvind.bernhardsen@gmail.com,
        gitster@pobox.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 1, 2023 at 10:17=E2=80=AFPM Torsten B=C3=B6gershausen <tboegi@w=
eb.de> wrote:
>
> This looks much better, thanks.
> I have some minor comments:
> a) The commit message from above:
> >  docs: rewrite the documentation of the text and eol attributes
>
> The word "doc" is used 2 times, that feel a little bit redundant
> (and should start with a uppercase letter)
>
> "Docs: rewrite the documentation of the text and eol attributes"
>
> Or may be shorter:
> "Rewrite the documentation of the text and eol attributes"

The commit message is modeled after 8c591dbfce, which is incidentally
the commit that introduced the confusing wording discussed below.
Unless there is a convention on how to write commit messages like
this, I would rather follow the existing precedent.

> On Sun, Apr 30, 2023 at 08:35:33PM -0600, Alex Henrie wrote:
> > These two sentences are confusing because the description of the text
> > attribute sounds exactly the same as the description of the text=3Dauto
> > attribute:
>
> The word "These" is somewhat dangling: Which ones ?
> May be "The following two sentences" ?

The colon indicates that the sentence refers to the following sentences.

> > -This attribute enables and controls end-of-line normalization.  When a
> > -text file is normalized, its line endings are converted to LF in the
> > -repository.  To control what line ending style is used in the working
> > -directory, use the `eol` attribute for a single file and the
> > -`core.eol` configuration variable for all text files.
> > -Note that setting `core.autocrlf` to `true` or `input` overrides
> > -`core.eol` (see the definitions of those options in
> > -linkgit:git-config[1]).
> > +This attribute marks the path as a text file, which enables end-of-lin=
e
> > +conversion: When a matching file is added to the index, the file's lin=
e
> > +endings are normalized to LF in the index.  Conversely, when the file =
is
> > +copied from the index to the working directory, its line endings may b=
e
> I still stumble accross "copied". May be shorter:
>
> "the file is written into the working directory"

Maybe, but then it almost sounds like Git watches the directory for
changes and transforms files as soon as the user creates them.
Conversion only happens when writing files _from the index_. Moreover,
the word "copy" does not always mean a byte-for-byte copy, and clearly
does not mean that here.

> > -This attribute sets a specific line-ending style to be used in the
> > -working directory.  This attribute has effect only if the `text`
> > -attribute is set or unspecified, or if it is set to `auto`, the file i=
s
> > -detected as text, and it is stored with LF endings in the index.  Note
> > -that setting this attribute on paths which are in the index with CRLF
> > -line endings may make the paths to be considered dirty unless
> > -`text=3Dauto` is set. Adding the path to the index again will normaliz=
e
> > -the line endings in the index.
> > +This attribute marks a path to use a specific line-ending style in the
> > +working tree when it is checked out.
> It enables even the normalization at checkin, see
> $ mkdir ttt
> $ cd ttt
> $ git init
> $ echo "*.sh eol=3Dlf" >.gitattributes
> $ printf '#!/bin/sh\r\necho hello\r\n' >xx.sh
> $ git add xx.sh
> warning: CRLF will be replaced by LF in xx.sh.
> The file will have its original line endings in your working directory

This has got to be the most confusing Git feature ever. Clearly I did
not understand how it works.

> > + This attribute has effect only if
> > +the `text` attribute is set or unspecified, or if it is set to `auto`,
> > +the file is detected as text, and it is stored with LF endings in the
> > +index.
> It took me a while to understand it.
> Should the "," after "unspecified" be removed ?
>
> Or, should we write:
>
> The `eol` attribute automatically sets `text`, unless `-text`, `binary` o=
r
> `text=3Dauto` is specified.

Your proposed wording makes the relationship between `text` and `eol`
far more clear, and it avoids the need to repeat the detailed
explanation of how normalization on checkin works. However, I think we
still need to say in the introduction that `eol` does not work without
`text`. How about this:

It has effect only if `text` or `text=3Dauto` is set (see above), but
specifying `eol` automatically sets `text` if `text` was left
unspecified.

I've CCed the author of the original sentence on this email in case he
wants to give any feedback on the rewrite.

> > +Unspecified::
> > +
> > +     If the `eol` attribute is unspecified for a file, its line ending=
s
> > +     in the working directory are determined by the `core.autocrlf` or
> > +     `core.eol` configuration variable (see the definitions of those
> > +     options in linkgit:git-config[1]).  The default if `text` is set =
but
> > +     neither of those variables is is `eol=3Dlf` on Unix and `eol=3Dcr=
lf` on
> > +     Windows.
>
> That's good - I wonder if everyone understands Linux, MacOs and others as=
 Unix.
>
> May be something like this:
> The default, if `text` is set but neither of those variables, is `eol=3Dc=
rlf` on
> Windows and `eol=3Dlf` on all other systems.

That's fine, we can say "all other platforms" instead of "Unix" here.
It would only become a problem if someone ports Git to DOS, which
seems unlikely.

Thanks for the insight and help,

-Alex
