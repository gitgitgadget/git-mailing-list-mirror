Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A91C24EF6E
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 20:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740429971; cv=none; b=Msb2QNysKwjsE+L9+CXGIF6yn66DITM4ZmWuCac45ACdl4XsLOsyGLLAQepUymqhLDLx6N79ieqEh2QFdfqE6XIUx2Gg28lgJt6lCTdW1bWkMYwV2HYLVax3yohnRMpGCHLhmV+W5X/k/CMgOVaULWHfIze6tO5ZzMsb1N7msnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740429971; c=relaxed/simple;
	bh=rsoSZwcBUGybVVMPPm4urgbkpza5TylLInoce+dpebY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QN3yiyJlJ6livMj7xBtczGi/zbTvL7ICIYzfGjknMdWUT327qzG5PZxKgElyr0MsyKij1gkJTmXMDIkt+aTTcO0q3m6pIjPtugGJlpgriZ5HbpNThx9dygIRk23bC06N/yW9Hd7R/zPGx4vPnzJtiUAwBsiRfs/i3i5JLT1VWgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=as9dm1c9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RDzHWLAA; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="as9dm1c9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RDzHWLAA"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 062B52540171;
	Mon, 24 Feb 2025 15:46:06 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 24 Feb 2025 15:46:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740429966; x=1740516366; bh=VaK+6hPjaY
	XEZkPVB4OZdc97djLCgdAc0ajcQzAlx3s=; b=as9dm1c9EJHVEj7iiyvyjgSVcQ
	yTFqk38QBfB88buxowQyiAOjkuLK6FcADqQNXjpK5cLaqYcxJe/plyo7RUtwRmtU
	8L0sBZtL8/5sDvnQBsQrEMuk4eaPSgoPfKdsAcYVM+Qzc5Ienmgm0KFT0CldkD7U
	lgitdOTKqkydLUYu7OoSQtgQLEYKFrKQ/GU6Jdqj5sYqpgl6mnMbNVkIHDtK5rIj
	62BuAW7+W25dfuiVCvmBOFJx3v+tzzyg/R4ridx4kbx7+fZKNY40AA4dGqgS+D1y
	zSdgw76TgxNfsmPJWRNYoHQubAYy+PtMqGRxmhZBgdG+OZJzGKPZo2iUq1zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740429966; x=1740516366; bh=VaK+6hPjaYXEZkPVB4OZdc97djLCgdAc0aj
	cQzAlx3s=; b=RDzHWLAA/aW6ar6ytz/A2gReKzNqDFFQ1JAzrFyF+3xmyYKkWsX
	HDIBB2TA0n7RDJwSdoq3zAb3r4lUAf2/iKuR6zSajX+7lQ9+8x8KjMwL0uNNgrJM
	xFw/RhztKBtC9+3AZjJkzzhHfLCn1NJ4KEhio2Co1QBOGpjXIGWtkLaPiyqjkigX
	XTzOR/fIyk4pdPvXBYKLZNEWVc+Old+gHXcRx8X1DujyO4ZuulceTc6e1QZCvGZc
	G3pT3duX86nNxOUSbFZZcuWpkWW8tzrsTsLVE2PGqh5wbHJuAkwvAhjwbWv6WRiu
	WyasT2uNRCN5/IEJIi1FFm/kYOZNmUoYwUA==
X-ME-Sender: <xms:jdq8Z3-i07RBRCqGWiuvItJAExTfMEOpp-n1v3A2vfAzwp2QF7aFNg>
    <xme:jdq8ZztmJFk6bClGNYnPs2DTLRSLuxCk4IN88xdJ3tRuC-6SGmu585Ux0s4YgrEO1
    CD5ufhpdS4dlHGJcg>
X-ME-Received: <xmr:jdq8Z1DhHAjGprpA8Ue0oWAHd8yUcsultct89_xm7cbyDK9bJq4So-74jpa3tpz6n4FHjsAEWCiBOKDOh15K4L0ub0ermgLshwP-eds>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejleejkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfe
    evteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepvghrihgtrdhpvghijhhirghnsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtrghlvhhi
    nhifrghnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehjohhnrghthhgrnhhtrghnmh
    ihsehgohhoghhlvgdrtghomhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgr
    mhhilhihrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehjlhht
    ohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:jdq8Zzc7XcHA0HlAZSHJksH78v9i-OdZUZfXpMCdU8_MHo9Ee9Frmw>
    <xmx:jdq8Z8Nk3ZwJw9f6fpdJrGBtvn1L8h8Za9R-dAmbqzfSfX6iP5306A>
    <xmx:jdq8Z1m1dTE-v0uuuGhiREP34tQie_kk3pXuwuuFhij5FedyHnp6sA>
    <xmx:jdq8Z2u-tZ6I5kJnwg0mPmyKn-HRt6s57BwhpcpMcgDQdzJKHfXK9A>
    <xmx:jtq8Z7qXI2VXMAzAehgmFGenJwole5UAPcl77OaiyqHl0kFb-kx4qc3O>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 15:46:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Ju <eric.peijian@gmail.com>
Cc: git@vger.kernel.org,  calvinwan@google.com,  jonathantanmy@google.com,
  chriscool@tuxfamily.org,  karthik.188@gmail.com,  toon@iotcl.com,
  jltobler@gmail.com
Subject: Re: [PATCH v11 8/8] cat-file: add remote-object-info to batch-command
In-Reply-To: <20250221190451.12536-9-eric.peijian@gmail.com> (Eric Ju's
	message of "Fri, 21 Feb 2025 14:04:49 -0500")
References: <20240628190503.67389-1-eric.peijian@gmail.com>
	<20250221190451.12536-1-eric.peijian@gmail.com>
	<20250221190451.12536-9-eric.peijian@gmail.com>
Date: Mon, 24 Feb 2025 12:46:03 -0800
Message-ID: <xmqqo6yr3wc4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Ju <eric.peijian@gmail.com> writes:

> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 69ea642dc6..47fd2a777b 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -27,6 +27,18 @@
>  #include "promisor-remote.h"
>  #include "mailmap.h"
>  #include "write-or-die.h"
> +#include "alias.h"
> +#include "remote.h"
> +#include "transport.h"
> +
> +/* Maximum length for a remote URL. While no universal standard exists,
> + * 8K is assumed to be a reasonable limit.
> + */

Style.  Our multi-line comment begins with slash-asterisk and ends
with asterisk-slash both on their own line without anything else.

> +#define MAX_REMOTE_URL_LEN (8*1024)

Here and ...

> +/* Maximum number of objects allowed in a single remote-object-info request. */
> +#define MAX_ALLOWED_OBJ_LIMIT 10000

... here, please have a blank line.

> +/* Maximum input size permitted for the remote-object-info command. */
> +#define MAX_REMOTE_OBJ_INFO_LINE (MAX_REMOTE_URL_LEN + MAX_ALLOWED_OBJ_LIMIT * (GIT_MAX_HEXSZ + 1))

This is an overly long line.

> @@ -579,6 +593,61 @@ static void batch_one_object(const char *obj_name,
>  	object_context_release(&ctx);
>  }
>  
> +static int get_remote_info(struct batch_options *opt, int argc, const char **argv)
> +{
> +	int retval = 0;
> +	struct remote *remote = NULL;
> +	struct object_id oid;
> +	struct string_list object_info_options = STRING_LIST_INIT_NODUP;
> +	static struct transport *gtransport;
> +
> +	/*
> +	 * Change the format to "%(objectname) %(objectsize)" when
> +	 * remote-object-info command is used. Once we start supporting objecttype
> +	 * the default format should change to DEFAULT_FORMAT.
> +	*/

Style.  Closing asterisk-slash aligns with the asterisk on the
previous line.

> +	if (!opt->format)
> +		opt->format = "%(objectname) %(objectsize)";
> +
> +	remote = remote_get(argv[0]);
> +	if (!remote)
> +		die(_("must supply valid remote when using remote-object-info"));
> +
> +	oid_array_clear(&object_info_oids);
> +	for (size_t i = 1; i < argc; i++) {

Pointless mixing of "size_t" and "int".  We have declared "int
argc", which is perfectly a sensible type, since we know that the
value of it would not exceed MAX_ALLOWED_OBJ_LIMIT, which is 10000.

> +		if (get_oid_hex(argv[i], &oid))
> +			die(_("Not a valid object name %s"), argv[i]);
> +		oid_array_append(&object_info_oids, &oid);
> +	}
> +	if (!object_info_oids.nr)
> +		die(_("remote-object-info requires objects"));
> +
> +	gtransport = transport_get(remote, NULL);
> +	if (gtransport->smart_options) {
> +		CALLOC_ARRAY(remote_object_info, object_info_oids.nr);
> +		gtransport->smart_options->object_info = 1;
> +		gtransport->smart_options->object_info_oids = &object_info_oids;
> +
> +		/* 'objectsize' is the only option currently supported */
> +		if (!strstr(opt->format, "%(objectsize)"))
> +			die(_("%s is currently not supported with remote-object-info"), opt->format);
> +
> +		string_list_append(&object_info_options, "size");
> +
> +		if (object_info_options.nr > 0) {
> +			gtransport->smart_options->object_info_options = &object_info_options;
> +			gtransport->smart_options->object_info_data = remote_object_info;
> +			retval = transport_fetch_refs(gtransport, NULL);
> +		}
> +	} else {
> +		retval = -1;
> +	}

Minor style nit, but when everything else is equal, writing the side
of smaller body first would make it easier to follow if/else, i.e.


	gtransport = transport_get(remote, NULL);
	if (!gtransport->smart_options) {
        	/* error */
		retval = -1;
	} else {
		... a lot of real code here ...
	}

> +static void parse_cmd_remote_object_info(struct batch_options *opt,
> +					 const char *line, struct strbuf *output,
> +					 struct expand_data *data)
> +{
> +	int count;
> +	const char **argv;
> +	char *line_to_split;
> +
> +	if (strlen(line) >= MAX_REMOTE_OBJ_INFO_LINE)
> +		die(_("remote-object-info command input overflow "
> +			"(no more than %d objects are allowed)"),
> +			MAX_ALLOWED_OBJ_LIMIT);

Nobody guarantees this user gave a request for more than 10000
objects; after all it may have been an overly long URL that busted
the line length limit, no?

> +	line_to_split = xstrdup(line);
> +	count = split_cmdline(line_to_split, &argv);
> +	if (count < 0)
> +		die(_("split remote-object-info command"));

Here, the code could check if count busts MAX_ALLOWED_OBJ_LIMIT, but
it doesn't.
