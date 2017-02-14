Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82B512013A
	for <e@80x24.org>; Tue, 14 Feb 2017 11:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753786AbdBNLdP (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 06:33:15 -0500
Received: from mout.gmx.net ([212.227.17.22]:49475 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752089AbdBNLc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 06:32:58 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MeQ43-1d2ZFR2Vf5-00Q9sE; Tue, 14
 Feb 2017 12:32:38 +0100
Date:   Tue, 14 Feb 2017 12:32:38 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/5] name-hash: remember previous dir_entry during
 lazy_init_name_hash
In-Reply-To: <cover.1487071883.git.johannes.schindelin@gmx.de>
Message-ID: <ce9f344b4d4de06320d5914b8f2cc2eaf0fcd923.1487071883.git.johannes.schindelin@gmx.de>
References: <cover.1487071883.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:HXI9kZf9XZpWVpXYKOkFiM2gz35ME6swqM6nGwDdK4BjhwT9NMm
 Jj2yk4wbp4rbmFJ6wI0EXgEtPB66EZDE+Cl4yt2hp0fNk2mcd05WMDybPgAKSok0P1pRRJD
 XzgIn75QfVM5/R+lExXDcc3vInSk4GbNvHkOveFoW4dBYad+8HltgXJYJBphQpC4iDJapfZ
 kHKEFnWcgbmxw+JVoeVeg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4Cv6rafAR5s=:qpV+rEHcydCXAPjqLXPQ+e
 Ga9hsIXG/vBjyufbTRgbHXkZJm57dAmCb95l3+F3EGuq/Di99GDEjW3R2Cayfp6Pz8vXIjwfA
 qgI4AO/z63uew8r0AGSfVacmjXBpkwsLmUIN6YaM/fPgP6XGFxIBA4bbG3uusNgE0LgmdTLNm
 V5ioNGDepu+QFYG0D4O7Ioyud6TNFvOIKdwxXvOTE7ssnYTZMqOfnXp5sfgqhyUHtdjaUJ73J
 F+lumet/I0IOE8vx6G764ZvsqLcyof6O40aFA0H/gElgGJdiGjd5JEPvqW2PegJjtpmOLCK0O
 qDGwbmXLTY1qeZzJyvRd+s++wsDcbBwqK75VaoqUHtdpKtid7rFeyAwgBuOboNT1Yw0l2YOZc
 CYfOkciTnKBRQqq9ZmOFrApKTnzAFwNhmDeeVPSl9oakPK8Xo8aGplvRZnCQkQhVuY/BywJkA
 n2PLq5j8cwdoI0+L2tm0Nwxmwju9DZNX5ern/Zpsf1ILbnN/TXA0axUbbeHiXYDIoEh6yR3BN
 cBocZbWqdYji9dc3z7XDLq3gkiXCAz1Vw1Xwc9nhPq6Xq4ae09LnREd8ZapIK1SmCswZWiwT2
 frfFPy01D6opRXoKh9H/bgfgjHSm/L7FN2K7I+NbYETtY4opzWYwupb1GGQJvgZVkT3VLKn9G
 kIpweUG1206nu0riTZlVSFFUkx+dtn0ri9paFA+6KewxjSuFPn5CL2CHXd0UlQbD8m9xV1Lw7
 zLbKuL2JD9G+Y6PFDuHxwYp3ORjWLgzpG8svQHZnTRwPhWVpYtnaXn10Xd0qOQJP84Z1XT8o6
 u+155ngjn7nPjNrvg1nnlsf519R2+BWEMCDQq9wAmlXVXBknLZOMHkPg4XSD1o6zqN2NOQAbY
 2XZJOrwc8Dlm3CpQ0JAeapnYQ7JHmyTmfn+b6nANQ0d0RoBg7Z68ea5e8Zu/3e8TokBUQ5rQr
 VUpqPcxqTohz/xhUEjOka7ZdJqieFvjBCfV41wJkGJcmdhbBU31Ifrl3FClDM9BRguHHO5U/6
 Ftyj23LtRvXXh6OHfJvS0uY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach hash_dir_entry() to remember the previously found dir_entry during
lazy_init_name_hash() iteration. This is a performance optimization.
Since items in the index array are sorted by full pathname, adjacent
items are likely to be in the same directory. This can save memihash()
computations and hash map lookups.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 name-hash.c | 50 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/name-hash.c b/name-hash.c
index 8f8336cc868..f95054f44cb 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -39,7 +39,8 @@ static struct dir_entry *find_dir_entry(struct index_state *istate,
 }
 
 static struct dir_entry *hash_dir_entry(struct index_state *istate,
-		struct cache_entry *ce, int namelen)
+		struct cache_entry *ce, int namelen,
+		struct dir_entry **previous_dir)
 {
 	/*
 	 * Throw each directory component in the hash for quick lookup
@@ -63,11 +64,24 @@ static struct dir_entry *hash_dir_entry(struct index_state *istate,
 	namelen--;
 
 	/* lookup existing entry for that directory */
-	if (ce->precomputed_hash.initialized && orig_namelen == ce_namelen(ce))
-		hash = ce->precomputed_hash.dir;
-	else
-		hash = memihash(ce->name, namelen);
-	dir = find_dir_entry_1(istate, ce->name, namelen, hash);
+	if (previous_dir && *previous_dir
+	    && namelen == (*previous_dir)->namelen
+	    && memcmp(ce->name, (*previous_dir)->name, namelen) == 0) {
+		/*
+		 * When our caller is sequentially iterating through the index,
+		 * items in the same directory will be sequential, and therefore
+		 * refer to the same dir_entry.
+		 */
+		dir = *previous_dir;
+	} else {
+		if (ce->precomputed_hash.initialized &&
+		    orig_namelen == ce_namelen(ce))
+			hash = ce->precomputed_hash.dir;
+		else
+			hash = memihash(ce->name, namelen);
+		dir = find_dir_entry_1(istate, ce->name, namelen, hash);
+	}
+
 	if (!dir) {
 		/* not found, create it and add to hash table */
 		FLEX_ALLOC_MEM(dir, name, ce->name, namelen);
@@ -76,15 +90,21 @@ static struct dir_entry *hash_dir_entry(struct index_state *istate,
 		hashmap_add(&istate->dir_hash, dir);
 
 		/* recursively add missing parent directories */
-		dir->parent = hash_dir_entry(istate, ce, namelen);
+		dir->parent = hash_dir_entry(istate, ce, namelen, NULL);
 	}
+
+	if (previous_dir)
+		*previous_dir = dir;
+
 	return dir;
 }
 
-static void add_dir_entry(struct index_state *istate, struct cache_entry *ce)
+static void add_dir_entry(struct index_state *istate, struct cache_entry *ce,
+			  struct dir_entry **previous_dir)
 {
 	/* Add reference to the directory entry (and parents if 0). */
-	struct dir_entry *dir = hash_dir_entry(istate, ce, ce_namelen(ce));
+	struct dir_entry *dir = hash_dir_entry(istate, ce, ce_namelen(ce),
+					       previous_dir);
 	while (dir && !(dir->nr++))
 		dir = dir->parent;
 }
@@ -95,7 +115,7 @@ static void remove_dir_entry(struct index_state *istate, struct cache_entry *ce)
 	 * Release reference to the directory entry. If 0, remove and continue
 	 * with parent directory.
 	 */
-	struct dir_entry *dir = hash_dir_entry(istate, ce, ce_namelen(ce));
+	struct dir_entry *dir = hash_dir_entry(istate, ce, ce_namelen(ce), NULL);
 	while (dir && !(--dir->nr)) {
 		struct dir_entry *parent = dir->parent;
 		hashmap_remove(&istate->dir_hash, dir, NULL);
@@ -104,7 +124,8 @@ static void remove_dir_entry(struct index_state *istate, struct cache_entry *ce)
 	}
 }
 
-static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
+static void hash_index_entry(struct index_state *istate, struct cache_entry *ce,
+			     struct dir_entry **previous_dir)
 {
 	unsigned int h;
 
@@ -121,7 +142,7 @@ static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
 	hashmap_add(&istate->name_hash, ce);
 
 	if (ignore_case)
-		add_dir_entry(istate, ce);
+		add_dir_entry(istate, ce, previous_dir);
 }
 
 static int cache_entry_cmp(const struct cache_entry *ce1,
@@ -137,6 +158,7 @@ static int cache_entry_cmp(const struct cache_entry *ce1,
 
 static void lazy_init_name_hash(struct index_state *istate)
 {
+	struct dir_entry *previous_dir = NULL;
 	int nr;
 
 	if (istate->name_hash_initialized)
@@ -146,14 +168,14 @@ static void lazy_init_name_hash(struct index_state *istate)
 	hashmap_init(&istate->dir_hash, (hashmap_cmp_fn) dir_entry_cmp,
 			istate->cache_nr);
 	for (nr = 0; nr < istate->cache_nr; nr++)
-		hash_index_entry(istate, istate->cache[nr]);
+		hash_index_entry(istate, istate->cache[nr], &previous_dir);
 	istate->name_hash_initialized = 1;
 }
 
 void add_name_hash(struct index_state *istate, struct cache_entry *ce)
 {
 	if (istate->name_hash_initialized)
-		hash_index_entry(istate, ce);
+		hash_index_entry(istate, ce, NULL);
 }
 
 void remove_name_hash(struct index_state *istate, struct cache_entry *ce)
-- 
2.11.1.windows.1
