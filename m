Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF7AC43219
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 14:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235481AbiCAOyn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 09:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbiCAOyj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 09:54:39 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EB190CE2
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 06:53:53 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 1FB485C019C;
        Tue,  1 Mar 2022 09:53:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 01 Mar 2022 09:53:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=QvIFw/2QF/GcaGpjotBAEGS2RlhCH/Ow10sCWl
        3YdZQ=; b=LzadvyhNQm/ZYGr3JiyaQBbvJvLJjXWYM33EpELbln+vvN7TXHCjnO
        CNDeKW1Z12D78YkZLbXmBQXZCWx5RrifBseWos7jzYI+cVkkBHaGzvdd/UTNwGse
        RIyl87P6bgXHgkUfXt1UYVuE/vBCUg/lWxUvyuqdmooUOn7AEXcYLDcHfwM9RGa6
        Fkg1lTMU5kGagioDpReomUHSt3wJdSrplOnc0kDHwp2t7QL2KAfFUNKZQxcWOhQa
        BdCcAHJxJVlrfGmnA5DJ36vE9b/EprW8piFJI+R7QikgVMbeENzLVL2oZab3+b6E
        3dohheL1g86Qgqb4zk7qN7AfzkAkyyMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=QvIFw/2QF/GcaGpjo
        tBAEGS2RlhCH/Ow10sCWl3YdZQ=; b=ZRQaQNlbwHkgTIhSyV/JpIeQcWcklAhY5
        ypJugrDYP5o9sEy+hVJOrv4Zm/e4GDCh23yG8zA6Kjp2si7L7ADV3XsL05osvA7K
        Q6k1sA9OzmDyORYn906W7T95HyAA6tprjG5Gjkv/bBHOhX80G+/DiwZdBPFg6I52
        LPrDpVN1wW0HhCAOp819ZD1e7BHb5LMZQh8j9W6GSGn2rPS4xarUhwV+97NhaOPS
        J+TjL1sqg1urMIUc+UUYXqP2yKyPiK4BpHya3+8sFZ9NV/CH9y1eBWmo3R8ftJOW
        BMwLE0V4l8G7D5Z83WQoNmkA3/nMOs9T5R2rBk4L9LgWk7u7KhLuA==
X-ME-Sender: <xms:fjMeYnM9vbkVJZv6iyeJA37k_NHJkqVbh4yvn_5KTO-X2LTJSoJZ4w>
    <xme:fjMeYh-YwsK-0TWPm3Gcs1U62tBRh5rdAJGsBtCyWMQDo9KZ5EnCqivdQT-MM-hbI
    aF34bkvNtCgys6bow>
X-ME-Received: <xmr:fjMeYmT3etfYjYPS0KAzGdK9UICUe9pkX5CMBQ_8_WRSorej5qCkCX6ZxjWpdKoZnilPvdmA9nLPZTdY12q-is2NMzAKjplgRAbzF3llIIIUid-CM4NLyAEK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtvddgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeejjedtiefggeekgfejheevveejjeevuedvtdeikeffveelgeelhffggfejjeeffeen
    ucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:fjMeYruZskbTVCk6lJMXT4RVSFwNDrhoREQ1_JyxPNJ0o5n3t11vNg>
    <xmx:fjMeYvc60a6aWlfMEoRkoAG3GK1UfPUgBQy-XqRJE_ScWhG8XZM-IA>
    <xmx:fjMeYn2hqniHohwYxDGKSyOshHeS2lctO5GZgbDQTK3ut7s6H0jpqg>
    <xmx:fzMeYm4Jbf19WEErRBL2IjfWi-QlI_ESPOzqjjVxWRgzUF9ZJ39zxg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Mar 2022 09:53:49 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 44ee843c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 1 Mar 2022 14:53:47 +0000 (UTC)
Date:   Tue, 1 Mar 2022 15:53:46 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        abhishekkumar8222@gmail.com
Subject: Re: [PATCH 3/7] commit-graph: start parsing generation v2 (again)
Message-ID: <Yh4zehdSnHLW1HuK@ncase>
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
 <a3436b92a32f7f6dd02ad61eb2337a4d088d5e9c.1645735117.git.gitgitgadget@gmail.com>
 <YhzkdMxrIGlNutr6@ncase>
 <e29ec01f-3039-6992-8ade-800ad32fcf34@github.com>
 <Yhz/hsDDGNVjt64R@xps>
 <dbb59fe7-4918-50ef-33a6-79eb430445e8@github.com>
 <Yh3rZX6cJpkHmRZc@ncase>
 <Yh325v3RBDMxjFnD@ncase>
 <f50e74f0-9ffa-f4f2-4663-269801495ed3@github.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="24ofu4b8itBCqgXy"
Content-Disposition: inline
In-Reply-To: <f50e74f0-9ffa-f4f2-4663-269801495ed3@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--24ofu4b8itBCqgXy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 01, 2022 at 09:06:44AM -0500, Derrick Stolee wrote:
> On 3/1/2022 5:35 AM, Patrick Steinhardt wrote:
> > On Tue, Mar 01, 2022 at 10:46:14AM +0100, Patrick Steinhardt wrote:
> >> On Mon, Feb 28, 2022 at 01:44:01PM -0500, Derrick Stolee wrote:
> >>> On 2/28/2022 11:59 AM, Patrick Steinhardt wrote:
> >>>> On Mon, Feb 28, 2022 at 11:23:38AM -0500, Derrick Stolee wrote:
> >>>>> On 2/28/2022 10:18 AM, Patrick Steinhardt wrote:
> >>>>>> I haven't yet found the time to dig deeper into why this is happen=
ing.
> >>>>>> While the repository is publicly accessible at [1], unfortunately =
the
> >>>>>> bug seems to be triggered by a commit that's only kept alive by an
> >>>>>> internal reference.
> >>>>>>
> >>>>>> Patrick
> >>>>>>
> >>>>>> [1]: https://gitlab.com/gitlab-com/www-gitlab-com.git
> >>>>>
> >>>>> Thanks for including this information. Just to be clear: did you
> >>>>> include patch 4 in your tests, or not? Patch 4 includes a fix
> >>>>> related to overflow values, so it would be helpful to know if you
> >>>>> found a _different_ bug or if it is the same one.
> >>>>>
> >>>>> Thanks,
> >>>>> -Stolee
> >>>>
> >>>> I initially only applied the first three patches, but after having h=
it
> >>>> the fatal error I also applied the rest of this series to have a loo=
k at
> >>>> whether it is indeed fixed already by one of your later patches. The
> >>>> error remains the same though.
> >>>
> >>> Thanks for this extra context. Is this a commit-graph that you wrote
> >>> with the first three patches and then you get an error when reading i=
t?
> >>>
> >>> Do you get the same error when deleting that file and rewriting it wi=
th
> >>> all patches included?
> >>>
> >>> Thanks,
> >>> -Stolee
> >>
> >> Yes, I do. I've applied all four patches from v2 on top of 715d08a9e5
> >> (The eighth batch, 2022-02-25) and still get the same results:
> >>
> >>     $ find objects/info/commit-graphs/
> >>     objects/info/commit-graphs/
> >>     objects/info/commit-graphs/graph-607e641165f3e83a82d5b14af4e611bf2=
a688f35.graph
> >>     objects/info/commit-graphs/commit-graph-chain
> >>     objects/info/commit-graphs/graph-5f357c7573c0075d42d82b28e660bc3ea=
c01bfe8.graph
> >>     objects/info/commit-graphs/graph-e0c12ead1b61c7c30720ae372e8a9f98d=
95dfb2d.graph
> >>     objects/info/commit-graphs/graph-c96723b133c2d81106a01ecd7a8773bb2=
ef6c2e1.graph
> >>
> >>      $ git commit-graph verify
> >>     fatal: commit-graph requires overflow generation data but has none
> >>
> >>      $ git commit-graph write
> >>     Finding commits for commit graph among packed objects: 100% (10235=
119/10235119), done.
> >>     Expanding reachable commits in commit graph: 2197197, done.
> >>     Finding extra edges in commit graph: 100% (2197197/2197197), done.
> >>     fatal: commit-graph requires overflow generation data but has none
> >>
> >>      $ rm -rf objects/info/commit-graphs/
> >>
> >>      $ git commit-graph write
> >>     Finding commits for commit graph among packed objects: 100% (10235=
119/10235119), done.
> >>     Expanding reachable commits in commit graph: 2197197, done.
> >>     Finding extra edges in commit graph: 100% (2197197/2197197), done.
> >>     fatal: commit-graph requires overflow generation data but has none)
> >>
> >> So even generating them completely anew doesn't seem to generate the
> >> overflow generation data.
> >>
> >> Patrick
> >=20
> > I stand corrected. I forgot that the repository at hand was connected to
> > another one via `objects/info/alternates`. If I prune commit-graphs from
> > that alternate, too, then it works alright with your patches.
>=20
> OK, thanks. That clarifies the situation.
>=20
> I ordered the patches such that the fix in patch 4 could be immediately
> testable, which is not the case without patch 3. However, it does leave
> this temporary state where information can be incorrect if only a subset
> of the series is applied.
>=20
> > This makes me wonder how such a bugfix should be handled though. As this
> > series is right now, users will be faced with repository corruption as
> > soon as they upgrade their Git version to one that contains this patch
> > series. This corruption needs manual action: they have to go into the
> > repository, delete the commit-graphs and then optionally create new
> > ones.
> >=20
> > This is not a good user experience, and it's worse on the server-side
> > where we now have a timeframe where all commit-graphs are potentially
> > corrupt. This effectively leads to us being unable to serve those repos
> > at all until we have rewritten the commit-graphs because all commands
> > which make use of the commit-graph will now die:
> >=20
> >     $ git log
> >     fatal: commit-graph requires overflow generation data but has none
> >=20
> > So the question is whether this is a change that needs to be rolled out
> > over multiple releases. First we'd get in the bug fix such that we write
> > correct commit-graphs, and after this fix has been released we can also
> > release the fix that starts to actually parse the generation. This
> > ensures there's a grace period during which we can hopefully correct the
> > data on-disk such that users are not faced with failures.
>=20
> You are right that we need to be careful here, but I also think that
> previous versions of Git always wrote the correct data. Here is my
> thought process:
>=20
> 1. To get this bug, we need to have parsed the corrected commit date
>    from an existing commit-graph in order to under-count the number
>    of overflow values.
>=20
> 2. Before this series, Git versions were not parsing the corrected
>    commit date, so they recompute the corrected commit date every
>    time the commit-graph is written, getting the proper count of
>    overflow values.
>=20
> For these reasons, data written by previous versions of Git are
> correct and can be trusted without a staged release.
>=20
> Does this make sense? Or, do you experience a different result when
> you build commit-graphs with a released Git version and then when
> writing on top with all patches applied?

Just to verify my understanding: you claim that the bug I was hitting
shouldn't be encountered in the wild when the release , but
only if one were to write a commit-graph with the intermediate stafe
until patch 3/4 of your patch series?

Hum. I have re-verified, and this indeed seems to play out. So I must've
accidentally ran all my testing with the state generated without the
final patch which fixes the corruption. I do see lots of the following
warnings, but overall I can verify and write the commit-graph just fine:

    commit-graph generation for commit c80a42de8803e2d77818d0c82f88e748d7f9=
425f is 1623362063 < 1623362139

Thanks for your patience, and sorry for the noise :)

> > The better alternative would probably be to just gracefully handle
> > commit-graphs which are corrupted in such a way. Can we maybe just
> > continue to not parse generations in case we find that the commit-graph
> > doesn't have overflow generation data?
> >
> > This is more of a general issue though: commit-graphs are an auxiliary
> > cache that is not required for proper operation at all. If we fail to
> > parse it, then Git shouldn't die but instead fail gracefully just ignore
> > it. Furthermore, if we notice that graphs are corrupt when we try to
> > write new ones, we may just delete the corrupt versions automatically
> > and generate completely new ones.
>=20
> You are right that we can be better about failures here and report
> and error instead of a die(). Especially in this case, we could just
> revert to topological levels instead of throwing out the commit-graph
> entirely.
>=20
> This seems like something for another series, so we can be sure to
> audit all cases of fatal errors when parsing the commit-graph so we
> catch all of them and do the "best" thing in each case.

I agree.

Patrick

--24ofu4b8itBCqgXy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIeM3kACgkQVbJhu7ck
PpRu2Q//WQT5+fdxcq9n0UekovekkCPj4Dx3RGTcpolUTnKKchJniZ4o2s5uf7AI
0NonmHMYXjf2s7ZNhQNZGB5HafrUW15iV6wd+6YjN6vo2Ht/kB8k17MZb06F8NvN
YkZG92bBgXJleK+azfbIHeMl/btBLqVwZZibrk+JdeigFOGZ4uzy1hRSkMoJ+M7I
jzHR9dVx/Kryb9aE45FUr5uGHaUNnBlw+fm6MUTE+nnw9ja21dmgw7APIgdnDgka
Ue3EMnHhReijLkUHFpuCQc8nCz+HaYcDd7BOViMWEnmE96ctSuB/De0OrzKMYhOq
PB/Wo9KqbCXZaaGNVw7dt6dO0krmddhkbSK0sBubhG7jMlmtuBG6Tb2wbwGR6lPu
D9ymq2P1yW1ezbkcS4ysAzp0EJB9EX+CgMfxJzlFIQm/3XvZYNfOLmqzeJZghdWo
8zcrmMQwfcxI1/uHcsHcZ9iynJfKKNntBugRNRPxgIOSWsme9wYMOhLloPRga3Ho
P9abwkhzl2kSOySd5GMiS9iiqqn6IDYE6giFUs/gKtbXkGzuTPOQMhReM2ZJRFaF
U4CrYdvtfs5UzjIcXS89YJJXYO1A3JTUti9FfbZEf6t7wwIvCkJgFXe2HM/muxOA
ub+mg8omRBhxUbhxR9XAhRSUdKtcjTFiGqn9pQ+75uv5VQsqAug=
=GwnF
-----END PGP SIGNATURE-----

--24ofu4b8itBCqgXy--
