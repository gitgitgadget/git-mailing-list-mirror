Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB34C4708D
	for <git@archiver.kernel.org>; Wed,  4 Jan 2023 14:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239545AbjADO5Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Jan 2023 09:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239574AbjADO5O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2023 09:57:14 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5133219A
        for <git@vger.kernel.org>; Wed,  4 Jan 2023 06:57:08 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id A2A5B5C008F;
        Wed,  4 Jan 2023 09:57:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 04 Jan 2023 09:57:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1672844227; x=1672930627; bh=DWspxhUlCj
        0vn2bhHQUgh8cGvZtvR910xYNNLeC1wBE=; b=N+pVL+nHWlKqZPgnTs6eESiqsD
        JfnU0X5+vLSKaNlWeVGGk8e0J65oKqda1lLw8f4xXG8b9ZTWQkgeDcwE/nmaai0F
        38zeOc5gsZ9z5gD+F/T7UMODkNm7+xvdjfyLxXgxGnl2LJh24hNUcKb6NgxbId+X
        mgv8o3KHMCgljSFa7S5PocSSmxxqUSc7x8y62Yavsia5SnXK54I+lo0vTc3RvVEV
        EeMVoN1vTuJfnOGpSi6WEqnejEkG+gNphLX33bA5QVWBcKOJxqNeIcaQQy1R+4JS
        5QTqTWwwsKISeaC36D76o3PRbuaZ3igC+KqFN350YKa8kNDm2Gf195COs4uA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1672844227; x=1672930627; bh=DWspxhUlCj0vn2bhHQUgh8cGvZtv
        R910xYNNLeC1wBE=; b=HI6fp73bMInM72bqyvrabbq+sIVLOpLZJVwIql3TI2/b
        M2e/duV5KAq+7LagNQyQCqCx3m3s6L5tE2g6FsdaRFuTzCstTkNbjJsc3trcMmL9
        ejP+xXcjX8TDvAsaaloRtRRMEZL6Efp/Wc3Fw7tlupkq8UZTX12sc4ry8DA3G1av
        T72WA7t/CXiuxOH7HVyKVwLT8iJOT0StjHRVGytL+TDwAmeOvmia78NwVtC+RXmZ
        xeGHhPAI2WMC+9WCPE0qnzbW3CMmbdqj0XFv7JoRNhOki6f+U7a3FQvJzTtLWIBQ
        LUW5cfLFzPCyu75TVkkLdEExNoIYIvXO3w6xk8rz6Q==
X-ME-Sender: <xms:w5O1Y2pks_n4786AHwPUvE2p0oiWAOOpR-zH0AtvPgwNE9q4oasfAw>
    <xme:w5O1Y0oZR0Nb1rXxzR-a7SwvrS_UDhUa3WnzYygNj1bE4KLy-y2FGGSlBfxqT7clH
    _n9BgoPhk0C9okpmg>
X-ME-Received: <xmr:w5O1Y7OYlvlMeHfKdosO5h7xdpjTWOcTBMW9T02_Ewy8zFUfbDmBG3hepZUked3DKZilTGzp40laL3rfx96NUXLicM9FwKHS4hYWXV06NRkM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeeigdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:w5O1Y15CN9ZYmVNFuHDPEMr5mc_j8N4nDX5RFzWqYUVzSKiRjeHL3A>
    <xmx:w5O1Y156E8rYi3859NeXWHagvNrEtVBS9R2Dt47HVeIipqrAcIaYeA>
    <xmx:w5O1Y1gqyl3qhDk8QuVO4ATF2cPOn5S4tFzqXMoPsY2DC2e_khOizQ>
    <xmx:w5O1YwaKMctBuMMRSCDY0-EhqlqA0boe2ph2o963A2Uf7rX98Ph5_Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jan 2023 09:57:05 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id c080f99e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 4 Jan 2023 14:56:55 +0000 (UTC)
Date:   Wed, 4 Jan 2023 15:57:03 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 3/3] gc: add gc.repackFilter config option
Message-ID: <Y7WTv19aqiFCU8au@ncase>
References: <20221122175150.366828-1-christian.couder@gmail.com>
 <20221221040446.2860985-1-christian.couder@gmail.com>
 <20221221040446.2860985-4-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+bkngFv0+fRK+m8I"
Content-Disposition: inline
In-Reply-To: <20221221040446.2860985-4-christian.couder@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--+bkngFv0+fRK+m8I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 21, 2022 at 05:04:46AM +0100, Christian Couder wrote:
> A previous commit has implemented `git repack --filter=3D<filter-spec>` to
> allow users to remove objects that are available on a promisor remote
> but that they don't want locally.
>=20
> Users might want to perform such a cleanup regularly at the same time as
> they perform other repacks and cleanups, so as part of `git gc`.
>=20
> Let's allow them to configure a <filter-spec> for that purpose using a
> new gc.repackFilter config option.
>=20
> Now when `git gc` will perform a repack with a <filter-spec> configured
> through this option and not empty, the repack process will be passed a
> corresponding `--filter=3D<filter-spec>` argument.
>=20
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/config/gc.txt |  9 +++++++++
>  builtin/gc.c                |  6 ++++++
>  t/t6500-gc.sh               | 19 +++++++++++++++++++
>  3 files changed, 34 insertions(+)
>=20
> diff --git a/Documentation/config/gc.txt b/Documentation/config/gc.txt
> index 38fea076a2..9359136f14 100644
> --- a/Documentation/config/gc.txt
> +++ b/Documentation/config/gc.txt
> @@ -130,6 +130,15 @@ or rebase occurring.  Since these changes are not pa=
rt of the current
>  project most users will want to expire them sooner, which is why the
>  default is more aggressive than `gc.reflogExpire`.
> =20
> +gc.repackFilter::
> +	When repacking, use the specified filter to omit certain
> +	objects from the resulting packfile. WARNING: this could
> +	easily corrupt the current repo and lose data if ANY of the
> +	omitted objects hasn't been already pushed to a remote. Be
> +	very careful about objects that might have been created
> +	locally! See the `--filter=3D<filter-spec>` option of
> +	linkgit:git-repack[1].

This limitation means that no user can ever configure this unless they
also set `gc.auto=3D0`, or otherwise Git might periodically delete their
local objects without any way to restore them.

I see though that this might be a useful thing to have for partial clone
repositories: right now they only ever grow in size, so it would be nice
if Git could gracefully cull that size every now and then. But for this
to be automatic I'd expect a few safeguards:

    - Given a remote with a partial clone filter we only ever delete
      objects that seem to exist on the remote. This might for example
      be determined via a graph-walk of the remote's references. This
      protects against deleting objects that only exist locally.

    - Objects that are referenced by any of the currently checked-out
      HEADs should not get puned. This protects against deleting objects
      that you'd have to re-download anyway.

    - It would be great to have a grace period after which objects get
      pruned. Given that we have no access times for packed objects
      though this doesn't seem that easy to implement though. Still,
      this would protect the user from objects getting deleted when they
      frequently switch between different commits.

=46rom my point of view we should not expose a high-level interface around
git-gc(1) at this point in time because of these missing safeguards.
Otherwise it is only a footgun waiting to go off.

Until then I don't see much of a problem with exposing the low-level
interface via git-repack(1) though.

Patrick

>  gc.rerereResolved::
>  	Records of conflicted merge you resolved earlier are
>  	kept for this many days when 'git rerere gc' is run.
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 02455fdcd7..bf28619723 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -52,6 +52,7 @@ static timestamp_t gc_log_expire_time;
>  static const char *gc_log_expire =3D "1.day.ago";
>  static const char *prune_expire =3D "2.weeks.ago";
>  static const char *prune_worktrees_expire =3D "3.months.ago";
> +static char *repack_filter;
>  static unsigned long big_pack_threshold;
>  static unsigned long max_delta_cache_size =3D DEFAULT_DELTA_CACHE_SIZE;
> =20
> @@ -161,6 +162,8 @@ static void gc_config(void)
>  	git_config_get_ulong("gc.bigpackthreshold", &big_pack_threshold);
>  	git_config_get_ulong("pack.deltacachesize", &max_delta_cache_size);
> =20
> +	git_config_get_string("gc.repackfilter", &repack_filter);
> +
>  	git_config(git_default_config, NULL);
>  }
> =20
> @@ -346,6 +349,9 @@ static void add_repack_all_option(struct string_list =
*keep_pack)
> =20
>  	if (keep_pack)
>  		for_each_string_list(keep_pack, keep_one_pack, NULL);
> +
> +	if (repack_filter && *repack_filter)
> +		strvec_pushf(&repack, "--filter=3D%s", repack_filter);
>  }
> =20
>  static void add_repack_incremental_option(void)
> diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
> index d9acb63951..b1492b521a 100755
> --- a/t/t6500-gc.sh
> +++ b/t/t6500-gc.sh
> @@ -56,6 +56,7 @@ test_expect_success 'gc -h with invalid configuration' '
>  '
> =20
>  test_expect_success 'gc is not aborted due to a stale symref' '
> +	test_when_finished "rm -rf remote client" &&
>  	git init remote &&
>  	(
>  		cd remote &&
> @@ -202,6 +203,24 @@ test_expect_success 'one of gc.reflogExpire{Unreacha=
ble,}=3Dnever does not skip "e
>  	grep -E "^trace: (built-in|exec|run_command): git reflog expire --" tra=
ce.out
>  '
> =20
> +test_expect_success 'gc.repackFilter launches repack with a filter' '
> +	test_when_finished "rm -rf server client" &&
> +	test_create_repo server &&
> +	git -C server config uploadpack.allowFilter true &&
> +	git -C server config uploadpack.allowAnySHA1InWant true &&
> +	test_commit -C server 1 &&
> +	git clone --bare --no-local server client &&
> +	git -C client config remote.origin.promisor true &&
> +	git -C client rev-list --objects --all --missing=3Dprint >objects &&
> +	test $(grep -c "^?" objects) =3D 0 &&
> +
> +	GIT_TRACE=3D$(pwd)/trace.out git -C client -c gc.repackFilter=3Dblob:no=
ne -c repack.writeBitmaps=3Dfalse -c gc.pruneExpire=3Dnow gc &&
> +
> +	grep -E "^trace: (built-in|exec|run_command): git repack .* --filter=3D=
blob:none ?.*" trace.out &&
> +	git -C client rev-list --objects --all --missing=3Dprint >objects &&
> +	test $(grep -c "^?" objects) =3D 1
> +'
> +
>  prepare_cruft_history () {
>  	test_commit base &&
> =20
> --=20
> 2.39.0.59.g395bcb85bc.dirty
>=20

--+bkngFv0+fRK+m8I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmO1k74ACgkQVbJhu7ck
PpR9Ng/+LGIEYl5cG4mvHbKU/4AiY6UuaiJ+M83YSbSofFGoGUH1E8ubpYqtShVf
gTmTWPICHQ6J72oP6mjTxTemXuEitYwxfXOMWMKe7ZYfQ8TLNa12FerON2WHkjeI
CRnUPvTMtjeexN6J5STkRInCrcfKzvzIisYFjjsAsFvGphJiSPj9ogGkVvNvxhrA
65X24GUhQA9PSjKXK29aELhPTS/QtqQcUXzoQNy+mVVOPnTdlDrz3UCsDmVm0hS0
RiBl+Xni/dHsclIR/C4nRxb/RF1eAAuEwc9S8mQP3GmQRKAzQsY+mWHVNazsdNMO
noXf6xpn8lYtMjxx8ZR3cU+bk6tC52au5V1P6GRB/L6y+F6df7ct99o4o0m/8FQF
hzeJoNnAqwEyWApy1TZ58itVrWPzRIO/EFvXkTZWDpbUEYtKammOrKTe+SCJEPpG
2Y5HzWNonrsaR6IuJiNzswYcd3Qq9dN+okW9WtqcS4IVSZKoD7lZ+fwPo/qtEpo3
XwNAC3I4bmYvrbnMK+JAhbGmWpu9sHHM46DIdKmtj0umjtCjS54cykAOxeNwfVv3
+DRxlCEVF5f5I8Ce3uWq4vivXW+oaFR7UNEZLCl2SQ+GCnBxzKSmEiqysSlpteti
lkqvc4P7+Jm6E6YSkh2hF1XXTESV2TNO3M9PlxNdRJFF7ia6sUY=
=CUdX
-----END PGP SIGNATURE-----

--+bkngFv0+fRK+m8I--
