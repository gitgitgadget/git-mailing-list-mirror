Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28992367AC
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 16:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759769837; cv=none; b=HQBoQHBUdAgi4BBn3zbJOUjGWh8k5NwgWgjpzAu+TcRnKjQmhzQUxc6VfEYxKsmhM2WWmzK7RXAtGPjfAAkz7EAmbefh7PJuGAHfPUoq4WNYQpY7Os+uCC5R+3L7+QAap38pfOeEHv7ZMaTbQSQnDEydqPV02XP77FGwOj9oHhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759769837; c=relaxed/simple;
	bh=rbz6Ha4pTufBUF8NcbDTK8wpV0BMzRzvpM6WD+v+SG4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bEvyNpWKLGvrsHJHZ0/TJxYqENBUHnfy/cz1Ri883HX/FJfgmNXPDVKwlJiB++j2FZdPN/xr0HwGP1w/uVhjYE9CR9BWhZYw6rK0oGiBpHD3OUVKuAbUx9TK6aXAQQy8UmBOcorKtlPyAG5/TExtupXfoY6KBH8c9H/BXlt9HdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=C/yBgbG0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JImcYV+C; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="C/yBgbG0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JImcYV+C"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 97B881D0015D;
	Mon,  6 Oct 2025 12:57:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 06 Oct 2025 12:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759769833; x=1759856233; bh=d55siWl28R
	ih1T6CeHlMQA6wKfJyBJdPhx2sv7lWjRI=; b=C/yBgbG0paAih/HPsZEuXg5apS
	M8NrvCgyb26U4RgN624lIV668PmlIsKc7SS6WliBcsk3wm82lvHGjEuf6RRPykjj
	7MCFZhsDKB4852mpU4TMgI04QGy03qduD1HgEiXQq4pQH0yvvmRqj32QJV8XBl6R
	WvrHN+zKOAayu5foA/q35n87gfDM2uJ259g2Cw1vb5jGelX+fU4asNN1e52uSLVv
	UPqGHpGhXbvWnux7XLPlZS0jXaGDBUy9RhG+Bq9s4wcc3dLVX/EbnDSV3tkZjUpY
	dTuN5PbSJYx1sc2rnoHdR2unWJEv4iz+XjgpNaABBf1oMMOtwsiPD1nW2L7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759769833; x=1759856233; bh=d55siWl28Rih1T6CeHlMQA6wKfJyBJdPhx2
	sv7lWjRI=; b=JImcYV+CA9+qs2fDF8FOerNFW5rrUtztCyT0AHAcvp6KjiIW1cw
	uGiFuSYrACEKPTrbaFHamoMC158lobrvTfkPxtlP969tOGUbNAymKZ8efYLz/Vc6
	8NZcRLunsVUYDGMd6kQR3qOdYZ7D/nVc0yw4X5nQYC7yctzFV4DGI/cNtTgbIC7x
	pKAFR179WkTRT6McFKl/B1bbJBoRXVZhGzgPd1ej4JLp+9g98jGV76CLdO4Sx3w6
	UI054XKCGX5pnz9P7h6MJeHRXhqGz6a+mBFUzO/qtfM57oLAMPDFWO1D7sGPkfxo
	nkM6yxEePUP9zyOGAzTZXduMQy8CDnNTlHg==
X-ME-Sender: <xms:6fTjaE86qglS1xQeY4DoFryEfDLA6dz09ClK-si0-9fiLGaKqLmbxw>
    <xme:6fTjaIg44w2FTbetDGWHAlcLSpEVt93aJN6W9ihFSvTSqXBcJBIHGcLzJBhRUI_rZ
    09jHwUe7jQG3uDrxJaP5ILjGTCN4E3p3z8rA-LvHdznBgjmINYzvg>
X-ME-Received: <xmr:6fTjaFZ7OuT1WXRssYQyfBAdVulYZK115kSUNhfixnLhz4xNezwJ_uhEpz24HNjiGbCn7-bze8-h2F56jpfcAbY8WpSRf5HFy0q->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelkedtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegvmhhilhihshhhrghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    eprhgurghmrgiiihhosehgohhoghhlvgdrtghomhdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvghtpdhrtghpthhtoheprggrrhhonhesshgthhhrrggsrdgtohhmpdhrtghpth
    htohepjhhrnhhivgguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhs
    rdhimhdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:6fTjaN8ErDGbxGx0Xdi5RW44yeyC8RhNUVbkntiKYdhTXazPgQ4tLw>
    <xmx:6fTjaHMDvdj-B4jL0G59Lj_a29tXD6mMeOIfCQ46Q3RxIdWHsfg8bg>
    <xmx:6fTjaKGblixDBZiQIQjNcbGb0EeJSJFAQvBKfGKFr5hypq2-RUTs3g>
    <xmx:6fTjaFz39ytQuD5W1kf6ozp6eODVaVAnwQfOflEQ-wy2Wz-GN5zjxw>
    <xmx:6fTjaIZEDuN0fICqQomJ7HHKVlwy5s8x0RFfQZs5yi7RnlG92dikz9CQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Oct 2025 12:57:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Emily Shaffer <emilyshaffer@google.com>,  Rodrigo
 Damazio Bovendorp <rdamazio@google.com>,  Jeff King <peff@peff.net>,
  Aaron Schrab <aaron@schrab.com>,  Jonathan Nieder <jrnieder@gmail.com>,
  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon <steadmon@google.com>,
  Ben Knoble <ben.knoble@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 4/5] submodule: encode gitdir paths to avoid conflicts
In-Reply-To: <20251006112518.3764240-5-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Mon, 6 Oct 2025 14:25:17 +0300")
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
	<20251006112518.3764240-1-adrian.ratiu@collabora.com>
	<20251006112518.3764240-5-adrian.ratiu@collabora.com>
Date: Mon, 06 Oct 2025 09:57:11 -0700
Message-ID: <xmqq347wq87s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> A custom encoding can become unnecessarily complex, while url-encoding is
> relatively well-known, however it needs some extending to support case
> insensitive filesystems, hence why A is encoded as _a, B as _b and so on.

Why 'A' cannot be encoded as %41 while encodign 'a' as %61?  Are
there case insensitive filesystems that cannot see the difference
between %41 and %61?  And they would not collide with COM: and other
anomalies, would they?

> For now url-encoding is the only option, however in the future we may
> add alternatives (other encodings, hashes or even hash_name).

Let's not say "For now".

Choose a single encoding that we can use forever so that we do not
have to upgrade extensions.encodeSubmoduleName with suffixes like
extensions.encodeSubmoduleNamev2, extensions.encodeSubmoduleNamev3,
etc. to cover our earlier mistakes and force renaming on users.

> Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
> Suggested-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
>  Documentation/config/extensions.adoc |   9 ++
>  Documentation/config/submodule.adoc  |   3 +
>  repository.h                         |   1 +
>  setup.c                              |   7 ++
>  setup.h                              |   1 +
>  submodule.c                          |  56 ++++++----
>  t/meson.build                        |   1 +
>  t/t7425-submodule-encoding.sh        | 146 +++++++++++++++++++++++++++
>  8 files changed, 204 insertions(+), 20 deletions(-)
>  create mode 100755 t/t7425-submodule-encoding.sh
>
> diff --git a/Documentation/config/extensions.adoc b/Documentation/config/extensions.adoc
> index 829f2523fc..c6ab268328 100644
> --- a/Documentation/config/extensions.adoc
> +++ b/Documentation/config/extensions.adoc
> @@ -73,6 +73,15 @@ relativeWorktrees::
>  	repaired with either the `--relative-paths` option or with the
>  	`worktree.useRelativePaths` config set to `true`.
>  
> +submoduleEncoding::
> +	If enabled, submodule gitdir paths are encoded to avoid filesystem
> +	conflicts due to nested gitdirs or case insensitivity. For now, only
> +	url-encoding (rfc3986) is available, with a small addition to encode
> +	uppercase to lowercase letters (`A  -> _a`, `B -> _b` and so on).
> +	Other encoding or hashing methods may be added in the future.
> +	Any preexisting non-encoded submodule gitdirs are used as-is, to
> +	ease migration and reduce risk of gitdirs not being recognized.
> +
>  worktreeConfig::
>  	If enabled, then worktrees will load config settings from the
>  	`$GIT_DIR/config.worktree` file in addition to the
> diff --git a/Documentation/config/submodule.adoc b/Documentation/config/submodule.adoc
> index 8f64adfbe3..cd7fd5da5b 100644
> --- a/Documentation/config/submodule.adoc
> +++ b/Documentation/config/submodule.adoc
> @@ -55,6 +55,9 @@ submodule.<name>.active::
>  submodule.<name>.gitdir::
>  	This option sets the gitdir path for submodule <name>, allowing users
>  	to override the default path or change the default path name encoding.
> +	Submodule gitdir encoding is enabled via `extensions.submoduleEncoding`
> +	(see linkgit:git-config[1]). This config works both with the extension
> +	enabled or disabled.
>  
>  submodule.active::
>  	A repeated field which contains a pathspec used to match against a
> diff --git a/repository.h b/repository.h
> index 5808a5d610..7e39b2acf7 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -158,6 +158,7 @@ struct repository {
>  	int repository_format_worktree_config;
>  	int repository_format_relative_worktrees;
>  	int repository_format_precious_objects;
> +	int repository_format_submodule_encoding;
>  
>  	/* Indicate if a repository has a different 'commondir' from 'gitdir' */
>  	unsigned different_commondir:1;
> diff --git a/setup.c b/setup.c
> index 7086741e6c..bf6e815105 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -687,6 +687,9 @@ static enum extension_result handle_extension(const char *var,
>  	} else if (!strcmp(ext, "relativeworktrees")) {
>  		data->relative_worktrees = git_config_bool(var, value);
>  		return EXTENSION_OK;
> +	} else if (!strcmp(ext, "submoduleencoding")) {
> +		data->submodule_encoding = git_config_bool(var, value);
> +		return EXTENSION_OK;
>  	}
>  	return EXTENSION_UNKNOWN;
>  }
> @@ -1865,6 +1868,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  				repo_fmt.worktree_config;
>  			the_repository->repository_format_relative_worktrees =
>  				repo_fmt.relative_worktrees;
> +			the_repository->repository_format_submodule_encoding =
> +				repo_fmt.submodule_encoding;
>  			/* take ownership of repo_fmt.partial_clone */
>  			the_repository->repository_format_partial_clone =
>  				repo_fmt.partial_clone;
> @@ -1963,6 +1968,8 @@ void check_repository_format(struct repository_format *fmt)
>  				    fmt->ref_storage_format);
>  	the_repository->repository_format_worktree_config =
>  		fmt->worktree_config;
> +	the_repository->repository_format_submodule_encoding =
> +		fmt->submodule_encoding;
>  	the_repository->repository_format_relative_worktrees =
>  		fmt->relative_worktrees;
>  	the_repository->repository_format_partial_clone =
> diff --git a/setup.h b/setup.h
> index 8522fa8575..66ec1ceba5 100644
> --- a/setup.h
> +++ b/setup.h
> @@ -130,6 +130,7 @@ struct repository_format {
>  	char *partial_clone; /* value of extensions.partialclone */
>  	int worktree_config;
>  	int relative_worktrees;
> +	int submodule_encoding;
>  	int is_bare;
>  	int hash_algo;
>  	int compat_hash_algo;
> diff --git a/submodule.c b/submodule.c
> index 7a2d7cd592..23b79c9192 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -2262,6 +2262,13 @@ int validate_submodule_git_dir(char *git_dir, const char *submodule_name)
>  	char *p;
>  	int ret = 0;
>  
> +	/*
> +	 * Skip these checks when extensions.submoduleEncoding is enabled because
> +	 * it fixes the nesting issues and the suffixes will not match by design.
> +	 */
> +	if (the_repository->repository_format_submodule_encoding)
> +		return 0;
> +
>  	if (len <= suffix_len || (p = git_dir + len - suffix_len)[-1] != '/' ||
>  	    strcmp(p, submodule_name))
>  		BUG("submodule name '%s' not a suffix of git dir '%s'",
> @@ -2581,29 +2588,22 @@ int submodule_to_gitdir(struct repository *repo,
>  	return ret;
>  }
>  
> +static void strbuf_addstr_case_encode(struct strbuf *dst, const char *src)
> +{
> +	for (; *src; src++) {
> +		unsigned char c = *src;
> +		if (c >= 'A' && c <= 'Z') {
> +			strbuf_addch(dst, '_');
> +			strbuf_addch(dst, c - 'A' + 'a');
> +		} else {
> +			strbuf_addch(dst, c);
> +		}
> +	}
> +}
> +
>  void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
>  			      const char *submodule_name)
>  {
> -	/*
> -	 * NEEDSWORK: The current way of mapping a submodule's name to
> -	 * its location in .git/modules/ has problems with some naming
> -	 * schemes. For example, if a submodule is named "foo" and
> -	 * another is named "foo/bar" (whether present in the same
> -	 * superproject commit or not - the problem will arise if both
> -	 * superproject commits have been checked out at any point in
> -	 * time), or if two submodule names only have different cases in
> -	 * a case-insensitive filesystem.
> -	 *
> -	 * There are several solutions, including encoding the path in
> -	 * some way, introducing a submodule.<name>.gitdir config in
> -	 * .git/config (not .gitmodules) that allows overriding what the
> -	 * gitdir of a submodule would be (and teach Git, upon noticing
> -	 * a clash, to automatically determine a non-clashing name and
> -	 * to write such a config), or introducing a
> -	 * submodule.<name>.gitdir config in .gitmodules that repo
> -	 * administrators can explicitly set. Nothing has been decided,
> -	 * so for now, just append the name at the end of the path.
> -	 */
>  	char *gitdir_path, *key;
>  
>  	/* Allow config override. */
> @@ -2618,4 +2618,20 @@ void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
>  
>  	repo_git_path_append(r, buf, "modules/");
>  	strbuf_addstr(buf, submodule_name);
> +
> +	/* Existing legacy non-encoded names are used as-is */
> +	if (is_git_directory(buf->buf))
> +		return;
> +
> +	if (the_repository->repository_format_submodule_encoding) {
> +		struct strbuf tmp = STRBUF_INIT;
> +
> +		strbuf_reset(buf);
> +		repo_git_path_append(r, buf, "modules/");
> +
> +		strbuf_addstr_urlencode(&tmp, submodule_name, is_rfc3986_unreserved);
> +		strbuf_addstr_case_encode(buf, tmp.buf);
> +
> +		strbuf_release(&tmp);
> +	}
>  }
> diff --git a/t/meson.build b/t/meson.build
> index 11376b9e25..de277227a2 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -882,6 +882,7 @@ integration_tests = [
>    't7422-submodule-output.sh',
>    't7423-submodule-symlinks.sh',
>    't7424-submodule-mixed-ref-formats.sh',
> +  't7425-submodule-encoding.sh',
>    't7450-bad-git-dotfiles.sh',
>    't7500-commit-template-squash-signoff.sh',
>    't7501-commit-basic-functionality.sh',
> diff --git a/t/t7425-submodule-encoding.sh b/t/t7425-submodule-encoding.sh
> new file mode 100755
> index 0000000000..4ea385d882
> --- /dev/null
> +++ b/t/t7425-submodule-encoding.sh
> @@ -0,0 +1,146 @@
> +#!/bin/sh
> +
> +test_description='submodules handle mixed legacy and new (encoded) style gitdir paths'
> +
> +. ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-verify-submodule-gitdir-path.sh
> +
> +test_expect_success 'setup: allow file protocol' '
> +	git config --global protocol.file.allow always
> +'
> +
> +test_expect_success 'create repo with mixed encoded and non-encoded submodules' '
> +	git init -b main legacy-sub &&
> +	test_commit -C legacy-sub legacy-initial &&
> +	legacy_rev=$(git -C legacy-sub rev-parse HEAD) &&
> +
> +	git init -b main new-sub &&
> +	test_commit -C new-sub new-initial &&
> +	new_rev=$(git -C new-sub rev-parse HEAD) &&
> +
> +	git init -b main main &&
> +	(
> +		cd main &&
> +		git submodule add ../legacy-sub legacy &&
> +		test_commit legacy-sub &&
> +
> +		git config core.repositoryformatversion 1 &&
> +		git config extensions.submoduleEncoding true &&
> +
> +		git submodule add ../new-sub "New Sub" &&
> +		test_commit new
> +	)
> +'
> +
> +test_expect_success 'verify submodule name is properly encoded' '
> +	verify_submodule_gitdir_path main legacy modules/legacy &&
> +	verify_submodule_gitdir_path main "New Sub" modules/_new%20_sub
> +'
> +
> +test_expect_success 'clone from repo with both legacy and new-style submodules' '
> +	git clone --recurse-submodules main cloned-non-encoding &&
> +	(
> +		cd cloned-non-encoding &&
> +
> +		test_path_is_dir .git/modules/legacy &&
> +		test_path_is_dir .git/modules/"New Sub" &&
> +
> +		git submodule status >list &&
> +		test_grep "$legacy_rev legacy" list &&
> +		test_grep "$new_rev New Sub" list
> +	) &&
> +
> +	git clone -c extensions.submoduleEncoding=true --recurse-submodules main cloned-encoding &&
> +	(
> +		cd cloned-encoding &&
> +
> +		test_path_is_dir .git/modules/legacy &&
> +		test_path_is_dir .git/modules/_new%20_sub &&
> +
> +		git submodule status >list &&
> +		test_grep "$legacy_rev legacy" list &&
> +		test_grep "$new_rev New Sub" list
> +	)
> +'
> +
> +test_expect_success 'commit and push changes to encoded submodules' '
> +	git -C legacy-sub config receive.denyCurrentBranch updateInstead &&
> +	git -C new-sub config receive.denyCurrentBranch updateInstead &&
> +	git -C main config receive.denyCurrentBranch updateInstead &&
> +	(
> +		cd cloned-encoding &&
> +
> +		git -C legacy switch --track -C main origin/main  &&
> +		test_commit -C legacy second-commit &&
> +		git -C legacy push &&
> +
> +		git -C "New Sub" switch --track -C main origin/main &&
> +		test_commit -C "New Sub" second-commit &&
> +		git -C "New Sub" push &&
> +
> +		# Stage and commit submodule changes in superproject
> +		git switch --track -C main origin/main  &&
> +		git add legacy "New Sub" &&
> +		git commit -m "update submodules" &&
> +
> +		# push superproject commit to main repo
> +		git push
> +	) &&
> +
> +	# update expected legacy & new submodule checksums
> +	legacy_rev=$(git -C legacy-sub rev-parse HEAD) &&
> +	new_rev=$(git -C new-sub rev-parse HEAD)
> +'
> +
> +test_expect_success 'fetch mixed submodule changes and verify updates' '
> +	(
> +		cd main &&
> +
> +		# only update submodules because superproject was
> +		# pushed into at the end of last test
> +		git submodule update --init --recursive &&
> +
> +		test_path_is_dir .git/modules/legacy &&
> +		test_path_is_dir .git/modules/_new%20_sub &&
> +
> +		# Verify both submodules are at the expected commits
> +		git submodule status >list &&
> +		test_grep "$legacy_rev legacy" list &&
> +		test_grep "$new_rev New Sub" list
> +	)
> +'
> +
> +test_expect_success 'setup submodules with nested git dirs' '
> +	git init nested &&
> +	test_commit -C nested nested &&
> +	(
> +		cd nested &&
> +		cat >.gitmodules <<-EOF &&
> +		[submodule "hippo"]
> +			url = .
> +			path = thing1
> +		[submodule "hippo/hooks"]
> +			url = .
> +			path = thing2
> +		EOF
> +		git clone . thing1 &&
> +		git clone . thing2 &&
> +		git add .gitmodules thing1 thing2 &&
> +		test_tick &&
> +		git commit -m nested
> +	)
> +'
> +
> +test_expect_success 'git dirs of encoded sibling submodules must not be nested' '
> +	git clone -c extensions.submoduleEncoding=true --recurse-submodules nested clone_nested &&
> +	verify_submodule_gitdir_path clone_nested hippo modules/hippo &&
> +	verify_submodule_gitdir_path clone_nested hippo/hooks modules/hippo%2fhooks
> +'
> +
> +test_expect_success 'submodule git dir nesting detection must work with parallel cloning' '
> +	git clone -c extensions.submoduleEncoding=true --recurse-submodules --jobs=2 nested clone_parallel &&
> +	verify_submodule_gitdir_path clone_parallel hippo modules/hippo &&
> +	verify_submodule_gitdir_path clone_parallel hippo/hooks modules/hippo%2fhooks
> +'
> +
> +test_done
