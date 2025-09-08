Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4351BC41
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 05:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757309479; cv=none; b=UcO/Grn3i/ccczmFY5ik1BY8KD0J3zFvYsNQ+UXg9Ui55PNonDAZ3fZ3YPjc0B/KaEC7wZpbPk1W/fG3vEP34PrSWgD1Z9uGnktIDpxQXTExZ+2xqQ4brtdAvGfoF3Xikp0eFafwKO3y6IjSMu4KaA28tOU3wez2JHzcgETbjqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757309479; c=relaxed/simple;
	bh=pLsMfG30nAHNPWNvxpGaPmLzIIb1GPffm5Obp5r0jYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q0CYM0I2OqEpEOhPRyHEWXn/oA4LB7Xnqa6JQx3kWskZySavLoCliWIUws1tFXs59I0Ah1x3dN4pc3fWw6HeY0EPJYH58egkgnY5iedteVAROkPK+3PNu/utSZCVna6ImP19ubIMekXMeOFCdqRntcCFfGX1RirzYFa5CLdQv8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3QhF2xj; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3QhF2xj"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3df2f4aedc7so2215730f8f.2
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 22:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757309475; x=1757914275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUeRTe7zc7jo3a1rPAW2NgLEt816s4pAldLys2lBvtY=;
        b=G3QhF2xjfk4iScp4IXz2ro86PmqoDUqtTP5MP6eid0V9sDke3D5sEwqyhKbXTKF7mG
         Vy/FWYK8SOIwM0rlqQrwXQMSMEX0woLA4JK55yr8D8XVeh5O6Bt2/GKdPv6LH3obOflu
         LLbKmgNIcKjVVW1p5h7/B9JPkUWrXxy+nXk09WjhvIeX+Z23vwcYjiySU+StSX+o9cUr
         5KOzRRx6o3xFFmnPO719JSgnXrh1O9cS8f87ckBZ9hlgu8q9fGw91a0D5cGy0Lp71cNJ
         M7pmXQl12YNz5D84YtdzjjfY/viPLR0U+EUp7GckKnqPQ7G1MJuzK7uwEBgve4JQOO2N
         MLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757309475; x=1757914275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EUeRTe7zc7jo3a1rPAW2NgLEt816s4pAldLys2lBvtY=;
        b=WcTB+kYKk806+tH8gi29CbvG9K38wGFnBBIj08p1/15LZOcLejd6i/j8MMw1uENLku
         J7nlV1FBoyARi/dkJZouxuq7cJaN7uYnc/crHY11CmQd9+w83Fx8V+ipYxK1ckJcHG6q
         4qygMYAJMCnsSw7KqKLN1sBWfVFH9K9NwB2UQ6tOU+o5G5a1+SGo2h9d2106Iwvr3K3U
         JF2ey+VdUJhhuLGogW3cgc/VF1p9yJdvmpBJx4g3ilwu9tXk4umf6JnWLgaLEr6VOfAg
         X1yCtNSKEXI4wZcRpe+8mi5EGqjNFGW8o0yUZaItTC5lqx5WjyTugLUg6s8Zjv7AxNjo
         1mvQ==
X-Gm-Message-State: AOJu0YzY9kOQjAUOHahJVizAR2yUiYV8qyMezFhXDKENmkIF/Wwgw75y
	YyzQ9wyHwwscohEph7pJOrdoJ66wQRqjaI84kIkoC0IHrWthtXn3OOOZikI1jA==
X-Gm-Gg: ASbGnctdOMMG4nIDbH8WooH7oTNMhAe7fiecgrDnN14MMS/F5QBpnPfve9+gL2h+tTU
	uDb0Wpq9Osy0+rucFSiGvU7NOCcmE8kTQIe+SS/wmYE6bPJm+mU6sndEP/pBGxX9d+04J2ZXD3I
	Az1Y2A+mMivqQkcAhnOGWn+5J6mjfX5kSn56GS0aY4ZLeGLjvaASpkj4ADO1poqq6Q7/FMnnLr/
	41hibQZf4BrhPPyocYDjNexKGxLE04tpR8NkWEF+bL7IwCHUQumQzdwLgPqF9Q5TtQCHr2jJ2Vk
	CsRPg/VuRGZvUeGrz/WG/IqisxOMwmSx9WnyiVuvnGSY8bnPj9FGUWjLdOiMtDAenx1aZd9LCPD
	OyrungxoN7wKzwm2cBp2ZmF3nxl2O5OlFbAOyapjFLE2Xm9ZwyqyemBLH+TodBqV6xLBOAabQvU
	1XMibA
X-Google-Smtp-Source: AGHT+IEph8CvfyMuCNhnsu82jgmC0F1QNRdqyRmPVUJ4e8uyQ6u8Vobf9SjRm4a8EXKE5QVZ7fM9kA==
X-Received: by 2002:a05:6000:230c:b0:3d0:64c1:1a40 with SMTP id ffacd0b85a97d-3e64374116cmr4457625f8f.46.1757309475019;
        Sun, 07 Sep 2025 22:31:15 -0700 (PDT)
Received: from christian--20230123--2G7D3 (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf276d5e5fsm40356579f8f.27.2025.09.07.22.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 22:31:14 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Jean-Noel Avila <jn.avila@free.fr>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v8 0/7] Make the "promisor-remote" capability support more fields
Date: Mon,  8 Sep 2025 07:30:46 +0200
Message-ID: <20250908053056.956907-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.0.174.g123d41a7fc
In-Reply-To: <20250731072401.3817074-1-christian.couder@gmail.com>
References: <20250731072401.3817074-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Note that the filter mechanism already exists for a long time and this
series doesn't change how it works. For example, it has already been
possible for a long time to have different repos using the same
promisor remote with different filters. See the existing partial clone
documentation (like "Documentation/technical/partial-clone.adoc") for
more information on partial clone.

The fields that can be passed are limited to "partialCloneFilter" and
"token".

On the technical side, we get rid of 'struct strvec' and we use
'struct promisor_info' to store the data and 'struct string_list' to
store the 'struct promisor_info' instances instead. We also replace
all the calls to strbuf_split*() functions with calls to
string_list_split*() functions.

This work is part of the "LOP" effort documented in:

  Documentation/technical/large-object-promisors.adoc

See that doc for more information on the broader context.

Changes since v7
----------------

Thanks to Patrick, Junio, Karthik, Jean-Noël and Justin for their
comments on the previous versions.

Here are the changes compared to v7:

  - Rebased on top of 6ad8021821 (The fifth batch, 2025-08-29) to
    avoid some conflicts with relatively new topics and to get
    functions that can simplify parts of the patches like
    string_list_split_in_place_f().

  - In all the patches, some calls to git_config_get_string*()
    functions have been replaced with calls to
    repo_config_get_string*() as git_config_get_string*() functions
    have been removed.

  - In patch 2/7 ("promisor-remote: allow a server to advertise more
    fields") a call to string_list_split_in_place() and a following
    call to string_list_remove_empty_items() have been replaced by a
    single call to string_list_split_in_place_f() which is passed both
    the STRING_LIST_SPLIT_TRIM and the STRING_LIST_SPLIT_NONEMPTY
    flags.

  - Patch 3/7 ("promisor-remote: use string constants for 'name' and
    'url' too") was moved earlier in the series. It used to be patch
    5/5 in v7. This is because it now introduces a new
    skip_field_name_prefix() helper function which should start to be
    used early in the series to avoid some churn.

  - In patch 4/7 ("promisor-remote: refactor how we parse advertised
    fields"), the parse_one_advertised_remote() function is improved
    in the following ways:

    - It is passed a `const char *` instead of a `struct strbuf *` as
      argument, because it doesn't really need a `struct strbuf *`.

    - It uses string_list_split() instead of
      string_list_split_in_place() to avoid munging the argument it is
      passed as this argument is used in a warning() in case we didn't
      find both a name and a url in the remote advertisement.

    - The parsing is simplified using the new skip_field_name_prefix()
      function.

  - Patch 5/7 is new. It replaces a call to strbuf_split_str() with a
    call to string_list_split() as we don't really needed the `struct
    strbuf` that strbuf_split_str() created. This is allowed by the
    previous patch which made parse_one_advertised_remote() accept a
    `const char *` instead of a `struct strbuf *`.

  - In patch 6/7 ("promisor-remote: allow a client to check fields")
    the new skip_field_name_prefix() function is used simplify parsing
    a filter and a token in remote advertisements.

  - Patch 7/7 ("promisor-remote: use string_list_split() in
    mark_remotes_as_accepted()") is also new. In the same way as patch
    5/7, a call to strbuf_split_str() is replaced with a call to
    string_list_split() as we don't need the `struct strbuf` that
    strbuf_split_str() created. This removes the last call to a
    strbuf_split*() function in "promisor-remote.c".

CI tests
--------

They have all passed, see:

https://github.com/chriscool/git/actions/runs/17408565173

Range diff compared to v7
-------------------------

1:  87a6ba5c48 ! 1:  c8716bf361 promisor-remote: refactor to get rid of 'struct strvec'
    @@ promisor-remote.c: static int allow_unsanitized(char ch)
     @@ promisor-remote.c: static void promisor_info_vecs(struct repository *repo,
      
      		/* Only add remotes with a non empty URL */
    - 		if (!git_config_get_string_tmp(url_key, &url) && *url) {
    + 		if (!repo_config_get_string_tmp(the_repository, url_key, &url) && *url) {
     -			strvec_push(names, r->name);
     -			strvec_push(urls, url);
     +			struct promisor_info *new_info = xcalloc(1, sizeof(*new_info));
    @@ promisor-remote.c: char *promisor_remote_info(struct repository *repo)
     +	struct string_list config_info = STRING_LIST_INIT_NODUP;
     +	struct string_list_item *item;
      
    - 	git_config_get_bool("promisor.advertise", &advertise_promisors);
    + 	repo_config_get_bool(the_repository, "promisor.advertise", &advertise_promisors);
      
      	if (!advertise_promisors)
      		return NULL;
    @@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
     -	struct strvec urls = STRVEC_INIT;
     +	struct string_list config_info = STRING_LIST_INIT_NODUP;
      
    - 	if (!git_config_get_string_tmp("promisor.acceptfromserver", &accept_str)) {
    + 	if (!repo_config_get_string_tmp(the_repository, "promisor.acceptfromserver", &accept_str)) {
      		if (!*accept_str || !strcasecmp("None", accept_str))
     @@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
      	if (accept == ACCEPT_NONE)
2:  c729c110d0 ! 2:  a07976245a promisor-remote: allow a server to advertise more fields
    @@ promisor-remote.c: static int allow_unsanitized(char ch)
     +{
     +	char *fields = NULL;
     +
    -+	if (!git_config_get_string(config_key, &fields) && *fields) {
    -+		/* Split on any comma or space character */
    -+		string_list_split_in_place(fields_list, fields, ", ", -1);
    -+		/*
    -+		 * Remove empty items that might result from trailing
    -+		 * commas, or from items being separated by both
    -+		 * commas and spaces.
    -+		 */
    -+		string_list_remove_empty_items(fields_list, 0);
    ++	if (!repo_config_get_string(the_repository, config_key, &fields) && *fields) {
    ++		string_list_split_in_place_f(fields_list, fields, ",", -1,
    ++					     STRING_LIST_SPLIT_TRIM |
    ++					     STRING_LIST_SPLIT_NONEMPTY);
     +		filter_string_list(fields_list, 0, is_valid_field, (void *)config_key);
     +	}
     +
    @@ promisor-remote.c: static void promisor_info_list_clear(struct string_list *list
     +	for_each_string_list_item(item, field_names) {
     +		char *key = xstrfmt("remote.%s.%s", p->name, item->string);
     +		const char *val;
    -+		if (!git_config_get_string_tmp(key, &val) && *val)
    ++		if (!repo_config_get_string_tmp(the_repository, key, &val) && *val)
     +			set_one_field(p, item->string, val);
     +		free(key);
     +	}
5:  d0f7fda912 ! 3:  e38f2711f5 promisor-remote: use string constants for 'name' and 'url' too
    @@ Commit message
         Let's do the same for "name" and "url" to avoid repeating them
         several times and for consistency with the other fields.
     
    +    For skipping "name=" or "url=" in advertisements, let's introduce
    +    a skip_field_name_prefix() helper function to keep parsing clean
    +    and easy to understand.
    +
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
      ## promisor-remote.c ##
    @@ promisor-remote.c: char *promisor_remote_info(struct repository *repo)
      		strbuf_addstr_urlencode(&sb, p->url, allow_unsanitized);
      
      		if (p->filter) {
    -@@ promisor-remote.c: static struct promisor_info *parse_one_advertised_remote(struct strbuf *remote_i
    - 		*p = '\0';
    - 		value = url_percent_decode(p + 1);
    +@@ promisor-remote.c: static int should_accept_remote(enum accept_promisor accept,
    + 	return 0;
    + }
    + 
    ++static int skip_field_name_prefix(const char *elem, const char *field_name, const char **value)
    ++{
    ++	const char *p;
    ++	if (!skip_prefix(elem, field_name, &p) || *p != '=')
    ++		return 0;
    ++	*value = p + 1;
    ++	return 1;
    ++}
    ++
    + static void filter_promisor_remote(struct repository *repo,
    + 				   struct strvec *accepted,
    + 				   const char *info)
    +@@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
    + 
    + 		for (size_t j = 0; elems[j]; j++) {
    + 			strbuf_strip_suffix(elems[j], ",");
    +-			if (!skip_prefix(elems[j]->buf, "name=", &remote_name))
    +-				skip_prefix(elems[j]->buf, "url=", &remote_url);
    ++			if (!skip_field_name_prefix(elems[j]->buf, promisor_field_name, &remote_name))
    ++				skip_field_name_prefix(elems[j]->buf, promisor_field_url, &remote_url);
    + 		}
      
    --		if (!strcmp(elem, "name"))
    -+		if (!strcmp(elem, promisor_field_name))
    - 			info->name = value;
    --		else if (!strcmp(elem, "url"))
    -+		else if (!strcmp(elem, promisor_field_url))
    - 			info->url = value;
    - 		else if (!strcmp(elem, promisor_field_filter))
    - 			info->filter = value;
    + 		if (remote_name)
3:  9e0eccae21 ! 4:  4263918802 promisor-remote: refactor how we parse advertised fields
    @@ promisor-remote.c: enum accept_promisor {
      
      	if (accept == ACCEPT_ALL)
      		return 1;
    -@@ promisor-remote.c: static int should_accept_remote(enum accept_promisor accept,
    - 	return 0;
    +@@ promisor-remote.c: static int skip_field_name_prefix(const char *elem, const char *field_name, cons
    + 	return 1;
      }
      
    -+static struct promisor_info *parse_one_advertised_remote(struct strbuf *remote_info)
    ++static struct promisor_info *parse_one_advertised_remote(const char *remote_info)
     +{
     +	struct promisor_info *info = xcalloc(1, sizeof(*info));
    -+	struct string_list elem_list = STRING_LIST_INIT_NODUP;
    ++	struct string_list elem_list = STRING_LIST_INIT_DUP;
     +	struct string_list_item *item;
     +
    -+	string_list_split_in_place(&elem_list, remote_info->buf, ",", -1);
    ++	string_list_split(&elem_list, remote_info, ",", -1);
     +
     +	for_each_string_list_item(item, &elem_list) {
    -+		char *elem = item->string;
    -+		char *value;
    -+		char *p = strchr(elem, '=');
    ++		const char *elem = item->string;
    ++		const char *p = strchr(elem, '=');
     +
     +		if (!p) {
     +			warning(_("invalid element '%s' from remote info"), elem);
     +			continue;
     +		}
     +
    -+		*p = '\0';
    -+		value = url_percent_decode(p + 1);
    -+
    -+		if (!strcmp(elem, "name"))
    -+			info->name = value;
    -+		else if (!strcmp(elem, "url"))
    -+			info->url = value;
    -+		else
    -+			free(value);
    ++		if (skip_field_name_prefix(elem, promisor_field_name, &p))
    ++			info->name = url_percent_decode(p);
    ++		else if (skip_field_name_prefix(elem, promisor_field_url, &p))
    ++			info->url = url_percent_decode(p);
     +	}
     +
     +	string_list_clear(&elem_list, 0);
     +
     +	if (!info->name || !info->url) {
     +		warning(_("server advertised a promisor remote without a name or URL: %s"),
    -+			remote_info->buf);
    ++			remote_info);
     +		promisor_info_free(info);
     +		return NULL;
     +	}
    @@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
      
     -		for (size_t j = 0; elems[j]; j++) {
     -			strbuf_strip_suffix(elems[j], ",");
    --			if (!skip_prefix(elems[j]->buf, "name=", &remote_name))
    --				skip_prefix(elems[j]->buf, "url=", &remote_url);
    +-			if (!skip_field_name_prefix(elems[j]->buf, promisor_field_name, &remote_name))
    +-				skip_field_name_prefix(elems[j]->buf, promisor_field_url, &remote_url);
     -		}
    -+		advertised = parse_one_advertised_remote(remotes[i]);
    ++		advertised = parse_one_advertised_remote(remotes[i]->buf);
      
     -		if (remote_name)
     -			decoded_name = url_percent_decode(remote_name);
-:  ---------- > 5:  c1f55b84f0 promisor-remote: use string_list_split() in filter_promisor_remote()
4:  b1a3384ddc ! 6:  0e37b7149f promisor-remote: allow a client to check fields
    @@ promisor-remote.c: static int should_accept_remote(enum accept_promisor accept,
      
      	warning(_("known remote named '%s' but with URL '%s' instead of '%s'"),
      		remote_name, p->url, remote_url);
    -@@ promisor-remote.c: static struct promisor_info *parse_one_advertised_remote(struct strbuf *remote_i
    - 			info->name = value;
    - 		else if (!strcmp(elem, "url"))
    - 			info->url = value;
    -+		else if (!strcmp(elem, promisor_field_filter))
    -+			info->filter = value;
    -+		else if (!strcmp(elem, promisor_field_token))
    -+			info->token = value;
    - 		else
    - 			free(value);
    +@@ promisor-remote.c: static struct promisor_info *parse_one_advertised_remote(const char *remote_info
    + 			info->name = url_percent_decode(p);
    + 		else if (skip_field_name_prefix(elem, promisor_field_url, &p))
    + 			info->url = url_percent_decode(p);
    ++		else if (skip_field_name_prefix(elem, promisor_field_filter, &p))
    ++			info->filter = url_percent_decode(p);
    ++		else if (skip_field_name_prefix(elem, promisor_field_token, &p))
    ++			info->token = url_percent_decode(p);
      	}
    + 
    + 	string_list_clear(&elem_list, 0);
     @@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
      	if (accept == ACCEPT_NONE)
      		return;
    @@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
     -
      	/* Parse remote info received */
      
    - 	remotes = strbuf_split_str(info, ';', 0);
    + 	string_list_split(&remote_info, info, ";", -1);
     @@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
      		if (!advertised)
      			continue;
-:  ---------- > 7:  123d41a7fc promisor-remote: use string_list_split() in mark_remotes_as_accepted()

Christian Couder (7):
  promisor-remote: refactor to get rid of 'struct strvec'
  promisor-remote: allow a server to advertise more fields
  promisor-remote: use string constants for 'name' and 'url' too
  promisor-remote: refactor how we parse advertised fields
  promisor-remote: use string_list_split() in filter_promisor_remote()
  promisor-remote: allow a client to check fields
  promisor-remote: use string_list_split() in mark_remotes_as_accepted()

 Documentation/config/promisor.adoc    |  61 ++++
 Documentation/gitprotocol-v2.adoc     |  64 +++-
 promisor-remote.c                     | 424 ++++++++++++++++++++------
 t/t5710-promisor-remote-capability.sh |  65 ++++
 4 files changed, 511 insertions(+), 103 deletions(-)

-- 
2.51.0.168.gc8716bf361

