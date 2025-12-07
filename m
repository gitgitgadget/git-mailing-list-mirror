Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04914257830
	for <git@vger.kernel.org>; Sun,  7 Dec 2025 22:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765145645; cv=none; b=FSOcAefnxueWhaWCna5lJ61k+nsFUzzvvEfiJuuvNXmZaQVo/4KTa0zcckW1vFuMtRWmuP6kkY0iayVjhI2ieIUb9oBuwk854P1fuFrm+T5APvDZq58ZF1QSAkWL2aUv+JNUzC4zFvjX64M35DsO+rF0YYXwNeYrz7CcdYrNhg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765145645; c=relaxed/simple;
	bh=3hbPirOdmIQH+AbLWamcZBJDZcNEdrBq0ltM9ow/J1I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XSwv0OCzM5xA12VR/nDhcLD0DnfspHbp6Y1u7DCUOm1LbPZ2lmWsJjbhKoW+WycZn2DCKiWjPhLobqMH/7aPIuh4FRqKEehCs/Wn4pgC96ruMYnIaKjaKbQc8A7ybhGn1Mzm0Y8nztyXW//wqLctvQY/A/J7T9PODVsIqsOecNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iyVBf24Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=spmEHSCo; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iyVBf24Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="spmEHSCo"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 216D51D0017A;
	Sun,  7 Dec 2025 17:14:02 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Sun, 07 Dec 2025 17:14:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765145641; x=1765232041; bh=5Oesd8qXC6
	BJHP4coqs6SxeSF0QimSGEAfijuIEExwA=; b=iyVBf24Q4GFKeXieTNMIO2k0u7
	Nu+pGG6IH0ASFj6yxMpnj57nkLcD4jqynoYf+Msqtd0Fdi7qcnW5rFWfMm9FUTsm
	HBFqEZvlMlVb0GkERM5SOdZaTVXYqw1NT1IAQC3wEd0mG+Ya6kK44G23XJOGhgmr
	p47CI+xyzOqD9y6HZE/y1ahESS5qCi8/jq4hmuCljXifFwLYF+rHpC5cyiT7p+15
	ppfWGRgPNxb8eMzx21qfoCC1RNu81CQ6aFTsu6e+bX+TxVargZLlLzZLb7pJQ3T7
	ut7S9xiTTkpME/Xc8e9z+EaCLgxgZBR2uRuKocmO6+8TC4JPpkez3kSi/BDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765145641; x=1765232041; bh=5Oesd8qXC6BJHP4coqs6SxeSF0QimSGEAfi
	juIEExwA=; b=spmEHSCoRSLBOg566A1bmdQE7SmXlYcrogZYpmQfdjU9pErOdSs
	VuiV0Qso+6TpaMiHWCqnRBfXI4fSE7At96bS/+qz3UZl2n5T55HYnChdaq1ZaXdd
	LPPmzWeZlx4ws5NY8/Im70GUV4JJgVLpkLmuQKfaA3pClWQ5/aVeM3+RlfdfBL7Q
	w8LJ1O9jcQVXK8EBkMKbv6B/92EwlW5dKk6qsiJigmd/gAeOd224MilGwuxNRoml
	vaPYYcl8fWjAXzS6ObXfBEI00N1j51UBKgsD3ADw9xxQwSG4rU4WppqTjdtqG6Mi
	rGIKq866exYIMZZ9CxT4My2k/s9jsKjgssQ==
X-ME-Sender: <xms:Kfw1aba6V1ijFHBeyVHuLHo2s0sp2vh-3FU0J6ER5Tk6uOxl9YWZEg>
    <xme:Kfw1aR37sxRNCXGhXeLSJUzbMcDmB3hdk15DgFGuKTyByKGrtQkNuAMLLe7mmGn1w
    j9HArHhnRXvR1EtiUBS5Qcc8djgdItc4tDDRpjNMxjDpDzfY0GKGko>
X-ME-Received: <xmr:Kfw1abUBeF2bBHTh8AFw33Eh5P2s5yaclso-jJF-_psNjWnqlp1OhX6j4BpBHx-2ayFuFc-JkVWALCl0rOcLyNxkQqSoJAl5OQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Kfw1abXbRw_MaBIfw-gMk_TqorEOqvrO4C0DaMxzeun9wBrv9lz3Tg>
    <xmx:Kfw1aaelOvyhZzI39lGeNNhCvsLfjUDuR6bGK9h9AJFNAY8qG0mGoA>
    <xmx:Kfw1aUUTUqjYrLa7Uqb-q0OVsxH03m2v6j__46AbFGrd1XQu2_fAyA>
    <xmx:Kfw1aTc8sW9gR3JCxXmIk6n9Rv00l2z3ppGVUGPhIpt9rlxZNyoFRQ>
    <xmx:Kfw1aZ3LQkpH1lP1twEdjnFbsVCf9aDG77iA-j1DQxldrfR-2DcOWTfY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Dec 2025 17:14:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] repo: add new flag --keys to git-repo-info
In-Reply-To: <20251207190532.67107-1-lucasseikioshiro@gmail.com> (Lucas Seiki
	Oshiro's message of "Sun, 7 Dec 2025 16:02:10 -0300")
References: <20251207190532.67107-1-lucasseikioshiro@gmail.com>
Date: Mon, 08 Dec 2025 07:14:00 +0900
Message-ID: <xmqqqzt6kkif.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Currently, if the user wants to find what are the available keys,
> they need to either check the documentation or to ask to all the
> key-value pairs by using --all.
>
> Add a new flag --keys for listing only the available keys without
> listing the values.

We do not need to say "Currently," but other than that the above is
very well written.  Easy to grok and to the point.

>  [synopsis]
>  git repo info [--format=(keyvalue|nul) | -z] [--all | <key>...]
> +git repo info --keys
>  git repo structure [--format=(table|keyvalue|nul) | -z]

So "git repo info --keys --all" or "git repo info --keys --format=..."
is not supported.  Does the implementation behave sensibly when given
such nonsense commands?  Let's see.

> @@ -170,6 +181,7 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
>  {
>  	enum output_format format = FORMAT_KEYVALUE;
>  	int all_keys = 0;
> +	int show_keys = 0;
>  	struct option options[] = {
>  		OPT_CALLBACK_F(0, "format", &format, N_("format"),
>  			       N_("output format"),
> @@ -179,10 +191,15 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
>  			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
>  			       parse_format_cb),
>  		OPT_BOOL(0, "all", &all_keys, N_("print all keys/values")),
> +		OPT_BOOL(0, "keys", &show_keys, N_("show keys")),
>  		OPT_END()
>  	};
>  
>  	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
> +
> +	if (show_keys)
> +		return print_keys();
> +
>  	if (format != FORMAT_KEYVALUE && format != FORMAT_NUL_TERMINATED)
>  		die(_("unsupported output format"));

OK, so it is:

    "git repo info --all --keys" and "git repo info --keys layout.bare"
    both behave as if "git repo --keys" was given, ignoring
    everything else.

Shouldn't "--keys" be explicitly marked incompatible with "--all"
and remaining keys in argc/argv[]?

While there is no strong reason why anybody must use NUL-terminated
output format, simply because repo_info_fields[] contains no tokens
with strange byte values, but just as principle, shouldn't

    "git repo info --keys -z"

do what is naturally expected?

Perhaps

	if (format != ...)
		die(_("unsupported output format"));

	if (show_keys && (all_keys || argc))
		die(_("--keys cannot be used with a <key> or --all"));

	if (show_keys)
		return print_keys(output_format);

with a trivial update to print_keys() to support NUL-terminated
records, instead of puts()?
