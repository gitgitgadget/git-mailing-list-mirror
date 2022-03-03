Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AE9C433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 06:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiCCGoS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 01:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiCCGoR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 01:44:17 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABB015C9F8
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 22:43:32 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 6FB675C0163;
        Thu,  3 Mar 2022 01:43:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 03 Mar 2022 01:43:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=EH+Oh9D/5edBK9WamWPXWL3k7otR9VCwNhXXd1
        KoFrE=; b=sWf/vjG0d3kXbOXopvM1lCFBVsdj4qf/ddd9BakQVQ9Gh8KY3dvzQQ
        E0mz6HpPYahXR02/F8M+e+ZcEBZxz0AUNphIuPJFYwZKZs2+bdnb2G8vRtwBZgbo
        4/Hekk3ZFb5mcQfbQ1U15JHrDN1K/oDuQ1tjwkSNvP6edsyr9CiXC8d3s7CnMr+k
        KMA/U21vEU4LjvvzHqK/JgVOhnaPqDtt9oWluQ+lxQpmya9ajstWUNIiLBpfUvwR
        n6t9aHn/+BCyoKinykz8HqdIlMVEQIB7Co8UcRUJZUn/Nk9kHXGRlmpwHTy712yn
        A52nh0tHW5Nw49WFw+5uMvkCPW9SUn2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=EH+Oh9D/5edBK9Wam
        WPXWL3k7otR9VCwNhXXd1KoFrE=; b=CypCVUVpHYeizboItsPaF70EDSl59k6qO
        ezxTJWb8Ix6BUkSXfYJFD16RwOVIIZ/pVZjT8gcc5DBRnLyEcXR6lyhp4wnQRl2H
        WYN8OJ56RUnM/UhaRq4nOzJDasbuOpMAf+j8W8d+gfGAYxh9kGVdSsNJ2IydLMTT
        4lZu7OjOcM0aOWB9Jbi75q8lKXv2Q40ksd9FnwsWUzjbYxmPmUYp5vy19qi84jVr
        k5MOP4u2j+8ZNplAjskPj9PFrufhtG9t/lZJsgcfGaM000YEuIs/bKQpJY7tw4P/
        Wovekrv1Mg9dbea2G431DTEazhUSf8q/Lx2XikRwizDc0SGW+9NYw==
X-ME-Sender: <xms:k2MgYvxMiF1F9EJ6LSpb5m65_Cl2C_ASSK4EXYBe_VXAX0bx7WiA9A>
    <xme:k2MgYnRLeRCVYohCOPIpthpN4DwxEJjWfldtopiDGLzN7zFWY7pJv7lZh5QILnvZi
    DaV8XX8LYRlIUsCYw>
X-ME-Received: <xmr:k2MgYpWwvxs9iFUSNqk7uQpuOuUWUksTtbvZIXmLSjbr2oVCoL2-u2OLpVWAdktxfTp74vF1aMu5r7X0fv9IKPa2GWSwN5AGGGwrQfZ6WCKGmFPe6KHyt85dFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddthedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:k2MgYph5g02UGV33PfYcRmDEptBSzxRXJrIQ2RvKBGTIOVPIBi9gug>
    <xmx:k2MgYhAanUTGkFIoP61b7qnlWtApgc_vLh3qq4FtNYFoCFNTZ4AyBQ>
    <xmx:k2MgYiIV9cN4VcWXLyWQRM9JlDX35v2KV5f55lRGpOH-HXucSqXDaA>
    <xmx:k2MgYgM9SowG9j3Lqb2DToe08TikdlB5Xfg8MotizhzDjG8xCz37UA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Mar 2022 01:43:30 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 77434313 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 3 Mar 2022 06:43:26 +0000 (UTC)
Date:   Thu, 3 Mar 2022 07:43:25 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 1/7] fetch: increase test coverage of fetches
Message-ID: <YiBjjV6Kw2KHsMxq@ncase>
References: <cover.1645102965.git.ps@pks.im>
 <cover.1645430423.git.ps@pks.im>
 <081174b7a00cf094a7dacd8aba89fb137ea40f66.1645430423.git.ps@pks.im>
 <xmqqsfrzev2d.fsf@gitster.g>
 <xmqqo82neuz3.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="L+PJid8CCX5seYbn"
Content-Disposition: inline
In-Reply-To: <xmqqo82neuz3.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--L+PJid8CCX5seYbn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 02, 2022 at 04:32:48PM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> >> +test_expect_success 'backfill failure causes command to fail' '
> >> +	git init clone5 &&
> >> +
> >> +	write_script clone5/.git/hooks/reference-transaction <<-EOF &&
> >> +		while read oldrev newrev reference
> >> +		do
> >> +			if test "\$reference" =3D refs/tags/tag1
> >> +			then
> >> +				# Create a nested tag below the actual tag we
> >> +				# wanted to write, which causes a D/F conflict
> >> +				# later when we want to commit refs/tags/tag1.
> >> +				# We cannot just `exit 1` here given that this
> >> +				# would cause us to die immediately.
> >> +				git update-ref refs/tags/tag1/nested $B
> >> +				exit \$!
> >> +			fi
> >> +		done
> >> +	EOF
> >
> > I think I've reviewed the previous round of these patches in
> > detail.  I by mistake sent a comment for this step in v2, but I
> > think the same puzzlement exists in this round, too.
>=20
> Namely:
>=20
> I have been wondering if we need to do this from the hook?  If we
> have this ref before we start "fetch", would it have the same
> effect, or "fetch" notices that this interfering ref exists and
> removes it to make room for storing refs/tags/tag1, making the whole
> thing fail to fail?
>=20
> > +				exit \$!
>=20
> In any case, "exit 0" or "exit \$?" would be understandable, but
> exit with "$!", which is ...?  The process ID of the most recent
> background command?  Puzzled.

Oof, this was supposed to be `exit \$?`, thanks for catching this. But
your above comment is right: we can indeed just create the D/F conflict
outside of the hook and thus avoid the hook script altogether. Thanks!

Patrick

--L+PJid8CCX5seYbn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIgY4wACgkQVbJhu7ck
PpRQ/w/9G9CfvygPHSrvRHOZrQ2OeMdl5wAXHGUYELjCLwvEmnu3TEy1XWqLcQe5
u0KQPYpJJ0VbWnfuhJYPwwpuwXshGthFx2//BhJoGDV8WlR8X2XSxdJvJp1P7/8R
YrYxsKwb0w4h3qWBP2MnK442Q4HN7Pl6n30uBR0Poimg81tPVW5HQBxmJEXk9E6l
y4UEUQfsCUy7hb7KmJSlK3XD8N3zxs5TgrQ1GLYYVed/nbBthrvEbfq8zeLujKdm
/oQTVckwpBUE1iknevVhSxIXGjQZZck43SzHqH8TyVPCh4fJzVa85nKQ1saLxiCS
tTYnrdmphVIJRhc73ejLq2IGTGf+y/STiXXprSATOwZg0i1G5MEwMV4MOJEBOxzI
W7vuADpEBaR45aNds5B2lsMDeVrYv3ZucqBcRHCzft85BJbQi8P3Bl2nSECyibxh
vheC2XFnkc7Zrj2WnOpEYb3H88ZFePZkUSGwRVOMfnyc7QesXjigRI7LbB2iovNL
zrVgUi/sIEhHrXkkRhkJNZcrN8gu9iV2HLV+xLvNo6worjvKHcZ/gWNIaT8GnET9
7pSWsYSXZdN/LsgGeQ4jypzY8FVDVoa8SWA2Sq0n5fIm7TUq9UT6KZeNmULZN/b4
CQX5mfsrg+nsMgDtRD+wL/4u5gJXvfyFgC82nX4gqyzkfqqyN5s=
=P32g
-----END PGP SIGNATURE-----

--L+PJid8CCX5seYbn--
