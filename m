Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7EBC54E94
	for <git@archiver.kernel.org>; Wed, 25 Jan 2023 12:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbjAYMrP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Jan 2023 07:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235099AbjAYMrN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2023 07:47:13 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061B915563
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 04:47:13 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-4fda31c3351so232671587b3.11
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 04:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbT906czgsplFbw7HKehjB8bfdPoHAOtpYZKURA5vF8=;
        b=oL4qm4fmIifYLqU5rJUzpUnepD2ck9kNyScIY4itkUjV/8YsrFb8LyuGDUNbidr+ud
         oHDrtFztFNNF0HF9ba1DEllzAwSUobR1ZDV+eoG0651XSK+diEC64EITE8cGJ/eDxore
         Yf/FNMHed5TyDofxNfKKmpYWMT5URnoD2ePAztS9js+EywbfqK4fRD3WJkpyISlhmmNC
         1VidIGZFFo0n1ssqAfKEL9HGChpf0b3QqDlXgi2pc7kIhiMwGMhoT6dPDpnGEHwODSG1
         qQqO2MlJWghMf3DPpaNtiswOKJHO7a+aY368XAm2Wqcr/lNvUpT4TjcJ2UxRlfx9N5Kh
         JFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GbT906czgsplFbw7HKehjB8bfdPoHAOtpYZKURA5vF8=;
        b=Jc5jgBsGWmyQN9lQLg1yf5f2aW5jDcWrWTzY8eWWtkU92jtuB5auDlc/f/MJYcGzY4
         HsUuwsbCa2X2aJniNndI6Kigu6IP5TEVrHGF5cYhLsVRXGMqHyeyLLnhPdleKSvM0O1Y
         8nanYts1hWpBDTkJoNhhX9t0RjcdT9qlKI4RNeFPCpTM1u4DK5gw5SjqwD4FkFpr/sjC
         HIAaDGB3RaIiu/HVCTmPNyTSQUJszrXtIjY88F0GIPlhOJgII0s9P+5W00MY6r6ZKkGW
         v6jCoNj3ohTfnnT0rn3+/uavZRGHa3CV36aTNjz6r4+OimcoymKOC0dhjuQyItVw0dwo
         e3WQ==
X-Gm-Message-State: AFqh2kq7FVNuE3C4VksCc/TJQUVa1nWN3T9fiqyBDBiSDFxcpXQ06dVz
        qUKQTY/JEG8LgqWQ0emg0eytAaqrqt4AbFSjttY=
X-Google-Smtp-Source: AMrXdXux6JNKj9M3Y7W7UttrhgK7UI/PUECj6/F8nQBRew7fxs3M50hJYW6i0za5WDNCiFMcE7n0Co5YUWpaBwyA7Vg=
X-Received: by 2002:a0d:cb44:0:b0:500:d985:6c45 with SMTP id
 n65-20020a0dcb44000000b00500d9856c45mr1824209ywd.175.1674650832115; Wed, 25
 Jan 2023 04:47:12 -0800 (PST)
MIME-Version: 1.0
References: <pull.1270.git.git.1674029874363.gitgitgadget@gmail.com>
 <pull.1270.v2.git.git.1674573972087.gitgitgadget@gmail.com> <xmqq1qnjhlbf.fsf@gitster.g>
In-Reply-To: <xmqq1qnjhlbf.fsf@gitster.g>
From:   Adam Szkoda <adaszko@gmail.com>
Date:   Wed, 25 Jan 2023 13:46:36 +0100
Message-ID: <CAEroKagUY5PfuC2CDn=pTJ=brPsjPy6MVz54mH1tvN8E-Pvk7g@mail.gmail.com>
Subject: Re: [PATCH v2] ssh signing: better error message when key not in agent
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Adam Szkoda via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 24, 2023 at 6:52 PM Junio C Hamano <gitster@pobox.com> wrote:
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1270=
/radicle-dev/maint-v2
> > Pull-Request: https://github.com/git/git/pull/1270
> >
> > Range-diff vs v1:
> >
> >  1:  0ce06076242 < -:  ----------- ssh signing: better error message wh=
en key not in agent
> >  -:  ----------- > 1:  03dfca79387 ssh signing: better error message wh=
en key not in agent
>
> This is a fairly useless range-diff.
>
> Even when a range-diff shows the differences in the patches,
> mechanically generated range-diff can only show _what_ changed.  It
> is helpful to explain the changes in your own words to highlight
> _why_ such changes are done, and this place after the "---" line
> and the diffstat we see below is the place to do so.
>
> Does GitGitGadget allow its users to describe the differences since
> the previous iteration yourself?

No, I don't think it does.   It got generated automatically without
giving me an opportunity to edit.

> >  gpg-interface.c | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/gpg-interface.c b/gpg-interface.c
> > index f877a1ea564..33899a450eb 100644
> > --- a/gpg-interface.c
> > +++ b/gpg-interface.c
> > @@ -998,6 +998,7 @@ static int sign_buffer_ssh(struct strbuf *buffer, s=
truct strbuf *signature,
> >       char *ssh_signing_key_file =3D NULL;
> >       struct strbuf ssh_signature_filename =3D STRBUF_INIT;
> >       const char *literal_key =3D NULL;
> > +     int literal_ssh_key =3D 0;
> >
> >       if (!signing_key || signing_key[0] =3D=3D '\0')
> >               return error(
> > @@ -1005,6 +1006,7 @@ static int sign_buffer_ssh(struct strbuf *buffer,=
 struct strbuf *signature,
> >
> >       if (is_literal_ssh_key(signing_key, &literal_key)) {
> >               /* A literal ssh key */
> > +             literal_ssh_key =3D 1;
> >               key_file =3D mks_tempfile_t(".git_signing_key_tmpXXXXXX")=
;
> >               if (!key_file)
> >                       return error_errno(
> > @@ -1036,11 +1038,14 @@ static int sign_buffer_ssh(struct strbuf *buffe=
r, struct strbuf *signature,
> >       }
> >
> >       strvec_pushl(&signer.args, use_format->program,
> > -                  "-Y", "sign",
> > -                  "-n", "git",
> > -                  "-f", ssh_signing_key_file,
> > -                  buffer_file->filename.buf,
> > -                  NULL);
> > +                     "-Y", "sign",
> > +                     "-n", "git",
> > +                     "-f", ssh_signing_key_file,
> > +                     NULL);
>
> Please avoid making a pointless indentation change like this.

Yep, removed.  It was largely accidental.

> We do
> not pass filename yet with this pushl(), because ...
>
> > +     if (literal_ssh_key) {
> > +             strvec_push(&signer.args, "-U");
> > +     }
>
> ... when we give a literal key, we want to insert "-U" in front, and then
>
> > +     strvec_push(&signer.args, buffer_file->filename.buf);
>
> ... the filename.  Which makes sense.

I'm not sure what you mean in this paragraph.   If there's something
more that needs to be done, I'd appreciate it if you could rephrase
it.

> The insertion of "-U" is a single statement as the body of a if()
> statement.  We do not want {} around it, by the way.

Removed the superfluous {}.

Thanks

=E2=80=94 Adam
