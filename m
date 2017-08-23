Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59F2220899
	for <e@80x24.org>; Wed, 23 Aug 2017 20:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754170AbdHWUhR (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 16:37:17 -0400
Received: from mail-yw0-f178.google.com ([209.85.161.178]:33650 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932674AbdHWUhO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 16:37:14 -0400
Received: by mail-yw0-f178.google.com with SMTP id h127so7683811ywf.0
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 13:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IF5/OH9ynkHsGLyx97m3OHwlNqn0qmj3f/kpEyUh7aU=;
        b=GTVOktyUQ9n1bQkKyryrsfzIkrtyyYHfUVeviE3SiQseNNyF6yS854z+95QAQJzeoh
         bbfqqqdc22EZpH3wajfskEADZPkditCrlhrfBKxJ4LRYElukNoI8Ojv1P41y/GChfsnS
         0AUn38p5UX8DHg4syfyzvF2uDZ3qwMznJaAk3VfC9FIV2z2DUTzdeyE3zzrChj8BLsLO
         JfN0dLbdxv25gVfF9q0K8LZBiRIvQkpm28zXpbWXEWezC2JsHrrEwwD2YCR8mUOaPZB6
         u9OyTd02h856hx5bx+lQM/yW+3KFv3rhv+D2ZvdxP22YlPVf+2qKULzchBlRtKcHSvNq
         WP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IF5/OH9ynkHsGLyx97m3OHwlNqn0qmj3f/kpEyUh7aU=;
        b=X5TYYULo6TKcdG6ynoqv2ZrI/D1CINOLBdtcH82NPk1rs9wNyDxVZB2J1MzbfGRjwY
         YieWphmJYu8KWnJ8lz7FOPyyv3T+tii4YjxHOd/x9WmDaGWsE/5/WDukMjhdVec+EItR
         wA03+Y+3uZ5hYfcm7gkmbDa6ysT7hL0xI5ZXvMflcuzOcq0c49cOt4MC9Sr3K/wMfLzD
         FIDxRo0KJqdOdoTWexEQgkUP//fUjcIPa2zYHAHgUcOKojvqX46vXiNr51EUg8RXw5I1
         hcSkHcF+mmNVqMV5zilmOYcMRgr4T6FtBIHIKChEeFr51VIZWC+a1+ennsEQ65kT6a6h
         +FjQ==
X-Gm-Message-State: AHYfb5iPESbSujDLiS1py71uH/X7RQcpARJUPYfl7F6TPM5hCdfRKg9H
        JorM1JIJfONUzdD2E/85ouXJIjRQrnhlsmY=
X-Received: by 10.13.233.198 with SMTP id s189mr3126802ywe.32.1503520633429;
 Wed, 23 Aug 2017 13:37:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.153.133 with HTTP; Wed, 23 Aug 2017 13:37:12 -0700 (PDT)
In-Reply-To: <dccd3e75fcd1b2de93263e8373a3b4cd5da0dd32.1503323391.git.martin.agren@gmail.com>
References: <cover.1502780343.git.martin.agren@gmail.com> <cover.1503323390.git.martin.agren@gmail.com>
 <dccd3e75fcd1b2de93263e8373a3b4cd5da0dd32.1503323391.git.martin.agren@gmail.com>
From:   Brandon Casey <drafnel@gmail.com>
Date:   Wed, 23 Aug 2017 13:37:12 -0700
Message-ID: <CA+sFfMdXv+nqpXmwfLTHtkRLuGkAEAwWXZCvOryVZ=aLb_UmbA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] strbuf_setlen: don't write to strbuf_slopbuf
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 21, 2017 at 10:43 AM, Martin =C3=85gren <martin.agren@gmail.com=
> wrote:
> strbuf_setlen(., 0) writes '\0' to sb.buf[0], where buf is either
> allocated and unique to sb, or the global slopbuf. The slopbuf is meant
> to provide a guarantee that buf is not NULL and that a freshly
> initialized buffer contains the empty string, but it is not supposed to
> be written to. That strbuf_setlen writes to slopbuf has at least two
> implications:
<snip very well written commit message>

> diff --git a/strbuf.h b/strbuf.h
> index e705b94db..7496cb8ec 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -147,7 +147,10 @@ static inline void strbuf_setlen(struct strbuf *sb, =
size_t len)
>         if (len > (sb->alloc ? sb->alloc - 1 : 0))
>                 die("BUG: strbuf_setlen() beyond buffer");
>         sb->len =3D len;
> -       sb->buf[len] =3D '\0';
> +       if (sb->buf !=3D strbuf_slopbuf)
> +               sb->buf[len] =3D '\0';
> +       else
> +               assert(!strbuf_slopbuf[0]);
>  }
>
>  /**
> --
> 2.14.1.151.gdfeca7a7e
>

I know this must have been discussed before and/or I'm having a neuron
misfire, but is there any reason why we didn't just make slopbuf a
macro for ""?

i.e.

   #define strbuf_slopbuf ""

That way it should point to readonly memory and any attempt to assign
to it should produce a crash.

One benefit that I can think of for making strbuf_slopbuf be a real
variable is that we can then compare the pointer stored in the strbuf
to the strbuf_slopbuf address to detect whether the strbuf held the
slopbuf.  With the static string macro, each execution unit may get
it's own instance of the empty string.  But, before this patch, we
don't actually seem to be doing that anywhere and instead rely on the
value of alloc being accurate to determine whether the strbuf contains
the slopbuf or not.

So is there any reason why didn't do something like the following in
the first place?

diff --git a/strbuf.h b/strbuf.h
index e705b94..fcca618 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -67,7 +67,7 @@ struct strbuf {
        char *buf;
 };

-extern char strbuf_slopbuf[];
+#define strbuf_slopbuf ""
 #define STRBUF_INIT  { .alloc =3D 0, .len =3D 0, .buf =3D strbuf_slopbuf }

 /**
@@ -147,7 +147,9 @@ static inline void strbuf_setlen(struct strbuf
*sb, size_t len)
        if (len > (sb->alloc ? sb->alloc - 1 : 0))
                die("BUG: strbuf_setlen() beyond buffer");
        sb->len =3D len;
-       sb->buf[len] =3D '\0';
+       if (sb->alloc) {
+               sb->buf[len] =3D '\0';
+       }
 }

-Brandon
