Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7A4191F7E
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 09:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528317; cv=none; b=PZ6lTmOcN39PSkvkE8lrNoaVUa9wM5Eko2PYPImSNd+IWb2zQpikka0unpuJ6xklIu2m7mKY6Vt6eKRmvUhQMhUuD6PA5MZM/PTgQ/cO3Gw0MevIxjqZYDmbUnrrazU0uk4hEt+9ABP6eaUpHsbOevIp2G5HMojHCOB2JKRylMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528317; c=relaxed/simple;
	bh=2wPPJfHjvIw9ygg7xUKIh5vWY9AggTwDpiQhq44Aqbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfzoLq8dhpmQQBV2GB6X92PqsT8wY6Yol5sdpFA2ocMk+dWqZ33Uez2bjgVQGiUY03IGIZB7trB0QGCQmsTw6CNFJv/mdxgbSyq3JBZ/0VZnshPNkqpZMpUsGAh8u6QOU/Mag69OBOLaQY3e3DMGO7IECSZqeMQ5rgsXEvR0Ve4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=wpTyM6kV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LRn5T3r7; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="wpTyM6kV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LRn5T3r7"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 38530254014C;
	Mon, 25 Nov 2024 04:51:54 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 25 Nov 2024 04:51:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1732528314; x=1732614714; bh=YkMcEZgJk2
	ziiHvropEY2OEwXqAQ6CAVtHU9SBPg+tw=; b=wpTyM6kVqZaNRriTCXwhNsSVV0
	weUWHLUs39wmN+9eosYbMVdPlP/JqlWrdpZovMVnap4GwcPIqkMF3P3OuEd8EwbB
	G1h89Etyjk7bP7bpg+7AzU3Di3y4j/OGafte1Rc+ObDgbVnIXjXW833I7fsyWigU
	C6Cb5fvmxhXo9VKwdIIisbXPBuDl46U2Q8PrxVozC0u8/3DsUFGA52cbxvBye6dX
	spSp0YQhSEbbqZo9xm+puQLdFikIflPRemn9RLG3pVMehMeO9RHVraU6Dl6rGRYJ
	m2ISuKTW94xGMxy50TlNy1X+PefqP2uXG5yULz0enSH7/f4opPA2EiQASNEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732528314; x=1732614714; bh=YkMcEZgJk2ziiHvropEY2OEwXqAQ6CAVtHU
	9SBPg+tw=; b=LRn5T3r7xMautUIXXKBYxDC6m8635IbH2grbckNRBAzBgxM9SBy
	s/GLawSFjT+qrfOiv7exsjoVL4ZI5LoyHWx0MXYrMvkKALo0Q20uEg12g8w3cFPW
	AcJUU7LvvCGlR//OAFtrXQPmSIFXaF+goy6O3t4nJD3TRGmV7rMX+poszPbTonjY
	TvWPRaCDgXYmjwPV9xtqT8cGh1Dr+q1I7e69jcHjTyGkxoJzgMuT+9Bz0H6MbXlD
	KIAh+LTcm8U65/g+Y34D2tfGnlYXK+W4r4BP5s4/CsSmhK+plK/CpAL0MpTl58IK
	Obo2MF40G9tLlvSmU0bOEdFb4fUfSRQvnyw==
X-ME-Sender: <xms:uUhEZygzBzztxTC6neiH9MlbOIypq0jk6mbYwW7tnZ3aLGtp0FfK7Q>
    <xme:uUhEZzDU3CfykZcB78zxhai5_LHYbCTMgPH5YgZfvwOc6rd7illMAgCT6dOT1c6SA
    0vhiK5mU6O4qvJMkQ>
X-ME-Received: <xmr:uUhEZ6HQSZM8u2miB24--ATrmNmztEbxKWNtb7l4BGISGZ46AY4-_W8HEDYTFh71-j0A9JbJWJwxEk3UbL8UyJrXOs2RxYrSSNQ7auWHU0xpJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitd
    eludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvghrihgtrdhp
    vghijhhirghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhi
    lhihrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehjlhhtohgslhgv
    rhesghhmrghilhdrtghomhdprhgtphhtthhopegtrghlvhhinhifrghnsehgohhoghhlvg
    drtghomhdprhgtphhtthhopehjohhnrghthhgrnhhtrghnmhihsehgohhoghhlvgdrtgho
    mh
X-ME-Proxy: <xmx:uUhEZ7TmLT9LqVT8g0gYnCMKLpyz_SByguHdwYwJnbg8bHZeN_zVuw>
    <xmx:uUhEZ_y2BCaMc84KCekOygx9nVlvIeTdQRK57KdtxHVUDKBY_YTcLg>
    <xmx:uUhEZ57tniVfAYgXjbryuM9Uo1HFUu2zAZVh6yrIn1fyBHsQKqIT8g>
    <xmx:uUhEZ8yxbFI8ujsXFdTY4Fdcs0gTyIEkLakB-7HdVp0caK1lbGMVNw>
    <xmx:ukhEZ2kjAhqKmM_aQnzokoQ-buWQ6ovWJrGUlhKULemF1dhl2S85gsx5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 04:51:52 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2fad2be2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 09:50:51 +0000 (UTC)
Date: Mon, 25 Nov 2024 10:51:40 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eric Ju <eric.peijian@gmail.com>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com,
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com,
	jltobler@gmail.com
Subject: Re: [PATCH v7 5/6] transport: add client support for object-info
Message-ID: <Z0RIrKwUnaWWm_gJ@pks.im>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241125053616.25170-1-eric.peijian@gmail.com>
 <20241125053616.25170-6-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125053616.25170-6-eric.peijian@gmail.com>

On Mon, Nov 25, 2024 at 12:36:15AM -0500, Eric Ju wrote:
> diff --git a/fetch-object-info.c b/fetch-object-info.c
> new file mode 100644
> index 0000000000..2aa9f2b70d
> --- /dev/null
> +++ b/fetch-object-info.c
> @@ -0,0 +1,92 @@
> +#include "git-compat-util.h"
> +#include "gettext.h"
> +#include "hex.h"
> +#include "pkt-line.h"
> +#include "connect.h"
> +#include "oid-array.h"
> +#include "object-store-ll.h"
> +#include "fetch-object-info.h"
> +#include "string-list.h"
> +
> +/**
> + * send_object_info_request sends git-cat-file object-info command and its
> + * arguments into the request buffer.
> + */
> +static void send_object_info_request(const int fd_out, struct object_info_args *args)
> +{
> +	struct strbuf req_buf = STRBUF_INIT;
> +
> +	write_command_and_capabilities(&req_buf, "object-info", args->server_options);
> +
> +	if (unsorted_string_list_has_string(args->object_info_options, "size"))
> +		packet_buf_write(&req_buf, "size");

Do we have a document somewhere that spells out the wire format that
client- and server-side talk with each other? If so it would be nice to
point it out in the commit message so that I know where to look, and
otherwise we should document it. Without such a doc it's hard to figure
out whether this is correct.

> +	if (args->oids) {
> +		for (size_t i = 0; i < args->oids->nr; i++)
> +			packet_buf_write(&req_buf, "oid %s", oid_to_hex(&args->oids->oid[i]));
> +	}

Nit: needless curly braces.

> +	packet_buf_flush(&req_buf);
> +	if (write_in_full(fd_out, req_buf.buf, req_buf.len) < 0)
> +		die_errno(_("unable to write request to remote"));

So we write the whole request into `req_buf` first before sending it to
the remote. Isn't that quite inefficient memory wise? In other words,
couldn't we instead stream the request line by line or at least in
batches to the file descriptor?

> +	strbuf_release(&req_buf);
> +}
> +
> +/**

Nit: s|/**|/*|

> + * fetch_object_info sends git-cat-file object-info command into the request buf
> + * and read the results from packets.
> + */
> +int fetch_object_info(const enum protocol_version version, struct object_info_args *args,
> +		      struct packet_reader *reader, struct object_info *object_info_data,
> +		      const int stateless_rpc, const int fd_out)
> +{
> +	int size_index = -1;
> +
> +	switch (version) {
> +	case protocol_v2:
> +		if (!server_supports_v2("object-info"))
> +			die(_("object-info capability is not enabled on the server"));
> +		send_object_info_request(fd_out, args);
> +		break;
> +	case protocol_v1:
> +	case protocol_v0:
> +		die(_("wrong protocol version. expected v2"));
> +	case protocol_unknown_version:
> +		BUG("unknown protocol version");
> +	}
> +
> +	for (size_t i = 0; i < args->object_info_options->nr; i++) {
> +		if (packet_reader_read(reader) != PACKET_READ_NORMAL) {
> +			check_stateless_delimiter(stateless_rpc, reader, "stateless delimiter expected");
> +			return -1;
> +		}
> +		if (unsorted_string_list_has_string(args->object_info_options, reader->line)) {

Hum. Does this result in quadratic runtime behaviour?

> +			if (!strcmp(reader->line, "size")) {
> +				size_index = i;
> +				for (size_t j = 0; j < args->oids->nr; j++)
> +					object_info_data[j].sizep = xcalloc(1, sizeof(long));

This might be a bit more future proof in case the `sizep` type were ever
to change:

	object_info_data[j].sizep = xcalloc(1, sizeof(*object_info_data[j].sizep));

It also allows you to skip double-checking whether you picked the
correct type. In fact, the type is actually an `unsigned long`, which
is confusing but ultimately does not make much of a difference because
it should have the same size.

> +			}
> +			continue;
> +		}
> +		return -1;
> +	}
> +
> +	for (size_t i = 0; packet_reader_read(reader) == PACKET_READ_NORMAL && i < args->oids->nr; i++){
> +		struct string_list object_info_values = STRING_LIST_INIT_DUP;
> +
> +		string_list_split(&object_info_values, reader->line, ' ', -1);
> +		if (0 <= size_index) {
> +			if (!strcmp(object_info_values.items[1 + size_index].string, ""))
> +				die("object-info: not our ref %s",
> +					object_info_values.items[0].string);
> +
> +			*object_info_data[i].sizep = strtoul(object_info_values.items[1 + size_index].string, NULL, 10);

We're completely missing error handling for strtoul(3p) here. That
function is also discouraged nowadays because error handling is hard to
do correct. We have `strtoul_ui()` and friends, but don't have a variant
yet that know to return an `unsigned long`. We might backfill that
omission and then use it instead.

> diff --git a/transport-helper.c b/transport-helper.c
> index bc27653cde..bf0a1877c7 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -728,6 +728,13 @@ static int fetch_refs(struct transport *transport,
>  		free_refs(dummy);
>  	}
>  
> +	/* fail the command explicitly to avoid further commands input. */
> +	if (transport->smart_options->object_info)
> +		die(_("remote-object-info requires protocol v2"));

The code path that checks for for protocol v2 with "--negotiate-only"
knows to warn and return an error. Should we do the same here?

> diff --git a/transport.c b/transport.c
> index 47fda6a773..746ec19ddc 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -9,6 +9,7 @@
>  #include "hook.h"
>  #include "pkt-line.h"
>  #include "fetch-pack.h"
> +#include "fetch-object-info.h"
>  #include "remote.h"
>  #include "connect.h"
>  #include "send-pack.h"
> @@ -444,8 +445,33 @@ static int fetch_refs_via_pack(struct transport *transport,
>  	args.server_options = transport->server_options;
>  	args.negotiation_tips = data->options.negotiation_tips;
>  	args.reject_shallow_remote = transport->smart_options->reject_shallow;
> +	args.object_info = transport->smart_options->object_info;
> +
> +	if (transport->smart_options
> +		&& transport->smart_options->object_info
> +		&& transport->smart_options->object_info_oids->nr > 0) {

Formatting is wrong here:

	if (transport->smart_options &&
	    transport->smart_options->object_info &&
	    transport->smart_options->object_info_oids->nr > 0) {

Patrick
