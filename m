Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FC2241131
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 22:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750458388; cv=none; b=FzPEhCgATTlh0Y2LETqoaR4cUUZCN8yH1gX0hOt7NEMj2UwwwVCjbtFdNL1/Yq9fXjJQ1/W0y7JhB7Gfjc4baRa3/1kLxi4rgCTZMK4l9B4QC35jm4XsNE2Sosdz+8EkeHoyzPzl6tP+gMdJiELC/I2lnvUrvRU91NyLmEcQhMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750458388; c=relaxed/simple;
	bh=26m0PEpV9XhM6dd5ZjxTvJ1Q/3kTTeLWnrvHaUxkByU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sRskSuPjeF+RlgdNSPB/Z0aKzrXiJ+SCcQgSWTIMjNj4EAjN4PEWORbuo/607Cbz4tUFc932Su3Vl9/JAZ+QheLwqU1cRCps9t4JJDkxswmdTqVSqEdTyjPaQrAgGN1sJo7rDpRZ21n5pAksoNZcryyj7ZsIYX9sRALGmLoj6dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xnq6dNoL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i1pzLmJF; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xnq6dNoL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i1pzLmJF"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5603325401F3;
	Fri, 20 Jun 2025 18:26:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 20 Jun 2025 18:26:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750458384; x=1750544784; bh=JfvpXuItv4
	fTBKyCb6ePWnBdtVXTVLd7IMZ21GNoru4=; b=xnq6dNoLeBvX4MvNEH4qIjOqBB
	gqsPoPWxjrqt06KYqcgVq8LR8lfrgU8hnjbp1Dz9Bcl4Ux8xzRg63j2v/veFPJdS
	g8H8yKMLEbIIi4eTzONvx0HO5fgZO7QFnpCvPA22jK29VDhY4sCFKev7YwU1zOtZ
	AL5wETADUH9VUk8V0+jDF70zS57C6cWZV/1Fm1RS3CF9al8ACssdmfYljw+PkvTu
	Q0yoemjgkNjRCRQqi7TiGSGiZwoKTuFucHW7qXg1MWrcQ2I9r3rXYyXfg55RH7/O
	W/SyGHdZPrHaWBV0VkjAAyH6cB3Uo/OhzFcBkY8hTnwXZGi/X71fWyFcB3mQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750458384; x=1750544784; bh=JfvpXuItv4fTBKyCb6ePWnBdtVXTVLd7IMZ
	21GNoru4=; b=i1pzLmJFco686z68v5+fpASDudoT956gAXXdtUws2CIdazn4xzZ
	QwulTeqQZk15323IFEBAikO6uPLpr4ZA0pETwXNUjT9naot44gXAjSZ3CCj4R5Hs
	Uy7lv2x31PX3gEPN717pYOHy9xMiObWMaEH5+HyvrNAIXirrUDou74GHIdAgQnSs
	5csvD2+QbAyXTNMRGjoTgsVNHfXx1Mn44Hki8FozS3qbdgus/X9rrkQywR205QIm
	HsmJMBqNXjPMrB6RfiKDSSwPRDs6IoLcQhDaJoclYt5MMPSwtPnYJ7dnptF46zTP
	f3X/Uy1T2mi4arXmtH+dG5wG5OI7kTdBNwg==
X-ME-Sender: <xms:D-BVaC2vPblGzvxK4iVnc7c_2HVwNyviE9gvMZX5HjnNt8fpqOKQxA>
    <xme:D-BVaFEgGBZxTH6k9rilQG7dIeH6q5-o5l04DZFBEUNvZlQulB1CHR4i_SBCGBdD9
    K01x7jJAzAl-QXI_g>
X-ME-Received: <xmr:D-BVaK7gWhWCT2YWHtVNfRk8-OL0zaeu9eqblhEJUIHC_WQnTLdXOwkrkTMxr9ijpb1Igz_7Vkv6TKVp2RycPCrTW0wKT-GRr3CR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdeliedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepffeghedtfeejteeguddtleeljeeihffhheelvdeihedujeeileeufefhheehfeev
    necuffhomhgrihhnpehrvghfvghrvghntggvshdrihhnnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplh
    hutggrshhsvghikhhiohhshhhirhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:EOBVaD1q2QZLEWSmNf4uHVngndqd6W8ecilqwLoGF-yKG0tcCTPqhg>
    <xmx:EOBVaFHOhFJXO5Y_tXiM-7--HnKRPVvx1r0GZ3k316DqE6No44_8AA>
    <xmx:EOBVaM86e2UK3yubN3STkvwzq0uGbvzLdDB7ffNb84rX9um5x5l_iA>
    <xmx:EOBVaKmVvxcVFt1Z7zA5JxsvtSQOf-w1hvdBl39B0DiMZvvC_630jw>
    <xmx:EOBVaFQo7TXtOJI2ujGQ8xRSBN5twQk9iDDHipax6ZBCQyQzYIGMUM7f>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Jun 2025 18:26:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  karthik.188@gmail.com,
  ben.knoble@gmail.com
Subject: Re: [GSoC RFC PATCH v2 5/7] repo-info: add the field references.format
In-Reply-To: <20250619225751.99699-6-lucasseikioshiro@gmail.com> (Lucas Seiki
	Oshiro's message of "Thu, 19 Jun 2025 19:57:49 -0300")
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
	<20250619225751.99699-1-lucasseikioshiro@gmail.com>
	<20250619225751.99699-6-lucasseikioshiro@gmail.com>
Date: Fri, 20 Jun 2025 15:26:22 -0700
Message-ID: <xmqqh60ayrqp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Add the field references.format to the repo-info command. The data
> retrieved in this field is the same that currently is obtained by
> running `git rev-parse --show-ref-format`.
>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Mentored-by Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
>  builtin/repo-info.c  | 108 +++++++++++++++++++++++++++++++++++++++++--
>  t/t1900-repo-info.sh |  58 +++++++++++++++++++++++
>  2 files changed, 162 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/repo-info.c b/builtin/repo-info.c
> index 6499be0eae..6ce3e6134f 100644
> --- a/builtin/repo-info.c
> +++ b/builtin/repo-info.c
> @@ -1,21 +1,56 @@
>  #include "builtin.h"
>  #include "json-writer.h"
>  #include "parse-options.h"
> +#include "quote.h"
> +#include "refs.h"
>  
>  enum output_format {
>  	FORMAT_JSON,
>  	FORMAT_PLAINTEXT
>  };
>  
> +enum repo_info_category {
> +	CATEGORY_REFERENCES = 1 << 0
> +};
> +
> +enum repo_info_references_field {
> +	FIELD_REFERENCES_FORMAT = 1 << 0
> +};
> +
> +struct repo_info_field {
> +	enum repo_info_category category;
> +	union {
> +		enum repo_info_references_field references;
> +	} field;
> +};

Are we going to gain more than one union in this struct?  If not,
name the union simply 'u', so that the accesses look like
"info.u.references" instead of "info.field.references".  In that
construct, a long name ".field" does not add much information value
anyway---the member in the union, like "references", is where all
the information value is.

>  struct repo_info {
>  	struct repository *repo;
>  	enum output_format format;
> +	int n_fields;
> +	struct repo_info_field *fields;
>  };
>  
> +static struct repo_info_field default_fields[] = {
> +	{
> +		.category = CATEGORY_REFERENCES,
> +		.field.references = FIELD_REFERENCES_FORMAT
> +	}
> +};
> +
> +static void print_key_value(const char *key, const char *value) {
> +	printf("%s=", key);
> +	quote_c_style(value, NULL, stdout, 0);
> +	putchar('\n');
> +}
> +
>  static void repo_info_init(struct repo_info *repo_info,
>  			   struct repository *repo,
> -			   char *format)
> +			   char *format,
> +			   int allow_empty,
> +			   int argc, const char **argv)
>  {
> +	int i;
>  	repo_info->repo = repo;
>  
>  	if (format == NULL || !strcmp(format, "json"))
> @@ -24,19 +59,83 @@ static void repo_info_init(struct repo_info *repo_info,
>  		repo_info->format = FORMAT_PLAINTEXT;
>  	else
>  		die("invalid format %s", format);
> +
> +	if (argc == 0 && !allow_empty) {
> +		repo_info->n_fields = ARRAY_SIZE(default_fields);
> +		repo_info->fields = default_fields;
> +	} else {
> +		repo_info->n_fields = argc;
> +		ALLOC_ARRAY(repo_info->fields, argc);
> +
> +		for (i = 0; i < argc; i++) {
> +			const char *arg = argv[i];
> +			struct repo_info_field *field = repo_info->fields + i;
> +
> +			if (!strcmp(arg, "references.format")) {
> +				field->category = CATEGORY_REFERENCES;
> +				field->field.references = FIELD_REFERENCES_FORMAT;

Are we going to have duplicate information between this
if/elseif/... cascade and the default_fields[] array?

There needs a catalog of "everything we support" somewhere, which
can be used to determine what "--all" should show, whose entry can
be looked up with the textual name (like "references.format") for
the purpose of command line parsing.  Once you have such a
"everything we support" table, this parser loop and "--all" handling
can become more table-driven.

> -static void repo_info_print_plaintext(struct repo_info *repo_info UNUSED)
> +static void repo_info_release(struct repo_info *repo_info)
>  {
> +	if (repo_info->fields != default_fields) free(repo_info->fields);

Do not write if() and its body on the same line.

>  }
>  
> -static void repo_info_print_json(struct repo_info *repo_info UNUSED)
> +static void repo_info_print_plaintext(struct repo_info *repo_info) {
> +	struct repository *repo = repo_info->repo;
> +	int i;
> +	for (i = 0; i < repo_info->n_fields; i++) {
> +		struct repo_info_field *field = &repo_info->fields[i];
> +		switch (field->category) {
> +		case CATEGORY_REFERENCES:
> +			switch (field->field.references) {
> +			case FIELD_REFERENCES_FORMAT:
> +				print_key_value("references.format",
> +						ref_storage_format_to_name(
> +							repo->ref_storage_format));
> +				break;
> +			}
> +			break;
> +		}

Can't this also be made more table driven, by having a callback
function pointer in the "everything we support" table?  That way,
this deeply nested loop does not have to be here and you do not have
to chomp a line that is overly deeply nested in the middle just to
go under 80-column limit.

IOW, the above code may become something like:

	for (int i = 0; i < repo_info->n_fields; i++) {
		struct repo_info_field *f = &repo_info->fields[i];
                f->show(repo_info, f);
	}

and the repo_info_field structure may have a pointer to the
implementation of "show" method for that particular type, which may
look like

        static void show_references_format(struct repo_info *i,
                                           struct repo_info_field *f)
        {
                struct repository *repo = i->repo;
                enum ref_storage_format fmt = repo->ref_storage_format;
                const char *name = ref_storage_format_to_name(fmt); 

                print_key_value("references.format", name);
        }

Hmm?

I'll stop here for now.

Thanks.
