Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1467C433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 22:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbiC3WIy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 18:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbiC3WIw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 18:08:52 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E73D3B3CF
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 15:07:06 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id w201-20020a627bd2000000b004fa92f4725bso12723531pfc.21
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 15:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=gBiwV3ritYxvoqG5LnEEL1Ljhyoql6luEfMni+4c1fo=;
        b=UF8FEq9YOShmuS1N4jrXkT9RJ7cZO0C+zNHekiUvUV2h9pPrVHySgvouNftR/SYCLj
         8UTQJXjtE+QUKJwcj4Cw3kO18gFn4O8+qSrM2eTQO2txwK193sdgt7BdXdcdHiWlxx00
         4mikZemnLSn13Od7TclLZNqll5UXUvBWdEEt6fH5k9+h56WwgI36UhNvlrQpuxGs4ssx
         F7lj+WwCc0/dhMM/I/xRpp/1o25bx8w+lFnds/OzQi1ODa/2EorijRkq/GeeFuGTXHbJ
         W78JpPasw3jFm1/zrd1oinWfNF5xcBzr5S3JsXtRJhZd2f08LqMBpq2Qa9tG8TcUxVtL
         sMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=gBiwV3ritYxvoqG5LnEEL1Ljhyoql6luEfMni+4c1fo=;
        b=Be20PZ5G1nzmrVVunk1CuyN2azrDjRkWFJBoPjhJ5BiCSoKO8CX9xMdkiDZnFRhsGl
         LsnJ/1jNEmx2S02rjIqo3bHwgoYyZqh6XrrbtzqOhbWroddP0Qmx0VUtuDPIxjJTneO1
         BZTbBKsYZDaunePVZqVvbIDKnXdQ761c8CTa3yQCGTaqz7NP6LwO/KoIW/4EtrhrXIug
         IGDCG1bCyXmfRAQVJXf9BCl9eeKObqo5kuc2S/f8lIxvuLHmysvUiynC9MLYpG/K1wuN
         zEoNN8XZdbZHrcwN+CylFwErnFwKMBwsoPmfbE9RgdYjmb6ZHKlsvNoAqS01oN21/K6V
         WfJA==
X-Gm-Message-State: AOAM533oRejkEePIUxjzagIwjfMV66ilKps7P0YtF0R47OrZrzldWApC
        sbdUBMavT7GBx3X3qNJmO8WY+IhTxR4tcfQNYS9Z
X-Google-Smtp-Source: ABdhPJzF3PxCex3sbp3G3hj4Qe5kdnQgH/xEn2d56ZHXtHB3APAjpl4Dxcl1N0Y7qryC6N6RvwA94agGYgQLclhlb/m5
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:903:2305:b0:154:4aa2:e800 with
 SMTP id d5-20020a170903230500b001544aa2e800mr1562977plh.167.1648678025903;
 Wed, 30 Mar 2022 15:07:05 -0700 (PDT)
Date:   Wed, 30 Mar 2022 15:07:03 -0700
In-Reply-To: <20220328191112.3092139-4-calvinwan@google.com>
Message-Id: <20220330220703.2304827-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: Re: [PATCH v3 3/3] object-info: add option for retrieving object info
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        philipoakley@iee.email, johncai86@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:
> @@ -1604,6 +1625,10 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  	if (args->depth > 0 || args->deepen_since || args->deepen_not)
>  		args->deepen = 1;
>  
> +	if (args->object_info) {
> +		state = FETCH_SEND_REQUEST;
> +	}
> +
>  	while (state != FETCH_DONE) {
>  		switch (state) {
>  		case FETCH_CHECK_LOCAL:
> @@ -1613,7 +1638,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  			/* Filter 'ref' by 'sought' and those that aren't local */
>  			mark_complete_and_common_ref(negotiator, args, &ref);
>  			filter_refs(args, &ref, sought, nr_sought);
> -			if (everything_local(args, &ref))
> +			if (!args->object_info && everything_local(args, &ref))
>  				state = FETCH_DONE;
>  			else
>  				state = FETCH_SEND_REQUEST;

I haven't looked into this deeply, but one thing to consider is to do
this in a separate function (instead of reusing do_fetch_pack_v2())
because the object-info request and response has almost nothing in
common with fetch.

> diff --git a/t/t5583-fetch-object-info.sh b/t/t5583-fetch-object-info.sh

[skip tests]

Also test when: the user gives an invalid --object-info (e.g.
"--object-info=foo") and when the user gives two parameters, one valid
and one invalid. (Both should fail.)

> diff --git a/transport-internal.h b/transport-internal.h
> index c4ca0b733a..04fa015011 100644
> --- a/transport-internal.h
> +++ b/transport-internal.h
> @@ -59,6 +59,7 @@ struct transport_vtable {
>  	 * use. disconnect() releases these resources.
>  	 **/
>  	int (*disconnect)(struct transport *connection);
> +	int (*fetch_object_info)(struct transport *transport, struct oid_array *oids);
>  };

Do we need another entry in the vtable, or can we do without? (As it is,
I don't think we need it, as evidenced by the fact that this patch did
not add any entries to the transport_vtable instances.)

> diff --git a/transport.c b/transport.c
> index 70e9840a90..65a1b1fdb3 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -350,6 +350,67 @@ static struct ref *handshake(struct transport *transport, int for_push,
>  	return refs;
>  }
>  
> +/*
> + * Fetches object info if server supports object-info command
> + * Make sure to fallback to normal fetch if this fails
> + */
> +static int fetch_object_info(struct transport *transport)
> +{
> +	struct git_transport_data *data = transport->data;
> +	struct object_info_args args;
> +	struct packet_reader reader;
> +
> +	memset(&args, 0, sizeof(args));
> +	args.server_options = transport->server_options;
> +	args.object_info_options = transport->smart_options->object_info_options;
> +	args.oids = transport->smart_options->object_info_oids;

I think we can avoid code duplication in this function too. So from
here (the connect_setup line below)...

> +	connect_setup(transport, 0);
> +	packet_reader_init(&reader, data->fd[0], NULL, 0,
> +			PACKET_READ_CHOMP_NEWLINE |
> +			PACKET_READ_DIE_ON_ERR_PACKET);
> +	data->version = discover_version(&reader);
> +
> +	transport->hash_algo = reader.hash_algo;
> +
> +	switch (data->version) {
> +	case protocol_v2:
> +		if (!server_supports_v2("object-info", 0))
> +			return 0;
> +		send_object_info_request(data->fd[1], &args);
> +		break;
> +	case protocol_v1:
> +	case protocol_v0:
> +		die(_("wrong protocol version. expected v2"));
> +	case protocol_unknown_version:
> +		BUG("unknown protocol version");
> +	}

...up to here can be a function (except that we need to take out
send_object_info_request() and maybe parameterize the server_supports_v2
call).

From here...

> +	if (packet_reader_read(&reader) != PACKET_READ_NORMAL) {
> +		die(_("error reading object info header"));
> +	}
> +	if (strcmp(reader.line, "size")) {
> +		die(_("expected 'size', received '%s'"), reader.line);
> +	}
> +	while (packet_reader_read(&reader) == PACKET_READ_NORMAL) {
> +		printf("%s\n", reader.line);
> +	}

...until here is object-info-specific, yes.

And this...

> +	check_stateless_delimiter(transport->stateless_rpc, &reader, "stateless delimiter expected");
> +
> +	return 1;
> +}

is common code once again.

Also instead of returning 0 from this function if the server doesn't
support object-info, it's probably clearer to have one function that
checks what the server supports, and then have an "if" block which
either does the object-info part or the fetch part depending on what the
server says.
