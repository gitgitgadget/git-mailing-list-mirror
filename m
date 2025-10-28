Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6EA24DFF9
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 15:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761664970; cv=none; b=TL91M8DkLW1MZdj3mcHr9VjAVzZuhUwgDAoQY96q28gJtLgR/o7ukhI79XtMqkTSDUUQPE7FzA68kgHY7W/WpH2Ya05D6ExjIMyfMLnsc2uD983NJ5oxvV5LE6xqB0fBWm334PRU+OY0/Atg/WzHQhnno1Np1LZ0F4Jj7TJCQ6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761664970; c=relaxed/simple;
	bh=sqjFBGnnHEgVvswHeHhfErbztB4mJkPMG5XsN+JQiCU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JXTS8m8qQekbL5dT3sHDvg86VrMLSb46acJ1yhVI3+vhte8JvnCkccbbrI3qiMZoOhKsJHcNzkgSj4yPooXU1cuZjbzyrwo3d9cLRp5n+FKf9wqep0ObT0Tp5vWkOvaphorbE49UfYh4On0zVPfg7T8HrFNaPYlcmCMnmkdJNSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ljl5/a49; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QDbRNduU; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ljl5/a49";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QDbRNduU"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 6E467EC0357;
	Tue, 28 Oct 2025 11:22:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 28 Oct 2025 11:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761664966; x=1761751366; bh=CyZe2/ZEXN
	KyfSBk8qFWIvdpNL51z64W446zJuV+h2Q=; b=Ljl5/a49e1b1VkJbybkWznmzHL
	3g4N+JLcEq1rvxp3RVwVOw9by3tLJ+08RdwRMaa/b47srPxG0OY2lBfIIdkIZyrk
	T1IEAmebBEAmWxJve8VQier75NQen9viOP3+p2XBsEXFuNK1ScNwzxlywYE6H8+C
	zUtBp6EMHUzt8PkUO/OsXkvlEVHNJUj18clB9Gw0zry88jaQaczAG78uhwxjvYi+
	OrBzyYBYvT9oeISqRMkuVMbV4nwmYEDg92/fDoWIS7M/eREghKTg+3v2vHi2nA5r
	9oKc3MuemAcL+fmXrjzUIkXB3lj6TL5OeYEElgtc4STR6P1vRQi+vktq8VAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761664966; x=1761751366; bh=CyZe2/ZEXNKyfSBk8qFWIvdpNL51z64W446
	zJuV+h2Q=; b=QDbRNduUS0/eUPvF5KHhUPCAbB/1tvXcn1BkIp6oXoZydJxV26l
	lTwroLX6tRIUlA3woKJSx2QgiH+GBv+QytqgzIeqxQNvJm41nZSBGY6oMLaV50Uj
	w/EaWvc8CzUM7mDzUP4DK6VTckI2wzgKi5d5nZ72pEFAanD/wm3serrs9ffHTZc0
	YcdlBSUlC8ZZ/cB15GFL+I8csjiSjYdFUm3aTIssQqdISFIJmQbJMUlM75QSzwhl
	++hFyETrsBcNiE12afYYcuhk4o3RA0PMz8IE/JzfMA+xB4tmBQhZi1Ip5FvXOQcB
	py16Y+aYBguBPLPcF/S7WSeoJhj8Bzsn/LQ==
X-ME-Sender: <xms:xt8AaRLVLRZe7F5eQDBs6d53cwZc4O4KGUO9SL0-XmXpTHXH_yJ1-A>
    <xme:xt8AaQ0m-54-cW33WaXQu54eICuLrWGIxRg74t7HJQJlWisoTt8RRnqZq3-P-iWXK
    peh_UUXB8HofNU_ZhajocrAAKpZ9PgMW30isw3VXsuJNdSHTQ23>
X-ME-Received: <xmr:xt8AaTg83veOWTiWl8cdOzeEAB0aKMb863WJS-69Lnqt6AEckI6dd0dQlQBvxzlIu3sr2ObFYUvkdi5SN1k5LSlQJgtlq7EnYdYu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieduvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdp
    rhgtphhtthhopegrnhhtohhnihhnseguvghlphgvuhgthhdrvghupdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:xt8AaZVjRytod5YByjoy2bYsagE8Xqxju7XiHlvieFsskUBrfWS-zA>
    <xmx:xt8AaaUTr_pLy0GFRkrkq1NlBKYPkg9VnzU9jVkdvuWlmuV2QsMR5w>
    <xmx:xt8AaRi6fcn4G6dcuoDOLA4Mbs3ZMqMOWaH2tsic61ltswXWxzjRFA>
    <xmx:xt8AadZC4isdEQZ43-c60-73nQrPulq2wRV2yCQJcMNczA_0NaK_Gw>
    <xmx:xt8AaQWR0dU-KApuW4X6FQ9EjkpfjABa4HLP_Xv2JkEit68JbAcAfNyX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 11:22:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Antonin Delpeuch <antonin@delpeuch.eu>
Subject: Re: [PATCH v2] blame: make diff algorithm configurable
In-Reply-To: <pull.2075.v2.git.git.1761658643278.gitgitgadget@gmail.com>
	(Antonin Delpeuch via GitGitGadget's message of "Tue, 28 Oct 2025
	13:37:23 +0000")
References: <pull.2075.git.git.1760972162827.gitgitgadget@gmail.com>
	<pull.2075.v2.git.git.1761658643278.gitgitgadget@gmail.com>
Date: Tue, 28 Oct 2025 08:22:44 -0700
Message-ID: <xmqqjz0fdpa3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Antonin Delpeuch <antonin@delpeuch.eu>
>
> The diff algorithm used in 'git-blame(1)' is set to 'myers',
> without the possibility to change it aside from the `--minimal` option.

Hmph.  It is very unfortunate that we had --minimal already.  We
should have done --diff-algorithm=<which> instead, but that is way
too late.

> There has been long-standing interest in changing the default diff
> algorithm to "histogram", and Git 3.0 was floated as a possible occasion
> for taking some steps towards that:
>
> https://lore.kernel.org/git/xmqqed873vgn.fsf@gitster.g/

Micronit.  I think the reference to 3.0 only about potentially
breaking backward compatibility by making the family of diff-*
plumbing commands ignore diff.algorithm configuration, and other
usability changes like this one are fair game without having to wait
for 3.0 boundary (the plumbing commands do ignore the configuration
already, so there is nothing we have to wait 3.0 before doing).

>     Changes since v1:
>     
>      * add tests
>      * ignore --diff-algorithm when it is provided before --minimal

Sensible.

I presume the reverse is true, i.e. giving "--minimal" and then
"--diff-algorithm=histogram" in this order would make "histogram"
survive, in other words, the usual "last one wins" rule is applied?

> +static int blame_diff_algorithm_minimal(const struct option *option,
> +					const char *arg, int unset)
> +{
> +	int *opt = option->value;
> +
> +	BUG_ON_OPT_NEG(unset);
> +	BUG_ON_OPT_ARG(arg);
> +
> +	*opt &= ~XDF_DIFF_ALGORITHM_MASK;
> +	*opt |= XDF_NEED_MINIMAL;
> +
> +	return 0;
> +}

This and diff.c:diff_opt_diff_algorithm_no_arg(), which I think is
the original from which this was copied from, look somewhat
different, but this can afford to be simpler, as it does not have to
parse "--histogram", "--patience", etc., as independent command line
options.  OK.

> +static int blame_diff_algorithm_callback(const struct option *option,
> +					 const char *arg, int unset)
> +{
> +	int *opt = option->value;
> +	long value = parse_algorithm_value(arg);
> +
> +	BUG_ON_OPT_NEG(unset);
> +
> +	if (value < 0)
> +		return error(_("option diff-algorithm accepts \"myers\", "
> +			       "\"minimal\", \"patience\" and \"histogram\""));
> +
> +	*opt &= ~(XDF_NEED_MINIMAL | XDF_DIFF_ALGORITHM_MASK);
> +	*opt |= value;
> +
> +	return 0;
> +}

Quite straight-forward and sensible.

>  static int is_a_rev(const char *name)
>  {
>  	struct object_id oid;
> @@ -915,10 +960,17 @@ int cmd_blame(int argc,
>  		OPT_BIT('s', NULL, &output_option, N_("suppress author name and timestamp (Default: off)"), OUTPUT_NO_AUTHOR),
>  		OPT_BIT('e', "show-email", &output_option, N_("show author email instead of name (Default: off)"), OUTPUT_SHOW_EMAIL),
>  		OPT_BIT('w', NULL, &xdl_opts, N_("ignore whitespace differences"), XDF_IGNORE_WHITESPACE),
> +		OPT_CALLBACK_F(0, "diff-algorithm", &xdl_opts, N_("<algorithm>"),
> +			       N_("choose a diff algorithm"),
> +			       PARSE_OPT_NONEG, blame_diff_algorithm_callback),
>  		OPT_STRING_LIST(0, "ignore-rev", &ignore_rev_list, N_("rev"), N_("ignore <rev> when blaming")),
>  		OPT_STRING_LIST(0, "ignore-revs-file", &ignore_revs_file_list, N_("file"), N_("ignore revisions from <file>")),
>  		OPT_BIT(0, "color-lines", &output_option, N_("color redundant metadata from previous line differently"), OUTPUT_COLOR_LINE),
>  		OPT_BIT(0, "color-by-age", &output_option, N_("color lines by age"), OUTPUT_SHOW_AGE_WITH_COLOR),
> +		OPT_CALLBACK_F(0, "minimal", &xdl_opts, NULL,
> +			       N_("spend extra cycles to find better match"),
> +			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
> +			       blame_diff_algorithm_minimal),
>  		OPT_BIT(0, "minimal", &xdl_opts, N_("spend extra cycles to find better match"), XDF_NEED_MINIMAL),

This OPT_BIT() can stay here?  I thought parse_options_check() was
capable of detecting duplicated long-form commands as programming
error, but apparently it does not.  (#leftoverbits) We should look
into teaching parse_options_check() to check duplicated option
names.

>  		OPT_STRING('S', NULL, &revs_file, N_("file"), N_("use revisions from <file> instead of calling git-rev-list")),
>  		OPT_STRING(0, "contents", &contents_from, N_("file"), N_("use <file>'s contents as the final image")),
> ...
> +test_expect_success 'blame honors --minimal option' '
> +	cat >expected <<-\EOF &&
> +	Initial
> +	Initial
> +	Initial
> +	Second
> +	Second
> +	Second
> +	Second
> +	Initial
> +	Second
> +	Second
> +	Second
> +	EOF
> +
> +	git blame file.txt --minimal | \
> +		grep --only-matching -e Initial -e Second > actual &&
> +	test_cmp expected actual
> +'

Do we need to test combination of configuration variables and
command line options (to verify that options trump configuration),
or two command line options (to verify that the last one wins)?

When xdiff/ part of the system gets improved, the above expected
patterns may have to change, these tests may fail.  Whoever updates
the diff algorithm to cause such a failure has to tell between a
genuine _bug_ in their update to diff implementation and the test
expecting a suboptimal result based on the behaviour of the diff
algorithm before their improvement.  And for that, they need to
debug these tests.  But I suspect that these tests will probably be
very difficult to debug, as it is almost impossible to see which
line in the original each of these lines correspond to.

I guess that's inevitable, and we'll cross that bridge when it
becomes necessary.

Thanks, will queue, but I do find the leftover --minimal bit
disturbing.


