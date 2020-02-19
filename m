Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08560C34022
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 04:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F8524656
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 04:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6q36R1o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgBSETZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 23:19:25 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41672 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgBSETZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 23:19:25 -0500
Received: by mail-qk1-f193.google.com with SMTP id d11so21815215qko.8
        for <git@vger.kernel.org>; Tue, 18 Feb 2020 20:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LjbF37cXZ24pp4qw2pK7kfYZz06FO8Op39RBY56vIF8=;
        b=U6q36R1oAMCBQ7RKLJcKxM5s1kAdyL76V9XYHfmnVTOKrEC5t+cT9B38MWRBD9d/uN
         CECuWQsYOmOfbJejitd1pjfczJxCYoBLXCQMsUaUNKqdyVyooDE0WuoJ3eqanlwZF2nr
         gUo8PAayqrKxYH1JK07CxwMpgvmAqYmoaHit3NaCfVgt7yMB70G2+00LR/6ZYIwpze9b
         xH4NzObLt2qrzpMUCx14M+nmIXN8IgoSfIH3zfWJi7BFwfW4HD6gALfqW7WodljtcwKV
         UrrHAUk0pjF5qUvyFdDStA4/eD+X09xpRxWhdGfHXXBpiM4vK+Z9PXhrcPFQGq5cC0aS
         PKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LjbF37cXZ24pp4qw2pK7kfYZz06FO8Op39RBY56vIF8=;
        b=K6NSknVnVteiwchi00I+dP/esk5oQWGx3XjtKjO3VftZIeAt6MZESGUikHl651zX7p
         vZS15MAll1yKrAzUBuOuchEH6KVgMI27z0wZxZ1+BwItuti3hbQNCwuN7scfxKzGJAjX
         sgH9CNzdrJ6oPJotZq/kFcZwoFMwx0WpKL/GVAJMfKXAV/8+mrNX6h5MzrgzRg8aJ3lf
         MGxCaZkK4p9to1btfmz4w7U264DwcnYuKHT+m4LLgL7tdSG4qh20l3uIuwoCDHw+8fx5
         Qn0kN3z0DItS+SLXRvM1h7SBb0ftpttxYMPCIAFyvnKeBg06vDu/rXRv3g0aQB4z2hh9
         DPOA==
X-Gm-Message-State: APjAAAWlZeg+kmCxwpk5wQdezQ+Lma1LJ82+A87opK9SO5xa0wPdxj1c
        eppmrfO3SL8E6InwDyDdsDU=
X-Google-Smtp-Source: APXvYqxLWfTTqhv1dmQkRXmJuYUJBaHJ16QhJae50UJbfe8ZMPWT5zHusMa1Cd22zKn+U3Bwf2i4zA==
X-Received: by 2002:a37:5fc2:: with SMTP id t185mr21474785qkb.271.1582085963995;
        Tue, 18 Feb 2020 20:19:23 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id 184sm435243qki.92.2020.02.18.20.19.22
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Feb 2020 20:19:23 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Nested submodule checkout
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <20200218170808.dh4s65b475yqs3oz@mithrim>
Date:   Tue, 18 Feb 2020 23:19:20 -0500
Cc:     git <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <14BE3511-17A8-48D8-B0C4-923745E5462A@gmail.com>
References: <20200214224242.knmzkwx7ls4sote7@doriath> <0123F1ED-C421-4C1F-896B-E54C9D345A34@gmail.com> <20200218170808.dh4s65b475yqs3oz@mithrim>
To:     Damien Robert <damien.olivier.robert@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Damien,

> Le 18 f=C3=A9vr. 2020 =C3=A0 12:08, Damien Robert =
<damien.olivier.robert@gmail.com> a =C3=A9crit :
>=20
> Hi Philippe,
>=20
> =46rom Philippe Blain, Sun 16 Feb 2020 at 23:51:43 (-0500) :
>> I reported the same bug to the list back in September [1]
>=20
> Meta question: is there an easy way I could have found your bug =
report?

That=E2=80=99s a good question. The search capabilities of public-inbox =
(the software running at lore.kernel.org) are explained at=20
https://lore.kernel.org/git/_/text/help/

In this case, my bug report comes out in the following searches:
b:(nested submodule checkout)
s:(bug* submodule* checkout)

the first one can be refined with
b:(nested submodule checkout) NOT s:(cooking) NOT s:(ANNOUNCE) NOT =
s:(PATCH*)

>=20
>> That=E2=80=99s another hint that you have `submodule.recurse` set. I =
don=E2=80=99t get this error doing `git reset --hard`, but I get it =
doing `git reset --hard --recurse-submodules` (or `git reset --hard =
--r`, which works and is quicker to type!). `git reset` populates the =
index, so now `git ls-files -s` would now show the correct content of =
=E2=80=98plam=E2=80=99.
>=20
> Oh, I did not know git expand unambiguous long options!

Yes, it=E2=80=99s not widely known but can be useful! It=E2=80=99s =
documented in gitcli(7) (`man gitcli`) or online at
https://git-scm.com/docs/gitcli#_abbreviating_long_options

> By the way the fact that `git reset` also support =
`--recurse-submodules` is not
> specified in the man page. (It is in the help text thought).

Yes, this is on my radar, I=E2=80=99d like to get some time to clean =
this up sometimes soon. It=E2=80=99s also missing for `git restore`.

> And it would be nice if the documentation of submodule.recurse in
> git-config specify the list of all affected commands, rather than just =
"all
> commands that have a --recurse-submodules options".
>=20
> (I could send a patch for this if there is interest)

That=E2=80=99s a very good idea in my opinion, especially since the =
search functionality on git-scm.com is presently limited to 10 hits from =
the manpages so it fails to find all occurrences of =
`--recurse-submodules` [1].

[1] https://github.com/git/git-scm.com/issues/1374

>> would have correctly checked out the submodules. I have a git alias =
=E2=80=98no-rs=E2=80=99 (for no recurse-submodules) that I use in these =
situations:
>>    git config --global alias.no-rs =E2=80=98-c submodule.recurse=3D0=E2=
=80=99
>=20
> Can you use alias to define option settings (rather than commands =
followed
> by options) without using the 'f() {}' trick?
>=20
> Using your alias, I get
> fatal: empty alias for no-rs

The alias specifies an option directly to the git "main" executable =
instead of a specific Git command (in this case setting a particular =
configuration variable for the duration of the command that will =
follow). This alias works for me, at least on Git 2.25. The git-config =
man page mentions aliases can start with an option to git [2]. If it =
does not work in an older version of Git then you can use=20

    git config --global alias.no-rs =E2=80=98!git -c =
submodule.recurse=3D0'

which should do the trick.

[2] =
https://git-scm.com/docs/git-config#Documentation/git-config.txt-alias

>> Note that using the `submodule.recurse` config also applies to =
internal calls to git commands (issued by other git commands), so using =
adding `--no-recurse-submodules` to the command line might not be enough =
to completely turn off the effect of that config, hence this handy =
alias.
>=20
> Ohh, good to know!

If you do go ahead with a patch listing the commands affected by =
submodule.recurse in git-config, then I think this should also be =
mentioned.=20

Cheers,
Philippe.
