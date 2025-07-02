Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3352D0C61
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751468494; cv=none; b=nMqag3puymiugZKxtUeUHsrTbjiL3p+ToSrqNOhJwaPWLXAvn364l8nKsVBW+ezXmmA8sS2Z3OsQC1m4AFVY80wL17sdduAMv2ep1hRWEH/hrLtvPPZAmKqL/dd67ABM9OLKvxRWBYKgWJZ1dvtnWc0xGVn83UmqmiFjSg8o45o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751468494; c=relaxed/simple;
	bh=m+mZbFcQ8eheLuaneLGAtTTpxq2Ad3yvBJCiBanKM3g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZIHBvyC3/lwaGwQgzordoPVR3ZzyNwEJdVwQpFuvfOI0ZzGXK9BJSSRcAHAVzEHKeVzPeStH2U0zJhLU1D0elOU2Bt/X5Hfv00oT6A2jVIkHiOSmcAjuu2JLJJxWGARpBfk/jvtIN6/D69ycFUqCkGUIKgA7rlBKYaXeXCvynfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=wIU8HA9g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xs/3UO3m; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="wIU8HA9g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xs/3UO3m"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id F2F161D000E1;
	Wed,  2 Jul 2025 11:01:29 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 02 Jul 2025 11:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751468489;
	 x=1751554889; bh=SR23F69oalgXHmtIiCqFkeOesyvxVw2oOZqDRfab6CI=; b=
	wIU8HA9gZhESCuaMWNqxYbczYj8N3FsTv7qfduXlMoIjpSvoKKoXa0RO5TBfp75g
	qTRe9wluaXfYmbgo35hFd2dqY2A77wWBY55seOvwm61uV0A8NKjAcY/DUcJ2svwS
	tnrPSQFIE5UeuPanOwXfacnmFqrIklAcb/er9JP85GLdosncfLU9DnD1CFDLsIBB
	tZsVwyPb38ocB3SwHzqrA8I6PPco+FA6L2w3/BB1zFrIgMnxCCkxT49vzP267JDg
	kG3z9y8StnSMoZDozFn0b8419VRiPdLA5LuYvDrGJfIk7cfmGWYuzgHKb3+92Up1
	/5H6S5kyYYXctd5aaFyf4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751468489; x=
	1751554889; bh=SR23F69oalgXHmtIiCqFkeOesyvxVw2oOZqDRfab6CI=; b=X
	s/3UO3m4TsCVJXl2vLwkJyGcSo/l756aYBbYZPlQJruDWxTNyS8dnEw62umHvM9A
	IjO874MqwK8Xk/wVthGOlxagFZPP8uNakNyPUyvZCoQQKzg/Q4FmNeg7lrO7zs/Z
	XghHsoFZ/vzT0CznL+zG5A4dA44rBvF3i+z8XPBnT+LFXjz2kJ2oSrQvSvHPLZym
	/fqxmF0njGsWe0TKZa7ebda23koL+gKYnFXjgGKyZbOkVmLoSs6oVfgiRnJDkL/y
	NsE3DCGuxVfVLTJ0LofhIOefV8H7QgMzpj4USkiDzdG5r7Iiq/ahW7iAazsp/ZZU
	jC+LtylfIgqp3JU8ELvsA==
X-ME-Sender: <xms:yUllaJni8BRs-yLwMCuwKK82XNeHarzdnAP9wNAxxnANYrsTyEtO12w>
    <xme:yUllaE0NKDEEStNFRmk_8RlmtZG6Ntvb1hNDcbu86qgwNQ6r1ntBahqEFJ_OdHgYA
    YdkK-ULEwt1WRYpUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeegtdejieetgefh
    uedtuedttdeigfdvgeetkedtuedtudfgkeeluefgleetffejffenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohht
    hhhprghsthgvrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yUllaPovXer_iIOrbcmuwp9wbyADyZpwL0AtHMXazPlpJUVOiQ3l6A>
    <xmx:yUllaJl1I853PX2h4bn2C6FhLj1anWuOF5ICPD-FeoqBkZE3VmQ8mg>
    <xmx:yUllaH1MEPSWa_iqLCe0OmYbd-fAmqKuJMdXH3bhb4sTMXAw42XjhA>
    <xmx:yUllaIt7y_l_9YOom72zSGa86ZzozXqWXETpp1lQb8VlrfQHNFvFcw>
    <xmx:yUllaI-UaGT58gl7XICaJ8I4P0UujbMAvlrDFjgrvCJyxoC8ObABOOxo>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 805061EA0066; Wed,  2 Jul 2025 11:01:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T0938d428f80aed09
Date: Wed, 02 Jul 2025 17:01:04 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
Message-Id: <0120a6c7-8ec9-487e-ab5a-0ad1b684166a@app.fastmail.com>
In-Reply-To: <aGVGVIryDXD576iG@pks.im>
References: <20250620011943.586596-1-sandals@crustytoothpaste.net>
 <20250701212237.766774-1-sandals@crustytoothpaste.net>
 <aGVGVIryDXD576iG@pks.im>
Subject: Re: [PATCH v2 00/11] Add SHA-256 by default as a breaking change
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Jul 2, 2025, at 16:46, Patrick Steinhardt wrote:
> I looked specifically for the things that I commented on, all of which
> seem to have been addressed. Given that there is no range diff I trust
> that there aren't any other unexpected changes.
>
> So this iteration looks good to me, and I think that this series is a
> step into the right direction overall.

Range diff with trimmed/mangled whitespace:

```
 1:  aced16ec164 =  1:  ca6daa1368e hash: add a constant for the default hash algorithm
 2:  291d6f26bdd !  2:  1f68f3da877 hash: add a constant for the original hash algorithm
    @@ Metadata
     Author: brian m. carlson <sandals@crustytoothpaste.net>
     
      ## Commit message ##
    -    hash: add a constant for the original hash algorithm
    +    hash: add a constant for the legacy hash algorithm
     
         We have a a variety of uses of GIT_HASH_SHA1 littered throughout our
         code.  Some of these really mean to represent specifically SHA-1, but
         some actually represent the original hash algorithm used in Git which is
    -    implied by older formats and protocols which do not contain hash
    +    implied by older, legacy formats and protocols which do not contain hash
         information.  For instance, the bundle v1 and v2 formats do not contain
         hash algorithm information, and thus SHA-1 is implied by the use of
         these formats.
    @@ hash.h: static inline void git_SHA256_Clone(git_SHA256_CTX *dst, const git_SHA25
      #define GIT_HASH_NALGOS (GIT_HASH_SHA256 + 1)
      /* Default hash algorithm if unspecified. */
      #define GIT_HASH_DEFAULT GIT_HASH_SHA1
    -+/* Original hash algorithm. Implied for older data formats which don't specify. */
    -+#define GIT_HASH_ORIGINAL GIT_HASH_SHA1
    ++/* Legacy hash algorithm. Implied for older data formats which don't specify. */
    ++#define GIT_HASH_SHA1_LEGACY GIT_HASH_SHA1
      
      /* "sha1", big-endian */
      #define GIT_SHA1_FORMAT_ID 0x73686131
 3:  d041a12031d =  3:  dc9c16c2fc8 builtin: use default hash when outside a repository
 4:  a52bf97d8eb !  4:  667d251a04c Use original hash for legacy formats
    @@ Metadata
     Author: brian m. carlson <sandals@crustytoothpaste.net>
     
      ## Commit message ##
    -    Use original hash for legacy formats
    +    Use legacy hash for legacy formats
     
         We have a large variety of data formats and protocols where no hash
         algorithm was defined and the default was assumed to always be SHA-1.
         Instead of explicitly stating SHA-1, let's use the constant to represent
    -    the original hash algorithm (which is still SHA-1) so that it's clear
    +    the legacy hash algorithm (which is still SHA-1) so that it's clear
         for documentary purposes that it's a legacy fallback option and not an
         intentional choice to use SHA-1.
     
    @@ builtin/receive-pack.c: static struct command *read_head_info(struct packet_read
      			hash = parse_feature_value(feature_list, "object-format", &len, NULL);
      			if (!hash) {
     -				hash = hash_algos[GIT_HASH_SHA1].name;
    -+				hash = hash_algos[GIT_HASH_ORIGINAL].name;
    ++				hash = hash_algos[GIT_HASH_SHA1_LEGACY].name;
      				len = strlen(hash);
      			}
      			if (xstrncmpz(the_hash_algo->name, hash, len))
    @@ bundle.c: int read_bundle_header_fd(int fd, struct bundle_header *header,
      	 * `parse_capability()`.
      	 */
     -	header->hash_algo = &hash_algos[GIT_HASH_SHA1];
    -+	header->hash_algo = &hash_algos[GIT_HASH_ORIGINAL];
    ++	header->hash_algo = &hash_algos[GIT_HASH_SHA1_LEGACY];
      
      	/* The bundle header ends with an empty line */
      	while (!strbuf_getwholeline_fd(&buf, fd, '\n') &&
    @@ bundle.c: int create_bundle(struct repository *r, const char *path,
      	 * 2. @filter is required because we parsed an object filter.
      	 */
     -	if (the_hash_algo != &hash_algos[GIT_HASH_SHA1] || revs.filter.choice)
    -+	if (the_hash_algo != &hash_algos[GIT_HASH_ORIGINAL] || revs.filter.choice)
    ++	if (the_hash_algo != &hash_algos[GIT_HASH_SHA1_LEGACY] || revs.filter.choice)
      		min_version = 3;
      
      	if (argc > 1) {
    @@ connect.c: static void process_capabilities(struct packet_reader *reader, size_t
      		free(hash_name);
      	} else {
     -		reader->hash_algo = &hash_algos[GIT_HASH_SHA1];
    -+		reader->hash_algo = &hash_algos[GIT_HASH_ORIGINAL];
    ++		reader->hash_algo = &hash_algos[GIT_HASH_SHA1_LEGACY];
      	}
      }
      
    @@ connect.c: static void send_capabilities(int fd_out, struct packet_reader *reade
      		packet_write_fmt(fd_out, "object-format=%s", reader->hash_algo->name);
      	} else {
     -		reader->hash_algo = &hash_algos[GIT_HASH_SHA1];
    -+		reader->hash_algo = &hash_algos[GIT_HASH_ORIGINAL];
    ++		reader->hash_algo = &hash_algos[GIT_HASH_SHA1_LEGACY];
      	}
      	if (server_feature_v2("promisor-remote", &promisor_remote_info)) {
      		char *reply = promisor_remote_reply(promisor_remote_info);
    @@ connect.c: int server_supports_hash(const char *desired, int *feature_supported)
      		*feature_supported = !!hash;
      	if (!hash) {
     -		hash = hash_algos[GIT_HASH_SHA1].name;
    -+		hash = hash_algos[GIT_HASH_ORIGINAL].name;
    ++		hash = hash_algos[GIT_HASH_SHA1_LEGACY].name;
      		len = strlen(hash);
      	}
      	while (hash) {
    @@ fetch-pack.c: static void write_fetch_command_and_capabilities(struct strbuf *re
      			    the_hash_algo->name, hash_name);
      		packet_buf_write(req_buf, "object-format=%s", the_hash_algo->name);
     -	} else if (hash_algo_by_ptr(the_hash_algo) != GIT_HASH_SHA1) {
    -+	} else if (hash_algo_by_ptr(the_hash_algo) != GIT_HASH_ORIGINAL) {
    ++	} else if (hash_algo_by_ptr(the_hash_algo) != GIT_HASH_SHA1_LEGACY) {
      		die(_("the server does not support algorithm '%s'"),
      		    the_hash_algo->name);
      	}
    @@ pkt-line.c: void packet_reader_init(struct packet_reader *reader, int fd,
      	reader->options = options;
      	reader->me = "git";
     -	reader->hash_algo = &hash_algos[GIT_HASH_SHA1];
    -+	reader->hash_algo = &hash_algos[GIT_HASH_ORIGINAL];
    ++	reader->hash_algo = &hash_algos[GIT_HASH_SHA1_LEGACY];
      	strbuf_init(&reader->scratch, 0);
      }
      
    @@ remote-curl.c: static const struct git_hash_algo *detect_hash_algo(struct discov
      	 */
      	if (!p)
     -		return &hash_algos[GIT_HASH_SHA1];
    -+		return &hash_algos[GIT_HASH_ORIGINAL];
    ++		return &hash_algos[GIT_HASH_SHA1_LEGACY];
      
      	algo = hash_algo_by_length((p - heads->buf) / 2);
      	if (algo == GIT_HASH_UNKNOWN)
    @@ serve.c
      static int advertise_sid = -1;
      static int advertise_object_info = -1;
     -static int client_hash_algo = GIT_HASH_SHA1;
    -+static int client_hash_algo = GIT_HASH_ORIGINAL;
    ++static int client_hash_algo = GIT_HASH_SHA1_LEGACY;
      
      static int always_advertise(struct repository *r UNUSED,
      			    struct strbuf *value UNUSED)
    @@ setup.c: void initialize_repository_version(int hash_algo,
      	 * the remote repository's format.
      	 */
     -	if (hash_algo != GIT_HASH_SHA1 ||
    -+	if (hash_algo != GIT_HASH_ORIGINAL ||
    ++	if (hash_algo != GIT_HASH_SHA1_LEGACY ||
      	    ref_storage_format != REF_STORAGE_FORMAT_FILES)
      		target_version = GIT_REPO_VERSION_READ;
      
     -	if (hash_algo != GIT_HASH_SHA1 && hash_algo != GIT_HASH_UNKNOWN)
    -+	if (hash_algo != GIT_HASH_ORIGINAL && hash_algo != GIT_HASH_UNKNOWN)
    ++	if (hash_algo != GIT_HASH_SHA1_LEGACY && hash_algo != GIT_HASH_UNKNOWN)
      		git_config_set("extensions.objectformat",
      			       hash_algos[hash_algo].name);
      	else if (reinit)
    @@ transport.c: struct transport *transport_get(struct remote *remote, const char *
      	}
      
     -	ret->hash_algo = &hash_algos[GIT_HASH_SHA1];
    -+	ret->hash_algo = &hash_algos[GIT_HASH_ORIGINAL];
    ++	ret->hash_algo = &hash_algos[GIT_HASH_SHA1_LEGACY];
      
      	return ret;
      }
 5:  d27e4ee557d !  5:  d6e616cee74 setup: use the default algorithm to initialize repo format
    @@ Commit message
     
         Because we might not always want to use SHA-1 as the default, let's
         instead specify the default hash algorithm constant so that we will use
    -    whatever the specified default is.  However, to make sure we continue to
    -    read repositories without a specified hash algorithm as SHA-1, default
    -    the repository format to the original hash algorithm (SHA-1) when
    -    reading the repository format.
    +    whatever the specified default is.
    +
    +    However, we also need to continue to read older repositories.  If we're
    +    in a v0 repository or extensions.objectformat is not set, then we must
    +    continue to default to the original hash algorithm: SHA-1.  If an
    +    algorithm is set explicitly, however, it will override the hash_algo
    +    member of the repository_format struct and we'll get the right value.
    +
    +    Similarly, if the repository was initialized before Git 0.99.3, then it
    +    may lack a core.repositoryformatversion key, and some repositories lack
    +    a config file altogether.  In both cases, format->version is -1 and we
    +    need to assume that SHA-1 is in use.
    +
    +    Because clear_repository_format reinitializes the struct
    +    repository_format and therefore sets the hash_algo member to the default
    +    (which could in the future not be SHA-1), we need to reset this member
    +    explicitly.  We know, however, that at the point we call
    +    read_repository_format, we are actually reading an existing repository
    +    and not initializing a new one or operating outside of a repository, so
    +    we are not changing the default behavior back to SHA-1 if the default
    +    algorithm is different.
    +
    +    It is potentially questionable that we ignore all repository
    +    configuration if there is a config file but it doesn't have
    +    core.repositoryformatversion set, in which case we reset all of the
    +    configuration to the default.  However, it is unclear what the right
    +    thing to do instead with such an old repository is and a simple git init
    +    will add the missing entry, so for now, we simply honor what the
    +    existing code does and reset the value to the default, simply adding our
    +    initialization to SHA-1.
     
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    @@ setup.c: static void init_repository_format(struct repository_format *format)
      int read_repository_format(struct repository_format *format, const char *path)
      {
      	clear_repository_format(format);
    -+	format->hash_algo = GIT_HASH_ORIGINAL;
    ++	format->hash_algo = GIT_HASH_SHA1_LEGACY;
      	git_config_from_file(check_repo_format, path, format);
     -	if (format->version == -1)
     +	if (format->version == -1) {
      		clear_repository_format(format);
    -+		format->hash_algo = GIT_HASH_ORIGINAL;
    ++		format->hash_algo = GIT_HASH_SHA1_LEGACY;
     +	}
      	return format->version;
      }
 6:  9bb3c06d5b7 =  6:  c470ac4ac41 t: default to compile-time default hash if not set
 7:  8670b4fc7b0 =  7:  6866b422608 t1007: choose the built-in hash outside of a repo
 8:  8804bfbfa2c =  8:  f957ce078f6 t4042: choose the built-in hash outside of a repo
 9:  231c9ff200f =  9:  9d619f2ef8c t5300: choose the built-in hash outside of a repo
10:  53554e53b35 <  -:  ----------- Enable SHA-256 by default in breaking changes mode
 -:  ----------- > 10:  39153c80971 help: add a build option for default hash
 -:  ----------- > 11:  c79bb70a2e7 Enable SHA-256 by default in breaking changes mode
```

From the repo.
