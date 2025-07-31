Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953241E2858
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 07:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753946663; cv=none; b=AToQAYW98/kOqmTFf28ATMvOIy7cTaBX9IKiiD32IE3Nx/QfoWPm8VAdp4A1l/CG8mnEm1GmmhfGfAF1aSMzNu57iDT41qraeVlHqWG6+sSNuBUpLXzT3b+CQ1cCa+zsBA2aZAmHXMiYB1f0dqfbVpWVFDKQQ4Fb/YiPTddpnqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753946663; c=relaxed/simple;
	bh=dnP63PvQdJ2AclT8cwDj22rQh+SrPIik/XlWU1G5OxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RdV+OLLpkxxj8kiHtulm4i4M7Qu5Iz9pHt/FFDr0Fl1h8EgpjK9Zwz8R8b8FnAYC+GA5u5LBRNOu99Wr2z9dbuomjYa5u41CMhxlNbbz2od09209uxkrZJGMu24RHIvxmkcv0EmNl06LMvE5REzSuBWoXXtqbBQkzZn3WUHboSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNSi5wFM; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNSi5wFM"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4538bc52a8dso718855e9.2
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 00:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753946658; x=1754551458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JywvroCj7Xt3MIFNxS+1c6FOpwATv3tQCHIY7O3owY=;
        b=VNSi5wFMwu0qQtNI5/XbevD54pwJKyQ8/MF6FqFrWCmouIlq2nQviA0pKntS137HnT
         t3hI+GZNtMcMfFm8iT7XrmGw59f9arflUCDTFeyMHCIKQmpjoUe8BQRNKPKIDkdpiaMf
         f3ub4VnxWB+VwArDpwh0k8MVzGJDb89xlD9bJNWYfd7hnGy6xnob5VRuxXP87kaEz62q
         aDtwFehVfWi34aC1GY5/t8eLm9li9TD5X/g3W1s4VT8qraE5B38QdQFl8z+alaHx6l92
         sJr7Nb24zJw44qIJbq+2JvTyD1XVtN03OS65tG6uqFLM8+ympr7/GGASOOtMRjAo5fY7
         XIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753946658; x=1754551458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4JywvroCj7Xt3MIFNxS+1c6FOpwATv3tQCHIY7O3owY=;
        b=QA+xkb++jt57fG/q6O5MQ1jFfTc+PUB5C2q5aJb7aMHZgvfbELQpnA8PtEko1Wyl6d
         N8RnNLMYXijdIBJ6fC4qpXN8S8JeXvfy9UaxxSIXBwhajULzfxH3IkYiC7becoxulH8C
         UIPwhtRNpIFAoUviVz7ZlJLDik2N2U3kJlVZxtLRxz/xwR+ymOwE5wh0cECK7ovHFKgU
         RgG5VFanUBnGOG5X6ZVTn2nOSMpz8Q3F/TNc6QNxnGCRp+r/tHQz3Tyf0v4iZkgaiSIW
         3cI7O6kZN5db17b8IaKbHWQOaZdyMwcuIYX3RyktMH6RE2mHJtZzN2OKmzjajbNo1LeH
         UfHA==
X-Gm-Message-State: AOJu0YwSHRi2vxg3Df/mOOGkVce8IefbKhgtl1t9LYtigIu/1Z+jWwp6
	82qzSKCydju8kZQ2R/vLvOg22KzkBsYKlaeety/mUJprb0AfhBy+qhFNWsQxkA==
X-Gm-Gg: ASbGncso7lRH6tsgTXPZtGUwi8pOqUL+2GBZC/Kt9HGhSsbQpx+7t2itBp+VA5Ux8/5
	mm+wrFz/MqnwtAtDPSWUKrQZqm0O2FBeFRhLJOlgcTofuBOLvz2TqWNxL/l131uUFvy/mi5L9jS
	fZnUzRCbVlMHNcAUiz82za25oxA0R+mknhD9MHcUvo7/KCcG3aqn7qK/T1drYrsZ7Kt+5TvsHpK
	B53yMppT/PsevVZNtmpCI2F0tGEwO/FqqbEZeXH3Roff75Gw7okoUnc5zr59C/FueSfVcIbAWLA
	kONQeLuSi4nzzkRltKW7UtBeqWq9y+3hDTnZSYk29j9qo1za4AZZ3yi98acMeQS1lIwh3ozLpVm
	5DcGd0zW6WI+WNmvw5IEaCG4MbTknYzRi/oE8cH5jn2M2aXhjxLb48wd4KRzdXtxyzUFugMZtrb
	iaxIhLezPKDw5730Q=
X-Google-Smtp-Source: AGHT+IH0IfBhCAzQ4b+n5xmlYSCZLxAvczR3inaFKV5E8bkkWkOyRSLWTmYm7z9mjl+v4xpeuP0V+Q==
X-Received: by 2002:a05:6000:40ce:b0:3b7:78c8:937f with SMTP id ffacd0b85a97d-3b794fc30e4mr4425902f8f.20.1753946658017;
        Thu, 31 Jul 2025 00:24:18 -0700 (PDT)
Received: from christian--20230123--2G7D3 (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953f8e02sm52495175e9.32.2025.07.31.00.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 00:24:17 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Jean-Noel Avila <jn.avila@free.fr>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 0/5] Make the "promisor-remote" capability support more fields
Date: Thu, 31 Jul 2025 09:23:52 +0200
Message-ID: <20250731072401.3817074-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.50.1.323.g4e0625aa69.dirty
In-Reply-To: <20250721141056.2283349-1-christian.couder@gmail.com>
References: <20250721141056.2283349-1-christian.couder@gmail.com>
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
store the 'struct promisor_info' instances instead.

This work is part of the "LOP" effort documented in:

  Documentation/technical/large-object-promisors.adoc

See that doc for more information on the broader context.

Changes since v6
----------------

Thanks to Patrick, Junio, Karthik, Jean-Noël and Justin for their
comments on the previous versions.

Here are the changes compared to v6:

- In patch 2/5 ("promisor-remote: allow a server to advertise more
  fields") in "Documentation/gitprotocol-v2.adoc" we now clarify that
  field names in the protocol are case-sensitive and MUST be
  transmitted exactly as specified.

- In patch 2/5 and 4/5 we don't initialize the `static int
  initialized` to `0`, we just let the BSS do it.

- In patch 3/5 ("promisor-remote: refactor how we parse advertised
  fields"), we now use string_list_split_in_place() instead of
  strbuf_split() and `struct string_list elem_list` instead of `struct
  strbuf **elems`. The useless call to strbuf_strip_suffix() has also
  been removed.

- In patch 4/5 ("promisor-remote: allow a client to check fields") in
  "Documentation/config/promisor.adoc" we removed "Field names are
  compared case-insensitively." as it's not true when field names are
  part of the protocol.

- Also in patch 4/5:

  - in all_fields_match((), we use `struct string_list *fields`
    instead of `struct string_list* fields` according to our style,
    and

  - in parse_one_advertised_remote() we use strcmp() instead of
    strcasecmp() as we decided that field names in the protocol are
    case-sensitive.

CI tests
--------

They have all passed, see:

https://github.com/chriscool/git/actions/runs/16632158419

Range diff compared to v6
-------------------------

1:  87a6ba5c48 = 1:  87a6ba5c48 promisor-remote: refactor to get rid of 'struct strvec'
2:  0543a42858 ! 2:  c729c110d0 promisor-remote: allow a server to advertise more fields
    @@ Documentation/gitprotocol-v2.adoc: retrieving the header from a bundle at the in
     +connecting to the remote. It corresponds to the "remote.<name>.token"
     +config setting.
     +
    -+No other fields are defined by the protocol at this time. Clients MUST
    -+ignore fields they don't recognize to allow for future protocol
    -+extensions.
    ++No other fields are defined by the protocol at this time. Field names
    ++are case-sensitive and MUST be transmitted exactly as specified
    ++above. Clients MUST ignore fields they don't recognize to allow for
    ++future protocol extensions.
     +
     +For now, the client can only use information transmitted through these
     +fields to decide if it accepts the advertised promisor remote. In the
    @@ promisor-remote.c: static int allow_unsanitized(char ch)
     +static struct string_list *fields_sent(void)
     +{
     +  static struct string_list fields_list = STRING_LIST_INIT_NODUP;
    -+  static int initialized = 0;
    ++  static int initialized;
     +
     +  if (!initialized) {
     +          fields_list.cmp = strcasecmp;
3:  d566719807 ! 3:  9e0eccae21 promisor-remote: refactor how we parse advertised fields
    @@ promisor-remote.c: static int should_accept_remote(enum accept_promisor accept,
     +static struct promisor_info *parse_one_advertised_remote(struct strbuf *remote_info)
     +{
     +  struct promisor_info *info = xcalloc(1, sizeof(*info));
    -+  struct strbuf **elems = strbuf_split(remote_info, ',');
    ++  struct string_list elem_list = STRING_LIST_INIT_NODUP;
    ++  struct string_list_item *item;
     +
    -+  for (size_t i = 0; elems[i]; i++) {
    -+          char *elem = elems[i]->buf;
    ++  string_list_split_in_place(&elem_list, remote_info->buf, ",", -1);
    ++
    ++  for_each_string_list_item(item, &elem_list) {
    ++          char *elem = item->string;
     +          char *value;
     +          char *p = strchr(elem, '=');
     +
    -+          strbuf_strip_suffix(elems[i], ",");
    -+
     +          if (!p) {
     +                  warning(_("invalid element '%s' from remote info"), elem);
     +                  continue;
    @@ promisor-remote.c: static int should_accept_remote(enum accept_promisor accept,
     +                  free(value);
     +  }
     +
    -+  strbuf_list_free(elems);
    ++  string_list_clear(&elem_list, 0);
     +
     +  if (!info->name || !info->url) {
     +          warning(_("server advertised a promisor remote without a name or URL: %s"),
4:  d2a13eabc0 ! 4:  b1a3384ddc promisor-remote: allow a client to check fields
    @@ Documentation/config/promisor.adoc: promisor.acceptFromServer::
     +be used to verify that authentication credentials match expected
     +values.
     ++
    -+Field names are compared case-insensitively. Field values are compared
    -+case-sensitively.
    ++Field values are compared case-sensitively.
     ++
     +The "name" and "url" fields are always checked according to the
     +`promisor.acceptFromServer` policy, independently of this setting.
    @@ promisor-remote.c: static struct string_list *fields_sent(void)
     +static struct string_list *fields_checked(void)
     +{
     +  static struct string_list fields_list = STRING_LIST_INIT_NODUP;
    -+  static int initialized = 0;
    ++  static int initialized;
     +
     +  if (!initialized) {
     +          fields_list.cmp = strcasecmp;
    @@ promisor-remote.c: enum accept_promisor {
     +                      struct string_list *config_info,
     +                      int in_list)
     +{
    -+  struct string_list* fields = fields_checked();
    ++  struct string_list *fields = fields_checked();
     +  struct string_list_item *item_checked;
     +
     +  for_each_string_list_item(item_checked, fields) {
    @@ promisor-remote.c: static struct promisor_info *parse_one_advertised_remote(stru
                        info->name = value;
                else if (!strcmp(elem, "url"))
                        info->url = value;
    -+          else if (!strcasecmp(elem, promisor_field_filter))
    ++          else if (!strcmp(elem, promisor_field_filter))
     +                  info->filter = value;
    -+          else if (!strcasecmp(elem, promisor_field_token))
    ++          else if (!strcmp(elem, promisor_field_token))
     +                  info->token = value;
                else
                        free(value);
5:  c7d7c83534 ! 5:  d0f7fda912 promisor-remote: use string constants for 'name' and 'url' too
    @@ promisor-remote.c: static struct promisor_info *parse_one_advertised_remote(stru
     -          else if (!strcmp(elem, "url"))
     +          else if (!strcmp(elem, promisor_field_url))
                        info->url = value;
    -           else if (!strcasecmp(elem, promisor_field_filter))
    +           else if (!strcmp(elem, promisor_field_filter))
                        info->filter = value;


Christian Couder (5):
  promisor-remote: refactor to get rid of 'struct strvec'
  promisor-remote: allow a server to advertise more fields
  promisor-remote: refactor how we parse advertised fields
  promisor-remote: allow a client to check fields
  promisor-remote: use string constants for 'name' and 'url' too

 Documentation/config/promisor.adoc    |  61 ++++
 Documentation/gitprotocol-v2.adoc     |  64 +++--
 promisor-remote.c                     | 398 +++++++++++++++++++++-----
 t/t5710-promisor-remote-capability.sh |  65 +++++
 4 files changed, 500 insertions(+), 88 deletions(-)

-- 
2.50.1.323.g4e0625aa69.dirty

