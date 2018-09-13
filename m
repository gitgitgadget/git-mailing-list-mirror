Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37DB91F404
	for <e@80x24.org>; Thu, 13 Sep 2018 16:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbeIMVlc (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 17:41:32 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:44963 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbeIMVlb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 17:41:31 -0400
Received: by mail-wr1-f43.google.com with SMTP id v16-v6so6769789wro.11
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 09:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7Gq6cssixfmVhaEdhdN5eUosmMGngFccZZqCnM6EeFg=;
        b=hO4ALHPKGNum6T8YRxaOek6FhGmrlb49Vb8TtkXj00cAcX8xcH4afcKAdrwTQbYrH7
         VlSpstlfk9H7L1fzqB5m55cZTsS15q/BNLiaqPe1JyZ9EtTzQPiIcrL6IrU7x4Nv4DEQ
         omnEfmsaZJTrY10uAgJq1mKjwRFBXMIUEf+x2GZP+MREzN9CHb4rpI5lEezxc7USWGCT
         OndGewwugoCQvo2uudWBKUvyImAhRaRfxnm4Wafj7l6aT+Yz/98BfjEmFTZVahu3XHaZ
         Jyd6jufQTgJWiLE1mO1MxWKVS7YV5vRl3FHRIRXtCJA4XKvF9AP9fi5T6iWiU6tiG2C6
         O3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7Gq6cssixfmVhaEdhdN5eUosmMGngFccZZqCnM6EeFg=;
        b=BfIudkLK/BtQfOnmw7HMYTCJsqt5ZrC4/fonuhDGfsPK54tTGMhwy8V1XSMi1ax66o
         qy6fBfUDo6A3IXoNt60xzBe6wRFjHFUobhVzCmEdqsIdY0YGGVBQLAlfI7UExRDDIG5g
         Nn6iif+o2PWDvsfNsA1ZQ2xLCcXB1QeNoyGz4IbauV4alU+qvmanltbkxXO1q7yjHBIs
         hLzWfggm+/nq4Z7SImrj5xA8bqyM61K34uXpEBIZ6wmw548UBPbMCHKZdPVwdHjm/YqV
         pzW3RM2D41labW74D+l4E557LrfiQf4VlHFEKFIRQEF1pFYVdIzIQMVhJ2hNrRmvACBQ
         vtAQ==
X-Gm-Message-State: APzg51AJ7VSIkzKsdimiTD4oU7Xf1dXOTiqry8qpB0omAKVUaFxEGaZO
        l6w6tJmcX8aKP0BJ4vEiNkw=
X-Google-Smtp-Source: ANB0VdZ+b6yVfxX/mzNYEWn92lOlmk6viQjJzAatM+DtQNBXlI32etJxLugOoHQozszMLBlBncQ5rA==
X-Received: by 2002:a5d:6150:: with SMTP id y16-v6mr6567331wrt.141.1536856274808;
        Thu, 13 Sep 2018 09:31:14 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y128-v6sm5744844wmy.26.2018.09.13.09.31.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 09:31:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, l.s.r@web.de,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH 2/3] archive: implement protocol v2 archive command
References: <20180912053519.31085-1-steadmon@google.com>
        <20180912053519.31085-3-steadmon@google.com>
Date:   Thu, 13 Sep 2018 09:31:13 -0700
In-Reply-To: <20180912053519.31085-3-steadmon@google.com> (Josh Steadmon's
        message of "Tue, 11 Sep 2018 22:35:18 -0700")
Message-ID: <xmqq1s9xicku.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> +static int do_v2_command_and_cap(int out)
> +{
> +	packet_write_fmt(out, "command=archive\n");
> +	/* Capability list would go here, if we had any. */
> +	packet_delim(out);
> +}
> +
>  static int run_remote_archiver(int argc, const char **argv,
>  			       const char *remote, const char *exec,
>  			       const char *name_hint)
> @@ -32,6 +41,7 @@ static int run_remote_archiver(int argc, const char **argv,
>  	struct remote *_remote;
>  	struct packet_reader reader;
>  	enum packet_read_status status;
> +	enum protocol_version version;
>  
>  	_remote = remote_get(remote);
>  	if (!_remote->url[0])
> @@ -41,6 +51,11 @@ static int run_remote_archiver(int argc, const char **argv,
>  
>  	packet_reader_init(&reader, fd[0], NULL, 0, PACKET_READ_CHOMP_NEWLINE);
>  
> +	version = discover_version(&reader);

The original version of upload-archive that is correctly running on
the other end sends either NACK (unable to spawn) or ACK (ready to
serve) to us without waiting for us to speak first, so peeking that
with this discover_version() is a safe thing to do.

> +	if (version == protocol_v2)
> +		do_v2_command_and_cap(fd[1]);
> +

With proto v2, "server capabilities" have already been collected in
server_capabilities_v2 array in discover_version().  We are to pick
and ask the capabilities in that function and respond.  Right now we
do not need to do much, as we saw that very thin implementation of
that function above.

>  	/*
>  	 * Inject a fake --format field at the beginning of the
>  	 * arguments, with the format inferred from our output

And then after that, both the original and updated protocol lets us
send the archive format and arguments (like revs and pathspecs),
followed by a flush packet...

> @@ -56,22 +71,24 @@ static int run_remote_archiver(int argc, const char **argv,
>  		packet_write_fmt(fd[1], "argument %s\n", argv[i]);
>  	packet_flush(fd[1]);

... which is a piece of code shared between the protocol versions
that ends here.

> -	status = packet_reader_read(&reader);
> -
> -	if (status == PACKET_READ_FLUSH)
> -		die(_("git archive: expected ACK/NAK, got a flush packet"));
> -	if (strcmp(reader.buffer, "ACK")) {
> -		if (starts_with(reader.buffer, "NACK "))
> -			die(_("git archive: NACK %s"), reader.buffer + 5);
> -		if (starts_with(reader.buffer, "ERR "))
> -			die(_("remote error: %s"), reader.buffer + 4);
> -		die(_("git archive: protocol error"));
> +	if (version == protocol_v0) {
> +		status = packet_reader_read(&reader);
> +
> +		if (status == PACKET_READ_FLUSH)
> +			die(_("git archive: expected ACK/NAK, got a flush packet"));
> +		if (strcmp(reader.buffer, "ACK")) {
> +			if (starts_with(reader.buffer, "NACK "))
> +				die(_("git archive: NACK %s"), reader.buffer + 5);
> +			if (starts_with(reader.buffer, "ERR "))
> +				die(_("remote error: %s"), reader.buffer + 4);
> +			die(_("git archive: protocol error"));
> +		}
> +
> +		status = packet_reader_read(&reader);
> +		if (status != PACKET_READ_FLUSH)
> +			die(_("git archive: expected a flush"));
>  	}

The original protocol lets upload-archive to report failure to spawn
the writer backend process and lets us act on it.  We do not need a
similar support in the updated protocol and instead can jump right
into receiving the archive stream because...?

> -	status = packet_reader_read(&reader);
> -	if (status != PACKET_READ_FLUSH)
> -		die(_("git archive: expected a flush"));
> -

>  	/* Now, start reading from fd[0] and spit it out to stdout */
>  	rv = recv_sideband("archive", fd[0], 1);
>  	rv |= transport_disconnect(transport);



> diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
> index 25d911635..534e8fd56 100644
> --- a/builtin/upload-archive.c
> +++ b/builtin/upload-archive.c
> @@ -5,6 +5,7 @@
>  #include "builtin.h"
>  #include "archive.h"
>  #include "pkt-line.h"
> +#include "protocol.h"
>  #include "sideband.h"
>  #include "run-command.h"
>  #include "argv-array.h"
> @@ -73,13 +74,53 @@ static ssize_t process_input(int child_fd, int band)
>  	return sz;
>  }
>  
> +static int handle_v2_command_and_cap(void)
> +{
> +	struct packet_reader reader;
> +	enum packet_read_status status;
> +
> +	packet_reader_init(&reader, 0, NULL, 0, PACKET_READ_CHOMP_NEWLINE);
> +
> +	packet_write_fmt(1, "version 2\n");

This lets the discover_version() on the other side notice that we
are speaking version 2.

> +	/*
> +	 * We don't currently send any capabilities, but maybe we could list
> +	 * supported archival formats?
> +	 */
> +	packet_flush(1);

process_capabilities_v2() expects the list of caps ends with a
flush, which is given here.

> +	status = packet_reader_read(&reader);
> +	if (status != PACKET_READ_NORMAL ||
> +	    strcmp(reader.buffer, "command=archive"))
> +		die(_("upload-archive: expected command=archive"));

The other side in do_v2_command_and_cap() would ask command=archive
and that is verified.  _() is unwanted, I suppose, by the way, as
you do not know what language the other side wants anyway.

> +	while (status == PACKET_READ_NORMAL) {
> +		/* We don't currently expect any client capabilities, but we
> +		 * should still read (and ignore) any that happen to get sent.
> +		 */
> +		status = packet_reader_read(&reader);

It is wrong to say we should "ignore".  If you are asked to behave
in a certain way by a capability that is not understood, the other
side expects you to honor that request and you have no idea how to
comply.  At least you should make sure that what is asked is among
the capabilities you offered (or you understand), and you should
error out when you see an unknown one, no?

> +	}
> +	if (status != PACKET_READ_DELIM)
> +		die(_("upload-archive: expected delim packet"));
> +
> +	/* Let git-upload-archive--writer handle the arguments. */

The choice of DELIM here over FLUSH is a bit curious, but it is
consistent between upload-archive and run-remote-archiver.

> +	return 0;
> +}
> +
>  int cmd_upload_archive(int argc, const char **argv, const char *prefix)
>  {
>  	struct child_process writer = { argv };
> +	enum protocol_version version = determine_protocol_version_server();
>  
>  	if (argc == 2 && !strcmp(argv[1], "-h"))
>  		usage(upload_archive_usage);
>  
> +	if (version == protocol_v2)
> +		handle_v2_command_and_cap();
> +	else {
> +		packet_write_fmt(1, "ACK\n");
> +		packet_flush(1);
> +	}
> +

This breaks the original protocol, no?  At this point we haven't
even tried to start the writer process, and letting the other side
go by giving ACK + flush prematurely.  After start_command() fails,
we may say NACK, but the other side is no longer listening to it.

>  	/*
>  	 * Set up sideband subprocess.
>  	 *
> @@ -96,9 +137,6 @@ int cmd_upload_archive(int argc, const char **argv, const char *prefix)
>  		die("upload-archive: %s", strerror(err));
>  	}
>  
> -	packet_write_fmt(1, "ACK\n");
> -	packet_flush(1);
> -
>  	while (1) {
>  		struct pollfd pfd[2];
>  
> diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
> index 2a97b27b0..4be74d6e9 100755
> --- a/t/t5000-tar-tree.sh
> +++ b/t/t5000-tar-tree.sh
> @@ -145,6 +145,11 @@ test_expect_success \
>  
>  check_tar b
>  
> +test_expect_success 'protocol v2 for remote' '
> +	GIT_PROTOCOL="version=2" git archive --remote=. HEAD >v2_remote.tar
> +'
> +check_tar v2_remote
> +
>  test_expect_success 'git archive --prefix=prefix/' '
>  	git archive --prefix=prefix/ HEAD >with_prefix.tar
>  '
