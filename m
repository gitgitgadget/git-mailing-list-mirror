Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C5EC388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 11:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08EAC20756
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 11:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1HcPrm4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgKKLEE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 06:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgKKLED (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 06:04:03 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B999C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 03:04:03 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id i193so1567213yba.1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 03:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sAP9J2qw4PeQKBqbXNiG8pArIMX16RasXMkFFJHGrG8=;
        b=U1HcPrm4/0RPOwjcM8sI/C5ANCiQ8Vgv/Ymb20lBEkeFUp2UBUyGOXAaJ0S2gKf1OE
         b4NfYQ0W0EUqW/aN2D2ATabraTO7toU7p3ptErDaTjUS900KjBq59YyOzKa2wU/EIiPm
         x7pd2FHNNqrsuWP6hU1Y100Je3Y1BBffDl0SXzBFvNNnHuT49e6/k0+4UQvG280mzwie
         RV4I4d6c6x+jQjhDP3izierp++clgYVT7X4wPVS7E4x+GekY/y3iHeFk97krcmCBxSnn
         EOzs3+8AolRpK/dYS5MPDa78fR5B8LwhRGr5Lti1YxuIhuvd7yToDO+IzohrhMQf0H/r
         tkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sAP9J2qw4PeQKBqbXNiG8pArIMX16RasXMkFFJHGrG8=;
        b=oxlMeREduXDsCmL1nW2m3N1g3a+Rji1tILehPRxtN6gZhfgFCBTdBgc5J7z2dtDuAR
         OtRTJHpTnjafuEFnYvOJwxKnGA//m1PTBCVMnQ4YpEO8pnFKHa8dbOY2VjRU17vrEfIx
         qdEkgQ4El6OheveemUDdd8Pm7EnD+hlQMa+9QIw6zEBni56a+pkQaFV7E/ysgu00K9FE
         JSszLy3N04TdaFJR4EqmyJ9ZM7oEFDGZ8losTwG9wtL8mIL7GiqT3jXadDEWVITjOuzL
         MwSZCEei4R7nOK5J2Ehj8MjAcaHHEOTZrs66UbabvQhXVhtaYJ+vNPQXTNF4MIzg7r/O
         +15w==
X-Gm-Message-State: AOAM531Y04yfXCUouZg+B/iaKEe1zKvx6hvT3U0iAFlg7YiVoJVte73P
        ZfwDXm4mjgadpWRD0sRFYfZunGgGtK2eie/vaxd7hdGmejaC3A==
X-Google-Smtp-Source: ABdhPJx3sRJz2wdrUSAAmVm4X1X6h9XGnGiYx4ruDkyWbkJVZdIZjU/0NOg/3q6XQPMNJmGcm5EygRy5oHcwnNk3JeI=
X-Received: by 2002:a25:b5ce:: with SMTP id d14mr19333894ybg.520.1605092642832;
 Wed, 11 Nov 2020 03:04:02 -0800 (PST)
MIME-Version: 1.0
References: <CANYiYbH-x6khgTkkFV29+7AjghOZmG69_6-sQcm2489WMHOWAA@mail.gmail.com>
 <20201110120135.42025-2-zhiyou.jx@alibaba-inc.com> <20201110215250.GB3263091@coredump.intra.peff.net>
In-Reply-To: <20201110215250.GB3263091@coredump.intra.peff.net>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Wed, 11 Nov 2020 19:03:51 +0800
Message-ID: <CANYiYbEd1bDtwsq44Xqsc1o3=a6XO7aX5b_ZQ9gh7-xOS5O5rg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] receive-pack: gently write messages to proc-receive
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> =E4=BA=8E2020=E5=B9=B411=E6=9C=8811=E6=97=A5=E5=
=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=885:52=E5=86=99=E9=81=93=EF=BC=9A
> > diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> > index bb9909c52e..697a4e8802 100644
> > --- a/builtin/receive-pack.c
> > +++ b/builtin/receive-pack.c
> > @@ -974,9 +974,10 @@ static int read_proc_receive_report(struct packet_=
reader *reader,
> >       struct command *cmd;
> >       struct command *hint =3D NULL;
> >       struct ref_push_report *report =3D NULL;
> > -     int new_report =3D 0;
> >       int code =3D 0;
> > +     int new_report =3D 0;
>
> This is just noise in the diff, I think. It does not matter either way.
>
> > @@ -984,8 +985,14 @@ static int read_proc_receive_report(struct packet_=
reader *reader,
> >               const char *refname;
> >               char *p;
> >
> > -             if (packet_reader_read(reader) !=3D PACKET_READ_NORMAL)
> > +             if (packet_reader_read(reader) !=3D PACKET_READ_NORMAL) {
> > +                     if (!response) {
> > +                             strbuf_addstr(errmsg, "no response from p=
roc-receive hook");
> > +                             return -1;
> > +                     }
> >                       break;
> > +             }
> > +             response++;
>
> This extra check seems orthogonal to the rest of the commit. It does
> seem like it might be a reasonable thing to check, but I wondered:
>
>   - if the hook has nothing to report, wouldn't it just send a flush
>     packet? Does that break protocol or not?

It's OK to send a flush packet without any payload, so will check
status PACKET_READ_EOF for broken proc-receive.

-- snip --
@@ -977,15 +977,25 @@ static int read_proc_receive_report(struct
packet_reader *reader,
        for (;;) {
                struct object_id old_oid, new_oid;
                const char *head;
                const char *refname;
                char *p;
-
-               if (packet_reader_read(reader) !=3D PACKET_READ_NORMAL)
+               enum packet_read_status status;
+
+               status =3D packet_reader_read(reader);
+               if (status !=3D PACKET_READ_NORMAL) {
+                       /* Check whether proc-receive exited abnormally */
+                       if (status =3D=3D PACKET_READ_EOF && !response) {
+                               strbuf_addstr(errmsg, "proc-receive
exited abnormally");
+                               return -1;
+                       }
                        break;
+               }
+               response++;
-- snap --

>
> > @@ -1100,7 +1107,7 @@ static int run_proc_receive_hook(struct command *=
commands,
> >       struct strbuf cap =3D STRBUF_INIT;
> >       struct strbuf errmsg =3D STRBUF_INIT;
> >       int hook_use_push_options =3D 0;
> > -     int version =3D 0;
> > +     int version =3D -1;
> > [...]
> > -     if (version !=3D 1) {
> > +     if (version =3D=3D -1) {
> > +             strbuf_addstr(&errmsg, "fail to negotiate version with pr=
oc-receive hook");
> > +             code =3D -1;
> > +             goto cleanup;
> > +     } else if (version !=3D 1) {
> >               strbuf_addf(&errmsg, "proc-receive version '%d' is not su=
pported",
> >                           version);
>
> Likewise this seems orthogonal to the main point of the patch. Though it
> seems like a good idea in general to check when the other side doesn't
> report a version (assuming it is a protocol breakage not to report the
> version, and we're not simply supposed to default).

Will add a new patch for default version for proc-receive.
