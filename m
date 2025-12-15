Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E9A32720F
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 20:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765832217; cv=none; b=tTKNPdlyqCMyAwnXOfDfk6+1r9Ig+gCbMicY/PHGJy4sCvFtNY2EpxcIySUNnpBfLDrPoyr/yMv+16M8pmxfT7Xysyf1/44bEQ4BraR+0I1495uGElEPOmXJIYHl17vPa5ZYmUY52jd9COZ01SRheLQtwLaynKWA+57ewi9g/SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765832217; c=relaxed/simple;
	bh=irKMW7y3SwwgbY1Lapr+494yGbqPZK82aSbiy0Shv5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/hRjT+/P+pqHzWZsIkh5pzcI/GKuIU2BH+5RdJtM38F8S3v88EeHyoJttAhe5qfmMu2XY175nCIWOb6Ikc0EZGxuCv3k3W/CtLB7XQwUVGDkmi+aFYdf0a5tynldCCpM3vj+MHKVQMMjCnJ4rqjCmENhsRyDwOrquFh4Zxon8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPJZa56C; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPJZa56C"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-3e12fd71984so2939926fac.2
        for <git@vger.kernel.org>; Mon, 15 Dec 2025 12:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765832213; x=1766437013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJRdJGGW+NaPW59jPicgpmn/u4zU0SBNp52xAztjehQ=;
        b=mPJZa56CpqfjExSn17jYp1CBVmmXoNsSElFbp0gK2D1MtPHD4BMglS+dUoI99nle3v
         y2Lb7P9JIdPBJmE6p94ph8WnLujITMmUPDnrj3S5WS8LXPPPnDlqwW4PRIUYJ/r7fiOe
         7TD9hdshabR/jR4rJx4ypURypmJqA2CdFfj/S/tUffigRfVr1D9CeLJz+xSa4+nx60/0
         H3N0xnT0d/lLz5ceYHTwav7j3yMPVCoPUxcezIFgOOrsRjq+nuE7EqHWx2zX7rAEas32
         ZfdEIsdemfewnooFi2A0CfB10gio7A5p8oMxTqCMedNqbxzIV0jc4LoTC7pUg8+KIAdJ
         44Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765832213; x=1766437013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HJRdJGGW+NaPW59jPicgpmn/u4zU0SBNp52xAztjehQ=;
        b=cRHyl0csETpPHOVckUa1Ydm4oEwTpQst/7NrDbprXhnyfIKTyYp5wmseVMzVnoN91x
         k/zZbPtbYr/Ex+aojkVWPojK6HW3V+jQe3iXnh73Know6IInmM5T96gC06WsetF4YWbo
         oApFBb8K2Ykn4D407tnH1qo6/Oca+mUAQ+92jCUOBLj1MQ/UAhLTnZM6v3PEUzRlZcmJ
         6+8lsZA3KodnfA1qpVhV8u9Dav4KAC9taJApMj5RIMbUP3u8C3Rj4Y3SmXC26PTHJj1A
         bdKdvDXPwy3FVJHPoYhgd6woF93sRxP5fUS2f3WTb5uRWz3CGyIwKstoKCuTNXsfXxW2
         iW4g==
X-Gm-Message-State: AOJu0YyoOf8olLnw89JEWfqkaaJ57QGmuhKfJAV+kKuhTs69xxgzS0Re
	bPnXQWixkbJSCFWXX4Ovyygn1pOhqi5WM2vtLdCZLkR/QUjVCLOywtyMnOWMTg==
X-Gm-Gg: AY/fxX7Yj1+ila6snUYul9srTYz5u9DL/1aXk+f8z/VNojp0H/J47/meI3Xy8gBSqZP
	WHXaMv9OogHKiZJyh+GvoGXJ5DyhApQTvHBURwu7uB+ErvTmqmbkjn6mVzLzMC3L3CfW3l3UKGZ
	pGvdW+Ujd6dDBH60BLtYaML0H+HkijCsfu7eK4MvZnXFdVBZHZBu6Mn9XE3Jx9gti6hHv6eXd3Y
	IVQPGYo3kuRUEhR5vsLYk1Zn8QA05Z2v6xJfHFq6nPfIRwLH8ZpmETc+JAX3iJVqs6j1lGw5Y9U
	kj4pe+nfMxROIAi1V5B32KL1YzyKCCcVGwn04Fmt4E3mQCiX1lzGVNpmSMP28uvF8TCBwaiK9VB
	Etos6KgdI6detIzZe2l9yJnYdibM6VggP2/36YktpMMFtoZss6oaBUSl84B4w3gahp9GPkJwyfE
	XT6HgBKQr3JJ168BJS9QurxaxFNApz/w==
X-Google-Smtp-Source: AGHT+IEglOMkLduqIzbQ8oh3SGO/PKLqPHC1ypPxCB7OdXhJVUnKXB0kvdkdmviNSm9bIyCNxZ5zjA==
X-Received: by 2002:a05:6820:994:b0:65b:35fe:433d with SMTP id 006d021491bc7-65b45299acemr5932837eaf.66.1765832213046;
        Mon, 15 Dec 2025 12:56:53 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65b360f0f4fsm8778898eaf.14.2025.12.15.12.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 12:56:52 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 0/7] builtin/repo: add object size info to structure output
Date: Mon, 15 Dec 2025 14:56:32 -0600
Message-ID: <20251215205639.2700270-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.209.ge85ae279b0
In-Reply-To: <20251212223644.3090879-1-jltobler@gmail.com>
References: <20251212223644.3090879-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

This patch series extends the recently introduced "structure" subcommand
for git-repo(1) to collect object size information. More specifically,
it shows total inflated and disk sizes of objects by object type. The
aim to provide additional insight that may be useful to users regarding
the structure of a repository.

In addition to this change, this series also updates the table output
format to downscale larger output values along with the appropriate unit
prefix. This is done to make table output more human friendly. The
keyvalue and nul output formats are left the same since they are
intended more for machine parsing.

Changes in V3:
- Address potential localization regression by making the downscaled
  number format string also translatable. Also make the format string
  for how the values and unit prefixes are displayed via
  `strbuf_humanise_{bytes,rate}()` translatable to be more flexible.
- `strbuf_humanise_{bytes,count}_value()` has been renamed to
  `humanise_{bytes,count}()` and updated to provide both the value and
  unit prefix as separate strings.
- Unit prefix strings are no longer allocated and instead constant.
- The humanise flags are now defined in an enum.
- Instead of using `OBJECT_INFO_FOR_PREFETCH`,
  `OBJECT_INFO_SKIP_FETCH_OBJECT` and `OBJECT_INFO_QUICK` are used
  explicitly.
- Tests now use git-rev-list(1) to verify disk size info.

Changes in V2:
- Factor out and reuse existing logic from strbuf_humanise() to handle
  downscaling values and determining the appropriate unit prefix
  separately. This enables more control over how exactly the values are
  written to the structure output table which is useful for alignment
  reasons. I'm not how about the interface used in patch 2. Feedback is
  most welcome.
- In the previous version, when checking object size on a missing object
  we would die. Instead we now ignore missing objects. This allows the
  structure command to work on partial clones.
- disk/inflated keyvalue names renamed to disk_size/inflated_size.
- Unit prefixes are marked for translation.
- The test for keyvalue disk size values are updated to check against
  real expected values instead of skipping. Table output tests still
  skip verifing human-readable values though.

Thanks,
-Justin

Justin Tobler (7):
  builtin/repo: group per-type object values into struct
  strbuf: split out logic to humanise byte values
  builtin/repo: humanise count values in structure output
  builtin/repo: add inflated object info to keyvalue structure output
  builtin/repo: add inflated object info to structure table
  builtin/repo: add disk size info to keyvalue stucture output
  builtin/repo: add object disk size info to structure table

 Documentation/git-repo.adoc |   2 +
 builtin/repo.c              | 175 ++++++++++++++++++++++++++++++------
 strbuf.c                    |  93 ++++++++++++-------
 strbuf.h                    |  25 ++++++
 t/t1901-repo-structure.sh   | 113 +++++++++++++++--------
 5 files changed, 311 insertions(+), 97 deletions(-)

Range-diff against v2:
1:  be14de68f6 = 1:  be14de68f6 builtin/repo: group per-type object values into struct
2:  5ca6f9b708 ! 2:  1fa33f5906 strbuf: split out logic to humanise byte values
    @@ Commit message
         the git-repo(1) "structure" subcommand will be shown in a more
         human-readable format with the appropriate unit prefixes. For this
         usecase, the downscaled values and unit prefixes must be handled
    -    separately to ensure proper column alignment. Refactor strbuf_humanise()
    -    to instead append the downscaled byte value to the buffer only and
    -    return the appropriate unit prefix string.
    +    separately to ensure proper column alignment.
    +
    +    Split out logic from strbuf_humanise() to downscale byte values and
    +    determine the corresponding unit prefix into a separate humanise_bytes()
    +    function that provides seperate value and unit strings.
     
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
    @@ strbuf.c: void strbuf_addstr_urlencode(struct strbuf *sb, const char *s,
      
     -static void strbuf_humanise(struct strbuf *buf, off_t bytes,
     -				 int humanise_rate)
    -+char *strbuf_humanise_bytes_value(struct strbuf *buf, off_t bytes, unsigned flags)
    ++void humanise_bytes(off_t bytes, char **value, const char **unit,
    ++		    unsigned flags)
      {
    -+	int humanise_rate = flags & STRBUF_HUMANISE_RATE;
    ++	int humanise_rate = flags & HUMANISE_RATE;
     +
      	if (bytes > 1 << 30) {
     -		strbuf_addf(buf,
    @@ strbuf.c: void strbuf_addstr_urlencode(struct strbuf *sb, const char *s,
     -					/* TRANSLATORS: IEC 80000-13:2008 gibibyte/second */
     -					_("%u.%2.2u GiB/s"),
     -			    (unsigned)(bytes >> 30),
    -+		strbuf_addf(buf, "%u.%2.2u", (unsigned)(bytes >> 30),
    - 			    (unsigned)(bytes & ((1 << 30) - 1)) / 10737419);
    +-			    (unsigned)(bytes & ((1 << 30) - 1)) / 10737419);
    ++		*value = xstrfmt(_("%u.%2.2u"), (unsigned)(bytes >> 30),
    ++				 (unsigned)(bytes & ((1 << 30) - 1)) / 10737419);
     +		/* TRANSLATORS: IEC 80000-13:2008 gibibyte/second and gibibyte */
    -+		return humanise_rate ? xstrfmt(_("GiB/s")) : xstrfmt(_("GiB"));
    ++		*unit = humanise_rate ? _("GiB/s") : _("GiB");
      	} else if (bytes > 1 << 20) {
     -		unsigned x = bytes + 5243;  /* for rounding */
     -		strbuf_addf(buf,
    @@ strbuf.c: void strbuf_addstr_urlencode(struct strbuf *sb, const char *s,
     -					_("%u.%2.2u MiB/s"),
     -			    x >> 20, ((x & ((1 << 20) - 1)) * 100) >> 20);
     +		unsigned x = bytes + 5243; /* for rounding */
    -+		strbuf_addf(buf, "%u.%2.2u", x >> 20,
    -+			    ((x & ((1 << 20) - 1)) * 100) >> 20);
    ++		*value = xstrfmt(_("%u.%2.2u"), x >> 20,
    ++				 ((x & ((1 << 20) - 1)) * 100) >> 20);
     +		/* TRANSLATORS: IEC 80000-13:2008 mebibyte/second and mebibyte */
    -+		return humanise_rate ? xstrfmt(_("MiB/s")) : xstrfmt(_("MiB"));
    ++		*unit = humanise_rate ? _("MiB/s") : _("MiB");
      	} else if (bytes > 1 << 10) {
     -		unsigned x = bytes + 5;  /* for rounding */
     -		strbuf_addf(buf,
    @@ strbuf.c: void strbuf_addstr_urlencode(struct strbuf *sb, const char *s,
     -					_("%u.%2.2u KiB/s"),
     -			    x >> 10, ((x & ((1 << 10) - 1)) * 100) >> 10);
     +		unsigned x = bytes + 5; /* for rounding */
    -+		strbuf_addf(buf, "%u.%2.2u", x >> 10,
    -+			    ((x & ((1 << 10) - 1)) * 100) >> 10);
    ++		*value = xstrfmt(_("%u.%2.2u"), x >> 10,
    ++				 ((x & ((1 << 10) - 1)) * 100) >> 10);
     +		/* TRANSLATORS: IEC 80000-13:2008 kibibyte/second and kibibyte */
    -+		return humanise_rate ? xstrfmt(_("KiB/s")) : xstrfmt(_("KiB"));
    ++		*unit = humanise_rate ? _("KiB/s") : _("KiB");
      	} else {
     -		strbuf_addf(buf,
     -				humanise_rate == 0 ?
    @@ strbuf.c: void strbuf_addstr_urlencode(struct strbuf *sb, const char *s,
     -					/* TRANSLATORS: IEC 80000-13:2008 byte/second */
     -					Q_("%u byte/s", "%u bytes/s", bytes),
     -				(unsigned)bytes);
    -+		strbuf_addf(buf, "%u", (unsigned)bytes);
    -+		return humanise_rate ?
    ++		*value = xstrfmt(_("%u"), (unsigned)bytes);
    ++		*unit = humanise_rate ?
     +			       /* TRANSLATORS: IEC 80000-13:2008 byte/second */
    -+			       xstrfmt(Q_("byte/s", "bytes/s", bytes)) :
    ++			       Q_("byte/s", "bytes/s", bytes) :
     +			       /* TRANSLATORS: IEC 80000-13:2008 byte */
    -+			       xstrfmt(Q_("byte", "bytes", bytes));
    ++			       Q_("byte", "bytes", bytes);
      	}
      }
      
    ++static void strbuf_humanise(struct strbuf *buf, off_t bytes, unsigned flags)
    ++{
    ++	char *value;
    ++	const char *unit;
    ++
    ++	humanise_bytes(bytes, &value, &unit, flags);
    ++	strbuf_addf(buf, _("%s %s"), value, unit);
    ++	free(value);
    ++}
    ++
      void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes)
      {
    --	strbuf_humanise(buf, bytes, 0);
    -+	char *unit = strbuf_humanise_bytes_value(buf, bytes, 0);
    -+	strbuf_addf(buf, " %s", unit);
    -+	free(unit);
    - }
    + 	strbuf_humanise(buf, bytes, 0);
    +@@ strbuf.c: void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes)
      
      void strbuf_humanise_rate(struct strbuf *buf, off_t bytes)
      {
     -	strbuf_humanise(buf, bytes, 1);
    -+	char *unit = strbuf_humanise_bytes_value(buf, bytes, STRBUF_HUMANISE_RATE);
    -+	strbuf_addf(buf, " %s", unit);
    -+	free(unit);
    ++	strbuf_humanise(buf, bytes, HUMANISE_RATE);
      }
      
      int printf_ln(const char *fmt, ...)
    @@ strbuf.h: void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strbu
       */
      void strbuf_add_percentencode(struct strbuf *dst, const char *src, int flags);
      
    -+#define STRBUF_HUMANISE_RATE 1 << 0
    ++enum humanise_flags {
    ++	/*
    ++	 * Use rate based unit prefixes for humanised values.
    ++	 */
    ++	HUMANISE_RATE = (1 << 0),
    ++};
     +
     +/**
    -+ * Append the given byte size as a human-readable string that is downscaled by
    -+ * some factor. A string with the corresponding unit prefix is returned
    -+ * separately.
    ++ * Converts the given byte size into a downscaled human-readable value and
    ++ * corresponding unit prefix as two separate strings.
     + */
    -+char *strbuf_humanise_bytes_value(struct strbuf *buf, off_t bytes, unsigned flags);
    ++void humanise_bytes(off_t bytes, char **value, const char **unit,
    ++		    unsigned flags);
     +
      /**
       * Append the given byte size as a human-readable string (i.e. 12.23 KiB,
3:  2efc3533ef ! 3:  8f09f6358e builtin/repo: humanise count values in structure output
    @@ builtin/repo.c: struct stats_table {
       */
      struct stats_table_entry {
      	char *value;
    -+	char *unit;
    ++	const char *unit;
      };
      
      static void stats_table_vaddf(struct stats_table *table,
    @@ builtin/repo.c: static void stats_table_vaddf(struct stats_table *table,
      
      static void stats_table_addf(struct stats_table *table, const char *format, ...)
     @@ builtin/repo.c: static void stats_table_count_addf(struct stats_table *table, size_t value,
    - 				   const char *format, ...)
    - {
    - 	struct stats_table_entry *entry;
    -+	struct strbuf buf = STRBUF_INIT;
      	va_list ap;
      
      	CALLOC_ARRAY(entry, 1);
     -	entry->value = xstrfmt("%" PRIuMAX, (uintmax_t)value);
    -+
    -+	entry->unit = strbuf_humanise_count_value(&buf, value);
    -+	entry->value = strbuf_detach(&buf, NULL);
    ++	humanise_count(value, &entry->value, &entry->unit);
      
      	va_start(ap, format);
      	stats_table_vaddf(table, entry, format, ap);
    @@ builtin/repo.c: static void stats_table_print_structure(const struct stats_table
      		strbuf_addstr(&buf, " |");
      		printf("%s\n", buf.buf);
      	}
    -@@ builtin/repo.c: static void stats_table_clear(struct stats_table *table)
    - 
    - 	for_each_string_list_item(item, &table->rows) {
    - 		entry = item->util;
    --		if (entry)
    -+		if (entry) {
    - 			free(entry->value);
    -+			free(entry->unit);
    -+		}
    - 	}
    - 
    - 	string_list_clear(&table->rows, 1);
     
      ## strbuf.c ##
     @@ strbuf.c: void strbuf_addstr_urlencode(struct strbuf *sb, const char *s,
      	strbuf_add_urlencode(sb, s, strlen(s), allow_unencoded_fn);
      }
      
    -+char *strbuf_humanise_count_value(struct strbuf *buf, size_t value)
    ++void humanise_count(size_t count, char **value, const char **unit)
     +{
    -+	if (value >= 1000000000) {
    -+		uintmax_t x = (uintmax_t)value + 5000000; /* for rounding */
    -+		strbuf_addf(buf, "%" PRIuMAX ".%02" PRIuMAX,
    -+			    x / 1000000000, x % 1000000000 / 10000000);
    -+		return xstrfmt(_("G"));
    -+	} else if (value >= 1000000) {
    -+		uintmax_t x = (uintmax_t)value + 5000; /* for rounding */
    -+		strbuf_addf(buf, "%" PRIuMAX ".%02" PRIuMAX,
    -+			    x / 1000000, x % 1000000 / 10000);
    -+		return xstrfmt(_("M"));
    -+	} else if (value >= 1000) {
    -+		uintmax_t x = (uintmax_t)value + 5; /* for rounding */
    -+		strbuf_addf(buf, "%" PRIuMAX ".%02" PRIuMAX,
    -+			    x / 1000, x % 1000 / 10);
    -+		return xstrfmt(_("k"));
    ++	if (count >= 1000000000) {
    ++		size_t x = count + 5000000; /* for rounding */
    ++		*value = xstrfmt(_("%u.%2.2u"), (unsigned)(x / 1000000000),
    ++				 (unsigned)(x % 1000000000 / 10000000));
    ++		*unit = _("G");
    ++	} else if (count >= 1000000) {
    ++		size_t x = count + 5000; /* for rounding */
    ++		*value = xstrfmt(_("%u.%2.2u"), (unsigned)(x / 1000000),
    ++				 (unsigned)(x % 1000000 / 10000));
    ++		*unit = _("M");
    ++	} else if (count >= 1000) {
    ++		size_t x = count + 5; /* for rounding */
    ++		*value = xstrfmt(_("%u.%2.2u"), (unsigned)(x / 1000),
    ++				 (unsigned)(x % 1000 / 10));
    ++		*unit = _("k");
     +	} else {
    -+		strbuf_addf(buf, "%" PRIuMAX, (uintmax_t)value);
    -+		return NULL;
    ++		*value = xstrfmt(_("%u"), (unsigned)count);
    ++		*unit = NULL;
     +	}
     +}
     +
    - char *strbuf_humanise_bytes_value(struct strbuf *buf, off_t bytes, unsigned flags)
    + void humanise_bytes(off_t bytes, char **value, const char **unit,
    + 		    unsigned flags)
      {
    - 	int humanise_rate = flags & STRBUF_HUMANISE_RATE;
     
      ## strbuf.h ##
    -@@ strbuf.h: void strbuf_add_percentencode(struct strbuf *dst, const char *src, int flags);
    -  */
    - char *strbuf_humanise_bytes_value(struct strbuf *buf, off_t bytes, unsigned flags);
    +@@ strbuf.h: enum humanise_flags {
    + void humanise_bytes(off_t bytes, char **value, const char **unit,
    + 		    unsigned flags);
      
     +/**
    -+ * Append the given count value as a human-readable string that is downsacled by
    -+ * some factor. A string with the corresponding unit prefix is returned
    -+ * separately.
    ++ * Converts the given count into a downscaled human-readable value and
    ++ * corresponding unit prefix as two separate strings.
     + */
    -+char *strbuf_humanise_count_value(struct strbuf *buf, size_t value);
    ++void humanise_count(size_t count, char **value, const char **unit);
     +
      /**
       * Append the given byte size as a human-readable string (i.e. 12.23 KiB,
4:  627b8bf025 ! 4:  3f4eabe94f builtin/repo: add inflated object info to keyvalue structure output
    @@ builtin/repo.c: static int count_objects(const char *path UNUSED, struct oid_arr
     +		oi.sizep = &inflated;
     +
     +		if (odb_read_object_info_extended(data->odb, &oids->oid[i], &oi,
    -+						  OBJECT_INFO_FOR_PREFETCH) < 0)
    ++						  OBJECT_INFO_SKIP_FETCH_OBJECT |
    ++							  OBJECT_INFO_QUICK) < 0)
     +			continue;
     +
     +		inflated_total += inflated;
5:  14f4983e1d ! 5:  85d1052100 builtin/repo: add inflated object info to structure table
    @@ builtin/repo.c: static void stats_table_count_addf(struct stats_table *table, si
     +				  const char *format, ...)
     +{
     +	struct stats_table_entry *entry;
    -+	struct strbuf buf = STRBUF_INIT;
     +	va_list ap;
     +
     +	CALLOC_ARRAY(entry, 1);
    -+
    -+	entry->unit = strbuf_humanise_bytes_value(&buf, value,
    -+						  STRBUF_HUMANISE_COMPACT);
    -+	entry->value = strbuf_detach(&buf, NULL);
    ++	humanise_bytes(value, &entry->value, &entry->unit, HUMANISE_COMPACT);
     +
     +	va_start(ap, format);
     +	stats_table_vaddf(table, entry, format, ap);
    @@ builtin/repo.c: static void stats_table_setup_structure(struct stats_table *tabl
      static void stats_table_print_structure(const struct stats_table *table)
     
      ## strbuf.c ##
    -@@ strbuf.c: char *strbuf_humanise_bytes_value(struct strbuf *buf, off_t bytes, unsigned flag
    - 		return humanise_rate ? xstrfmt(_("KiB/s")) : xstrfmt(_("KiB"));
    +@@ strbuf.c: void humanise_bytes(off_t bytes, char **value, const char **unit,
    + 		*unit = humanise_rate ? _("KiB/s") : _("KiB");
      	} else {
    - 		strbuf_addf(buf, "%u", (unsigned)bytes);
    -+		if (flags & STRBUF_HUMANISE_COMPACT)
    -+			return humanise_rate ?
    -+				       xstrfmt(_("B/s")) :
    -+				       xstrfmt(_("B"));
    - 		return humanise_rate ?
    - 			       /* TRANSLATORS: IEC 80000-13:2008 byte/second */
    - 			       xstrfmt(Q_("byte/s", "bytes/s", bytes)) :
    + 		*value = xstrfmt(_("%u"), (unsigned)bytes);
    +-		*unit = humanise_rate ?
    +-			       /* TRANSLATORS: IEC 80000-13:2008 byte/second */
    +-			       Q_("byte/s", "bytes/s", bytes) :
    +-			       /* TRANSLATORS: IEC 80000-13:2008 byte */
    +-			       Q_("byte", "bytes", bytes);
    ++		if (flags & HUMANISE_COMPACT)
    ++			*unit = humanise_rate ? _("B/s") : _("B");
    ++		else
    ++			*unit = humanise_rate ?
    ++					/* TRANSLATORS: IEC 80000-13:2008 byte/second */
    ++					Q_("byte/s", "bytes/s", bytes) :
    ++					/* TRANSLATORS: IEC 80000-13:2008 byte */
    ++					Q_("byte", "bytes", bytes);
    + 	}
    + }
    + 
     
      ## strbuf.h ##
    -@@ strbuf.h: void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strbuf *src);
    -  */
    - void strbuf_add_percentencode(struct strbuf *dst, const char *src, int flags);
    - 
    --#define STRBUF_HUMANISE_RATE 1 << 0
    -+#define STRBUF_HUMANISE_RATE	1 << 0
    -+#define STRBUF_HUMANISE_COMPACT 1 << 1
    +@@ strbuf.h: enum humanise_flags {
    + 	 * Use rate based unit prefixes for humanised values.
    + 	 */
    + 	HUMANISE_RATE = (1 << 0),
    ++	/*
    ++	 * Use compact "B" unit prefixes instead of "byte/bytes" for humanised
    ++	 * values.
    ++	 */
    ++	HUMANISE_COMPACT = (1 << 1),
    + };
      
      /**
    -  * Append the given byte size as a human-readable string that is downscaled by
     
      ## t/t1901-repo-structure.sh ##
     @@ t/t1901-repo-structure.sh: test_expect_success 'empty repository' '
6:  dc9e82889f ! 6:  e9fa9babec builtin/repo: add disk size info to keyvalue stucture output
    @@ builtin/repo.c: static int count_objects(const char *path UNUSED, struct oid_arr
     +		oi.disk_sizep = &disk;
      
      		if (odb_read_object_info_extended(data->odb, &oids->oid[i], &oi,
    - 						  OBJECT_INFO_FOR_PREFETCH) < 0)
    + 						  OBJECT_INFO_SKIP_FETCH_OBJECT |
    +@@ builtin/repo.c: static int count_objects(const char *path UNUSED, struct oid_array *oids,
      			continue;
      
      		inflated_total += inflated;
    @@ t/t1901-repo-structure.sh: test_description='test git repo structure'
      . ./test-lib.sh
      
     +object_type_disk_usage() {
    -+	git cat-file --batch-check='%(objectsize:disk)' --batch-all-objects \
    -+		--filter=object:type=$1 | awk '{ sum += $1 } END { print sum }'
    ++	git rev-list --all --objects --disk-usage --filter=object:type=$1 \
    ++		--filter-provided-objects
     +}
     +
      test_expect_success 'empty repository' '
7:  213b19dc7f ! 7:  df542c7bdf builtin/repo: add object disk size info to structure table
    @@ Commit message
         git-repo(1) structure command to display the total object disk usage by
         object type.
     
    -    Since disk size may vary between platforms, tests do not validate actual
    -    values and only check that size info is printed in an empty repository.
    -
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
      ## builtin/repo.c ##
    @@ builtin/repo.c: static void stats_table_setup_structure(struct stats_table *tabl
      static void stats_table_print_structure(const struct stats_table *table)
     
      ## t/t1901-repo-structure.sh ##
    -@@ t/t1901-repo-structure.sh: object_type_disk_usage() {
    - 		--filter=object:type=$1 | awk '{ sum += $1 } END { print sum }'
    - }
    +@@ t/t1901-repo-structure.sh: test_description='test git repo structure'
    + . ./test-lib.sh
      
    -+strip_object_disk_usage() {
    -+	awk '
    -+		/^\|   \* Disk size/ { skip=1; next }
    -+		skip && /^\|     \* / { next }
    -+		skip && !/^\|     \* / { skip=0 }
    -+		{ print }
    -+	' $1
    -+}
    + object_type_disk_usage() {
    +-	git rev-list --all --objects --disk-usage --filter=object:type=$1 \
    +-		--filter-provided-objects
    ++	disk_usage_opt="--disk-usage"
    ++
    ++	if [ "$2" = "true" ]; then
    ++		disk_usage_opt="--disk-usage=human"
    ++	fi
     +
    ++	if [ "$1" = "all" ]; then
    ++		git rev-list --all --objects $disk_usage_opt
    ++	else
    ++		git rev-list --all --objects $disk_usage_opt \
    ++			--filter=object:type=$1 --filter-provided-objects
    ++	fi
    + }
    + 
      test_expect_success 'empty repository' '
    - 	test_when_finished "rm -rf repo" &&
    - 	git init repo &&
     @@ t/t1901-repo-structure.sh: test_expect_success 'empty repository' '
      		|     * Trees          |    0 B |
      		|     * Blobs          |    0 B |
    @@ t/t1901-repo-structure.sh: test_expect_success 'empty repository' '
      
      		git repo structure >out 2>err &&
     @@ t/t1901-repo-structure.sh: test_expect_success SHA1 'repository with references and objects' '
    + 		# Also creates a commit, tree, and blob.
    + 		git notes add -m foo &&
    + 
    +-		cat >expect <<-\EOF &&
    ++		cat >expect <<-EOF &&
    + 		| Repository structure | Value      |
    + 		| -------------------- | ---------- |
    + 		| * References         |            |
    +@@ t/t1901-repo-structure.sh: test_expect_success SHA1 'repository with references and objects' '
    + 		|     * Trees          |  15.81 MiB |
    + 		|     * Blobs          |  11.68 KiB |
      		|     * Tags           |    132 B   |
    ++		|   * Disk size        | $(object_type_disk_usage all true) |
    ++		|     * Commits        | $(object_type_disk_usage commit true) |
    ++		|     * Trees          | $(object_type_disk_usage tree true) |
    ++		|     * Blobs          |  $(object_type_disk_usage blob true) |
    ++		|     * Tags           |    $(object_type_disk_usage tag) B   |
      		EOF
      
    --		git repo structure >out 2>err &&
    -+		git repo structure >out.raw 2>err &&
    -+
    -+		# Skip object disk sizes due to platform variance.
    -+		strip_object_disk_usage out.raw >out &&
    - 
    - 		test_cmp expect out &&
    - 		test_line_count = 0 err
    + 		git repo structure >out 2>err &&

base-commit: e85ae279b0d58edc2f4c3fd5ac391b51e1223985
-- 
2.52.0.209.ge85ae279b0

