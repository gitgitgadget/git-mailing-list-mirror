Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68332C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 02:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BB55206FB
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 02:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHzkYV69"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbgKDCL0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 21:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgKDCLZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 21:11:25 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD186C061A4D
        for <git@vger.kernel.org>; Tue,  3 Nov 2020 18:11:25 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id u7so10615691vsq.11
        for <git@vger.kernel.org>; Tue, 03 Nov 2020 18:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5x3j1Lc41xzTfEyNQCYGEOf8Xzk3JHBhWS/SchJ8/98=;
        b=LHzkYV69AnRxi/ODCY8G8kTNRkF6w1v0DgfKdxqPMTvDJ8byCFX9+JBya6JKmRW0rR
         IG9OOgMEdu3zYmZFfurMFxrdNHYx1ItOBQJT7L9MrnfNCEpc6N3moZTvp7195XQMjyOv
         Vt6BG3E/9mCDJgni/xYqDj9hho0gBfl/WBTpL+x55Tpe7k8hdOykmDKJbWg0/TdEYiwo
         PXqA2Ms/+wR/yjqUs2tyQPvLnPPUOMKbH7QFAyXiG6npDeClmNLKs9Vw8MHrNaqR8n7D
         3OB7lL4vPyEsZ+fjVFyFrljqRf9vI7t8YDvAPFGnivGzyGw5kA5m+ptzSzDznvkQn+W8
         1q+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5x3j1Lc41xzTfEyNQCYGEOf8Xzk3JHBhWS/SchJ8/98=;
        b=Zqu9S2XlgMQepED/c1gmmVyC7Zeyq76pVIFd9e3PHul5KP4WUwW4Pm+O0LEjSqZIyT
         aUax+HkVi+u+9v6B0HhiL9OLHkG56H9xHmjgrCeeeAwqQuIS4FKUOIJ+/J/3TLQ4O5Wk
         MZfOsHORo4QfFzhLNrNETMWQ0TjBzpEj8XuXXT0bv+qtS8A7coe8Q45KvEW69JjeaxWE
         exCHy3Eln321B+w0H6UNx5z/AEmCKs9VSwUCtZJ+Ph7pmpJA90NkM4y8984HfnbFzBgO
         jatMv9ERUoX1oLDdr2ptQ23mFb/dkBQZDPib0xzvY7Vk+/xad+LGg1GdPesnsmN63Jjv
         KBJA==
X-Gm-Message-State: AOAM533W/NyenKTb78tRDLg7R6lFRwpTwlDQOx1EPQd+lBLAtJ1RJnJL
        4MvRKnmL09QGzvR3FejHMOETW7BEYhYcnO0p8Llf7JZk6cc=
X-Google-Smtp-Source: ABdhPJzof9j7I1tHUBXcgj0mFBzwXLPvJ9dDCjfFNf/YwFyKeRRAYOs4PAM+Oin9kxmXMNiURtUoTj3NjDYZr7Ew/t0=
X-Received: by 2002:a67:5f05:: with SMTP id t5mr11088243vsb.21.1604455884240;
 Tue, 03 Nov 2020 18:11:24 -0800 (PST)
MIME-Version: 1.0
References: <CAF7CYk51BC0KcsBb0KjKWAj17AMU2c9Y6Y81ddwX6oOAFYhT8w@mail.gmail.com>
 <xmqqk0v1q60l.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqk0v1q60l.fsf@gitster.c.googlers.com>
From:   =?UTF-8?B?TcOhcmlvIEd1aW1hcsOjZXM=?= 
        <mario.luis.guimaraes@gmail.com>
Date:   Wed, 4 Nov 2020 02:11:13 +0000
Message-ID: <CAF7CYk6SVx396=fLZ2yMVTaS2XK58M_=kT7J+th_T8VqM+HmaQ@mail.gmail.com>
Subject: Re: Bug with --abbrev option in git log?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello

Junio C Hamano <gitster@pobox.com> escreveu no dia quarta, 4/11/2020 =C3=A0=
(s) 01:12:
>
> M=C3=A1rio Guimar=C3=A3es  <mario.luis.guimaraes@gmail.com> writes:
>
> > In the Git repository run this command:
> >
> > git log --raw -r -c --abbrev=3D6 --pretty=3Doneline -n1
> > a7144d4bc5ab58f306a1e5c73b27196fb999a63d
>
> This is not one of my object, so above won't be usable as
> reproduction recipe.  But that is OK.
>
> > What did you expect to happen? (Expected behavior)
> >
> > I was expecting to get this line in the output
> >
> > ::100644 100644 100644 639a41 111378 05ba1d MM Documentation/git-rebase=
.txt
> >
> > What happened instead? (Actual behavior)
> >
> > I got the following line instead
> >
> > ::100644 100644 100644 639a41 111378 05ba1d3 MM Documentation/git-rebas=
e.txt
>
> The above command tells us that you locally have an object whose
> name begins with 05ba1d3, which I do not have.  But my history
> shared with the entire world has an object whose name begins with
> 05ba1d7, and I am reasonably sure that your repository has it, since
> it is a part of 17f26a9e (git-am: fix shell quoting, 2009-01-14).
>
> So in my repository, 05ba1d is enough to uniquely identify 05ba1d7,
> but in your repository 05ba1d is not enough to uniquely identify
> 05ba1d3, because 05ba1d7 also exists in your repository.  And when
> the object cannot be uniquely specified with the given abbreviation
> width, Git makes sure its output is usable to uniquely identify the
> object it wants to name.
>
> In short, I think what you observed is totally expected.
>
> The documentation has some room for improvement, I also think.
>
> How about saying something like this?
>
>
>
>  Documentation/diff-options.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git i/Documentation/diff-options.txt w/Documentation/diff-options.=
txt
> index ee52b65e46..114e440c5b 100644
> --- i/Documentation/diff-options.txt
> +++ w/Documentation/diff-options.txt
> @@ -446,7 +446,8 @@ endif::git-format-patch[]
>  --abbrev[=3D<n>]::
>         Instead of showing the full 40-byte hexadecimal object
>         name in diff-raw format output and diff-tree header
> -       lines, show only a partial prefix.
> +       lines, show only a partial prefix that uses at least '<n>'
> +       hexdigits.
>         In diff-patch output format, `--full-index` takes higher
>         precedence, i.e. if `--full-index` is specified, full blob
>         names will be shown regardless of `--abbrev`.

What about this? It makes clear that the prefix is still one that can
be used to identify the object in the repository.

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.tx=
t
index ee52b65e46..c15b4adb28 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -446,8 +446,9 @@ endif::git-format-patch[]
 --abbrev[=3D<n>]::
        Instead of showing the full 40-byte hexadecimal object
        name in diff-raw format output and diff-tree header
-       lines, show only a partial prefix.
-       In diff-patch output format, `--full-index` takes higher
+       lines, show only the minimal prefix that identifies
+       the object using at least `<n>` hexdigits.
        In diff-patch output format, `--full-index` takes higher
        precedence, i.e. if `--full-index` is specified, full blob
        names will be shown regardless of `--abbrev`.
        Non default number of digits can be specified with `--abbrev=3D<n>`=
.
