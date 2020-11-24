Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACF9C2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 03:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F5E820866
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 03:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nkr5f8zI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbgKXDVW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 22:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728846AbgKXDVW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 22:21:22 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC518C0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 19:21:21 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id u18so26784172lfd.9
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 19:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T11pM30Zo2OtDA1oQ1Lu3ZWmFFIu+bqjF96YLuSv8Ms=;
        b=Nkr5f8zI9xAI6yibQdWVTPcQq2dB1Y8/at8xV3GKA2sDZzrrWbwjBxELFPdOk8kA5k
         J97VajlvY12aAkmDbclz4t2oMtQ6xO/ZINajI2sveVUMnUVTq+dvRdUWFTYLVJktDkv1
         vppOoAb4rEQPbFWUdf9x122bHhoGlbe+ztbDOAL4Wvt/BAUoOKo8bOaQtC1KXHXGAgEL
         P+hBuzLhnHp+E9FevSuGzoMLyYgqTGBG/zmxbO6hn3gYnxKDOlS0a+m7EFn+wylZArmr
         LuDMWy70MKKDRNmUcvpT/ZpDgFrOOwROg36J6epD2983I+a/P4EcIFMjyFx+fApaJ72T
         cLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T11pM30Zo2OtDA1oQ1Lu3ZWmFFIu+bqjF96YLuSv8Ms=;
        b=Zv87/3kEF8BrAJGrQCH2+llpnWF7kwOx00rC6oybp7vASe/K87lNjldR2ItJRze4op
         DQaKNddGAAqqdl8GVdJlQ/cs703BopXAU72c2IRhBx+UJOxOAw1FXUljdhiSxTzi88MM
         v+JiAIy1gj6SQMJgsREWhEX3QmTr6Ceo/i52t6Wl+wJNMDknL+vuEF1gyHGKeRsGJSt7
         rUCYLRjGkAjH55j993L7d3tNqXgs2ex9F72rsdYfWqLDp3g2mt+HKfP4CI+ExhPJRNa7
         AwevWwXsxQw/GI+zkLTytYKGX2mh68B0vtFjdvmuRXkXI9CnvjkOZ7En6aAH0Jfo8oMP
         z3XA==
X-Gm-Message-State: AOAM53104l0cbZDse1FBfWQzpE+g+toPJpDQdiWXl+6OGOpGvVDg/0pR
        ku1QAUsk5yXmcgCFGFI4/IDnzufSF5SFHJ+pUCA=
X-Google-Smtp-Source: ABdhPJxhxRMkpjHrW2M757ph3poznUfHcZzWjicKXDDZi6rPQ7+V3ju6+1fDD5nhEvpKmMVGLqGmESOObfrUa0xoFSQ=
X-Received: by 2002:ac2:4834:: with SMTP id 20mr823036lft.598.1606188080248;
 Mon, 23 Nov 2020 19:21:20 -0800 (PST)
MIME-Version: 1.0
References: <CAFWsj_UwkQX9y0xPQJE3xguo0z3TMkvKAwei5iryCWXvVP8CjA@mail.gmail.com>
 <badf3777-3970-b714-3ad9-67d2f77f94a5@web.de> <20201121002921.GC353076@coredump.intra.peff.net>
 <xmqqd006s7ee.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqd006s7ee.fsf@gitster.c.googlers.com>
From:   =?UTF-8?B?5ZSQ5a6H5aWV?= <winglovet@gmail.com>
Date:   Tue, 24 Nov 2020 11:21:09 +0800
Message-ID: <CAFWsj_WsexXgFe-jMYOk8_m9N7GLrhRjqFjRWRePZmxUDEYkSg@mail.gmail.com>
Subject: Re: Bug report: orphaned pack-objects after killing upload-pack on [
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

when will this bug be fixed?

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2020=E5=B9=B411=E6=9C=8822=E6=
=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=8D=885:54=E5=86=99=E9=81=93=EF=BC=9A
>
> Jeff King <peff@peff.net> writes:
>
> > Yeah, clean_on_exit seems quite reasonable to me. I suspect nobody ever
> > really noticed, because as soon as pack-objects starts to write out the
> > pack, it will get SIGPIPE or EPIPE and die. But there is no point in
> > letting it chug on expensive object enumeration or delta compression if
> > upload-pack has already exited.
> >
> > I don't know that wait_after_clean is necessary. We don't need to wait
> > for pack-objects to fail.
> >
> > On the flip side, one of the reasons I added clean_on_exit long ago was
> > for the similar issue on the push side, which is even worse. Here we
> > might just waste some CPU, but on the push side we connect pack-objects
> > directly to the remote socket, so it could actually complete the push
> > (from the server's perspective) after the local git-push has died. Or a=
t
> > least I think that was possible at one point; it might not be the case
> > any more.
> >
> > I wrote this patch ages ago, and it is still sitting close to the botto=
m
> > (if not the bottom) of my todo stack, waiting to be investigated. ;)
>
> Sounds sensible.
>
> > -- >8 --
> > Subject: [PATCH] send-pack: kill pack-objects helper on signal or exit
> >
> > We spawn an external pack-objects process to actually send
> > objects to the remote side. If we are killed by a signal
> > during this process, the pack-objects will keep running and
> > complete the push, which may surprise the user. We should
> > take it down when we go down.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> >  send-pack.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/send-pack.c b/send-pack.c
> > index eb4a44270b..d2701bf35c 100644
> > --- a/send-pack.c
> > +++ b/send-pack.c
> > @@ -85,6 +85,7 @@ static int pack_objects(int fd, struct ref *refs, str=
uct oid_array *extra, struc
> >       po.in =3D -1;
> >       po.out =3D args->stateless_rpc ? -1 : fd;
> >       po.git_cmd =3D 1;
> > +     po.clean_on_exit =3D 1;
> >       if (start_command(&po))
> >               die_errno("git pack-objects failed");
