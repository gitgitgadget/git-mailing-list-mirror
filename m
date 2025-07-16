Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184601EF0B9
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 20:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752698017; cv=none; b=TenWQZ83sl1q6DKTtGG4Q4KygntjLYNLfDgfK2G+BCDnL6Vl/BHal1DohjzC+8I1cYQKbPYMkJ+/D0D8XRotFV8hmfDQHPeNj5ytuEh8Y/NKDQs24XoUvkgf9ZHzf2StNR1bd5TlGiItWfsShtgHi23A4CuMJUSC6LfGOb1TuaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752698017; c=relaxed/simple;
	bh=HRVVUfJOE0zvsVLvLoKQZSiA8g/wMScTNoCjZmwXwUI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W07tSCSI1IKLvhcvcFWPH7xjNjpo70jJZmpHB7mIbtURJiiAeJ4iL4IfWFDuzwUQJzq/H98+mOPRvCCBTdVBigGUAG0N4qj+EqRSzYkXVvjWymFH3m/kcJOm4djIBtj7lYfH8WQi4KJMZOSmjiSnByGEEfUJv6Wgnn+f5/aZyk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=luzoS7MO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C+ybNIvi; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="luzoS7MO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C+ybNIvi"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 033C41D000A3;
	Wed, 16 Jul 2025 16:33:32 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 16 Jul 2025 16:33:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752698012; x=1752784412; bh=dID6cMZ18t
	9TYCX/DrOsFPsf1aCU6ul9YtVMNeri9Ms=; b=luzoS7MOp7d1PE03+gMk+zpmCn
	TbBoefgIQi0qrurV8JYnXGQXsRxttJInpzdJJ1dZ3JW3Au8nQoZ/gmTDhrSakje1
	ZtvbF2xeycsjkPDscUlViTeo83X4LTaCOflJnRIMQ+GiIzNKT6uZzrJWbJ+TQOO0
	HTXC04W0tzbUaruBThdisKSugus1EFh3lmHa3pASKX+2gLiYo/zbwb6vrgg9B/mb
	3fsPvj83gkWWm//wshgrOzz/EntbvW9O24cIL1rzDUpTeMwbLdFhf3SOeXlRjXMV
	4uEi+fzbbKW35hZxA+Mxf1hrjXk4i3yd7L9bnHL5CURQCL4buk79BpPBS0Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752698012; x=1752784412; bh=dID6cMZ18t9TYCX/DrOsFPsf1aCU6ul9YtV
	MNeri9Ms=; b=C+ybNIvi2EkgPQX4t61KY99gHqq0nxSsem9eXR2wz7hTIt9Zksy
	gnezfUaaSwOywe9RHAIWNvGU3Bx0AJ7xqcP8kTU2PLrycGxYhhQumrs+Xu9oWEPF
	RXLAvDvr+O+NDFDxe/R/VzN+PXsdSRyuyr/+4QVEbAhCt4C/ajAf0V/U3FCP/f9g
	15PndfYHulv2iGfIRVCIeK3FdjPpLrwGw5BkI/GHlAUpChnLnWBLjvdUKj8UpoPX
	HjuF0dvZHrWBd9qPiM/uFUgAl8HM8QM0GSMWVOTNS8yTr9Xpv/26N1Fk8qEKjHS2
	pz38KivA02MGp7EJSucy6Dmr8pDIqFU5iCA==
X-ME-Sender: <xms:mwx4aC_GGs2yCokpSOoao-S1U6dJoZO5BMWdz3sN3InT5BLSrthrUg>
    <xme:mwx4aH4qBwDzalANdnRwB76LKkwRbvoJGJ_6YKXmq6Hy1Bfi1m4Jbh0HW1aMpnYNh
    Tzsd6rRWmxt9_Krfg>
X-ME-Received: <xmr:mwx4aI5JGsRES4gnCaZBma7nt2VMH-cxiOj2ZspMFjPUmp77Rj8oYluQfBodr5BAEMnzcrUqs5GyAe6VRPFEYCU3LxN8CR7sakMwV0k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehkeeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeegkeevtdeiveekteejteehtedvtdehtddvvedvffffgeeftdevieeifefgveeu
    vdenucffohhmrghinheprhgvphhordgtfienucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehluhgtrghssh
    gvihhkihhoshhhihhrohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdr
    khhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:nAx4aAo28pJQf_pcBR0YG-tZA1C8lUAJvpM3F8jEDI0SrAgMrpVo4Q>
    <xmx:nAx4aJPemd3Vxmm70ftRbVWyx5fMa93oF1AqPJYJzUHMS_IRlUirnQ>
    <xmx:nAx4aI2rHcn-8VNTvQwdP9a0m1lzCNobIL2Tzhvf0H9Cbd8Hqj00iQ>
    <xmx:nAx4aIBuS8PHjiJnMT3_bBaXo6Ak5lrhq0rAsQjD7q9ph5smynpPeA>
    <xmx:nAx4aEpU6bkAchEVH2_4C_GpNWSQnHS5Yh0ihjHFtBDeMFJRuURyYoV_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 16:33:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  karthik.188@gmail.com,
  ben.knoble@gmail.com,  phillip.wood@dunelm.org.uk,  jltobler@gmail.com
Subject: Re: [GSoC RFC PATCH v4 0/4] repo: add new command for retrieving
 repository info
In-Reply-To: <xmqq7c07c2fu.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	16 Jul 2025 13:20:53 -0700")
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
	<20250714235231.10137-1-lucasseikioshiro@gmail.com>
	<xmqq7c07c2fu.fsf@gitster.g>
Date: Wed, 16 Jul 2025 13:33:30 -0700
Message-ID: <xmqqjz47anad.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> The below is from 
>
>     $ git clang-format --diff $(git merge-base master HEAD) -- builtin/repo.c
>
> I removed some obviously bad suggestions but many were improvements.
>
> I'll follow this message up as if I were reviewing what clang-format
> produced.
>
> Thanks.
>
>
>  builtin/repo.c | 47 ++++++++++++++++++++---------------------------
>  1 file changed, 20 insertions(+), 27 deletions(-)
>
> diff --git c/builtin/repo.c w/builtin/repo.c
> index d75417a48b..e8cf465da6 100644
> --- c/builtin/repo.c
> +++ w/builtin/repo.c
> @@ -14,27 +14,23 @@ struct field {
>  	add_field_fn *add_field_callback;
>  };
>  
> -static void add_string(struct strbuf *buf,
> -		       const char *key, const char *value)
> +static void add_string(struct strbuf *buf, const char *key, const char *value)
>  {
>  	strbuf_addf(buf, "%s\n%s%c", key, value, '\0');
>  }
>  
> -static void add_bool(struct strbuf *buf,
> -		     const char *key, const int value)
> +static void add_bool(struct strbuf *buf, const char *key, const int value)
>  {
>  	const char *output_value = value ? "true" : "false";
>  	strbuf_addf(buf, "%s\n%s%c", key, output_value, '\0');
>  }
>  
> -static void add_references_format(struct strbuf *buf,
> -				  struct repository *repo)
> +static void add_references_format(struct strbuf *buf, struct repository *repo)
>  {
>  	add_string(buf, "references.format",
>  		   ref_storage_format_to_name(repo->ref_storage_format));
>  }

If the parameter list fits on a single line not just helps readers
of a code who reads from top to bottom, but those who run "grep" for
the function name.

>  
> -
>  static void add_layout_bare(struct strbuf *buf, struct repository *repo UNUSED)
>  {
>  	add_bool(buf, "layout.bare", is_bare_repository());

No reason to give double-blank between these two functions; it is
not like add_string/bool/references/format are closer together than
this add_layout_bare

> @@ -45,11 +41,11 @@ static void add_layout_shallow(struct strbuf *buf, struct repository *repo)
>  	add_bool(buf, "layout.shallow", is_repository_shallow(repo));
>  }
>  
> -// repo_info_fields keys should be in lexicographical order
> +/* repo_info_fields keys should be in lexicographical order */

We don't do // comments

>  static const struct field repo_info_fields[] = {
> -	{"layout.bare", add_layout_bare},
> -	{"layout.shallow", add_layout_shallow},
> -	{"references.format", add_references_format},
> +	{ "layout.bare", add_layout_bare },
> +	{ "layout.shallow", add_layout_shallow },
> +	{ "references.format", add_references_format },
>  };

Spaces are used inside {braces} like the above.

>  static int repo_info_fields_cmp(const void *va, const void *vb)
> @@ -60,12 +56,13 @@ static int repo_info_fields_cmp(const void *va, const void *vb)
>  	return strcmp(a->key, b->key);
>  }
>  
> -static add_field_fn *get_append_callback(const char *key) {
> -	const struct field search_key = {key, NULL};
> -	const struct field *found = bsearch(&search_key, repo_info_fields,
> -					    ARRAY_SIZE(repo_info_fields),
> -					    sizeof(struct field),
> -					    repo_info_fields_cmp);
> +static add_field_fn *get_append_callback(const char *key)
> +{

"{" opening and "}" closing braces around a function body sit on
their own line alone without anybody else.  This is unlike the
multi-statement blocks in control structures (e.g. opening brace for
the block executed when condition holds in "if (cond) {" comes after
the closing parenthesis ")" for the condition after a SP on the same
line).

> +	const struct field search_key = { key, NULL };

Use of spaces inside brace pair again.

> +	const struct field *found =
> +		bsearch(&search_key, repo_info_fields,
> +			ARRAY_SIZE(repo_info_fields), sizeof(struct field),
> +			repo_info_fields_cmp);
>  	return found ? found->add_field_callback : NULL;
>  }
>  
> @@ -77,7 +74,8 @@ static int qsort_strcmp(const void *va, const void *vb)
>  	return strcmp(a, b);
>  }
>  
> -static void print_fields(int argc, const char **argv, struct repository *repo) {
> +static void print_fields(int argc, const char **argv, struct repository *repo)
> +{

Ditto.

>  	const char *last = "";
>  	struct strbuf buf;
>  	strbuf_init(&buf, 256);
> @@ -107,19 +105,14 @@ static void print_fields(int argc, const char **argv, struct repository *repo) {
>  	strbuf_release(&buf);
>  }
>  
> -static int repo_info(int argc,
> -		     const char **argv,
> -		     const char *prefix UNUSED,
> +static int repo_info(int argc, const char **argv, const char *prefix UNUSED,
>  		     struct repository *repo)
>  {
> -
> -	print_fields(argc - 1 , argv + 1, repo);

Extra SP before ",".

> +	print_fields(argc - 1, argv + 1, repo);
>  	return 0;
>  }
>  
> -int cmd_repo(int argc,
> -	     const char **argv,
> -	     const char *prefix,
> +int cmd_repo(int argc, const char **argv, const char *prefix,
>  	     struct repository *repo)
>  {
>  	parse_opt_subcommand_fn *fn = NULL;
