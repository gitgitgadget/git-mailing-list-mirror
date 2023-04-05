Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2D7C76188
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 17:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjDERcf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 13:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjDERcd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 13:32:33 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F6B4C31
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 10:32:32 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 4F3995C00C2;
        Wed,  5 Apr 2023 13:32:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 05 Apr 2023 13:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1680715949; x=1680802349; bh=tf
        W2bN0eHPIFYhqFelVmUrI5Ng5c9YEFw6J02x7tl20=; b=p9WRWPkxGtuqkG/hVB
        ipSHeIufLHs8SW49pwgXRrk88v/Szdmtfcr3u6JaboldqueeLDRr5We7zNwyONVq
        bqrr8+jUx91DrO6BQM+lUjuS/9iKTb0rJ6OraCsXJrk5qIMq8kgR/ZlilcHp4tEc
        AaNCA0M1lWB7G6drVxZPDz+pheyHS0N7Fm0/fSK2j573gehOmgGZRf3BQEQP/Jah
        xOYf9OXTk4tTV18En7CvgqB+czj6gwhqMvX6AE4IcmdazXmfC0lcue8F5G+qUIs1
        FcxwjRvsJTfa7fsC8KWixgW2F0ndNR0Z0lPPNy72hDhEnucTL9RhjoDdbBkg183s
        WSXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680715949; x=1680802349; bh=tfW2bN0eHPIFY
        hqFelVmUrI5Ng5c9YEFw6J02x7tl20=; b=WFmiHN3ygcJqdRFhVTmmf1NeKwbjj
        qrDJ3b09QU3tz48mJMfEgTI7U1GfRUJz3ITN9d5oECoqqLXsvgy0lj8TjN3YdPka
        m9O/qJcm7j40jNVUm6vBkVl+bG0oMP/Df/NO64kp4kzCNXBVxMxhuYh4n1YWrjHa
        yMdzW/83fxIoK7D7R/L/qHnook+dnhS6+Tr9ZGaoS9hqbvFrPpEkjqNeeV1wdizW
        t7XnNMrIgUPPEvqsZFI/Jc5ReTdX8ryg5P7pvz3A7OfkIAOrVJhOCp8kj3Vwch8a
        Z0GCPOQCRePyQ8DOw/ByzAQ489XY9JMe6LHyW+EtqFWjcdbMjDxGPObsQ==
X-ME-Sender: <xms:rLAtZCR33iA-cLkHyUoz-uvIsdBIDO3HsFjbzvUy1V7GF6PwoTbGtg>
    <xme:rLAtZHwu6TK9YvRTBuZDftgSeClAeRvzhV7zWHfUtjm8OLUl7eUSzUpn63qIruzhT
    hjy04iqC9DpochARA>
X-ME-Received: <xmr:rLAtZP2KvIZvywN6w-3kOWMsohL3ArEd9A8SaIesdIyeYZcZQdYygrkqPNYjndRdZjrFXOBM6unve8MoqjzoFHGWqNiUXQ6fsUo-U6zHzfQE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:rLAtZODnRY8y6vKRpRun6AmP88eXH5vCch1SEU_GRf5K2kXPcQh4zA>
    <xmx:rLAtZLi-2g3xU3ihZKuIQ7rsLqqh1KhtDOYVRyhGX5V2sr4jQpaBhA>
    <xmx:rLAtZKogA1DKCnbdZljtTFZwNlnbtEPVrhUimLNHGlm0abA1J5fMVQ>
    <xmx:rbAtZDYPvqGC7rju4sE_1iaDVjQnXC-oIOG7uRLcvtIuwCxpvlg4uA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Apr 2023 13:32:27 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 6c812c5b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 5 Apr 2023 17:32:17 +0000 (UTC)
Date:   Wed, 5 Apr 2023 19:32:22 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] global: resolve Perl executable via PATH
Message-ID: <ZC2wppC62E7wOcqM@xps>
References: <d9cfad7caf9ff5bf88eb06cf7bb3be5e70e6d96f.1680689378.git.ps@pks.im>
 <ZC2I7CfVzY6Tl7Pk@pobox.com>
 <ZC2LOAwycdaUawxM@ncase>
 <20230405165414.GA497301@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ix9BjDx25LRXBfkL"
Content-Disposition: inline
In-Reply-To: <20230405165414.GA497301@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ix9BjDx25LRXBfkL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2023 at 12:54:14PM -0400, Jeff King wrote:
> On Wed, Apr 05, 2023 at 04:52:40PM +0200, Patrick Steinhardt wrote:
>=20
> > > Is there a reason to not set PERL_PATH, which is the
> > > documented method to handle this?  From the Makefike:
> > >=20
> > > # Define PERL_PATH to the path of your Perl binary (usually /usr/bin/=
perl).
> >=20
> > Setting PERL_PATH helps with a subset of invocations where the Makefile
> > either executes Perl directly or where it writes the shebang itself. But
> > the majority of scripts I'm touching have `#!/usr/bin/perl` as shebang,
> > and that path is not adjusted by setting PERL_PATH.
>=20
> Which scripts? If I do:
>=20
>   mkdir /tmp/foo
>   ln -s /usr/bin/perl /tmp/foo/my-perl
>   make PERL_PATH=3D/tmp/foo/my-perl prefix=3D/tmp/foo install
>=20
>   head -n 1 /tmp/foo/bin/git-cvsserver
>=20
> Then I see:
>=20
>   #!/tmp/foo/my-perl
>=20
> And that is due to this segment in the Makefile:
>=20
>   $(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VER=
SION-FILE
>           $(QUIET_GEN) \
>           sed -e '1{' \
>               -e '        s|#!.*perl|#!$(PERL_PATH_SQ)|' \
>               -e '        r GIT-PERL-HEADER' \
>               -e '        G' \
>               -e '}' \
>               -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
>               $< >$@+ && \
>           chmod +x $@+ && \
>           mv $@+ $@
>=20
> And that behavior goes all the way back to bc6146d2abc ('build' scripts
> before installing., 2005-09-08). If there are some perl scripts we are
> "building" outside of this rule, then that is probably a bug.
>=20
> The only thing I found via:
>=20
>   find /tmp/foo -type | xargs grep /usr/bin/perl
>=20
> was a sample hook (which is probably a bug; we do munge the hook scripts
> to replace @PERL_PATH@, etc, but I think the Makefile never learned that
> the template hook scripts might be something other than shell scripts).

Yeah, agreed, the scripts we install are fine from all I can tell. I
should've clarified, but what I care about is our build infra as well as
our test scripts. That's neither clear from the commit description nor
=66rom the changes that I'm doing.

I'd be happy to keep the current state of installed scripts as-is and
resend another iteration of this patch that only addresses shebangs used
in internal scripts.

Patrick

--ix9BjDx25LRXBfkL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQtsKUACgkQVbJhu7ck
PpQpKw//V2tiC+leF+5Vb0VzYiIP1VW5yWBsdBKaSjHBXN3el4hQUlt0EG5vxrbd
b+6RxQIxy5e2C11xDhdWLWReGCcD4IMlTCqMhjZJ0ve16DMa67AoEAQcwi8mBJ7r
xE9mQOQYO6ZJQh0dOy6r12Kq6IgrP3kwZIWiZlipREHFWrkrWsrSq2cgJfFCO1+S
tk/fZX4E5RnMSlipHbJBjmMphoA8H8seHkLHR2AtxNl7V7Q6vwF1bFA8J3dXwE0D
y3jSv1z7noS/hxPus/cV4qEhbebvq8I9Y7rmgI8VFVMxt2SjTjnBX7DyfyjADt0/
aVT27p1TSyYb6JLSJE0g/piqDaUDwdWoQFdlCc6/CKG/m8xC1dsHWXhCvSHXk2QH
Zwa3A93EzE1O0SDTJ4QydC9tomjngnV4xKgja24XGUeL4mc3zHgGdcNsqwaJ+kX6
rJljSHZrWQDpiIRPJaQ6/O3itBKu/k56ulixB86Wjxy/rW5WZrtAivbBO71CmLNq
n+pLZ0KcTdLSgr0YS2OTQH71INfJ/OMLgCMq+Gs9ZzJDJCwaz4FO6MwgZ9y9iuTR
7KhBJzaUaks7c1WzlgEtSnTG17ru0wRvO6BPB7H565EKn7xEkIx79c92M4kIaFJR
YIIKoz+1VR212JRODOJR3lsLB5cLE+ff3Cbp8hmPtf1pVVbSOZA=
=99AY
-----END PGP SIGNATURE-----

--ix9BjDx25LRXBfkL--
