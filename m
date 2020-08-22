Return-Path: <SRS0=iV/m=CA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF43C433E1
	for <git@archiver.kernel.org>; Sat, 22 Aug 2020 10:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91C7C204EC
	for <git@archiver.kernel.org>; Sat, 22 Aug 2020 10:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="jmMgeDsl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgHVK3g (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Aug 2020 06:29:36 -0400
Received: from mout.web.de ([212.227.15.14]:35057 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbgHVK3f (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Aug 2020 06:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1598092164;
        bh=cOulWmSdUyCDkwj81QMgV9CcwikkD3V9Y4J95qsZRd8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jmMgeDslI420GFlzbeNw8qgpeKgpBdJHqRWDaB/kmdH2oprhyrN2rjHNfWtje/wo0
         56otbGls2Vz7hT+Qs8f2rnvpErN7GJgt95tDYjIn46dhCiEGmhkbjgoQYyQplS77Ux
         Y9wkmmE0ErQi/ZnIRXRyCWkxjtHneM56Tnr6Ot7I=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MNt8d-1kGqMx2Czr-007RRk; Sat, 22
 Aug 2020 12:29:24 +0200
Subject: Re: Possible bug with git restore
To:     Jeff King <peff@peff.net>
Cc:     Sergii Shkarnikov <sergii.shkarnikov@globallogic.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
References: <CAFvH=vsWyX79j-9pyC5gpxGu8rRxYyrXwywHjh-_T2opHjT8Xg@mail.gmail.com>
 <CAPig+cSCd_8YB90sypTe1bHMQhPgo+Tr2PHNucdqfCpEe+Dosg@mail.gmail.com>
 <CAFvH=vuFg+kM2GkBaE7jRqHWWcTcZMrs36KLS+-VTy8tgNZXJw@mail.gmail.com>
 <20200820134013.GA2526241@coredump.intra.peff.net>
 <c3f0d51a-d0e3-ed0a-c9ed-da092704da5c@web.de>
 <20200820182720.GA2537643@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <73bddcfc-f8c9-6ec1-328d-a2f427c4aef2@web.de>
Date:   Sat, 22 Aug 2020 12:29:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200820182720.GA2537643@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W95KEdq43xYLvprAYMT2kcMQd0GT+9lWzJVG4l+HKOdgoNWCavO
 boN6zCDsORiAhij1MqlrpwjBW8pQ5YfWljy6/NzEu7I5u3ZUojZQEDui7D6rteJl89O91y2
 PUrzgqLy0HUqevLzHViiFlzZMXyoCbcdhZKLHsw0eMy3R462grPqzudW/Wh0c9BBrJzbSjg
 zhdIFH9v6H7MCPsUti+OQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AvpeIXMJHbk=:R9ayMMAnmpWMf0wGQbo4Oo
 w6Nc3lQYXQm2gcsiOekHzIs5+qRVOetkBxSrpg5pAONWZO2s9t3Ye4bN3vETFSvXttsUMFKOP
 7PvKSU/J7d+8JkiCYV9OtB1aRt9Oo14treplBo4bMMlIHxOaBXuVLwfVig3zOsvAlq79f4qq3
 6y42glHOz1jreyAB04IPrMdh8Ja1i57RxPoeXhF//CTAD8wP/A5KyYGNbMHY8CXc+nh2H9r9o
 aqv+jlypaYJ46Acmam7MPLm+KKQR3gLhX9OL7HknlT9p/h08QN6NPvn9PGp+qWtDRoII+F/Xf
 wOU18AX4qd8UIx23TMYr+F+HDIKyODxj/PnA95Y0xEJWHPuo5tbDiHlP0OjZH51aYiFOL9Vk7
 pQ447Ni+JIdl8SfkIDGMR91+hW1Y49ToZy/cHChONq2ZcSt+76cFPiy3TM16KSM8fmauj5qcd
 TfgS5KR4MpRXgR1jAF+v42tzoMs++UEfzmRRKr6ZOgO7o4Vn2rjWrdUxUQ0sEerqWd61vVbqr
 9LC83i3XLXu3yMR9a2Ohr1zJxLIyj7px9WCHJ72o6x4uqRqSJjTDMQgbnALGw6nptJrtOek7Y
 mLd4/OJWe5KLQUxHtEf/aaJaT4KrBmVK8bL15oOE5pKuWzmZMVl/cnx2OkUZSl2v6snt07RD2
 e+itwbw/HOVh30ibLii68ArIHAa6dGZrNnX4QWhhYgN1weRDtbklk9h4xXMji5fkz1zsoEyx6
 L0LFNti49wZgsFOEqUt49opIMlSovdTJ/w7q1HNV4JIOpy2jLs/2j7kO7Da1QxvQLpZsTJH+8
 gIJ2IHsjCxw6beLFhhGyPnwU84zNFDAf6s1dX2lB6HuZelPhyPN/KY491UozzHY6gE1RA0yOI
 w5djemzEajVgSG0Mg7wgt2tZGjIa1qoFTfd9dorOGzU0ByLyb80hfr/L3/0NcF1WHj9Qmv78i
 MlPil2AJlK1Q+andXCiT2s4TaN7uSNv/RRrYA5PCLDRICigf97Zqfin+SOKhyki6rMHeFxLch
 OJWTimx49TB+Eo84MbbJOf3Cv8jC+DHGx8iMGocaZvo+EsA11fnzsFNLNTfOh99QRef2RACXO
 qU1QzpCE/LW/wV063WA6Q8dUMuGsKV8/oJFeYTXcoiUuREnexqYMmbddgsGY4vVqBv3RzDLjV
 MG+XS4fke6aSXNgaHDOQ2cyWH8Ief8HxyLUietr9uxJdICfwSxc0+MMZXXd5+Rz8JoFHu+o/i
 zcoXYUzrBoXOkFWaP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.08.20 um 20:27 schrieb Jeff King:
> On Thu, Aug 20, 2020 at 07:48:48PM +0200, Ren=C3=A9 Scharfe wrote:
>
>>>   - shouldn't that wildcard pathspec match those files? I've confirmed
>>>     that the glob characters make it into Git's pathspec machinery, an=
d
>>>     since it doesn't have slashes, I think we'd match a basename (and
>>>     certainly "git ls-files *test_file.*" does what I expect).
>>
>> No, because restore doesn't interpret pathspecs recursively.  I don't
>> know why that causes files to disappear, though.  But here's a fix.
>
> I think it's because of this comment from bc96cc87dbb:
>
>   When pathspec.recursive =3D=3D 0, the behavior depends on match functi=
ons:
>   non-recursive for tree_entry_interesting() and recursive for
>   match_pathspec{,_depth}

> So the fundamental issue is treating the pathspec in two different ways,
> and then correlating the results. We need to either do a recursive match
> for the tree match (as your patch does), or do non-recursive for this
> index match (which I don't think is trivial, because of the way the
> recursive flag works).

If using the same pathspec with both tree_entry_interesting and
match_pathspec gives inconsistent results and can even lead to data loss
as we've seen here, then we better prevent it.

The easiest way to do that would be to BUG out in match_pathspec if
recursive is unset, to indicate that it doesn't support non-recursive
matching.  Finding all the places that didn't bothered to set this flag
since it doesn't affect match_pathspec anyway would be quite tedious,
though.

At least the test suite still completes with the following evil patch
and the fix I sent earlier (evil because it ignores const), so we
currently don't have any other mismatches in covered code.

Ren=C3=A9

=2D--
 dir.c       | 4 ++++
 pathspec.h  | 2 ++
 tree-walk.c | 5 +++++
 3 files changed, 11 insertions(+)

diff --git a/dir.c b/dir.c
index fe64be30ed6..87d5ffa62d0 100644
=2D-- a/dir.c
+++ b/dir.c
@@ -432,6 +432,10 @@ static int do_match_pathspec(const struct index_state=
 *istate,
 {
 	int i, retval =3D 0, exclude =3D flags & DO_MATCH_EXCLUDE;

+	((struct pathspec *)ps)->match_pathspec =3D 1;
+	if (ps->tree_entry_interesting && !ps->recursive)
+		BUG("match_pathspec tree_entry_interesting !recursive");
+
 	GUARD_PATHSPEC(ps,
 		       PATHSPEC_FROMTOP |
 		       PATHSPEC_MAXDEPTH |
diff --git a/pathspec.h b/pathspec.h
index 454ce364fac..bbae0abb249 100644
=2D-- a/pathspec.h
+++ b/pathspec.h
@@ -32,6 +32,8 @@ struct pathspec {
 	unsigned int has_wildcard:1;
 	unsigned int recursive:1;
 	unsigned int recurse_submodules:1;
+	unsigned int match_pathspec:1;
+	unsigned int tree_entry_interesting:1;
 	unsigned magic;
 	int max_depth;
 	struct pathspec_item {
diff --git a/tree-walk.c b/tree-walk.c
index 0160294712b..f6465cd9cf4 100644
=2D-- a/tree-walk.c
+++ b/tree-walk.c
@@ -1185,6 +1185,11 @@ enum interesting tree_entry_interesting(struct inde=
x_state *istate,
 					const struct pathspec *ps)
 {
 	enum interesting positive, negative;
+
+	((struct pathspec *)ps)->tree_entry_interesting =3D 1;
+	if (ps->match_pathspec && !ps->recursive)
+		BUG("match_pathspec tree_entry_interesting !recursive");
+
 	positive =3D do_match(istate, entry, base, base_offset, ps, 0);

 	/*
=2D-
2.28.0
