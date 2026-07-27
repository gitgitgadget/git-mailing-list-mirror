Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C4D1D88D7
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 01:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785114382; cv=none; b=FrLXZlm+0jKdfkhqqiNBi3caH8SKya9GrHl9UNkyg8T1cDoC8WI/F3uvEF1tnIRaePNFOUIQjfcDyMxTWTUr/bf6CzmsdIhTTBrUsAJ/IRnqWTq4+9eIlmc20NR0IEToTsWil7//1cJmfrzVdOr/Yt9tI3Kgp37P66Y/IeyrbHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785114382; c=relaxed/simple;
	bh=3bamKxmJWUFhiElez5YxF9C7dPSc/s0wbzF2x8Lodss=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=F+kKint8gvhds1B37SKuDFceKgbqU+QadcusUDTmSAnfC179BSVIPR98LNKJ9qbC8EAqcKL6hjTGMo6si0PYAy/akNmwcMOvRNT6S4vNqBy+64S+1kn76OAd/t9EHormLUKwdIeThymJm9fexMUayVEPCWWvRJ+8Sg5Z2R7qkSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnBDc7qp; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnBDc7qp"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49545ba3d4eso12461035e9.3
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 18:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785114378; x=1785719178; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=85hq/BTsLDNRdvkdFuNTFnOYHyIszJp7qQ4MojIFyzM=;
        b=JnBDc7qpW0oK/XbAKCTnZ3w+pzIBnh0vm0R8pTBUP5ss6E/cPWJ7JtP2M2a4qcIB8Y
         kDhVwUGJvUP6kx5qFSBHTIpsyz4o4pHBS72IEgTB0Pj0v7bFfzJ5JiNWxjwfP8zOkyg5
         LP9rTsIlOClAmw/6d317gwrB1Btkj3nYB8NN+NqlhWxsb5CV7LhA1Igx30uRAkOwSHCG
         qM0Rv7f1SQqiwNsRCKdKDeNrqLy9WsyBsKgRgTdql37rjEuYJG3ZSsEwoCYCKQzYq7Ae
         XoHevaaetvQJQnQ6PFe4kiFv7rjAJUg8vmfrU9IWkqmO2MJcJcTLcxr80JzdivxBoZBa
         1zGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785114378; x=1785719178;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=85hq/BTsLDNRdvkdFuNTFnOYHyIszJp7qQ4MojIFyzM=;
        b=XhOsTbEonxeutH9d3XLqiTE7x6Pgyruzyu4F/wQ6SxJoY5g6t39PsGCbCYTdhRAoFr
         CWWQVtKrYXe7xlQzA5Z0awuJlrid4jhEVRO8z+HtDQtS8RIaOp8xE3WSY+5UIVPwwXSc
         7wYp10HwMRrb2287j2aHTRmAoeIm66957sYEuOes128A09bK5cQhY95YTt1DVqmwHHFK
         37mg5z0x4UPkSAncPlypHy8GkULy2ri2P5H8GM5p/dI/TCAMrnXbFLB9uCz1RBzdHbeo
         yTwmhvsXCf2Rl9J2VtgOjJGdO1T3oizGffHGgmIgOGKnmOuiozTWvsqrr8p58XHzV5bn
         shBw==
X-Forwarded-Encrypted: i=1; AHgh+RqM5xK8WuEnzGcOhIwuos25dlVn7OAhzPxl+54rLI68nya/3AiWes8RMn1/w7IQwIyyNb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxccJ6si5JclYAacyOibOOg8H8naMl7pTEipCNPUKIFwZp/6sYM
	RQOPQrnb93j/pdOfKGapN96V9T7Q5YUl5SrvOqN1ha6PeqeXtnH0M6Pc
X-Gm-Gg: AR+sD10rIdEOIqd1tmP3eLiICHKunGmJryws4DqFzL0blqGhMlwhKDGqixEnuHOhH3F
	fTEbmBEDeaYJKK4/Ks3bKczwiWjY4dgKmgQeV6DsrRjs93xj36FTaooXdi1/7h3sY2UWxL03OyK
	ppBq5Iur0r8oXUITjrHQKXRMbiCg4amlPmqXw++aEBoVuxXo8fAbMD//FhuEz0zmVKmn7pQ31Od
	Xy+VYvQ/KLNRGTfzzO6WP6HMtBOEFbnjx0bI4TzlaS7l6UelOusj+ToQ8BCs/Qeui9ufTbwy+GI
	gAkA84P/nnMNVHHqemunk8hQ3WbT0THoRQFbMNMf1gvmld467KZYT0mlKLtXFX8Yq8FvHHXa0Ty
	3kmIfd809MUrmnUP9Zv439+fqHE0BTgHkL7uz7/SLA8hbVVcXSc718FqRAD8etGgwAAkqO23paD
	DEMw4bthIp5tNjlqQBzW5ZC1DLWpONASAybqoFFY90TZdNj4UXsKBmE7yBX1TiYLY+4WSmpIjXh
	uEGaP77+kVV6QgREqsqOXDYwjgI/y4FVKSeLgMJtPR/QadLQ1wL2V1wHlZ/vMZmj1GUpqCrpeDV
	o503BWHfe53vfdFnuTCVyd/HD2soqOc=
X-Received: by 2002:a05:600c:198d:b0:490:44eb:c1ea with SMTP id 5b1f17b1804b1-496b5719c40mr85917485e9.24.1785114378129;
        Sun, 26 Jul 2026 18:06:18 -0700 (PDT)
Received: from localhost ([148.56.122.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957b816ef8sm181667475e9.1.2026.07.26.18.06.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jul 2026 18:06:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Jul 2026 03:06:15 +0200
Message-Id: <DK8Y8F4650AW.1XN921ROZW70F@gmail.com>
Cc: <l.s.r@web.de>, <pabloosabaterr@gmail.com>, <gitster@pobox.com>
Subject: Re: [PATCH v2] utf8: use size_t for string width methods and callee
 sites.
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Hardik Kumar" <hardikxk@gmail.com>, <git@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <DK8L6JM14UNS.16B15DIOFW1K5@gmail.com>
 <20260726195718.1914131-1-hardikxk@gmail.com>
In-Reply-To: <20260726195718.1914131-1-hardikxk@gmail.com>

[+cc Junio, who reviewed this while I was writing mine, to keep him in
the thread]

Hi!

Note that you have sent v2 in-reply-to my review from last version, not
to the v1.

This Patch does not compile with DEVELOPER=3D1:

  $ make DEVELOPER=3D1

  builtin/blame.c:681:20: error: comparison of integers of different signs:=
 'int' and 'size_t'
        (aka 'unsigned long') [-Werror,-Wsign-compare]
    681 |                 if (longest_file < num)
        |                     ~~~~~~~~~~~~ ^ ~~~
  builtin/blame.c:691:23: error: comparison of integers of different signs:=
 'int' and 'size_t'
        (aka 'unsigned long') [-Werror,-Wsign-compare]
    691 |                         if (longest_author < num)
        |                             ~~~~~~~~~~~~~~ ^ ~~~
  builtin/blame.c:696:25: error: comparison of integers of different signs:=
 'int' and 'size_t'
        (aka 'unsigned long') [-Werror,-Wsign-compare]
    696 |                 if (longest_src_lines < num)
        |                     ~~~~~~~~~~~~~~~~~ ^ ~~~
  builtin/blame.c:699:25: error: comparison of integers of different signs:=
 'int' and 'size_t'
        (aka 'unsigned long') [-Werror,-Wsign-compare]
    699 |                 if (longest_dst_lines < num)
        |                     ~~~~~~~~~~~~~~~~~ ^ ~~~

Also note that many files have DISABLE_SIGN_COMPARE_WARNINGS which hides
from us this errors.

That's why we have to be extra careful when changing signatures of
functions accross the codebase.

The title is being too explicit, when a function signature changes, it
is expected that their callers will change, no need to add it to the
title. What about:

  utf8: make utf8_strwidth() and utf8_strnwidth() return size_t

does it work?

On Sun Jul 26, 2026 at 9:57 PM CEST, Hardik Kumar wrote:
> utf8_strwidth() and utf8_strnwidth() return int, even though the
> return value is always non-negative:
>
> - utf8_strnwidth() accumulates the width into a size_t and otherwise
>   returns its size_t len parameter,

nit: change the comma for a dot.

> - utf8_strwidth() just forwards its result.
>
> Change their signatures to return size_t instead.
>
> Update the types of the variables the said method is used to avoid
> potential UB caused by implicit conversion from size_t to int.

This is not correct and it reads a bit off, what about:

  Update the types of the variables where these functions are used, to
  avoid the implicit conversion from size_t to int.

This is not correct because the implicit conversion from size_t to
int is not undefined behavior.

>
> The returned values from `utf8_strwidth()` are casted to int at places
> where it was falling tests or required other changes.

nit: s/casted/cast/
nit: s/falling/failing/

>
> Signed-off-by: Hardik Kumar <hardikxk@gmail.com>
> ---
> Changes in v2:
> - reworked types for utf8_strwidth and its sites of usage.
> - removed redundant parens around `string`.
> - updated commit message for better explaining the patch.
>
>  builtin/blame.c  |  4 ++--
>  builtin/branch.c |  2 +-
>  builtin/repo.c   | 10 +++++-----
>  column.c         |  2 +-
>  diff.c           |  7 ++++---
>  gettext.c        |  2 +-
>  gettext.h        |  2 +-
>  pretty.c         |  5 +++--
>  utf8.c           | 13 ++++---------
>  utf8.h           |  4 ++--
>  wt-status.c      |  8 ++++----
>  11 files changed, 28 insertions(+), 31 deletions(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 48d5251..2d24b63 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -564,7 +564,7 @@ static void emit_other(struct blame_scoreboard *sb, s=
truct blame_entry *ent,
>  					name =3D ci.author_mail.buf;
>  				else
>  					name =3D ci.author.buf;
> -				pad =3D longest_author - utf8_strwidth(name);
> +				pad =3D longest_author - cast_size_t_to_int(utf8_strwidth(name));

This one is fine.

>  				printf(" (%s%*s %10s",
>  				       name, pad, "",
>  				       format_time(ci.author_time,
> @@ -668,7 +668,7 @@ static void find_alignment(struct blame_scoreboard *s=
b, int *option)
>
>  	for (e =3D sb->ent; e; e =3D e->next) {
>  		struct blame_origin *suspect =3D e->suspect;
> -		int num;
> +		size_t num;

Looking at how num is used, it is reused for multiple things:
- strlen()
- utf8_strwidth()
- line-number sums

The longest_* variables we compare num against are still int.

Can we split num into different variables?

>  		size_t marks_count =3D count_marks(e, *option);
>
>  		if (max_marks_count < marks_count)
> diff --git a/builtin/branch.c b/builtin/branch.c
> index dede60d..514ba64 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -354,7 +354,7 @@ static int calc_maxwidth(struct ref_array *refs, int =
remote_bonus)
>  	for (i =3D 0; i < refs->nr; i++) {
>  		struct ref_array_item *it =3D refs->items[i];
>  		const char *desc =3D it->refname;
> -		int w;
> +		size_t w;

w receives utf8_strwidth() but later we have:

  if (w > max)

This is now size_t > int.
Here I would keep w int and cast.

>
>  		skip_prefix(it->refname, "refs/heads/", &desc);
>  		skip_prefix(it->refname, "refs/remotes/", &desc);
> diff --git a/builtin/repo.c b/builtin/repo.c
> index 84e012f..47b9191 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -367,7 +367,7 @@ static void stats_table_vaddf(struct stats_table *tab=
le,
>  	struct strbuf buf =3D STRBUF_INIT;
>  	struct string_list_item *item;
>  	char *formatted_name;
> -	int name_width;
> +	size_t name_width;

Same as above:

  if (name_width > table->name_col_width)

I think that these three fields can be promoted safely

  struct stats_table {
	  [snip]

	  int name_col_width;
	  int value_col_width;
	  int unit_col_width;
  };

but check every use of them afterwards for code that still expects an
int.

>
>  	strbuf_vaddf(&buf, format, ap);
>  	formatted_name =3D strbuf_detach(&buf, NULL);
> @@ -387,12 +387,12 @@ static void stats_table_vaddf(struct stats_table *t=
able,
>  		string_list_append_nodup(&table->annotations, strbuf_detach(&buf, NULL=
));
>  	}
>  	if (entry->value) {
> -		int value_width =3D utf8_strwidth(entry->value);
> +		size_t value_width =3D utf8_strwidth(entry->value);

I feel this one is partially my fault, I wrote these as example output
of the grep I sent last reroll. But they still need to be checked:

>  		if (value_width > table->value_col_width)

We are comparing size_t > int.

>  			table->value_col_width =3D value_width;

We are narrowing size_t to int.

>  	}
>  	if (entry->unit) {
> -		int unit_width =3D utf8_strwidth(entry->unit);
> +		size_t unit_width =3D utf8_strwidth(entry->unit);
>  		if (unit_width > table->unit_col_width)
>  			table->unit_col_width =3D unit_width;
>  	}
> @@ -582,8 +582,8 @@ static void stats_table_print_structure(const struct =
stats_table *table)
>  {
>  	const char *name_col_title =3D _("Repository structure");
>  	const char *value_col_title =3D _("Value");
> -	int title_name_width =3D utf8_strwidth(name_col_title);
> -	int title_value_width =3D utf8_strwidth(value_col_title);
> +	size_t title_name_width =3D utf8_strwidth(name_col_title);
> +	size_t title_value_width =3D utf8_strwidth(value_col_title);

Same problem, these are compared against int *_col_width locals,
and:
  value_col_width =3D title_value_width - unit_col_width

below the context now mixes size_t and int. Promoting the struct fields
as suggested above fixes all of this at once.


>  	int name_col_width =3D table->name_col_width;
>  	int value_col_width =3D table->value_col_width;
>  	int unit_col_width =3D table->unit_col_width;
> diff --git a/column.c b/column.c
> index 93fae31..6b7f921 100644
> --- a/column.c
> +++ b/column.c
> @@ -24,7 +24,7 @@ struct column_data {
>  };
>
>  /* return length of 's' in letters, ANSI escapes stripped */
> -static int item_length(const char *s)
> +static size_t item_length(const char *s)
>  {
>  	return utf8_strnwidth(s, strlen(s), 1);
>  }

item_length() has only one caller, which stores the result into an
int *, so the value gets narrowed right back to int and this change
buys nothing. Keep returning int and cast inside.

> diff --git a/diff.c b/diff.c
> index 589c196..4887958 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2952,7 +2952,8 @@ static int utf8_ish_width(const char **start)
>
>  static void show_stats(struct diffstat_t *data, struct diff_options *opt=
ions)
>  {
> -	int i, len, add, del, adds =3D 0, dels =3D 0;
> +	int i, add, del, adds =3D 0, dels =3D 0;
> +	size_t len;

This will have problems below:

	[snip]

	len =3D name_width;
	name_len =3D utf8_strwidth(name);
	if (name_width < name_len) {
		prefix =3D "...";
		len -=3D 3;
		if (len < 0)
			len =3D 0;
		while (name_len > len && *name)

	[snip]

if (len < 0) will always be false for a size_t, becoming dead code.
Also name_len > len is int > size_t.

Let's step back a bit.
name_len receives utf8_strwidth(), let's make it size_t too, and
compare against len so the types stay consistent. The dead code can
become:

	len =3D len > 3 ? len - 3 : 0;

We would also have to change the check:

	if (name_width < name_len)
to:
	if (len < name_len)

>  	uintmax_t max_change =3D 0, max_len =3D 0;
>  	int total_files =3D data->nr, count;
>  	int width, name_width, graph_width, number_width =3D 0, bin_width =3D 0=
;
> @@ -3037,7 +3038,7 @@ static void show_stats(struct diffstat_t *data, str=
uct diff_options *options)
>  	 * making the line longer than the maximum width.
>  	 */
>  	if (options->stat_width =3D=3D -1)
> -		width =3D term_columns() - utf8_strnwidth(line_prefix, strlen(line_pre=
fix), 1);
> +		width =3D term_columns() - cast_size_t_to_int(utf8_strnwidth(line_pref=
ix, strlen(line_prefix), 1));

This one is fine.

>  	else
>  		width =3D options->stat_width ? options->stat_width : 80;
>  	number_width =3D decimal_width(max_change) > number_width ?
> @@ -3123,7 +3124,7 @@ static void show_stats(struct diffstat_t *data, str=
uct diff_options *options)
>  			if (slash)
>  				name =3D slash;
>  		}
> -		padding =3D len - utf8_strwidth(name);
> +		padding =3D len - cast_size_t_to_int(utf8_strwidth(name));
>  		if (padding < 0)
>  			padding =3D 0;

The cast doesn't work here because len is also size_t. We could do this
to be sure that there will be no problems:

	size_t name_disp =3D utf8_strwidth(name);
	if (name_disp > len)
		padding =3D 0;
	else
		padding =3D cast_size_t_to_int(len - name_disp);

>
> diff --git a/gettext.c b/gettext.c
> index 8d08a61..4d5d05e 100644
> --- a/gettext.c
> +++ b/gettext.c
> @@ -129,7 +129,7 @@ void git_setup_gettext(void)
>  }
>
>  /* return the number of columns of string 's' in current locale */
> -int gettext_width(const char *s)
> +size_t gettext_width(const char *s)
>  {
>  	static int is_utf8 =3D -1;
>  	if (is_utf8 =3D=3D -1)
> diff --git a/gettext.h b/gettext.h
> index 484cafa..f161a21 100644
> --- a/gettext.h
> +++ b/gettext.h
> @@ -31,7 +31,7 @@
>  #ifndef NO_GETTEXT
>  extern int git_gettext_enabled;
>  void git_setup_gettext(void);
> -int gettext_width(const char *s);
> +size_t gettext_width(const char *s);

Careful, this is inside an #ifndef, if we change the signature here,
the other branch must follow.

>  #else
>  #define git_gettext_enabled (0)
>  static inline void git_setup_gettext(void)
> diff --git a/pretty.c b/pretty.c
> index d8a9f37..f7d392d 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1805,11 +1805,12 @@ static size_t format_and_pad_commit(struct strbuf=
 *sb, /* in UTF-8 */
>  {
>  	struct strbuf local_sb =3D STRBUF_INIT;
>  	size_t total_consumed =3D 0;
> -	int len, padding =3D c->padding;
> +	int padding =3D c->padding;
> +	size_t len;
>
>  	if (padding < 0) {
>  		const char *start =3D strrchr(sb->buf, '\n');
> -		int occupied;
> +		size_t occupied;
>  		if (!start)
>  			start =3D sb->buf;
>  		occupied =3D utf8_strnwidth(start, strlen(start), 1);

padding is signed on purpose, so we can't have len as size_t.
Later we have len > padding.
Keep len and occupied as int, casting the utf8_strnwidth() results
instead.

> diff --git a/utf8.c b/utf8.c
> index 96460cc..cefaefe 100644
> --- a/utf8.c
> +++ b/utf8.c
> @@ -208,7 +208,7 @@ int utf8_width(const char **start, size_t *remainder_=
p)
>   * string, assuming that the string is utf8.  Returns strlen() instead
>   * if the string does not look like a valid utf8 string.
>   */
> -int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
> +size_t utf8_strnwidth(const char *string, size_t len, int skip_ansi)
>  {
>  	const char *orig =3D string;
>  	size_t width =3D 0;
> @@ -225,15 +225,10 @@ int utf8_strnwidth(const char *string, size_t len, =
int skip_ansi)
>  		if (glyph_width > 0)
>  			width +=3D glyph_width;
>  	}
> -
> -	/*
> -	 * TODO: fix the interface of this function and `utf8_strwidth()` to
> -	 * return `size_t` instead of `int`.
> -	 */
> -	return cast_size_t_to_int(string ? width : len);
> +	return string ? width : len;
>  }

This is good.

>
> -int utf8_strwidth(const char *string)
> +size_t utf8_strwidth(const char *string)
>  {
>  	return utf8_strnwidth(string, strlen(string), 0);
>  }
> @@ -821,7 +816,7 @@ void strbuf_utf8_align(struct strbuf *buf, align_type=
 position, unsigned int wid
>  		       const char *s)
>  {
>  	size_t slen =3D strlen(s);
> -	int display_len =3D utf8_strnwidth(s, slen, 0);
> +	size_t display_len =3D utf8_strnwidth(s, slen, 0);
>  	int utf8_compensation =3D slen - display_len;

This is fine.

>
>  	if (display_len >=3D width) {
> diff --git a/utf8.h b/utf8.h
> index cf8ecb0..531e968 100644
> --- a/utf8.h
> +++ b/utf8.h
> @@ -7,8 +7,8 @@ typedef unsigned int ucs_char_t;  /* assuming 32bit int *=
/
>
>  size_t display_mode_esc_sequence_len(const char *s);
>  int utf8_width(const char **start, size_t *remainder_p);
> -int utf8_strnwidth(const char *string, size_t len, int skip_ansi);
> -int utf8_strwidth(const char *string);
> +size_t utf8_strnwidth(const char *string, size_t len, int skip_ansi);
> +size_t utf8_strwidth(const char *string);
>  int is_utf8(const char *text);
>  int is_encoding_utf8(const char *name);
>  int same_encoding(const char *, const char *);
> diff --git a/wt-status.c b/wt-status.c
> index 58461e0..0e1e32d 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -331,9 +331,9 @@ static int maxwidth(const char *(*label)(int), int mi=
nval, int maxval)
>
>  	for (i =3D minval; i <=3D maxval; i++) {
>  		const char *s =3D label(i);
> -		int len =3D s ? utf8_strwidth(s) : 0;
> +		size_t len =3D s ? utf8_strwidth(s) : 0;
>  		if (len > result)
> -			result =3D len;
> +			result =3D cast_size_t_to_int(len);
>  	}
>  	return result;
>  }

This function returns non-negative, I would say that the TODO applies to
it as well because it returns 0 or utf8_strwidth(). Cleaning it to return
size_t would help in some steps below:

> @@ -360,7 +360,7 @@ static void wt_longstatus_print_unmerged_data(struct =
wt_status *s,
>  	status_printf(s, color(WT_STATUS_HEADER, s), "\t");
>
>  	how =3D wt_status_unmerged_status_string(d->stagemask);
> -	len =3D label_width - utf8_strwidth(how);
> +	len =3D label_width - cast_size_t_to_int(utf8_strwidth(how));
>  	status_printf_more(s, c, "%s%.*s%s\n", how, len, padding, one);
>  	strbuf_release(&onebuf);
>  }
> @@ -429,7 +429,7 @@ static void wt_longstatus_print_change_data(struct wt=
_status *s,
>  	what =3D wt_status_diff_status_string(status);
>  	if (!what)
>  		BUG("unhandled diff status %c", status);
> -	len =3D label_width - utf8_strwidth(what);
> +	len =3D label_width - cast_size_t_to_int(utf8_strwidth(what));
>  	assert(len >=3D 0);

We can see here that len has to be non-negative. label_width comes from
maxwidth(). With the cleanup I suggested, maxwidth() returns size_t and
so does label_width.

We can have the same safety with:

	size_t what_width =3D utf8_strwidth(what);

	if (what_width > label_width)
		BUG("label wider than column");
	len =3D cast_size_t_to_int(label_width - what_width);

You need the cast at the end anyway because len is used as the
precision in "%.*s".

But I think this way leaves the code cleaner.

>  	if (one_name !=3D two_name)
>  		status_printf_more(s, c, "%s%.*s%s -> %s",

Please know that the hunks of code I suggest might not be the direct
solution, so don't take them directly. I do this because I don't want
to write whole functions and I think that if I just write what's
relevant it will be easier to understand.

Also, part of your work as author is to verify what you add and be able
to defend it, which means taking what others say (including this
review) with a grain of salt, everyone can make mistakes. You can run
the tests on your own to check before sending the next version.

Nice work,
Pablo
