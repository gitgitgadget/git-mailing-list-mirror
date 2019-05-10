Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D42F1F45F
	for <e@80x24.org>; Fri, 10 May 2019 17:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfEJRTW (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 13:19:22 -0400
Received: from mout.web.de ([212.227.17.12]:60091 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727364AbfEJRTW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 13:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1557508741;
        bh=ysfjr9mT2vKyz7nHfOxwb6MwF/kQAAwf5dyG8yVX2us=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=V9eLztbB/ZzzvMN+00jHuyRDuFyB7YDN0QKvkeQQtcluD975aOk1Y4o9gDs1NbPEJ
         iudHW2u180vT/hdgSM/IUlpGi8t4Q1aM0tO6TiCltILtnOd1nWhum4CcqmN5WXTP6Y
         pkksJyLV1noYLJOMOVvQlSc5O/0OS7ZWvQZk4I0g=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.192]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MVLak-1hDcsd0wN4-00YhUR; Fri, 10
 May 2019 19:19:01 +0200
Subject: Re: [PATCH v2 2/4] archive-tar: mark RECORDSIZE/BLOCKSIZE as unsigned
To:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.145.git.gitgitgadget@gmail.com>
 <pull.145.v2.git.gitgitgadget@gmail.com>
 <ac2b2488a1b42b3caf8a84594c48eca796748e59.1556321244.git.gitgitgadget@gmail.com>
 <d960966d-a7d4-dc3e-ca0a-70e9e5d1abf3@web.de>
 <nycvar.QRO.7.76.6.1905081334260.44@tvgsbejvaqbjf.bet>
 <20190508230420.GC19990@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1905091605070.44@tvgsbejvaqbjf.bet>
 <20190509183855.GA28107@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f380b182-633f-f347-ed2e-f90548d7f3c9@web.de>
Date:   Fri, 10 May 2019 19:18:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509183855.GA28107@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Xyfz2UuyogR9jEzr1Q81apREm3IfykY5WkzT/+mPf6NQN+m8yWV
 NkRHPorZue0OlAocuGyyIkqTkLcm7RFQdQ4GpYYv10ot1grHUxPC52L3nChAuuLCUJ81qxY
 bNhEbiyY+bEl63scgBBPrcz02pqBUMyUYWQ4snT6zeTzxZ10QF3MeZO4knWZUSYYi59VTux
 Zy+8DOx9peG3LljD5YvXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wQg6wgW9ADE=:CLjJkl6vEBdKZR8yZMMcth
 1JuoTFHBSN9qroKA4+1JuKi5pO0kzAXtNu6NMOORoq1TR2S+mkIkVm9o8uVCcrae3lz7mtnNX
 +EtVkVaoNmhAxVXTOzzs+MvZf6jbb1s/7vGnfdqNBaePdtvIMVuB+I0Pe1tRvbMZHubmyWS/f
 9JMe5hX9K3dPCCj2LH3lZLPAnW0aqP4fOXniMcyFy7E0En21n5htrImjjFc4JVfsMssHdME3o
 bRLVHUDAaxMqpQ32rw05kE1g0j8MLpV8ekP/LIpcYb5H2z3Ljw5hrhItDtlrxBtplkr+iGSQB
 zl7oXy7O7uZmei3CAYNI27Zn8aOD42SnMbQSq8Z+/gfo11DUBDRNEOximWLbA9DhIdg+wpmaT
 bYu6AspSzqXI2gufQJs8p1JJFKg5RSFPt9bnd4U+mQuNk4wgfd09e7285Q1MQ6aQXBbe8wx6w
 3EpS3nBQwz66IZoImsLBz3u1P2otWU0u08/O31YahNzJIr8lnK7dK1RPVobtqSjlEpjiug0rp
 GF0jWy1GHGy/94ySai1cBu+jMyEzLS8uOY62rruQwx63z9wuTmH8usAxGQhlFNljXNfZfmAxd
 9ebEAsKCxlvcSZ4vFlinwXcfP2gMIIiO/I0+CxGi9TQMe/5QFsmj/I7ULsxqMZ/T41GtU7p1i
 GWSB9dAjqO7NLl+EAORw6S4Tr1vqajChAuIimB1zFoEOJ5RlmToZ+njIMb56jRZ9ye0unoNbn
 K5ocvzp4qlZt0eNnLoUFfMOB/B+uTM8fScz9vBZxGiRX72a9gnimmlvgSdd5ejE7YtQD2MFLx
 21WiZajpST6HkatG5+61jCf3MzilHb11icWNhtp8pyU+2nZA5VM1PowQn87xuqsDR6mimkWln
 SyB9PLR3xwkHiVj4KXPePWJk5m6d7Gk46P68NXnH/Y/31GB81M+6JirDGmo0A3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.05.19 um 20:38 schrieb Jeff King:
> I do dream of a world where we do not have a bunch of implicit
> conversions (both signedness but also truncation) in our code base, and
> can compile cleanly with -Wconversion We know that this case is
> perfectly fine, but I am sure there are many that are not. However, I'm
> not sure if we'll ever get there, and in the meantime I don't think it's
> worth worrying too much about individual cases like this.

Here's a rough take on how to silence that warning for archive-tar.c using
GCC 8.3.  Some of the changes are worth polishing and submitting.  Some
are silly.  The one for regexec_buf() is scary; I don't see a clean way of
dealing with that size_t to int conversion.

=2D--
 archive-tar.c     | 54 +++++++++++++++++++++++++++++++----------------
 cache.h           | 10 ++++-----
 git-compat-util.h | 21 +++++++++++++++---
 hash.h            |  2 +-
 strbuf.h          |  2 +-
 5 files changed, 61 insertions(+), 28 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 3e53aac1e6..bfd91782ab 100644
=2D-- a/archive-tar.c
+++ b/archive-tar.c
@@ -15,7 +15,7 @@
 static char block[BLOCKSIZE];
 static unsigned long offset;

-static int tar_umask =3D 002;
+static mode_t tar_umask =3D 002;

 static int write_tar_filter_archive(const struct archiver *ar,
 				    struct archiver_args *args);
@@ -99,7 +99,7 @@ static void write_blocked(const void *data, unsigned lon=
g size)
  */
 static void write_trailer(void)
 {
-	int tail =3D BLOCKSIZE - offset;
+	size_t tail =3D BLOCKSIZE - offset;
 	memset(block + offset, 0, tail);
 	write_or_die(1, block, BLOCKSIZE);
 	if (tail < 2 * RECORDSIZE) {
@@ -127,12 +127,13 @@ static int stream_blocked(const struct object_id *oi=
d)
 		readlen =3D read_istream(st, buf, sizeof(buf));
 		if (readlen <=3D 0)
 			break;
-		do_write_blocked(buf, readlen);
+		do_write_blocked(buf, (size_t)readlen);
 	}
 	close_istream(st);
-	if (!readlen)
-		finish_record();
-	return readlen;
+	if (readlen < 0)
+		return -1;
+	finish_record();
+	return 0;
 }

 /*
@@ -142,9 +143,9 @@ static int stream_blocked(const struct object_id *oid)
  * string and appends it to a struct strbuf.
  */
 static void strbuf_append_ext_header(struct strbuf *sb, const char *keywo=
rd,
-				     const char *value, unsigned int valuelen)
+				     const char *value, size_t valuelen)
 {
-	int len, tmp;
+	size_t len, tmp;

 	/* "%u %s=3D%s\n" */
 	len =3D 1 + 1 + strlen(keyword) + 1 + valuelen + 1;
@@ -152,7 +153,7 @@ static void strbuf_append_ext_header(struct strbuf *sb=
, const char *keyword,
 		len++;

 	strbuf_grow(sb, len);
-	strbuf_addf(sb, "%u %s=3D", len, keyword);
+	strbuf_addf(sb, "%"PRIuMAX" %s=3D", (uintmax_t)len, keyword);
 	strbuf_add(sb, value, valuelen);
 	strbuf_addch(sb, '\n');
 }
@@ -168,7 +169,9 @@ static void strbuf_append_ext_header_uint(struct strbu=
f *sb,
 	int len;

 	len =3D xsnprintf(buf, sizeof(buf), "%"PRIuMAX, value);
-	strbuf_append_ext_header(sb, keyword, buf, len);
+	if (len < 0)
+		BUG("unable to convert %"PRIuMAX" to decimal", value);
+	strbuf_append_ext_header(sb, keyword, buf, (size_t)len);
 }

 static unsigned int ustar_header_chksum(const struct ustar_header *header=
)
@@ -177,7 +180,7 @@ static unsigned int ustar_header_chksum(const struct u=
star_header *header)
 	unsigned int chksum =3D 0;
 	while (p < (const unsigned char *)header->chksum)
 		chksum +=3D *p++;
-	chksum +=3D sizeof(header->chksum) * ' ';
+	chksum +=3D (unsigned int)sizeof(header->chksum) * ' ';
 	p +=3D sizeof(header->chksum);
 	while (p < (const unsigned char *)header + sizeof(struct ustar_header))
 		chksum +=3D *p++;
@@ -355,12 +358,14 @@ static void write_global_extended_header(struct arch=
iver_args *args)
 }

 static struct archiver **tar_filters;
-static int nr_tar_filters;
-static int alloc_tar_filters;
+static size_t nr_tar_filters;
+static size_t alloc_tar_filters;

-static struct archiver *find_tar_filter(const char *name, int len)
+static struct archiver *find_tar_filter(const char *name, size_t len)
 {
 	int i;
+	if (len < 1)
+		return NULL;
 	for (i =3D 0; i < nr_tar_filters; i++) {
 		struct archiver *ar =3D tar_filters[i];
 		if (!strncmp(ar->name, name, len) && !ar->name[len])
@@ -369,14 +374,27 @@ static struct archiver *find_tar_filter(const char *=
name, int len)
 	return NULL;
 }

+static int parse_config_key2(const char *var, const char *section,
+			     const char **subsection, size_t *subsection_len,
+			     const char **key)
+{
+	int rc, len;
+
+	rc =3D parse_config_key(var, section, subsection, &len, key);
+	if (!rc && len < 0)
+		return -1;
+	*subsection_len =3D (size_t)len;
+	return rc;
+}
+
 static int tar_filter_config(const char *var, const char *value, void *da=
ta)
 {
 	struct archiver *ar;
 	const char *name;
 	const char *type;
-	int namelen;
+	size_t namelen;

-	if (parse_config_key(var, "tar", &name, &namelen, &type) < 0 || !name)
+	if (parse_config_key2(var, "tar", &name, &namelen, &type) < 0 || !name)
 		return 0;

 	ar =3D find_tar_filter(name, namelen);
@@ -400,7 +418,7 @@ static int tar_filter_config(const char *var, const ch=
ar *value, void *data)
 		if (git_config_bool(var, value))
 			ar->flags |=3D ARCHIVER_REMOTE;
 		else
-			ar->flags &=3D ~ARCHIVER_REMOTE;
+			ar->flags &=3D ~(unsigned int)ARCHIVER_REMOTE;
 		return 0;
 	}

@@ -414,7 +432,7 @@ static int git_tar_config(const char *var, const char =
*value, void *cb)
 			tar_umask =3D umask(0);
 			umask(tar_umask);
 		} else {
-			tar_umask =3D git_config_int(var, value);
+			tar_umask =3D (mode_t)git_config_ulong(var, value);
 		}
 		return 0;
 	}
diff --git a/cache.h b/cache.h
index 67cc2e1806..a791034260 100644
=2D-- a/cache.h
+++ b/cache.h
@@ -241,7 +241,7 @@ static inline void copy_cache_entry(struct cache_entry=
 *dst,
 				    const struct cache_entry *src)
 {
 	unsigned int state =3D dst->ce_flags & CE_HASHED;
-	int mem_pool_allocated =3D dst->mem_pool_allocated;
+	unsigned int mem_pool_allocated =3D dst->mem_pool_allocated;

 	/* Don't copy hash chain and name */
 	memcpy(&dst->ce_stat_data, &src->ce_stat_data,
@@ -249,7 +249,7 @@ static inline void copy_cache_entry(struct cache_entry=
 *dst,
 			offsetof(struct cache_entry, ce_stat_data));

 	/* Restore the hash state */
-	dst->ce_flags =3D (dst->ce_flags & ~CE_HASHED) | state;
+	dst->ce_flags =3D (dst->ce_flags & ~(unsigned int)CE_HASHED) | state;

 	/* Restore the mem_pool_allocated flag */
 	dst->mem_pool_allocated =3D mem_pool_allocated;
@@ -1314,7 +1314,7 @@ extern int check_and_freshen_file(const char *fn, in=
t freshen);
 extern const signed char hexval_table[256];
 static inline unsigned int hexval(unsigned char c)
 {
-	return hexval_table[c];
+	return (unsigned int)hexval_table[c];
 }

 /*
@@ -1323,8 +1323,8 @@ static inline unsigned int hexval(unsigned char c)
  */
 static inline int hex2chr(const char *s)
 {
-	unsigned int val =3D hexval(s[0]);
-	return (val & ~0xf) ? val : (val << 4) | hexval(s[1]);
+	int val =3D hexval_table[(unsigned char)s[0]];
+	return (val < 0) ? val : (val << 4) | hexval_table[(unsigned char)s[1]];
 }

 /* Convert to/from hex/sha1 representation */
diff --git a/git-compat-util.h b/git-compat-util.h
index 4386b3e1c8..cf33e84c96 100644
=2D-- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1068,7 +1068,7 @@ static inline int strtoul_ui(char const *s, int base=
, unsigned int *result)
 	ul =3D strtoul(s, &p, base);
 	if (errno || *p || p =3D=3D s || (unsigned int) ul !=3D ul)
 		return -1;
-	*result =3D ul;
+	*result =3D (unsigned int)ul;
 	return 0;
 }

@@ -1081,7 +1081,7 @@ static inline int strtol_i(char const *s, int base, =
int *result)
 	ul =3D strtol(s, &p, base);
 	if (errno || *p || p =3D=3D s || (int) ul !=3D ul)
 		return -1;
-	*result =3D ul;
+	*result =3D (int)ul;
 	return 0;
 }

@@ -1119,7 +1119,22 @@ static inline int regexec_buf(const regex_t *preg, =
const char *buf, size_t size,
 {
 	assert(nmatch > 0 && pmatch);
 	pmatch[0].rm_so =3D 0;
-	pmatch[0].rm_eo =3D size;
+	pmatch[0].rm_eo =3D (regoff_t)size;
+	if (pmatch[0].rm_eo !=3D size) {
+		if (((regoff_t)-1) < 0) {
+			if (sizeof(regoff_t) =3D=3D sizeof(int))
+				pmatch[0].rm_eo =3D (regoff_t)INT_MAX;
+			else if (sizeof(regoff_t) =3D=3D sizeof(long))
+				pmatch[0].rm_eo =3D (regoff_t)LONG_MAX;
+			else
+				die("unable to determine maximum value of regoff_t");
+		} else {
+			pmatch[0].rm_eo =3D (regoff_t)-1;
+		}
+		warning("buffer too big (%"PRIuMAX"), "
+			"will search only the first %"PRIuMAX" bytes",
+			(uintmax_t)size, (uintmax_t)pmatch[0].rm_eo);
+	}
 	return regexec(preg, buf, nmatch, pmatch, eflags | REG_STARTEND);
 }

diff --git a/hash.h b/hash.h
index 661c9f2281..7056f89eb4 100644
=2D-- a/hash.h
+++ b/hash.h
@@ -134,7 +134,7 @@ int hash_algo_by_id(uint32_t format_id);
 /* Identical, except based on the length. */
 int hash_algo_by_length(int len);
 /* Identical, except for a pointer to struct git_hash_algo. */
-static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
+static inline ptrdiff_t hash_algo_by_ptr(const struct git_hash_algo *p)
 {
 	return p - hash_algos;
 }
diff --git a/strbuf.h b/strbuf.h
index c8d98dfb95..30659f2d5d 100644
=2D-- a/strbuf.h
+++ b/strbuf.h
@@ -225,7 +225,7 @@ int strbuf_cmp(const struct strbuf *first, const struc=
t strbuf *second);
 /**
  * Add a single character to the buffer.
  */
-static inline void strbuf_addch(struct strbuf *sb, int c)
+static inline void strbuf_addch(struct strbuf *sb, char c)
 {
 	if (!strbuf_avail(sb))
 		strbuf_grow(sb, 1);
=2D-
2.21.0
