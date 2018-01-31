Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF3CC1F404
	for <e@80x24.org>; Wed, 31 Jan 2018 15:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932081AbeAaPWx (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 10:22:53 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:43635 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932066AbeAaPWt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 10:22:49 -0500
Received: by mail-qt0-f194.google.com with SMTP id s3so22232121qtb.10
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 07:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=BkhC02rDaHhJshXGGEvILXhzazIPrNqXP0uaGH7+4QY=;
        b=mDUJZNdWjX7dv3NU3q2lNhzdPG6BYPdWTjjgLoP811QEC1iGz+Ir2i/tUFce36Lu7m
         S1Us6Jofv8p0oRYxxre0QvgK4lg/1nSuED//S68lAJ7kqdKYUX3p0u23f5hjLAauyB1A
         kGE9HDV4ckayMLrqBWF3/B8toqqdaz7M5KWjTaXoppsMRS2Quj9GH9yFFPDFH658Wrj3
         QAzVHwdSy8XgJFbn3RBi8B8fgJ1lZENopbIRahBvJw9w9o7+HuGXlPxILreVZuEtPWzi
         nOq1Gk4NinJz82cGLUjrfwOfQzcRCWcqShI8ycNblL8pTTG7tQdEzSZn0wFhp9OV9ifN
         mFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=BkhC02rDaHhJshXGGEvILXhzazIPrNqXP0uaGH7+4QY=;
        b=faE6awjUMl3fjoMT3nx7JcDjNZ6o6f8mhJu3Y8yCXaEzYTOEJcu4c9bOJASqWS3ffI
         a8xr+fOKkmwVoil1ddz8V6xXuMYSLzP7TozjNsO0u/ds2Nr9yyt9yAVJHv4LRLjvXHLW
         K5G4uhYBBhl0xn+CVnb6UKhovq7eiNyLVscYuC+jJFfcOZzokBY56+NxrAoCuOw5dscP
         8oF+9SE+ewpVMNFq+AM77Tit9Mox4t1XJALNoSjth+MEi6YMzLZBEWCLygiaRi0Uranf
         NcZmWgThxLT54LsjpWGh6YJhG1Ewh/WY/uTvcRGC9dL7qPp6UZA+u8B6COlPi03RGQ4Q
         nVMQ==
X-Gm-Message-State: AKwxytexcztyXmP98tAwYVuZs9gGmR8xfAz8Mqwl2afZyHWnxJdyUW+s
        zTLkXar5I/5YNgMJqs6wrSk=
X-Google-Smtp-Source: AH8x226pbealPqnaVvRIGUAiPU3HQiuXqTsPLGIXKOnJJxn1xohv6NMUIYFHu+MRMj7VszSBCM1jIw==
X-Received: by 10.237.36.152 with SMTP id t24mr56266965qtc.136.1517412168563;
        Wed, 31 Jan 2018 07:22:48 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id 23sm7766757qtx.33.2018.01.31.07.22.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 07:22:47 -0800 (PST)
Subject: Re: [PATCH v2 14/27] connect: request remote refs using v2
To:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, jrnieder@gmail.com
References: <20180103001828.205012-1-bmwill@google.com>
 <20180125235838.138135-1-bmwill@google.com>
 <20180125235838.138135-15-bmwill@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2007efc8-ec31-0267-9b83-392a9d2eaf4a@gmail.com>
Date:   Wed, 31 Jan 2018 10:22:46 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180125235838.138135-15-bmwill@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/25/2018 6:58 PM, Brandon Williams wrote:
> Teach the client to be able to request a remote's refs using protocol
> v2.  This is done by having a client issue a 'ls-refs' request to a v2
> server.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>   builtin/upload-pack.c  |  10 ++--
>   connect.c              | 123 ++++++++++++++++++++++++++++++++++++++++++++++++-
>   remote.h               |   4 ++
>   t/t5702-protocol-v2.sh |  28 +++++++++++
>   transport.c            |   2 +-
>   5 files changed, 160 insertions(+), 7 deletions(-)
>   create mode 100755 t/t5702-protocol-v2.sh
>
> diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
> index 8d53e9794..a757df8da 100644
> --- a/builtin/upload-pack.c
> +++ b/builtin/upload-pack.c
> @@ -5,6 +5,7 @@
>   #include "parse-options.h"
>   #include "protocol.h"
>   #include "upload-pack.h"
> +#include "serve.h"
>   
>   static const char * const upload_pack_usage[] = {
>   	N_("git upload-pack [<options>] <dir>"),
> @@ -16,6 +17,7 @@ int cmd_upload_pack(int argc, const char **argv, const char *prefix)
>   	const char *dir;
>   	int strict = 0;
>   	struct upload_pack_options opts = { 0 };
> +	struct serve_options serve_opts = SERVE_OPTIONS_INIT;
>   	struct option options[] = {
>   		OPT_BOOL(0, "stateless-rpc", &opts.stateless_rpc,
>   			 N_("quit after a single request/response exchange")),
> @@ -48,11 +50,9 @@ int cmd_upload_pack(int argc, const char **argv, const char *prefix)
>   
>   	switch (determine_protocol_version_server()) {
>   	case protocol_v2:
> -		/*
> -		 * fetch support for protocol v2 has not been implemented yet,
> -		 * so ignore the request to use v2 and fallback to using v0.
> -		 */
> -		upload_pack(&opts);
> +		serve_opts.advertise_capabilities = opts.advertise_refs;
> +		serve_opts.stateless_rpc = opts.stateless_rpc;
> +		serve(&serve_opts);
>   		break;
>   	case protocol_v1:
>   		/*
> diff --git a/connect.c b/connect.c
> index f2157a821..3c653b65b 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -12,9 +12,11 @@
>   #include "sha1-array.h"
>   #include "transport.h"
>   #include "strbuf.h"
> +#include "version.h"
>   #include "protocol.h"
>   
>   static char *server_capabilities;
> +static struct argv_array server_capabilities_v2 = ARGV_ARRAY_INIT;
>   static const char *parse_feature_value(const char *, const char *, int *);
>   
>   static int check_ref(const char *name, unsigned int flags)
> @@ -62,6 +64,33 @@ static void die_initial_contact(int unexpected)
>   		      "and the repository exists."));
>   }
>   
> +/* Checks if the server supports the capability 'c' */
> +static int server_supports_v2(const char *c, int die_on_error)
> +{
> +	int i;
> +
> +	for (i = 0; i < server_capabilities_v2.argc; i++) {
> +		const char *out;
> +		if (skip_prefix(server_capabilities_v2.argv[i], c, &out) &&
> +		    (!*out || *out == '='))
> +			return 1;
> +	}
> +
> +	if (die_on_error)
> +		die("server doesn't support '%s'", c);
> +
> +	return 0;
> +}
> +
> +static void process_capabilities_v2(struct packet_reader *reader)
> +{
> +	while (packet_reader_read(reader) == PACKET_READ_NORMAL)
> +		argv_array_push(&server_capabilities_v2, reader->line);
> +
> +	if (reader->status != PACKET_READ_FLUSH)
> +		die("protocol error");
> +}
> +
>   enum protocol_version discover_version(struct packet_reader *reader)
>   {
>   	enum protocol_version version = protocol_unknown_version;
> @@ -85,7 +114,7 @@ enum protocol_version discover_version(struct packet_reader *reader)
>   	/* Maybe process capabilities here, at least for v2 */
>   	switch (version) {
>   	case protocol_v2:
> -		die("support for protocol v2 not implemented yet");
> +		process_capabilities_v2(reader);
>   		break;
>   	case protocol_v1:
>   		/* Read the peeked version line */
> @@ -293,6 +322,98 @@ struct ref **get_remote_heads(struct packet_reader *reader,
>   	return list;
>   }
>   
> +static int process_ref_v2(const char *line, struct ref ***list)
> +{
> +	int ret = 1;
> +	int i = 0;

nit: you set 'i' here, but first use it in a for loop with blank 
initializer. Perhaps keep the first assignment closer to the first use?

> +	struct object_id old_oid;
> +	struct ref *ref;
> +	struct string_list line_sections = STRING_LIST_INIT_DUP;
> +
> +	if (string_list_split(&line_sections, line, ' ', -1) < 2) {
> +		ret = 0;
> +		goto out;
> +	}
> +
> +	if (get_oid_hex(line_sections.items[i++].string, &old_oid)) {
> +		ret = 0;
> +		goto out;
> +	}
> +
> +	ref = alloc_ref(line_sections.items[i++].string);
> +
> +	oidcpy(&ref->old_oid, &old_oid);
> +	**list = ref;
> +	*list = &ref->next;
> +
> +	for (; i < line_sections.nr; i++) {
> +		const char *arg = line_sections.items[i].string;
> +		if (skip_prefix(arg, "symref-target:", &arg))
> +			ref->symref = xstrdup(arg);
> +
> +		if (skip_prefix(arg, "peeled:", &arg)) {
> +			struct object_id peeled_oid;
> +			char *peeled_name;
> +			struct ref *peeled;
> +			if (get_oid_hex(arg, &peeled_oid)) {
> +				ret = 0;
> +				goto out;
> +			}
> +
> +			peeled_name = xstrfmt("%s^{}", ref->name);
> +			peeled = alloc_ref(peeled_name);
> +
> +			oidcpy(&peeled->old_oid, &peeled_oid);
> +			**list = peeled;
> +			*list = &peeled->next;
> +
> +			free(peeled_name);
> +		}
> +	}
> +
> +out:
> +	string_list_clear(&line_sections, 0);
> +	return ret;
> +}
> +
> +struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
> +			     struct ref **list, int for_push,
> +			     const struct argv_array *ref_patterns)
> +{
> +	int i;
> +	*list = NULL;
> +
> +	/* Check that the server supports the ls-refs command */
> +	/* Issue request for ls-refs */
> +	if (server_supports_v2("ls-refs", 1))
> +		packet_write_fmt(fd_out, "command=ls-refs\n");
> +
> +	if (server_supports_v2("agent", 0))
> +	    packet_write_fmt(fd_out, "agent=%s", git_user_agent_sanitized());
> +
> +	packet_delim(fd_out);
> +	/* When pushing we don't want to request the peeled tags */
> +	if (!for_push)
> +		packet_write_fmt(fd_out, "peel\n");
> +	packet_write_fmt(fd_out, "symrefs\n");
> +	for (i = 0; ref_patterns && i < ref_patterns->argc; i++) {
> +		packet_write_fmt(fd_out, "ref-pattern %s\n",
> +				 ref_patterns->argv[i]);
> +	}
> +	packet_flush(fd_out);
> +
> +	/* Process response from server */
> +	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
> +		if (!process_ref_v2(reader->line, &list))
> +			die("invalid ls-refs response: %s", reader->line);
> +	}
> +
> +	if (reader->status != PACKET_READ_FLUSH)
> +		die("protocol error");
> +
> +	return list;
> +}
> +
>   static const char *parse_feature_value(const char *feature_list, const char *feature, int *lenp)
>   {
>   	int len;
> diff --git a/remote.h b/remote.h
> index 2016461df..21d0c776c 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -151,10 +151,14 @@ void free_refs(struct ref *ref);
>   
>   struct oid_array;
>   struct packet_reader;
> +struct argv_array;
>   extern struct ref **get_remote_heads(struct packet_reader *reader,
>   				     struct ref **list, unsigned int flags,
>   				     struct oid_array *extra_have,
>   				     struct oid_array *shallow_points);
> +extern struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
> +				    struct ref **list, int for_push,
> +				    const struct argv_array *ref_patterns);
>   
>   int resolve_remote_symref(struct ref *ref, struct ref *list);
>   int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid);
> diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
> new file mode 100755
> index 000000000..4bf4d61ac
> --- /dev/null
> +++ b/t/t5702-protocol-v2.sh
> @@ -0,0 +1,28 @@
> +#!/bin/sh
> +
> +test_description='test git wire-protocol version 2'
> +
> +TEST_NO_CREATE_REPO=1
> +
> +. ./test-lib.sh
> +
> +# Test protocol v2 with 'file://' transport
> +#
> +test_expect_success 'create repo to be served by file:// transport' '
> +	git init file_parent &&
> +	test_commit -C file_parent one
> +'
> +
> +test_expect_success 'list refs with file:// using protocol v2' '
> +	GIT_TRACE_PACKET=1 git -c protocol.version=2 \
> +		ls-remote --symref "file://$(pwd)/file_parent" >actual 2>log &&
> +
> +	# Server responded using protocol v2
> +	cat log &&
> +	grep "git< version 2" log &&
> +
> +	git ls-remote --symref "file://$(pwd)/file_parent" >expect &&
> +	test_cmp actual expect
> +'
> +
> +test_done
> diff --git a/transport.c b/transport.c
> index 83d9dd1df..ffc6b2614 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -204,7 +204,7 @@ static struct ref *get_refs_via_connect(struct transport *transport, int for_pus
>   	data->version = discover_version(&reader);
>   	switch (data->version) {
>   	case protocol_v2:
> -		die("support for protocol v2 not implemented yet");
> +		get_remote_refs(data->fd[1], &reader, &refs, for_push, NULL);
>   		break;
>   	case protocol_v1:
>   	case protocol_v0:

