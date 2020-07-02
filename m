Return-Path: <SRS0=gkpi=AN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF9AC433E0
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 20:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B4432088E
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 20:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Mmc4sKMf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgGBUGg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jul 2020 16:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgGBUGg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jul 2020 16:06:36 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD59C08C5C1
        for <git@vger.kernel.org>; Thu,  2 Jul 2020 13:06:36 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id m8so9080789qvk.7
        for <git@vger.kernel.org>; Thu, 02 Jul 2020 13:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BHm+QVQOdE70LXEkxMdBPbTQ/qU7ng3hqD4zm4GJbHQ=;
        b=Mmc4sKMfvnVedka2/TxvGnZUuVMMhQwUipnVjUgMQrfzG5XE2DMwrb9aPGfSckV9Cd
         ZTyLzCctYX8akA29p5e3RVAVt2Ddi8A6JgOD9vZ003RodU1r3lgaU1MYnvjUQrNfCdiX
         9bVQuQu5KNGQEUkKi9sYM0NQ0hdH5mhqeVtOZ/QcfY1kO8xq7F9xIUtiMGqPgj/wA0E1
         dI1v0xOKF7ICqq+etE/cL3kTr8k3FWIe3cZL8jFZ8aTfjaYXrfZf6KlS+5whJ9Wht5Gs
         nlyw/fXLNn5UErb+WxC9Tx4JrwYW1TjzXUffIQrQfQ5Dya61EU/6MbApP3MJBr0+4gy/
         5IZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BHm+QVQOdE70LXEkxMdBPbTQ/qU7ng3hqD4zm4GJbHQ=;
        b=OyaOqDqhO+Z9N4XklgIw92ZFU5ZbUPaLfmneh6RK77SpMNy8ZOEU3oNvC2WB1zFgkK
         Kc+Ga7v9/EgHRxxQ0QuhXjy1uTlcmczyIF7oJeq0UARVGtpyJ4QQjQDI9EiilhgA5R51
         wp6oKYRVOq/U/LO7eF7KqrjB9HSGkC64LB52aASspEZWOys+3aa7GuC51ygx/6LamwGW
         DHqP6ZsS2Rp1sjet1dNWwsRJ6k3C2f1rWdyppXYBtVoV4sS6JauctTF0rbIu7gRV/VuX
         H8XoTNyLzJvX/oNTxy4r79BpbXz6qaKhUsU/xQ9qSZLfAOoPcIJQep1bJKVnbfoJkRBp
         etxA==
X-Gm-Message-State: AOAM533wcLIJvQpmwkPsvT27oTAWqonHK7b8RDsFn/GxqeoTSXdqHbOw
        LpVA15RN35mJnCLrezVp4tlwSUEKhaHOAw==
X-Google-Smtp-Source: ABdhPJyFZ9PVw1xcNnF0ZVKEhsgKbO8uJEbxHgHR62TIAI6spTQMi33rTZX11H86rf6eVq7z53o+jA==
X-Received: by 2002:a05:6214:1882:: with SMTP id cx2mr32533167qvb.240.1593720394681;
        Thu, 02 Jul 2020 13:06:34 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:650d:8c1a:48a0:61b2])
        by smtp.gmail.com with ESMTPSA id w204sm9442065qka.41.2020.07.02.13.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 13:06:34 -0700 (PDT)
Date:   Thu, 2 Jul 2020 16:06:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, chriscool@tuxfamily.org
Subject: [PATCH 2/4] upload-pack.c: allow banning certain object filter(s)
Message-ID: <f0982d24e74155f6c0e405e5e3ae8c3e579f798a.1593720075.git.me@ttaylorr.com>
References: <cover.1593720075.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1593720075.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git clients may ask the server for a partial set of objects, where the
set of objects being requested is refined by one or more object filters.
Server administrators can configure 'git upload-pack' to allow or ban
these filters by setting the 'uploadpack.allowFilter' variable to
'true' or 'false', respectively.

However, administrators using bitmaps may wish to allow certain kinds of
object filters, but ban others. Specifically, they may wish to allow
object filters that can be optimized by the use of bitmaps, while
rejecting other object filters which aren't and represent a perceived
performance degradation (as well as an increased load factor on the
server).

Allow configuring 'git upload-pack' to support object filters on a
case-by-case basis by introducing two new configuration variables:

  - 'uploadpack.filter.allow'
  - 'uploadpack.filter.<kind>.allow'

where '<kind>' may be one of 'blobNone', 'blobLimit', 'tree', and so on.

Setting the second configuration variable for any valid value of
'<kind>' explicitly allows or disallows restricting that kind of object
filter.

If a client requests the object filter <kind> and the respective
configuration value is not set, 'git upload-pack' will default to the
value of 'uploadpack.filter.allow', which itself defaults to 'true' to
maintain backwards compatibility. Note that this differs from
'uploadpack.allowfilter', which controls whether or not the 'filter'
capability is advertised.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/uploadpack.txt | 16 ++++++
 t/t5616-partial-clone.sh            | 26 ++++++++++
 upload-pack.c                       | 78 +++++++++++++++++++++++++++++
 3 files changed, 120 insertions(+)

diff --git a/Documentation/config/uploadpack.txt b/Documentation/config/uploadpack.txt
index ed1c835695..fd4970306c 100644
--- a/Documentation/config/uploadpack.txt
+++ b/Documentation/config/uploadpack.txt
@@ -57,6 +57,22 @@ uploadpack.allowFilter::
 	If this option is set, `upload-pack` will support partial
 	clone and partial fetch object filtering.
 
+uploadpack.filter.allow::
+	Provides a default value for unspecified object filters (see: the
+	below configuration variable).
+	Defaults to `true`.
+
+uploadpack.filter.<filter>.allow::
+	Explicitly allow or ban the object filter corresponding to
+	`<filter>`, where `<filter>` may be one of: `blob:none`,
+	`blob:limit`, `tree`, `sparse:oid`, or `combine`. If using
+	combined filters, both `combine` and all of the nested filter
+	kinds must be allowed.  Defaults to `uploadpack.filter.allow`.
++
+Note that the dot between 'filter' and '<filter>' is both non-standard
+and intentional. This is done to avoid a parsing ambiguity when
+specifying this configuration as an argument to Git's top-level `-c`.
+
 uploadpack.allowRefInWant::
 	If this option is set, `upload-pack` will support the `ref-in-want`
 	feature of the protocol version 2 `fetch` command.  This feature
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 8a27452a51..5dcd0b5656 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -235,6 +235,32 @@ test_expect_success 'implicitly construct combine: filter with repeated flags' '
 	test_cmp unique_types.expected unique_types.actual
 '
 
+test_expect_success 'upload-pack fails banned object filters' '
+	# Test case-insensitivity by intentional use of "blob:None" rather than
+	# "blob:none".
+	test_config -C srv.bare uploadpack.filter.blob:None.allow false &&
+	test_must_fail git clone --no-checkout --filter=blob:none \
+		"file://$(pwd)/srv.bare" pc3 2>err &&
+	test_i18ngrep "filter '\''blob:none'\'' not supported" err
+'
+
+test_expect_success 'upload-pack fails banned combine object filters' '
+	test_config -C srv.bare uploadpack.filter.allow false &&
+	test_config -C srv.bare uploadpack.filter.combine.allow true &&
+	test_config -C srv.bare uploadpack.filter.tree.allow true &&
+	test_config -C srv.bare uploadpack.filter.blob:none.allow false &&
+	test_must_fail git clone --no-checkout --filter=tree:1 \
+		--filter=blob:none "file://$(pwd)/srv.bare" pc3 2>err &&
+	test_i18ngrep "filter '\''blob:none'\'' not supported" err
+'
+
+test_expect_success 'upload-pack fails banned object filters with fallback' '
+	test_config -C srv.bare uploadpack.filter.allow false &&
+	test_must_fail git clone --no-checkout --filter=blob:none \
+		"file://$(pwd)/srv.bare" pc3 2>err &&
+	test_i18ngrep "filter '\''blob:none'\'' not supported" err
+'
+
 test_expect_success 'partial clone fetches blobs pointed to by refs even if normally filtered out' '
 	rm -rf src dst &&
 	git init src &&
diff --git a/upload-pack.c b/upload-pack.c
index 39d0cf00be..a5f56d73cc 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -88,6 +88,7 @@ struct upload_pack_data {
 	enum allow_uor allow_uor;
 
 	struct list_objects_filter_options filter_options;
+	struct string_list allowed_filters;
 
 	struct packet_writer writer;
 
@@ -103,6 +104,7 @@ struct upload_pack_data {
 	unsigned no_progress : 1;
 	unsigned use_include_tag : 1;
 	unsigned allow_filter : 1;
+	unsigned allow_filter_fallback : 1;
 
 	unsigned done : 1;					/* v2 only */
 	unsigned allow_ref_in_want : 1;				/* v2 only */
@@ -120,6 +122,7 @@ static void upload_pack_data_init(struct upload_pack_data *data)
 	struct string_list deepen_not = STRING_LIST_INIT_DUP;
 	struct string_list uri_protocols = STRING_LIST_INIT_DUP;
 	struct object_array extra_edge_obj = OBJECT_ARRAY_INIT;
+	struct string_list allowed_filters = STRING_LIST_INIT_DUP;
 
 	memset(data, 0, sizeof(*data));
 	data->symref = symref;
@@ -131,6 +134,8 @@ static void upload_pack_data_init(struct upload_pack_data *data)
 	data->deepen_not = deepen_not;
 	data->uri_protocols = uri_protocols;
 	data->extra_edge_obj = extra_edge_obj;
+	data->allowed_filters = allowed_filters;
+	data->allow_filter_fallback = 1;
 	packet_writer_init(&data->writer, 1);
 
 	data->keepalive = 5;
@@ -147,6 +152,7 @@ static void upload_pack_data_clear(struct upload_pack_data *data)
 	string_list_clear(&data->deepen_not, 0);
 	object_array_clear(&data->extra_edge_obj);
 	list_objects_filter_release(&data->filter_options);
+	string_list_clear(&data->allowed_filters, 1);
 
 	free((char *)data->pack_objects_hook);
 }
@@ -983,6 +989,47 @@ static int process_deepen_not(const char *line, struct string_list *deepen_not,
 	return 0;
 }
 
+static int allows_filter_choice(struct upload_pack_data *data,
+				enum list_objects_filter_choice c)
+{
+	const char *key = list_object_filter_config_name(c);
+	struct string_list_item *item = string_list_lookup(&data->allowed_filters,
+							   key);
+	if (item)
+		return (intptr_t) item->util;
+	return data->allow_filter_fallback;
+}
+
+static struct list_objects_filter_options *banned_filter(
+	struct upload_pack_data *data,
+	struct list_objects_filter_options *opts)
+{
+	size_t i;
+
+	if (!allows_filter_choice(data, opts->choice))
+		return opts;
+
+	if (opts->choice == LOFC_COMBINE)
+		for (i = 0; i < opts->sub_nr; i++) {
+			struct list_objects_filter_options *sub = &opts->sub[i];
+			if (banned_filter(data, sub))
+				return sub;
+		}
+	return NULL;
+}
+
+static void die_if_using_banned_filter(struct upload_pack_data *data)
+{
+	struct list_objects_filter_options *banned = banned_filter(data,
+								   &data->filter_options);
+	if (!banned)
+		return;
+
+	packet_writer_error(&data->writer, _("filter '%s' not supported\n"),
+			    list_object_filter_config_name(banned->choice));
+	die(_("git upload-pack: banned object filter requested"));
+}
+
 static void receive_needs(struct upload_pack_data *data,
 			  struct packet_reader *reader)
 {
@@ -1013,6 +1060,7 @@ static void receive_needs(struct upload_pack_data *data,
 				die("git upload-pack: filtering capability not negotiated");
 			list_objects_filter_die_if_populated(&data->filter_options);
 			parse_list_objects_filter(&data->filter_options, arg);
+			die_if_using_banned_filter(data);
 			continue;
 		}
 
@@ -1169,6 +1217,33 @@ static int find_symref(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
+static void parse_object_filter_config(const char *var, const char *value,
+				       struct upload_pack_data *data)
+{
+	struct strbuf spec = STRBUF_INIT;
+	const char *sub, *key;
+	size_t sub_len;
+
+	if (parse_config_key(var, "uploadpack", &sub, &sub_len, &key))
+		return;
+	if (!sub || !skip_prefix(sub, "filter.", &sub))
+		return;
+
+	if (sub != key)
+		strbuf_add(&spec, sub, key - sub - 1);
+	strbuf_tolower(&spec);
+
+	if (!strcmp(key, "allow")) {
+		if (spec.len)
+			string_list_insert(&data->allowed_filters, spec.buf)->util =
+				(void *)(intptr_t)git_config_bool(var, value);
+		else
+			data->allow_filter_fallback = git_config_bool(var, value);
+	}
+
+	strbuf_release(&spec);
+}
+
 static int upload_pack_config(const char *var, const char *value, void *cb_data)
 {
 	struct upload_pack_data *data = cb_data;
@@ -1208,6 +1283,8 @@ static int upload_pack_config(const char *var, const char *value, void *cb_data)
 			return git_config_string(&data->pack_objects_hook, var, value);
 	}
 
+	parse_object_filter_config(var, value, data);
+
 	return parse_hide_refs_config(var, value, "uploadpack");
 }
 
@@ -1388,6 +1465,7 @@ static void process_args(struct packet_reader *request,
 		if (data->allow_filter && skip_prefix(arg, "filter ", &p)) {
 			list_objects_filter_die_if_populated(&data->filter_options);
 			parse_list_objects_filter(&data->filter_options, p);
+			die_if_using_banned_filter(data);
 			continue;
 		}
 
-- 
2.27.0.225.g9fa765a71d

