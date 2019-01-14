Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DC981F62E
	for <e@80x24.org>; Mon, 14 Jan 2019 22:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfANW1H (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 17:27:07 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38628 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfANW1H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 17:27:07 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so756914wrw.5
        for <git@vger.kernel.org>; Mon, 14 Jan 2019 14:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rYGDJoINPVRkBixowuNXwEXr5YqK4HRifLEJPQ7xayM=;
        b=EYrBPrCZ1yqcRxlAyv3EsSVsazxErbVoLHdT37fvntuWMABDkSGSP1EGda1LYesVFG
         buwztSM/J610KHlK/uDQBM3tnj6LfI4FHwjWSn3bxLvjg8d+ZDBCdYk9wMlGgsAvfCLd
         1jQks+XR3st86RGbCb990ktWIeFDhi30PvLQaWgtXT/VE/J6lJRPQv8uvQD/s7j3TOOZ
         6uI7dxQ0FU4/3HujixQR6Ak/cIn4ZThPfRKM7hcXQoF+n0N1aTpCBru/dKdBGSj0YK2u
         W7p/0nv/Sg8mJJPMpoDZjRGopyQddbW4qo4A9wdmkq9sQyKwlDu59Zv6Id0942V8Wy7D
         GUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rYGDJoINPVRkBixowuNXwEXr5YqK4HRifLEJPQ7xayM=;
        b=MXQduVEsFZsNG36oPBYmFYeCY8+HvP4DMA+NGu68yie21Y1DJKmVg/jqj78Jr+zLFE
         KdwDc6Cua+5T8NtGuUEzbgL9bMjRsxU/FC1nql/ZahOkdKDFuj5uGnc5zcG0G4+4Txe7
         3GczmPeUBV5qi98gkme+jtq9laWt8CwJY9jlgKeXjRADTFB6agNmmQdvlRe00agtLlGt
         03wC9G56+KPi3eb/dwmogOEhvJEoFbW3hEQ4VBnZroWaLRlSVMt8zK0XNz1eKWPNws0t
         CykR1/DxN9Rfj9JB8fOQJvKub3Iwt7tj579UD0guFFo2ExDWKcOSMALLbUMklbFc9KTT
         OhdQ==
X-Gm-Message-State: AJcUukdthNPlgPLP670SEpTRp0kLFK8xUdk/KpvAqv3CuSH7jiaIWDnp
        rtFmbPyOORZ82wDzf+I/yKU=
X-Google-Smtp-Source: ALg8bN4qq7saMdnkD/a+SAP2Bwfiqeah9X987xzEZjXABd7N6EQlOlYb2zF3Y2TyyIrfksHB27xcWw==
X-Received: by 2002:adf:fa05:: with SMTP id m5mr467459wrr.155.1547504824132;
        Mon, 14 Jan 2019 14:27:04 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p5sm18119258wmh.16.2019.01.14.14.27.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 14:27:03 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/4] {fetch,upload}-pack: sideband v2 fetch response
References: <cover.1547244620.git.jonathantanmy@google.com>
        <673b928b4158b0aecca843302483b48da5ed8d35.1547244620.git.jonathantanmy@google.com>
Date:   Mon, 14 Jan 2019 14:27:02 -0800
In-Reply-To: <673b928b4158b0aecca843302483b48da5ed8d35.1547244620.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Fri, 11 Jan 2019 14:18:16 -0800")
Message-ID: <xmqqk1j6ub7t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Currently, a response to a fetch request has sideband support only while
> the packfile is being sent, meaning that the server cannot send notices
> until the start of the packfile.
>
> Extend sideband support in protocol v2 fetch responses to the whole
> response. upload-pack will advertise it if the
> uploadpack.allowsidebandall configuration variable is set, and
> fetch-pack will automatically request it if advertised.
>
> If the sideband is to be used throughout the whole response, upload-pack
> will use it to send errors instead of prefixing a PKT-LINE payload with
> "ERR ".

Makes sense.

> diff --git a/fetch-pack.c b/fetch-pack.c
> index 3f9626dbf7..b89199891d 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1125,7 +1125,8 @@ static int add_haves(struct fetch_negotiator *negotiator,
>  static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
>  			      const struct fetch_pack_args *args,
>  			      const struct ref *wants, struct oidset *common,
> -			      int *haves_to_send, int *in_vain)
> +			      int *haves_to_send, int *in_vain,
> +			      int sideband_all)
>  {
>  	int ret = 0;
>  	struct strbuf req_buf = STRBUF_INIT;
> @@ -1151,6 +1152,8 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
>  		packet_buf_write(&req_buf, "include-tag");
>  	if (prefer_ofs_delta)
>  		packet_buf_write(&req_buf, "ofs-delta");
> +	if (sideband_all)
> +		packet_buf_write(&req_buf, "sideband-all");
>  
>  	/* Add shallow-info and deepen request */
>  	if (server_supports_feature("fetch", "shallow", 0))
> @@ -1359,6 +1362,10 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  	packet_reader_init(&reader, fd[0], NULL, 0,
>  			   PACKET_READ_CHOMP_NEWLINE |
>  			   PACKET_READ_DIE_ON_ERR_PACKET);
> +	if (server_supports_feature("fetch", "sideband-all", 0)) {
> +		reader.use_sideband = 1;
> +		reader.me = "fetch-pack";
> +	}
>  
>  	while (state != FETCH_DONE) {
>  		switch (state) {
> @@ -1392,7 +1399,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  		case FETCH_SEND_REQUEST:
>  			if (send_fetch_request(&negotiator, fd[1], args, ref,
>  					       &common,
> -					       &haves_to_send, &in_vain))
> +					       &haves_to_send, &in_vain,
> +					       reader.use_sideband))
>  				state = FETCH_GET_PACK;
>  			else
>  				state = FETCH_PROCESS_ACKS;

OK, so the "fetch" side enables sideband-all any time it knows that
the other side supports it.

It feels a bit strange at the logical level that reader.me is set
only when we are going to talk over "sideband-all".  I know that at
the implementation level, reader.me is only looked at when sideband
is use, but it still feels somewhat funny.  Future developers may
want to use reader.me to identify the entity that found some error
during a read, even when the sideband is not yet in use, and at that
point, uninitialized .me would be a source of an error.  IOW, that
assignment smells like a timebomb waiting to go off.

> @@ -483,16 +483,42 @@ enum packet_read_status packet_reader_read(struct packet_reader *reader)
>  		return reader->status;
>  	}
>  
> -	reader->status = packet_read_with_status(reader->fd,
> -						 &reader->src_buffer,
> -						 &reader->src_len,
> -						 reader->buffer,
> -						 reader->buffer_size,
> -						 &reader->pktlen,
> -						 reader->options);
> +	while (1) {
> +		int retval;
> +		reader->status = packet_read_with_status(reader->fd,
> +							 &reader->src_buffer,
> +							 &reader->src_len,
> +							 reader->buffer,
> +							 reader->buffer_size,
> +							 &reader->pktlen,
> +							 reader->options);
> +		if (!reader->use_sideband)
> +			break;
> +		retval = diagnose_sideband(reader->me, reader->buffer,
> +					   reader->pktlen, 1);
> +		switch (retval) {
> +			case SIDEBAND_PROTOCOL_ERROR:

Dedent (see previous step).

> +			case SIDEBAND_REMOTE_ERROR:
> +				BUG("should have died in diagnose_sideband");
> +			case SIDEBAND_FLUSH:
> +				goto nonprogress;
> +			case SIDEBAND_PRIMARY:
> +				if (reader->pktlen != 1)
> +					goto nonprogress;
> +				/*
> +				 * Since pktlen is 1, this is a keepalive
> +				 * packet. Wait for the next one.
> +				 */

What guarantees that a normal payload packet is never of length==1?

> +				break;
> +			default: /* SIDEBAND_PROGRESS */
> +				;
> +		}
> +	}
>  
> +nonprogress:

It is totally unclear why this label is called nonprogress.  Is it
that the primary purpose of the while loop above is to spin and eat
the keep-alive packets from the other side?  If so, then it sort-of
makes sense (i.e. "we are looking for progress-meter related
packets, but now we found something else, so let's leave the loop").

It would have greatly helped reviewers to have a comment in front of
that infinite loop, perhaps like

	/*
	 * Spin and consume the keep-alive packets
	 */
	while (1) {
		int keepalive = 0;

		get_packet();

		/* decide if we got a keepalive here */
		...
		keepalive = ...;

		if (keepalive) {
			/* do the keep-alive thing here */
			...
			continue;
		}

		/* do one-off thing for non-keepalive packet if any */
		...
		break;
	}

>  	if (reader->status == PACKET_READ_NORMAL)
> -		reader->line = reader->buffer;
> +		reader->line = reader->use_sideband ?
> +			reader->buffer + 1 : reader->buffer;

Is the one byte the sideband designator?

>  void packet_writer_write(struct packet_writer *writer, const char *fmt, ...)
> @@ -521,7 +548,8 @@ void packet_writer_write(struct packet_writer *writer, const char *fmt, ...)
>  	va_list args;
>  
>  	va_start(args, fmt);
> -	packet_write_fmt_1(writer->dest_fd, 0, "", fmt, args);
> +	packet_write_fmt_1(writer->dest_fd, 0,
> +			   writer->use_sideband ? "\1" : "", fmt, args);
>  	va_end(args);
>  }

As I am superstitious, I'd prefer to see octal literals to be fully
spelled out as 3-digit sequence, i.e. "\001".  Likewise for "\003".

> @@ -530,7 +558,8 @@ void packet_writer_error(struct packet_writer *writer, const char *fmt, ...)
>  	va_list args;
>  
>  	va_start(args, fmt);
> -	packet_write_fmt_1(writer->dest_fd, 0, "ERR ", fmt, args);
> +	packet_write_fmt_1(writer->dest_fd, 0,
> +			   writer->use_sideband ? "\3" : "ERR ", fmt, args);

OK, band#3 is an error message for emergency exit.  It is a bit
curious that this patch does not show any line from the existing
code in the context that reacts to the ERR string, but that is
because the errors are noticed at a lot lower level when the
sideband is in use than the code that currently checks for errors?

