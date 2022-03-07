Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20413C433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 11:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240486AbiCGLMo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 06:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241466AbiCGLMf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 06:12:35 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1ABD8372
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 02:34:37 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id B05A15C0338;
        Mon,  7 Mar 2022 05:34:11 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 07 Mar 2022 05:34:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=wIo6K/rUsxkBtwS1oaQZndV86kFgKzaCutU5Uj
        UNeyU=; b=MmslCugDd5y4lREsHY17GqSc6JybmhWNidKiGFqhc1BEPSSEM6NGeZ
        Y2YrLjrRiSN99Roa+vcjWUY6vIp2xd8dZHCleD+PlxhN3uCCDlyJf4uK5DIrRfbp
        P71AUAdOxBfs3X4FBjbBnQ91z+/eXolCAEZibSDkGGwwaCXWjSHU4WHVGi04fMjX
        j7RGnhTzjX0ENAPGvqyodWu9SThoDKc6VyVzSazzy1MIADzxtm+uzb5J/ECCYeRZ
        TNpW6ErAtN30aXTQ1i9/tz2NhmdcaDyT8btFT6Zi/N4u4I0xyQSYULCxZJkWOhF1
        ohXEsv6mz88RuuEfSk5yDviFHg+BfiGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=wIo6K/rUsxkBtwS1o
        aQZndV86kFgKzaCutU5UjUNeyU=; b=DZkyDKsh7nof/i5ZHc+LyJOQadeCMc640
        y9FLOTDZ3q3P1nK4d6jr/g3VCkE+s7omCo1pSMqVbIlhBbt5Hkd2nPaniZgOiNBR
        vI79cjGgYKw29aCyTg94it61fPyQ8s8Y4z751LUUXgxgXjbDxiVFK1uJWjlxxAeZ
        TRU+5QJMkAaKtGVXtXtU5fJkrBpa2U+4ybGSlqfSLgd36y0ezgZWvnn7mmWcpzmV
        7otarV3lCT1DK7OBVmKZyeCplnNe/aCVix4V2Thfj2sQU+ipZFcogJfyDT7FvrRz
        ZOXdot1u5pvMV7WysqnHn/XQcG1e7oyxOPC2+90gFBDttu+ELFQZQ==
X-ME-Sender: <xms:o98lYtk9581zX2TVNjj-WX24EBSW-4agDuMKXx0qC8Nin_F8ypUnbw>
    <xme:o98lYo1nCOfMO67QZ3VqxHH3us2SD7dsgiqwO0SFFsFEHbF9H8JHjr2qHhX88hx2R
    io_TLB3AHC4E4rVrw>
X-ME-Received: <xmr:o98lYjod-Z7_GQpeJKgm3rWWgxLb8MHrhIr4FE-E7Y25hnK7tegOwov4g98Hq1XlbB-M2XplcBpTz0FqrvtkAdvMJzBPGOvw-6HZ-aORLFMQHLoDME1Gxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddugedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtdorredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueduhedtvdejheetfeehuddtieekfeffffejuddtheevveduffduiefgkeekuden
    ucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:o98lYtn5rgJz_WSkvLIjPpH8KptsxOZuRS_97MTPEiJOrk5Ec5GG1Q>
    <xmx:o98lYr0bSRdj_R4_HTichAaqwU-OPNaK7kxWlV-Kbc35D3kIWy9yCQ>
    <xmx:o98lYss5L5Lu1DwPMczUSJTMwkWoGhMJa84YHOIEV_K0YQC2vY4gPw>
    <xmx:o98lYmQnIMJK4dsjKZ7w_5wESPAADbUHVlN3xqUOF0UNrjP_JImMZA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Mar 2022 05:34:10 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id e6fbdf3d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 7 Mar 2022 10:34:07 +0000 (UTC)
Date:   Mon, 7 Mar 2022 11:34:06 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        abhishekkumar8222@gmail.com
Subject: Re: [PATCH 3/7] commit-graph: start parsing generation v2 (again)
Message-ID: <YiXfnsbGzPXffdgV@ncase>
References: <Yh3rZX6cJpkHmRZc@ncase>
 <Yh325v3RBDMxjFnD@ncase>
 <f50e74f0-9ffa-f4f2-4663-269801495ed3@github.com>
 <Yh4zehdSnHLW1HuK@ncase>
 <1b9912f7-87be-2520-bb53-9e23529ad233@github.com>
 <Yh93vOkt2DkrGPh2@ncase>
 <db5eb248-1b54-9f24-8f8a-28c19a1eee6a@github.com>
 <YiCkRLFxn8Pok7Kc@ncase>
 <33deae83-1afd-1645-82f3-5af14f14094d@github.com>
 <06ea3190-32d0-c792-0ae9-c5600305f158@github.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GJIG3E2Mb7mhBQAa"
Content-Disposition: inline
In-Reply-To: <06ea3190-32d0-c792-0ae9-c5600305f158@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--GJIG3E2Mb7mhBQAa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 04, 2022 at 09:03:15AM -0500, Derrick Stolee wrote:
> On 3/3/2022 11:00 AM, Derrick Stolee wrote:
> > On 3/3/2022 6:19 AM, Patrick Steinhardt wrote:
> >> On Wed, Mar 02, 2022 at 09:57:17AM -0500, Derrick Stolee wrote:
> >>> On 3/2/2022 8:57 AM, Patrick Steinhardt wrote:
> >>>> On Tue, Mar 01, 2022 at 10:25:46AM -0500, Derrick Stolee wrote:
> >>>>> On 3/1/2022 9:53 AM, Patrick Steinhardt wrote:
> >>>
> >>>>>> Hum. I have re-verified, and this indeed seems to play out. So I m=
ust've
> >>>>>> accidentally ran all my testing with the state generated without t=
he
> >>>>>> final patch which fixes the corruption. I do see lots of the follo=
wing
> >>>>>> warnings, but overall I can verify and write the commit-graph just=
 fine:
> >>>>>>
> >>>>>>     commit-graph generation for commit c80a42de8803e2d77818d0c82f8=
8e748d7f9425f is 1623362063 < 1623362139
> >>>>>
> >>>>> But I'm not able to generate these warnings from either version. I
> >>>>> tried generating different levels of a split commit-graph, but
> >>>>> could not reproduce it. If you have reproduction steps using current
> >>>>> 'master' (or any released Git version) and the four patches here,
> >>>>> then I would love to get a full understanding of your errors.
> >>>>>
> >>>>> Thanks,
> >>>>> -Stolee
> >>>>
> >>>> I haven't yet been able to reproduce it with publicly available data,
> >>>> but with the internal references I'm able to evoke the warnings
> >>>> reliably. It only works when I have two repositories connected via
> >>>> alternates, when generating the commit-graph in the linked-to repo
> >>>> first, and then generating the commit-graph in the linking repo.
> >>>>
> >>>> The following recipe allows me to reproduce, but rely on private dat=
a:
> >>>>
> >>>>     $ git --version
> >>>>     git version 2.35.1
> >>>>
> >>>>     # The pool repository is the one we're linked to from the fork.
> >>>>     $ cd "$pool"
> >>>>     $ rm -rf objects/info/commit-graph objects/info/commit-graph
> >>>>     $ git commit-graph write --split
> >>>>
> >>>>     $ cd "$fork"
> >>>>     $ rm -rf objects/info/commit-graph objects/info/commit-graph
> >>>>     $ git commit-graph write --split
> >>>>
> >>>>     $ git commit-graph verify --no-progress
> >>>>     $ echo $?
> >>>>     0
> >>>>
> >>>>     # This is 715d08a9e51251ad8290b181b6ac3b9e1f9719d7 with your ful=
l v2
> >>>>     # applied on top.
> >>>>     $ ~/Development/git/bin-wrappers/git --version
> >>>>     git version 2.35.1.358.g7ede1bea24
> >>>>
> >>>>     $ ~/Development/git/bin-wrappers/git commit-graph verify --no-pr=
ogress
> >>>>     commit-graph generation for commit 06a91bac00ed11128becd48d5ae77=
eacd8f24c97 is 1623273624 < 1623273710
> >>>>     commit-graph generation for commit 0ae91029f27238e8f8e109c6bb390=
7f864dda14f is 1622151146 < 1622151220
> >>>>     commit-graph generation for commit 0d4582a33d8c8e3eb01adbf564f5e=
1deeb3b56a2 is 1631045222 < 1631045225
> >>>>     commit-graph generation for commit 0daf8976439d7e0bb9710c5ee63b5=
70580e0dc03 is 1620347739 < 1620347789
> >>>>     commit-graph generation for commit 0e0ee8ffb3fa22cee7d28e21cbd6d=
f26454932cf is 1623783297 < 1623783380
> >>>>     commit-graph generation for commit 0f08ab3de6ec115ea8a956a1996cb=
9759e640e74 is 1621543278 < 1621543339
> >>>>     commit-graph generation for commit 133ed0319b5a66ae0c2be76e5a887=
b880452b111 is 1620949864 < 1620949915
> >>>>     commit-graph generation for commit 1341b3e6c63343ae94a8a473fa057=
126ddd4669a is 1637344364 < 1637344384
> >>>>     commit-graph generation for commit 15bdfc501c2c9f23e9353bf6e6a5f=
acd9c32a07a is 1623348103 < 1623348133
> >>>>     ...
> >>>>     $ echo $?
> >>>>     1
> >>>>
> >>>> When generating commit-graphs with your patches applied the `verify`
> >>>> step works alright.
> >>>>
> >>>> I've also by accident stumbled over the original error again:
> >>>>
> >>>>     fatal: commit-graph requires overflow generation data but has no=
ne
> >>>>
> >>>> This time it's definitely not caused by generating commit-graphs wit=
h an
> >>>> in-between state of your patch series because the data comes straight
> >>>> from production with no changes to the commit-graphs performed by
> >>>> myself. There we're running Git v2.33.1 with a couple of backported
> >>>> patches (see [1]). While those patches cause us to make more use of =
the
> >>>> commit-graph, none modify the way we generate them.
> >>>>
> >>>> Of note is that the commit-graph contains references to commits which
> >>>> don't exist in the ODB anymore.
> >>>>
> >>>> Patrick
> >>>>
> >>>> [1]: https://gitlab.com/gitlab-org/gitlab-git/-/commits/pks-v2.33.1.=
gl3
> >>>
> >>> Thank you for your diligence here, Patrick. I really appreciate the
> >>> work you're putting in to verify the situation.
> >>>
> >>> Since our repro relies on private information, but is consistent, I
> >>> wonder if we should take the patch below, which starts to ignore the
> >>> older generation number v2 data and only writes freshly-computed
> >>> numbers.
> >>>
> >>> Thanks,
> >>> -Stolee
> >>
> >> Thanks. With your patch below the `fatal:` error is gone, but I'm still
> >> seeing the same errors with regards to the commit-graph generations.
> >=20
> > This is disappointing and unexpected. Thanks for verifying.
> >=20
> >> So to summarize my findings:
> >>
> >>     - This bug occurs when writing commit-graphs with v2.35.1, but
> >>       reading them with your patches.
> >>
> >>     - This bug occurs when I have two repositories connected via an
> >>       alternates file. I haven't yet been able to reproduce it in a
> >>       single repository that is not connected to a separate ODB.
> >=20
> > This is an interesting distinction. One that I didn't think would
> > matter, but I'll look into the code to see how that could affect
> > things.
> >=20
> >>     - This bug only occurs when I first generate the commit-graph in t=
he
> >>       repository I'm borrowing objects from.
> >>
> >>     - This bug only occurs when I write commit-graphs with `--split` in
> >>       both repositories. "Normal" commit-graphs don't have this issue,
> >>       and neither can I see it with `--split=3Dreplace` or mixed-type
> >>       commit-graphs.
> >>
> >> Beware, the following explanation is based on my very basic
> >> understanding of the commit-graph code and thus more likely to be wrong
> >> than right:
> >>
> >> With the old Git version, we've been mis-parsing the generation because
> >> `read_generation_data` wasn't ever set. As a result it can happen that
> >> the second split commit-graph we're generating computes its own
> >> generation numbers from the wrong starting point because it uses the
> >> mis-parsed generation numbers from the parent commit-graph.
> >>
> >> With your patches, we start to correctly account for overflows and wou=
ld
> >> thus end up with a different value for the generation depending on whe=
re
> >> we parse the commit from: if we parse it from the first commit-graph it
> >> would be correct because it's contains the "root" of the generation
> >> numbers. But if we parse a commit from the second commit-graph we may
> >> have a mismatch because the generation numbers in there may have been
> >> derived from generation numbers mis-parsed from the first commit-graph.
> >> And because these would be wrong in case there was an overflow it is
> >> clear that the new corrected generation number may be wrong, as well.
> >=20
> > Hm. My expectation was that the older layers of the split commit-graph
> > would have read_generation_data disabled (because the new Git version
> > cannot read the GDAT chunk) and then the validate_mixed_generation_chai=
n()
> > method would remove read_generation_data from all of the graphs in the
> > list.
> >=20
> > Combining this with your thoughts on cross-alternate split commit-graph=
s,
> > this makes me think we should try this:
> >=20
> > --- >8 ---
> >=20
> > diff --git a/commit-graph.c b/commit-graph.c
> > index fb2ced0bd6..74c6534f56 100644
> > --- a/commit-graph.c
> > +++ b/commit-graph.c
> > @@ -609,8 +609,6 @@ struct commit_graph *read_commit_graph_one(struct r=
epository *r,
> >  	if (!g)
> >  		g =3D load_commit_graph_chain(r, odb);
> > =20
> > -	validate_mixed_generation_chain(g);
> > -
> >  	return g;
> >  }
> > =20
> > @@ -668,7 +666,13 @@ static int prepare_commit_graph(struct repository =
*r)
> >  	     !r->objects->commit_graph && odb;
> >  	     odb =3D odb->next)
> >  		prepare_commit_graph_one(r, odb);
> > -	return !!r->objects->commit_graph;
> > +
> > +	if (r->objects->commit_graph) {
> > +		validate_mixed_generation_chain(r->objects->commit_graph);
> > +		return 1;
> > +	}
> > +
> > +	return 0;
> >  }
> > =20
> >  int generation_numbers_enabled(struct repository *r)
> >=20
> >=20
> > --- >8 ---
> >=20
> > Notice that I'm moving the validate_mixed_generation_chain() call
> > out of read_commit_graph_one() and into prepare_commit_graph(). To
> > my understanding, this _should_ have an equivalent end state as the
> > old code, but might be worth trying just as a quick check.
> >=20
> > I will continue investigating and try to reproduce with this
> > additional constraint of working across an alternate.
>=20
> My attempts to reproduce this across an alternate have failed. I
> tried running the following test against Git without these patches,
> then verify with the newer version of Git. (I also have generated
> a few new layers on top with these patches, and they correctly drop
> the GDA2 and GDO2 chunks when the lower layers "don't have gen v2".)
>=20
>=20
> test_description=3D'commit-graph with offsets across alternates'
> . ./test-lib.sh
>=20
> if ! test_have_prereq TIME_IS_64BIT || ! test_have_prereq TIME_T_IS_64BIT
> then
> 	skip_all=3D'skipping 64-bit timestamp tests'
> 	test_done
> fi
>=20
>=20
> UNIX_EPOCH_ZERO=3D"@0 +0000"
> FUTURE_DATE=3D"@4147483646 +0000"
>=20
> GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=3D0
>=20
> test_expect_success 'generate alternate split commit-graph' '
> 	git init alternate &&
> 	(
> 		cd alternate &&
> 		test_commit --date "$UNIX_EPOCH_ZERO" 1 &&
> 		test_commit --date "$FUTURE_DATE" 2 &&
> 		git commit-graph write --reachable &&
> 		test_commit --date "$UNIX_EPOCH_ZERO" 3 &&
> 		test_commit --date "$FUTURE_DATE" 4 &&
> 		git commit-graph write --reachable --split=3Dno-merge
> 	) &&
> 	git clone --shared alternate fork &&
> 	(
> 		cd fork &&
> 		test_commit --date "$UNIX_EPOCH_ZERO" 5 &&
> 		test_commit --date "$FUTURE_DATE" 6 &&
> 		git commit-graph write --reachable --split=3Dno-merge &&
> 		test_commit --date "$UNIX_EPOCH_ZERO" 7 &&
> 		test_commit --date "$FUTURE_DATE" 8 &&
> 		git commit-graph write --reachable --split=3Dno-merge
> 	)
> '
>=20
> test_done
>=20
>=20
> My testing after running this with -d allows me to reliably see these
> layers being created with GDAT and GDOV chunks. Running the 'git
> commit-graph verify' command with the new code does not show those
> errors, even after adding commits and another layer to the split
> commit-graph.
>=20
> I look forward to any additional insights you might have here.

I don't really know why, but now I've become unable to reproduce it
again. I think we should just go with your patch 5/4 on top -- it does
fix the most important issue, which is the `die()` I saw on almost all
commands. The second part about the warnings I'm just not sure about,
but I don't think it should stop this patch series given my own
uncertainty.

Patrick

--GJIG3E2Mb7mhBQAa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIl350ACgkQVbJhu7ck
PpSLIRAArJlBC0OK/osSHoYlBUBSzr4OGc87pUjnNfRfulfkIbfYVN3fzAvvqTXP
VULTeyliefkFo/2z5NlxgZMBuLcO0e5fjK3OdTDO/vOqPMmISDRb7fXVLRX3p++E
SlYTfNPuV8wIfP9RCgAqAkK54HS+xFkWlHO1IkadIawHOyw3CJtWoz0pDINsbuGh
2Xln7cXx3Q9f1YVHm60GzqJGmmYzeQOc52+uz3sygT4jnTTS6WpuLsd8NK34q+gY
4FvP/yj1rBv+a/QlHSQRkFoPqQWQRnRmMWijHFehYa848fxsx6zgvaahrrtB3Zn5
OMjVsAun3FcLcEqZWP9MH8UBCdt/UNFbZOjM7C42pmeVpjpr11ocRQXEmxTLQy6c
d25tzi/2xQDmjSf0t6gDK5aeo59R1F+MqRaSNjD0svBmZ+BDiWCoM/oZivAZajwe
+cRSRg6HUOAu0j6M0GBJ5JimxNpl6YKK/VoH16jrKehx2QzLVr1gRaouz4ebRNQM
5tHaBzRThQAEKcli56DND/9AJ3JAzGIowwYTqNLSAHGsvhrDJXS/ZQLyGMyI2SLy
CPM8NQYcoS27Wrl7YGs2TjoT4yHtbqalBXVV+2SYolnt1Skgjx4UiJpFrxX/LDAi
e8NBFTbyFUhlhVQ3OBXxe/FZrGEXK/fd3DHSNZArm1azE3Sepz4=
=OirU
-----END PGP SIGNATURE-----

--GJIG3E2Mb7mhBQAa--
