Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA87C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 22:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiKHWw4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 17:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKHWwz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 17:52:55 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC65361769
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 14:52:53 -0800 (PST)
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 213035A1AC;
        Tue,  8 Nov 2022 22:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1667947973;
        bh=M1/J81hdGxAxIi49FdDjENEQ82ji4vvw7NQZDrxIQi0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=JF75PYXSe4NUrQDDB7UeId/s/7MBIHHZfjBgD1QKAg6t6Y04cuNMTyW7nkTQ//Qks
         WWpmZmJHwjFXNS1Ow+D8D4l+D91sd0FYSUrtKiLF+WxO5EnWq/Y+zdWd0F1GmVz5Yz
         NokDadSroIaA1rmxP72ZKoTaCbqeBS5UyRbHjnhFkTwVnKC3jGBVDNQtffzwqapVZx
         ohbqYf4dk05+LG0B3o0qSBjLvIChQoLNnF3DxOPI3WEFZTW+ZJSK7NmsXXL9rnjS67
         LQulIdcuEDH/1m3ANLr4Vyla9HRoRtQvciNutG4rJQzco5XtYKTkTnUTDufv435qxz
         yA4GAxi+YLUNaYCEKe2wYU2ubwzA826rmCaZxLzZT8nKEPXKwpMArJh/12FegX9zDA
         wtGgfrtipONHvIldkiJU1Zo8iDFeBTU+VtvjhqVyu8m4eCAUpJEnuZc0R01sQ8okbJ
         h8lxnfLQJGyoFUU+4nJg/jOrVLXRy6PjoYHp1YW64iC+QR3tDL2
Date:   Tue, 8 Nov 2022 22:52:51 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     M Hickford <mirth.hickford@gmail.com>
Cc:     git@vger.kernel.org, "peff@peff.net" <peff@peff.net>
Subject: Re: The enduring popularity of git-credential-store
Message-ID: <Y2rdw7RD8mGTF40w@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        M Hickford <mirth.hickford@gmail.com>, git@vger.kernel.org,
        "peff@peff.net" <peff@peff.net>
References: <CAGJzqskRYN49SeS8kSEN5-vbB_Jt1QvAV9QhS6zNuKh0u8wxPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4x7yFyrdS+W5MSlz"
Content-Disposition: inline
In-Reply-To: <CAGJzqskRYN49SeS8kSEN5-vbB_Jt1QvAV9QhS6zNuKh0u8wxPQ@mail.gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4x7yFyrdS+W5MSlz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-11-08 at 10:50:33, M Hickford wrote:
> Among StackOverflow users [1], git-credential-store appears several
> times more popular than any other credential helper. Does this make
> anyone else uneasy? The docs warn that git-credential-store "stores
> your passwords unencrypted on disk" [2]. Are users sacrificing
> security for convenience?

I definitely think there are better approaches.  However, none of the
credential managers for the three major platforms work without a
desktop environment, so if someone's logging in over SSH, then there's
no more secure option that's going to work for them.  Taylor did
mention GCM, but I believe it has the same problem, and even if it
didn't, it's written in C#, which isn't portable to many Unices and
isn't viable on servers anyway due to dependencies.

Even on Linux desktops, Debian and Ubuntu don't ship the libsecret
credential helper, so users have to build it themselves.

I have written a tool that lets you access credential helpers on your
local machine over an SSH session for trusted machines[0], but it's very
preliminary.

In the ideal world, we'd ship an encrypted store that people could use,
but then we have to deal with export regulations and sanctions and
nobody wants to do that.  We'd also have to deal with multiple
cryptographic libraries for portability and license reasons and nobody
wants to do that, either.

> Firstly, how grave is storing credentials in plaintext? Software
> development guidelines such as CWE discourage storing credentials in
> plaintext [3]. Password managers in desktop environments, mobile
> operating systems and web browsers typically encrypt passwords on disk
> and guard them behind a master password.

I think there's space for credential managers that operate with major
password managers.  Unfortunately, op (the 1Password CLI) isn't open
source, although LastPass has an open-source CLI.  If Firefox and/or
Chromium can offer command-line functionality to access the password
manager, those could be supported.  Such a tool would probably live
outside of Git's codebase because I think interacting with some of those
tools requires parsing JSON, which we won't want to do in C.

> Secondly, the docs recommend git-credential-cache [2] which ships with
> Git and is equally easy to configure. So why isn't it more popular? My
> hypothesis: while caching works great for passwords typed from memory,
> the combination of caching with personal access tokens has poor
> usability. The unmemorised token is lost when the cache expires, so
> the user has to generate a new token every session. I suspect GitHub's
> 2021 decision to stop accepting passwords [4] may have inadvertently
> pushed users from 'cache' to 'store'.

That may be the case, but I'd much rather people use tokens instead of
passwords because they're much more limited and can easily be revoked
(or can even just expire).  We know that people are very bad about
reusing passwords all over the place, so in the event people do
compromise their credentials, they're substantially more limited.

> Thirdly, why doesn't everyone use SSH keys? Unlike HTTP remotes,
> upfront set-up is necessary to clone a public repo. For users
> unfamiliar with SSH, this set-up may be intimidating. Introducing
> users new to Git to SSH at the same time is a significant cognitive
> load.

SSH keys are also more difficult to make work with multiple accounts,
and judging from my experience on StackOverflow, that's not an uncommon
situation to be in.  I have diligently added entries in the FAQ to cover
this, but in general people don't read it unless specifically directed
there.

I do think SSH keys in general work well for forwarding to other
machines, but in a decent number of corporate environments there are
intercepting proxies so everything has to be HTTP.

[0] https://github.com/bk2204/lawn
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--4x7yFyrdS+W5MSlz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY2rdwwAKCRB8DEliiIei
gZkNAQCX6HpIW2lLP+nnlDaKZATgjHKZWgcF5ECavTQdUzhC3QD+NfEYOZY5EZAG
idt2kQ/kU6UuBtPb3K0EQQu41bwcjAI=
=mlyA
-----END PGP SIGNATURE-----

--4x7yFyrdS+W5MSlz--
