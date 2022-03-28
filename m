Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B65CC433EF
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 10:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240403AbiC1K6t (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 06:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240386AbiC1K6r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 06:58:47 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2451541B7
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 03:57:06 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 8AD255C005A;
        Mon, 28 Mar 2022 06:57:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 28 Mar 2022 06:57:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=VupMCY1B9upoEJ81/EZfk08ekcqnD4SHrFRIFo
        Xcy88=; b=dv8g6QvcwPOO8ah18c/loPY23wT46f9PXggQXY+ewYU7S6Pt41Dvmf
        LrNB1GVNbDMHeOZ/5ANyAPCLAaNJ5AAazFDVBYrRTh9+zG2f5NLfaz78iuGZT3rX
        4Z55tK8Ly+EhYv1cS6qi7OYMupv6QycfnoLDd9jPHtrMCHsX+MdpwnrkwpKi9trQ
        V7xZWpB82SY3eTTUttTx5V6O7kwP8EPDo2wBR5RIRrVLaO3rF/70FX+cotM2BC0O
        94/2I9DsBhoy+HgcMn7lOOPRLb1/tI+eYONKtK2lu7g+26KTuXGaHxFd8dsmBo+w
        0iDC1eImOSdtwyKOaJbIP6VerTaQC/tQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=VupMCY1B9upoEJ81/
        EZfk08ekcqnD4SHrFRIFoXcy88=; b=Q4kME2YNU9CbLyuzwB1PlAYm5p/GNpiEB
        o7Ufjo2Fntc43+Mt25d/d6kzWmIZlc/ih10VNrL+f2g7PE7WrSx3HJXQiUEGX1Xy
        zM531LX6BG/6614TqpiTw4KfKF9g64tfpKy5VJOLCf9VLSm4e8oELx0DTkpeUrdE
        1pOkb9qVy0OOuzu59ojHbpUQj/LFM1d5rtXMRYgH/l4mgR6jitwiqN/wvaQENf77
        yqaYWx7t6iWi7b96vE1zNZDuUC5rGqdnwGUG9n33NDH1TG+9vzfseh1lP+WkrPN1
        oFJP+lqPrI4A3aHR15PA5X59MxIq/GFoZ7YFW+8fk0eWZ2l08TwQA==
X-ME-Sender: <xms:gJRBYuFJ6hZA5UNxQlU7jdgv4imXcimywhB9y4Zx29Cp1CntwsEKxw>
    <xme:gJRBYvW2g8F9RHm-8RntrIrz3oN8LZE-0okq4rdI7YTDfQaKfVClYlwlpTfr12yxu
    jmrYDvpmRHHYE9kkQ>
X-ME-Received: <xmr:gJRBYoJcsdISRN1PYRXegPpY4mBOT_CKqjFtKFZicJK8qsLQ9kCFa-bINkLXTttpaqYn8UdRQC_FWzNX6D-U3CmZShq7peWBEJAi0tEpu1AAt0YNW2cnRa4o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudehjedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeefiefhtdfhffelgeefffdtleeffedujeefgeekieeitdfhudekieekjeehleevvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:gJRBYoGbXFcCgZQXXK0VifOaV1lVHrIfaYVj5CfY0SIzGejMt5wHjw>
    <xmx:gJRBYkXgU9tgRRI6htAl5SlTkIksc1Kwpf0edkXptROMoXrqftBm2g>
    <xmx:gJRBYrMXt9Qp-IYqZTYAyPwTlekd4xSzJpTlOA8R5WW5nFQlXiA2JQ>
    <xmx:gJRBYoppWMTw6S8q4aBAPWkkO6pu5dF_hD_bTFh_SobIYVQ_kKfB2w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Mar 2022 06:57:02 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 4d333be6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 28 Mar 2022 10:56:58 +0000 (UTC)
Date:   Mon, 28 Mar 2022 12:56:57 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Neeraj Singh <nksingh85@gmail.com>,
        "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git List <git@vger.kernel.org>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: do we have too much fsync() configuration in 'next'? (was:
 [PATCH v7] core.fsync: documentation and user-friendly aggregate options)
Message-ID: <YkGUeQH4y1KIAdCc@ncase>
References: <7e4cc6e10a5d88f4c6c44efaa68f2325007fd935.1646952205.git.gitgitgadget@gmail.com>
 <20220315191245.17990-1-neerajsi@microsoft.com>
 <220323.86fsn8ohg8.gmgdl@evledraar.gmail.com>
 <CANQDOdeeP8opTQj-j_j3=KnU99nYTnNYhyQmAojj=FZtZEkCZQ@mail.gmail.com>
 <220326.86ils1lfho.gmgdl@evledraar.gmail.com>
 <CANQDOdeduc8bFA_=R-kXmkM+nb__oTxVhjBfFYj70vCFew1EyA@mail.gmail.com>
 <220326.86sfr4k9rm.gmgdl@evledraar.gmail.com>
 <CANQDOdfWh5aO9cuJVuUccKyD9Cj+NndisokiewBH9Sq4oSUp5A@mail.gmail.com>
 <220327.86y20veeua.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zKtI1SDb5HFwElqb"
Content-Disposition: inline
In-Reply-To: <220327.86y20veeua.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--zKtI1SDb5HFwElqb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 27, 2022 at 02:43:48PM +0200, =C6var Arnfj=F6r=F0 Bjarmason wro=
te:
>=20
> On Sat, Mar 26 2022, Neeraj Singh wrote:
>=20
> > On Sat, Mar 26, 2022 at 8:34 AM =C6var Arnfj=F6r=F0 Bjarmason
> > <avarab@gmail.com> wrote:
> >>
> >>
> >> On Fri, Mar 25 2022, Neeraj Singh wrote:
> >>
> >> > On Fri, Mar 25, 2022 at 5:33 PM =C6var Arnfj=F6r=F0 Bjarmason
> >> > <avarab@gmail.com> wrote:
> [...]
> >> > I want to make a comment about the Index here.  Syncing the index is
> >> > strictly required for the "added" level of consistency, so that we
> >> > don't lose stuff that leaves the work tree but is staged.  But my
> >> > Windows enlistment has an index that's 266MB, which would be painful
> >> > to sync even with all the optimizations.  Maybe with split-index, th=
is
> >> > wouldn't be so bad, but I just wanted to call out that some advanced
> >> > users may really care about the configurability.
> >>
> >> So for that use-case you'd like to fsync the loose objects (if any), b=
ut
> >> not the index? So the FS will "flush" up to the index, and then queue
> >> the index for later syncing to platter?
> >>
> >>
> >> But even in that case don't the settings need to be tied to one anothe=
r,
> >> because in the method=3Dbulk sync=3Dindex && sync=3D!loose case wouldn=
't we be
> >> syncing "loose" in any case?
> >>
> >> > As Git's various database implementations improve, the fsync stuff
> >> > will hopefully be more optimal and self-tuning.  But as that happens,
> >> > Git could just start ignoring settings that lose meaning without tyi=
ng
> >> > anyones hands.
> >>
> >> Yeah that would alleviate most of my concerns here, but the docs aren't
> >> saying anything like that. Since you added them & they just landed, do
> >> you mind doing a small follow-up where we e.g. say that these new
> >> settings are "EXPERIMENTAL" or whatever, and subject to drastic change?
> >
> > The doc is already pretty prescriptive.  It has this line at the end
> > of the first  paragraph:
> > "Unless you
> > have special requirements, it is recommended that you leave
> > this option empty or pick one of `committed`, `added`,
> > or `all`."
> >
> > Those values are already designed to change as Git changes.
>=20
> I'm referring to the documentation as it stands not being marked as
> experimental in the sense that we might decide to re-do this to a large
> extent, i.e. something like the diff I suggested upthread in
> https://lore.kernel.org/git/220323.86fsn8ohg8.gmgdl@evledraar.gmail.com/
>=20
> So yes, I agree that it e.g. clearly states that you can add a new
> core.git=3Dfoobar or whatever down the line, but it clearly doesn't
> suggest that e.g. core.fsync might have boolean semantics in some later
> version, or that the rest might simply be ignored, even if that
> e.g. means that we wouldn't sync loose objects on
> core.fsync=3Dloose-object, as we'd just warn with a "we don't provide this
> anymore".
>=20
> Or do you disagree with that? IOW I mean that we'd do something like
> this, either in docs or code:
>=20
> diff --git a/config.c b/config.c
> index 3c9b6b589ab..94548566073 100644
> --- a/config.c
> +++ b/config.c
> @@ -1675,6 +1675,9 @@ static int git_default_core_config(const char *var,=
 const char *value, void *cb)
>  	}
> =20
>  	if (!strcmp(var, "core.fsync")) {
> +		if (!the_repository->settings.feature_experimental)
> +			warning(_("the '%s' configuration option is EXPERIMENTAL. opt-in to u=
se it with feature.experimental=3Dtrue"),
> +				var);
>  		if (!value)
>  			return config_error_nonbool(var);
>  		fsync_components =3D parse_fsync_components(var, value);
> @@ -1682,6 +1685,9 @@ static int git_default_core_config(const char *var,=
 const char *value, void *cb)
>  	}
> =20
>  	if (!strcmp(var, "core.fsyncmethod")) {
> +		if (!the_repository->settings.feature_experimental)
> +			warning(_("the '%s' configuration option is EXPERIMENTAL. opt-in to u=
se it with feature.experimental=3Dtrue"),
> +				var);
>  		if (!value)
>  			return config_error_nonbool(var);
>  		if (!strcmp(value, "fsync"))

Let's please not tie this to `feature.experimental=3Dtrue`. Setting that
option has unintended sideeffects and will also change defaults which we
may not want to have in production. I don't mind adding a warning in the
docs though that the specific items which can be configured may be
subject to change in the future.

At GitLab, we've got a three-step plan:

    1. We need to migrate to `core.fsync` in the first place. In order
       to not migrate and change behaviour at the same point in time we
       already benefit from the fine-grainedness of this config because
       we can simply say `core.fsync=3Dloose-objects` and have the same
       behaviour as before with `core.fsyncLooseObjects=3Dtrue`.

    2. We'll want to enable syncing of packfiles, which I think wasn't
       previously covered by `core.fsyncLooseobjects`.

    3. We'll add `refs` to also sync loose refs to disk.

So while the end result will be the same as `committed`, having this
level of control helps us to assess the impact in a nicer way by being
able to do this step by step with feature flags.

On the other hand, many of the other parts we don't really care about.
Auxiliary metadata like the commit-graph or pack indices are data that
can in the worst case be regenerated by us, so it's not clear to me
whether it makes to also enable fsyncing those in production.

So altogether, I agree with Neeraj: having the fine-grainedness greatly
helps us to roll out changes like this and be able to pick what we deem
to be important. Personally I would be fine with explicitly pointing out
that there are two groups of this config in our docs though:

    1. The "porcelain" group: "committed", "added", "all", "none". These
       are abstract groups whose behaviour should adapt as we change
       implementations, and are those that should typically be set by a
       user, if intended.

    2. The "plumbing" or "expert" group: these are fine-grained options
       which shouldn't typically be used by Git users. They still have
       merit though in hosting environments, where requirements are
       typically a lot more specific.

We may also provide different guarantees for both groups. The first one
should definitely be stable, but we might state that the second group is
subject to change in the future.

Patrick

--zKtI1SDb5HFwElqb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmJBlHgACgkQVbJhu7ck
PpSayRAAod4JGEJnA7hZRWnlpGG268DFOPAGo15m+YuRaVu6CB8KcIp73LyX/gVG
A31NwCjby4y8STOGBnf7xYLMeAylgZOBXEeGvUDRC//OGDCjWaGbIF4K3VLhOTOg
LfwrRf45uLWHrMfYk44gzC24iGN3ZZyB3eSMJgdoHU4+CIwj1UkPNlVuQa3ymC/C
08cy2Kz1jMfCWhWJwlCsoPK+LKbU8pDx4FWwSPXqqTLyBEEdOLyPVaL/ZIkwZYdK
fAr548RLuRSs5Ooa1cd0fGE3SBfTjTmx+Fn0FqYEk3rn9YHMfQ+bYRlKK6r2ON39
ssPDWArCI5p6k5NX6vcEceslBJSkcP966lQwEfG2zRpGPUAYwqXXZS0HlIZ8A5gf
twtTIz+PXObo4bUwAqgxi+Ig//LmWQwEHVxnfX/aWKJ2XCeGxOaM1j2NoEAgguLW
l67pamGDxGYe/VLfRl7hibMY2aBzp5tYLDcrUQuHlWM9jnG9QAXe2L39pQw5aoZS
H6GFPgel4a/zQ6UHKVPSRUcBEl3QSUNoQy6yvYZtnRe0FXaEkuwkDg4D9lcnGxDa
+aDwyip19D4Xh5xlY0HiAykxSSedFsWLTfeimbbNfmm1plKty6iIvD5hhNeSrVUo
7QzsF+xOUaP7HTakTbHKcPAJioF2uWRCik3asdVWQ77sPk+HpDU=
=utvk
-----END PGP SIGNATURE-----

--zKtI1SDb5HFwElqb--
