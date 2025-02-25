Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABF121ABCA
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 14:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740495220; cv=none; b=IOxEVcjdaRNmIM7ZhbOLHYCLbaYwSp/A9OhQWZ47M0zQ3Jlp4cy8jSGkSYWyrOSXWO4EFh3a8B1kNqEFn0hSWoD4cQzWhO8qLGU/B4kgpu0AAwM+9zoGS0qqsS3cZMzu+rbt8/fIsiRYNubFQDtvAtGabXE+x8mvASwih+70dr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740495220; c=relaxed/simple;
	bh=hZETOX8neiQ+XawDtJko9CNlCphBMwEmjp322NudOnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nOFek6xLzbEhwctFIjHOB/XrfKO0AH6XG6mffRPOBh6KRckZ5gg2mtTTbKY++bhpl8orkLa6frjw3ng0VmtCAAElcP4EiOErCSzwtD0i00ziOTULf5cBPPznHJxjh2Y2Blxgz3HB8YHgrqH6uBLXj5ST3sqJBjZq1KAog+r6tvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5FrqUF/; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5FrqUF/"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-439846bc7eeso36180855e9.3
        for <git@vger.kernel.org>; Tue, 25 Feb 2025 06:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740495216; x=1741100016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qCdWtLA4rmXKG3GubRSqb/RpPEh4X0ghQ/RApow8T3A=;
        b=J5FrqUF/962B3amNaO5JBN364MFhIKk1N2SDDL2wB1uNY3D6YjyzD6rzGdW1KYIn77
         UJrST8iXXgywx5i9SR4ko1y+6X3ikQYEYrMIBiLVmBtoDLUhrxNleK4LqKt8GuSdqo2S
         gMk47rtYh2LOiZ0W7R7vAMLP9J01BvoZhcR0uqoosNrbOpyTERNvUjiDlCqumzBQjdkS
         lmEx6F3wosiS2zTlqSBLbLqunhwo9mWeOw8/TQuTFTbhT7CzMrlqh3aUV2UOn8TOH7Ek
         R7bt5tCmDt3r9w3jW8iS/6nqRrc4gP3aLy2XznSemFy/TvZhhc2FxhtONSPBHGhEX9lU
         zfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740495216; x=1741100016;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qCdWtLA4rmXKG3GubRSqb/RpPEh4X0ghQ/RApow8T3A=;
        b=c+axx2qvw+BIA4AhoEiAt8bzUcImBv+nLhZHea2+/KLUSkTDWDj2jJNkcCcfIDWZwL
         8QVr/KMd50EvcW79PykTX7ThXzzhb1Z2q0ENVela6JblKdBYmkkw3UdmGSEwl5kn+ivc
         DoyA7Rhpp3I4GoV6fdF8Xpr7ywb1GCqAaU2Rgl3V0YBs2ZIZwxtlHR5YoED7lO44Hj93
         f/pvVxf361pOEgQ/HGDyNoe//k7bn18NEFz+Cf3EHXeI/c8cLq3G1FGDaiItJpTWpOPL
         pbCD1naMafN4iGavsyFZuAhgcqCMHHgBDpE2XQ45dGPL0KFZRIhhNpWCio9dgJ4VXqU/
         D8Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWtFil46xCLaWVpvOY4GjEGwSKsfusvSLDThUPPTq50o2XjVzXrhQg4gB6uksP40qFqB40=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDpTV3323PuB7cAcH5OT9tDMBiejOfSEv6LvMnXFaCTAKNq19E
	QWKgkLssXwfgEex4zr2WthA+GuvJHQr666T4C7sGE9fq4mCMhL3K
X-Gm-Gg: ASbGncv/3Q7vXjP9D24+oxtN4kT6DUUav5Qot83xq6sDfPvxpQ4QAar4nEV6ujrIEsu
	1UnrjPnryFbIPYNJnhyRIFda6NGcABXy7e4k4leCeEVvBlJ1UCHa60fmgCdGL9vTu5P8KUBwr3w
	RrlkhUIQcHCFtevtl/vYLWiPspEGU4gTesYeuGMdUiX7cZ5au47hqRhUfY7prxI+wMzjpMPekHn
	Ymgbz+eQCYRnj4y3Of6ST460PZECAv5XgqpDPNnHA1za2E1muMcvw7oXttgOUqA3jtWLOVX9tDW
	fu3OezhTuTQ8FwIAv8aCjNtX8ZLNA8cvZD0IS6qYG4OsCwMX2z97NsOGggYMQXQOoOFUYcv2R05
	xiE6/
X-Google-Smtp-Source: AGHT+IGpIlgBC6a7NcuR9p2pQJBJufIPVcj9BXXj3sh3uIwtkornhcHO0KCPFA0C8v+VkuSevdhXWw==
X-Received: by 2002:a5d:64e2:0:b0:38f:2856:7d96 with SMTP id ffacd0b85a97d-38f6e754b76mr13936617f8f.1.1740495216294;
        Tue, 25 Feb 2025 06:53:36 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd86d69bsm2536782f8f.40.2025.02.25.06.53.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 06:53:35 -0800 (PST)
Message-ID: <98b4c9e7-4034-4692-bc86-f6b905dcc5aa@gmail.com>
Date: Tue, 25 Feb 2025 14:53:27 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/6] fast-export, fast-import: add support for
 signed-commits
To: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 Luke Shumaker <lukeshu@lukeshu.com>, Elijah Newren <newren@gmail.com>,
 Jeff King <peff@peff.net>, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Taylor Blau <me@ttaylorr.com>,
 "brian m . carlson" <sandals@crustytoothpaste.net>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <20210430232537.1131641-1-lukeshu@lukeshu.com>
 <20250224142744.279643-1-christian.couder@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20250224142744.279643-1-christian.couder@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christian

I've only glanced over this series, but I did notice a memory leak

On 24/02/2025 14:27, Christian Couder wrote:
> 
>       + * The returned string has had the ' ' line continuation markers
>      -+ * removed, and points to staticly allocated memory (not to memory
>      ++ * removed, and points to statically allocated memory (not to memory

This corrects the spelling but the changes below remove the static 
buffer so the user is now responsible for freeing the returned string. 
That means this comment is wrong and I don't see any corresponding 
changes to the callers to free the memory.

>       + * within 'msg'), so it is only valid until the next call to
>       + * find_commit_multiline_header.
>       + *
>      @@ builtin/fast-export.c: static void anonymize_ident_line(const char **beg, const
>       +						const char *key,
>       +						const char **end)
>       +{
>      -+	static struct strbuf val = STRBUF_INIT;
>      ++	struct strbuf val = STRBUF_INIT;
>       +	const char *bol, *eol;
>       +	size_t len;
>       +
>      -+	strbuf_reset(&val);
>      -+
>       +	bol = find_commit_header(msg, key, &len);
>       +	if (!bol)
>       +		return NULL;
>      @@ builtin/fast-export.c: static void anonymize_ident_line(const char **beg, const
>       +	}
>       +
>       +	*end = eol;
>      -+	return val.buf;
>      ++	return strbuf_detach(&val, NULL);
>       +}

Best Wishes

Phillip

>      - static char *reencode_message(const char *in_msg,
>      - 			      const char *in_encoding, size_t in_encoding_len)
>      + static void handle_commit(struct commit *commit, struct rev_info *rev,
>      + 			  struct string_list *paths_of_changed_objects)
>        {
>       @@ builtin/fast-export.c: static void handle_commit(struct commit *commit, struct rev_info *rev,
>        	const char *author, *author_end, *committer, *committer_end;
>      - 	const char *encoding;
>      + 	const char *encoding = NULL;
>        	size_t encoding_len;
>      -+	const char *signature_alg = NULL, *signature;
>      ++	const char *signature_alg = NULL, *signature = NULL;
>        	const char *message;
>        	char *reencoded = NULL;
>        	struct commit_list *p;
>       @@ builtin/fast-export.c: static void handle_commit(struct commit *commit, struct rev_info *rev,
>      - 	committer++;
>        	commit_buffer_cursor = committer_end = strchrnul(committer, '\n');
>        
>      --	/* find_commit_header() gets a `+ 1` because
>      + 	/*
>      +-	 * find_commit_header() gets a `+ 1` because
>       -	 * commit_buffer_cursor points at the trailing "\n" at the end
>       -	 * of the previous line, but find_commit_header() wants a
>      -+	/* find_commit_header() and find_commit_multiline_header() get
>      ++	 * find_commit_header() and find_commit_multiline_header() get
>       +	 * a `+ 1` because commit_buffer_cursor points at the trailing
>       +	 * "\n" at the end of the previous line, but they want a
>      - 	 * pointer to the beginning of the next line. */
>      + 	 * pointer to the beginning of the next line.
>      + 	 */
>       +
>      - 	encoding = find_commit_header(commit_buffer_cursor + 1, "encoding", &encoding_len);
>      - 	if (encoding)
>      - 		commit_buffer_cursor = encoding + encoding_len;
>      + 	if (*commit_buffer_cursor == '\n') {
>      + 		encoding = find_commit_header(commit_buffer_cursor + 1, "encoding", &encoding_len);
>      + 		if (encoding)
>      + 			commit_buffer_cursor = encoding + encoding_len;
>      + 	}
>        
>      -+	if ((signature = find_commit_multiline_header(commit_buffer_cursor + 1, "gpgsig", &commit_buffer_cursor)))
>      -+		signature_alg = "sha1";
>      -+	else if ((signature = find_commit_multiline_header(commit_buffer_cursor + 1, "gpgsig-sha256", &commit_buffer_cursor)))
>      -+		signature_alg = "sha256";
>      ++	if (*commit_buffer_cursor == '\n') {
>      ++		if ((signature = find_commit_multiline_header(commit_buffer_cursor + 1, "gpgsig", &commit_buffer_cursor)))
>      ++			signature_alg = "sha1";
>      ++		else if ((signature = find_commit_multiline_header(commit_buffer_cursor + 1, "gpgsig-sha256", &commit_buffer_cursor)))
>      ++			signature_alg = "sha256";
>      ++	}
>       +
>        	message = strstr(commit_buffer_cursor, "\n\n");
>        	if (message)
>      @@ builtin/fast-export.c: static void handle_commit(struct commit *commit, struct r
>        	printf("%.*s\n%.*s\n",
>        	       (int)(author_end - author), author,
>        	       (int)(committer_end - committer), committer);
>      -+	if (signature)
>      -+		switch(signed_commit_mode) {
>      ++	if (signature) {
>      ++		switch (signed_commit_mode) {
>       +		case SIGN_ABORT:
>       +			die("encountered signed commit %s; use "
>       +			    "--signed-commits=<mode> to handle it",
>      @@ builtin/fast-export.c: static void handle_commit(struct commit *commit, struct r
>       +		case SIGN_STRIP:
>       +			break;
>       +		}
>      ++		free((char *)signature);
>      ++	}
>        	if (!reencoded && encoding)
>        		printf("encoding %.*s\n", (int)encoding_len, encoding);
>        	printf("data %u\n%s",
>       @@ builtin/fast-export.c: static void handle_tag(const char *name, struct tag *tag)
>        					       "\n-----BEGIN PGP SIGNATURE-----\n");
>        		if (signature)
>      - 			switch(signed_tag_mode) {
>      + 			switch (signed_tag_mode) {
>       -			case SIGNED_TAG_ABORT:
>       +			case SIGN_ABORT:
>        				die("encountered signed tag %s; use "
>      @@ builtin/fast-export.c: static void handle_tag(const char *name, struct tag *tag)
>        				message_size = signature + 1 - message;
>        				break;
>        			}
>      -@@ builtin/fast-export.c: static int parse_opt_anonymize_map(const struct option *opt,
>      -
>      - int cmd_fast_export(int argc, const char **argv, const char *prefix)
>      +@@ builtin/fast-export.c: int cmd_fast_export(int argc,
>      + 		    const char *prefix,
>      + 		    struct repository *repo UNUSED)
>        {
>       +	const char *env_signed_commits_noabort;
>        	struct rev_info revs;
>      - 	struct object_array commits = OBJECT_ARRAY_INIT;
>        	struct commit *commit;
>      -@@ builtin/fast-export.c: int cmd_fast_export(int argc, const char **argv, const char *prefix)
>      + 	char *export_filename = NULL,
>      +@@ builtin/fast-export.c: int cmd_fast_export(int argc,
>        			    N_("show progress after <n> objects")),
>        		OPT_CALLBACK(0, "signed-tags", &signed_tag_mode, N_("mode"),
>        			     N_("select handling of signed tags"),
>      @@ builtin/fast-export.c: int cmd_fast_export(int argc, const char **argv, const ch
>        		OPT_CALLBACK(0, "tag-of-filtered-object", &tag_of_filtered_mode, N_("mode"),
>        			     N_("select handling of tags that tag filtered objects"),
>        			     parse_opt_tag_of_filtered_mode),
>      -@@ builtin/fast-export.c: int cmd_fast_export(int argc, const char **argv, const char *prefix)
>      +@@ builtin/fast-export.c: int cmd_fast_export(int argc,
>        	if (argc == 1)
>        		usage_with_options (fast_export_usage, options);
>        
>      @@ builtin/fast-import.c: static void parse_new_commit(const char *arg)
>       +			strbuf_addstr(&new_data, "gpgsig-sha256 ");
>       +		else
>       +			die("Expected gpgsig algorithm sha1 or sha256, got %s", sig_alg);
>      -+		string_list_split_in_place(&siglines, sig.buf, '\n', -1);
>      ++		string_list_split_in_place(&siglines, sig.buf, "\n", -1);
>       +		strbuf_add_separated_string_list(&new_data, "\n ", &siglines);
>       +		strbuf_addch(&new_data, '\n');
>       +	}
>      @@ t/t9350-fast-export.sh: test_expect_success 'signed-tags=warn-strip' '
>       +	# between the two.
>       +	test_config i18n.commitEncoding ISO-8859-1 &&
>       +	git checkout -f -b commit-signing main &&
>      -+	echo Sign your name > file-sign &&
>      ++	echo Sign your name >file-sign &&
>       +	git add file-sign &&
>       +	git commit -S -m "signed commit" &&
>       +	COMMIT_SIGNING=$(git rev-parse --verify commit-signing)
>      @@ t/t9350-fast-export.sh: test_expect_success 'signed-tags=warn-strip' '
>       +
>       +test_expect_success GPG 'signed-commits default' '
>       +
>      -+	unset FAST_EXPORT_SIGNED_COMMITS_NOABORT &&
>      ++	sane_unset FAST_EXPORT_SIGNED_COMMITS_NOABORT &&
>       +	test_must_fail git fast-export --reencode=no commit-signing &&
>       +
>       +	FAST_EXPORT_SIGNED_COMMITS_NOABORT=1 git fast-export --reencode=no commit-signing >output 2>err &&
>       +	! grep ^gpgsig output &&
>       +	grep "^encoding ISO-8859-1" output &&
>       +	test -s err &&
>      -+	sed "s/commit-signing/commit-strip-signing/" output |
>      -+		(cd new &&
>      -+		 git fast-import &&
>      -+		 test $COMMIT_SIGNING != $(git rev-parse --verify refs/heads/commit-strip-signing))
>      ++	sed "s/commit-signing/commit-strip-signing/" output | (
>      ++		cd new &&
>      ++		git fast-import &&
>      ++		STRIPPED=$(git rev-parse --verify refs/heads/commit-strip-signing) &&
>      ++		test $COMMIT_SIGNING != $STRIPPED
>      ++	)
>       +
>       +'
>       +
>      @@ t/t9350-fast-export.sh: test_expect_success 'signed-tags=warn-strip' '
>       +	git fast-export --signed-commits=verbatim --reencode=no commit-signing >output &&
>       +	grep "^gpgsig sha" output &&
>       +	grep "encoding ISO-8859-1" output &&
>      -+	(cd new &&
>      -+	 git fast-import &&
>      -+	 test $COMMIT_SIGNING = $(git rev-parse --verify refs/heads/commit-signing)) <output
>      ++	(
>      ++		cd new &&
>      ++		git fast-import &&
>      ++		STRIPPED=$(git rev-parse --verify refs/heads/commit-signing) &&
>      ++		test $COMMIT_SIGNING = $STRIPPED
>      ++	) <output
>       +
>       +'
>       +
>      @@ t/t9350-fast-export.sh: test_expect_success 'signed-tags=warn-strip' '
>       +	grep "^gpgsig sha" output &&
>       +	grep "encoding ISO-8859-1" output &&
>       +	test -s err &&
>      -+	(cd new &&
>      -+	 git fast-import &&
>      -+	 test $COMMIT_SIGNING = $(git rev-parse --verify refs/heads/commit-signing)) <output
>      ++	(
>      ++		cd new &&
>      ++		git fast-import &&
>      ++		STRIPPED=$(git rev-parse --verify refs/heads/commit-signing) &&
>      ++		test $COMMIT_SIGNING = $STRIPPED
>      ++	) <output
>       +
>       +'
>       +
>      @@ t/t9350-fast-export.sh: test_expect_success 'signed-tags=warn-strip' '
>       +	git fast-export --signed-commits=strip --reencode=no commit-signing >output &&
>       +	! grep ^gpgsig output &&
>       +	grep "^encoding ISO-8859-1" output &&
>      -+	sed "s/commit-signing/commit-strip-signing/" output |
>      -+		(cd new &&
>      -+		 git fast-import &&
>      -+		 test $COMMIT_SIGNING != $(git rev-parse --verify refs/heads/commit-strip-signing))
>      ++	sed "s/commit-signing/commit-strip-signing/" output | (
>      ++		cd new &&
>      ++		git fast-import &&
>      ++		STRIPPED=$(git rev-parse --verify refs/heads/commit-strip-signing) &&
>      ++		test $COMMIT_SIGNING != $STRIPPED
>      ++	)
>       +
>       +'
>       +
>      @@ t/t9350-fast-export.sh: test_expect_success 'signed-tags=warn-strip' '
>       +	! grep ^gpgsig output &&
>       +	grep "^encoding ISO-8859-1" output &&
>       +	test -s err &&
>      -+	sed "s/commit-signing/commit-strip-signing/" output |
>      -+		(cd new &&
>      -+		 git fast-import &&
>      -+		 test $COMMIT_SIGNING != $(git rev-parse --verify refs/heads/commit-strip-signing))
>      ++	sed "s/commit-signing/commit-strip-signing/" output | (
>      ++		cd new &&
>      ++		git fast-import &&
>      ++		STRIPPED=$(git rev-parse --verify refs/heads/commit-strip-signing) &&
>      ++		test $COMMIT_SIGNING != $STRIPPED
>      ++	)
>       +
>       +'
>       +
>        test_expect_success 'setup submodule' '
>        
>      + 	test_config_global protocol.file.allow always &&
>        	git checkout -f main &&
>      -+	{ git update-ref -d refs/heads/commit-signing || true; } &&
>      ++	test_might_fail git update-ref -d refs/heads/commit-signing &&
>        	mkdir sub &&
>        	(
>        		cd sub &&
> 
> 
> Christian Couder (1):
>    fast-export: fix missing whitespace after switch
> 
> Luke Shumaker (5):
>    git-fast-import.adoc: add missing LF in the BNF
>    fast-export: rename --signed-tags='warn' to 'warn-verbatim'
>    git-fast-export.txt: clarify why 'verbatim' may not be a good idea
>    fast-export: do not modify memory from get_commit_buffer
>    fast-export, fast-import: add support for signed-commits
> 
>   Documentation/git-fast-export.adoc |  25 +++-
>   Documentation/git-fast-import.adoc |  20 ++-
>   builtin/fast-export.c              | 189 +++++++++++++++++++++--------
>   builtin/fast-import.c              |  23 ++++
>   t/t9350-fast-export.sh             | 116 ++++++++++++++++++
>   5 files changed, 317 insertions(+), 56 deletions(-)
> 

