Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE2B91FA7B
	for <e@80x24.org>; Sun, 18 Jun 2017 10:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752944AbdFRK7H (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Jun 2017 06:59:07 -0400
Received: from mout.web.de ([212.227.15.3]:50118 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752892AbdFRK7D (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jun 2017 06:59:03 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LiFT1-1e8pE31HUp-00nR8O; Sun, 18
 Jun 2017 12:58:40 +0200
Subject: Re: [BUG] add_again() off-by-one error in custom format
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <CACi5S_1j46SbP7cQMdUnULmgGD7xBkSUrS2PKbzq8ZydybHE=w@mail.gmail.com>
 <xmqqd1a8n7o8.fsf@gitster.mtv.corp.google.com>
 <d229403a-d078-87b4-f3e8-89058fa4b548@web.de>
 <xmqqtw3j68rc.fsf@gitster.mtv.corp.google.com>
 <99d19e5a-9f79-9c1e-3a23-7b2437b04ce9@web.de>
 <xmqqwp8f4mb2.fsf@gitster.mtv.corp.google.com>
 <dae96f72-761c-3ed1-4567-0933acc7618a@web.de>
 <20170615055654.efvsouhr3leszz3i@sigill.intra.peff.net>
 <ec36f9fa-5f3e-b511-3985-3d0301b4847f@web.de>
 <20170615132532.nivmj22dctowxssm@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <b0bc9dab-bd93-c321-9f2e-f1621f857708@web.de>
Date:   Sun, 18 Jun 2017 12:58:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20170615132532.nivmj22dctowxssm@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:VFtcR3yQg0hClJ0RCHuDAGbwE0yBiBwU2fBPYoV1Idqw6bCPnFH
 5jluT3VUpsGMNrZ4XG+6OCQ7+65aUPyjb2OPsaw90xC4wHnJ6MzhLxuSHr1T1Fdxl2zpS0C
 f3UPkvR8wUg4UavfY327wT0S89orIHWANOzdGuhkVF+G/ZdlMVtZgWqMF7SgN4TBJLb1NXl
 ZEy6zhDJ6fj4TR6NZF7Qg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WyF3sVoljpY=:L9uwus8v/ediebcrpdh/5g
 WZszH1/i0pq/pTi8zfV9ZueUrQIQD4ny1UgvH4TFCjWsDWITHApnmT/7KB+qHGrd+7ItL3qPK
 QUYm2hPyUcmZbnFV4r6BN7xO1jbSZlRp6l8yF5UoxZfYZj4ECR6KHqKlR7FM9seEk5AeLsvk/
 x7WTCD0uM6Lnz9tcfMlontbINJgVzG3LDRRBMFM4t8Hg2uVGa569+PxSSahYCinz/+HRUT+FW
 bZ+5+0nmrnzXlQl+4KOxckFWQ6A9HpTenvFhGQZizATIV21cOlwSAu0V3iuixvE1f1csqdxJ4
 4cyKH3Y3D+FrT3bl/adXPlVVcMaXIz2joclxriljUPpw/p0LAnTOKvljd6cn/BfaKi/RKLyUe
 TkdCeK11hP5AAlD8eZcaH23B0umPiL4WJ8PB37PtNWvel72isp0aQlCqJjGOxGcPlhmkrs4av
 gDBFzRiXbmPAmJq87xu3Anr2lGj5dxMAKTCbcmNgJWjd8FMG+iU7o6qETaUXbnC6Me/oDJNPb
 7+Sx8Our3CCBOyLzFOwVC8KkPDva1x8BjzCo8IkfFmhKTkS2pVG8FfSl8Xquzhs1Z6dY6Zu3R
 KX7JAAge1qgs3nouDpPr29X1Za6MeK/msc+/V599qHAfoUkv2L0HnOaCB/mm6A9k6kzjSoRHE
 VgHu/rbv8z98gI33Yf8qTfMuBdfB2nLhQnNbMXO66KvJ2weDvvSa+tUYH2YyKwZNplfFfD+Ak
 SKTQTq8ng0MyEwoizD5veBTOEILrPi4ygNLysM8v/uwvfHbnUMa9EquM0h0KgikrZQXXLKWWG
 AMi2pFg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.06.2017 um 15:25 schrieb Jeff King:
> On Thu, Jun 15, 2017 at 01:33:34PM +0200, René Scharfe wrote:
>>> I'm not really sure how, though, short of caching the directory
>>> contents. That opens up questions of whether and when to invalidate the
>>> cache. If the cache were _just_ about short hashes, it might be OK to
>>> just assume that it remains valid through the length of the program (so
>>> worst case, a simultaneous write might mean that we generate a sha1
>>> which just became ambiguous, but that's generally going to be racy
>>> anyway).
>>>
>>> The other downside of course is that we'd spend RAM on it. We could
>>> bound the size of the cache, I suppose.
>>
>> You mean like an in-memory pack index for loose objects?  In order to
>> avoid the readdir call in sha1_name.c::find_short_object_filename()?
>> We'd only need to keep the hashes of found objects.  An oid_array
>> would be quite compact.
> 
> Yes, that's what I was thinking of.

An oid_array spends ca. 30 bytes per entry (20 bytes for a hash times
a factor of 1.5 from alloc_nr).  How many loose objects do we have to
expect?  30 MB for a million of them sounds not too bad, but can there
realistically be orders of magnitude more?

>> Non-racy writes inside a process should not be ignored (write, read
>> later) -- e.g. checkout does something like that.
> 
> Ideally, yes. Though thinking on this more, it's racy even today,
> because we rely on the in-memory packed_git list. We usually re-check the
> directory only when we look for an object and it's missing. So any new
> packs which have been added while the process runs will be missed when
> doing short-sha1 lookups (and actually, find_short_packed_object does
> not even seem to do the usual retry-on-miss).
> 
> A normal process like "checkout" isn't writing new packs, but a
> simultaneous repack could be migrating its new objects to a pack behind
> its back. (It also _can_ write packs, but only for large blobs).
> 
> Given that we are talking about finding "unique" abbreviations here, and
> that those abbreviations can become invalidated immediately anyway as
> more objects are added (even by the same process), I'm not sure we need
> to strive for absolute accuracy.

Agreed.  And processes that add objects and use them later probably use
full hashes (at least checkout does).

So here's a patch for caching loose object hashes in an oid_array
without a way to invalidate or release the cache.  It uses a single
oid_array for simplicity, but reads each subdirectory individually and
remembers that fact using a bitmap.
---
 cache.h     |  4 ++++
 sha1_name.c | 69 +++++++++++++++++++++++++++++++++++++++++++------------------
 2 files changed, 53 insertions(+), 20 deletions(-)

diff --git a/cache.h b/cache.h
index 4d92aae0e8..8c6748907b 100644
--- a/cache.h
+++ b/cache.h
@@ -11,6 +11,7 @@
 #include "string-list.h"
 #include "pack-revindex.h"
 #include "hash.h"
+#include "sha1-array.h"
 
 #ifndef platform_SHA_CTX
 /*
@@ -1586,6 +1587,9 @@ extern struct alternate_object_database {
 	struct strbuf scratch;
 	size_t base_len;
 
+	uint32_t loose_objects_subdir_bitmap[8];
+	struct oid_array loose_objects_cache;
+
 	char path[FLEX_ARRAY];
 } *alt_odb_list;
 extern void prepare_alt_odb(void);
diff --git a/sha1_name.c b/sha1_name.c
index 5126853bb5..ae6a5c3abe 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -77,10 +77,46 @@ static void update_candidates(struct disambiguate_state *ds, const struct object
 	/* otherwise, current can be discarded and candidate is still good */
 }
 
+static void read_loose_object_subdir(struct alternate_object_database *alt,
+				     int subdir_nr)
+{
+	struct strbuf *buf;
+	char hex[GIT_MAX_HEXSZ];
+	DIR *dir;
+	struct dirent *de;
+	size_t bitmap_index = subdir_nr / 32;
+	uint32_t bitmap_mask = 1 << (subdir_nr % 32);
+
+	if (alt->loose_objects_subdir_bitmap[bitmap_index] & bitmap_mask)
+		return;
+	alt->loose_objects_subdir_bitmap[bitmap_index] |= bitmap_mask;
+
+	buf = alt_scratch_buf(alt);
+	strbuf_addf(buf, "%02x/", subdir_nr);
+	xsnprintf(hex, sizeof(hex), "%02x", subdir_nr);
+
+	dir = opendir(buf->buf);
+	if (!dir)
+		return;
+
+	while ((de = readdir(dir)) != NULL) {
+		struct object_id oid;
+
+		if (strlen(de->d_name) != GIT_SHA1_HEXSZ - 2)
+			continue;
+		memcpy(hex + 2, de->d_name, GIT_SHA1_HEXSZ - 2);
+		if (!get_oid_hex(hex, &oid))
+			oid_array_append(&alt->loose_objects_cache, &oid);
+	}
+	closedir(dir);
+}
+
+static int match_sha(unsigned, const unsigned char *, const unsigned char *);
+
 static void find_short_object_filename(struct disambiguate_state *ds)
 {
+	int subdir_nr = ds->bin_pfx.hash[0];
 	struct alternate_object_database *alt;
-	char hex[GIT_MAX_HEXSZ];
 	static struct alternate_object_database *fakeent;
 
 	if (!fakeent) {
@@ -95,29 +131,22 @@ static void find_short_object_filename(struct disambiguate_state *ds)
 	}
 	fakeent->next = alt_odb_list;
 
-	xsnprintf(hex, sizeof(hex), "%.2s", ds->hex_pfx);
 	for (alt = fakeent; alt && !ds->ambiguous; alt = alt->next) {
-		struct strbuf *buf = alt_scratch_buf(alt);
-		struct dirent *de;
-		DIR *dir;
-
-		strbuf_addf(buf, "%.2s/", ds->hex_pfx);
-		dir = opendir(buf->buf);
-		if (!dir)
-			continue;
+		int pos;
 
-		while (!ds->ambiguous && (de = readdir(dir)) != NULL) {
-			struct object_id oid;
+		read_loose_object_subdir(alt, subdir_nr);
 
-			if (strlen(de->d_name) != GIT_SHA1_HEXSZ - 2)
-				continue;
-			if (memcmp(de->d_name, ds->hex_pfx + 2, ds->len - 2))
-				continue;
-			memcpy(hex + 2, de->d_name, GIT_SHA1_HEXSZ - 2);
-			if (!get_oid_hex(hex, &oid))
-				update_candidates(ds, &oid);
+		pos = oid_array_lookup(&alt->loose_objects_cache, &ds->bin_pfx);
+		if (pos < 0)
+			pos = -1 - pos;
+		while (!ds->ambiguous && pos < alt->loose_objects_cache.nr) {
+			const struct object_id *oid;
+			oid = alt->loose_objects_cache.oid + pos;
+			if (!match_sha(ds->len, ds->bin_pfx.hash, oid->hash))
+				break;
+			update_candidates(ds, oid);
+			pos++;
 		}
-		closedir(dir);
 	}
 }
 
-- 
2.13.0
