Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF32FC433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 22:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351472AbiC3WOf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 18:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351470AbiC3WOc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 18:14:32 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E086241324
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 15:12:46 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id bx5so22120143pjb.3
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 15:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BxQ+2CjuZy+hcNBsSaMCuzJiRjll8azcJ4nJulgGv/M=;
        b=jsqpvV6+ccYB2Qtn2b/+IUzHNR5vgt3JlcyvwAe/uPmpk+LL0uVl3TnHt164XOSxnY
         0S8OHJBk6cjXcxQZr4gvQIui9PWbhdcokqv7KNryQZ5suTgHh6YQn6PkDXxIhdNfC4nh
         S1PNsD+6s2ERVWyOgZgHozt9fUexfik+JqEKzndTkFU8M2q0suB37eKjtgcpkaxLIz3B
         Z7EIPdmI6r+nkuLST41FldXqUW5iqRcuFb7ZzwrxoPgwHhcRroQZWP/XLPL5ZDe80MSh
         e9aehzpBpvxHTX/bSzdUFakvogtxpO264gPqz2Z+1vFtxvrk+X2Yyr4d8YgfqPCRaHAp
         MXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=BxQ+2CjuZy+hcNBsSaMCuzJiRjll8azcJ4nJulgGv/M=;
        b=0WXYTIanXV1GQIFvwI0IXAScm1abY0Rc41wpls0wT8wUKRGVhdjOJnOpxbpF0tObfZ
         gMCIpii9Lyv6pozxigYVJi0yQ4Df96sLyxrVy86KiAZBscg4c3mymwKlQbYog1yCZuHJ
         QDoXnyXi1i715lis82Zcx+R6EkCVrMxieXrBBbivvXz9dDoeNQxMlbn9Z0X89jhJcOyG
         jNAMxWqHX/fhbp5gtQd10F2gwQKje0STjoIyx2SC5rg6j/Vb5+QtgON9gh9mjFBD7P3/
         VRVzmgzewt0lIssle2hqKxJyjJWyfI9jXLNQqwW2slUOqOdko0Rf88wrqvEj0O9jdrLR
         tegQ==
X-Gm-Message-State: AOAM532awiwaKI9p1lB+MHZ7D27fAmnLzJav+P/AJD+zOT4jriwrmtTN
        rgDFxPClAspFgYAo32JDX48kwg==
X-Google-Smtp-Source: ABdhPJw8sAtvUQiV63Cg2IplWlMfggCEG5H1TIcbkoGHDAG4W4Kcnkcdkc2NgEr80XFgOwD4o7UyFA==
X-Received: by 2002:a17:903:2281:b0:154:50ab:72c6 with SMTP id b1-20020a170903228100b0015450ab72c6mr1645289plh.51.1648678366133;
        Wed, 30 Mar 2022 15:12:46 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:3728:cfe6:997a:fb8])
        by smtp.gmail.com with ESMTPSA id p10-20020a056a000b4a00b004fd9a6a2a39sm4355898pfo.184.2022.03.30.15.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 15:12:45 -0700 (PDT)
Date:   Wed, 30 Mar 2022 15:12:39 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com
Subject: Re: [PATCH v3 3/3] object-info: add option for retrieving object info
Message-ID: <YkTV19+eCQNq/C5s@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
        jonathantanmy@google.com, philipoakley@iee.email,
        johncai86@gmail.com
References: <20220208235631.732466-1-calvinwan@google.com>
 <20220328191112.3092139-1-calvinwan@google.com>
 <20220328191112.3092139-4-calvinwan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220328191112.3092139-4-calvinwan@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.03.28 19:11, Calvin Wan wrote:
> Sometimes it is useful to get information about an object without
> having to download it completely. The server logic has already been
> implemented as “a2ba162cda (object-info: support for retrieving object
> info, 2021-04-20)”. This patch implements the client option for
> it. Currently, only 'size' is supported, however future patches can
> implement additional options.
> 
> Add ‘--object-info’ option to fetch. This option allows the client to
> make an object-info command request to a server that supports protocol
> v2. If the server is v2, but does not allow for the object-info
> command request, fetch the objects as if it were a standard fetch
> (however without changing any refs). Therefore, hook `fetch
> object-info` into transport_fetch_refs() to easily fallback if needed.
> 
> A previous patch added the `transfer.advertiseObjectInfo` config
> option, of which this patch utilizes to test the fallback.
> 
> ---
>  Documentation/fetch-options.txt |   5 ++
>  Documentation/git-fetch.txt     |   1 +
>  builtin/fetch.c                 |  36 ++++++++-
>  fetch-pack.c                    |  42 +++++++++-
>  fetch-pack.h                    |   9 +++
>  t/t5583-fetch-object-info.sh    | 138 ++++++++++++++++++++++++++++++++
>  transport-helper.c              |   8 +-
>  transport-internal.h            |   1 +
>  transport.c                     |  75 ++++++++++++++++-
>  transport.h                     |   9 +++
>  10 files changed, 315 insertions(+), 9 deletions(-)
>  create mode 100755 t/t5583-fetch-object-info.sh

> diff --git a/fetch-pack.c b/fetch-pack.c
> index b709a61baf..36e3d1c5d0 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1269,6 +1269,27 @@ static void write_command_and_capabilities(struct strbuf *req_buf,
>  	packet_buf_delim(req_buf);
>  }
>  
> +void send_object_info_request(int fd_out, struct object_info_args *args)
> +{
> +	struct strbuf req_buf = STRBUF_INIT;
> +	int i;
> +
> +	write_command_and_capabilities(&req_buf, args->server_options, "object-info");
> +
> +	if (string_list_has_string(args->object_info_options, "size"))
> +		packet_buf_write(&req_buf, "size");

Do we need a newline after "size" here? It's not clear to me that it's
necessary; Documentation/technical/protocol-v2.txt just says
"command-specific-args are packet line framed arguments defined by each
individual command", but the oid arguments below have a newline, so we
should be consistent one way or the other.

It looks like the server-side implementation wants just a bare "size"
string (no newline), but I suspect that either is OK because the
packet_reader is probably using PACKET_READ_CHOMP_NEWLINE.


> +	for (i = 0; i < args->oids->nr; i++) {
> +		packet_buf_write(&req_buf, "oid %s\n", oid_to_hex(&args->oids->oid[i]));
> +	}
> +
> +	packet_buf_flush(&req_buf);
> +	if (write_in_full(fd_out, req_buf.buf, req_buf.len) < 0)
> +		die_errno(_("unable to write request to remote"));
> +
> +	strbuf_release(&req_buf);
> +}
> +

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
> +
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

The comment at the top of this function says that callers should be
prepared to fallback to normal fetch if this function fails. The only
way it can currently fail is if we are using protocol V2 but the server
doesn't support object-info. Rather than die() if we're on protocol V1
or V0, can we also return a failure here and let callers fallback to
fetch?

> +	case protocol_unknown_version:
> +		BUG("unknown protocol version");
> +	}
> +
> +	if (packet_reader_read(&reader) != PACKET_READ_NORMAL) {
> +		die(_("error reading object info header"));
> +	}
> +	if (strcmp(reader.line, "size")) {
> +		die(_("expected 'size', received '%s'"), reader.line);
> +	}
> +	while (packet_reader_read(&reader) == PACKET_READ_NORMAL) {
> +		printf("%s\n", reader.line);
> +	}
> +	check_stateless_delimiter(transport->stateless_rpc, &reader, "stateless delimiter expected");
> +
> +	return 1;
> +}
> +
