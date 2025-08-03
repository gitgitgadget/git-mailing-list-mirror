Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5936EDF76
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 11:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754221114; cv=none; b=Td2todPDPlmtxsv/OV4AW85KYqNt/phQPAxzRyhTP5vAN3KR94EYOIgmPnLjsxc/1uBrdD/WYRe7kzQ/6c+yd0U9TLIGGDrfgiDCClmxLhM0H5SNZaxjlkdkhZJAfoutPmUp2kKEPejtfjgTQhFPlL4duH7+gfFNj7OaG6CMOrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754221114; c=relaxed/simple;
	bh=JZg04Jjfi34uSQBX2Ect4uAJBIwVRG4FpKg89sE6Mso=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=XHIg1gCJyxC3UZZ7suGdYXn56iSJoHLOBmT293xgRAz5TbgzXp5vKaFZ1oOLCuB4AK6vALrGPb9Y5r2lpyAimKwMmmjfOuunZphHjaseggO8px1Lgk0AOmaQ3aKcu4hIMpdiMripsa0/JmJsnaNIdcqRyHveqAQMDWuSIZ1JUss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=uJLxAkOP; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="uJLxAkOP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754221110; x=1754825910; i=l.s.r@web.de;
	bh=fKTWqfKkYxlKIZlf3Q+O5bfvsyLQ/ULmAMWySL5iO2Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uJLxAkOPh5GCmQ9ssz5cIhtNfJCAOkJU5ubE7etdtofI0q+XIv75zCadj6FCRMSY
	 RCrZa6B99Cn7XH+nmormJbzq9YBsqtcPKaSGtP4IWeFQIyd7IdyZxedFpFZLE0/FE
	 +FEfWBB2TydfTEq8bhEIWpZrzv63ao5WsBVPSQkMT2iNr3fmmkSrsvrPmwmpGOek6
	 HpD/uLFJgE6ey0/d7pTkF1gGARALjOo5tVzcrOpjysiQXidcRJ+Ana5ia8vCFO0RH
	 kP+flk/HWkpUpVQyyr/jXELlkVmcfPu8iQk+HMDukiFyvfx8KyGOSBH/wJ8DnaTG8
	 ZOi4fku+2Dr5em34Og==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MNfY9-1v1Rdd125b-00Y4KB for
 <git@vger.kernel.org>; Sun, 03 Aug 2025 13:38:30 +0200
Message-ID: <81c7deee-75e9-471a-84f3-8604c0860ee3@web.de>
Date: Sun, 3 Aug 2025 13:38:29 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/2] describe: use prio_queue
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oO3jHWuBwK5xsXLW77pqfoRFSpFxub8ReVHrAoZJLrwUpWbY0gb
 27SYSON59R4w2kG54Z4HQvbPiy4RKcPX+5GM97avWtl9SJgF4my5sePQsfd+Bxtuw+xdbgJ
 ktVsZf4+Y2cXJuTsyYU4KY+eZn3/9c6zquIn7KD+PxAtDnVyNwDiGita6RpZ/gA/IenJ+CR
 /O5Di8XKjb1mkxe8kQ5yw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SAv6u2gJbEU=;9JyZE5fJD8ZV18A+2QXCaY/D6Pc
 PZKwU980O7Qvnyo9UqRipKCRSW7N090zY6Bf0+bfQR+8sAMnJI4RepISMRYMNItOV565cvoa5
 58+K/uRW7QwWtmeqwXe3U5JpgCELxS/tofKZFzQLa7ro3N/h/eBGnwO4Mwtu7Veb6Z6YE5ioQ
 OQ23CkdC+fUTwLyTYFZDsMAF9AZye3xkJbvkEzQlojWJGWo73CZtt0uphPOjqIZE3qfsavSvp
 72OTBfrXGhbYGq/pVARvE+C72K4Y0mVc4zFtcWUHnTpj2c/r7eZ/uTDTihNQrh9vhkZyVWcEj
 KoN8UZH+os8W7bBtwwQrpkzEDujcAEoiEftw6MzfgZPiJ9WV5KPLFTdaBHfMG/mTOcJ1pjnDA
 P6VF+EgVqBkjX2P6+VxQ9qFCyN3LO8FZLFDaVb7nhVsWnNdVA0ImmqA0FQbBfkBMsWmVjAUWy
 u9mUkFQBZWpKLZfq3k4B2BwGwlH8azyDFdSY7fCTvhc8Anpi/9p+jCRVfytcX/dH4muqIp+CK
 QePs+cci3LvwsaBBPgHasvD4D3TZGr70MPDKabn42unkm4/ZHmiFWyCFpQrzuNgKzTjS0MN63
 /brWbJBiIWNPduq7RgajdEp6TiAVYZ78a+FeuX+IBm1v070aZ7y4TR5u4QIua6t+k9wanJ410
 1b79TybnTdNKximRrM7cNgHlmA71GWZC0CXL+SX1v4qkyysE+xUtqEHHunMncTmTDDtTOnIFv
 FvmUUikZ1VnNngRPq9KLyPauRXZPweHYGGSKVXakxn+LwTlMs82HznObH2P7bE+XFEYD1ESg6
 msMEEQQ9PTKVXlZDz5hIE1HqShU6HoEtH+qM6e/z+L+sbC+miX56twEWGeRxCCd6l0wJOwenA
 WCmQyl5edUyliCwgCVe9cI71nupV3UvzKl4EnY3LS1gbT9M2hFLZyu9Y+JL/rO98q4pyYjPzg
 mNadceORFBPcqEmvMeySTDSaKxE8tCWwgxqw0nFFbpD4iiuncCmaZF+9CFlKGKIid31ajWV7K
 nZXPKwwtLW1hSwe1ZpyrIInR+SmIFCj4Oh8+uw4dzgZjSRm9Zrk/ERTM5puuCMHcBabymUAb/
 OGLMthxTV/douMS8PdZNNR3P3U008fqw2C0f9ap2Oqvulw91tdsd6RH/rlPXKC+dzAZABpzYm
 W6QWAFE53FbJSjBv7An0ahvT/Os0doul27DzsIrdaPbZfVIuPkAjlj+epcFkrvwlJAPvm58eC
 BYHyxfbiXkXh+tpQkQeko8FmHPtgdx2LDqQDBqQOVbYL8ZnkS/bmm4j72IcRhiCTLBrokL+l7
 +kix9D1rIUHQa1J1VLa60ySknbLBMqWy581+Qd5LuxVJ3eI+vYSzwf96HyTUxKjH6C5RMzILG
 trvepJNEmlwhkzRNSLb2LMadh4Wa+SvQ5mCH7uZ/PF5ZV+4KXNzyi9rjtfSIAhDsC7tLqGkmp
 k1JVQUA8iny0MGxIBy0MbpviMUebLSXkyggU47VIrly4P1C1FZ70gGPon2jMGThSDBHj1zUJ2
 Y6IgHfKwtc0Ukd8fUmAHDoP9Yed4IWL7jy5BzCO7q3xXHayZfoUqyLY792iA9b9jqrgwPxSBI
 pW1FF6OrcCzdFxCLexoPLvf3WoCgf3QNVSOYV+WH3gslZ51+bhpWAH7BUAA1mUC40eGV7ypWm
 PFUW8x+smdteA23gPTwUWN5n0ZJmzTgY/YmiC0uNdjuEwa0hAZ8x3yNlgFcR5BRAOXmDOVIJu
 aiPPLWyWMnIo59xEo3E+VhEw4orHsAeYgYCv9JlRoY0Bcv+LpJjh6/3pJEBIBMKxK27p0Vgo7
 nG4Jhy4mYLTcEpRMKZ5vk1XYdBafKkhGxNAqwD13N+KHMyTwOOLUDRCalkXfl08VLDNbugEYs
 he8SD2o5QU3dc3IcWezQCOqTDqe+qBBVbIFqU2PQ3lLMDup5k1T3630Q9KCc7lI8Xf4a309m6
 7nl9lRr02xXOvDdCxRFTFnCRgYmri3bLjJkxtHb+YPcXdlr0RoViJYovxfDObcnY8AuyvzCjb
 Vp/Hnkkm3R4zWhO1i4GGppCfN8Ftsv4+CzJN83Tc/OeDiE+E6fpJugZK0Zub/CP7j04DDhPop
 jsWeBOCoIzzZHN2qfYblsf0P3/mr6E70i8nP4bcQ3msFCIHC5klRjpCtBpdKksMiNVcwmhoCx
 2RNNDCf0lP0hgel81cqZkPedKN1U5lOV+dj8ZX0UqMaHFQxnAWFOUFwwWZCNxfCJCWrBvdtyJ
 PIK7E9cW7jDDV5bF9DHDnisJRjMNPuk2Cvk2vI4GGz/oS2+ZC8mW4dy9keSQXNgOYrsfPzRlc
 e9vTwP607hZZON71bBTN/VUW3P9+InQelT+21PbQvawsGbpgMo0I/Gs1SQSpo2QDbETltQTNg
 mIusO0KPzDiYusPUTm2FADkkUfxgAJIjprBIXPoqJYI//RJ/C0p8kPC+ftSz9EmZ21OxrCslr
 VMXbABvj8xFfOu+Zgh5EftE9R4oeseBs6yenbYXlL9Ac+WHaO7JdUl7qTgqp+lqq9asCRTiD0
 J6/lJjatehDej/6QeOF/GJr40RW8X4gHzWj0TvlQ0Y29SOdCjH77zNk9pPcXzMsnYkNySr9Bu
 lcZQF6gCpNlMr4Em50Bij21At166GzQF63EY7vkaEXFLllM7ZdlKuhKcugbfBAUgDMpgxbYE/
 o/Y/htTi8hCBsEHdeqyxspcAsCPPCbLOVfWm/PgBMf4kiambnUoMK5FrKOXH3fClJs8+dpjre
 kSQIzP9bjC0FCwRS/UhQaq+Qnm+LxTCOb/kA7E8FsE6YQjPxZRUADrtkxuJP8uznTA4XC1u5t
 14wuSU/glyQSSX+WF+EpJZApOlG2P21zHoDWq0ctWZHLD3FzkGQ0zaNguQ8xoXanc9rYh7njo
 6SKtUDAJCpWxLaI7nz4AhuEVVWwer/dg/61g/z+DuCtW/9dgaUZeu1BtzTLc0JaOnUU/jaZ8L
 xYty2/95rMRJTKUsQHw8zG/OVkVYT8DXf7I0KzVZ0DdsSY4FLvKqBaJidH85iJrIAn/teBzSv
 kqm2hH+cE0j7oaqBo9ofy7mrvlouWV6zXa3MTLW8r7yzlDkpKoWmG+NFgwzl/R+LT1YmLLCBO
 x41WlSgGyxKYMr0/TL+JlnnW1j6ceyjCGlHxtJGnl38txq0oeJH4xUyzigz9yJx6XlDNVyG33
 CgdocIxHGF//xdxsJNofw79prX62duPxtNUJucPKOdCjLd26woJpHeqzjK2xcrtHuZfQyQ4tt
 S4WwQmIZBmd2K/6zN5NubZKVCvcFTuWDKEwq34geyxSoIh9GUXUtUzsOaK+o5YwH1f7m4sJNY
 Csl1qrh1zW3piiRd75oFOXFBQNXc6gNsGf3KSjiHb/t83IVdhDvPq8nj8IsBkeYE64+IyazDT
 YUslUcDDoiUPCWmpG7mna1kdhs9+wc1hjr5Cvfsj8UhC3qe3nsfnwb4pFVLi9AsohS9D+5e3N
 Y0LFRrBqZ6GUArGTCMahpQD16QuRHGA74xwfnATRusqKJ2y909CsV

Replace the use a list-based priority queue whose order is maintained by
commit_list_insert_by_date() with a prio_queue.  This avoids quadratic
worst-case complexity.  And in the somewhat contrived example of
describing the 4751 commits from v2.41.0 to v2.47.0 in one go (to get a
sizable chunk of describe work with minimal ref loading overhead) it's
significantly faster:

Benchmark 1: ./git_2.50.1 describe $(git rev-list v2.41.0..v2.47.0)
  Time (mean =C2=B1 =CF=83):      1.558 s =C2=B1  0.002 s    [User: 1.492 =
s, System: 0.051 s]
  Range (min =E2=80=A6 max):    1.557 s =E2=80=A6  1.562 s    10 runs

Benchmark 2: ./git describe $(git rev-list v2.41.0..v2.47.0)
  Time (mean =C2=B1 =CF=83):      1.209 s =C2=B1  0.006 s    [User: 1.143 =
s, System: 0.051 s]
  Range (min =E2=80=A6 max):    1.201 s =E2=80=A6  1.219 s    10 runs

Summary
  ./git describe $(git rev-list v2.41.0..v2.47.0) ran
    1.29 =C2=B1 0.01 times faster than ./git_2.50.1 describe $(git rev-lis=
t v2.41.0..v2.47.0)

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/describe.c | 51 ++++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index fbf305d762..80722ae0c0 100644
=2D-- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -23,6 +23,7 @@
 #include "list-objects.h"
 #include "commit-slab.h"
 #include "wildmatch.h"
+#include "prio-queue.h"
=20
 #define MAX_TAGS	(FLAG_BITS - 1)
 #define DEFAULT_CANDIDATES 10
@@ -249,24 +250,26 @@ static int compare_pt(const void *a_, const void *b_=
)
 	return 0;
 }
=20
-static unsigned long finish_depth_computation(
-	struct commit_list **list,
-	struct possible_tag *best)
+static bool all_have_flag(const struct prio_queue *queue, unsigned flag)
+{
+	for (size_t i =3D 0; i < queue->nr; i++) {
+		struct commit *commit =3D queue->array[i].data;
+		if (!(commit->object.flags & flag))
+			return false;
+	}
+	return true;
+}
+
+static unsigned long finish_depth_computation(struct prio_queue *queue,
+					      struct possible_tag *best)
 {
 	unsigned long seen_commits =3D 0;
-	while (*list) {
-		struct commit *c =3D pop_commit(list);
+	while (queue->nr) {
+		struct commit *c =3D prio_queue_get(queue);
 		struct commit_list *parents =3D c->parents;
 		seen_commits++;
 		if (c->object.flags & best->flag_within) {
-			struct commit_list *a =3D *list;
-			while (a) {
-				struct commit *i =3D a->item;
-				if (!(i->object.flags & best->flag_within))
-					break;
-				a =3D a->next;
-			}
-			if (!a)
+			if (all_have_flag(queue, best->flag_within))
 				break;
 		} else
 			best->depth++;
@@ -274,7 +277,7 @@ static unsigned long finish_depth_computation(
 			struct commit *p =3D parents->item;
 			repo_parse_commit(the_repository, p);
 			if (!(p->object.flags & SEEN))
-				commit_list_insert_by_date(p, list);
+				prio_queue_put(queue, p);
 			p->object.flags |=3D c->object.flags;
 			parents =3D parents->next;
 		}
@@ -316,7 +319,7 @@ static void append_suffix(int depth, const struct obje=
ct_id *oid, struct strbuf
 static void describe_commit(struct object_id *oid, struct strbuf *dst)
 {
 	struct commit *cmit, *gave_up_on =3D NULL;
-	struct commit_list *list;
+	struct prio_queue queue =3D { compare_commits_by_commit_date };
 	struct commit_name *n;
 	struct possible_tag all_matches[MAX_TAGS];
 	unsigned int match_cnt =3D 0, annotated_cnt =3D 0, cur_match;
@@ -359,11 +362,10 @@ static void describe_commit(struct object_id *oid, s=
truct strbuf *dst)
 		have_util =3D 1;
 	}
=20
-	list =3D NULL;
 	cmit->object.flags =3D SEEN;
-	commit_list_insert(cmit, &list);
-	while (list) {
-		struct commit *c =3D pop_commit(&list);
+	prio_queue_put(&queue, cmit);
+	while (queue.nr) {
+		struct commit *c =3D prio_queue_get(&queue);
 		struct commit_list *parents =3D c->parents;
 		struct commit_name **slot;
=20
@@ -397,7 +399,7 @@ static void describe_commit(struct object_id *oid, str=
uct strbuf *dst)
 				t->depth++;
 		}
 		/* Stop if last remaining path already covered by best candidate(s) */
-		if (annotated_cnt && !list) {
+		if (annotated_cnt && !queue.nr) {
 			int best_depth =3D INT_MAX;
 			unsigned best_within =3D 0;
 			for (cur_match =3D 0; cur_match < match_cnt; cur_match++) {
@@ -420,7 +422,7 @@ static void describe_commit(struct object_id *oid, str=
uct strbuf *dst)
 			struct commit *p =3D parents->item;
 			repo_parse_commit(the_repository, p);
 			if (!(p->object.flags & SEEN))
-				commit_list_insert_by_date(p, &list);
+				prio_queue_put(&queue, p);
 			p->object.flags |=3D c->object.flags;
 			parents =3D parents->next;
=20
@@ -435,6 +437,7 @@ static void describe_commit(struct object_id *oid, str=
uct strbuf *dst)
 			strbuf_add_unique_abbrev(dst, cmit_oid, abbrev);
 			if (suffix)
 				strbuf_addstr(dst, suffix);
+			clear_prio_queue(&queue);
 			return;
 		}
 		if (unannotated_cnt)
@@ -450,11 +453,11 @@ static void describe_commit(struct object_id *oid, s=
truct strbuf *dst)
 	QSORT(all_matches, match_cnt, compare_pt);
=20
 	if (gave_up_on) {
-		commit_list_insert_by_date(gave_up_on, &list);
+		prio_queue_put(&queue, gave_up_on);
 		seen_commits--;
 	}
-	seen_commits +=3D finish_depth_computation(&list, &all_matches[0]);
-	free_commit_list(list);
+	seen_commits +=3D finish_depth_computation(&queue, &all_matches[0]);
+	clear_prio_queue(&queue);
=20
 	if (debug) {
 		static int label_width =3D -1;
=2D-=20
2.50.1
