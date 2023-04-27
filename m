Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792C8C77B61
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 10:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243403AbjD0K6c (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 06:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243283AbjD0K62 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 06:58:28 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4054644A0
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 03:58:27 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A88335C0227;
        Thu, 27 Apr 2023 06:58:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 27 Apr 2023 06:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1682593103; x=1682679503; bh=nZ
        jWK5mwhUIlJqghlk/YWX1f6Caj0f3ZLBp0rllNbRM=; b=qESP2aPKrOpRstMt29
        3zSVruub//3v9ZjnlSs49bgmpBm2sbQkCGYzdF64hUOMUVN7d+bLGuInyIAIjapd
        Z152TAv+GUaOSsEE4S1g2n08WLJaUJHSTZ5gnaMWYp4VF5Vt0EuKVJthXpb83dR3
        y5Ssk9JjF7v4mlEEUaEEK0adhQ2rtIYQGDPAS8id3iCLb2W0e0crXkr/t1XsnACx
        VJh6GY+N7OZjAizVY0UzkSltcFW2qA6joCL5r6f7HrOF2hHxOBFH5x5w0WQctVcg
        VwafcTb3NQF8Ibotk1yZjqXtUF0+JL65BH0rBLEGYQN44MpvQozVnYkp2LcbBdqv
        4gGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682593103; x=1682679503; bh=nZjWK5mwhUIlJ
        qghlk/YWX1f6Caj0f3ZLBp0rllNbRM=; b=iwtalm6DE7n3PbhL7+hKg16YZuSQk
        PHn4q8VIwvBHe0vIXrfgb1DQvh75NRh8SM9c9xCRK+rBn3ENorNa4OLvMH7vLlI0
        vCkSkinqpTGwioj9ZpSP8QM+DqDRvTLDqS2B4hA69J0qXZeo4JfdU8GsWLF3yRTh
        7mHkRCj8ig2IFMIU/hmBupfPWrGBHzB9k7DXJUTo1vBddy9Y6QjZtUiKK8XZJ7bM
        qWWIAOCY0NSGjBmOFfeNTZ5WALh1x4NoCdQWpniMbLT8ocHtEV6nS9K6SUjzSmz6
        v2B58lLtblMBZZmbs+MXrpQiFMXubljDvaC4vW3r/7mlLoW+s89k0AZPw==
X-ME-Sender: <xms:T1VKZCvTnT4Q-jAL9xb9R4O2fmC7WeBeOq6wvgJqVBi1K-K8BXmgLw>
    <xme:T1VKZHenhbKDDzq1krMkTwoRwNMpYlZVqhU9EvmqahAIIfjETiljNVA-znr9otsk5
    hqElHkn8TJrFG_hEg>
X-ME-Received: <xmr:T1VKZNyPcaIKyGDhVH_-hx87yMe7yuvp4Qn48_oVisqPdMG5r79nXjKM3JrMbttYzZT93ZWYGfOGEenh55Fh0xqsrv72TCxRve5gc0MOX4L1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeduiedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:T1VKZNNUTd29oNZqdH4BxyYn97fidRI9wyBpoWPMZpXUwG2gJtWTXw>
    <xmx:T1VKZC906hze-_M4P_st7OzNoy-ULgiIOwohpMBMYjp9vXsPbO6LTw>
    <xmx:T1VKZFVOcFKdq3RVc55Yy0GRstIwGLLiICguyurHIACcqjaXH8dlYg>
    <xmx:T1VKZIkHffmWDo7Q9WzdIXAdxGb8GvuG3_0oo2UFW4RakdQPxxSJjQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Apr 2023 06:58:22 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id a0aeee0d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 27 Apr 2023 10:57:51 +0000 (UTC)
Date:   Thu, 27 Apr 2023 12:58:18 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 8/8] fetch: introduce machine-parseable "porcelain"
 output format
Message-ID: <ZEpVSrz-uUcfN_3_@ncase>
References: <cover.1681906948.git.ps@pks.im>
 <301138da039451519c6e60d6126e7756a54d346f.1681906949.git.ps@pks.im>
 <kl6lzg6umne9.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rVH3rF8t4rz2BcEJ"
Content-Disposition: inline
In-Reply-To: <kl6lzg6umne9.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rVH3rF8t4rz2BcEJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 26, 2023 at 12:52:46PM -0700, Glen Choo wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > The output format is quite simple:
> >
> > ```
> > <flag> <old-object-id> <new-object-id> <local-reference>\n
> > ```
>=20
> This format doesn't show the remote name or url that was fetched. That
> seems okay when fetching with a single remote, but it seems necessary
> with "--all". Perhaps you were planning to add that in a later series?
> If so, I think it's okay to call the "porcelain" format experimental,
> and forbid porcelain + --all until then.

The reason is mostly that I didn't find an output format that I really
liked here. We'd basically have to repeat the remote URL for every
single reference: just repeating it once per remote doesn't fly because
with `--parallel` the output could be intermingled. But doing that feels
wasteful to me, so I bailed. I guess I'm also biased here because it
just wouldn't be useful to myself.

So with that in mind, I'd like to continue ignoring this issue for now
and just not report the remote that the ref came from. But I'd also
argue that we don't have to restrict porcelain mode to single-remote
fetches: it can still be useful to do multi-remote fetches even without
the information where a certain reference update comes from. So any kind
of restriction would feel artificial to me here.

Furthermore, I'd argue that it is not necessary to label the format as
experimental only because of this limitation. With the refactorings done
in this and the preceding patch series it is easy to add a new format in
case there indeed is somebody that would have a usecase for this. The
"porcelain" format should stay stable, and if we decide that we want to
also report the remote for each reference in a follow-up we can easily
add a "porcelain-v2" or "porcelain-with-remote" format.

As I said though: I'm clearly biased, so if you feel like my train of
though is simply me being lazy then I'd carve in and adapt.

> > We assume two conditions which are generally true:
> >
> >     - The old and new object IDs have fixed known widths and cannot
> >       contain spaces.
> >
> >     - References cannot contain newlines.
>=20
> This seems like a non-issue if we add a -z CLI option to indicate that
> entries should be NUL terminated instead of newline terminated, but that
> can be done as a followup.

Yeah, either via `-z` or a new porcelain output format. But both of
these conditions should generally be true anyway, so I don't see that
those should become a problem.

> > With these assumptions, the output format becomes unambiguously
> > parseable. Furthermore, given that this output is designed to be
> > consumed by scripts, the machine-readable data is printed to stdout
> > instead of stderr like the human-readable output is. This is mostly done
> > so that other data printed to stderr, like error messages or progress
> > meters, don't interfere with the parseable data.
>=20
> Sending the 'main output' to stdout makes sense to me, but this (and
> possibly respecting -z) sounds like a different mode of operation, not
> just a matter of formats. It seems different enough that I'd prefer not
> to piggyback on "fetch.output" for this (even though this adds more
> surface to the interface...).
>=20
> We could add --porcelain and say that "fetch.output" is ignored if
> --porcelain is also given. That also eliminates the need for
> --output-format, I think.

I was thinking about this initially, as well. But ultimately I decided
against this especially because of your second paragraph: we'd now need
to think about precedence of options and mutual exclusion, and that to
me feels like an interface that is less obvious than a single knob that
works as you'd expect.

> The .c changes look good to me.
>=20
> > +test_expect_success 'fetch porcelain output with HEAD and --dry-run' '
> > +	test_when_finished "rm -rf head" &&
> > +	git clone . head &&
> > +	COMMIT_ID=3D$(git rev-parse HEAD) &&
> > +
> > +	git -C head fetch --output-format=3Dporcelain --dry-run origin HEAD >=
actual &&
> > +	cat >expect <<-EOF &&
> > +	* $ZERO_OID $COMMIT_ID FETCH_HEAD
> > +	EOF
> > +	test_cmp expect actual &&
> > +
> > +	git -C head fetch --output-format=3Dporcelain --dry-run origin HEAD:f=
oo >actual &&
> > +	cat >expect <<-EOF &&
> > +	* $ZERO_OID $COMMIT_ID refs/heads/foo
> > +	EOF
> > +	test_cmp expect actual
> > +'
>=20
> As mentioned upthread, I think this test isn't needed because
> "porcelain" wouldn't run into the bug we are checking for anyway.

The only reason that the other bug was able to survive for so long was
that we didn't have test coverage there. So I think it makes sense to
explicitly test this, too, also because it causes us to walk a different
code path.

Last but not least: this test uncovered a segfault I had in a previous
version. So I'd rather keep it :)

Patrick

--rVH3rF8t4rz2BcEJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRKVUkACgkQVbJhu7ck
PpRV0hAAlcgsMeOtrqnL4zU4D8AGUyl3SqoU0aIUasp0Wa1ZxjAOu8GmDqLCDYY0
HEYtoguNxe2QSXkIIq06l2Qs2uxqQdb6hR/3JlmHz6LV3fpB+2p0lzB2lO+fptQE
nMG1aVAD9x8jNjxtnxu4u6PxB9K5dQLJAlncCxneGgUmWtDER4U1vDBaSp7YgLYI
sYLCJXyocbRgXlUy96bv8oX/DThrqeEQOhjYH5D/BePDbm7qrdGhIKb7YF2o3DTj
ahaAMuQ7v+YwmIq69ItApG6Jp4NoYTAMMSMDDwUOaTACPoP8luhYFsrA6h96bZw7
8AGTyvw5TmxvauSvKK8G67ZWAelu5i9ntHEz3/3xedBtxx9kiwwlIjCxyTvmU/Qo
1bxDReDnS3Ya4NYcMKIATI/1qI6qC1ZwD8eEwdlUHAXrmj0s2vit41RVrfGU8RZ1
/iCKUIk8UTAbMJPOHLYJB2Bu6RozVE3XWHVmUMeZ67k/PvdD7f7NdtWYcWtbxuoq
eLOQHEajZQvOE4MEgTfux4tr79+2KXZuBbbhoSWZgsspdUcStcppa9wTCjelWp4b
htiaFzsdKo/7qD4Ii26wk33zkDBSMkM9KfrckRIcrekik5UBTUWsZbk7t3+M45ff
bLzprTw2um3ETOGPoWqCif50vqHQnPSolJLoaUmVQwFFLC7YeSY=
=UFWz
-----END PGP SIGNATURE-----

--rVH3rF8t4rz2BcEJ--
