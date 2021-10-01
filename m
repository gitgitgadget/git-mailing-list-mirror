Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26236C433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06F486187D
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbhJAJOP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 05:14:15 -0400
Received: from mout.web.de ([212.227.17.12]:52595 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229681AbhJAJOO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 05:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1633079547;
        bh=/zSY045fpew0AbDo5E1kzYjESun88SFZ4WyIRpG4bWU=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=rQLbfLZybPrSfN3DgNkbMontLzubZJ8femmI4JgG1ywl9lPhG7JQXTgLREi1aIJU2
         EPfNWhumN8xLjss5N0uzhELE6fUvCAkPrX1FhfTu4V3iIkAfa5e9NbfoWzbsDB1EmU
         brKHQnRSTk7pK4uuaPlVkuQeEnNDnXC0BA4VHDWI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb105 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MAcpW-1mhHCV1qky-00BXzM; Fri, 01 Oct 2021 11:12:27 +0200
Subject: [PATCH 3/9] test-mergesort: add test subcommand
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <943b1e01-465e-5def-a766-0adf667690de@web.de>
Message-ID: <522fba5e-1048-3377-45c1-7107b55dc6e1@web.de>
Date:   Fri, 1 Oct 2021 11:12:27 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <943b1e01-465e-5def-a766-0adf667690de@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fRqUU5KeRNGV/mN1SYWp1nZOVfXJfUwssTeej/T6xkP+8/at3Cw
 RZGmorVfYTwKlS0kIHYzr9jtcys5lanKo00g1ydgk/jACeh1W9g2f+hpmpbTEUplFuLN8xn
 urvNP0bqDrZqz6UKTVd/s4ZlmbVfvnyY2TkkRpcaviAf4ceQjSGEED/vLt7KUKXxv30Tz2i
 BXlD12WrlDAB224ogdwRA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iEX3uASVwBU=:Dk0arxILaBqfa9D2SxijnI
 ljzG1fBNqTRn4cgtx8chCF8U5IzCmKd+xDjUpUUCx6fU0kxQ6VamGNGv71vnBLEfcwonDdmgB
 s2Eaa6xAzOvvyR5CV4Hm8ub9mTKBiPkVd2opPv2w6hd1rllvakYds8nA8wZFKR7r80XiFyd9I
 86BzQlgNUTbkKROawLs4DD8urer9nClmRigJhWAqFn5IXJ8TPeXixO9cxV8t55T+katNahXN9
 fK2VcTseaJ119oZYYyAG/wsgFMAxfkdEVrjo/XOEt6xQ3hi+TneR715paWoiOQtiZUcd3vlFS
 SVsuMd7gO8KJiuLL2QmsGh/Imh34KHmWbNaZZ1h6/MFafM6F5mj90T8iVBdC1O3kCIUuttit9
 Gl1txuMWLcSu0QWM4R4CEkKCtzMGPp9qlZgaWqDf7ezH1Y2FRCVhRnHLaqUrhOzRvUb3xSnYt
 Co9a59wLwS+RKP+/Lc9dP/EI3B5JmnBLrPjWLFY1R/xYoJhTikv6gpJHDsfLB7cXnn1Y0DUBI
 zHtxEzVgN26C1O/Tfkw7rFBsScscI7XTWBhpKPMonL/swTQbBQwFdGyQLCpnsAYcJAtuOVxmA
 p4Ejk792keR8lbyLty7CBpzDrjxyJR3BPLMmUH3OxR3Iu4OpUeVp0Mcm1qQCbDwthXfs4kZ8i
 cM7W8j9ehtsZPNu9dooC3XwmK8AFI82BF5xYP8v/t9neS8MfSQ09HfqDtHZ5yyFzTn/qA7cLT
 dp/yXS8HozqkWgWQDmkoBbMNiLM+W6zuYudkXH3MGUe7ynldV3aU5ZNs3LjU2HggutRp6cxrQ
 xTthisKg/Dt/JP6lJ6mb1OMr/vq82fykGL1NS6Y/oAkm00MbGgGKDrZJcHXBL+jpIsSDH1Mqz
 v7Vg5wYIJR/mddJXhBe/6mbd0pzRQaBovErVc4ll4LEdJyx9BEFoSrOlxm47LIIYgofUZyukz
 rdaxvXEFV3YGVRVClvOGTJ5gW2H9AgAX6iGnJca7L+S05QSyZsU0bQqXosdHOBmvSe+9iZg3S
 7UrjdBJa1rtwkTB4OvYKU0zpi+WII9sH57ZLwnUKN9OTl8bSoqkJP0OcsO5zGNYPTg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adapt the qsort certification program from "Engineering a Sort Function"
by Bentley and McIlroy for testing our linked list sort function.  It
generates several lists with various distribution patterns and counts
the number of operations llist_mergesort() needs to order them.  It
compares the result to the output of a trusted sort function (qsort(1))
and also checks if the sort is stable.

Also add a test script that makes use of the new subcommand.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/helper/test-mergesort.c | 232 +++++++++++++++++++++++++++++++++++++-
 t/t0071-sort.sh           |  11 ++
 2 files changed, 242 insertions(+), 1 deletion(-)
 create mode 100755 t/t0071-sort.sh

diff --git a/t/helper/test-mergesort.c b/t/helper/test-mergesort.c
index 05be0d067a..8006be8bf8 100644
=2D-- a/t/helper/test-mergesort.c
+++ b/t/helper/test-mergesort.c
@@ -50,9 +50,239 @@ static int sort_stdin(void)
 	return 0;
 }

+static void dist_sawtooth(int *arr, int n, int m)
+{
+	int i;
+	for (i =3D 0; i < n; i++)
+		arr[i] =3D i % m;
+}
+
+static void dist_rand(int *arr, int n, int m)
+{
+	int i;
+	for (i =3D 0; i < n; i++)
+		arr[i] =3D rand() % m;
+}
+
+static void dist_stagger(int *arr, int n, int m)
+{
+	int i;
+	for (i =3D 0; i < n; i++)
+		arr[i] =3D (i * m + i) % n;
+}
+
+static void dist_plateau(int *arr, int n, int m)
+{
+	int i;
+	for (i =3D 0; i < n; i++)
+		arr[i] =3D (i < m) ? i : m;
+}
+
+static void dist_shuffle(int *arr, int n, int m)
+{
+	int i, j, k;
+	for (i =3D j =3D 0, k =3D 1; i < n; i++)
+		arr[i] =3D (rand() % m) ? (j +=3D 2) : (k +=3D 2);
+}
+
+#define DIST(name) { #name, dist_##name }
+
+static struct dist {
+	const char *name;
+	void (*fn)(int *arr, int n, int m);
+} dist[] =3D {
+	DIST(sawtooth),
+	DIST(rand),
+	DIST(stagger),
+	DIST(plateau),
+	DIST(shuffle),
+};
+
+static void mode_copy(int *arr, int n)
+{
+	/* nothing */
+}
+
+static void mode_reverse(int *arr, int n)
+{
+	int i, j;
+	for (i =3D 0, j =3D n - 1; i < j; i++, j--)
+		SWAP(arr[i], arr[j]);
+}
+
+static void mode_reverse_1st_half(int *arr, int n)
+{
+	mode_reverse(arr, n / 2);
+}
+
+static void mode_reverse_2nd_half(int *arr, int n)
+{
+	int half =3D n / 2;
+	mode_reverse(arr + half, n - half);
+}
+
+static int compare_ints(const void *av, const void *bv)
+{
+	const int *ap =3D av, *bp =3D bv;
+	int a =3D *ap, b =3D *bp;
+	return (a > b) - (a < b);
+}
+
+static void mode_sort(int *arr, int n)
+{
+	QSORT(arr, n, compare_ints);
+}
+
+static void mode_dither(int *arr, int n)
+{
+	int i;
+	for (i =3D 0; i < n; i++)
+		arr[i] +=3D i % 5;
+}
+
+#define MODE(name) { #name, mode_##name }
+
+static struct mode {
+	const char *name;
+	void (*fn)(int *arr, int n);
+} mode[] =3D {
+	MODE(copy),
+	MODE(reverse),
+	MODE(reverse_1st_half),
+	MODE(reverse_2nd_half),
+	MODE(sort),
+	MODE(dither),
+};
+
+static struct stats {
+	int get_next, set_next, compare;
+} stats;
+
+struct number {
+	int value, rank;
+	struct number *next;
+};
+
+static void *get_next_number(const void *a)
+{
+	stats.get_next++;
+	return ((const struct number *)a)->next;
+}
+
+static void set_next_number(void *a, void *b)
+{
+	stats.set_next++;
+	((struct number *)a)->next =3D b;
+}
+
+static int compare_numbers(const void *av, const void *bv)
+{
+	const struct number *an =3D av, *bn =3D bv;
+	int a =3D an->value, b =3D bn->value;
+	stats.compare++;
+	return (a > b) - (a < b);
+}
+
+static void clear_numbers(struct number *list)
+{
+	while (list) {
+		struct number *next =3D list->next;
+		free(list);
+		list =3D next;
+	}
+}
+
+static int test(const struct dist *dist, const struct mode *mode, int n, =
int m)
+{
+	int *arr;
+	size_t i;
+	struct number *curr, *list, **tail;
+	int is_sorted =3D 1;
+	int is_stable =3D 1;
+	const char *verdict;
+	int result =3D -1;
+
+	ALLOC_ARRAY(arr, n);
+	dist->fn(arr, n, m);
+	mode->fn(arr, n);
+	for (i =3D 0, tail =3D &list; i < n; i++) {
+		curr =3D xmalloc(sizeof(*curr));
+		curr->value =3D arr[i];
+		curr->rank =3D i;
+		*tail =3D curr;
+		tail =3D &curr->next;
+	}
+	*tail =3D NULL;
+
+	stats.get_next =3D stats.set_next =3D stats.compare =3D 0;
+	list =3D llist_mergesort(list, get_next_number, set_next_number,
+			       compare_numbers);
+
+	QSORT(arr, n, compare_ints);
+	for (i =3D 0, curr =3D list; i < n && curr; i++, curr =3D curr->next) {
+		if (arr[i] !=3D curr->value)
+			is_sorted =3D 0;
+		if (curr->next && curr->value =3D=3D curr->next->value &&
+		    curr->rank >=3D curr->next->rank)
+			is_stable =3D 0;
+	}
+	if (i < n) {
+		verdict =3D "too short";
+	} else if (curr) {
+		verdict =3D "too long";
+	} else if (!is_sorted) {
+		verdict =3D "not sorted";
+	} else if (!is_stable) {
+		verdict =3D "unstable";
+	} else {
+		verdict =3D "OK";
+		result =3D 0;
+	}
+
+	printf("%-9s %-16s %8d %8d %8d %8d %8d %s\n",
+	       dist->name, mode->name, n, m, stats.get_next, stats.set_next,
+	       stats.compare, verdict);
+
+	clear_numbers(list);
+	free(arr);
+
+	return result;
+}
+
+/*
+ * A version of the qsort certification program from "Engineering a Sort
+ * Function" by Bentley and McIlroy, Software=E2=80=94Practice and Experi=
ence,
+ * Volume 23, Issue 11, 1249=E2=80=931265 (November 1993).
+ */
+static int run_tests(int argc, const char **argv)
+{
+	const char *argv_default[] =3D { "100", "1023", "1024", "1025" };
+	if (!argc)
+		return run_tests(ARRAY_SIZE(argv_default), argv_default);
+	printf("%-9s %-16s %8s %8s %8s %8s %8s %s\n",
+	       "distribut", "mode", "n", "m", "get_next", "set_next",
+	       "compare", "verdict");
+	while (argc--) {
+		int i, j, m, n =3D strtol(*argv++, NULL, 10);
+		for (i =3D 0; i < ARRAY_SIZE(dist); i++) {
+			for (j =3D 0; j < ARRAY_SIZE(mode); j++) {
+				for (m =3D 1; m < 2 * n; m *=3D 2) {
+					if (test(&dist[i], &mode[j], n, m))
+						return 1;
+				}
+			}
+		}
+	}
+	return 0;
+}
+
 int cmd__mergesort(int argc, const char **argv)
 {
 	if (argc =3D=3D 2 && !strcmp(argv[1], "sort"))
 		return sort_stdin();
-	usage("test-tool mergesort sort");
+	if (argc > 1 && !strcmp(argv[1], "test"))
+		return run_tests(argc - 2, argv + 2);
+	fprintf(stderr, "usage: test-tool mergesort sort\n");
+	fprintf(stderr, "   or: test-tool mergesort test [<n>...]\n");
+	return 129;
 }
diff --git a/t/t0071-sort.sh b/t/t0071-sort.sh
new file mode 100755
index 0000000000..a8ab174879
=2D-- /dev/null
+++ b/t/t0071-sort.sh
@@ -0,0 +1,11 @@
+#!/bin/sh
+
+test_description=3D'verify sort functions'
+
+. ./test-lib.sh
+
+test_expect_success 'llist_mergesort()' '
+	test-tool mergesort test
+'
+
+test_done
=2D-
2.33.0
