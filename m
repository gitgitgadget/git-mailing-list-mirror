Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C929C4320A
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 08:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD2A661078
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 08:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbhHIIMP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 04:12:15 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:53517 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233830AbhHIIMO (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 9 Aug 2021 04:12:14 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id E93785C009A;
        Mon,  9 Aug 2021 04:11:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 09 Aug 2021 04:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=BRbO340etX5DVXGf/lJ7o5WEkbH
        Qm0cPjXrs6zN+/qc=; b=vGy1o9coH2yL//LG20H0LSie+ybVPIlQAeyF02p+7lc
        95dtp2s4W2lQeNfTkLAkFjCoPxGPWw3/G1dImsrmB94+GIyzBeiRovy0Xf5e4yqn
        fiBeWOFhrAUrtuGr8Jw7AzgwIeLFJGYcVzJX+40SOUulGy9aviwdZBn02qdE8xzy
        zMNPbVYKQTTzUrb8KSwn2O9mgem5wLF1tgWG2JG//t/oeBsLBatQ+l8ZsdEhAL/u
        ysyvx3zvDhWSiNPdysYoFHMLaFAFVch5GDOBlN50srJIzK0uz5elT6+irehVQiOr
        OjvvbhN5lHroURsz3ZCzm8poCNYHkKvvQL7xBYOFQSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=BRbO34
        0etX5DVXGf/lJ7o5WEkbHQm0cPjXrs6zN+/qc=; b=b72Jj/Oj1mKkcBK6kqo8aN
        FWA5qOEWUVjOS1HDMC1Udul/mZFXsv39tLaGsqmtEuSpQF+lq1Fq/wyR1W/EgRNb
        goAslopHwJ9xDLC58dIMGfp84rYc7A5GHo76SKyx88KKVkqrr60LS4qmjaLwORtO
        NNE65IVpshGSSjrmsltsP5zbW0lP01gmIQ9ECi30KpuRdXgyZ5PLwO8N6Cvb6kyn
        35xIEyas8OGv0Ls8WIrQGQcP2d1c0cQc/OHwFPa0WlV4HeVlZ373rJxy3j2tsBGS
        /pZWCzWbok4m4+IMpZiySSzdo+WM5WCPzpHHN2/tnxIbF39QpoZSRrWmF3cRA4Tg
        ==
X-ME-Sender: <xms:SeMQYYsHgGlkcPgMTIJtA6JG0jPAC1f5V6dZDoSoYYj3VpQ-UmVnig>
    <xme:SeMQYVc0ZLhFs4vh4GMxArx5DauVc2spZwQrdOMmzhp7J94Xt1h0aD7cUu2R9D6Bk
    fSYuZJuXSFOhuQ5HQ>
X-ME-Received: <xmr:SeMQYTzLRDO7fHWwJPga312-gUfUxLL2_mByCR40uEUL_AGU51NJfzIQXPUJHQGW7TdBV-WkR8DWZM2rQSay74dopSRKsq98bXjH_qI870sZIm6sapwm4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjeejgddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveduueeitefgieevvefgtdeuueevveeggeevgfegvdeuleeivdelleelkeeuvddunecu
    ffhomhgrihhnpehgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:SeMQYbPcFUuA0jIcciontYqIwgXxiwWNftjl-6s-q5W8pDQ1ehJDXA>
    <xmx:SeMQYY-O34ccj9sPsJAVoU49fRcbNxff5zeUBhKZjZcd1r8zgGIMlw>
    <xmx:SeMQYTXJ_qJMlL3PxmsgS5dsQ5OTU4n6coY1j4txxFrJMM5xed6BZw>
    <xmx:SeMQYYxl-v8vTSJeVGlPgzbdYmKrkkawQaj5D1JY2xizNpkz0B3TOQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Aug 2021 04:11:52 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id c7f26bba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 9 Aug 2021 08:11:51 +0000 (UTC)
Date:   Mon, 9 Aug 2021 10:11:50 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v5 2/5] connected: do not sort input revisions
Message-ID: <d3f498a5633d88403381aefca58c8b11e1194831.1628496539.git.ps@pks.im>
References: <cover.1624858240.git.ps@pks.im>
 <cover.1628496538.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BAPpRV+QuL4AwW3g"
Content-Disposition: inline
In-Reply-To: <cover.1628496538.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--BAPpRV+QuL4AwW3g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In order to compute whether objects reachable from a set of tips are all
connected, we do a revision walk with these tips as positive references
and `--not --all`. `--not --all` will cause the revision walk to load
all preexisting references as uninteresting, which can be very expensive
in repositories with many references.

Benchmarking the git-rev-list(1) command highlights that by far the most
expensive single phase is initial sorting of the input revisions: after
all references have been loaded, we first sort commits by author date.
In a real-world repository with about 2.2 million references, it makes
up about 40% of the total runtime of git-rev-list(1).

Ultimately, the connectivity check shouldn't really bother about the
order of input revisions at all. We only care whether we can actually
walk all objects until we hit the cut-off point. So sorting the input is
a complete waste of time.

Introduce a new "--unsorted-input" flag to git-rev-list(1) which will
cause it to not sort the commits and adjust the connectivity check to
always pass the flag. This results in the following speedups, executed
in a clone of gitlab-org/gitlab [1]:

    Benchmark #1: git rev-list  --objects --quiet --not --all --not $(cat n=
ewrev)
      Time (mean =C2=B1 =CF=83):      7.639 s =C2=B1  0.065 s    [User: 7.3=
04 s, System: 0.335 s]
      Range (min =E2=80=A6 max):    7.543 s =E2=80=A6  7.742 s    10 runs

    Benchmark #2: git rev-list --unsorted-input --objects --quiet --not --a=
ll --not $newrev
      Time (mean =C2=B1 =CF=83):      4.995 s =C2=B1  0.044 s    [User: 4.6=
57 s, System: 0.337 s]
      Range (min =E2=80=A6 max):    4.909 s =E2=80=A6  5.048 s    10 runs

    Summary
      'git rev-list --unsorted-input --objects --quiet --not --all --not $(=
cat newrev)' ran
        1.53 =C2=B1 0.02 times faster than 'git rev-list  --objects --quiet=
 --not --all --not $newrev'

[1]: https://gitlab.com/gitlab-org/gitlab.git. Note that not all refs
     are visible to clients.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/rev-list-options.txt |  8 +++++++-
 connected.c                        |  1 +
 revision.c                         |  9 +++++++++
 t/t6000-rev-list-misc.sh           | 31 ++++++++++++++++++++++++++++++
 4 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-op=
tions.txt
index 24569b06d1..b7bd27e171 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -968,6 +968,11 @@ list of the missing objects.  Object IDs are prefixed =
with a ``?'' character.
 	objects.
 endif::git-rev-list[]
=20
+--unsorted-input::
+	Show commits in the order they were given on the command line instead
+	of sorting them in reverse chronological order by commit time. Cannot
+	be combined with `--no-walk` or `--no-walk=3Dsorted`.
+
 --no-walk[=3D(sorted|unsorted)]::
 	Only show the given commits, but do not traverse their ancestors.
 	This has no effect if a range is specified. If the argument
@@ -975,7 +980,8 @@ endif::git-rev-list[]
 	given on the command line. Otherwise (if `sorted` or no argument
 	was given), the commits are shown in reverse chronological order
 	by commit time.
-	Cannot be combined with `--graph`.
+	Cannot be combined with `--graph`. Cannot be combined with
+	`--unsorted-input` if `sorted` or no argument was given.
=20
 --do-walk::
 	Overrides a previous `--no-walk`.
diff --git a/connected.c b/connected.c
index b18299fdf0..b5f9523a5f 100644
--- a/connected.c
+++ b/connected.c
@@ -106,6 +106,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 	if (opt->progress)
 		strvec_pushf(&rev_list.args, "--progress=3D%s",
 			     _("Checking connectivity"));
+	strvec_push(&rev_list.args, "--unsorted-input");
=20
 	rev_list.git_cmd =3D 1;
 	rev_list.env =3D opt->env;
diff --git a/revision.c b/revision.c
index 86bbcd10d2..47541407d2 100644
--- a/revision.c
+++ b/revision.c
@@ -2256,6 +2256,10 @@ static int handle_revision_opt(struct rev_info *revs=
, int argc, const char **arg
 	} else if (!strcmp(arg, "--author-date-order")) {
 		revs->sort_order =3D REV_SORT_BY_AUTHOR_DATE;
 		revs->topo_order =3D 1;
+	} else if (!strcmp(arg, "--unsorted-input")) {
+		if (revs->no_walk)
+			die(_("--unsorted-input is incompatible with --no-walk"));
+		revs->unsorted_input =3D 1;
 	} else if (!strcmp(arg, "--early-output")) {
 		revs->early_output =3D 100;
 		revs->topo_order =3D 1;
@@ -2651,8 +2655,13 @@ static int handle_revision_pseudo_opt(const char *su=
bmodule,
 	} else if (!strcmp(arg, "--not")) {
 		*flags ^=3D UNINTERESTING | BOTTOM;
 	} else if (!strcmp(arg, "--no-walk")) {
+		if (!revs->no_walk && revs->unsorted_input)
+			die(_("--no-walk is incompatible with --unsorted-input"));
 		revs->no_walk =3D 1;
 	} else if (skip_prefix(arg, "--no-walk=3D", &optarg)) {
+		if (!revs->no_walk && revs->unsorted_input)
+			die(_("--no-walk is incompatible with --unsorted-input"));
+
 		/*
 		 * Detached form ("--no-walk X" as opposed to "--no-walk=3DX")
 		 * not allowed, since the argument is optional.
diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index 12def7bcbf..ef849e5bc8 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -169,4 +169,35 @@ test_expect_success 'rev-list --count --objects' '
 	test_line_count =3D $count actual
 '
=20
+test_expect_success 'rev-list --unsorted-input results in different sortin=
g' '
+	git rev-list --unsorted-input HEAD HEAD~ >first &&
+	git rev-list --unsorted-input HEAD~ HEAD >second &&
+	! test_cmp first second &&
+	sort first >first.sorted &&
+	sort second >second.sorted &&
+	test_cmp first.sorted second.sorted
+'
+
+test_expect_success 'rev-list --unsorted-input incompatible with --no-walk=
' '
+	cat >expect <<-EOF &&
+		fatal: --no-walk is incompatible with --unsorted-input
+	EOF
+	test_must_fail git rev-list --unsorted-input --no-walk HEAD 2>error &&
+	test_cmp expect error &&
+	test_must_fail git rev-list --unsorted-input --no-walk=3Dsorted HEAD 2>er=
ror &&
+	test_cmp expect error &&
+	test_must_fail git rev-list --unsorted-input --no-walk=3Dunsorted HEAD 2>=
error &&
+	test_cmp expect error &&
+
+	cat >expect <<-EOF &&
+		fatal: --unsorted-input is incompatible with --no-walk
+	EOF
+	test_must_fail git rev-list --no-walk --unsorted-input HEAD 2>error &&
+	test_cmp expect error &&
+	test_must_fail git rev-list --no-walk=3Dsorted --unsorted-input HEAD 2>er=
ror &&
+	test_cmp expect error &&
+	test_must_fail git rev-list --no-walk=3Dunsorted --unsorted-input HEAD 2>=
error &&
+	test_cmp expect error
+'
+
 test_done
--=20
2.32.0


--BAPpRV+QuL4AwW3g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEQ40UACgkQVbJhu7ck
PpQN7g//UjbTmbVE7i/ffYrA9vNZZeYX7uGATWIbytxZjdb/jwV8xO0L9wFdjyd6
8RV5XyzBDc4OAnRyLHdh8ZfQSlk94wQItnEYA8V7QOmKl7S+I6jqigNGSMvn/d2j
6gsMEOm9zZLoOcgUimnRfd/ZYM6LwN3c/9BHQIug/2txqKI7QvX59Fy4ktTMHp3b
fgNeST0VeEVVuc9yOWzwZQSHvfhYNOgA7JIgHxTU0EuQsqDb2/tWdQgBZnwLXT/1
WWD+qOxUDtf6UsfZjNry0SQkUCLkvuNrWKGKPsYxfxgEl3OR04A1kndTVoxEEHGZ
iL1UqBYOKwkUu4ATJnSYNqkyetM7U7c72s4fafKSFOAFRoxxRqFAKpuO5MQBv/Bh
xjQBR/GZN25rxa7AU/IcJg40zIkmNVWIfb3eKlknuS5A47SIMuP8ArA4PeWsFb4g
nDBn4/1577VLyBsT5Pw1K6po12u9glKTgiROzhcYXH6qtlbb+v3hWiY1QEN419Rl
mIjfV08HtvrFcGDA024E33ABCSnmFAYUGhjxA0OzOZ3MYv0ChPDOAKLE6m4PiKns
e0WvHazox3FyvYA0gQNqwDhKBWIAK9AXzVM8RWTUvT5/hfjhwtljOwB6n4vURUZ+
zjs5yeMfY1jpkJhH7MRsRXiQdd2UKbROciDysa1P/slL+pHdKPw=
=N+0d
-----END PGP SIGNATURE-----

--BAPpRV+QuL4AwW3g--
