Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47087C433E2
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 21:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A978206F0
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 21:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="PIwyiCDC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgGNVr3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jul 2020 17:47:29 -0400
Received: from mout.gmx.net ([212.227.17.21]:38891 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbgGNVr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jul 2020 17:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594763246;
        bh=91xrDyFINFKd3fiySRJoC3p4tSFARBa5E3Iyn4sByDw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PIwyiCDCXS1Y2taQt+3/i5QybJZhT90Diq7Rt0mnGJDW9j6BaY++LqTkojv2LJnRj
         x6MFP1vyfFcH/KX5dRdc3X07LJvMACxVYOgJFAqpIQnCTXpPvZ36izST2yRAXxaz9N
         aU0C8aBVMAPeAnGiRsy+s31IasxMb0njzGFrv8MU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.94.224] ([89.1.215.93]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMofc-1kC1gP45ga-00IigF; Tue, 14
 Jul 2020 23:47:26 +0200
Date:   Tue, 14 Jul 2020 23:47:25 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "R. Lemos" <rslemos@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: Empty bundles are not useless
In-Reply-To: <CAM6_cxzzWJQpw9akM=JZAnZ0LrPBCPX+q1da8_24vOJexCKeHA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2007142331160.52@tvgsbejvaqbjf.bet>
References: <CAM6_cxzzWJQpw9akM=JZAnZ0LrPBCPX+q1da8_24vOJexCKeHA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jvcBO9LvjFTZAbkT9Zw/HvLmWVLz15TP3clKgvVX4/GfnEtn0jz
 w0umRF3uElL+WOms7pIYObl60dwf9xtkp2zFcpThQ2TeuEjAJ+PyFBLsPJjhtt8JAO2Y3M9
 9pndFmxNJ8WhehTkRIJSA7FuqWErj8oy8pmGmub/eb15rceEw4GSfB7bWFoJwcViMcUCdP5
 ssXkDu/fr82Et7L5jhA9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Uko9E6lBpL8=:Vz2vUbRZJB8I7Z7l2yp6OA
 mbgZ5ZzTc0SlXQsAf9ftIf6Qg0M2xVz4RKBC+X0Z6eW6g4Jm3YDjmWgz7hHVrxEFUK9/0aIdm
 Ff5xmNKuHZmXkE+hCtf5JKUeiAVnjrykGCiZJJ0Iu3CxW/a/T+kcJbRPEq78zldY0KQc+DaKT
 45eCvvKoFz+Ozu4E0ze9f7dMynAOnLAKIWbNXNcEoc07K8QfnGb2e+9dtgAVw9COR6NyiUuWr
 DpxhQA8TTOXhb5V3OpFpOiLS0kxaKKTu7tg4WqO22tJ+pa9YvssBHAbV6WkZNPsaOjNj4dXi1
 aS0MPkcZpKo2SviLeSFzvVQcdPqR6bSsYvQqrSrJK+9pOQNfvaDRJj9YHzD4dkwCsCk+uR2YI
 kQU3Qyqga9gSJDg7Zbt5LHyyQjT61QoixKHO4bw3Ua3aLZJNIPWJV6UaBLZySdl5P1kxGmOMK
 P/zX+Oy8c64GBHMN6o8h8GrNDQu+DnmaZfKUANiPpG9FHUbkIK5bK4z+RQ4LU3kM/IX48SazV
 3y0XlBF/gQ6Vmd14wP7kCAMR069FeD0/x3976/bjJetIYLFYlg+unyoSoj+HvwlH8YFidAuzB
 ZR3syWMeU/uNIjAbVt3H1QVGwgVk66YrFn48RRU52VWc8+Ekezw2xI3S3IjL3h8A1WNqE/WEC
 BOOfVHiDVF9OAygz2Yi7Qas2bMDKWSpxJyvKO1NtCIHE1yTpm2nQoVa4v3eehgtzefkxIUz4G
 y3tNi2aJ7uQ8iVS8bb4X5Es6RGRBZ3d9zmBNs98mXWRTU9FSQRTzBrW3jZurI/5i/kdDtPYrO
 plEY3hf2+Rqid3IZeUVI6kv9kuwHEigf/kGHHUtDhp/HjPXZCti7eQ61XGCPjeMb82/i2mHOo
 +q6R/XBXJOMTckjQ0onXF7xeg4l/d/JwCJ8yphya7WRHVYe1P7L0lh95J20OQ2DKBpsLZsdR/
 bQhfGIm9evLhGg6be2w53fHorX8tqpmrc6qBipRVWKZXDx+NVXH2qu3HYS1ax6bCrtP1GCj2t
 8xRarPCHsPlDh7aaq75e6rT7uHlOfmsR/rE6utYiSY2SslnPYSH8LhE5VwuqAWL6Jg116oqmI
 4R/lW3d8ffbUsj8P6pnJRl9K6QszCnaBKrjq9y8PHA62Ktog71/1Ufi/ls/3Vqb2sfjdQRVj+
 eIUubrus6EV87lTeiIbLv2AU54dML40vtNt+zmC4daqHUoGftnyyZbOOfLsq3pcq9TnxQLAvn
 wbdmbB5Fa/ZrTdhbE0o2yb0c+UVnmLCf3yblFGA==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rodrigo,

On Tue, 14 Jul 2020, R. Lemos wrote:

> When working disconnected (sending bundles back and forth) it is
> useful to make bundles like this:
>
> $ git bundle create /tmp/my.bundle master ^disconnected/master
>
> This way I pack all new commits since the last updated from
> `disconnected` remote.
>
> But if my local copy is up-to-date, git bundle refuses to create an
> empty bundle, since there are no commits to send.
>
> However it would be nice to at least send the information that my
> local branch `master` is up-to-date. That is, the bundle would just
> convey that my local `master` points to a given commit (even though
> this commit is already on the remote site). This way, when I upload
> this bundle to the remote site, then bring back changes made there,
> the remote site will know which commits I already have.

I am sympathetic to your use case (I certainly had wished for something
like this in the past), but it is not quite as trivial as you might think:
any bundle lists its "wants" and "haves" first, i.e. the commits that it
expects to be present and the tip commits it provides, respectively. And
herein lies the rub: in your case, the tip commit would technically belong
to both "wants" and "haves", and that cannot be represented by the simple
`git rev-list --boundary --pretty=3Doneline <rev-list-args>` call that
`compute_and_write_prerequisites()` in `bundle.c` performs in order to
generate that wants/haves list.

You could of course implement something in `write_bundle_refs()` that
(guarded by a new option, so as to maintain backwards-compatibility) would
list commits marked as `UNINTERESTING` both as "wants" and "haves", but
that might become a bit tricky e.g. handling commit ranges like
`HEAD~2..HEAD` (where `HEAD~2` would be marked `UNINTERESTING`).

Side note: if it is not clear to you what I mean by `UNINTERESTING`,
please read the excellent tutorial at:
https://github.com/git/git/blob/v2.28.0-rc0/Documentation/MyFirstObjectWal=
k.txt

Once you worked out how to write out such commits both as prerequisites as
well as refs in the bundle, the rest should be relatively easy: a new test
case in `t/t5607-clone-bundle.sh` to verify that empty bundles can be
created (using a new command-line option that allows precisely that) and
something like this (plus the corresponding docs in
`Documentation/git-bundle.txt`):

=2D- snip --
diff --git a/bundle.c b/bundle.c
index 99439e07a106..74f2759a2068 100644
=2D-- a/bundle.c
+++ b/bundle.c
@@ -11,6 +11,7 @@
 #include "run-command.h"
 #include "refs.h"
 #include "argv-array.h"
+#include "parse-options.h"

 static const char bundle_signature[] =3D "# v2 git bundle\n";

@@ -436,6 +437,21 @@ int create_bundle(struct repository *r, const char *p=
ath,
 	int bundle_to_stdout;
 	int ref_count =3D 0;
 	struct rev_info revs;
+	int allow_empty_bundle =3D 0;
+	struct option options[] =3D {
+		OPT_BOOL(0, "allow-empty-bundle",
+			 &allow_empty_bundle,
+			 N_("allow an empty bundle to be created")),
+		OPT_END()
+	};
+	const char * const create_usage[] =3D {
+		N_("git bundle create [<options>] <file> <git-rev-list args>"),
+		NULL
+	};
+
+	argc =3D parse_options(argc, argv, NULL, options, create_usage,
+			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0 |
+			     PARSE_OPT_KEEP_UNKNOWN);

 	bundle_to_stdout =3D !strcmp(path, "-");
 	if (bundle_to_stdout)
@@ -465,7 +481,7 @@ int create_bundle(struct repository *r, const char *pa=
th,
 	object_array_remove_duplicates(&revs.pending);

 	ref_count =3D write_bundle_refs(bundle_fd, &revs);
-	if (!ref_count)
+	if (!ref_count && !allow_empty_bundle)
 		die(_("Refusing to create empty bundle."));
 	else if (ref_count < 0)
 		goto err;
=2D- snap --

Hopefully this gets you started with "scratching your own itch".

Ciao,
Johannes
