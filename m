Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E2AC433DB
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 10:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B5D520B1F
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 10:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbhAKKnC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 05:43:02 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:57603 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726734AbhAKKnC (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Jan 2021 05:43:02 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 2ED2F2554;
        Mon, 11 Jan 2021 05:42:16 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 11 Jan 2021 05:42:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=FobFz63xFkHMLd4F5iPIwZyaJPV
        90pv2wyXkaTDTXVo=; b=MWL1uRwDVPFviWnenJ58vXi9ygF1HyxiBSyyrEDecLa
        n7DXH2gwu4KzgtqyIQ7UljcNNFfhcyXpbxQbXOQpKZ0sYVYxgwKlHs7w9f2TRAF0
        YtisnDV4PJl3AgvI0YIRGnI1WIurWqCL5YUrRi7jZovSSdlMqmTfibZWPVaJFTU+
        EwlRY+ZECrplWSIcLxpIhdOi39kVvJmoaBbHSucKh2TBVmVhjjK8/LdR98+dJFcV
        k/R323py3NME1w5a8dmnjjWpgeIbxht5hA8NwQG+lVyhkwuIDK9EYwuUyiuyZIy8
        5KKwVPQe+wNXobFijMSiQofBGzCS4FwVFADfoH6vDOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=FobFz6
        3xFkHMLd4F5iPIwZyaJPV90pv2wyXkaTDTXVo=; b=LCEPFKIYCGrn1PS67h3MNV
        +NzNVH1gcrzSSnSO2zHjQBYcq84oz9OTrzFmjfNSqyGCRI6BVo4AigxzUP2g7OKD
        AxjhgW6zQKsE4QxDd6EEbAXYPkORZaTWDMio5nIYy1mVIuZLR611D4gIVTHlbFGx
        eiJu/32xPHfmeZdTJ1Gq/uY7+JYxwl2Yp3GSFIj7GWib3mAgUleb2RpuGST0/uhF
        PF4O3OUm4Aga9Zc8reiHdfXTGclHwI5nt7IcSs3PKOiNa1zakMKFIudwfgmD1OxI
        YLo4iH6Htb6ueNKPYxrFKpJ4kPLN8cIjR8RX/I0qC+Un2DAOfzw24DPzA4L3J81w
        ==
X-ME-Sender: <xms:hyv8X1BSz-ueGtjPObAlJLIZGDm44_wJE3HoMojuA35sty0Qj7QvRA>
    <xme:hyv8XzgI8DSAR_THU8oZhhhKR3EmIr65AtjmygJv9iMYuUcQ8Arw07Z_qwfwGCjOf
    t1XZcV1FYEgGdxpgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdehuddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepkeelrddugedrgeehrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:hyv8Xwkolkz6XXqkNXa97QKGlO_9NT1PKcyJTOqgHDvWN_Cf3ZwQtA>
    <xmx:hyv8X_yNFn_2jcMb0WUIJjt4vsDgVnSLv2cssHoterZIlK9JAHfMnw>
    <xmx:hyv8X6Sgvgi9vVRXUDEYP4u1hUvDiVFB2XIC2UK5Yv51vpbvR_omEQ>
    <xmx:hyv8Xz7d0qqoPS4BiwP7a0ZWSfC3-r7nbbyVh6FouOuajeqXiS4ezQ>
Received: from vm-mail.pks.im (dynamic-089-014-045-170.89.14.pool.telefonica.de [89.14.45.170])
        by mail.messagingengine.com (Postfix) with ESMTPA id C5E691080063;
        Mon, 11 Jan 2021 05:42:14 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 0d5f5e15 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 11 Jan 2021 10:42:10 +0000 (UTC)
Date:   Mon, 11 Jan 2021 11:42:09 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 4/4] fetch: implement support for atomic reference
 updates
Message-ID: <X/wrgYYcZfYZj+4/@ncase>
References: <cover.1610027375.git.ps@pks.im>
 <cover.1610107599.git.ps@pks.im>
 <53705281b60285837905137f45fc8607012d2f19.1610107599.git.ps@pks.im>
 <xmqq7dongeji.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XBypyAU1GVfIXQWD"
Content-Disposition: inline
In-Reply-To: <xmqq7dongeji.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--XBypyAU1GVfIXQWD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 08, 2021 at 04:05:53PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > +	/*
> > +	 * When using an atomic fetch, we do not want to update FETCH_HEAD if
> > +	 * any of the reference updates fails. We thus have to write all
> > +	 * updates to a buffer first and only commit it as soon as all
> > +	 * references have been successfully updated.
> > +	 */
> > +	if (atomic_fetch) {
> > +		strbuf_addf(&fetch_head->buf, "%s\t%s\t%s",
> > +			    old_oid, merge_status_marker, note);
> > +		strbuf_add(&fetch_head->buf, url, url_len);
> > +		strbuf_addch(&fetch_head->buf, '\n');
> > +	} else {
> > +		fprintf(fetch_head->fp, "%s\t%s\t%s",
> > +			old_oid, merge_status_marker, note);
> > +		for (i =3D 0; i < url_len; ++i)
> > +			if ('\n' =3D=3D url[i])
> > +				fputs("\\n", fetch_head->fp);
> > +			else
> > +				fputc(url[i], fetch_head->fp);
> > +		fputc('\n', fetch_head->fp);
> > +	}
>=20
> I do not want to see it done like this; formating what ought to come
> out identical with two separate mechanisms will lead to bugs under
> the road.
>=20
> Also what is the deal about "\n" vs "\\n"?  Do we already have
> behaviour differences between two codepaths from the get-go?

Good point. I'll unify those code paths.

> It would be much more preferrable to see this series go like so:
>=20
>     [1/4] create append_fetch_head() that writes out to
>           fetch_head->fp
>=20
>     [1.5/4] convert append_fetch_head() to ALWAYS accumulate in
>             fetch_head->buf, and ALWAYS flushes what is accumulated
>             at the end.

This is a change I'm hesitant to make. The thing is that FETCH_HEAD is
quite weird as the current design allows different `git fetch --append`
processes to write to FETCH_HEAD at the same time. If we change to
always accumulate first and flush once we're done, then we essentially
have a change in behaviour as FETCH_HEADs aren't written in an
interleaving fashion anymore, but only at the end. Also, if there is any
unexpected error in between updating references which causes us to die,
then we wouldn't have written the already updated references to
FETCH_HEAD now.

So I'm all in when it comes to merging formatting directives, even more
so as I have missed the "\\n" weirdness. But for now, I'll keep the
current flushing semantics in the non-atomic case. Please let me know if
you're not convinced and I'll have another look for v4.

> After these two patches are applied, there shouldn't be any
> behaviour change or change in the format in generated FETCH_HEAD.
>=20
>     [2/4] and [3/4] stay the same
>=20
>     [4/4] this step does not touch append_fetch_head() at all.  It
>     just changes the way how fetch_head->buf is flushed at the end
>     (namely, under atomic mode and after seeing any failure, the
>     accumulated output gets discarded without being written).
>=20
> I also thought briefly about an alternative approach to rewind and
> truncate the output to its original length upon seeing a failure
> under the atomic mode, but rejected it because the code gets hairy.
> I think "accumulate until we know we want to actually write them out"
> is a good approach to this issue.
>=20
> Thanks.

Patrick

--XBypyAU1GVfIXQWD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/8K4AACgkQVbJhu7ck
PpRVRhAAme5On+A81BAlfOZKgaBd4CxHRjHc8uW+jK9XInM8TGpEcjXOgsEfFLXc
Dcn5JWU4054HvCQAow6nrnTYXvsjggUjz0FRUoiolMiMmACaLASZdy708zgqQg0W
LmdBQB+seFvsq1mXSX15GuHDdPUlQyJVE4y6xQFnD4d4Kgw/QgApyR0ZBbBa7Is9
znFuZLcqemAI+Z1jv5PZJ4Zf2gvQguoV9NX/kmXF1z95Tz44aBjJ67aFiIwAc1x1
qhGwn1vBDJhdVdykW11m+O9dDDkGXoBZkXpcX9DFWT1eYbww3/kt34olKqDhS3c8
oA1kRS7S0CNLzhT123Swr3FQ/g/Py95i5VDlTaaPVDkSFlCC4hRUfO9gggQgX685
p+B1HMqRQxL9Lnkye3G9W9uFfZKzb2bOe0bjHe14icv6KjCtkpD3gPGZRpEwbxou
DfqNSdiCkCsP4jTp8pXmp8U8L3bSSUx6MAhFmXEP+WhzQmOvFxAWE56zILcXUjqL
57isKieBkU1o0VIBOXgOcOJcwMKAVkV5ZFKgXHn63CW2c7brwfWwfQ912n/va7iH
feduG1IVjOiTTRD9XzUHV8PxTHfs2Zqq/ESLYJ3PQH9iMa4OkngWHzICzN80xjGu
9JU6eTxKTe6NNUit1UDgfFiwvjrq5UVZqgo5VV5pp01IRiB4Slw=
=yeMj
-----END PGP SIGNATURE-----

--XBypyAU1GVfIXQWD--
