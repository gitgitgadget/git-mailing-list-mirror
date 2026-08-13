Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A901419A4
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 07:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786606563; cv=none; b=MokSpRQGE3HEBzfJwjuHEY5bc9k7Uv658U4H8fWnWpqvJXAByULR01Joz3ZCY7emDRdBW6XdN8EKO3/kctqcqykrAkzQbehgXbrbM4L+OysGOj5pd63HHFhBBj3o3/ll/9xr639YZyyUx4P2iuJ8DXZN/WQlugObRehSkrf9BtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786606563; c=relaxed/simple;
	bh=w2G+zl+9Rq8X3cShPKrVTdKYJVeG0Eq+d89XHi3/cz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+aI8otfydD6SHYAJxFA9mGWLsjd4To3jcGt60YJFBXrwXJ43cfcp7NecPILs0zpyjQXz4q/6ZO0Cd0J7NL7rF5B/cJTJpUilAasWoWMHVpVx5KZvDHrdddJ1BUlyoEEunAcGN54aNrMkm/DpT3CLIunJe9L71buHJf0v8ztQ2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jaxN5n2H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bvL6tpMS; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jaxN5n2H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bvL6tpMS"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7E11A7A0112;
	Thu, 13 Aug 2026 03:36:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 13 Aug 2026 03:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786606560;
	 x=1786692960; bh=vjnVUeMmuMtv52Hp1iTm3bUaBylI11YW2S3iXZelm9s=; b=
	jaxN5n2HOv74RFSC2xuy+B5b9y7FSLQdrexGHXl6vBQsF4AiGVvthjwWvP5rO/er
	YkZWEN35ox1VVnthiDTUo81Xgh3keFsilk9Z+7SivsKcIPlI75155ToojmbFxiXp
	IeeUN+Dx9RYuRKGWkNIaYbXPRB8RHCx2xkdlQIuyOfdjQYNJznD570tNkdH1909M
	kKdEcqJt6QiG7pDX6aN+HXVkVoaLR5HsKEZgrEZXhR6YeajOWO9UpMAWqbCFwlWw
	etotXvjVh7d5WmlH8HJvdNMkD/RVdlWanG1ngYj/FRJlUDs263NWqMv5hEBaNEPT
	YHyR1JXced6Vdfsi/3Metw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786606560; x=
	1786692960; bh=vjnVUeMmuMtv52Hp1iTm3bUaBylI11YW2S3iXZelm9s=; b=b
	vL6tpMS1X4rb1dMQ4cfyoVq3CImjr0JJ3zV1ibi5e/i0Vopra8BQZIjr0ydnQ4NB
	U0LBS7KFEVupFO/Bb9PXqfTha6H2yubtMc0xw1DLZ5JOInSTzSaAvMAkBbbpmg0P
	3aOaonsRFrVrENinupgiz5kVxIprUVnc7qTB8JYqvvpoE2QiEvlZ6JjPcMBvtNQd
	uR9ICe/PU3yzC7qt59igMVUNmzyt6OUWz+gqbo1tBeiL0dEmuU7NEIJ7xAynNzqV
	rroXg4fWqaerLoEoDFVDwjiOvMQCqkvVD+x8uoSACNVokCLT4PtLlxo7+CIBHslc
	oMUrrtk/lkhBWpHXQA49Q==
X-ME-Sender: <xms:4HN9amtd6KUpRPndWMVIzkXQFOIboiO19YAVgV3-edBE4D_sL95nDg>
    <xme:4HN9ai7gUwJnlagGYhMtbwkzHjO1Gnc5qYX5dEnTFABxAAEh89VqUd7-f03X8UWEu
    HcA8lv2ZWdi82a086VpEn_PHHuc8GUg8WE9Pw4CMlU1f2ozYFTKkw>
X-ME-Received: <xmr:4HN9avLPBRxMiVyBGNdS4LUhaSp67FlTrFTMppBQ3ZdnswfEkuwaapyvO1Agm8JGz7K-7ZWdRzd2GnDPKePdDCkLndDjKgOw-vZ8uO6TuNhV>
X-ME-Proxy-Cause: dmFkZTF5o5E/EqrYXj1VcsvjfphNTU58kikBg/m222MVxQ06QzHtfSJ++mCaOOiDMCAFAt
    L93L+HsjIy6RzC2nvsewNDBmDkBNiyqxoykU1wbWwBa9Zx/w/OPtt8tquJ9uZg4/Aas/ye
    Q+4sWkQbG2KYVqh8wy1N+FnYP3BGEW2GXRwlPFkEgpA6XJqICDq/LNJ1CrCuizWku429El
    iYRX2RUHh05SSK3gv3b87RNGhG8iMULYJGWIkbmC0tkS6/PbnjTk/C5YYO03SddB3Gn0sB
    qf2ohZZQ/bE1+2S7SF6lr8VO0DyZ4lUwgLFFFqcKemJHWEiGY25F4wA1Eo/wdaLs45fmHy
    mLE/vg9d1T0J4Xb/vJopuWA6jU7x283JPMbO2oV0c0UO43MsXUkdy/ztNMqW1Bl+zN12h9
    Lu7tTiNLtKtHD3ZkO52hwqnl/WZqq3vTJYSZnTD4jFYyDSKqaF6UM9u80aQ0vDUFwhtOVT
    igHMZXXz4pFCruTSZLNGvm6/UZ4eiH9tCOSHZV20/fJrb5oSWVciWsFahmJagtMvBNlPVE
    95nc0gtGuQ6DCpZuKZCYCf830Set4a+LAOoSrdnJtw7UbM/S3XFkHicAxL60fI9Ta2/Dax
    Bi/nxe6ch0gPp/KIsD70Z6lZ0cPRdkxaPgnioUJSuCNKc8KQpyWgzJ4MCQog
X-ME-Proxy: <xmx:4HN9aq55L58dwpDWHSo5b9Pp1GxEAM1w5QoedVMPAlkEwC_0IQ8SYA>
    <xmx:4HN9aqyeUukThsFOWVKH_l7TbLoeUYho_VA9unQcxpHUWkrPASHX5A>
    <xmx:4HN9amaY3QvHGyj2kbhXskt8oDyOVdxHUqxSgp93Q30wZXwqe8eOdQ>
    <xmx:4HN9akSRIITlUBqbX0zqLv2MyimAN5-FwnpaH5wuHg-OHEM2meOC9A>
    <xmx:4HN9avInbW5N7juvaWGcnX1N_ZsRLebijQknycNFYMOKBGjf4ULH68e3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 03:35:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e9fb3428 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Aug 2026 07:35:56 +0000 (UTC)
Date: Thu, 13 Aug 2026 09:35:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] packfile: fix perf regression with many packs
Message-ID: <an1zz02GNqDu-0Oz@pks.im>
References: <pull.2202.git.1786561870638.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.2202.git.1786561870638.gitgitgadget@gmail.com>

On Wed, Aug 12, 2026 at 07:11:09PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Since 589127caa730 (packfile: move list of packs into the packfile
> store, 2025-10-30), there is a performance regression when many
> packfiles need to be loaded: `packfile_store_add_pack()` now calls
> `packfile_list_remove_internal()` to detect whether the packfile was
> _already_ in the list, if if so, move it to the end of the list. This

Nit: s/if if/and if/

> function linearly scans the existing list before every insertion. Newly
> loading N packs therefore has complexity O(N²).
> 
> In one reported use case (https://github.com/microsoft/git/issues/970),
> N equals 37,815 and caused a slow-down of a simple `git rev-parse
> --short HEAD` (which is regularly executed as part of `GIT_PS1`) from
> 0.4s to 4.5s. In another, heavily exercised CI scenario, clone times
> increased from under 2 minutes to over half an hour.

Wow, 38k packfiles is a lot.

> Let's fix this by establishing a fast path for known-new packfiles.
> 
> The keen reader will note that there is currently only a single,
> "known-new" caller of the `packfile_list_append()` function, and wonder
> why not simply remove this check whether the packfile already exists in
> the list? Originally, when above-mentioned commit introduced that logic,
> there was a second caller in `prepare_midx()`, which would have required
> that check, but that caller was removed in 6aff1f25a046 (packfile:
> always add packfiles to MRU when adding a pack, 2025-10-30). Still, the
> function is declared in a header file, and to avoid any problems with
> in-flight or downstream callers, it is safer to extend the signature to
> be explicit whether or not to skip that check.

Quite conservative, but fair enough.

> diff --git a/packfile-list.c b/packfile-list.c
> index 01fb913abf..1379ab3a4f 100644
> --- a/packfile-list.c
> +++ b/packfile-list.c
> @@ -57,11 +57,12 @@ void packfile_list_prepend(struct packfile_list *list, struct packed_git *pack)
>  		list->tail = entry;
>  }
>  
> -void packfile_list_append(struct packfile_list *list, struct packed_git *pack)
> +void packfile_list_append(struct packfile_list *list, struct packed_git *pack,
> +			  int is_new)
>  {
>  	struct packfile_list_entry *entry;
>  
> -	entry = packfile_list_remove_internal(list, pack);
> +	entry = is_new ? NULL : packfile_list_remove_internal(list, pack);
>  	if (!entry) {
>  		entry = xmalloc(sizeof(*entry));
>  		entry->pack = pack;

I wonder whether we should slightly reformulate this and rename `is_new`
to `accept_duplicates`. Because ultimately, that is what we're doing
now: instead of ensuring that the packfile is unique in the list, we
just don't care and just append the entry to the list.

An alternative would be to use a hashmap here that tracks the packs that
have already been added. It has the advantage that it also covers the
`prepend()` operation and that callers don't have to be aware of this
mechanism at all. Furthermore, moving preexisting entries to the back or
front could become O(logn) if the list was doubly-linked. We do this
operation quite often to re-sort entries in the list when looking up
objects.

Overall though I'm not quite sure whether the added complexity would be
worth it, see below patch.

Thanks!

Patrick

diff --git a/http-push.c b/http-push.c
index 94a1fac9ab..52b00e7c95 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1729,6 +1729,7 @@ int cmd_main(int argc, const char **argv)
 	const char *gitdir;
 
 	CALLOC_ARRAY(repo, 1);
+	packfile_list_init(&repo->packs);
 
 	argv++;
 	for (i = 1; i < argc; i++, argv++) {
@@ -1992,6 +1993,7 @@ int cmd_main(int argc, const char **argv)
  cleanup:
 	if (info_ref_lock)
 		unlock_remote(info_ref_lock);
+	packfile_list_clear(&repo->packs);
 	free(repo->url);
 	free(repo);
 
diff --git a/http-walker.c b/http-walker.c
index b58a3b2a92..541437e52d 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -325,6 +325,7 @@ static void process_alternates_response(void *callback_data)
 					warning("adding alternate object store: %s",
 						target.buf);
 					CALLOC_ARRAY(newalt, 1);
+					packfile_list_init(&newalt->packs);
 					newalt->base = strbuf_detach(&target, NULL);
 
 					while (tail->next != NULL)
@@ -609,6 +610,7 @@ struct walker *get_http_walker(const char *url)
 	struct walker *walker = xmalloc(sizeof(struct walker));
 
 	CALLOC_ARRAY(data->alt, 1);
+	packfile_list_init(&data->alt->packs);
 	data->alt->base = xstrdup(url);
 	for (s = data->alt->base + strlen(data->alt->base) - 1; *s == '/'; --s)
 		*s = 0;
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 0890704e76..082c2494cb 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -835,6 +835,7 @@ struct odb_source_packed *odb_source_packed_new(struct object_database *odb,
 
 	CALLOC_ARRAY(packed, 1);
 	odb_source_init(&packed->base, odb, ODB_SOURCE_PACKED, path, local);
+	packfile_list_init(&packed->packs);
 	strmap_init(&packed->packs_by_path);
 
 	packed->base.free = odb_source_packed_free;
diff --git a/packfile-list.c b/packfile-list.c
index 01fb913abf..d3c4843d8d 100644
--- a/packfile-list.c
+++ b/packfile-list.c
@@ -2,6 +2,28 @@
 #include "packfile.h"
 #include "packfile-list.h"
 
+static unsigned int packfile_list_entry_hash(struct packfile_list_entry *e)
+{
+	return memhash(&e->pack, sizeof(e->pack));
+}
+
+static int packfile_list_entry_cmp(const void *data UNUSED,
+				   const struct hashmap_entry *h1,
+				   const struct hashmap_entry *h2,
+				   const void *keydata UNUSED)
+{
+	const struct packfile_list_entry *e1, *e2;
+	e1 = container_of(h1, const struct packfile_list_entry, ent);
+	e2 = container_of(h2, const struct packfile_list_entry, ent);
+	return e1->pack != e2->pack;
+}
+
+void packfile_list_init(struct packfile_list *list)
+{
+	memset(list, 0, sizeof(*list));
+	hashmap_init(&list->seen, packfile_list_entry_cmp, NULL, 0);
+}
+
 void packfile_list_clear(struct packfile_list *list)
 {
 	struct packfile_list_entry *e, *next;
@@ -12,6 +34,20 @@ void packfile_list_clear(struct packfile_list *list)
 	}
 
 	list->head = list->tail = NULL;
+
+	hashmap_clear(&list->seen);
+}
+
+static struct packfile_list_entry *packfile_list_lookup(struct packfile_list *list,
+							struct packed_git *pack)
+{
+	struct packfile_list_entry key = { .pack = pack };
+	struct hashmap_entry *ent;
+
+	hashmap_entry_init(&key.ent, packfile_list_entry_hash(&key));
+	ent = hashmap_get(&list->seen, &key.ent, NULL);
+
+	return ent ? container_of(ent, struct packfile_list_entry, ent) : NULL;
 }
 
 static struct packfile_list_entry *packfile_list_remove_internal(struct packfile_list *list,
@@ -38,20 +74,33 @@ static struct packfile_list_entry *packfile_list_remove_internal(struct packfile
 
 void packfile_list_remove(struct packfile_list *list, struct packed_git *pack)
 {
-	free(packfile_list_remove_internal(list, pack));
+	struct packfile_list_entry key = { .pack = pack };
+
+	hashmap_entry_init(&key.ent, packfile_list_entry_hash(&key));
+	if (hashmap_remove(&list->seen, &key.ent, NULL)) {
+		struct packfile_list_entry *e = packfile_list_remove_internal(list, pack);
+		if (!e)
+			BUG("corrupt packfile list");
+		free(e);
+	}
 }
 
 void packfile_list_prepend(struct packfile_list *list, struct packed_git *pack)
 {
 	struct packfile_list_entry *entry;
 
-	entry = packfile_list_remove_internal(list, pack);
-	if (!entry) {
+	if (packfile_list_lookup(list, pack)) {
+		entry = packfile_list_remove_internal(list, pack);
+		if (!entry)
+			BUG("corrupt packfile list");
+	} else {
 		entry = xmalloc(sizeof(*entry));
 		entry->pack = pack;
+		hashmap_entry_init(&entry->ent, packfile_list_entry_hash(entry));
+		hashmap_add(&list->seen, &entry->ent);
 	}
-	entry->next = list->head;
 
+	entry->next = list->head;
 	list->head = entry;
 	if (!list->tail)
 		list->tail = entry;
@@ -61,13 +110,18 @@ void packfile_list_append(struct packfile_list *list, struct packed_git *pack)
 {
 	struct packfile_list_entry *entry;
 
-	entry = packfile_list_remove_internal(list, pack);
-	if (!entry) {
+	if (packfile_list_lookup(list, pack)) {
+		entry = packfile_list_remove_internal(list, pack);
+		if (!entry)
+			BUG("corrupt packfile list");
+	} else {
 		entry = xmalloc(sizeof(*entry));
 		entry->pack = pack;
+		hashmap_entry_init(&entry->ent, packfile_list_entry_hash(entry));
+		hashmap_add(&list->seen, &entry->ent);
 	}
-	entry->next = NULL;
 
+	entry->next = NULL;
 	if (list->tail) {
 		list->tail->next = entry;
 		list->tail = entry;
diff --git a/packfile-list.h b/packfile-list.h
index 1b05e2aa36..bfb7017852 100644
--- a/packfile-list.h
+++ b/packfile-list.h
@@ -1,17 +1,22 @@
 #ifndef PACKFILE_LIST_H
 #define PACKFILE_LIST_H
 
+#include "hashmap.h"
+
 struct object_id;
 
 struct packfile_list {
 	struct packfile_list_entry *head, *tail;
+	struct hashmap seen;
 };
 
 struct packfile_list_entry {
+	struct hashmap_entry ent;
 	struct packfile_list_entry *next;
 	struct packed_git *pack;
 };
 
+void packfile_list_init(struct packfile_list *list);
 void packfile_list_clear(struct packfile_list *list);
 void packfile_list_remove(struct packfile_list *list, struct packed_git *pack);
 void packfile_list_prepend(struct packfile_list *list, struct packed_git *pack);
