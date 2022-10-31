Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79671FA3741
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 14:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbiJaOVt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 10:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiJaOVp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 10:21:45 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBA41151
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 07:21:42 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 6FB6A320090F;
        Mon, 31 Oct 2022 10:21:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 31 Oct 2022 10:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1667226100; x=1667312500; bh=DV6NUilA4V
        jBcykr4RuhxdRV8Mcoxr+Xk7FwGSZaJfs=; b=LONvTZWLUNmT+He51aDrMBS/uc
        pMPEZkzgNNvJ0Lae3JG7YRXLLHfemecDpOL0YT+FnCErgTN4poFsUPyG+GHXp+P9
        e3gZ/2MmLu/fyo1ApZYkaEE4LeWLfSdQTWQVfKTiAnJgFuQTzX47Em38qA9XzvvE
        glqQMyn9okQ/aRGzDQXBvtChxSu9dxYmFCCwXoJkSrtZK1jwt1MGVRUjW4TA0qXt
        6a/5wBOdXri4xgaYqwNbMgwFARWMI0zwT9mTJY0T6PSZ56WslRb3hEVtV20lqfTj
        jTB5XoZVKHCi0xKOEDgm9KtlAi9O9qUYrWn9Yy6Y9L/ywtcGVWtu3C0WgJTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667226100; x=1667312500; bh=DV6NUilA4VjBcykr4RuhxdRV8Mco
        xr+Xk7FwGSZaJfs=; b=MeqSzF3AM0qnB/1oARSrNWQs9qiOqZQWL14poIgJieGU
        6tkTmwXVd8l7Ogbg4OlJWRFyFdOSfwr7o0UuL+AEgay2OaLUlTIaHYUq53Ix8VSc
        E6IvqvEYh+MqSOPQ95ogi3SzS5ziFkRUVRyswUarDchazht/+Hv5oteGJc7slxLn
        Dtg9NwJIs8bjXVf+rlDJqjLCXUgga4p06l1v6KMKU7fY8rYpBHMHSjObUmqA5MQu
        Pai89Bwj8sfw0EVvbpIdcW5HDNWHPWU7ClJ7SohqxOyDy3diPBzo8nzRpQ48cZsA
        +MMLHPkK6foYv/OntkXNwr4jDNzW8xWkVOmYCV3OcQ==
X-ME-Sender: <xms:89lfY86uOSoMbXiXZffh2WqNWKcmn13ZMl1Q6sn3Ta-y_vVrvIUUBw>
    <xme:89lfY96det9ISSr0QjJOu0sHvFYjigeBZzFWWymVUWqbgD5tUtTOVClx9oCZ1WlLm
    wsDPMlTiTaaNDt_EQ>
X-ME-Received: <xmr:89lfY7cDE1W1MZNW4bVDWW-go1PbWI5CtL5Mb-44s5D8bCMirwDQ5Ut6SCoUDzdEPwtM2cc-awtBG8BqFag-nJs2ws7NQqtWvmNiIBYdJnQe2Xk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrudefgdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepteeuvefhhfdufedvgeeiueeileegtdfhge
    eftdeuveejjedtgfejhedujeeutddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:89lfYxJrBrJ34llBuDrXbpu21f281sOSnrH9dRojcKrk5LzVhsUIAA>
    <xmx:89lfYwKHyR0amLjrDSnXOIlPgj3ytrYJ6PmF5Q8iTW0TIHEmfDdh2w>
    <xmx:89lfYyzk2HCTl8kHnI2Jyz_Pw3_EVgdsEw8wFYi2j_t6VniYCPMthg>
    <xmx:9NlfY6xAgiHfdvURw74GpP2ELojfTR1mwkMLptq8z2nmD7jesTrSfA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Oct 2022 10:21:39 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 539c1a16 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 31 Oct 2022 14:21:23 +0000 (UTC)
Date:   Mon, 31 Oct 2022 15:21:34 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] receive-pack: use advertised reference tips to
 inform connectivity check
Message-ID: <Y1/Z7q+56Mu+rmAX@ncase>
References: <cover.1666967670.git.ps@pks.im>
 <006e89f384be1227b922fb6fdc8755ae84cac587.1666967670.git.ps@pks.im>
 <221028.867d0k7yny.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kI22Xl6lemr7snWw"
Content-Disposition: inline
In-Reply-To: <221028.867d0k7yny.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--kI22Xl6lemr7snWw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 28, 2022 at 05:01:58PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bjar=
mason wrote:
> On Fri, Oct 28 2022, Patrick Steinhardt wrote:
[sinp]
> > Unfortunately, this change comes with a performance hit when refs are
> > not hidden. Executed in the same repository:
> >
> >     Benchmark 1: main
> >       Time (mean =C2=B1 =CF=83):     45.780 s =C2=B1  0.507 s    [User:=
 46.908 s, System: 4.838 s]
> >       Range (min =E2=80=A6 max):   45.453 s =E2=80=A6 46.364 s    3 runs
> >
> >     Benchmark 2: pks-connectivity-check-hide-refs
> >       Time (mean =C2=B1 =CF=83):     49.886 s =C2=B1  0.282 s    [User:=
 51.168 s, System: 5.015 s]
> >       Range (min =E2=80=A6 max):   49.589 s =E2=80=A6 50.149 s    3 runs
> >
> >     Summary
> >       'main' ran
> >         1.09 =C2=B1 0.01 times faster than 'pks-connectivity-check-hide=
-refs'
> >
> > This is probably caused by the overhead of reachable tips being passed
> > in via git-rev-list(1)'s standard input, which seems to be slower than
> > reading the references from disk.
> >
> > It is debatable what to do about this. If this were only about improving
> > performance then it would be trivial to make the new logic depend on
> > whether or not `transfer.hideRefs` has been configured in the repo. But
> > as explained this is also about correctness, even though this can be
> > considered an edge case. Furthermore, this slowdown is really only
> > noticeable in outliers like the above repository with an unreasonable
> > amount of refs. The same benchmark in linux-stable.git with about
> > 4500 references shows no measurable difference:
>=20
> Do we have a test that would start failing if we changed the behavior?
> Perhaps such a test is peeking too much behind the curtain, but if it's
> easy come up with one I think it would be most welcome to have it
> alongside this.  to have exposes

We have tests that verify that we indeed detect missing objects in
t5504. But what we're lacking is tests that verify that we stop walking
at the boundary of preexisting objects, and I honestly wouldn't quite
know how to do that as there is no functional difference, but really
only a performance issue if we overwalked.

> > -static void write_head_info(void)
> > +static void write_head_info(struct oidset *announced_objects)
> >  {
> > -	static struct oidset seen =3D OIDSET_INIT;
> > -
> > -	for_each_ref(show_ref_cb, &seen);
> > -	for_each_alternate_ref(show_one_alternate_ref, &seen);
> > -	oidset_clear(&seen);
> > +	for_each_ref(show_ref_cb, announced_objects);
> > +	for_each_alternate_ref(show_one_alternate_ref, announced_objects);
> >  	if (!sent_capabilities)
> >  		show_ref("capabilities^{}", null_oid());
>=20
> Nit: The variable rename stands out slightly,
> i.e. s/&seen/announced_objects/ not s/&seen/seen/, especially as:
>=20
> >  static void execute_commands(struct command *commands,
> >  			     const char *unpacker_error,
> >  			     struct shallow_info *si,
> > -			     const struct string_list *push_options)
> > +			     const struct string_list *push_options,
> > +			     struct oidset *announced_oids)
>=20
> Here we have the same variable, but now it's *_oids, not *objects.

Hm. I think that `announced_oids` is easier to understand compared to
`seen`, so I'd prefer to keep the rename. But I'll definitely make this
consistent so we use `announced_oids` in both places.

[snip]
> > +static const struct object_id *iterate_announced_oids(void *cb_data)
> > +{
> > +	struct oidset_iter *iter =3D cb_data;
> > +	return oidset_iter_next(iter);
> > +}
> > +
>=20
> Is just used as (from 1/2):
>=20
> > +	if (opt->reachable_oids_fn) {
> > +		const struct object_id *reachable_oid;
> > +		while ((reachable_oid =3D opt->reachable_oids_fn(opt->reachable_oids=
_data)) !=3D NULL)
> > +			if (fprintf(rev_list_in, "^%s\n", oid_to_hex(reachable_oid)) < 0)
> > +				break;
> > +	}
>=20
> After doing above:
>=20
> > +	if (oidset_size(announced_oids) !=3D 0) {
> > +		oidset_iter_init(announced_oids, &announced_oids_iter);
> > +		opt.reachable_oids_fn =3D iterate_announced_oids;
> > +		opt.reachable_oids_data =3D &announced_oids_iter;
> > +	}
>=20
> But I don't see the reason for the indirection, but maybe I'm missing
> something obvious.
>=20
> Why not just pass the oidset itself and have connected.c iterate through
> it, rather than going thorugh this callback / data indirection?

This is done to stay consistent with the way new tips are passed in via
the `oid_iterate_fn`. I'm happy to change callers to just directly pass
a `struct oidset *` though.

Patrick

--kI22Xl6lemr7snWw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmNf2e0ACgkQVbJhu7ck
PpSseQ//XH6iJh1wtxYmO7BgCvk4P4rMpAO+301U/+HIBU9SSpA9+MZ/v/0KDzhz
fhdF3LSAFOuIbaYvSxZNINGd+wFtlIMmyzmImLiYjhkIoM52Q+T2FmCwP3OZEdr9
KKStrHCLwk6TXtlHX1EjWmNuQ8lwY4LSP4oS8JUcFjQ+IYEn2gYKaTOobLx8bCVw
mCN7gCX0NQQ5P41ELKJ20lzbPKnyXNClGTvXzcGkdoQ4YjtzpU1MrAwD470t7nUN
JJjsOBcLrr6w+w31m0feQ5jn611sFrwQdWcThwlX43jvc3uPMk9u4N2BPLsE4owi
4LkJQOEqzU/JJ2o7VHQRxt0Naq03KrVrcvAeyOPjXhrrz+wFjvm5bVdaiekOHNq7
Lnt7srC6K5d/IDV8JAuIToHK3surXvlo21qqrOJ6SPH3+ZcpLNtnvUq9pDFkZR7D
m6FXH96Nk/KbiaQD0RY4/w4aVa2Rdb6yuwUEQWtNSgY3QC4Z2wpnO9AuJp9K0Pbl
FdGP6SP+xTDtUel4UDTcalu4w4Gvi1W3S0xMe36BZ/Fi+JaoAEM8zQa29Npi8Gh8
Il51zM+zAt5thk8DreTmmJEmJCCuucC1YAEpbKIjJ1c63pq0xboXBrQcu1Ri8W+i
BFWovzJCjlSZk3d+QmClBvLtqO2UUXt8KVT/TwOydMXJJZa219g=
=v74I
-----END PGP SIGNATURE-----

--kI22Xl6lemr7snWw--
