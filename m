Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 138021F576
	for <e@80x24.org>; Tue, 27 Feb 2018 06:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752017AbeB0GwE (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 01:52:04 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:52645 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751128AbeB0GwC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 01:52:02 -0500
Received: by mail-it0-f65.google.com with SMTP id k135so8889802ite.2
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 22:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NSeynwFsyGxD/C4cCCS277tsUEdv41tnZgHz6YWRek4=;
        b=nbI9DlC8bzm4BnSVRvkxDE5xX1Pk/9YejR6hV15AoffvzTUgsZ3kmBmgt0arKcp7tL
         K+P/qMa8k/RyYW9DM6Ox78bN8b1RYyiubmUEXaSPoDQx7DZLHs0ha2HXBiKsrAEWowP9
         ogVdVPqxh/itACvhF938UgLy/uOD93MXvFDtd6TTC1Zrfo2XrIwGJTp/TGPVQPKImReE
         9qh4dV87YRtm7VmO8ELHbmQwiWHIDrS/pDUECzYjxj0nDOhNnTJFcyMb5Akkaifi0IAA
         bjBm52rC4oTzmsPJKk0LT45n6e48j5tpbGQamaaLhuEGm6sFYT12oWRJctum9t38Qmbw
         AYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NSeynwFsyGxD/C4cCCS277tsUEdv41tnZgHz6YWRek4=;
        b=THD1xZkdPRxlbouUKwnE0ulzcCWs9UzTGA5ajI9RSjP2BAZDbNv+FVDxKlFD6tKRGr
         PnP5N/VnQxt1YVhX529ZAozPpSbeoRy98/J9sak543CERmiCbOcv3xiskbBZaFRPmPpZ
         pJCH69UpkWhd+R7cG1uy9lRESqCaHGJZrCi5Ao2nT2RFbg48q+hK0e1riECHkkLEAlpg
         XYofKMCDrhflM2A8BgQMum/tqwNmv58TN61y+AD2tE2vwteWxLBmIIxG0DBi8w2UmvDr
         EiVye5Qe8CD/aCm4eXzF23XcVh5ANlokp+lP4Ohx3OcVmZR0BTSmtn3vHL4Ps4NE6pGO
         4t9w==
X-Gm-Message-State: APf1xPDDqzEvDVDxee7zOQwwBIa04rZQxaF2pKZEKfsRyI7Zs25qJ4fz
        jD1LagbErmSr9VuS7YA+6sg=
X-Google-Smtp-Source: AG47ELtdI93Ot12Z9Ka/t82r+HdW3fMw2wxDtTVNhMfHRqxeUwrhps0rI5/3O4HQAkyybKhEEf8BVQ==
X-Received: by 10.36.61.201 with SMTP id n192mr7804287itn.152.1519714321430;
        Mon, 26 Feb 2018 22:52:01 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id r65sm6794228ioe.26.2018.02.26.22.52.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Feb 2018 22:52:00 -0800 (PST)
Date:   Mon, 26 Feb 2018 22:51:58 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com
Subject: Re: [PATCH v3 14/35] connect: request remote refs using v2
Message-ID: <20180227065158.GH65699@aiede.svl.corp.google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-15-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207011312.189834-15-bmwill@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:

> Teach the client to be able to request a remote's refs using protocol
> v2.  This is done by having a client issue a 'ls-refs' request to a v2
> server.

Yay, ls-remote support!

[...]
> --- a/builtin/upload-pack.c
> +++ b/builtin/upload-pack.c
> @@ -5,6 +5,7 @@
>  #include "parse-options.h"
>  #include "protocol.h"
>  #include "upload-pack.h"
> +#include "serve.h"

nit, no change needed in this patch: What is a good logical order for
the #includes here?  Bonus points if there's a tool to make it happen
automatically.

Asking since adding #includes like this at the end tends to result in
a harder-to-read list of #includes, sometimes with duplicates, and
often producing conflicts when multiple patches in flight add a
#include to the same file.

[...]
> @@ -48,11 +50,9 @@ int cmd_upload_pack(int argc, const char **argv, const char *prefix)
>  
>  	switch (determine_protocol_version_server()) {
>  	case protocol_v2:
> -		/*
> -		 * fetch support for protocol v2 has not been implemented yet,
> -		 * so ignore the request to use v2 and fallback to using v0.
> -		 */
> -		upload_pack(&opts);
> +		serve_opts.advertise_capabilities = opts.advertise_refs;
> +		serve_opts.stateless_rpc = opts.stateless_rpc;
> +		serve(&serve_opts);

Interesting!  daemon.c has its own (file-local) serve() function;
can one of the two be renamed?

I actually like both names: serve() is a traditional name for the
function a server calls when it's done setting up and is ready to
serve.  But the clash is confusing.

[...]
> +++ b/connect.c
> @@ -12,9 +12,11 @@
>  #include "sha1-array.h"
>  #include "transport.h"
>  #include "strbuf.h"
> +#include "version.h"
>  #include "protocol.h"
>  
>  static char *server_capabilities;
> +static struct argv_array server_capabilities_v2 = ARGV_ARRAY_INIT;

Can a quick doc comment describe these and how they relate?

Is only one of them set, based on which protocol version is in use?
Should server_capabilities be renamed to server_capabilities_v1?

>  static const char *parse_feature_value(const char *, const char *, int *);
>  
>  static int check_ref(const char *name, unsigned int flags)
> @@ -62,6 +64,33 @@ static void die_initial_contact(int unexpected)
>  		      "and the repository exists."));
>  }
>  
> +/* Checks if the server supports the capability 'c' */
> +int server_supports_v2(const char *c, int die_on_error)
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

Nice.
> +
> +static void process_capabilities_v2(struct packet_reader *reader)
> +{
> +	while (packet_reader_read(reader) == PACKET_READ_NORMAL)
> +		argv_array_push(&server_capabilities_v2, reader->line);
> +
> +	if (reader->status != PACKET_READ_FLUSH)
> +		die("protocol error");

Can this say more?  E.g. "expected flush after capabilities, got <foo>"?

[...]
> @@ -85,7 +114,7 @@ enum protocol_version discover_version(struct packet_reader *reader)
>  	/* Maybe process capabilities here, at least for v2 */

Is this comment out of date now?

>  	switch (version) {
>  	case protocol_v2:
> -		die("support for protocol v2 not implemented yet");
> +		process_capabilities_v2(reader);
>  		break;
>  	case protocol_v1:
>  		/* Read the peeked version line */
> @@ -293,6 +322,98 @@ struct ref **get_remote_heads(struct packet_reader *reader,
>  	return list;
>  }
>  
> +static int process_ref_v2(const char *line, struct ref ***list)

What does the return value represent?

Could it return the more typical 0 on success, -1 on error?

> +{
> +	int ret = 1;
> +	int i = 0;
> +	struct object_id old_oid;
> +	struct ref *ref;
> +	struct string_list line_sections = STRING_LIST_INIT_DUP;
> +
> +	if (string_list_split(&line_sections, line, ' ', -1) < 2) {

Can there be a comment describing the expected format?

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

Ref names cannot contains a space, so this is safe.  Good.

> +
> +	oidcpy(&ref->old_oid, &old_oid);
> +	**list = ref;
> +	*list = &ref->next;
> +
> +	for (; i < line_sections.nr; i++) {
> +		const char *arg = line_sections.items[i].string;
> +		if (skip_prefix(arg, "symref-target:", &arg))
> +			ref->symref = xstrdup(arg);

Using space-delimited fields in a single pkt-line means that
- values cannot contains a space
- total length is limited by the size of a pkt-line

Given the context, I think that's fine.  More generally it is tempting
to use a pkt-line per field to avoid the trouble v1 had with
capability lists crammed into a pkt-line, but I see why you used a
pkt-line per ref to avoid having to have sections-within-a-section.

My only potential worry is the length part: do we have an explicit
limit on the length of a ref name?  git-check-ref-format(1) doesn't
mention one.  A 32k ref name would be a bit ridiculous, though.

> +
> +		if (skip_prefix(arg, "peeled:", &arg)) {
> +			struct object_id peeled_oid;
> +			char *peeled_name;
> +			struct ref *peeled;
> +			if (get_oid_hex(arg, &peeled_oid)) {
> +				ret = 0;
> +				goto out;
> +			}

Can this also check that there's no trailing garbage after the oid?

[...]
> +
> +			peeled_name = xstrfmt("%s^{}", ref->name);

optional: can reuse a buffer to avoid allocation churn:

	struct strbuf peeled_name = STRBUF_INIT;

			strbuf_reset(&peeled_name);
			strbuf_addf(&peeled_name, "%s^{}", ref->name);
			// or strbuf_addstr(ref->name); strbuf_addstr("^{}");

 out:
 	strbuf_release(&peeled_name);

[...]
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

Since the code is so clear, I don't think the above two comments are
helping.

> +
> +	if (server_supports_v2("agent", 0))
> +	    packet_write_fmt(fd_out, "agent=%s", git_user_agent_sanitized());

whitespace nit: mixing tabs and spaces.  Does "make style" catch this?

> +
> +	packet_delim(fd_out);
> +	/* When pushing we don't want to request the peeled tags */

Can you say more about this?  In theory it would be nice to have the
peeled tags since they name commits whose history can be excluded from
the pack.

> +	if (!for_push)
> +		packet_write_fmt(fd_out, "peel\n");
> +	packet_write_fmt(fd_out, "symrefs\n");

Are symrefs useful during push?

> +	for (i = 0; ref_patterns && i < ref_patterns->argc; i++) {
> +		packet_write_fmt(fd_out, "ref-pattern %s\n",
> +				 ref_patterns->argv[i]);
> +	}

The exciting part.

Why do these pkts end with \n?  I would have expected the pkt-line
framing to work to delimit them.

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

Can this protocol error give more detail?  When diagnosing an error in
servers, proxies, or lower-level networking issues, informative protocol
errors can be very helpful (similar to syntax errors from a compiler).

[...]
> --- a/connect.h
> +++ b/connect.h
> @@ -16,4 +16,6 @@ extern int url_is_local_not_ssh(const char *url);
>  struct packet_reader;
>  extern enum protocol_version discover_version(struct packet_reader *reader);
>  
> +extern int server_supports_v2(const char *c, int die_on_error);

const char *cap, maybe?

[...]
> --- a/remote.h
> +++ b/remote.h
> @@ -151,10 +151,14 @@ void free_refs(struct ref *ref);
>  
>  struct oid_array;
>  struct packet_reader;
> +struct argv_array;
>  extern struct ref **get_remote_heads(struct packet_reader *reader,
>  				     struct ref **list, unsigned int flags,
>  				     struct oid_array *extra_have,
>  				     struct oid_array *shallow_points);
> +extern struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
> +				    struct ref **list, int for_push,
> +				    const struct argv_array *ref_patterns);

What is the difference between get_remote_heads and get_remote_refs?
A comment might help.  (BTW, thanks for making the new saner name to
replace get_remote_heads!)

[...]
> --- /dev/null
> +++ b/t/t5702-protocol-v2.sh
> @@ -0,0 +1,53 @@
> +#!/bin/sh
> +
> +test_description='test git wire-protocol version 2'

Woot!

[...]
> +test_expect_success 'list refs with git:// using protocol v2' '
> +	GIT_TRACE_PACKET=1 git -c protocol.version=2 \
> +		ls-remote --symref "$GIT_DAEMON_URL/parent" >actual 2>log &&
> +
> +	# Client requested to use protocol v2
> +	grep "git> .*\\\0\\\0version=2\\\0$" log &&
> +	# Server responded using protocol v2
> +	grep "git< version 2" log &&

optional: Could anchor these greps to make the test tighter (e.g. to
not match "version 20".

Thanks,
Jonathan
