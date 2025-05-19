Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE54280CE7
	for <git@vger.kernel.org>; Mon, 19 May 2025 14:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747664003; cv=none; b=J3x3DUokMEU5mtHwjRyTzitW81XqBDvJdeERjt81WhqxoxPSBsF1Q7hDDQJ3smdWoD8c4dOW85/XBCFn65r/MHTXEbhFa/qmBckcWgg0M4epHptwDtXs8SG9lsldTmU311+1O1L49ZLfhYLTbrSJqEbMiYgmxNX51FYesTB3EPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747664003; c=relaxed/simple;
	bh=HNOjzR6fgyf4iQK8+ZlfE4rqrycsT68A3I/utvN1Tm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GftQmrtKYQoe9ZFiedHTmMb030kmFGcZ6WSsrP9RWxwEHjC5nX/n8wS+17OcPE4QAB3CPIx/w+T9oh/YA9A15nvHz+hg47Mp22K6BOD4DqKrmZ5ubm8LjLm0abpmuIHvxUj91qCQn9LyDVJZUtUfclAhY510DqWivrIVi0ZfE/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsJvHev0; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsJvHev0"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-441d1ed82faso33822485e9.0
        for <git@vger.kernel.org>; Mon, 19 May 2025 07:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747663998; x=1748268798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1R1QmS4LEGx9NZ1LLT6BDVYRSVQKsUgMhUiB8XKOhyI=;
        b=QsJvHev065qF17pdHUVKLth7VTW0xOp1U4fmvVtoS5yUoakrizLfuJYf4BuuFK73RX
         AESKII27hmulbQHb71ZjdpFW+Hn9QnwiQwo/9EItruKIk4anPiIfyo6AU0qOQxb8p3Xk
         3ljXTg7ZJVsbfZHzH/MYM5hUaCHB0bICl+JEyoQvC1YRIxwgXoz6d4bj610A7cuf8uy+
         1rRPoaN80Ym35Ic3khr+aZj/qEz2mvmE41yABHx9sKPX/bsD7Bgy0l9d9/mG9lU9kzc4
         K7s7YMHcTfATl3+ixsVmyjrrBZ7CUHUO3tCuU0rX9rZ//9MwRR6mdv2A7aJrMxDla85e
         IDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747663998; x=1748268798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1R1QmS4LEGx9NZ1LLT6BDVYRSVQKsUgMhUiB8XKOhyI=;
        b=wNL/ozEWTnvA22zZfSPReeqOvPt3GF8YBjZISU+58VBYPcFSz6OkQkZ/ScWtiqNyJR
         R9V8naIgJyfKcKN3zjkoR56cL2EqIfx4Gqx5U3KGdffoNEvf8Zsxp2SQ0GZpzEDQPsXq
         /z/KT9U9fe3DPFnp9N04q2CO/224f42tlke3Um1JTDoVsO3yrNIBCH0ZqdWWOSwJTIUG
         htVHXwSpnu887SkoPKed1pIPOh2kYP+3PTQ2XCiUJ+yX0WQ/EFex4hPJYYpA12rFTGl+
         LeLPuZwBP2NgOPly0d+cCU4/2mlmbLJ3T5oIEPm/KHH8PGUWlIwuk/6PF8+WEBDHR326
         dLTg==
X-Gm-Message-State: AOJu0Yy7DQ8m9zdFdTbcMD0C5HFF7ord4h5sOmA1ytqz4vPIqW89TDia
	DnBw7GZR5fyEhLBPDzFxiLqmwzVq0LmHOIbqcD7Ti+NdyR5qbj9oUkxZc0KSiHiy
X-Gm-Gg: ASbGncsNW5OofvfbS0DTg1YE2JH0PXrQ8lmFM8wySa+CQ9f8IKHnL2uPEkxA3YYshOd
	h+TQRfNMxWS25wKMHwS0eJIPIlxOVkVAj+mffPzGl9bxlo3Wv0EY7v4xX2NsMRsIukqkEXL3iW+
	dk+GkgteX8f3bj75ORDf6cEsa1l2L0XT2XkISPmPb9AN/HAUFkYR8gnce0rmWcla1MKSRwG7X5r
	wH63HVhuN1Crm8foUDwICJzMIfoVo5yF0+wY+xko7rZE2Mo1MLv0rsiRd9P2PHfq5064LPhzL8v
	0wjiuZzM/7bcDmFWh+jfSixv6FCCXMiwPG+IbdV+tmHddZRs8Oi5ZQC0GPMC4sJBcXI5xIOLYaq
	g6N+vT0nPtbdPWYhJl9I9HVpIvYmrXdgYmbd8
X-Google-Smtp-Source: AGHT+IGQKKA+sGHfPMo9pIuLs+en6Kk093i630XpTlzNVOPjfjMvgV5iAHzojD5jN8uJwO9HlCdEww==
X-Received: by 2002:a05:600c:548e:b0:442:dc6f:7a21 with SMTP id 5b1f17b1804b1-442fefd5f18mr121248265e9.3.1747663997273;
        Mon, 19 May 2025 07:13:17 -0700 (PDT)
Received: from christian--20230123--2G7D3.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fa3e2ce5sm160372405e9.13.2025.05.19.07.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 07:13:16 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 0/5] Make the "promisor-remote" capability support more fields
Date: Mon, 19 May 2025 16:12:54 +0200
Message-ID: <20250519141259.3061550-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.49.0.596.g707f6eb7a2.dirty
In-Reply-To: <20250429145243.992252-1-christian.couder@gmail.com>
References: <20250429145243.992252-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "promisor-remote" capability can only be used to pass the names
and URLs of the promisor remotes from the server to the client. After
that the client can use this information to decide if it accepts the
remotes or not.

It would be nice if the server could pass more fields about its
remotes and if the client could use that additional information to
decide about the remotes by comparing it with its local information
about the remotes.

This patch series implements this by adding the "promisor.sendFields"
on the server side and the "promisor.checkFields" on the client side.

For example, if "promisor.sendFields" is set to "partialCloneFilter",
and the server has the remote "foo" configured like this:

[remote "foo"]
        url = file:///tmp/foo.git
	partialCloneFilter = blob:none

then "name=foo,url=file:///tmp/foo.git,partialCloneFilter=blob:none"
will be sent by the server for this remote.

All the information passed through the "promisor-remote" capability is
still only used to decide if the remotes are accepted or not. The
client doesn't store it and doesn't use it for any other purpose.

The fields that can be passed are limited to "partialCloneFilter" and
"token".

On the technical side, we get rid of 'struct strvec' and we use a
'struct promisor_info' linked list and some 'struct string_list'
instead. This matches some suggestions made when the series that
introduced the "promisor-remote" capability was reviewed.

Changes since v2
----------------

Thanks to Patrick, Junio and Karthik for their comments on the
previous versions.

- A big change affecting all the patches is that instead of a linked
  list, the 'struct promisor_info' now contains a `const char *`
  member for each field (name, url, token, ...) that can be passed
  throught the "promisor-remote" capability.

- In patch 1/5, the commit message has been simplified a bit as
  'struct promisor_info' doesn't contain a 'struct string_list fields'
  anymore, and to void repeating information that is already in some
  code comments.

- In patch 1/5, the promisor_info_list() function has been renamed
  promisor_config_info_list() to make it clear that it populates the
  'struct promisor_info' it returns with information from the
  config. For the same purpose, the `info_list` variable used to point
  to the list returned by that function has been renamed
  `config_info`.

- In patch 2/5, there are a few documentation changes:

  - "fld-name" and "fld-value" have been renamed "field-name" and
    "field-value" respectively for clarity,

  - some information about what the "partialCloneFilter" and "token"
    fields should be used for has been provided,

  - it's stated that the "name" and "url" fields MUST appear first in
    each pr-fields, in that order,

  - it's stated that clients MUST ignore fields they don't recognize.

- In patch 2/5, in the code, there are the following changes:

  - string constants are used instead of repeating the
    "partialCloneFilter" and "token" literal strings,

  - `allowed_fields` and `is_allowed_field()` have been renamed
    `known_fields` and `is_known_field()` respectively,

  - `valid_field()` has been renamed `is_valid_field()`

  - `append_fields()` has been replaced by `set_one_field()` and
    `set_fields()`.

- In patch 2/5, the test has been adjusted to account for the fact
  that fields are now processed in a different order due to the
  changes in 'struct promisor_info'.

- Patch 3/5 ("promisor-remote: refactor how we parse advertised
  fields") is a new refactoring patch that prepares for the next
  patch. It refactors into a new parse_one_advertised_remote()
  function how remote information advertised by the server is
  parsed. Instead of parsing it into variables, we now parse it into a
  `struct promisor_info`.

- Patch 4/5 used to be patch 3/3 in v2. In the documentation we now
  cleary state under which condition having fields listed in
  "promisor.checkFields" results in an accepted remote.

- In patch 4/5, in the code, the main change is that the
  `check_field_one()`, `check_field()` and `check_all_fields()`
  functions have been replaced by the `match_field_against_config()`
  and `all_fields_match()` functions.

- In patch 4/5, the test has also been adjusted to account for the
  fact that fields are now processed in a different order due to the
  changes in 'struct promisor_info'.

- Patch 5/5 ("promisor-remote: use string constants for 'name' and
  'url' too") is a new clean up patch. It uses string constants for
  "name" and "url" to match the fact that they are used for
  "partialCloneFilter" and "token" since patch 2/5.

CI tests
--------

Here they are:

https://github.com/chriscool/git/actions/runs/15108739921

They all seem to have passed.

Range diff compared to v2
-------------------------

This range diff doesn't detect that patch 4/5 in v3 was patch 3/3 in
v2 as there were a lot of changes. It might be useful for the first 2
patches (1/5 and 2/5) though.

1:  d4e12afbc1 ! 1:  12e753a358 promisor-remote: refactor to get rid of 'struct strvec'
    @@ Commit message
         scale easily in that case.
     
         Let's refactor this and introduce a new 'struct promisor_info' linked
    -    list that contains a 'struct string_list fields'. This string_list
    -    stores the field names, like "name" and "url", in the 'string' member
    -    of its items, and the field values in the 'util' member of its items.
    +    list which for now only contains a 'next' pointer, a 'name' member for
    +    the promisor remote name and an 'url' member for its URL.
     
    -    Except for "name", each "<field_name>/<field_value>" pair should
    -    correspond to a "remote.<name>.<field_name>" config variable set to
    -    <field_value> where "<name>" is a promisor remote name.
    -
    -    Previously in Git, the part after the last dot in a configuration
    -    variable key, for example "c" for "a.b.c", was called the "variable
    -    name part" of a configuration key. It would be very confusing to use
    -    "variable name part" or some similar terms in the context of the
    -    'promisor-remote' protocol though, so let's forget about it, and just
    -    use "field", "field name" and "field value" instead.
    +    Explicit members are used within 'struct promisor_info' for type
    +    safety and clarity regarding the specific information being handled,
    +    rather than a generic key-value store. We want to specify and document
    +    each field and its content, so adding new members to the struct as
    +    more fields are supported is fine.
     
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
    @@ promisor-remote.c: static int allow_unsanitized(char ch)
     + * Linked list for promisor remotes involved in the "promisor-remote"
     + * protocol capability.
     + *
    -+ * 'fields' contains a defined set of field name/value pairs for
    -+ * each promisor remote. Field names are stored in the 'string'
    -+ * member, and values in the 'util' member.
    -+ *
    -+ * Currently supported field names:
    -+ * - "name": The name of the promisor remote.
    -+ * - "url": The URL of the promisor remote.
    -+ *
    -+ * Except for "name", each "<field_name>/<field_value>" pair should
    -+ * correspond to a "remote.<name>.<field_name>" config variable set to
    -+ * <field_value> where "<name>" is a promisor remote name.
    -+ *
    -+ * 'fields' should not be sorted, as we will rely on the order we put
    -+ * things into it. So, for example, 'string_list_append()' should be
    -+ * used instead of 'string_list_insert()'.
    ++ * Except for "next" and "name", each <member> in this struct and its
    ++ * <value> should correspond to a "remote.<name>.<member>" config
    ++ * variable set to <value> where "<name>" is a promisor remote name.
     + */
     +struct promisor_info {
     +	struct promisor_info *next;
    -+	struct string_list fields;
    ++	const char *name;
    ++	const char *url;
     +};
     +
     +static void promisor_info_list_free(struct promisor_info *p)
    @@ promisor-remote.c: static int allow_unsanitized(char ch)
     +
     +	for (; p; p = next) {
     +		next = p->next;
    -+		string_list_clear(&p->fields, 0);
    ++		free((char *)p->name);
    ++		free((char *)p->url);
     +		free(p);
     +	}
     +}
     +
    -+/*
    -+ * Prepare a 'struct promisor_info' linked list of promisor
    -+ * remotes. For each promisor remote, some of its fields, starting
    -+ * with "name" and "url", are put in the 'fields' string_list.
    -+ */
    -+static struct promisor_info *promisor_info_list(struct repository *repo)
    ++/* Prepare a 'struct promisor_info' linked list with config information. */
    ++static struct promisor_info *promisor_config_info_list(struct repository *repo)
      {
     +	struct promisor_info *infos = NULL;
     +	struct promisor_info **last_info = &infos;
    @@ promisor-remote.c: static void promisor_info_vecs(struct repository *repo,
     -			strvec_push(urls, url);
     +			struct promisor_info *new_info = xcalloc(1, sizeof(*new_info));
     +
    -+			string_list_init_dup(&new_info->fields);
    -+			new_info->fields.cmp = strcasecmp;
    -+
    -+			string_list_append(&new_info->fields, "name")->util = (char *)r->name;
    -+			string_list_append(&new_info->fields, "url")->util = (char *)url;
    ++			new_info->name = xstrdup(r->name);
    ++			new_info->url = xstrdup(url);
     +
     +			*last_info = new_info;
     +			last_info = &new_info->next;
    @@ promisor-remote.c: static void promisor_info_vecs(struct repository *repo,
      	int advertise_promisors = 0;
     -	struct strvec names = STRVEC_INIT;
     -	struct strvec urls = STRVEC_INIT;
    -+	struct promisor_info *info_list;
    -+	struct promisor_info *r;
    ++	struct promisor_info *config_info;
    ++	struct promisor_info *p;
      
      	git_config_get_bool("promisor.advertise", &advertise_promisors);
      
    @@ promisor-remote.c: static void promisor_info_vecs(struct repository *repo,
      		return NULL;
      
     -	promisor_info_vecs(repo, &names, &urls);
    -+	info_list = promisor_info_list(repo);
    ++	config_info = promisor_config_info_list(repo);
      
     -	if (!names.nr)
    -+	if (!info_list)
    ++	if (!config_info)
      		return NULL;
      
     -	for (size_t i = 0; i < names.nr; i++) {
     -		if (i)
    -+	for (r = info_list; r; r = r->next) {
    -+		struct string_list_item *item;
    -+		int first = 1;
    -+
    -+		if (r != info_list)
    ++	for (p = config_info; p; p = p->next) {
    ++		if (p != config_info)
      			strbuf_addch(&sb, ';');
    --		strbuf_addstr(&sb, "name=");
    ++
    + 		strbuf_addstr(&sb, "name=");
     -		strbuf_addstr_urlencode(&sb, names.v[i], allow_unsanitized);
    --		strbuf_addstr(&sb, ",url=");
    ++		strbuf_addstr_urlencode(&sb, p->name, allow_unsanitized);
    + 		strbuf_addstr(&sb, ",url=");
     -		strbuf_addstr_urlencode(&sb, urls.v[i], allow_unsanitized);
    -+
    -+		for_each_string_list_item(item, &r->fields) {
    -+			if (first)
    -+				first = 0;
    -+			else
    -+				strbuf_addch(&sb, ',');
    -+			strbuf_addf(&sb, "%s=", item->string);
    -+			strbuf_addstr_urlencode(&sb, (char *)item->util, allow_unsanitized);
    -+		}
    ++		strbuf_addstr_urlencode(&sb, p->url, allow_unsanitized);
      	}
      
     -	strvec_clear(&names);
     -	strvec_clear(&urls);
    -+	promisor_info_list_free(info_list);
    ++	promisor_info_list_free(config_info);
      
      	return strbuf_detach(&sb, NULL);
      }
    @@ promisor-remote.c: static void promisor_info_vecs(struct repository *repo,
     - * Find first index of 'nicks' where there is 'nick'. 'nick' is
     - * compared case sensitively to the strings in 'nicks'. If not found
     - * 'nicks->nr' is returned.
    -+ * Find first element of 'p' where the 'name' field is 'nick'. 'nick'
    ++ * Find first element of 'p' where the 'name' member is 'nick'. 'nick'
     + * is compared case sensitively to the strings in 'p'. If not found
     + * NULL is returned.
       */
    @@ promisor-remote.c: static void promisor_info_vecs(struct repository *repo,
     -			return i;
     -	return nicks->nr;
     +	for (; p; p = p->next) {
    -+		if (strcmp(p->fields.items[0].string, "name"))
    -+			BUG("First field of promisor info should be 'name', but was '%s'.",
    -+			    p->fields.items[0].string);
    -+		if (!strcmp(p->fields.items[0].util, nick))
    ++		if (!strcmp(p->name, nick))
     +			return p;
     +	}
     +	return NULL;
    @@ promisor-remote.c: enum accept_promisor {
      static int should_accept_remote(enum accept_promisor accept,
      				const char *remote_name, const char *remote_url,
     -				struct strvec *names, struct strvec *urls)
    -+				struct promisor_info *info_list)
    ++				struct promisor_info *config_info)
      {
     -	size_t i;
     +	struct promisor_info *p;
    -+	const char *local_url;
      
      	if (accept == ACCEPT_ALL)
      		return 1;
      
     -	i = remote_nick_find(names, remote_name);
    -+	p = remote_nick_find(info_list, remote_name);
    ++	p = remote_nick_find(config_info, remote_name);
      
     -	if (i >= names->nr)
     +	if (!p)
    @@ promisor-remote.c: static int should_accept_remote(enum accept_promisor accept,
      	}
      
     -	if (!strcmp(urls->v[i], remote_url))
    -+	if (strcmp(p->fields.items[1].string, "url"))
    -+		BUG("Bad info_list for remote '%s'.\n"
    -+		    "Second field of promisor info should be 'url', but was '%s'.",
    -+		    remote_name, p->fields.items[1].string);
    -+
    -+	local_url = p->fields.items[1].util;
    ++	if (!p->url)
    ++		BUG("Bad config_info (invalid URL) for remote '%s'.\n",
    ++		    remote_name);
     +
    -+	if (!strcmp(local_url, remote_url))
    ++	if (!strcmp(p->url, remote_url))
      		return 1;
      
      	warning(_("known remote named '%s' but with URL '%s' instead of '%s'"),
     -		remote_name, urls->v[i], remote_url);
    -+		remote_name, local_url, remote_url);
    ++		remote_name, p->url, remote_url);
      
      	return 0;
      }
    @@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
      	enum accept_promisor accept = ACCEPT_NONE;
     -	struct strvec names = STRVEC_INIT;
     -	struct strvec urls = STRVEC_INIT;
    -+	struct promisor_info *info_list = NULL;
    ++	struct promisor_info *config_info = NULL;
      
      	if (!git_config_get_string_tmp("promisor.acceptfromserver", &accept_str)) {
      		if (!*accept_str || !strcasecmp("None", accept_str))
    @@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
      
      	if (accept != ACCEPT_ALL)
     -		promisor_info_vecs(repo, &names, &urls);
    -+		info_list = promisor_info_list(repo);
    ++		config_info = promisor_config_info_list(repo);
      
      	/* Parse remote info received */
      
    @@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
      			decoded_url = url_percent_decode(remote_url);
      
     -		if (decoded_name && should_accept_remote(accept, decoded_name, decoded_url, &names, &urls))
    -+		if (decoded_name && should_accept_remote(accept, decoded_name, decoded_url, info_list))
    ++		if (decoded_name && should_accept_remote(accept, decoded_name, decoded_url, config_info))
      			strvec_push(accepted, decoded_name);
      
      		strbuf_list_free(elems);
    @@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
      
     -	strvec_clear(&names);
     -	strvec_clear(&urls);
    -+	promisor_info_list_free(info_list);
    ++	promisor_info_list_free(config_info);
      	strbuf_list_free(remotes);
      }
      
2:  d6d4f99768 ! 2:  29c6104827 promisor-remote: allow a server to advertise more fields
    @@ Commit message
         that will be passed to the client.
     
         Only a set of predefined fields are allowed. The only fields in this
    -    set are "partialCloneFilter" and "token".
    +    set are "partialCloneFilter" and "token". The "partialCloneFilter"
    +    field specifies the filter definition used by the promisor remote,
    +    and the "token" field can provide an authentication credential for
    +    accessing it.
     
         For example if "promisor.sendFields" is set to "partialCloneFilter",
         and the server has the "remote.<name>.partialCloneFilter" config
    @@ Documentation/gitprotocol-v2.adoc: retrieving the header from a bundle at the in
     +	pr-info = pr-fields | pr-info ";" pr-info
      
     -	pr-info = "name=" pr-name | "name=" pr-name "," "url=" pr-url
    -+	pr-fields = fld-name "=" fld-value | pr-fields "," pr-fields
    ++	pr-fields = field-name "=" field-value | pr-fields "," pr-fields
      
     -where `pr-name` is the urlencoded name of a promisor remote, and
     -`pr-url` the urlencoded URL of that promisor remote.
    -+where all the `fld-name` and `fld-value` in a given `pr-fields` are
    -+field names and values related to a single promisor remote.
    ++where all the `field-name` and `field-value` in a given `pr-fields`
    ++are field names and values related to a single promisor remote.
      
     -In this case, if the client decides to use one or more promisor
     -remotes the server advertised, it can reply with
     -"promisor-remote=<pr-names>" where <pr-names> should be of the form:
     +The server MUST advertise at least the "name" and "url" field names
     +along with the associated field values, which are the name of a valid
    -+remote and its URL, in each `pr-fields`.
    ++remote and its URL, in each `pr-fields`. The "name" and "url" fields
    ++MUST appear first in each pr-fields, in that order.
      
     -	pr-names = pr-name | pr-names ";" pr-name
    -+The server MAY advertise the following optional fields:
    ++After these mandatory fields, the server MAY advertise the following
    ++optional fields in any order:
     +
    -+- "partialCloneFilter": Filter used for partial clone, corresponding
    -+  to the "remote.<name>.partialCloneFilter" config setting.
    -+- "token": Authentication token for the remote, corresponding
    -+  to the "remote.<name>.token" config setting.
    ++- "partialCloneFilter": The filter specification used by the remote.
    ++Clients can use this to determine if the remote's filtering strategy
    ++is compatible with their needs (e.g., checking if both use "blob:none").
    ++It corresponds to the "remote.<name>.partialCloneFilter" config setting.
     +
    -+No other fields are defined by the protocol at this time. Clients SHOULD
    -+ignore fields they don't recognize to allow for future protocol extensions.
    ++- "token": An authentication token that clients can use when
    ++connecting to the remote. It corresponds to the "remote.<name>.token"
    ++config setting.
    ++
    ++No other fields are defined by the protocol at this time. Clients MUST
    ++ignore fields they don't recognize to allow for future protocol
    ++extensions.
     +
     +For now, the client can only use information transmitted through these
     +fields to decide if it accepts the advertised promisor remote. In the
    @@ Documentation/gitprotocol-v2.adoc: retrieving the header from a bundle at the in
     -remote name, and the ';' and ',' characters MUST be encoded if they
     -appear in `pr-name` or `pr-url`.
     +Note that, everywhere in this document, the ';' and ',' characters
    -+MUST be encoded if they appear in `pr-name` or `fld-value`.
    ++MUST be encoded if they appear in `pr-name` or `field-value`.
      
      If the server doesn't know any promisor remote that could be good for
      a client to use, or prefers a client not to use any promisor remote it
    @@ promisor-remote.c: static int allow_unsanitized(char ch)
      	return ch > 32 && ch < 127;
      }
      
    ++static const char promisor_field_filter[] = "partialCloneFilter";
    ++static const char promisor_field_token[] = "token";
    ++
     +/*
    -+ * List of field names allowed to be used in the "promisor-remote"
    -+ * protocol capability. Each field should correspond to a configurable
    -+ * property of a remote that can be relevant for the client.
    ++ * List of optional field names that can be used in the
    ++ * "promisor-remote" protocol capability (others must be
    ++ * ignored). Each field should correspond to a configurable property
    ++ * of a remote that can be relevant for the client.
     + */
    -+static const char *allowed_fields[] = {
    -+	"partialCloneFilter", /* Filter used for partial clone */
    -+	"token",              /* Authentication token for the remote */
    ++static const char *known_fields[] = {
    ++	promisor_field_filter, /* Filter used for partial clone */
    ++	promisor_field_token,  /* Authentication token for the remote */
     +	NULL
     +};
     +
     +/*
    -+ * Check if 'field' is in the list of allowed field names for the
    ++ * Check if 'field' is in the list of the known field names for the
     + * "promisor-remote" protocol capability.
     + */
    -+static int is_allowed_field(const char *field)
    ++static int is_known_field(const char *field)
     +{
     +	const char **p;
     +
    -+	for (p = allowed_fields; *p; p++)
    ++	for (p = known_fields; *p; p++)
     +		if (!strcasecmp(*p, field))
     +			return 1;
     +	return 0;
     +}
     +
    -+static int valid_field(struct string_list_item *item, void *cb_data)
    ++static int is_valid_field(struct string_list_item *item, void *cb_data)
     +{
     +	const char *field = item->string;
     +	const char *config_key = (const char *)cb_data;
     +
    -+	if (!is_allowed_field(field)) {
    ++	if (!is_known_field(field)) {
     +		warning(_("unsupported field '%s' in '%s' config"), field, config_key);
     +		return 0;
     +	}
    @@ promisor-remote.c: static int allow_unsanitized(char ch)
     +
     +	if (!git_config_get_string(config_key, &fields) && *fields) {
     +		string_list_split_in_place(fields_list, fields, ", ", -1);
    -+		filter_string_list(fields_list, 0, valid_field, (void *)config_key);
    ++		filter_string_list(fields_list, 0, is_valid_field, (void *)config_key);
     +	}
     +
     +	return fields;
    @@ promisor-remote.c: static int allow_unsanitized(char ch)
     +	return &fields_list;
     +}
     +
    -+static void append_fields(struct string_list *fields,
    -+			  struct string_list *field_names,
    -+			  const char *name)
    + /*
    +  * Linked list for promisor remotes involved in the "promisor-remote"
    +  * protocol capability.
    +@@ promisor-remote.c: struct promisor_info {
    + 	struct promisor_info *next;
    + 	const char *name;
    + 	const char *url;
    ++	const char *filter;
    ++	const char *token;
    + };
    + 
    + static void promisor_info_list_free(struct promisor_info *p)
    +@@ promisor-remote.c: static void promisor_info_list_free(struct promisor_info *p)
    + 		next = p->next;
    + 		free((char *)p->name);
    + 		free((char *)p->url);
    ++		free((char *)p->filter);
    ++		free((char *)p->token);
    + 		free(p);
    + 	}
    + }
    + 
    +-/* Prepare a 'struct promisor_info' linked list with config information. */
    +-static struct promisor_info *promisor_config_info_list(struct repository *repo)
    ++static void set_one_field(struct promisor_info *p,
    ++			  const char *field, const char *value)
    ++{
    ++	if (!strcasecmp(field, promisor_field_filter))
    ++		p->filter = xstrdup(value);
    ++	else if (!strcasecmp(field, promisor_field_token))
    ++		p->token = xstrdup(value);
    ++	else
    ++		BUG("Invalid field '%s'", field);
    ++}
    ++
    ++static void set_fields(struct promisor_info *p,
    ++		       struct string_list *field_names)
     +{
     +	struct string_list_item *item;
     +
     +	for_each_string_list_item(item, field_names) {
    -+		char *key = xstrfmt("remote.%s.%s", name, item->string);
    ++		char *key = xstrfmt("remote.%s.%s", p->name, item->string);
     +		const char *val;
     +		if (!git_config_get_string_tmp(key, &val) && *val)
    -+			string_list_append(fields, item->string)->util = (char *)val;
    ++			set_one_field(p, item->string, val);
     +		free(key);
     +	}
     +}
     +
    - /*
    -  * Linked list for promisor remotes involved in the "promisor-remote"
    -  * protocol capability.
    -@@ promisor-remote.c: static int allow_unsanitized(char ch)
    -  * member, and values in the 'util' member.
    -  *
    -  * Currently supported field names:
    -- * - "name": The name of the promisor remote.
    -- * - "url": The URL of the promisor remote.
    -+ * - "name": The name of the promisor remote,
    -+ * - "url": The URL of the promisor remote,
    -+ * - the fields in 'allowed_fields[]' above.
    -  *
    -  * Except for "name", each "<field_name>/<field_value>" pair should
    -  * correspond to a "remote.<name>.<field_name>" config variable set to
    -@@ promisor-remote.c: static void promisor_info_list_free(struct promisor_info *p)
    -  * remotes. For each promisor remote, some of its fields, starting
    -  * with "name" and "url", are put in the 'fields' string_list.
    -  */
    --static struct promisor_info *promisor_info_list(struct repository *repo)
    -+static struct promisor_info *promisor_info_list(struct repository *repo,
    -+						struct string_list *field_names)
    ++/*
    ++ * Prepare a 'struct promisor_info' linked list of promisor remotes
    ++ * with config information. Only members of that struct specified by
    ++ * the 'field_names' linked list are set (using values from the
    ++ * configuration).
    ++ */
    ++static struct promisor_info *promisor_config_info_list(struct repository *repo,
    ++						       struct string_list *field_names)
      {
      	struct promisor_info *infos = NULL;
      	struct promisor_info **last_info = &infos;
    -@@ promisor-remote.c: static struct promisor_info *promisor_info_list(struct repository *repo)
    - 			string_list_append(&new_info->fields, "name")->util = (char *)r->name;
    - 			string_list_append(&new_info->fields, "url")->util = (char *)url;
    +@@ promisor-remote.c: static struct promisor_info *promisor_config_info_list(struct repository *repo)
    + 			new_info->name = xstrdup(r->name);
    + 			new_info->url = xstrdup(url);
      
     +			if (field_names)
    -+				append_fields(&new_info->fields, field_names, r->name);
    ++				set_fields(new_info, field_names);
     +
      			*last_info = new_info;
      			last_info = &new_info->next;
    @@ promisor-remote.c: char *promisor_remote_info(struct repository *repo)
      	if (!advertise_promisors)
      		return NULL;
      
    --	info_list = promisor_info_list(repo);
    -+	info_list = promisor_info_list(repo, fields_sent());
    +-	config_info = promisor_config_info_list(repo);
    ++	config_info = promisor_config_info_list(repo, fields_sent());
      
    - 	if (!info_list)
    + 	if (!config_info)
      		return NULL;
    +@@ promisor-remote.c: char *promisor_remote_info(struct repository *repo)
    + 		strbuf_addstr_urlencode(&sb, p->name, allow_unsanitized);
    + 		strbuf_addstr(&sb, ",url=");
    + 		strbuf_addstr_urlencode(&sb, p->url, allow_unsanitized);
    ++
    ++		if (p->filter) {
    ++			strbuf_addf(&sb, ",%s=", promisor_field_filter);
    ++			strbuf_addstr_urlencode(&sb, p->filter, allow_unsanitized);
    ++		}
    ++		if (p->token) {
    ++			strbuf_addf(&sb, ",%s=", promisor_field_token);
    ++			strbuf_addstr_urlencode(&sb, p->token, allow_unsanitized);
    ++		}
    + 	}
    + 
    + 	promisor_info_list_free(config_info);
     @@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
      		return;
      
      	if (accept != ACCEPT_ALL)
    --		info_list = promisor_info_list(repo);
    -+		info_list = promisor_info_list(repo, NULL);
    +-		config_info = promisor_config_info_list(repo);
    ++		config_info = promisor_config_info_list(repo, NULL);
      
      	/* Parse remote info received */
      
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with 'KnownUrl
     +	git -C server config remote.otherLop.stuff "baz" &&
     +	git -C server config remote.otherLop.partialCloneFilter "blob:limit=10k" &&
     +	test_when_finished "git -C server remote remove otherLop" &&
    -+	git -C server config promisor.sendFields "token, partialCloneFilter" &&
    ++	git -C server config promisor.sendFields "partialCloneFilter, token" &&
     +	test_when_finished "git -C server config unset promisor.sendFields" &&
     +	test_when_finished "rm trace" &&
     +
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with 'KnownUrl
     +	# Check that fields are properly transmitted
     +	ENCODED_URL=$(echo "file://$(pwd)/lop" | sed -e "s/ /%20/g") &&
     +	PR1="name=lop,url=$ENCODED_URL,partialCloneFilter=blob:none" &&
    -+	PR2="name=otherLop,url=https://invalid.invalid,token=fooBar,partialCloneFilter=blob:limit=10k" &&
    ++	PR2="name=otherLop,url=https://invalid.invalid,partialCloneFilter=blob:limit=10k,token=fooBar" &&
     +	test_grep "clone< promisor-remote=$PR1;$PR2" trace &&
     +	test_grep "clone> promisor-remote=lop;otherLop" trace &&
     +
3:  09af0369a6 < -:  ---------- promisor-remote: allow a client to check fields
-:  ---------- > 3:  6d8236bf70 promisor-remote: refactor how we parse advertised fields
-:  ---------- > 4:  dab5823356 promisor-remote: allow a client to check fields
-:  ---------- > 5:  9bd612cdb8 promisor-remote: use string constants for 'name' and 'url' too


Christian Couder (5):
  promisor-remote: refactor to get rid of 'struct strvec'
  promisor-remote: allow a server to advertise more fields
  promisor-remote: refactor how we parse advertised fields
  promisor-remote: allow a client to check fields
  promisor-remote: use string constants for 'name' and 'url' too

 Documentation/config/promisor.adoc    |  53 ++++
 Documentation/gitprotocol-v2.adoc     |  59 ++--
 promisor-remote.c                     | 383 +++++++++++++++++++++-----
 t/t5710-promisor-remote-capability.sh |  67 +++++
 4 files changed, 479 insertions(+), 83 deletions(-)

-- 
2.49.0.596.g707f6eb7a2.dirty

