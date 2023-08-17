Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD73EB64DD
	for <git@archiver.kernel.org>; Thu, 17 Aug 2023 10:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349552AbjHQKH6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Aug 2023 06:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349808AbjHQKHi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2023 06:07:38 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C02A2D61
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 03:07:35 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id D83B93200910;
        Thu, 17 Aug 2023 06:07:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 17 Aug 2023 06:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1692266852; x=1692353252; bh=Ev
        cdwN0SXx5Goz19j9ExypwIzlHbWzuw4mLrpwpVXW0=; b=CeeRMK22j5NNGWJrxv
        K3afaLXMvv1cDrdao58pZPLW+ZusoHqcAH5qpvXWIMKCKOEnNi6Ri3qFo7lLiRRw
        AdCcEtaEmqvtieRpLwPaFgbdNwT3x2NIa6d801XS4pvatMYlt30nFApFWb7ypB3s
        Yi8fS4IcUwMhwfpr1PYBALT8jIAWAXxiK+lx/W220sdQBlsr7FLqIqUJf142raYc
        z1BpNRV6g7NkshB7bv2msg3nmmt9khSb4kpLF/4Rl+25MSY2K7Y9IN4FkY/yafye
        3X/8QNucRE0R3kgEv2gOObw+OIOmDwBjOl24flMEYP8S62AhQDuFSqbT7DEky5rE
        x3cQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692266852; x=1692353252; bh=EvcdwN0SXx5Go
        z19j9ExypwIzlHbWzuw4mLrpwpVXW0=; b=dOxVgZVXdheUd80ikTNqy5Qn8J15I
        m+AlhLEWgHzcrx3ft+o+H1z+l+qgkNh7Ib840eNPP7Ld2x2z2Y4oJWtIfNjdqec+
        waA3td2yML/+XDadDWEgAgdo/xSBBlV+rgdSN3udBjA0A50/4enQxWp8e/KfmRNu
        gblwoO3HjsgrS5Q09KSdZqBlX50Si7mwtO9AicPoRVZYYka4Mi278OQTg1upjOEl
        LSDZKPgyVDg712IVsJ5GicU85e6Dv0j3HFbKWhOUheUKh/052pUKBd3+4EQPr8U3
        kXIv3u4M/QNfD0kDDywONI/0XP+tU1Rkhl808VjNdEfiukp9SgnOqZhKQ==
X-ME-Sender: <xms:Y_HdZL08fwE_17lk1cN8G6aK4QKAfaPR3yPC0a9CYavn5W1nLfgk1Q>
    <xme:Y_HdZKHG8B-hivna8T0_vx-MdTYS5MIsFZqP5-6xmntPpA09Zc5wdJVNcSTgrLki9
    fXPFHoYXtzVeFuImw>
X-ME-Received: <xmr:Y_HdZL6QxZ0yCmzLo-mdPGV-ozdUOmmamL7zCPmwKwidYfdArRL-f5VuAmVy_mrGUKRBC7McAbqgwoNtqFRZPMTV5pGeMhpDoAys4VkfclPO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudduuddgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Y_HdZA3BNCX47q9fPFTBAZfbnTw8bkn_igH8WkEqKLq1Iv0GanTjvQ>
    <xmx:Y_HdZOGkJ7fBqFsU93oT-ORcvIj5F6hEhWYhFFr7vx2UbX8tMzkwkQ>
    <xmx:Y_HdZB_2VTizgGwh-H85PhQ_2H1WDiddqusDtvj-VBAEe3j85U-0-A>
    <xmx:ZPHdZAMB7KTS6JuxnD6-oQuaZT6j5rnZocqsi7rmFT_sjbA_KFyB2Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Aug 2023 06:07:31 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 119d67b4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 17 Aug 2023 10:05:12 +0000 (UTC)
Date:   Thu, 17 Aug 2023 12:07:25 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org
Subject: Re: [PATCH] upload-pack: fix exit code when denying fetch of
 unreachable object ID
Message-ID: <ZN3xXfJEETBIn7nu@tanuki>
References: <pull.1572.git.1691678450757.gitgitgadget@gmail.com>
 <fe028981d353158e9840eb035194ca15e6a2c15e.1692165840.git.ps@pks.im>
 <xmqqjztvezen.fsf@gitster.g>
 <xmqq8rabey3v.fsf@gitster.g>
 <CABQH79pick0c1UVc+W8n2QtVmSJAjqXcJGtYSm0aahAFDNvE1g@mail.gmail.com>
 <xmqqa5uqckwd.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5zh88TAG0+cAaP0m"
Content-Disposition: inline
In-Reply-To: <xmqqa5uqckwd.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5zh88TAG0+cAaP0m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2023 at 10:12:18PM -0700, Junio C Hamano wrote:
> Derrick Stolee <derrickstolee@github.com> writes:
>=20
> [jc: the message I am responding to may not be on the list archive,
>  as it was multipart/alternative with text/html in it, but I think
>  the main point from you can be seen by others only from the parts
>  I quoted here].
>=20
> > While I don't think we should document that the exit code has
> > a special meaning for the builtin, adding the test will help
> > prevent another accidental change in the future. If the patch is
> > worth taking (to fix the accidental change) then I think the test
> > should stay, so we don't make this change accidentally again.
>=20
> I think my stance is a bit more nuanced, in that the first half of
> the patch to make us exit with 128 is worth taking, simply because
> we did not have to and did not intend to change the exit status, but
> the other half of the patch, using test_expect_code in the test
> suite, sends a wrong message that somehow exact value of non-zero
> exit status in this particular case matters.
>=20
> To put it another way, if your patch to shuffle the calls for two
> error messages, concluded with a call to exit(), were written in the
> ideal world, you would have passed 128 to exit(), *and* you wouldn't
> have added any test that says "fetch should exit with 128 and not 1
> when it fails".  I aimed to massage Patrick's patch so that the
> original patch from you will become that patch in the ideal world
> when it is squashed in.

I tend to agree with Derrick -- if we think that it is important enough
to restore the exit code, whether that change was intentional or not,
then I think it makes sense to also add a test. The benefit of that test
wouldn't be to say "This is cast into stone", but rather to indicate to
the developer that a change that they have just been doing has an
unintentional side effect.

The problem I see with my own stance though is that if you extend it to
the extreme, every single `test_must_fail` would need to do exact error
code checking. The benefit of this would be kind of dubious though as
long as we do not decide to attach meaning to specific error codes.

In general I often wish that we had better ways to transport the
circumstances of why a specific command has failed to the caller. In
Gitaly, we often have to fall back to parsing the standard error stream
of a command in order to figure out the failure cause, which does not
exactly feel great given that these are rather intended to be consumed
by a user rather than a program.

Whether that information should be transported via exit codes though...
I don't know. An exit code can only convey so much information and they
often feel fragile to me. Documenting them explicitly would of course
already go a long way, but that wouldn't quite help the fact that this
mechanism still can't convey more information than "The command has
failed because of a specific root cause". Many commands perform more
than a single unit of work though, so even if we know the root cause we
still wouldn't necessarily know where exactly it has failed.=20

One way to fix this would be to give commands a way to return structured
error data to the caller instead of relying on exit codes. But that is
of course a bigger topic, and I feel like I'm digressing.

Patrick

> > To my view, test cases can change in the future as long as
> > there is good justification in doing so. Having existing tests
> > helps to demonstrate a change in behavior.
>=20
> I agree with that 100%, but the thing is that the error shuffling
> patch will not escape 'next' until the upcoming release, at which
> time we can rewind and redo 'next'.  I think the first half of
> Patrick's fix would be a good material to squash into that patch,
> which would make the result identical to the one that would have
> been written in the ideal world I described above.
>=20
> And the other half would not have a place to be in that patch in the
> ideal world.  IOW, there is no "change in behaviour" we want to
> demonstrate here, as we will pretend nothing bad happened after the
> upcoming release ;-)
>=20
> Thanks.

--5zh88TAG0+cAaP0m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmTd8VwACgkQVbJhu7ck
PpRQvQ//eGfulRcm5FKsv2HgDZ83A/f+q5jzzvWT+OJxTEcGoJMlk4HNd3x766LK
+p+QoLNSGNA6RmkU3PyewU8PVoULNM/+9OzrpnCMMqlRvqOgRblo1IwigMO402fF
qYESiYF/mWDvNm073DGSJigH7gAKMX+wMIqWluhiNujhSub4iSdzdhKh5CMZaupn
Nta4uCbi2SPbZnwHBXdu0cJSrEkbmLzTTw3+0Yhbk5eDlBFkUW09vdhxTZmUm38j
bQng44N8jgWdh+2dUytPsmYlZ7uqXgo1zaOuX2D11bvrm3UwwUBh/YrGe6C2150Y
NG5VxtcducAGFKdsl39fDYl2OxEBEODMDWdlNmI479BaXt6cw0YWouKlrloVXyhz
kU7YXMw8LpyXwvL8ChIVYVj69hU/rY8m/X8fjUOC9/nbA0CfpILBZUrS+4tcugfA
/taRfYQR1cVKIqPHtEkgHRld1MnyC82clHXes9YsGUSOVLQ+iy1fOZ66XOc2ROio
WpE46ql21IqOQASeNrRN4eoBLn1tFCCyAj11NlJE5rfl6qpZl82Xbq7c9GCgNoqS
titU6ANftxuVcuKCV4DKKzqa7g3DQGcxHIJ4yT9REi3lnPDADqZTrROJWk4xi8Hj
Wfgivdp+pzxUSNR+JJ469LPLw0PTDPNylpeyLAxfS/FkO37PR+Y=
=3tG2
-----END PGP SIGNATURE-----

--5zh88TAG0+cAaP0m--
