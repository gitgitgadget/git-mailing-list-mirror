Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4DDC28CBC
	for <git@archiver.kernel.org>; Thu,  7 May 2020 02:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F7132082E
	for <git@archiver.kernel.org>; Thu,  7 May 2020 02:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XovT1ac+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgEGC64 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 22:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725827AbgEGC6z (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 May 2020 22:58:55 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD954C061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 19:58:51 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id k18so286161ion.0
        for <git@vger.kernel.org>; Wed, 06 May 2020 19:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=HyL2bkg32HcUVzofAFuJNnACk1j00oV6LadmcS79Dzk=;
        b=XovT1ac+9wHjRQrzSvufbRGfVYBvJWslXCOdIEs9QgxLb7ovRDmzNYzREKZwIa4CwK
         sv75MdM2hz4QU/+Vq8XEwdG9AVbjt6gt2ScEkb12lN37pgkHy5WVtm3C1Z9RP7J29eSw
         l+TZp7+p+Jh1FxyMsdA7gpQwgAH05E903//QDc8m0F3z++ImZ/O4tjT6LT194VFYl6wO
         SkR3rI6dqRdUQtDkIlqr0MNOIVKuy/9msiHhRXPdVH3bMTKvGHeO4JJtY7SFH5nMfxb6
         GGona1OZidIQ+kSinJWiLW808E69ZZUFjAy1qfnbQoHZogDkePJXRxcazYKjJDO5B5u6
         7JgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:content-transfer-encoding;
        bh=HyL2bkg32HcUVzofAFuJNnACk1j00oV6LadmcS79Dzk=;
        b=QmrfG3RbFG/fv0rEeSn910v4yyYI/rK5hI4H4O1Qo3Nu1+3TyM9PXP0z4yd729h/HD
         6LsiXw80NEOROQhm1P2zaHvFW/lGd0aO1r8BZtE/WHMnz9Uu8sIcOLas08rd4ivryfjE
         QUXEHAors/YnPPddxOaF+NnImQOMtpynr/6ao7bvnRVRIJXGjm9B6jbiEamShY5NE4fo
         Q+o8XcGMYdl4zB7YtRHb3FVdtKJp+FWYCGhkk90mUMBHl8RSYDrOg8l8tYgPH6/a+zqg
         uHy2bBmMdf8Aut3DzoWoguQCMCI5PXAwVaqoBbGHa/PgSXIIhju6KbMxSWdf1/6b8uEv
         qyZg==
X-Gm-Message-State: AGi0PuZnB1GMd2SY43/p2d1M2BnCqfhA+pkdy3rh9EOYsI3P4uNokhHN
        nmfatK2UqYCYm3N4b4VVClL6WK8km93q7+kDgHUN+A==
X-Google-Smtp-Source: APiQypIntVopjuJzBiyIlCu4AajBvFwaI87ps34pNwM19TF6FfQdztCdlXpO2pNRhfvWymV8kqxyzUX+/XRkudXguz0=
X-Received: by 2002:a6b:750c:: with SMTP id l12mr12045838ioh.66.1588820330899;
 Wed, 06 May 2020 19:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8nAsF7HT__AhsRk08wpa_Bjsc6RXoZuomVbM1CWeG8QeA@mail.gmail.com>
In-Reply-To: <CAH8yC8nAsF7HT__AhsRk08wpa_Bjsc6RXoZuomVbM1CWeG8QeA@mail.gmail.com>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Wed, 6 May 2020 22:58:32 -0400
Message-ID: <CAH8yC8kjdb5ZwKYsh7S_CgHbOShumggzbHH=ApQVeK3FnPcDnA@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IGNobW9kOiBtaXNzaW5nIG9wZXJhbmQgYWZ0ZXIg4oCYYStyd3jigJk=?=
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 6, 2020 at 10:03 PM Jeffrey Walton <noloader@gmail.com> wrote:
>
> Hi Everyone,
>
> Git 2.26.2 passes its self tests on OS X using libiconv-utf8mac.
>
> It looks like one issue remains during make install:
>
>         for p in $remote_curl_aliases; do \
>                 rm -f "$execdir/$p" && \
>                 test -n "" && \
>                 ln -s "git-remote-http" "$execdir/$p" || \
>                 { test -z "" && \
>                   ln "$execdir/git-remote-http" "$execdir/$p" 2>/dev/null=
 || \
>                   ln -s "git-remote-http" "$execdir/$p" 2>/dev/null || \
>                   cp "$execdir/git-remote-http" "$execdir/$p" || exit; } =
\
>         done && \
>         ./check_bindir "z$bindir" "z$execdir" "$bindir/git-add"
> usage:  chmod [-fhv] [-R [-H | -L | -P]] [-a | +a | =3Da  [i][# [ n]]]
> mode|entry file ...
>         chmod [-fhv] [-R [-H | -L | -P]] [-E | -C | -N | -i | -I] file ..=
.
>
> And on Ubuntu 18.04:
>
> for p in $remote_curl_aliases; do \
>         rm -f "$execdir/$p" && \
>         test -n "" && \
>         ln -s "git-remote-http" "$execdir/$p" || \
>         { test -z "" && \
>           ln "$execdir/git-remote-http" "$execdir/$p" 2>/dev/null || \
>           ln -s "git-remote-http" "$execdir/$p" 2>/dev/null || \
>           cp "$execdir/git-remote-http" "$execdir/$p" || exit; } \
> done && \
> ./check_bindir "z$bindir" "z$execdir" "$bindir/git-add"
> chmod: missing operand after =E2=80=98a+rwx=E2=80=99
> Try 'chmod --help' for more information.
>
> make install stops after the messages. I'm not sure if there is more
> to install at this point.

Cancel... This was my script that changed ownership back to the user
in the home directory.

Jeff
