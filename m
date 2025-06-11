Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4B1D299
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 13:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749649528; cv=none; b=Bw/R16l5ecmuXCOJkyLKybDHuSsjRiDxjA2vKAHvCx7GMaBaigHWLbXTNciTkeTSueKj+5RQiQFVIh08JAUqMcbizRwSVDptsO5fiyQ6J08NTENCkRoOipaEwCADD3K7aaW0lnqFMdeFa4pVQovMNBlSZo0etFpOHrA0MZZvzGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749649528; c=relaxed/simple;
	bh=pbHS8+6wiFujA2Z5TjiUZLVc4/ifrG4G9gzykAuBU9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fP0SMxASLbfmreuyEyLwZYFoGTmvThAp12PI3kvPhPuW9rHTCKkZDmQtgsuN62xiKP95kqzW2If44hCQj2uUtlyzrkcqL/7p8Bb+DXj+p8smmJNPOBg95BbbML1LOw+v9a3s/C+43NJdCY3zkfpCZt0yPPTwFne8EsXCVARrqOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhGTEcsX; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhGTEcsX"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a525eee2e3so5071435f8f.2
        for <git@vger.kernel.org>; Wed, 11 Jun 2025 06:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749649523; x=1750254323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GeT3/tr1csSbX5JUMFtVUhm2F3KL+24uCTsmWTqcHWA=;
        b=AhGTEcsXHGZTfZQBKZC8SGyrRQClSmuUhJxL4yoq+RrZwey67ZYlYf3J7WlYD+EeZ7
         3Xtj/aq0Wf9RAr+cXJ9F0WkLQSlX2NDYRcOeOczdU4Jc1D29NSZRStB5+kTPRXUM5h+b
         d/0+Xc4ILkfcVTJ53uusUF/NL0PeOXqlcpnNdVGdVw8ej2wfKRLlMYScYTd8FZQfHQ8g
         YK742kR6CXRVad/HxOVq/MxIt3aJrRB8Wdp6YhRF0d1i69gvnF9BVaV9HTmBtBOMVDDa
         2ipVMHDLvWLM6JKQS2hsqjCEJAj7zBmlucmmvpPZKNc1623kwXMVE5yQ8DmH5eVEbfWg
         gAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749649523; x=1750254323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GeT3/tr1csSbX5JUMFtVUhm2F3KL+24uCTsmWTqcHWA=;
        b=n1vQmkDAH1cn6bRr9oD4Ltnv+I6dIb4aGD5ijo5Uaie5wcgU/n/shUPfppyBsyyBMn
         Iv8CKupCYAphyQ2AkCMa3PCh5x3Xjd8UU/7kS8z+DqGOaTFtBUnFFrseN726D5x1ufeG
         8Ou7/fGBToKSpAnx63JXLdrTtxHdwSNUvUPxuAEpDX6//vmcTLL5NdL66AaLDMs+EMvN
         Lq9Mm48jqhuiECXKtEQzGtYK+Pj9aOr1fOTJ7hbmCU+c4X1KJH0CcohbNYtrUSU3Jpxz
         fyhzciHduTjP6cdXhsU+NM8sa6TGfkDxvSQw/cDivWNSliGIsJVwXPZ7UQKJXbXZPd3z
         1Mbg==
X-Gm-Message-State: AOJu0YzFRCylW21XTvktSEnHYcHAisK0utASeK3F8iZ3tLw+fKtoa/EM
	sjawbOXFtOv22C00OeArlWD4TzBYjOzu8smCXk1RAtx7HUza8VdNhHsB4LkURA==
X-Gm-Gg: ASbGncsis1lflMB87nvs/U9B2oKk6VxG0Z2FRoxncrho7P3fqGhl5Opo/grAbQwenfE
	CI8fOU+A7I2qMnPqp426frCFYGhlKBrE94iY/81NQK/apPcK0YVDHuqNIi6lIxwmT2zd+TWVbiL
	OH3pFZksYCRSM4KoAHVKOP5BRNM3LVebQfwxnH3fLuXLQwzqiB2NhbQ0gAk3/hWBGq4uoxWpoSp
	hx/jaFP8xfUx1J/yWH+QBVn4cxjqWsE3jB+YOZL3VmYZkUTs+sgUYXzQbUl4NBOcH64XT85eyDa
	iS2wAHEmisuq+rYRH+anWJViZ0cboEvk48rbAZqla6JPSciKMrxJgVkihmCbFFJ0qc8HUfgGJ92
	HqkbPI+w1+QawWvbOgNbz3NPW9V/d8HtHbPUZrt2zrGCn
X-Google-Smtp-Source: AGHT+IEpLxhzvRj7oaQtOtNS02BUeursdFMmb0ZrikVnIq8DpDmcMD37Haz+R9L+ol+vj25wOUsZdw==
X-Received: by 2002:a05:6000:188d:b0:3a5:1c71:432a with SMTP id ffacd0b85a97d-3a558a9b9d0mr3048470f8f.14.1749649522892;
        Wed, 11 Jun 2025 06:45:22 -0700 (PDT)
Received: from christian--20230123--2G7D3 (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453252450d4sm21513205e9.9.2025.06.11.06.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 06:45:22 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 0/5] Make the "promisor-remote" capability support more fields
Date: Wed, 11 Jun 2025 15:45:01 +0200
Message-ID: <20250611134506.2975856-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.50.0.rc2.5.ge8efe62b7f
In-Reply-To: <20250519141259.3061550-1-christian.couder@gmail.com>
References: <20250519141259.3061550-1-christian.couder@gmail.com>
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
store the 'struct promisor_info' instances instead. This matches the
latest suggestion from Junio.

This work is part of the "LOP" effort documented in:

  Documentation/technical/large-object-promisors.adoc

See that doc for more information on the broader context.

Changes since v3
----------------

Thanks to Patrick, Junio, Karthik and Justin for their comments on the
previous versions.

- A big change affecting all the patches is that 'struct string_list'
  is used to store the 'struct promisor_info' instances which don't
  contain a 'next' pointer anymore. The items in 'struct string_list'
  have their 'string' pointer point to the remote name and their
  'util' pointer point to a 'struct promisor_info' instance. The
  'struct string_list' is sorted when useful.

- Another global change is that "field name" is used instead of
  "fields" where it makes sense.

- In patch 1/5, the error message in a BUG() has been improved a bit.

- In patch 2/5, bullet points are used to improve the doc of the new
  "promisor.sendFields" config variable.

- In patch 2/5, a call to string_list_remove_empty_items() has been
  added to avoid issues with empty fields.

- In patch 2/5, test_config is used instead of removing some config
  with `test_when_finished`.

- In patch 4/5, test_config is also used instead of removing some
  config with `test_when_finished`.

CI tests
--------

Here they are:

https://github.com/chriscool/git/actions/runs/15585655648

They have all passed.

Range diff compared to v3
-------------------------

1:  12e753a358 ! 1:  8a4df71d2c promisor-remote: refactor to get rid of 'struct strvec'
    @@ Commit message
         with one 'struct strvec' for each field like "name" or "url" does not
         scale easily in that case.
     
    -    Let's refactor this and introduce a new 'struct promisor_info' linked
    -    list which for now only contains a 'next' pointer, a 'name' member for
    -    the promisor remote name and an 'url' member for its URL.
    +    Let's refactor this and introduce a new 'struct promisor_info'.
    +
    +    It will only store promisor remote information in its members. For now
    +    it has only a 'name' member for the promisor remote name and an 'url'
    +    member for its URL. We will use use a 'struct string_list' to store
    +    the instances of 'struct promisor_info'. For each 'item' in the
    +    string_list, 'item->string' will point to the promisor remote name and
    +    'item->util' will point to the corresponding 'struct promisor_info'
    +    instance.
     
         Explicit members are used within 'struct promisor_info' for type
         safety and clarity regarding the specific information being handled,
    @@ promisor-remote.c: static int allow_unsanitized(char ch)
     -			       struct strvec *names,
     -			       struct strvec *urls)
     +/*
    -+ * Linked list for promisor remotes involved in the "promisor-remote"
    ++ * Struct for promisor remotes involved in the "promisor-remote"
     + * protocol capability.
     + *
    -+ * Except for "next" and "name", each <member> in this struct and its
    -+ * <value> should correspond to a "remote.<name>.<member>" config
    -+ * variable set to <value> where "<name>" is a promisor remote name.
    ++ * Except for "name", each <member> in this struct and its <value>
    ++ * should correspond (either on the client side or on the server side)
    ++ * to a "remote.<name>.<member>" config variable set to <value> where
    ++ * "<name>" is a promisor remote name.
     + */
     +struct promisor_info {
    -+	struct promisor_info *next;
     +	const char *name;
     +	const char *url;
     +};
     +
    -+static void promisor_info_list_free(struct promisor_info *p)
    ++static void promisor_info_list_clear(struct string_list *list)
     +{
    -+	struct promisor_info *next;
    -+
    -+	for (; p; p = next) {
    -+		next = p->next;
    ++	for (size_t i = 0; i < list->nr; i++) {
    ++		struct promisor_info *p = list->items[i].util;
     +		free((char *)p->name);
     +		free((char *)p->url);
    -+		free(p);
     +	}
    ++	string_list_clear(list, 1);
     +}
     +
    -+/* Prepare a 'struct promisor_info' linked list with config information. */
    -+static struct promisor_info *promisor_config_info_list(struct repository *repo)
    ++/*
    ++ * Populate 'list' with promisor remote information from the config.
    ++ * The 'util' pointer of each list item will hold a 'struct promisor_info'.
    ++ */
    ++static void promisor_config_info_list(struct repository *repo, struct string_list *list)
      {
    -+	struct promisor_info *infos = NULL;
    -+	struct promisor_info **last_info = &infos;
      	struct promisor_remote *r;
      
    - 	promisor_remote_init(repo);
     @@ promisor-remote.c: static void promisor_info_vecs(struct repository *repo,
      
      		/* Only add remotes with a non empty URL */
    @@ promisor-remote.c: static void promisor_info_vecs(struct repository *repo,
     -			strvec_push(names, r->name);
     -			strvec_push(urls, url);
     +			struct promisor_info *new_info = xcalloc(1, sizeof(*new_info));
    ++			struct string_list_item *item;
     +
     +			new_info->name = xstrdup(r->name);
     +			new_info->url = xstrdup(url);
     +
    -+			*last_info = new_info;
    -+			last_info = &new_info->next;
    ++			item = string_list_append(list, new_info->name);
    ++			item->util = new_info;
      		}
      
      		free(url_key);
    - 	}
    -+
    -+	return infos;
    - }
    - 
    - char *promisor_remote_info(struct repository *repo)
    +@@ promisor-remote.c: char *promisor_remote_info(struct repository *repo)
      {
      	struct strbuf sb = STRBUF_INIT;
      	int advertise_promisors = 0;
     -	struct strvec names = STRVEC_INIT;
     -	struct strvec urls = STRVEC_INIT;
    -+	struct promisor_info *config_info;
    -+	struct promisor_info *p;
    ++	struct string_list config_info = STRING_LIST_INIT_NODUP;
    ++	struct string_list_item *item;
      
      	git_config_get_bool("promisor.advertise", &advertise_promisors);
      
    @@ promisor-remote.c: static void promisor_info_vecs(struct repository *repo,
      		return NULL;
      
     -	promisor_info_vecs(repo, &names, &urls);
    -+	config_info = promisor_config_info_list(repo);
    ++	promisor_config_info_list(repo, &config_info);
      
     -	if (!names.nr)
    -+	if (!config_info)
    ++	if (!config_info.nr)
      		return NULL;
      
     -	for (size_t i = 0; i < names.nr; i++) {
     -		if (i)
    -+	for (p = config_info; p; p = p->next) {
    -+		if (p != config_info)
    ++	for_each_string_list_item(item, &config_info) {
    ++		struct promisor_info *p = item->util;
    ++
    ++		if (item != config_info.items)
      			strbuf_addch(&sb, ';');
     +
      		strbuf_addstr(&sb, "name=");
    @@ promisor-remote.c: static void promisor_info_vecs(struct repository *repo,
      
     -	strvec_clear(&names);
     -	strvec_clear(&urls);
    -+	promisor_info_list_free(config_info);
    ++	promisor_info_list_clear(&config_info);
      
      	return strbuf_detach(&sb, NULL);
      }
      
    - /*
    +-/*
     - * Find first index of 'nicks' where there is 'nick'. 'nick' is
     - * compared case sensitively to the strings in 'nicks'. If not found
     - * 'nicks->nr' is returned.
    -+ * Find first element of 'p' where the 'name' member is 'nick'. 'nick'
    -+ * is compared case sensitively to the strings in 'p'. If not found
    -+ * NULL is returned.
    -  */
    +- */
     -static size_t remote_nick_find(struct strvec *nicks, const char *nick)
    -+static struct promisor_info *remote_nick_find(struct promisor_info *p, const char *nick)
    - {
    +-{
     -	for (size_t i = 0; i < nicks->nr; i++)
     -		if (!strcmp(nicks->v[i], nick))
     -			return i;
     -	return nicks->nr;
    -+	for (; p; p = p->next) {
    -+		if (!strcmp(p->name, nick))
    -+			return p;
    -+	}
    -+	return NULL;
    - }
    - 
    +-}
    +-
      enum accept_promisor {
    + 	ACCEPT_NONE = 0,
    + 	ACCEPT_KNOWN_URL,
     @@ promisor-remote.c: enum accept_promisor {
      
      static int should_accept_remote(enum accept_promisor accept,
      				const char *remote_name, const char *remote_url,
     -				struct strvec *names, struct strvec *urls)
    -+				struct promisor_info *config_info)
    ++				struct string_list *config_info)
      {
     -	size_t i;
     +	struct promisor_info *p;
    ++	struct string_list_item *item;
      
      	if (accept == ACCEPT_ALL)
      		return 1;
      
     -	i = remote_nick_find(names, remote_name);
    -+	p = remote_nick_find(config_info, remote_name);
    ++	/* Get config info for that promisor remote */
    ++	item = string_list_lookup(config_info, remote_name);
      
     -	if (i >= names->nr)
    -+	if (!p)
    ++	if (!item)
      		/* We don't know about that remote */
      		return 0;
      
    ++	p = item->util;
    ++
    + 	if (accept == ACCEPT_KNOWN_NAME)
    + 		return 1;
    + 
     @@ promisor-remote.c: static int should_accept_remote(enum accept_promisor accept,
      		return 0;
      	}
      
     -	if (!strcmp(urls->v[i], remote_url))
     +	if (!p->url)
    -+		BUG("Bad config_info (invalid URL) for remote '%s'.\n",
    ++		BUG("bad config_info (invalid URL) for remote '%s'",
     +		    remote_name);
     +
     +	if (!strcmp(p->url, remote_url))
    @@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
      	enum accept_promisor accept = ACCEPT_NONE;
     -	struct strvec names = STRVEC_INIT;
     -	struct strvec urls = STRVEC_INIT;
    -+	struct promisor_info *config_info = NULL;
    ++	struct string_list config_info = STRING_LIST_INIT_NODUP;
      
      	if (!git_config_get_string_tmp("promisor.acceptfromserver", &accept_str)) {
      		if (!*accept_str || !strcasecmp("None", accept_str))
     @@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
    + 	if (accept == ACCEPT_NONE)
      		return;
      
    - 	if (accept != ACCEPT_ALL)
    +-	if (accept != ACCEPT_ALL)
     -		promisor_info_vecs(repo, &names, &urls);
    -+		config_info = promisor_config_info_list(repo);
    ++	if (accept != ACCEPT_ALL) {
    ++		promisor_config_info_list(repo, &config_info);
    ++		string_list_sort(&config_info);
    ++	}
      
      	/* Parse remote info received */
      
    @@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
      			decoded_url = url_percent_decode(remote_url);
      
     -		if (decoded_name && should_accept_remote(accept, decoded_name, decoded_url, &names, &urls))
    -+		if (decoded_name && should_accept_remote(accept, decoded_name, decoded_url, config_info))
    ++		if (decoded_name && should_accept_remote(accept, decoded_name, decoded_url, &config_info))
      			strvec_push(accepted, decoded_name);
      
      		strbuf_list_free(elems);
    @@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
      
     -	strvec_clear(&names);
     -	strvec_clear(&urls);
    -+	promisor_info_list_free(config_info);
    ++	promisor_info_list_clear(&config_info);
      	strbuf_list_free(remotes);
      }
      
2:  29c6104827 ! 2:  8f3111b4f2 promisor-remote: allow a server to advertise more fields
    @@ Commit message
     
         Let's make it possible to pass more information by introducing a new
         "promisor.sendFields" configuration variable. This variable should
    -    contain a comma or space separated list of fields that will be looked
    -    up in the configuration of the remote on the server to find the values
    -    that will be passed to the client.
    +    contain a comma or space separated list of field names that will be
    +    looked up in the configuration of the remote on the server to find the
    +    values that will be passed to the client.
     
         Only a set of predefined fields are allowed. The only fields in this
         set are "partialCloneFilter" and "token". The "partialCloneFilter"
    @@ Commit message
         and the "token" field can provide an authentication credential for
         accessing it.
     
    -    For example if "promisor.sendFields" is set to "partialCloneFilter",
    +    For example, if "promisor.sendFields" is set to "partialCloneFilter",
         and the server has the "remote.<name>.partialCloneFilter" config
         variable set to a value for a remote, then that value will be passed
         in the form "partialCloneFilter=<value>" after the "name" and "url"
    @@ Documentation/config/promisor.adoc: promisor.advertise::
      
     +promisor.sendFields::
     +	A comma or space separated list of additional remote related
    -+	fields that a server will send while advertising its promisor
    -+	remotes using the "promisor-remote" capability, see
    -+	linkgit:gitprotocol-v2[5]. Currently, only the
    -+	"partialCloneFilter" and "token" fields are supported. The
    -+	"partialCloneFilter" field contains the partial clone filter
    -+	used for the remote, and the "token" field contains an
    -+	authentication token for the remote.
    ++	field names. A server will send these field names and the
    ++	associated field values from its configuration when
    ++	advertising its promisor remotes using the "promisor-remote"
    ++	capability, see linkgit:gitprotocol-v2[5]. Currently, only the
    ++	"partialCloneFilter" and "token" field names are supported.
     ++
    -+When a field is part of this list and a corresponding
    -+"remote.foo.<field>" config variable is set on the server to a
    -+non-empty value, then the field and its value will be sent when
    -+advertising the promisor remote "foo". This list has no effect unless
    -+the "promisor.advertise" config variable is set to "true", and the
    -+"name" and "url" fields are always advertised regardless of this
    -+setting.
    ++* "partialCloneFilter": contains the partial clone filter
    ++  used for the remote.
    +++
    ++* "token": contains an authentication token for the remote.
    +++
    ++When a field name is part of this list and a corresponding
    ++"remote.foo.<field name>" config variable is set on the server to a
    ++non-empty value, then the field name and value will be sent when
    ++advertising the promisor remote "foo".
    +++
    ++This list has no effect unless the "promisor.advertise" config
    ++variable is set to "true", and the "name" and "url" fields are always
    ++advertised regardless of this setting.
     +
      promisor.acceptFromServer::
      	If set to "all", a client will accept all the promisor remotes
    @@ promisor-remote.c: static int allow_unsanitized(char ch)
     +
     +	if (!git_config_get_string(config_key, &fields) && *fields) {
     +		string_list_split_in_place(fields_list, fields, ", ", -1);
    ++		string_list_remove_empty_items(fields_list, 0);
     +		filter_string_list(fields_list, 0, is_valid_field, (void *)config_key);
     +	}
     +
    @@ promisor-remote.c: static int allow_unsanitized(char ch)
     +}
     +
      /*
    -  * Linked list for promisor remotes involved in the "promisor-remote"
    +  * Struct for promisor remotes involved in the "promisor-remote"
       * protocol capability.
    -@@ promisor-remote.c: struct promisor_info {
    - 	struct promisor_info *next;
    +@@ promisor-remote.c: static int allow_unsanitized(char ch)
    + struct promisor_info {
      	const char *name;
      	const char *url;
     +	const char *filter;
     +	const char *token;
      };
      
    - static void promisor_info_list_free(struct promisor_info *p)
    -@@ promisor-remote.c: static void promisor_info_list_free(struct promisor_info *p)
    - 		next = p->next;
    + static void promisor_info_list_clear(struct string_list *list)
    +@@ promisor-remote.c: static void promisor_info_list_clear(struct string_list *list)
    + 		struct promisor_info *p = list->items[i].util;
      		free((char *)p->name);
      		free((char *)p->url);
     +		free((char *)p->filter);
     +		free((char *)p->token);
    - 		free(p);
      	}
    + 	string_list_clear(list, 1);
      }
      
    --/* Prepare a 'struct promisor_info' linked list with config information. */
    --static struct promisor_info *promisor_config_info_list(struct repository *repo)
     +static void set_one_field(struct promisor_info *p,
     +			  const char *field, const char *value)
     +{
    @@ promisor-remote.c: static void promisor_info_list_free(struct promisor_info *p)
     +	else if (!strcasecmp(field, promisor_field_token))
     +		p->token = xstrdup(value);
     +	else
    -+		BUG("Invalid field '%s'", field);
    ++		BUG("invalid field '%s'", field);
     +}
     +
     +static void set_fields(struct promisor_info *p,
    @@ promisor-remote.c: static void promisor_info_list_free(struct promisor_info *p)
     +	}
     +}
     +
    -+/*
    -+ * Prepare a 'struct promisor_info' linked list of promisor remotes
    -+ * with config information. Only members of that struct specified by
    -+ * the 'field_names' linked list are set (using values from the
    -+ * configuration).
    -+ */
    -+static struct promisor_info *promisor_config_info_list(struct repository *repo,
    -+						       struct string_list *field_names)
    + /*
    +  * Populate 'list' with promisor remote information from the config.
    +- * The 'util' pointer of each list item will hold a 'struct promisor_info'.
    ++ * The 'util' pointer of each list item will hold a 'struct
    ++ * promisor_info'. Except "name" and "url", only members of that
    ++ * struct specified by the 'field_names' list are set (using values
    ++ * from the configuration).
    +  */
    +-static void promisor_config_info_list(struct repository *repo, struct string_list *list)
    ++static void promisor_config_info_list(struct repository *repo,
    ++				      struct string_list *list,
    ++				      struct string_list *field_names)
      {
    - 	struct promisor_info *infos = NULL;
    - 	struct promisor_info **last_info = &infos;
    -@@ promisor-remote.c: static struct promisor_info *promisor_config_info_list(struct repository *repo)
    + 	struct promisor_remote *r;
    + 
    +@@ promisor-remote.c: static void promisor_config_info_list(struct repository *repo, struct string_lis
      			new_info->name = xstrdup(r->name);
      			new_info->url = xstrdup(url);
      
     +			if (field_names)
     +				set_fields(new_info, field_names);
     +
    - 			*last_info = new_info;
    - 			last_info = &new_info->next;
    + 			item = string_list_append(list, new_info->name);
    + 			item->util = new_info;
      		}
     @@ promisor-remote.c: char *promisor_remote_info(struct repository *repo)
      	if (!advertise_promisors)
      		return NULL;
      
    --	config_info = promisor_config_info_list(repo);
    -+	config_info = promisor_config_info_list(repo, fields_sent());
    +-	promisor_config_info_list(repo, &config_info);
    ++	promisor_config_info_list(repo, &config_info, fields_sent());
      
    - 	if (!config_info)
    + 	if (!config_info.nr)
      		return NULL;
     @@ promisor-remote.c: char *promisor_remote_info(struct repository *repo)
      		strbuf_addstr_urlencode(&sb, p->name, allow_unsanitized);
    @@ promisor-remote.c: char *promisor_remote_info(struct repository *repo)
     +		}
      	}
      
    - 	promisor_info_list_free(config_info);
    + 	promisor_info_list_clear(&config_info);
     @@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
      		return;
      
    - 	if (accept != ACCEPT_ALL)
    --		config_info = promisor_config_info_list(repo);
    -+		config_info = promisor_config_info_list(repo, NULL);
    - 
    - 	/* Parse remote info received */
    + 	if (accept != ACCEPT_ALL) {
    +-		promisor_config_info_list(repo, &config_info);
    ++		promisor_config_info_list(repo, &config_info, NULL);
    + 		string_list_sort(&config_info);
    + 	}
      
     @@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
      		elems = strbuf_split(remotes[i], ',');
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with 'KnownUrl
     +	git -C server config remote.otherLop.stuff "baz" &&
     +	git -C server config remote.otherLop.partialCloneFilter "blob:limit=10k" &&
     +	test_when_finished "git -C server remote remove otherLop" &&
    -+	git -C server config promisor.sendFields "partialCloneFilter, token" &&
    -+	test_when_finished "git -C server config unset promisor.sendFields" &&
    ++	test_config -C server promisor.sendFields "partialCloneFilter, token" &&
     +	test_when_finished "rm trace" &&
     +
     +	# Clone from server to create a client
3:  6d8236bf70 ! 3:  c91a1ba04a promisor-remote: refactor how we parse advertised fields
    @@ Commit message
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
      ## promisor-remote.c ##
    +@@ promisor-remote.c: struct promisor_info {
    + 	const char *token;
    + };
    + 
    ++static void promisor_info_free(struct promisor_info *p)
    ++{
    ++	free((char *)p->name);
    ++	free((char *)p->url);
    ++	free((char *)p->filter);
    ++	free((char *)p->token);
    ++	free(p);
    ++}
    ++
    + static void promisor_info_list_clear(struct string_list *list)
    + {
    +-	for (size_t i = 0; i < list->nr; i++) {
    +-		struct promisor_info *p = list->items[i].util;
    +-		free((char *)p->name);
    +-		free((char *)p->url);
    +-		free((char *)p->filter);
    +-		free((char *)p->token);
    +-	}
    +-	string_list_clear(list, 1);
    ++	for (size_t i = 0; i < list->nr; i++)
    ++		promisor_info_free(list->items[i].util);
    ++	string_list_clear(list, 0);
    + }
    + 
    + static void set_one_field(struct promisor_info *p,
     @@ promisor-remote.c: enum accept_promisor {
      };
      
      static int should_accept_remote(enum accept_promisor accept,
     -				const char *remote_name, const char *remote_url,
     +				struct promisor_info *advertised,
    - 				struct promisor_info *config_info)
    + 				struct string_list *config_info)
      {
      	struct promisor_info *p;
    + 	struct string_list_item *item;
     +	const char *remote_name = advertised->name;
     +	const char *remote_url = advertised->url;
      
    @@ promisor-remote.c: static int should_accept_remote(enum accept_promisor accept,
     +	if (!info->name || !info->url) {
     +		warning(_("server advertised a promisor remote without a name or URL: %s"),
     +			remote_info->buf);
    -+		promisor_info_list_free(info);
    ++		promisor_info_free(info);
     +		return NULL;
     +	}
     +
    @@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
     +		if (!advertised)
     +			continue;
      
    --		if (decoded_name && should_accept_remote(accept, decoded_name, decoded_url, config_info))
    +-		if (decoded_name && should_accept_remote(accept, decoded_name, decoded_url, &config_info))
     -			strvec_push(accepted, decoded_name);
    -+		if (should_accept_remote(accept, advertised, config_info))
    ++		if (should_accept_remote(accept, advertised, &config_info))
     +			strvec_push(accepted, advertised->name);
      
     -		strbuf_list_free(elems);
     -		free(decoded_name);
     -		free(decoded_url);
    -+		promisor_info_list_free(advertised);
    ++		promisor_info_free(advertised);
      	}
      
    - 	promisor_info_list_free(config_info);
    + 	promisor_info_list_clear(&config_info);
4:  dab5823356 ! 4:  ad68202057 promisor-remote: allow a client to check fields
    @@ Documentation/config/promisor.adoc: promisor.acceptFromServer::
     +
     +promisor.checkFields::
     +	A comma or space separated list of additional remote related
    -+	fields that a client will check before accepting a promisor
    -+	remote. Currently, "partialCloneFilter" and "token" are the only
    -+	supported field names.
    ++	field names. A client will check if the values of these fields
    ++	transmitted by a server correspond to the values of these
    ++	fields in its own configuration before accepting a promisor
    ++	remote. Currently, "partialCloneFilter" and "token" are the
    ++	only supported field names.
     ++
     +If one of these field names (e.g., "token") is being checked for an
     +advertised promisor remote (e.g., "foo"), three conditions must be met
    @@ Documentation/config/promisor.adoc: promisor.acceptFromServer::
     +3. The value of the locally configured `remote.foo.token` must exactly
     +   match the value advertised by the server for the "token" field.
     ++
    -+If any of these conditions are not met for any field name listed in
    ++If any of these conditions is not met for any field name listed in
     +`promisor.checkFields`, the advertised remote "foo" will be rejected.
     ++
     +For the "partialCloneFilter" field, this allows the client to ensure
    @@ Documentation/config/promisor.adoc: promisor.acceptFromServer::
     +be used to verify that authentication credentials match expected
     +values.
     ++
    ++Field names are compared case-insensitively. Field values are compared
    ++case-sensitively.
    +++
     +The "name" and "url" fields are always checked according to the
     +`promisor.acceptFromServer` policy, independently of this setting.
     ++
    -+The fields should be passed by the server through the
    ++The field names and values should be passed by the server through the
     +"promisor-remote" capability by using the `promisor.sendFields` config
     +variable. The fields will be checked only if the
     +`promisor.acceptFromServer` config variable is not set to "None". If
    @@ promisor-remote.c: static struct string_list *fields_sent(void)
     +}
     +
      /*
    -  * Linked list for promisor remotes involved in the "promisor-remote"
    +  * Struct for promisor remotes involved in the "promisor-remote"
       * protocol capability.
     @@ promisor-remote.c: enum accept_promisor {
      	ACCEPT_ALL
    @@ promisor-remote.c: enum accept_promisor {
     +}
     +
     +static int all_fields_match(struct promisor_info *advertised,
    -+			    struct promisor_info *config_info,
    ++			    struct string_list *config_info,
     +			    int in_list)
     +{
     +	struct string_list* fields = fields_checked();
    @@ promisor-remote.c: enum accept_promisor {
     +		int match = 0;
     +		const char *field = item_checked->string;
     +		const char *value = NULL;
    ++		struct string_list_item *item;
     +
     +		if (!strcasecmp(field, promisor_field_filter))
     +			value = advertised->filter;
    @@ promisor-remote.c: enum accept_promisor {
     +			return 0;
     +
     +		if (in_list) {
    -+			for (struct promisor_info *p = config_info; p; p = p->next) {
    ++			for_each_string_list_item(item, config_info) {
    ++				struct promisor_info *p = item->util;
     +				if (match_field_against_config(field, value, p)) {
     +					match = 1;
     +					break;
     +				}
     +			}
     +		} else {
    -+			match = match_field_against_config(field, value, config_info);
    ++			item = string_list_lookup(config_info, advertised->name);
    ++			if (item) {
    ++				struct promisor_info *p = item->util;
    ++				match = match_field_against_config(field, value, p);
    ++			}
     +		}
     +
     +		if (!match)
    @@ promisor-remote.c: enum accept_promisor {
     +
      static int should_accept_remote(enum accept_promisor accept,
      				struct promisor_info *advertised,
    - 				struct promisor_info *config_info)
    + 				struct string_list *config_info)
     @@ promisor-remote.c: static int should_accept_remote(enum accept_promisor accept,
      	const char *remote_url = advertised->url;
      
    @@ promisor-remote.c: static int should_accept_remote(enum accept_promisor accept,
     -		return 1;
     +		return all_fields_match(advertised, config_info, 1);
      
    - 	p = remote_nick_find(config_info, remote_name);
    - 
    + 	/* Get config info for that promisor remote */
    + 	item = string_list_lookup(config_info, remote_name);
     @@ promisor-remote.c: static int should_accept_remote(enum accept_promisor accept,
    - 		return 0;
    + 	p = item->util;
      
      	if (accept == ACCEPT_KNOWN_NAME)
     -		return 1;
    -+		return all_fields_match(advertised, p, 0);
    ++		return all_fields_match(advertised, config_info, 0);
      
      	if (accept != ACCEPT_KNOWN_URL)
      		BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
    @@ promisor-remote.c: static int should_accept_remote(enum accept_promisor accept,
      
      	if (!strcmp(p->url, remote_url))
     -		return 1;
    -+		return all_fields_match(advertised, p, 0);
    ++		return all_fields_match(advertised, config_info, 0);
      
      	warning(_("known remote named '%s' but with URL '%s' instead of '%s'"),
      		remote_name, p->url, remote_url);
    @@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
      	if (accept == ACCEPT_NONE)
      		return;
      
    --	if (accept != ACCEPT_ALL)
    --		config_info = promisor_config_info_list(repo, NULL);
    +-	if (accept != ACCEPT_ALL) {
    +-		promisor_config_info_list(repo, &config_info, NULL);
    +-		string_list_sort(&config_info);
    +-	}
     -
      	/* Parse remote info received */
      
    @@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
      		if (!advertised)
      			continue;
      
    -+		if (!config_info)
    -+			config_info = promisor_config_info_list(repo, fields_checked());
    ++		if (!config_info.nr) {
    ++			promisor_config_info_list(repo, &config_info, fields_checked());
    ++			string_list_sort(&config_info);
    ++		}
     +
    - 		if (should_accept_remote(accept, advertised, config_info))
    + 		if (should_accept_remote(accept, advertised, &config_info))
      			strvec_push(accepted, advertised->name);
      
     
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with promisor.
     +	git -C server config remote.otherLop.stuff "baz" &&
     +	git -C server config remote.otherLop.partialCloneFilter "blob:limit=10k" &&
     +	test_when_finished "git -C server remote remove otherLop" &&
    -+	git -C server config promisor.sendFields "partialCloneFilter, token" &&
    -+	test_when_finished "git -C server config unset promisor.sendFields" &&
    ++	test_config -C server promisor.sendFields "partialCloneFilter, token" &&
     +	test_when_finished "rm trace" &&
     +
     +	# Clone from server to create a client
5:  9bd612cdb8 ! 5:  e8efe62b7f promisor-remote: use string constants for 'name' and 'url' too
    @@ promisor-remote.c: static int allow_unsanitized(char ch)
      static const char promisor_field_token[] = "token";
      
     @@ promisor-remote.c: char *promisor_remote_info(struct repository *repo)
    - 		if (p != config_info)
    + 		if (item != config_info.items)
      			strbuf_addch(&sb, ';');
      
     -		strbuf_addstr(&sb, "name=");


Christian Couder (5):
  promisor-remote: refactor to get rid of 'struct strvec'
  promisor-remote: allow a server to advertise more fields
  promisor-remote: refactor how we parse advertised fields
  promisor-remote: allow a client to check fields
  promisor-remote: use string constants for 'name' and 'url' too

 Documentation/config/promisor.adoc    |  62 ++++
 Documentation/gitprotocol-v2.adoc     |  59 ++--
 promisor-remote.c                     | 395 +++++++++++++++++++++-----
 t/t5710-promisor-remote-capability.sh |  65 +++++
 4 files changed, 493 insertions(+), 88 deletions(-)

-- 
2.50.0.rc2.5.ge8efe62b7f

