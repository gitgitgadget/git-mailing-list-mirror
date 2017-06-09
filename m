Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDC921F8CF
	for <e@80x24.org>; Fri,  9 Jun 2017 12:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751577AbdFIMEv (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 08:04:51 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:32782 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751541AbdFIMEu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 08:04:50 -0400
Received: by mail-qt0-f174.google.com with SMTP id u12so72917857qth.0
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 05:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mKhSBBYUyhj+osv7zE/9z91Y3UE98tQpyGolhlHzrDw=;
        b=QXCwm3eBdBnMRISzqJXvSjMdCG3XS1ioT52Hcovz//WqRh2LbByCyGh+txPWaA4/H7
         ATcaL9mXnBNie3W3BIxI5DGA04VUa91wQWVzzPJDu6SRjRCAGVGHt79nWCkk5LRhGZzy
         GOZIBBVTYinRYgL3e/Mxn+NDuIm9cQ5EMG1P1nuMAcGZarCgtnaj5ncFuO2Paac/VNvI
         NXujrWA2Nf4loqKubAGmuG4VgBWOo6AIDV9pf5ZNetf56CLnCGVkDVm+mVf8qgS7/bf0
         gMuMoC584zbC4GY/LA9Atq6EXmlDlOSJJebeJuucjLXBV5o3Lj+dP6sIyu3Eha7PV6r6
         4nmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mKhSBBYUyhj+osv7zE/9z91Y3UE98tQpyGolhlHzrDw=;
        b=av2rnvfHYxfaV7dWLJ0igN+3TcxcGmVYYb98QIuc6B3Fag2ie3Bay+jgWaotnGZpWm
         Yu+NTTcNwA4hzICaHI/NTTE3gc5t/uT+TGp2LH8A+9FkZyM6IysDEF/a8bcRNL10Xa3c
         wxUI9WdhwT57v2XVjMaE+EDAij6SG30+ABRNPVLqXgXouH4ERWKTujUdjpWP0phbHvw9
         6fQgVT+dE18e8jGOBh/OWQyGbJRDo1OrhgPVXrM6j6bdiWomh41RbMnuxxqnByK01UJm
         aS6VCLmmaZd+dxTxAxJ1jjcySa0Msn3sh/ZmVwCEoRBtzv5XRXqM4EBnN8LCPPHd23p9
         GBRw==
X-Gm-Message-State: AODbwcCMhZ4WiMpY4kAJKSh6wOb4kJnuNN4Z2wUWJ9mZVe4NI+cJy0mW
        9jZwTvd1Yob73OP7qh71gTGuv0lcYA==
X-Received: by 10.237.46.226 with SMTP id k89mr5062888qtd.158.1497009889668;
 Fri, 09 Jun 2017 05:04:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.162.85 with HTTP; Fri, 9 Jun 2017 05:04:49 -0700 (PDT)
In-Reply-To: <20170609085346.19974-2-avarab@gmail.com>
References: <20170608234100.188529-8-bmwill@google.com> <20170609085346.19974-1-avarab@gmail.com>
 <20170609085346.19974-2-avarab@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 9 Jun 2017 14:04:49 +0200
Message-ID: <CAP8UFD0w34frARr4AjLQen0oXhFxu4B37e5JKz49oqn5MyxwhA@mail.gmail.com>
Subject: Re: [PATCH 1/2] git-compat-util: add a freez() wrapper around
 free(x); x = NULL
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 9, 2017 at 10:53 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:

> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -787,6 +787,7 @@ extern char *xstrdup(const char *str);
>  extern void *xmalloc(size_t size);
>  extern void *xmallocz(size_t size);
>  extern void *xmallocz_gently(size_t size);
> +#define freez(p) do { if (p) { free(p); (p) =3D NULL; } } while (0)

I think we already rely on free(NULL) working, see
http://public-inbox.org/git/alpine.DEB.2.20.1608301948310.129229@virtualbox=
/
for example, so this could just be:

#define freez(p) do { free(p); (p) =3D NULL; } while (0)

and yeah FREEZ() would be even better than freez().
