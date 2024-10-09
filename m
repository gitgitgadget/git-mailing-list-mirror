Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A4D188925
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 22:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728511299; cv=none; b=SRFRFpdA5FeRNJV6sS3goUM+5SnkXn9LTOSsktIvAjGKKyVbJcOm4sF0CK2f5+6ILARhVFccaoUTbcuk/IVv67cOq4Ni6rim9Q8DKn9Q1TqAMwN0izuqKF734BwkMOuPTeBKb1D7928o6SgMPb2yn8zMMY7SNSp5/5dYnoRycA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728511299; c=relaxed/simple;
	bh=Bg/eObximUTcXLdxv+wZLKH6+M2gV9cMLh/3Nb+5U3E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qQPELV/7i8FZY1LOFTNKjvh2hTAceJAQNwBEM5liGmbCJiuokTZ1ZU+y61lNCThRyYj3BO26kdrznLt03nKz+UC8rpg9Ob5wSDlqhJr2ZR9vP0l0IDAKt2RH5Jrna476kHfdEIvYJ+UPNwCGaEsEzVQLQtOx7sOcInM9LfDU7DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tqrXYlOu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kCW67Nhc; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tqrXYlOu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kCW67Nhc"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EE3441140167;
	Wed,  9 Oct 2024 18:01:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Wed, 09 Oct 2024 18:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728511295; x=1728597695; bh=OkovUagnQ1
	16j1h0jKboUJ4pVbFu79xFq4emYNqxiYY=; b=tqrXYlOuGqVO2aTWEsSib9aLoP
	BaT4dp8oYJnv3qtPrfhN9oPL0ZGoxOpoyklqu3tsSPUIsa6bDaJqP8H4mhBe9g4s
	h/ZahpJC9M174pnbUs2A1rwKNqQi2/25PZViiemwMpy0CZfnxEObU8NNi4rD9xXf
	9Uc/72X3KFqICR0FwB3SfAU+8C7gMOTGryUa5IVsxxNMXB7LfC9y4F4dPG4XwgT0
	4J1ddr8Q4AYEZRTyjCpsuPvkar4TtO0wMuZVdtiIZiP/gA7WUGQar+nL/aQeWFq2
	+EwHS59cwUcFRGP8mVZ9VOKv1sMhVm05oaQtWVp2BhKezKhC+COB3CVLvHdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728511295; x=1728597695; bh=OkovUagnQ116j1h0jKboUJ4pVbFu
	79xFq4emYNqxiYY=; b=kCW67Nhckwk9InsKeDyxQUnJp0jDGKzW+LCBsFDXgElk
	xmIP3cVSOpcQS8XXU0KcxYwXSzPL5ZcLYLhFaPlz72dsElvfrDdfBveB6B2742ml
	VcjFEaEh2hI0elUjuUkNRcMXl5RWn3PFA8oIQLbip4Cvt+xRmVWnmKck165KsTNr
	xf2+03aw2eo5Ohcp7bFt8UTAx9T0sWSBwXoGbDWTRdTggEjl3sZTfsHppmTLrMBh
	g82ltBvF/icxjgnpzRZcJkgR22cgOgvBJS04zOXh8rTziD3ku6tgusXkvWXyFZY9
	9VefNSY5vBnYYwa/NW3QdRBwjRwNU1bMPxTLeb782A==
X-ME-Sender: <xms:P_0GZ9T-s2mGvCvQPipA3P2pF9gWZvvNGhQH9jV7xpHrXO6YyGifDg>
    <xme:P_0GZ2wU_MOx6qvAqk0OL8hAZnZXUhHkjyTX0c19vILlGp7lcZ7Xo0hUIy39tYyo0
    Da-2UEQwpvZbgvdSg>
X-ME-Received: <xmr:P_0GZy0Snl8LWNWtuiFj4a_VXOf5ijZchw-BFTMUIyMzbPj_I6kY5hFSA_1Ba41NHQnQf4vu6pUk0N21sOkDWOd91rX3jSKJ7KV3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefgedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeei
    vddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvnhgtvgesfhgvrh
    guihhnrghnugihrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrd
    hukhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoheplhdr
    shdrrhesfigvsgdruggvpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlh
    hinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:P_0GZ1CXAce1QJf25YewZ3CdoZGRPafHNLdMGtuCM0ngXIByQ9-pjA>
    <xmx:P_0GZ2gRo0MEPeLgA4MuKx8YDu_B6zQGnb1FiIx2e23uHwYwWJ1N-Q>
    <xmx:P_0GZ5p12AotCylExGTue72fqO2TxU26iFxNHTvQBqDdXcPSdwG8Aw>
    <xmx:P_0GZxgAaID0eLrFR-hUR9dNY2te1prXhHaNVOwo6jqBzN-8AgKm3g>
    <xmx:P_0GZ6iRg27ExAIAcck9wSknvlDBSQz9t5LpHkWq99UxIzU8rmMPgK_B>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 18:01:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org,  phillip.wood@dunelm.org.uk, 	Taylor Blau
 <me@ttaylorr.com>,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Johannes
 Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 6/6] fetch: set remote/HEAD if it does not exist
In-Reply-To: <20241009135747.3563204-6-bence@ferdinandy.com> (Bence
	Ferdinandy's message of "Wed, 9 Oct 2024 15:57:28 +0200")
References: <xmqq1q0xhu13.fsf@gitster.g>
	<20241009135747.3563204-1-bence@ferdinandy.com>
	<20241009135747.3563204-6-bence@ferdinandy.com>
Date: Wed, 09 Oct 2024 15:01:33 -0700
Message-ID: <xmqqzfndndfm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bence Ferdinandy <bence@ferdinandy.com> writes:

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 80a64d0d26..c3d3c05950 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1578,6 +1578,82 @@ static int backfill_tags(struct display_state *display_state,
>  	return retcode;
>  }
>  
> +static void report_set_head(const char *remote, const char *head_name,
> +			struct strbuf *buf_prev) {
> +	struct strbuf buf_prefix = STRBUF_INIT;
> +	const char *prev_head;
> +
> +	strbuf_addf(&buf_prefix, "refs/remotes/%s/", remote);
> +	skip_prefix(buf_prev->buf, buf_prefix.buf, &prev_head);

The same "uninitialized prev_head" problem I discussed earlier for a
separate patch is here, I think.

> +	if (prev_head && !strcmp(prev_head, head_name))
> +		;
> +	else if (prev_head) {
> +		printf("'HEAD' at '%s' has changed from '%s' to '%s'\n",
> +			remote, prev_head, head_name);
> +		printf("Run 'git remote set-head %s %s' to follow the change.\n",
> +			remote, head_name);
> +	}

If the condition is only for one arm, can't we do this without
else/if?  Would the condition become too contorted to read if we did
so?  Let's see.

	if (prev_head && strcmp(prev_head, head_name)) {
		HEAD has changed from prev_head to head_name;
	}

I guess it is a bit subjective, but as long as you are used to read
"strcmp(a,b)" as "a and b are different", this should be easier to
read than the original.

> +static const char *strip_refshead(const char *name){
> +	skip_prefix(name, "refs/heads/", &name);
> +	return name;
> +}
> +
> +static int set_head(const struct ref *remote_refs)
> +{
> +	int result = 0;
> +	struct strbuf b_head = STRBUF_INIT, b_remote_head = STRBUF_INIT,
> +		b_local_head = STRBUF_INIT;
> +	const char *remote = gtransport->remote->name;
> +	char *head_name = NULL;
> +	struct ref *ref, *matches;
> +	struct ref *fetch_map = NULL, **fetch_map_tail = &fetch_map;
> +	struct refspec_item refspec = {
> +		.force = 0,
> +		.pattern = 1,
> +		.src = (char *) "refs/heads/*",
> +		.dst = (char *) "refs/heads/*",
> +	};
> +	struct string_list heads = STRING_LIST_INIT_DUP;
> +	struct ref_store *refs = get_main_ref_store(the_repository);
> +
> +	get_fetch_map(remote_refs, &refspec, &fetch_map_tail, 0);
> +	matches = guess_remote_head(find_ref_by_name(remote_refs, "HEAD"),
> +				    fetch_map, 1);
> +	for (ref = matches; ref; ref = ref->next) {
> +		string_list_append(&heads, strip_refshead(ref->name));
> +	}
> +
> +
> +	if (!heads.nr)
> +		result = 1;
> +	else if (heads.nr > 1) {

Curious use of extra {braces}.  In this case we can just lose them.

> +		result = 1;
> +	} else
> +		head_name = xstrdup(heads.items[0].string);


> +	if (head_name) {
> +		strbuf_addf(&b_head, "refs/remotes/%s/HEAD", remote);
> +		strbuf_addf(&b_remote_head, "refs/remotes/%s/%s", remote, head_name);
> +		/* make sure it's valid */
> +		if (!refs_ref_exists(refs, b_remote_head.buf))
> +			result |= error(_("Not a valid ref: %s"), b_remote_head.buf);
> +		else if (refs_update_symref(refs, b_head.buf, b_remote_head.buf,
> +					"remote set-head", &b_local_head, true))
> +			result |= error(_("Could not setup %s"), b_head.buf);

Two problems.

 * we do not capitalize the beginning of the sentence in an error()
   message, i.e. "Could not" -> "could not" (or "cannot").

 * "setup" is not a verb.

I know both were inherited from builtin/remote.c but existing
breakage is not a good excuse to make new code worse.

> +		else {

Curious use of extra {braces}.  In this case we can just lose them.

> +			report_set_head(remote, head_name, &b_local_head);
> +		}
> +		free(head_name);
> +	}
> +
> +	strbuf_release(&b_head);
> +	strbuf_release(&b_local_head);
> +	strbuf_release(&b_remote_head);
> +	return result;
> +}
> +
>  static int do_fetch(struct transport *transport,
>  		    struct refspec *rs,
>  		    const struct fetch_config *config)
> @@ -1647,6 +1723,8 @@ static int do_fetch(struct transport *transport,
>  				    "refs/tags/");
>  	}
>  
> +	strvec_push(&transport_ls_refs_options.ref_prefixes,"HEAD");

Missing SP after ",".

>  	if (must_list_refs) {
>  		trace2_region_enter("fetch", "remote_refs", the_repository);
>  		remote_refs = transport_get_remote_refs(transport,
> @@ -1791,6 +1869,9 @@ static int do_fetch(struct transport *transport,
>  				  "you need to specify exactly one branch with the --set-upstream option"));
>  		}
>  	}
> +	if (set_head(remote_refs))
> +		; // Way too many cases where this can go wrong.
> +		  // Just fail silently.

	/*
	 * our multi-line comments
	 * look like this.
	 */

More importantly, we are not failing silently.  As we saw in the
implementation of set_head() above, a non-zero return came from ret
that was assigned the return value of error() in the function, so an
error message is already given, no?

> @@ -2021,6 +2102,7 @@ static int fetch_multiple(struct string_list *list, int max_children,
>  	return !!result;
>  }
>  
> +
>  /*
>   * Fetching from the promisor remote should use the given filter-spec
>   * or inherit the default filter-spec from the config.

An unintended change?

Thanks.
