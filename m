Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C392EB64D7
	for <git@archiver.kernel.org>; Fri, 23 Jun 2023 10:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjFWKDI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jun 2023 06:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjFWKCd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2023 06:02:33 -0400
Received: from forward500c.mail.yandex.net (forward500c.mail.yandex.net [178.154.239.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EC5189
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 03:02:30 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:6e01:0:640:627f:0])
        by forward500c.mail.yandex.net (Yandex) with ESMTP id EED275E966;
        Fri, 23 Jun 2023 13:02:28 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id R2E8k5TDgGk0-BvZ8w736;
        Fri, 23 Jun 2023 13:02:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687514548;
        bh=u3441w2p7QljYfYpx87bjOVhqLCdvpoqi+C0jMpWHLI=;
        h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
        b=w7Ci1fCGZQAYuX/bZ32ZahY3Y6C73DQVF8W07kU1w+K/5eHrob2YIUDcI1vlE7hih
         6buEoGb17oj3Kj5HgpsTXE64oOsIuctbkzdIByTmOataoVvAojP1eVEmb9ARJoaaUy
         a9xSaMUXZw1SPs/2FRtiSwy/YOlrrLLxEbmjl/S8=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <d20ac97bbb82256732e15cdc512709db98d1da88.camel@yandex.ru>
Subject: Re: Getting path to a file from arbitrary project directory
From:   Konstantin Kharlamov <hi-angel@yandex.ru>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Fri, 23 Jun 2023 13:02:27 +0300
In-Reply-To: <xmqqzg4qbj4y.fsf@gitster.g>
References: <21c8396c1441dd4f74cd2097ac970a2033b81da4.camel@yandex.ru>
         <xmqqzg4qbj4y.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you, it works!

On Fri, 2023-06-23 at 02:52 -0700, Junio C Hamano wrote:
> Konstantin Kharlamov <hi-angel@yandex.ru> writes:
>=20
> > 1: the usecase is I have a Emacs helper function to pick up a an
> > aribtrarily mangled path to a file in the project from the primary
> > clipboard and open that file. It's often "mangled", because gdb
> > prints it with `../`, then logs print no path whatsoever, just a
> > filename=E2=80=A6 So it's generally useful to have.
>=20
> Sounds like you are looking for the top (and possibly glob) magic
> pathspec, e.g. in the source tree of Git itself, I can go a few
> levels down into a random directory and get exactly the same listing
> of two files whose name is "rerere.c" located in two directories:
>=20
> =C2=A0=C2=A0=C2=A0 $ cd t/helper
> =C2=A0=C2=A0=C2=A0 $ git ls-files --full-name ':(top,glob)**/rerere.c'
> =C2=A0=C2=A0=C2=A0 builtin/rerere.c
> =C2=A0=C2=A0=C2=A0 rerere.c
>=20
> Look for magic pathspec in "git help glossary" to learn more.
>=20
>=20

