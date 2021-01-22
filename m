Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E351BC433E0
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 06:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9747323122
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 06:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbhAVGqL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 01:46:11 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:43083 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726757AbhAVGqI (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 22 Jan 2021 01:46:08 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 53865189B;
        Fri, 22 Jan 2021 01:44:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 22 Jan 2021 01:44:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=rVDs26HqCvqKRK5W0jvGGQiW0zr
        RWdL9UUlNsSraltY=; b=Xthla7bvHOrB/cqoUUzNHjZXX9uD6kpum9PIPeoNYP4
        LPcivOGjZLnnChHgcR5sPqh5z5zt04MsOoGoTT2uRqmVr4O2GBeF8ep/m4dM+n3A
        5hFBRjOVxJzGpzwR4cs0indGpALzfLP/ceTwf78/Q/VCQVNUOYtF7WDZp/GF3ybI
        IYAqcPDRcZt9TfG57Aye3eLonA9L0oZQXt0D/s6ncgICe6dapTfPsNJcwTSPq8s1
        B280J7rdvXBEyqBs0CuDSpuIbpWCKegPhii25wgRDIg2PZq2MiHgg2qx2R4jyLPx
        0Y5AKxs5bgBoDVQYLwdiQxwFyd7qdEx9XVnI75LN9Lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=rVDs26
        HqCvqKRK5W0jvGGQiW0zrRWdL9UUlNsSraltY=; b=dChoE2QkPZtyu05A7Csj1Q
        LsMygNcpchI92/Mm1kS9MT7JSyeT9xe8AguciMVEs2brhsOncPHEc8zq4FapiViw
        2g6RZVEtLxvsFThHVWjOWXvNe2PzMpJUDbvx4562gOQP43GjoP5P7QDseP5U9laT
        p4GPIePxVE0wPPKnIbTCFVcSGJ3vjpLwuJSWtjUKLDL7qND0e6LsZrvBr4no3B+v
        McvzfJClWwnB9Nr/yIydYkjqGWHi/8Opt8QndcDz9f5Cp0dG0PcmHHUYiL257ije
        Oe9Jleg/N8TSM7bpCMsw1z89HIAheodpwoZb0WZa67fyePLW9h+BQU3YVpJNKssA
        ==
X-ME-Sender: <xms:aXQKYIA0suIYz00cg4XVbm-E6ZZLmDungG5DeWL0xafMohDUulCX2w>
    <xme:aXQKYKh2AU8shctjCXABJjTwIkDACpX2lEMNWh7hmf7ALczaamb1OrvyieBH9yU1C
    NXnMa1ii3DhslPe8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudehgddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecukfhppeekledrudegrdehuddrfeejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himh
X-ME-Proxy: <xmx:aXQKYLnNev7ruxmxX4atQvcxNuM8NdjaJw0ESppYQs8MOJRxOYOtZQ>
    <xmx:aXQKYOw5jQg4dSbH3D1rXYKG9AwkhjNFeREbmXhyBCUQG-SqWkQJ0A>
    <xmx:aXQKYNR1_8-t9MkDoPx1MGL5vtD0vLTjZH8dpZy78dPh2OeJRKTdmQ>
    <xmx:aXQKYMIWod848lEGhdv3sazuQ20BaX83m3Ecs9xq87b88WE9W2oJuQ>
Received: from vm-mail.pks.im (dynamic-089-014-051-037.89.14.pool.telefonica.de [89.14.51.37])
        by mail.messagingengine.com (Postfix) with ESMTPA id C773624005B;
        Fri, 22 Jan 2021 01:44:56 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 76de0e8e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 22 Jan 2021 06:44:53 +0000 (UTC)
Date:   Fri, 22 Jan 2021 07:44:51 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com
Subject: Re: [PATCH RESEND] refs: Always pass old object name to reftx hook
Message-ID: <YAp0Y3rHty7itayo@ncase>
References: <d255c7a5f95635c2e7ae36b9689c3efd07b4df5d.1604501894.git.ps@pks.im>
 <ae5c3b2b783f912a02b26142ecd753bf92530d2f.1610974040.git.ps@pks.im>
 <xmqq4kjdkgol.fsf@gitster.c.googlers.com>
 <YAfNcyZ7mj4J69XT@ncase>
 <xmqqft2wgk9k.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uPHmuySv5gxp1Y1X"
Content-Disposition: inline
In-Reply-To: <xmqqft2wgk9k.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--uPHmuySv5gxp1Y1X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 19, 2021 at 11:06:15PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> >> Even without this change, the current value the hook can learn by
> >> looking the ref up itself if it really wanted to, no?
> >
> > I think the biggest problem is that right now, you cannot discern the
> > actual intention of the user because the information provided to the
> > hook is ambiguous in the branch creation case: "$ZERO_OID $NEW_OID $REF"
> > could mean the user intends to create a new branch where it shouldn't
> > have existed previously. BUT it could also mean that the user just
> > doesn't care what the reference previously pointed to.
>=20
> Yes, it can mean both, but when you pretend to be that hook,
> wouldn't you check if the ref exists?  If not, the user is trying to
> create it, and otherwise, the user does not know or care what the
> original value is, no?

As long as you're aware as the script author, yes.

There is one gotcha though: you can verify the state when the
reference-transaction hook gets invoked in the "prepared" state, as it
means that all references have been locked and thus cannot be changed by
any other well-behaved process accessing the git repository. In
"committed" or "aborted" that's not true anymore, given that the state
has changed already, so any locks have been released and it's impossible
to find out what happened now.

> > The user could now try to derive the intention by manually looking up
> > the current state of the reference. But that does feel kind of awkward
> > to me.
>=20
> So in short, with respect to the OLD slot, there are three kind of
> end-user intention that could be conveyed to the hook:
>=20
>  (1) the user does not care, so 0{40} appears in the OLD slot here,
>  (2) the user is creating, so 0{40} apears in the OLD slot here, and
>  (3) the user does care, and this is the OID in the OLD slot,
>=20
> And (1) and (2) cannot be separated without looking at the ref (in
> other words, if the hook really cares, it can find it out).
>=20
> But if you replace 0{40} with the current OID, then you are making
> it impossible to tell (1) and (3) apart.  The hook cannot tell the
> distinction even if it is willing to go the extra mile.
>=20
> So that sounds like a strict disimprovement to me.

True.

> If you can invent a way to help the hook to tell all three apart, I
> am very much interested.  It would earn you a bonus point if you can
> do so without breaking backward compatibility (but I doubt that it
> is possible).

I did think about any way to do this, but wasn't yet able to find one.
And doing it in a backwards-compatible way is probably going to be
impossible. One idea I had is to use something similar to the
peeled-format we use in packed refs in case the actual change is
different from the user-provided change. E.g.

    0{40} <new> <ref>
    ^<old>

or

    0{40}^<old> <new> <ref>

That can be considered as backwards-incompatible though.

> > To me, having clearly defined semantics ("The script always gets old and
> > new value of the branch regardless of what the user did") is preferable
> > to having ambiguous semantics.
>=20
> But "The script always gets old that was given by the user and the
> new value to be stored" is very clearly defined semantics already.
>=20
> On the other hand, "The script gets a non-NULL object name in both
> cases, either when the user says s/he does not care, or when the
> user insists that the old value must be that, and it is not just
> ambiguous but is impossible to tell apart" is worse than just being
> ambiguous.

Yup. Whatever we agree on, what is clear is that the documentation needs
to be more specific here.

Patrick

--uPHmuySv5gxp1Y1X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmAKdGMACgkQVbJhu7ck
PpSadQ/9G6k/ie02RPWx2GqJIMhk4BBSNOF/9gbNTIyYH1bK0kEhPpPkzjC7OvVP
dLy8MhVQeqyKZ2/VIbhslTybHrc6wQWEyJpePYtvOMZ67lP67QN0bC5Ob0cYhiw0
VhEofHM+tmNmMO9f7u2WBcQ18hOyJWqmoVYwEhKrNuNZGPWrrUOSUu24BZcwVTog
LBcNl0MfM/XX15IZ4zuVjrgKfnO8LXoZAMgQLpv2lpVE3vUaPBhO5/7vRfANBG00
PV8QIiuf7SSLzFTC8YUd+q6+LNEFe176HzOwLGcXmaCATt4vXXwmfdN/grFs2y1O
rbtUAfP0uAHnJDrX1lKtEnlUrrK5JD5Jn4HhhgPAUrzcXsXMT+qlQYBJKr9jwrfz
z5vhDR2Jp+L3TlNFp6UHXD4vyZ6WdQHtNMI5tcgZhe7tu6GL1L7KmGAZrPDlcwuj
ZqkumZqBStxI4sAws1ai7uxBdQQdg5YkbFlShcYDTdWyuVrk3p3xfNkEtdZbmHL+
3o9d1HojnuwiiF0LojWFLzaspehyMcWrNzynIQAbbrHA8JzT6CU2gLyFKWu/+MKX
qqj7JatwdQhtaQ6/TUlZgAwY2/t7E4UICmoVYhzjiOxbEJv5CL02UtLDrUS2hxdq
7g+1ZOWCDvIhlcfQd8F87Wxzu/JZ3zsT5+nsNBqyhNKixDumVc8=
=PScF
-----END PGP SIGNATURE-----

--uPHmuySv5gxp1Y1X--
