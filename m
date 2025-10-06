Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D5717A316
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 16:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759769281; cv=none; b=de/04tO+aNycaPtR+axGWcK6ZJZmTcPhSAfXTR0BSj5KAU/Hg141B/FVk391rATcIQvkJVbnUHj/mI1o0xOjCEqgbsrSN3XhAMiOgVAeCzqfRTlt5l0roBkTwGa6yl9sMlEkfkfsSWElE/WLXUBW0ZqT9WtIFYw7VlC08uH3/FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759769281; c=relaxed/simple;
	bh=l1BXswX+IYWXSOc8/IGlWGWDqcB2IzwWfUqZ49OXQKU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MdOySkz5QJo6OPkSU07/3iKkazGgDjSw7C2ByP55xKK/rZAzGP+wXLoFOQ31q70wr1vrYYUx7lqmjsavpglJ3Ae1xBmOyRNxFqkxlYqA1WOBhdU1f4bMmU1AOwH9VvqNCUverwe5w0PTQQZQiSvj5FUeYVm9K+MkVIICyFr6xyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QTVNXgjb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fJiVi7Qt; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QTVNXgjb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fJiVi7Qt"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A918B7A018E;
	Mon,  6 Oct 2025 12:47:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 06 Oct 2025 12:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759769278; x=1759855678; bh=GwaY0Wxywt
	XLUpbQNvUbZTfr6wDMFrSqRDUCrEVV79s=; b=QTVNXgjbaSfAfCG9mvdZTRUsTE
	K0VnSANdRTRqvNUeYw35T25XOr/XUQ/WauLjmImFVDykMFTbEI3BaqadgHrgdWHO
	Evxfbf5xqCOqV4mv7RpHbLumMkqseb15Y6jPyrvnQfNyshc/OlxqNVo7W0FlkUHu
	tIu8Bq4ykHDqtViz8Xn7n6KKMtbO8kykF4/iC6yP0l5CAutrZASlwbm6DnzN6hb3
	UztfRG8bmPSM68+P7yj+6U+Tyc/CO3y072j0eVyRUcWR3+WigCfYXsORZTf7VUKx
	n8dt4cBvK0rETBPWAQ8lX/D5zf0+JZkGyWsbp/oXE/1lq7LwpIuMki1YbWIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759769278; x=1759855678; bh=GwaY0WxywtXLUpbQNvUbZTfr6wDMFrSqRDU
	CrEVV79s=; b=fJiVi7Qtd8tiH1yo1UpiLPDjAiwlfxueqv0awY8cHfH27stU+qb
	BcqA5qXWDXBaQGvks6m8YliltbFTcd8m8KrXIJogfoZGPD+rIhWjfsA6X+Lh6zRL
	ZNHMAwAsZTzuH9A5mYcd3YerxP/sEaOHv0PTTaFOUm5uchAvdarngAmnsjhwah9Q
	Fng47lP2L9r+tNthTfbMGg6x3a61Wq/7j/TM52waYw0SWe9Nv+ugEw3DwMbIJPpE
	gaOn/PTDHx9IZ1N1a5PLDh2/wx+jU1w2U48laIImJxugitunD01LvWudir2WvgxJ
	6BkqqO7ygieZhtvngGTSwbE7vex0XxRC88A==
X-ME-Sender: <xms:vfLjaGlFtPNag3RPohZyvfYzWkvzcrHQlO2-DfMjTNYI_lN4VzA3lw>
    <xme:vfLjaJpOG4IvAkMm_E4YOCL6meDYVpn5BfakIPXaNxRRcLJReW85L2OQdCwtorgtU
    VjsfY4ksxAH1Vanszg2zg0V_T5_Os5qdtKyAqQ9OMTMSTsNlMXu3w>
X-ME-Received: <xmr:vfLjaAANiLjk5EmQ30NGzmpq3p-MXEkCm4mbkHCShQbH6wknBrn0XJLRWJsNHfhnL2bgafHYi7-lJ6jaultcIWCl3Ttcu3SPDhyv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelkedtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvieefudekudduuefhuddujeeiteejleeltddttedvveejhffflefgtdduudev
    hfenucffohhmrghinhepshhusgdrrggtthhivhgvnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrug
    hrihgrnhdrrhgrthhiuhestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghmihhlhihshhgrfhhfvg
    hrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehruggrmhgriihiohesghhoohhglhgv
    rdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegrrg
    hrohhnsehstghhrhgrsgdrtghomhdprhgtphhtthhopehjrhhnihgvuggvrhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshhtvggrug
    hmohhnsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:vfLjaEHGSfxFNk_4qIkaOA_6kKOa_1PIwBI6OPoWpwzLtcUF2aqikg>
    <xmx:vfLjaC1m_hsppJ2KBIqR3YVrd4We7d2_g3X8Fn0iOjssIf-b9cJ6dw>
    <xmx:vfLjaNPAmN3-BsPmy5TxrRN0hT3O4us5qGih76xDDCpt1NhOt5Jedg>
    <xmx:vfLjaKa5ZB2H5PZywpTAOfEInYCD5N9q5T-mAXU2I7rbiZleMCQ4yQ>
    <xmx:vvLjaPAmrYz-s5OJPqLC1D6MOnkZDOOCY4ZiL-Sm47YlZbq1YyFFyUO5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Oct 2025 12:47:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Emily Shaffer <emilyshaffer@google.com>,
  Rodrigo Damazio Bovendorp <rdamazio@google.com>,  Jeff King <peff@peff.net>,
  Aaron Schrab <aaron@schrab.com>,  Jonathan Nieder <jrnieder@gmail.com>,
  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon <steadmon@google.com>,
  Ben Knoble <ben.knoble@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 2/5] submodule: add gitdir path config override
In-Reply-To: <20251006112518.3764240-3-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Mon, 6 Oct 2025 14:25:15 +0300")
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
	<20251006112518.3764240-1-adrian.ratiu@collabora.com>
	<20251006112518.3764240-3-adrian.ratiu@collabora.com>
Date: Mon, 06 Oct 2025 09:47:56 -0700
Message-ID: <xmqqcy70q8n7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

[jc: brandon removed from CC list as the address would bounce]

> This adds the ability to override gitdir paths via config files
> (not .gitmodules) such that the encoding scheme (or plain text
> name if the encoding extension is disabled) can be changed via
> config entries.
>
> These entries are not added by default for all submodules: they
> should be used on an as-needed basis.
>
> A new test and a helper are added. The helper will also be used
> in further tests exercising gitdir encoding functionality.

What is the use case of this?  The only reasonable use case I can
see is to set this to all the existing submodules when you are
switching the extension on before adding a new submodule, in which
case the old ones will keep using unencoded names, while the new
ones will use encoded ones.  But is that a sensible thing to do?
How would we guarantee that existing submodules' vanilla names would
not collide with encoded submodules' names?  We haven't seen the
encoded names yet, but I think I saw some mention of URL encoding.

So if I had a submodule whose name is "%41%42%43", set this
configuration because I do not want it treated as URL-encoded, then
enable the extension, and then later add a separate submodule whose
name is "ABC", which may be encoded (remember use of "ABC" here is
only for illustration; replace it with something that do need
encoding if you want a more realistic example) to the same
"%41%42%43".

If that kind of situation is what this new configuration allows, I
do not quite see why it is a good idea to have such a thing.

> Based-on-patch-by: Brandon Williams <bmwill@google.com>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
>  Documentation/config/submodule.adoc   |  4 ++++
>  builtin/submodule--helper.c           | 17 +++++++++++++++++
>  submodule.c                           | 12 ++++++++++++
>  t/lib-verify-submodule-gitdir-path.sh | 20 ++++++++++++++++++++
>  t/t7400-submodule-basic.sh            |  9 +++++++++
>  t/t9902-completion.sh                 |  1 +
>  6 files changed, 63 insertions(+)
>  create mode 100644 t/lib-verify-submodule-gitdir-path.sh
>
> diff --git a/Documentation/config/submodule.adoc b/Documentation/config/submodule.adoc
> index 0672d99117..8f64adfbe3 100644
> --- a/Documentation/config/submodule.adoc
> +++ b/Documentation/config/submodule.adoc
> @@ -52,6 +52,10 @@ submodule.<name>.active::
>  	submodule.active config option. See linkgit:gitsubmodules[7] for
>  	details.
>  
> +submodule.<name>.gitdir::
> +	This option sets the gitdir path for submodule <name>, allowing users
> +	to override the default path or change the default path name encoding.
> +
>  submodule.active::
>  	A repeated field which contains a pathspec used to match against a
>  	submodule's path to determine if the submodule is of interest to git
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 2873b2780e..abd20eee53 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1208,6 +1208,22 @@ static int module_summary(int argc, const char **argv, const char *prefix,
>  	return ret;
>  }
>  
> +static int module_gitdir(int argc, const char **argv, const char *prefix UNUSED,
> +			 struct repository *repo)
> +{
> +	struct strbuf gitdir = STRBUF_INIT;
> +
> +	if (argc != 2)
> +		usage(_("git submodule--helper gitdir <name>"));
> +
> +	submodule_name_to_gitdir(&gitdir, repo, argv[1]);
> +
> +	printf("%s\n", gitdir.buf);
> +
> +	strbuf_release(&gitdir);
> +	return 0;
> +}
> +
>  struct sync_cb {
>  	const char *prefix;
>  	const char *super_prefix;
> @@ -3591,6 +3607,7 @@ int cmd_submodule__helper(int argc,
>  		NULL
>  	};
>  	struct option options[] = {
> +		OPT_SUBCOMMAND("gitdir", &fn, module_gitdir),
>  		OPT_SUBCOMMAND("clone", &fn, module_clone),
>  		OPT_SUBCOMMAND("add", &fn, module_add),
>  		OPT_SUBCOMMAND("update", &fn, module_update),
> diff --git a/submodule.c b/submodule.c
> index 35c55155f7..7a2d7cd592 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -2604,6 +2604,18 @@ void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
>  	 * administrators can explicitly set. Nothing has been decided,
>  	 * so for now, just append the name at the end of the path.
>  	 */
> +	char *gitdir_path, *key;
> +
> +	/* Allow config override. */
> +	key = xstrfmt("submodule.%s.gitdirpath", submodule_name);
> +	if (!repo_config_get_string(r, key, &gitdir_path)) {
> +		strbuf_addstr(buf, gitdir_path);
> +		free(key);
> +		free(gitdir_path);
> +		return;
> +	}
> +	free(key);
> +
>  	repo_git_path_append(r, buf, "modules/");
>  	strbuf_addstr(buf, submodule_name);
>  }
> diff --git a/t/lib-verify-submodule-gitdir-path.sh b/t/lib-verify-submodule-gitdir-path.sh
> new file mode 100644
> index 0000000000..3a83f2d975
> --- /dev/null
> +++ b/t/lib-verify-submodule-gitdir-path.sh
> @@ -0,0 +1,20 @@
> +# Helper to verify if repo $1 contains a submodule named $2 with gitdir path $3
> +
> +# This does not check filesystem existence. That is done in submodule.c via the
> +# submodule_name_to_gitdir() API which this helper ends up calling. The gitdirs
> +# might or might not exist (e.g. when adding a new submodule), so this only
> +# checks the expected configuration path, which might be overridden by the user.
> +
> +verify_submodule_gitdir_path() {
> +	repo="$1" &&
> +	name="$2" &&
> +	path="$3" &&
> +	(
> +		cd "$repo" &&
> +		cat >expect <<-EOF &&
> +			$(git rev-parse --git-common-dir)/$path
> +		EOF
> +		git submodule--helper gitdir "$name" >actual &&
> +		test_cmp expect actual
> +	)
> +}
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index fd3e7e355e..11c84a7bdf 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -13,6 +13,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  
>  . ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-verify-submodule-gitdir-path.sh
>  
>  test_expect_success 'setup - enable local submodules' '
>  	git config --global protocol.file.allow always
> @@ -1505,4 +1506,12 @@ test_expect_success 'submodule add fails when name is reused' '
>  	)
>  '
>  
> +test_expect_success 'submodule helper gitdir config overrides' '
> +	verify_submodule_gitdir_path test-submodule child modules/child &&
> +	test_config -C test-submodule submodule.child.gitdirpath ".git/modules/custom-child" &&
> +	verify_submodule_gitdir_path test-submodule child modules/custom-child &&
> +	test_unconfig -C test-submodule submodule.child.gitdirpath &&
> +	verify_submodule_gitdir_path test-submodule child modules/child
> +'
> +
>  test_done
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 964e1f1569..ffb9c8b522 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -3053,6 +3053,7 @@ test_expect_success 'git config set - variable name - __git_compute_second_level
>  	submodule.sub.fetchRecurseSubmodules Z
>  	submodule.sub.ignore Z
>  	submodule.sub.active Z
> +	submodule.sub.gitdir Z
>  	EOF
>  '
