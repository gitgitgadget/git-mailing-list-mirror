Return-Path: <SRS0=ylBF=6D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419F1C38A30
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 12:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12DCA21841
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 12:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aewl101/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgDSM3T (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Apr 2020 08:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgDSM3S (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Apr 2020 08:29:18 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E600C061A0C
        for <git@vger.kernel.org>; Sun, 19 Apr 2020 05:29:18 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id h200so1818380vke.3
        for <git@vger.kernel.org>; Sun, 19 Apr 2020 05:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w0yBMmYs5nE/H8HMltItuRthPWvwevOro3qQifK1njM=;
        b=Aewl101/vZkqDR2m+fzROtH1zTGyz6+4yuXr2hwDlP86ipBgBF/dvxVirm5NG+yX/F
         FSwrAzWN3xaUvA22kgwcq95bOxgtTszxhwlCBgCx4JzXY4n6n+r4KMWrDVoXxXbHv011
         InUae4g/sUtUO91yX1M2TX9r/X3bfF4aJ+bl8YtXgfzntWzpRdQ7hjM53gkY9WrTvNHj
         5iKUBcaTNTE9HU3tvcVea8U0nd45Ph8N/JRefqEJ5c/RxaMwHhrWD8KojUPgXR93jhqX
         U/b1j4uWwMGnyqb31dFUe8mD6zXsB6gX3wWkvawNp637ahI1vKjSELUF17+VZE+vRUbc
         Py0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w0yBMmYs5nE/H8HMltItuRthPWvwevOro3qQifK1njM=;
        b=WVHyr3NYfHIQGXyq7N1jUd/3sVYm/+5EUHc+aHysPUXixOYd/pjbpDGOt6XwLG0/Mo
         TR7sxuDIz2k8g6JHowIoB7Ce6YwVgWOHGhBy/+6lh9sqi/2Fj/AXHb89aDRpD1xTn6iq
         RM0EO8B6k5ysIDnGGWQnNhQP3f+Q9dPG9HWuAl1EWHR+QcFZtCKrfDvgX4/oXAfyLdEx
         xbYpbJ0SeD3mzbcFg7v/T8UGy9cC8T/yzcn8LNjlJeHRtwKgU1JZ5P+WpbvJU8qLmU0z
         d5lYFopefkN7CaQFb7wAcX+yo/cgB3oNlt4sJWIiIuEJIx6EqisUr8c1RwhWrOpk5cJs
         ugeA==
X-Gm-Message-State: AGi0PuZS772GmRyGWtDZEcjqw2F84eVhTWLWIg7h929l5YYeX+TpsiIv
        gYP5k2vpUpzsfhRgwSCKVgEo7AJoU2JUsSVA6WA=
X-Google-Smtp-Source: APiQypJD57hw5HGabBYCEHIf1/xY3C970E6nnnZqsOCL7Pyg7J0JqZmE4L6QlHol0lyzcQlPUhfZTVi/ob2pSgUb9lk=
X-Received: by 2002:a1f:a150:: with SMTP id k77mr8300887vke.88.1587299357657;
 Sun, 19 Apr 2020 05:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200418035449.9450-1-congdanhqx@gmail.com> <cover.1587289680.git.congdanhqx@gmail.com>
 <e3e542d38818b762f8d6d6b50bc42e01b070772b.1587289680.git.congdanhqx@gmail.com>
In-Reply-To: <e3e542d38818b762f8d6d6b50bc42e01b070772b.1587289680.git.congdanhqx@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 19 Apr 2020 14:29:06 +0200
Message-ID: <CAN0heSqi8KvbfSD80UA9s_aj9dGYTvbeW4GXVY59014_Sm-HmQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mailinfo.c::convert_to_utf8: reuse strlen info
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 19 Apr 2020 at 13:03, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <c=
ongdanhqx@gmail.com> wrote:
>
> We're passing buffer from strbuf to reencode_string,
> which will call strlen(3) on that buffer,
> and discard the length of newly created buffer.
> Then, we compute the length of the return buffer to attach to strbuf.
>
> During this process, we introduce a discrimination between mail
> originally written in utf-8 and other encoding.
>
> * if the email was written in utf-8, we leave it as is. If there is
>   a NUL character in that line, we complains loudly:
>
>         error: a NUL byte in commit log message not allowed.
>
> * if the email was written in other encoding, we truncate the data as
>   the NUL character in that line, then we used the truncated line for
>   the metadata.
>
> We can do better by reusing all the available information,
> and call the underlying lower level function that will be called
> indirectly by reencode_string. By doing this, we will also postpone
> the NUL character processing to the commit step, which will
> complains about the faulty metadata.
>
> Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gma=
il.com>

This makes sense to me.

I think the subject could be adapted though? Now it's not about "reusing
info" anymore, it's about using *other*, *better* info. Maybe

  mailinfo.c: avoid strlen on strings that might contain NUL

? Could probably be improved further..

> --- a/mailinfo.c
> +++ b/mailinfo.c
> @@ -447,19 +447,21 @@ static int convert_to_utf8(struct mailinfo *mi,
>                            struct strbuf *line, const char *charset)
>  {
>         char *out;
> +       size_t out_len;
>
>         if (!mi->metainfo_charset || !charset || !*charset)
>                 return 0;
>
>         if (same_encoding(mi->metainfo_charset, charset))
>                 return 0;
> -       out =3D reencode_string(line->buf, mi->metainfo_charset, charset)=
;
> +       out =3D reencode_string_len(line->buf, line->len,
> +                                 mi->metainfo_charset, charset, &out_len=
);
>         if (!out) {
>                 mi->input_error =3D -1;
>                 return error("cannot convert from %s to %s",
>                              charset, mi->metainfo_charset);
>         }
> -       strbuf_attach(line, out, strlen(out), strlen(out));
> +       strbuf_attach(line, out, out_len, out_len);
>         return 0;
>  }

Same diff as before, ok.

> +write_nul_patch() {
> +       space=3D' '
> +       qNUL=3D
> +       case "$1" in
> +               subject) qNUL=3D'=3D00' ;;
> +       esac

Here it's case/esac...

> +       cat <<-EOF
> +       From ec7364544f690c560304f5a5de9428ea3b978b26 Mon Sep 17 00:00:00=
 2001
> +       From: A U Thor <author@example.com>
> +       Date: Sun, 19 Apr 2020 13:42:07 +0700
> +       Subject: [PATCH] =3D?ISO-8859-1?q?=3DC4=3DCB${qNUL}=3DD1=3DCF=3DD=
6?=3D
> +       MIME-Version: 1.0
> +       Content-Type: text/plain; charset=3DISO-8859-1
> +       Content-Transfer-Encoding: 8bit
> +
> +       EOF
> +       if test "$1" =3D body
> +       then
> +               printf "%s\0%s\n" abc def
> +       fi

Here it's if/fi. Looks a bit inconsistent.

I suppose you tried to have a case for "body" above but couldn't get it
to work? Somehow, it would seem more consistent to have a qSubject and
qBody and handle them the same way, but maybe that's not possible?
Maybe using q_to_nul to create qBody containing a NUL?

> +       cat <<-\EOF
> +       ---
> +       diff --git a/afile b/afile
> +       new file mode 100644
> +       index 0000000000..e69de29bb2
> +       --$space
> +       2.26.1
> +       EOF
> +}

I think this helper function should use &&-chaining.

> +
>  test_expect_success setup '
>         # Note the missing "+++" line:
>         cat >bad-patch.diff <<-\EOF &&
> @@ -32,4 +62,18 @@ test_expect_success 'try to apply corrupted patch' '
>         test_i18ncmp expected actual
>  '
>
> +test_expect_success "NUL in commit message's body" '
> +       test_when_finished "git am --abort" &&
> +       write_nul_patch body >body.patch &&
> +       test_must_fail git am body.patch 2>err &&
> +       grep "a NUL byte in commit log message not allowed" err
> +'

Makes sense.

> +
> +test_expect_failure "NUL in commit message's header" '
> +       test_when_finished "git am --abort" &&
> +       write_nul_patch subject >subject.patch &&
> +       test_must_fail git am subject.patch 2>err &&
> +       grep "a NUL byte in Subject is not allowed" err
> +'

Interesting. :-)


Martin
