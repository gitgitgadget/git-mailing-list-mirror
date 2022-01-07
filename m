Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D98C433EF
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 12:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238217AbiAGMwr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 07:52:47 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:49355 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232347AbiAGMwp (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 7 Jan 2022 07:52:45 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 8CA935C00E6;
        Fri,  7 Jan 2022 07:52:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 07 Jan 2022 07:52:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=QxQlELWCtisqil71CFna45aPQSk
        VSJ7NeXJK3FfvWeM=; b=SDxOSDRqYFOiE2fqpaaoWb96be8CYGNvWq0yQodL29m
        dVbx2HJJvMn9o+qylBIPNCcGz/w13CDWqpxb7GE9u5/jvwX7jubuHRx/cHYi9C80
        qFAL4fjyjfoXgQqCE/ChBATg+1Sb+F9dtynVP5mmRjwtOc944Ewjhciq6rRudmzM
        3uINr4z/Zf5eCD3s7pGr2forPSbOBxVkAeOQ6l6P/eNWhAPYD4ax7wiKf2bwZweT
        eswb9KyzVqmjnwh/DqKzbZUCgLPeXxJO013SChfjBhdCOJ6bIFNTgOoZSrvmQEQh
        11CYp55vB8do5moTub35RyLWluXxLuCFho2USaie4nQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=QxQlEL
        WCtisqil71CFna45aPQSkVSJ7NeXJK3FfvWeM=; b=jOwaCLP3r+8tnpQONkma1A
        1II3duRKT+OxvNXoCHPVcxLVCsURoNgoh3vUT3SmgQCykelj8nXUClrudUnr5Mka
        aFbVzN1fcDvX6GG3xMeKGVvRygaL8bxRNxqi82AgPIGH1oYsyRoLuAjJt8+bazUh
        yDKRC6n4AL2AmaOKlASolDMQohp3o6H9E0VoG8D4pNvDBcDHHx5J4YV8kXvHPwCN
        C/TypKVinEDG+Me1YkVZ4tvT+tVTZAUoHKf/7+67cv1uA99aQVxpmX84nZ3IQcu4
        JTqCzkP87ub/rYMO46MVjvnh6iUpnu6w45xSQQxtvCdUpYGTHJC20d7DPRDFsqew
        ==
X-ME-Sender: <xms:nDfYYZnOSZOjvUIdIl24OfCWBSotEINBDDSebX15mwbu5ou87R_YRw>
    <xme:nDfYYU2JDHEfXmrYwhCLX2gflDaD8lCv-RGHDTiCLerRGmCcwDuVbhKz61cOuZFQu
    75tq3qyAwHwPp4SVQ>
X-ME-Received: <xmr:nDfYYfr7DbYkx-KbOQEFoWojjbF70s9rwm6R5mXVSBNbgYTeEAnNGDqgrjQWanXNmjI6o8Uv3QlNGSUBLaB0-2U1jivaDZhoYy3zXfTLpA_K_9xhxmfkXSOa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudegvddgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeevvddtuefgvdehkeevgeethfeifffhhffhgeetheefgfefheevteevjeeuhefgjeen
    ucffohhmrghinheprggurghmrdhlohgtrghlpdhgihhthhhusgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:nDfYYZlRsm9LxHaCmao6Hpz_buE5zZj3RZoT0mB8fAclzuVYc5xOAA>
    <xmx:nDfYYX34i-ezmgcjB9APaoUxHLPIsXnjSW5pySLZC4bVfMkwQYpsog>
    <xmx:nDfYYYu3-1EBHus-_tHOSHPYYECNez2UfiKI6GSQ4DN4BEPtKjC9qw>
    <xmx:nDfYYQ-XHhRtkNMAI01iYfNQO7ED2EAkrzXO64SGbNjxPXwNKXAoGw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jan 2022 07:52:43 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 7fa75a76 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 7 Jan 2022 12:52:42 +0000 (UTC)
Date:   Fri, 7 Jan 2022 13:52:20 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Bug using `fetch` with blank `-c` arguments to git
Message-ID: <Ydg3hE+ZcCq4qW9m@ncase>
References: <CA+kUOak9_RLpdr9d4pQiwU=K42taCwhMdg5WkLP4GreQd4yWig@mail.gmail.com>
 <CAGyf7-HSia4pRs4FZ107v0jmP4k4Zfw5zJ-3Oz8UvF9oobczEw@mail.gmail.com>
 <CA+kUOam-Dd-XUk0XaOfw4_rUTg=Ws7w5H=vZ=ZZeEo4XJfsVOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IuTYXZb7ZMU1i2ph"
Content-Disposition: inline
In-Reply-To: <CA+kUOam-Dd-XUk0XaOfw4_rUTg=Ws7w5H=vZ=ZZeEo4XJfsVOg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--IuTYXZb7ZMU1i2ph
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 04, 2022 at 09:00:45PM +0000, Adam Dinwoodie wrote:
> On Tue, 4 Jan 2022 at 20:04, Bryan Turner <bturner@atlassian.com> wrote:
> >
> > On Tue, Jan 4, 2022 at 4:37 AM Adam Dinwoodie <adam@dinwoodie.org> wrot=
e:
> > >
> > > While investigating some issues with a different project, I discovered
> > > the command `git -c config.helper=3D fetch` was working with the Debi=
an
> > > stable version of Git (v2.30.2) but not with my local build
> > > (v2.34.1.428.gdcc0cd074f).
> >
> > Since you're working with a locally-built Git, have you, by chance,
> > actually _installed_ that build, or is it simply in the Git repository
> > itself after running make?
> >
> > If you haven't _installed_ your build, my guess is you might be
> > getting a mismatch wherein your _built_ Git, when it forks out
> > subprocesses, is triggering your _installed_ Git (which I assume you
> > have, and which I assume is not 2.34.1). Git compiles paths into
> > itself to know where to find certain binaries, and if you run a
> > compiled-but-not-installed Git then those paths are "wrong". (I see
> > administrators do this fairly often when building Git from source to
> > set up Bitbucket Server.)
> >
> > What does `./git --exec-path` print, when you run your 2.34.1 binary?
> > And is that where, for example, the compiled 2.34.1 versions of things
> > like `git-remote-https` are?
>=20
> Good thoughts, but I initially hit this problem after having installed
> it; I reproduced it running Git from the working copy for ease of
> bisecting, but the problem definitely occurs using the compiled
> version after installation. The below was collected after running
> `make install` (plus all the previously noted build commands,
> including running the configure script to specify the installation
> path) with the commit I identified as introducing the problem:
>=20
> ```
> $ type git
> git is hashed (/home/adam/.local/bin/git)
>=20
> $ which git
> /home/adam/.local/bin/git
>=20
> $ git --version
> git version 2.29.2.372.g1ff21c05ba
>=20
> $ git --exec-path
> /home/adam/.local/libexec/git-core
>=20
> $ ls $(git --exec-path)/git $(git --exec-path)/git-remote-https
> /home/adam/.local/libexec/git-core/git
> /home/adam/.local/libexec/git-core/git-remote-https
>=20
> $ $(git --exec-path)/git --version
> git version 2.29.2.372.g1ff21c05ba
>=20
> $ rm -rf tmp && git -c core.autocrlf=3Dtrue clone git://github.com/git/gi=
t tmp
> Cloning into 'tmp'...
> error: bogus format in GIT_CONFIG_PARAMETERS
> fatal: unable to parse command-line config
> ```
>=20
> For the sake of double-checking, though, I just uninstalled the
> version of Git in /usr/bin (after spending some time working out how
> to do that with apt, without also uninstalling dependencies I wanted
> to leave alone) and repeated the above commands, and got exactly the
> same output.

I cannot really reproduce this locally. But given that it happens on
some installations while it works alright on others my best guess is
that you're effectively running a "mixed" setup, where Git binaries of
one version execute Git binaries of a different version. The result
would be that they have different ways to encode GIT_CONFIG_PARAMETERS,
where new versions use the more robust, quoted format, which older
versions don't understand, or the other way round.

If my theory is correct, then I'm a bit on the edge to call this a bug.
Git expects its binaries to all be of the same version, so running such
a mixed setup is only going to cause problems. This isn't only true for
internal variables like the one we have here, but we also introduce new
command line switches and expect Git helpers to understand them without
any fallback if an old binary was executed.

You may want to verify that the Git executables you have are indeed able
to execute the correct auxiliary binaries as expected and that they all
stem from the same Git version.

Patrick

--IuTYXZb7ZMU1i2ph
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmHYN4MACgkQVbJhu7ck
PpSk4Q//aG9B5n0X/n23H9aO8pT069qAWtNymO/zIiiMBaVIDaQUi2zjpCKCyBYY
UQ7om9TwmAA6YNnQmcpQQEKWu50JJsxPdscLf+uXC4UjiZh9qN6OW2XRI652s5h3
6gIwXshi1vdmgVhJZpG8XMIhUb/Z3EO1TYGZYeXOUyeRlNjPhjfDPVkSp4W90nBE
VAgkSylG1AWmYZ1YVNC1sfVMSrolWoCYCuqMXEAB7TFT1KfnVxDiZrmwlQdN89Ac
pRDGaXkl9V4VZEKS+5G/Okjc5GtdTjhEofgC9FR9/pQD3j2mu5leqQcjtEK8UupG
FtH5QWa4sICPeM4Fn2RdbqzB2AbHNd29dPhEU4VIqW4Pwavf2lfg7BwC/nhQy+Jq
1aLx2aIohIAPOxI+sPoz7XVvKpFiQYGqwgUP28I1qQjM7EUkCYxD5JRLoMeEuajH
RIh/fCOlymbA79oy/um8mMsBHrCE2D7MaUR6GhGkQUCrK49Rh1jpARX4LKrdvfWb
xwkikVVjKn6h4bPRjr/9CZQ4JmP4CgJTqFSClUa7a4heDoNLp0bWsFk8Ho2LhzRa
bzkE8wlBNJ9jMaoylgggaRtaswJcyo0tia97wqfXSMafXKXWkUPhaHG3beU9AhzG
tgRoGLle4Y3z5uACRaUpFph4+oIlFG5xCsW6EVxpR8U/ErTRqhY=
=3ijd
-----END PGP SIGNATURE-----

--IuTYXZb7ZMU1i2ph--
