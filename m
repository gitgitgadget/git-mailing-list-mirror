Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4763D1FA7B
	for <e@80x24.org>; Sun, 18 Jun 2017 10:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752970AbdFRK7L (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Jun 2017 06:59:11 -0400
Received: from mout.web.de ([212.227.15.4]:64856 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752925AbdFRK7H (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jun 2017 06:59:07 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MEmbK-1dbPDb0sck-00G5Ey; Sun, 18
 Jun 2017 12:58:53 +0200
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
Message-ID: <b728352d-7fa5-2adb-af00-5f232b85b2bf@web.de>
Date:   Sun, 18 Jun 2017 12:58:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20170615132532.nivmj22dctowxssm@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:/6ma6vvxfxZZ9j4ELsX2GH/holUAuryAOHJ0m6FRUXrh524ZcvJ
 cPJB08HmJU4M18Z7FNKAzmj7H0snsxrZBq4RUs+c0b9BmBFFu6amTThQ4HKyeyhPdEGkuk2
 7czsituEe2Y73nZLwxuHXNcWMlGtZZjDOAKS7ATLpQm4137MjnB4X7gKo2pPcyfU4PpuEYS
 ljizBoUctr8jQZ8hlxVQg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:22Mfnbb+Of8=:xh49W53skQGceqwsUi7YEF
 zacWNotpYvbeAoQ3E4yU4nSYjmhfId0PEKhkK+n4A6QM8dQ/xVC5EPXibAS7XSx1lcgYF3o5V
 Uxxt0jqviQH5nPII6HFPfwWWzRAa7z+bqe9cGSWUcqgVHfeKZ1DmwFggZDegwpy5S9ZlU5M7q
 YzsAd9qcsLt+/4DvtkYwtoRD6SSqrDUd120ZJ53G8FTBYfGtx3Isa1SMNPzIr0QLXITMs/RlZ
 1xHOkG+gLA1P1TTEzyqmduK9BhbCdXl888cFx/cCkKT/OOMR3/jJBzBvPYSxmCx1v5tYLPWuV
 mHGsPmi/Ryy5ZqNpZ3nvDRu9ANGsoI9UCMQrlet96RS8U76YDlyL46nmynPGbvz+kqsc1ml2X
 5FHrcXjKzJHq4yRowIigkEt1q0/J/b2Uzp0wTGYFjRzlDj4tsU0HBHlCXVMAoF26rzcVF76UU
 KBqQZqcQcZhrDme/OHev8DdoimZquY8EdDr7pqHOJ9w1r3k8gt4AHkl1nF6A1xiXc8l8Md3Ls
 I7isnlFSNAUjjFbjFKV5yIIpf0EB2yqFmvZo8PzW5t41U9fG2o4NpVV8KxWXXYPNRgdkt2AMu
 Zh706v/+MGTmXJnTiDlLWhBTBJZ4ufoRix0ab3TG5cr0ZF7wdcBNJDfOJnDmYcIKdSnDUIywx
 426ms7Pb3OeexQ22lq7jsFnKbdL1tyU9wsYYjKkWfS69sYssz69jvXjwf0Ns0BVzLH14yPlIW
 5JMwNu91cOaHjVivpsEnoQLF5AQ/I5QsgZTwkrOIK2WxAosFcq3Z1nJqknCN3i9ioQjBvGR4M
 altQYHq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.06.2017 um 15:25 schrieb Jeff King:
> On Thu, Jun 15, 2017 at 01:33:34PM +0200, René Scharfe wrote:
>> Can we trust object directory time stamps for cache invalidation?
> 
> I think it would work on POSIX-ish systems, since loose object changes
> always involve new files, not modifications of existing ones. I don't
> know if there are systems that don't update directory mtimes even for
> newly added files.
> 
> That would still be a stat() per request. I'd be curious how the timing
> compares to the opendir/readdir that happens now.

Modification times wouldn't be exact, as you mentioned above: An object
could be added just after checking the time stamp.  So perhaps we don't
need that, or a time-based invalidation suffices, e.g. we discard the
cache after five minutes or so?

Anyway, here's a patch for stat-based invalidation, on top of the other
one.  Array removal is really slow (hope I didn't sneak a bug in there,
but my confidence in this code isn't very high).  No locking is done;
parallel threads removing and adding entries could make a mess, but
that's not an issue for log.

Timings for "time git log --pretty=%h >/dev/null" in my git repository
with 5094 loose objects on Debian:

        master       first patch  this patch
real    0m1.065s     0m0.581s     0m0.633s
user    0m0.648s     0m0.564s     0m0.580s
sys     0m0.412s     0m0.016s     0m0.052s


And on mingw with 227 loose objects:

        master       first patch  this patch
real    0m1.756s     0m0.546s     0m1.659s
user    0m0.000s     0m0.000s     0m0.000s
sys     0m0.000s     0m0.000s     0m0.000s

So at least for Windows it would be really nice if we could avoid
calling stat..
---
 cache.h     |  1 +
 sha1_name.c | 32 ++++++++++++++++++++++++++++----
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 8c6748907b..386b09710d 100644
--- a/cache.h
+++ b/cache.h
@@ -1589,6 +1589,7 @@ extern struct alternate_object_database {
 
 	uint32_t loose_objects_subdir_bitmap[8];
 	struct oid_array loose_objects_cache;
+	time_t loose_objects_subdir_mtime[256];
 
 	char path[FLEX_ARRAY];
 } *alt_odb_list;
diff --git a/sha1_name.c b/sha1_name.c
index ae6a5c3abe..baecb10454 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -77,6 +77,24 @@ static void update_candidates(struct disambiguate_state *ds, const struct object
 	/* otherwise, current can be discarded and candidate is still good */
 }
 
+static void remove_subdir_entries(struct oid_array *array, int subdir_nr)
+{
+	struct object_id oid;
+	int start, end;
+
+	memset(&oid, 0, sizeof(oid));
+	oid.hash[0] = subdir_nr;
+	start = oid_array_lookup(array, &oid);
+	if (start < 0)
+		start = -1 - start;
+	end = start;
+	while (end < array->nr && array->oid[end].hash[0] == subdir_nr)
+		end++;
+	memmove(array->oid + start, array->oid + end,
+		(array->nr - end) * sizeof(array->oid[0]));
+	array->nr -= end - start;
+}
+
 static void read_loose_object_subdir(struct alternate_object_database *alt,
 				     int subdir_nr)
 {
@@ -86,15 +104,21 @@ static void read_loose_object_subdir(struct alternate_object_database *alt,
 	struct dirent *de;
 	size_t bitmap_index = subdir_nr / 32;
 	uint32_t bitmap_mask = 1 << (subdir_nr % 32);
-
-	if (alt->loose_objects_subdir_bitmap[bitmap_index] & bitmap_mask)
-		return;
-	alt->loose_objects_subdir_bitmap[bitmap_index] |= bitmap_mask;
+	struct stat st;
 
 	buf = alt_scratch_buf(alt);
 	strbuf_addf(buf, "%02x/", subdir_nr);
 	xsnprintf(hex, sizeof(hex), "%02x", subdir_nr);
 
+	stat(buf->buf, &st);
+	if (alt->loose_objects_subdir_bitmap[bitmap_index] & bitmap_mask) {
+		if (alt->loose_objects_subdir_mtime[subdir_nr] == st.st_mtime)
+			return;
+		remove_subdir_entries(&alt->loose_objects_cache, subdir_nr);
+	}
+	alt->loose_objects_subdir_mtime[subdir_nr] = st.st_mtime;
+	alt->loose_objects_subdir_bitmap[bitmap_index] |= bitmap_mask;
+
 	dir = opendir(buf->buf);
 	if (!dir)
 		return;
-- 
2.13.0
