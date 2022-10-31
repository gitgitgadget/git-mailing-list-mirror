Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9987BECAAA1
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 14:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbiJaOqA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 10:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbiJaOp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 10:45:56 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8144101CB
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 07:45:52 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 315FF320098C;
        Mon, 31 Oct 2022 10:45:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 31 Oct 2022 10:45:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1667227551; x=1667313951; bh=BhdaJThsx1
        Ar1aV2Y/PfbNlqtw733bIrO5UIKurXbes=; b=DhqLzGZA9CF879SZI7+P0YZiu+
        ez3Ol8qhU6NR/7q8ijt22qaJU33Bo3/bokrjwXONSzH8Ihk10Xo5SsXDqfQGnQ+z
        vaFgbyU3jg4AJYWpTnUS4JFn8P/e2UFWnpTngxVUgmp/m1GE4u8L2F7yndtF+SIc
        jAdRsIQomZLbWtmkXCUIJRb2rp+IVFIyd6W8fSjpj1DImdp8okPsTP0862GglB+q
        CFMd+4ZS4uHGp/oWvwA+ZjTYRbwCmb+HPJaeufBWfw9MEFnK22BP1vlC8joWzmna
        by7Fc0jo0OnXi4k8kaDgkB2q/JLBhhd1phVUziR8cjL9wlQML8vP+JTVksmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667227551; x=1667313951; bh=BhdaJThsx1Ar1aV2Y/PfbNlqtw73
        3bIrO5UIKurXbes=; b=ZhbTcNJTc0wGwISydC0vPXqLEb9rBr69KOOWjWbmLBc+
        vGQF8x0VW0RmcPIMTXHwFv5lWqXv0dXjeJmR+bl7y+MPoPotEbxoaVpRShG/im58
        jEPMybWCFubbJb2DKQTRcNnkMC8imqdLYcvb1agc8C7mmm/FZmxeDX3pRhQ4NHsT
        jXbLX1UehXLWA20czDY3k6FYRAqdLLg9yrtetCIUZKtb9RZoWGrOkXd2x3DzZS2e
        TPepHfuWLq3PlE1T+mciR/pekd9+RXCtTsdg1Li4VV/11XzKD4kiX+zwVYIY2d5B
        hFfG6mZZCOHH5zsv9jrovQdnBbAo24jw996hn5FY/A==
X-ME-Sender: <xms:n99fY3GC8vMO5rZasGyccvwz5tZ-dnVdbnBXPWQiS63cCVdw7KvWcQ>
    <xme:n99fY0UslUWdwq-8yGvK6bcbHztHU2CcME_ekZkyT3telNUZKypam6k_dG-kfrmTB
    hd8vXUiFyU1tRxvdQ>
X-ME-Received: <xmr:n99fY5IvRkOiIcG1Ozbh-jlNkOWOWOI1giqPILYqTTYGA8A8WkmEOqOk3DNB1gHh-yo5Ncfyz4fjD236G_8eMfkvNoPQ1LUb_nZr1QLHW_wlSZs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrudefgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:n99fY1HZGm-o7rW0i0Q5WMWHxCOgTPukJGmG3MQZIsXdMdzI2pNQ6w>
    <xmx:n99fY9URnT60doOp2XGyyHS48mXdmwxnpmRjX2rkZdTUHqQeNqfa3A>
    <xmx:n99fYwOSKG77_hDnbivqJLJi_nqJIAL7o13c2AE3zyr1RTtCtQgwBQ>
    <xmx:n99fY-fs_vnQYICI_QWC5Vbp4F-MwTYmdicsZTZCbPNIPzSn7Fyjzg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Oct 2022 10:45:50 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 9335165a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 31 Oct 2022 14:45:35 +0000 (UTC)
Date:   Mon, 31 Oct 2022 15:45:47 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] receive-pack: use advertised reference tips to
 inform connectivity check
Message-ID: <Y1/fm1prlAs3U1NE@ncase>
References: <cover.1666967670.git.ps@pks.im>
 <006e89f384be1227b922fb6fdc8755ae84cac587.1666967670.git.ps@pks.im>
 <Y17L0IjELU5QlOPL@nand.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="stdC7xRx77pL9a5G"
Content-Disposition: inline
In-Reply-To: <Y17L0IjELU5QlOPL@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--stdC7xRx77pL9a5G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 30, 2022 at 03:09:04PM -0400, Taylor Blau wrote:
> On Fri, Oct 28, 2022 at 04:42:27PM +0200, Patrick Steinhardt wrote:
> > This strategy has the major downside that it will not require any object
> > to be sent by the client that is reachable by any of the repositories'
> > references. While that sounds like it would be indeed what we are after
> > with the connectivity check, it is arguably not. The administrator that
> > manages the server-side Git repository may have configured certain refs
> > to be hidden during the reference advertisement via `transfer.hideRefs`
> > or `receivepack.hideRefs`. Whatever the reason, the result is that the
> > client shouldn't expect that any of those hidden references exists on
> > the remote side, and neither should they assume any of the pointed-to
> > objects to exist except if referenced by any visible reference. But
> > because we treat _all_ local refs as uninteresting in the connectivity
> > check, a client is free to send a packfile that references objects that
> > are only reachable via a hidden reference on the server-side, and we
> > will gladly accept it.
>=20
> You mention below that this is a correctness issue, but I am not sure
> that I agree.
>=20
> The existing behavior is a little strange, I agree, but your argument
> relies on an assumption that the history on hidden refs is not part of
> the reachable set, which is not the case. Any part of the repository
> that is reachable from _any_ reference, hidden or not, is reachable by
> definition.
>=20
> So it's perfectly fine to consider objects on hidden refs to be in the
> uninteresting set, because they are reachable. It's odd from the
> client's perspective, but I do not see a path to repository corruption
> with thee existing behavior.

Indeed, I'm not trying to say that this can lead to repository
corruption. If at all you can argue that this is more security-related.
Suppose an object is not reachable from any public reference and that
`allowAnySHA1InWant=3Dfalse`. Then you could make these hidden objects
reachable by sending a packfile with an object that references the
hidden object. It naturally requires you to somehow know about the
object ID, so I don't think this is a critical issue.

But security-related or not, I think it is safe to say that any packfile
sent by a client that does not contain objects required for the updated
reference that the client cannot know to exist on the server-side must
be generated by buggy code.

[snip]
> Why do we see a slowdown when there there aren't any hidden references?
> Or am I misunderstanding your patch message which instead means "we see
> a slow-down when there are no hidden references [since we still must
> store and enumerate all advertised references]"?

I have tried to dig down into the code of `revision.c` but ultimately
returned empty-handed. I _think_ that this is because of the different
paths we use when reading revisions from stdin as we have to resolve the
revision to an OID first, which is more involved than taking the OIDs as
returned by the reference backend. I have tried to short-circuit this
logic in case the revision read from stdin is exactly `hash_algo->hexsz`
long so that we try to parse it as an OID directly instead of trying to
do any of the magic that is required to resolve a revision. But this
only speed things up by a small margin.

Another assumption was that this is overhead caused by using stdin
instead of reading data from a file, but flame graphs didn't support
this theory, either.

> If the latter, could we avoid invoking the new machinery altogether? In
> other words, shouldn't receive-pack only set the reachable_oids_fn() to
> enumerate advertised references only when the set of advertised
> references differs from the behavior of `--not --all`?

Yeah, I was taking a "wait for feedback and see" stance on this. We can
easily make the logic conditional on whether there are any hidden refs
at all.

> >  	if (check_connected(iterate_receive_command_list, &data, &opt))
> >  		set_connectivity_errors(commands, si);
> >
> > @@ -2462,6 +2473,7 @@ int cmd_receive_pack(int argc, const char **argv,=
 const char *prefix)
> >  {
> >  	int advertise_refs =3D 0;
> >  	struct command *commands;
> > +	struct oidset announced_oids =3D OIDSET_INIT;
>=20
> This looks like trading one problem for another. In your above example,
> we now need to store 20 bytes of OIDs 6.8M times, or ~130 MiB. Not the
> end of the world, but it feels like an avoidable problem.

We store these references in an `oidset` before this patch set already,
but yes, the lifetime is longer now. But note that this set stores the
announced objects, not the hidden ones. So we don't store 6.8m OIDs, but
only the 250k announced ones.

> Could we enumerate the references in a callback to for_each_ref() and
> only emit ones which aren't hidden? Storing these and then recalling
> them after the fact is worth avoiding.

Sorry, I don't quite get what you're proposing. `for_each_ref()` already
does exactly that: it stores every reference that is not hidden in the
above `oidset`. This is the exact set of advertised references, which in
my example repository would be about 250k. This information is used by
git-receive-pack(1) to avoid announcing the same object twice, and now
it's also used to inform the connectivity check to use these objects as
the set of already-reachable objects.

Patrick

--stdC7xRx77pL9a5G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmNf35oACgkQVbJhu7ck
PpQU5xAAq8D2CxjvLYmEhiPHp5nm2c69qev8msB8MtZIJoXQg9g+2dAUq0rtzLnN
GqrLyzlmPiT8ZYPpSYQqcbvkEa3zYgMXMmD1qkvH/g4x99Va5HK61ECUi2fep4tr
+d38fPcEEa9eIT7FRCJpcNMEsTRXbpTvBPD1Wb2fSI9djQIjgzcxckAetvMAzcpr
pEeyNxPUs01NonjE9poEjhM5UYsq2LCkjUAGm58WLQPnixUVERzW7DB+uXI5K/3C
M8Ufejwy2jlTSqJZ1eAbSTCYT1GczwFaAWM0VLlHpAAAcFejfoLMxeYTwIkCWG+5
ZvEfIUZR2aVFBJfwk4D2eub/VGSWxPlV9DFuhVuijj1bk44vZ7BPGtw2+IJVuJy+
9qZyh5Xicqr9uII/eVhivITU/55T9wZ8ROXGg2o6BcMxQhMpKJwXWF9zjRJqGreQ
1XljwdpPgd+vHGzSXyTUYzro3zp3VAR+RJ5vAfT5/A6VKzH5wnrK2/zN2O9OY2tk
ztvKlLimdusCiPAs1M56S+ZCvtDNXO+i/8JIyn8iZQiPrCROTC88StzQgoK+0sB7
EIs0edl35aYodhjLgfiGZVG3i4GLYZ6wkDPsqM7Qo65N52O93a/PxEzMZQqJeSKi
rLNHF8KbLpRac2xR77wCZBrxT47mAMaigo5c4TiGSEQ89GggkG4=
=jG5O
-----END PGP SIGNATURE-----

--stdC7xRx77pL9a5G--
