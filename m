Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775FBC433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DAFF61A87
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhJAJQV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 05:16:21 -0400
Received: from mout.web.de ([217.72.192.78]:33021 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229702AbhJAJQU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 05:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1633079673;
        bh=DZbCBUzsyeR0mESMjMiRa98oSh/aD68k+7vaFNNwk4Y=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=CalJP1WrrqNipitVYaToVB2iX2kTPsGZibx6bkSAr7Y/WMleOJRiQ6hjoJCyfMgII
         pjxXKncIAld+f/2FkPBTnL5RcmjYonDpXBNW5xxGCOrDgJCHm2mOHP39gWLNQIoa8s
         VUovfncHZwDc/Qj+DprZZ70YrxO76Th3r0OaciPY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb103 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0Lal6K-1nGL0D1ItM-00kOxI; Fri, 01 Oct 2021 11:14:33 +0200
Subject: [PATCH 4/9] test-mergesort: add generate subcommand
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <943b1e01-465e-5def-a766-0adf667690de@web.de>
Message-ID: <1b6e34fc-b758-f6e7-39b2-e73f309591bd@web.de>
Date:   Fri, 1 Oct 2021 11:14:32 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <943b1e01-465e-5def-a766-0adf667690de@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6opvJZ7N4fLOUg5g7iKzlIklxVNKVn0LvNAzhZY+Tg7kZr9aCiw
 HZ1S6e2K59XvErXsxHu7vrCcoNtgaAFH0GgPxi4Dtsl6w87r7EwhVx8BQGEVyVVjVhA10EV
 CXVCQMzH7OQKe0lnxxDx8f5MDBsqWW+I9FfZuFhfVR4dWV/T7QU1dtuJkNLd5iVkC0tiYLh
 sVYmTt1hDj4qYt8gqU2fw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YvmNxUYI5W0=:zVb9wwgs664SLYCtLAAPqP
 WZ/4/VPqBgHl01xu2Klp3AS6qO7Zp8hMFs7hPtNakfDhSlPeMjpxCfpWeVQhyzZ22JeZlvBVn
 TlRjuwaAOAVNI3fF9PjiI5wl7rdf+Zep+AwRChmH/cvBmLCZvmmA4GSL0Qd+4OedVM1zuRINm
 a+qJC8YgYzXrgrxojycU9yN9mAe2zZMTgijwBFIYIi8bSE2AknIa85eFgkWjbEkMV+smC/fw1
 N5eNkKxyoV9gmcJDWa/UKjOLWp7jwY1ipwjPzMrUFmX6Hkm+pPXabVD7xHMjnESjESU/I+/wm
 mMy5Ux/wbnQF9sNP17+I+P2K5PrU7PyyBL6ZQmy2IyC9DqQtPzxIu81ezJE4Sfkel24hxwLYW
 yuk1NteiYY+xYeqhMHxv2qkfTTVzxD5UIj2ExGfi+mIFuj4dUyFkfYoXXSOJDJlNhEhl1Xxae
 33IEVnisbquZ8op+3oEJICnkKIitE1mdyaNRwPvQrucgztM44G1nm6KZ1p4M1xpdvC8o2ePsL
 OYXd09uDN0YPV/b9DooxpELetv7YdBdk0S1HvVo97N9LRs24QbpxplW/Mcctj8zDuPTUFqgId
 31356qy/w5XKdioNpQcYo/EMC72bxd36raAhyPKEH1NsAHds17xmw3d+YyEongODeDk/QLM6r
 jVe7xKeOS8ggiR7i2l7L+2A28OoABsAy05Q7o0nhOyxmQkLqMDQO4es8/RclgyoEcEAWBzzLa
 fY2CVuAx8nVGIXfhSbFWcmX/j8cJJ60wYQ0uJOz8Zc/42boSoQPFH4v05S0MHcBWlLthNgKXx
 959CiSO0ZSQASYwBBep0gXxCOzQSGTRnEgB4VjE0EfW131gjvMC47uuBsED6frZ20QyMtTVkH
 3z4+bZdyQ5GLhJiyfNTYihOI19W3KNVnA6nl2QBnNFTGtJS7U99yO3KfstaAMvFGN4u2wAHwX
 42sk4rDLFQQ/opJAH+9Be1TqwMfw80zBsgixPz7c8w5aXyi76aD8mlVSy6HhPSW1pxyo1uuyM
 GiZVFSzums78rBXfGKPF/qdP75OirCVwjl0h0Zoauu+RCKvGKxoKFr3QpcqsJnsr51fCkldue
 bA6IHzH9l1A7gA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a subcommand for printing test data.  It can be used to generate
special test cases and feed them into the sort subcommand or sort(1) for
performance measurements.  It may also be useful to illustrate the
effect of distributions, modes and their parameters.

It generates n integers with the specified distribution and its
distribution-specific parameter m.  E.g. m is the maximum value for
the plateau distribution and the length and height of individual teeth
of the sawtooth distribution.

The generated values are printed as zero-padded eight-digit hexadecimal
numbers to make sure alphabetic and numeric order are the same.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/helper/test-mergesort.c | 60 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-mergesort.c b/t/helper/test-mergesort.c
index 8006be8bf8..27ba252d4a 100644
=2D-- a/t/helper/test-mergesort.c
+++ b/t/helper/test-mergesort.c
@@ -98,6 +98,16 @@ static struct dist {
 	DIST(shuffle),
 };

+static const struct dist *get_dist_by_name(const char *name)
+{
+	int i;
+	for (i =3D 0; i < ARRAY_SIZE(dist); i++) {
+	       if (!strcmp(dist[i].name, name))
+		       return &dist[i];
+	}
+	return NULL;
+}
+
 static void mode_copy(int *arr, int n)
 {
 	/* nothing */
@@ -154,6 +164,41 @@ static struct mode {
 	MODE(dither),
 };

+static const struct mode *get_mode_by_name(const char *name)
+{
+	int i;
+	for (i =3D 0; i < ARRAY_SIZE(mode); i++) {
+	       if (!strcmp(mode[i].name, name))
+		       return &mode[i];
+	}
+	return NULL;
+}
+
+static int generate(int argc, const char **argv)
+{
+	const struct dist *dist =3D NULL;
+	const struct mode *mode =3D NULL;
+	int i, n, m, *arr;
+
+	if (argc !=3D 4)
+		return 1;
+
+	dist =3D get_dist_by_name(argv[0]);
+	mode =3D get_mode_by_name(argv[1]);
+	n =3D strtol(argv[2], NULL, 10);
+	m =3D strtol(argv[3], NULL, 10);
+	if (!dist || !mode)
+		return 1;
+
+	ALLOC_ARRAY(arr, n);
+	dist->fn(arr, n, m);
+	mode->fn(arr, n);
+	for (i =3D 0; i < n; i++)
+		printf("%08x\n", arr[i]);
+	free(arr);
+	return 0;
+}
+
 static struct stats {
 	int get_next, set_next, compare;
 } stats;
@@ -278,11 +323,24 @@ static int run_tests(int argc, const char **argv)

 int cmd__mergesort(int argc, const char **argv)
 {
+	int i;
+	const char *sep;
+
+	if (argc =3D=3D 6 && !strcmp(argv[1], "generate"))
+		return generate(argc - 2, argv + 2);
 	if (argc =3D=3D 2 && !strcmp(argv[1], "sort"))
 		return sort_stdin();
 	if (argc > 1 && !strcmp(argv[1], "test"))
 		return run_tests(argc - 2, argv + 2);
-	fprintf(stderr, "usage: test-tool mergesort sort\n");
+	fprintf(stderr, "usage: test-tool mergesort generate <distribution> <mod=
e> <n> <m>\n");
+	fprintf(stderr, "   or: test-tool mergesort sort\n");
 	fprintf(stderr, "   or: test-tool mergesort test [<n>...]\n");
+	fprintf(stderr, "\n");
+	for (i =3D 0, sep =3D "distributions: "; i < ARRAY_SIZE(dist); i++, sep =
=3D ", ")
+		fprintf(stderr, "%s%s", sep, dist[i].name);
+	fprintf(stderr, "\n");
+	for (i =3D 0, sep =3D "modes: "; i < ARRAY_SIZE(mode); i++, sep =3D ", "=
)
+		fprintf(stderr, "%s%s", sep, mode[i].name);
+	fprintf(stderr, "\n");
 	return 129;
 }
=2D-
2.33.0
