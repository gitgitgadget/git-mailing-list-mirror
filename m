Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5747D2367AD
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 05:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758778746; cv=none; b=qMXt1d3WLP3yxq8VLxJJ91il4Tqm8VZy3s6lQpXKKepNG4ZBVkh1iPVUsIiI8yfAmgT3y3+MgIudiJ4J8ZgEhkurZebetqRi/CWWGsncnGwAZGJj0zyj4nsyW0mt7UlYRr1SxXmsWkqIjKQPxLix0gAA4ZUYXb42x03B0vv964c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758778746; c=relaxed/simple;
	bh=Wsq+fJd7nsFUQcpB4De9h1BaFXSSzpVl/52GMBUTSZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XM2MYpuM1so2fZ+laPwjR5AoUqCfqbfXGBSIbaFFjr1NoufY2qb3tQBGL3MCrmRxyhCZSeIHK3QnABLCkdvGLb5TQRJt6pZzEJPB2Is9NKMTLGgLucpMYYagzI/H/SVDD/IIPBf2/xvCFwCIsXJ9MaolvWO8xVoiXtbjuL6FkSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DAcMOVkc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TFwNbzJ2; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DAcMOVkc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TFwNbzJ2"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 320DF14000CF;
	Thu, 25 Sep 2025 01:39:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 25 Sep 2025 01:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758778742; x=1758865142; bh=Ez+mQj6R6y
	MWf9Hi0KEvj8G//tZTvSgSQnSJKbCoZnE=; b=DAcMOVkcJZ+FsxnHi0nFumDzyn
	Vaf4nz4ftSBg4o5h3wqo/Rn8H7Qjg1zncYAgz4FixWE3HDUuDi4IBg68mIMmvwB1
	vwZDfdMuwlicpwSyTpyG9m+HIxx7W4FBnl4/nW8tASKrG4fEgmX4+F+YYXru4IH+
	pLsrDRalp96D6j/AAWNSqpPyNx87pU/OSnDCAzg0ewzeOjAMHYEw3QvSBWLUoMc7
	7C/QO4ELT0j82L/HoNO2T5J9rIvl03tRFw6uvwrNj1UQuMGuGnpFXo8QkrRkhe7J
	KDcFZOOWcuqB6umQuQMNQ/J+svLinfI6mumXFknyx5aJupdHBPCTqV2P1ahA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758778742; x=1758865142; bh=Ez+mQj6R6yMWf9Hi0KEvj8G//tZTvSgSQnS
	JKbCoZnE=; b=TFwNbzJ2nC+C9vpCX9i719PXQ4EuEF8dH5z5kPPJFiKlRW4nBo9
	Vf8PvzGEqglzxbZ6FXkp/1wc0lw7rkS9sBtb3raC3958274EVjb8OrfkE4F0B2yF
	O/VJBZ2QsQ15Sxy1wEUjgjVHVmxTN/eFPaZtUGIJWtmk12OBY0vhYaifqcGxUwV7
	krqyXJI/lOfaQm1YJ/M4ITUpZ5BuzJ53tvSbhj9zIk96Aippv5CHkRdce69R+eLV
	A+VaxIez3lx11/Sl1r5bh6a0D2LXB07xlSPcQk+tH9OaRdJAliAyID3r50Z46Bj9
	dRffRuK7urv7vh2CUlgcvrObLnk3j75STkA==
X-ME-Sender: <xms:ddXUaHPf86Wu-Bv9subXJfxOFUYsFRCqx9MPbpczsxRMNXC4VG9vIw>
    <xme:ddXUaI82yt4VLrwRkBCY4k7r4Ml2j4-yk-b6-osj4UrJkTLJgmbDN0agLVHn9KE5A
    azdLVF_8yg5oXtC0LnorNNWIz4O0WI6AlNIc0E2fLDAXpT4wFw5m8I>
X-ME-Received: <xmr:ddXUaLTC20QnkTjB4xI0v2qoqWEAJkKf35nFHoapfXsLv02_SpRH0WzlsAzktwyrBULo5riEWP3Rfj08pSIba3O8TgAtXLQ6vv0kdB_ThrY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiheeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:dtXUaKmsjzHhqHBjDF7urf0CiOjhA1MB7-sVvnd4HykqEutCyTs_XA>
    <xmx:dtXUaLSPWZZFCKP3p8N8Fz9coZ3sKGzvH2jHpIamEMdL_MOyFUhjgQ>
    <xmx:dtXUaIM1xFtULcce9zTw1JwK4VYi8D2qBwU8C3pzwlcREF6Ftm0OZA>
    <xmx:dtXUaEWOTdGn5ymk4ZMXsLmETS6NpDA_Fk1lnRgb-Cq7Smi4ELE2_Q>
    <xmx:dtXUaGnI2QkEdW8TLwvv5ysqZfXU5Km4WxFEsKl7ZDgirx9KPlzuiw3j>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 01:39:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 15760533 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 25 Sep 2025 05:38:59 +0000 (UTC)
Date: Thu, 25 Sep 2025 07:38:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 3/6] builtin/repo: introduce stats subcommand
Message-ID: <aNTVa3-RtYNPlcHc@pks.im>
References: <20250923025700.3046260-1-jltobler@gmail.com>
 <20250924212426.2930029-1-jltobler@gmail.com>
 <20250924212426.2930029-4-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924212426.2930029-4-jltobler@gmail.com>

On Wed, Sep 24, 2025 at 04:24:23PM -0500, Justin Tobler wrote:
> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> index 209afd1b61..a009bf8cf1 100644
> --- a/Documentation/git-repo.adoc
> +++ b/Documentation/git-repo.adoc
> @@ -156,12 +159,188 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
>  	return print_fields(argc, argv, repo, format);
>  }
>  
> +struct ref_stats {
> +	size_t branches;
> +	size_t remotes;
> +	size_t tags;
> +	size_t others;
> +};
> +
> +struct stats_table {
> +	struct string_list rows;
> +
> +	size_t name_col_width;
> +	size_t value_col_width;
> +};
> +
> +/*
> + * Holds column data that gets stored for each row.
> + */
> +struct stats_table_entry {
> +	char *value;
> +};
> +
> +static void stats_table_add(struct stats_table *table, const char *format,
> +			    const char *name, struct stats_table_entry *entry)

We could of course accept varargs right from the start and thus allow
the caller to pass arbitrary formatting directives. But I guess we don't
need it now, so it's fine to not do it.

[snip]
> +static void stats_table_print(struct stats_table *table)

Nit: The table can be marked as `const` as we don't modify it.

> +{
> +	const char *name_col_title = _("Repository stats");
> +	const char *value_col_title = _("Value");
> +	size_t name_title_len = strlen(name_col_title);
> +	size_t value_title_len = strlen(value_col_title);
> +	struct strbuf buf = STRBUF_INIT;
> +	struct string_list_item *item;
> +	int name_col_width;
> +	int value_col_width;
> +
> +	name_col_width = cast_size_t_to_int(
> +		max_size_t(table->name_col_width, name_title_len));
> +	value_col_width = cast_size_t_to_int(
> +		max_size_t(table->value_col_width, value_title_len));
> +
> +	strbuf_addf(&buf, "| %-*s | %-*s |\n", name_col_width, name_col_title,
> +		    value_col_width, value_col_title);
> +	strbuf_addstr(&buf, "| ");
> +	strbuf_addchars(&buf, '-', name_col_width);
> +	strbuf_addstr(&buf, " | ");
> +	strbuf_addchars(&buf, '-', value_col_width);
> +	strbuf_addstr(&buf, " |\n");
> +
> +	for_each_string_list_item(item, &table->rows) {
> +		struct stats_table_entry *entry = item->util;
> +		const char *value = "";
> +
> +		if (entry) {
> +			struct stats_table_entry *entry = item->util;
> +			value = entry->value;
> +		}
> +
> +		strbuf_addf(&buf, "| %-*s | %*s |\n", name_col_width,
> +			    item->string, value_col_width, value);
> +	}
> +
> +	fputs(buf.buf, stdout);
> +	strbuf_release(&buf);
> +}

By the way, is there any specific reason we do the detour via the strbuf
instead of printing the data to stdout directly?

> +static void stats_table_clear(struct stats_table *table)
> +{
> +	struct stats_table_entry *entry;
> +	struct string_list_item *item;
> +
> +	for_each_string_list_item(item, &table->rows) {
> +		entry = item->util;
> +		if (entry)
> +			free(entry->value);
> +	}
> +
> +	string_list_clear(&table->rows, 1);
> +}

Yeah, this is much nicer now.

> +static void stats_count_references(struct ref_stats *stats, struct ref_array *refs)
> +{
> +	for (int i = 0; i < refs->nr; i++) {
> +		struct ref_array_item *ref = refs->items[i];
> +
> +		switch (ref->kind) {
> +		case FILTER_REFS_BRANCHES:
> +			stats->branches++;
> +			break;
> +		case FILTER_REFS_REMOTES:
> +			stats->remotes++;
> +			break;
> +		case FILTER_REFS_TAGS:
> +			stats->tags++;
> +			break;
> +		case FILTER_REFS_OTHERS:
> +			stats->others++;
> +			break;
> +		default:
> +			BUG("unexpected reference type");
> +		}
> +	}
> +}

Here we're now being defensive. Good.

Patrick
