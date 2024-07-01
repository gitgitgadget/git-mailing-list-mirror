Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AF938394
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 22:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719872461; cv=none; b=soiBrhqFIuRPZ0ZOKt9grFS8h7HzOBS1FXMvqhvsqsRcwOXjtEOnaFxPVJnT+/zlvAMkGvgkAfwnNh9Op60pHvYWyBZb6JT/P1HQm/DaYLUupkdc9YfnYLUIKqTP/tia4S8I3X/OopUHas1eqgvXsClBDkT2876V1PO+NyTpX9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719872461; c=relaxed/simple;
	bh=XEGlQHQWW7wpgp6TTKrPsftlvXS5Pxkb8ZmZOVwd2n0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yd1U4/Ky8TGtqsGZI94sHLKzJZEppPT95T7oIfukCg9pxN1IwA93ESJqKFd5JwJZ8vY0uSnijlA4ROqv0k4coMxr1DT4XQRHc6mvnW47/V+L9z1t/AVLdyD+O9jEqFHKzf8YIphQNibEtbw6HCRVE2NufxOaV6zcp3HTw387GsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BCvTSnTd; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BCvTSnTd"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EDDE41BA44;
	Mon,  1 Jul 2024 18:20:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=XEGlQHQWW7wpgp6TTKrPsftlvXS5Pxkb8ZmZOV
	wd2n0=; b=BCvTSnTdmVOPOF+Lf1Yi8iCDjFmOAL1uDFmQGw9WAos8wmJvNuqaOb
	G4zFxISQN+bOjIYSNoC2cLP1zSkWUC5OwX0rP7g4sG5Kl4OblX7ih6WOWXEwF+hr
	4eMoVOBLoCBT14X23exw72K//xH+4Pwb7dOGlRRs9XiNOOLhk4kN4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E4B051BA43;
	Mon,  1 Jul 2024 18:20:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5B8BF1BA42;
	Mon,  1 Jul 2024 18:20:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org,  Jonathan Nieder <jrnieder@gmail.com>,  Josh
 Steadmon <steadmon@google.com>,  christian.couder@gmail.com,  Phillip Wood
 <phillip.wood123@gmail.com>,  Christian Couder <chriscool@tuxfamily.org>,
  Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][PATCH v2] t: migrate helper/test-oidmap.c to
 unit-tests/t-oidmap.c
In-Reply-To: <xmqq4j98vmpw.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	01 Jul 2024 14:14:35 -0700")
References: <20240619175036.64291-1-shyamthakkar001@gmail.com>
	<20240628122030.41554-1-shyamthakkar001@gmail.com>
	<xmqq4j98vmpw.fsf@gitster.g>
Date: Mon, 01 Jul 2024 15:20:57 -0700
Message-ID: <xmqqjzi4u52u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 30EB2804-37F8-11EF-B972-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Hmph.  You seem to overwrite key_val[i][1] ...
> ...
> ... in this test, rendering the key_val[] array unusuable for
> further tests.  Is that intended and desirable?
> ...
> The TEST(setup(t_foo)) pattern is done so nicely to make sure that
> everybody is independent from everybody else, preparing the oidmap
> used for each specific test from scratch.  It is a bit disappointing
> that we are now invalidating this nice property.

It may be just the matter of doing something silly like this to
restore the "different tests are independent and the source of truth
array is intact" property.

The first hunk should be reindented properly, if you are going to
take this and squash into your patch, by the way.

Thanks.

 t/unit-tests/t-oidmap.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git c/t/unit-tests/t-oidmap.c w/t/unit-tests/t-oidmap.c
index 13532aa98b..be2741c6c7 100644
--- c/t/unit-tests/t-oidmap.c
+++ w/t/unit-tests/t-oidmap.c
@@ -14,7 +14,7 @@ struct test_entry {
 	char name[FLEX_ARRAY];
 };
 
-static const char *key_val[][2] = { { "11", "one" },
+static const char * const key_val[][2] = { { "11", "one" },
 				    { "22", "two" },
 				    { "33", "three" } };
 
@@ -116,7 +116,7 @@ static void t_remove(struct oidmap *map)
 	check(oidmap_remove(map, &oid) == NULL);
 }
 
-static int key_val_contains(struct test_entry *entry)
+static int key_val_contains(struct test_entry *entry, char seen[])
 {
 	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++) {
 		struct object_id oid;
@@ -125,9 +125,9 @@ static int key_val_contains(struct test_entry *entry)
 			return -1;
 
 		if (oideq(&entry->entry.oid, &oid)) {
-			if (!strcmp(key_val[i][1], "USED"))
+			if (seen[i])
 				return 2;
-			key_val[i][1] = "USED";
+			seen[i] = 1;
 			return 0;
 		}
 	}
@@ -138,11 +138,12 @@ static void t_iterate(struct oidmap *map)
 {
 	struct oidmap_iter iter;
 	struct test_entry *entry;
+	char seen[ARRAY_SIZE(key_val)] = { 0 };
 
 	oidmap_iter_init(map, &iter);
 	while ((entry = oidmap_iter_next(&iter))) {
 		int ret;
-		if (!check_int((ret = key_val_contains(entry)), ==, 0)) {
+		if (!check_int((ret = key_val_contains(entry, seen)), ==, 0)) {
 			switch (ret) {
 			case -1:
 				break; /* error message handled by get_oid_arbitrary_hex() */



