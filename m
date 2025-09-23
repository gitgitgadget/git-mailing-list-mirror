Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C121E8332
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 15:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758640942; cv=none; b=BPhLPIiXRg32ddMHX1pAcNqg1JRCXDzmSAZdKvNo9whP+nZBFow/T9mexMpPCFOwo8WoK79+dQQNAiSurGNvoefhVbp8zjo8m071jgiruadM8/+SAobnZk/udjMkdgF6TIGoQ/AWNd+Xhw3PVceGITL7WDqOSAEE9sttKuaxjGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758640942; c=relaxed/simple;
	bh=ox3XgSArl713xCP0Tei2xJXfksuor4Px2G9C/dfPF4U=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=GzExp1F0U24AEEubD1ebY9mV4lzcJcE1Y3Dtu7hoeL4hisiCEfeDJr6w4Sxd3IMrBw8UV2k8CCvEXP9qNCcDER7rzY2nukKu3P9XtFOxRuNDzCHrq92+DS90QAgOKKudTtNdRFMfpjnUm89e/uT0fvQ9eKmYNxylk79JokU75Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIAQV81K; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIAQV81K"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-8fea25727a9so731751241.1
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 08:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758640939; x=1759245739; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8+Dnir5shsjjn9yYTeAlF/TDsdel2jj7zE1NuDWLp2E=;
        b=cIAQV81KWm6OhvnEebD8vZLebbh6zJbZVdGKsJiR/7SbytAwfaYPvs4huHhintWDpr
         L7u9iBRbyumhH8Jx8/dB3ALNKjibqEd2HiNHnDuWfu359IULJCEKlFC9nPH/JrTz3yp2
         H1nrmWnhFwGaq1LyCSQbopnMaZ/D0LF5vsRCtu+qcYQYkauvZTD/lNey8M+9AH6nDApy
         4XcB4T5HigjYmpmqPNSVvh3qAp6UREEdJlsPlCDuG+KvAUlp7gDWiU8u/MYK2Ogue4NT
         EUDOr5gfP8CPzNkr/8kpt5buw/4qHtSNu1ubHEjg+V+gDtX/NDkcTbkH+XYhz0xEzIzU
         3PMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758640939; x=1759245739;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8+Dnir5shsjjn9yYTeAlF/TDsdel2jj7zE1NuDWLp2E=;
        b=kNTEdocR4Z8vndhT4ksLLIQYmsMtwyEc2BhrrQIopLlf6rIfmu6uKzgkHHmfKQBBc2
         goqYiBOsY0sr198KNSgGRZxWPKRpZ9u1c6dHQTszq54eY2h8KrhARjsO35W0HziZk6pE
         GI1+XB1wAEkaKeLXnU39n7heT+M2Kt2HFe5oeqXMwcac9dr/GfB3yfgrVHcDtiK3jwck
         csODqtnN9KzoNZ/PYykTMvN86jMeMPM1CbPCJqdVg8oM0S/5qsnRM2x+3mrtatyaA7V2
         eeZqL++u4ycci0wBpwHBrKDBCJ2gEZavV4vC2uYQINJ5fC+PB2Qi+wVLLi/D+edaonTI
         YBuA==
X-Forwarded-Encrypted: i=1; AJvYcCXwH4L0x5nTVgGDkGzFPvlSybBnvbMSSE2fZJgRrIhmoDpAfU95MDvxv9ygmxqH/Sg5X4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuyGTE4d26x4UPyfL98XwsdSs4Jl5tMgNddvyYuMhfSPVb6lty
	dT+Uj9h+atozKNCP6eokpMeZH1JnkVtxoYBD44zdpYjPp0t0vf+vaWQFado8KIwetENKwxVJhNm
	G159Gktdnh34iwhAriWpdL9jz/oDFhVA=
X-Gm-Gg: ASbGnct0mHrS6fSg+dHlcf35uLSiwOIv0ScENG3lqp86ngqkqGoesQ18N1QirfNO71p
	yIfKk35CsHwmk20mduLKlhJscflCRE6kzZZ5jU1tAIw7kXuNP51G8dSe29D9h6QRsRwlSs4jf3t
	GpaKyoPVExbj+O57LLzaNhMeU2C8fXQYaMs8BlQJm8JB6W2iSY+9YQMkSezTIYi6Uyu/re55urL
	/ED2LmrzG5ssJ8WSQ==
X-Google-Smtp-Source: AGHT+IERNMW8HYTFq30/gj9CqA6+wdXytO4+RSgJtWjXDFQ3+lasSPU6x6kRD97AU9CGeVcqv/F9uNpc/PC2OGVFD0o=
X-Received: by 2002:a05:6102:32cd:b0:518:9c6a:2c04 with SMTP id
 ada2fe7eead31-5a5835dccaemr887607137.31.1758640938576; Tue, 23 Sep 2025
 08:22:18 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Sep 2025 11:22:17 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Sep 2025 11:22:17 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250923025700.3046260-2-jltobler@gmail.com>
References: <20250923025700.3046260-1-jltobler@gmail.com> <20250923025700.3046260-2-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 23 Sep 2025 11:22:17 -0400
X-Gm-Features: AS18NWDb83G8C_iX5f3GD86f9SliffhpZtKhrd66CbudjNvLZCSPs0SGi89QRwo
Message-ID: <CAOLa=ZQHU8m-BLzD=uWx6e-FVcs-aDmrUp9qrU72_5E=CNQRNg@mail.gmail.com>
Subject: Re: [PATCH 1/4] builtin/repo: introduce stats subcommand
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000006ea540063f798004"

--0000000000006ea540063f798004
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

[snip]

> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> index 209afd1b61..7762329551 100644
> --- a/Documentation/git-repo.adoc
> +++ b/Documentation/git-repo.adoc
> @@ -9,6 +9,7 @@ SYNOPSIS
>  --------
>  [synopsis]
>  git repo info [--format=(keyvalue|nul)] [-z] [<key>...]
> +git repo stats
>
>  DESCRIPTION
>  -----------
> @@ -43,6 +44,12 @@ supported:
>  +
>  `-z` is an alias for `--format=nul`.
>
> +stats::
> +	Retrieve stats about the current repository. All references in the
> +	repository are categorized and counted accordingly.
> ++

Nit: Should we use bullet points for the information provided? As of
this commit it is only references, but with time, this will grow, so
would be nice to have a set of bullet points to understand the different
information retrieved.

> +The table output format may change and is not intended for machine parsing.
> +
>  INFO KEYS
>  ---------
>  In order to obtain a set of values from `git repo info`, you should provide
> diff --git a/builtin/repo.c b/builtin/repo.c
> index bbb0966f2d..15899dd74c 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -4,12 +4,15 @@
>  #include "environment.h"
>  #include "parse-options.h"
>  #include "quote.h"
> +#include "ref-filter.h"
>  #include "refs.h"
>  #include "strbuf.h"
> +#include "string-list.h"
>  #include "shallow.h"
>
>  static const char *const repo_usage[] = {
>  	"git repo info [--format=(keyvalue|nul)] [-z] [<key>...]",
> +	"git repo stats",
>  	NULL
>  };
>
> @@ -156,12 +159,160 @@ static int repo_info(int argc, const char **argv, const char *prefix,
>  	return print_fields(argc, argv, repo, format);
>  }
>
> +struct stats {
> +	size_t branches;
> +	size_t remotes;
> +	size_t tags;
> +	size_t others;

Maybe we can use a nested structure here, which would reflect the output
table. That would be much nicer, as the code would grow, currently we
know 'others' here refers to references, but with other fields coming
in, this would no longer be obvious.

> +};
> +
> +struct stats_table {
> +	struct string_list rows;
> +
> +	int name_col_width;
> +	int value_col_width;

Can these be negative?

> +};
> +

Nit: Could we add a comment about what this structure is and what it
holds? I think it is sort of obvious, but would be nice to clarify.


> +struct stats_table_entry {
> +	char *value;
> +};
> +
> +static void stats_table_add(struct stats_table *table, const char *name,
> +			    struct stats_table_entry *entry)
> +{
> +	int name_width = strlen(name);
> +	struct string_list_item *item;
> +
> +	item = string_list_append(&table->rows, name);
> +	item->util = entry;
> +
> +	if (name_width > table->name_col_width)
> +		table->name_col_width = name_width;
> +	if (entry) {
> +		int value_width = strlen(entry->value);
> +		if (value_width > table->value_col_width)
> +			table->value_col_width = value_width;
> +	}
> +}
> +
> +static void stats_table_add_count(struct stats_table *table, const char *name,
> +				  size_t value)
> +{
> +	struct stats_table_entry *entry;
> +
> +	CALLOC_ARRAY(entry, 1);
> +	entry->value = xstrfmt("%" PRIuMAX, (uintmax_t)value);
> +	stats_table_add(table, name, entry);
> +}
> +
> +static void stats_table_setup(struct stats_table *table, struct stats *stats)
> +{
> +	size_t ref_total;
> +
> +	ref_total = stats->branches + stats->remotes + stats->tags + stats->others;
> +	stats_table_add(table, _("* References"), NULL);
> +	stats_table_add_count(table, _("  * Count"), ref_total);
> +	stats_table_add_count(table, _("    * Branches"), stats->branches);
> +	stats_table_add_count(table, _("    * Tags"), stats->tags);
> +	stats_table_add_count(table, _("    * Remotes"), stats->remotes);
> +	stats_table_add_count(table, _("    * Others"), stats->others);
> +}
> +
> +static void stats_table_print(struct stats_table *table)
> +{
> +	const char *name_col_title = _("Repository stats");
> +	const char *value_col_title = _("Value");
> +	int name_col_width = strlen(name_col_title);
> +	int value_col_width = strlen(value_col_title);
> +	struct strbuf buf = STRBUF_INIT;
> +	struct string_list_item *item;
> +
> +	if (table->name_col_width > name_col_width)
> +		name_col_width = table->name_col_width;
> +	if (table->value_col_width > value_col_width)
> +		value_col_width = table->value_col_width;
> +
> +	strbuf_addf(&buf, "| %-*s | %-*s |\n", name_col_width, name_col_title,
> +		    value_col_width, value_col_title);
> +	strbuf_addstr(&buf, "| ");
> +	strbuf_addchars(&buf, '-', name_col_width);
> +	strbuf_addstr(&buf, " | ");
> +	strbuf_addchars(&buf, '-', value_col_width);
> +	strbuf_addstr(&buf, " |\n");
> +
> +	for_each_string_list_item (item, &table->rows) {
> +		struct stats_table_entry *entry = item->util;
> +		const char *value = "";
> +
> +		if (entry) {
> +			struct stats_table_entry *entry = item->util;
> +			value = entry->value;
> +		}
> +
> +		strbuf_addf(&buf, "| %-*s | %*s |\n", name_col_width,
> +			    item->string, value_col_width, value);
> +
> +		if (entry)
> +			free(entry->value);
> +	}
> +
> +	fputs(buf.buf, stdout);
> +	strbuf_release(&buf);
> +}
> +
> +static void stats_count_references(struct stats *stats, struct ref_array *refs)
> +{
> +	for (int i = 0; i < refs->nr; i++) {
> +		struct ref_array_item *ref = refs->items[i];
> +
> +		switch (ref->kind) {
> +		case FILTER_REFS_BRANCHES:
> +			stats->branches++;
> +			break;
> +		case FILTER_REFS_REMOTES:
> +			stats->remotes++;
> +			break;
> +		case FILTER_REFS_TAGS:
> +			stats->tags++;
> +			break;
> +		case FILTER_REFS_OTHERS:
> +			stats->others++;
> +			break;
> +		}
> +	}
> +}
> +
> +static int repo_stats(int argc UNUSED, const char **argv UNUSED,
> +		      const char *prefix UNUSED, struct repository *repo UNUSED)
> +{
> +	struct ref_filter filter = REF_FILTER_INIT;
> +	struct strvec ref_patterns = STRVEC_INIT;
> +	struct stats_table table = { 0 };
> +	struct ref_array refs = { 0 };
> +	struct stats stats = { 0 };
> +
> +	filter.name_patterns = ref_patterns.v;
> +	filter_refs(&refs, &filter, FILTER_REFS_REGULAR);
> +

I was wondering why we need the filter mechanism here, but seems like
this is to obtain the type of the reference. This is setup automatically
by the filter mechanism and so it's okay.

We could replicate the same using the ref iterator code. This would be a
little more involved, but would remove the need to store all refs in a
'ref_array' and also the need to loop over references twice. But it
doesn't really matter in this usecase I assume.

> +	stats_count_references(&stats, &refs);
> +
> +	stats_table_setup(&table, &stats);
> +	stats_table_print(&table);
> +
> +	string_list_clear(&table.rows, 1);
> +	strvec_clear(&ref_patterns);

Huh. So `ref_patterns` is simply a dummy variable, I was wondering why
we simply can't set `filter.name_patterns = NULL`. I see that it is
because in `filter_pattern_match()` we do `if
(!*filter->name_patterns)`. This is not a great interface for
ref-filter. Perhaps we could add a precursor commit like:

diff --git a/ref-filter.c b/ref-filter.c
index 520d2539c9..20284b5918 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2664,7 +2664,7 @@ static int match_name_as_path(const char
**pattern, const char *refname,
 /* Return 1 if the refname matches one of the patterns, otherwise 0. */
 static int filter_pattern_match(struct ref_filter *filter, const char *refname)
 {
-	if (!*filter->name_patterns)
+	if (!filter->name_patterns || !*filter->name_patterns)
 		return 1; /* No pattern always matches */
 	if (filter->match_as_path)
 		return match_name_as_path(filter->name_patterns, refname,
diff --git a/ref-filter.h b/ref-filter.h
index f22ca94b49..44d9b481ad 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -109,6 +109,7 @@ struct ref_format {
 #define REF_FILTER_INIT { \
 	.points_at = OID_ARRAY_INIT, \
 	.exclude = STRVEC_INIT, \
+	.name_pattern = NULL, \
 }
 #define REF_FORMAT_INIT {             \
 	.use_color = -1,              \


and then we could modify this commit:

diff --git a/builtin/repo.c b/builtin/repo.c
index 15899dd74c..09733b8df7 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -286,12 +286,11 @@ static int repo_stats(int argc UNUSED, const
char **argv UNUSED,
 		      const char *prefix UNUSED, struct repository *repo UNUSED)
 {
 	struct ref_filter filter = REF_FILTER_INIT;
-	struct strvec ref_patterns = STRVEC_INIT;
 	struct stats_table table = { 0 };
 	struct ref_array refs = { 0 };
 	struct stats stats = { 0 };

-	filter.name_patterns = ref_patterns.v;
 	filter_refs(&refs, &filter, FILTER_REFS_REGULAR);

 	stats_count_references(&stats, &refs);
@@ -300,7 +299,6 @@ static int repo_stats(int argc UNUSED, const char
**argv UNUSED,
 	stats_table_print(&table);

 	string_list_clear(&table.rows, 1);
-	strvec_clear(&ref_patterns);
 	ref_array_clear(&refs);

 	return 0;

> +	ref_array_clear(&refs);
> +
> +	return 0;
> +}
> +
>  int cmd_repo(int argc, const char **argv, const char *prefix,
>  	     struct repository *repo)
>  {
>  	parse_opt_subcommand_fn *fn = NULL;
>  	struct option options[] = {
>  		OPT_SUBCOMMAND("info", &fn, repo_info),
> +		OPT_SUBCOMMAND("stats", &fn, repo_stats),
>  		OPT_END()
>  	};
>

[snip]

--0000000000006ea540063f798004
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 59ea3ce6610b686f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qU3V5Y1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meW5iQy9zRmU2OVc5cEtKRGFtd1kvcE1kSG9MeUZKYgp2QjUxdUk0NEJt
V0I1WUVLVkdNMjdXbm5nUEdiUm1jMks2V3J5RnJwcGp5eXY0RHpCeXY0cGtLeUJMcm1qZjdtClAr
YysvaHFmUDMrSktIUS8yMkl2aHE1Z3hTV2x0Y2hSVWFLTDZuQmlqajd2a1ZTeGg3SUxHTFBBaGJB
bzliTUMKMTI3Tjh1UWgxNVNKYitVaExpdFpKOEtEUjVDVVpzejVxazFCd1JHNVZYbHduZnVadHoy
QitMSWMzQ1J5dnh1dgpwYzBqL0UvL0RWRlQram1lSGVMZVhGTVZSVk5tUW5UNlpqQUEvcE8vYk1X
ci9MRWhXMXZtdmQwSjBEQUY2YjJkCmc2UlZWd2MrWUV1SEZDcXhuNXdNOWtZaEMzeFdZTHZUVTNJ
bGlXZTdYSjdCUmhaSVhnWVUzbHI4dGFhNGpmRWEKd2N3c2FDY2tnV2g2OUxUeDhhTm10NFcvWUxo
SWp4dHExb3U4ZklYR3BRc1c3RlViaFpDQWVFanBOb09GN3V5dgpyaDdGcHFGelhmVm5YcEhpNEdD
U1VsV0huYXA2b3Z5eTdRdm16amIvd3V2cDY0bEVNMVhXVGpLdG80N0ExREg2CmR2OHdLdENtZVFU
dXFZWVo0K2dXN0wweVFrTm5CbnZLM01LeDR5WT0KPTB0b0wKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006ea540063f798004--
