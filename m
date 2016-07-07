Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4C5B2070D
	for <e@80x24.org>; Thu,  7 Jul 2016 20:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385AbcGGUiB (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 16:38:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57910 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751732AbcGGUh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 16:37:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0613F2B5B9;
	Thu,  7 Jul 2016 16:37:58 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6YnvRDlqIK3cs1EUJ646QtdEs5c=; b=eA+ZmH
	1gaOTdMvXSNtsh8iKYvtW6C/wZ64eJMBcQ+XVGHhtzr+8TQvcOD2LsthxGV3B6gN
	UXw9tJsy3iCiMPuJOoEGfiY2FCaNBh3+/4Ous1OpsBqpfq09rj1XXRvlTWVFKBez
	y6p6bVrkUihE7VrJqXENowQ80aJPAwe9+Alxs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wjlZUz25V1xCKHg6TB2aZhOvccjEsiPB
	k+B6+vrLXenjJkgdj5MXjyy9D6xcxGfucR4x2o/LwiHhdOH+HkUyn/LTuqDa64K3
	1twJSg3VADQxVTayG8GhiyR8HL/JFMETjF2op9Hv1NEExBREMq/+C4d1+efAYKIg
	s9pYLwF1eXM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F1A672B5B8;
	Thu,  7 Jul 2016 16:37:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 745C62B5B7;
	Thu,  7 Jul 2016 16:37:57 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	git@vger.kernel.org, e@80x24.org, peff@peff.net, dwwang@google.com,
	dennis@kaarsemaker.net
Subject: Re: [PATCH 2/4] receive-pack: implement advertising and receiving push options
References: <20160707011218.3690-1-sbeller@google.com>
	<20160707011218.3690-3-sbeller@google.com>
Date:	Thu, 07 Jul 2016 13:37:55 -0700
In-Reply-To: <20160707011218.3690-3-sbeller@google.com> (Stefan Beller's
	message of "Wed, 6 Jul 2016 18:12:16 -0700")
Message-ID: <xmqqa8htp4kc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B04AE390-4482-11E6-BCC6-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> While documenting
> this, fix a nit in the `receive.advertiseAtomic` wording.
>  
>  receive.advertiseAtomic::
>  	By default, git-receive-pack will advertise the atomic push
> -	capability to its clients. If you don't want to this capability
> +	capability to its clients. If you don't want this capability
> +	to be advertised, set this variable to false.
> +
> +receive.advertisePushOptions::
> +	By default, git-receive-pack will advertise the push options capability
> +	to its clients. If you don't want this capability
>  	to be advertised, set this variable to false.

I think we correcting the nit by avoiding passive voice, i.e.

	If you don't want to advertise this capability, set this
	variable to false.

would make it easier to read.

>  in packet-line format to the client, followed by a flush-pkt.  The only
>  real difference is that the capability listing is different - the only
> -possible values are 'report-status', 'delete-refs' and 'ofs-delta'.
> +possible values are 'report-status', 'delete-refs', 'ofs-delta' and
> +'push-options'.

OK.

> +push-options
> +------------
> +
> +If the server sends the 'push-options' capability it is capable to accept

Two nits:

 - A comma would make it easier to read.
 - "capable" goes with "of <gerund>", while "able" goes with "to <infinitive>".

i.e. "... capability, it is capable of accepting..."

> +push options after the update commands have been sent. If the pushing client
> +requests this capability, the server will pass the options to the pre and post
> +receive hooks that process this push request.

Missing dashes, i.e. "pre- and post-receive hooks"?

> @@ -207,6 +214,8 @@ static void show_ref(const char *path, const unsigned char *sha1)
>  			      "report-status delete-refs side-band-64k quiet");
>  		if (advertise_atomic_push)
>  			strbuf_addstr(&cap, " atomic");
> +		if (advertise_push_options)
> +			strbuf_addstr(&cap, " push-options");
>  		if (prefer_ofs_delta)
>  			strbuf_addstr(&cap, " ofs-delta");
>  		if (push_cert_nonce)

Hmph, was there a good reason to add it in the middle (contrast to
the previous addition to the "only possible values are..."
enumeration)?

> +static struct string_list *read_push_options()

static struct string_list *read_push_options(void)

> +{
> +	int i;
> +	struct string_list *ret = xmalloc(sizeof(*ret));
> +	string_list_init(ret, 1);
> +
> +	/* NEEDSWORK: expose the limitations to be configurable. */
> +	int max_options = 32;
> +
> +	/*
> +	 * NEEDSWORK: expose the limitations to be configurable;
> +	 * Once the limit can be lifted, include a way for payloads
> +	 * larger than one pkt, e.g allow a payload of up to
> +	 * LARGE_PACKET_MAX - 1 only, and reserve the last byte
> +	 * to indicate whether the next pkt continues with this
> +	 * push option.
> +	 */
> +	int max_size = 1024;

Good NEEDSWORK comments; perhaps also hint that the configuration
must not come from the repository level configuration file (i.e.
Peff's "scoped configuration" from jk/upload-pack-hook topic)?

> +	for (i = 0; i < max_options; i++) {
> +		char *line;
> +		int len;
> +
> +		line = packet_read_line(0, &len);
> +
> +		if (!line)
> +			break;
> +
> +		if (len > max_size)
> +			die("protocol error: server configuration allows push "
> +			    "options of size up to %d bytes", max_size);
> +
> +		len = strcspn(line, "\n");
> +		line[len] = '\0';
> +
> +		string_list_append(ret, line);
> +	}
> +	if (i == max_options)
> +		die("protocol error: server configuration only allows up "
> +		    "to %d push options", max_options);

When not going over ssh://, does the user sees these messages?

More importantly, if we plan to make this configurable and not make
the limit a hardwired constant of the wire protocol, it may be
better to advertise push-options capability with the limit, e.g.
"push-options=32" (or even "push-options=1024/32"), so that the
client side can count and abort early?

I wondered how well the extra flush works with the extra framing
smart-http does to wrap the wire protocol; as I do not see any
change to the http side, I'd assume that there is no issue.

> +
> +	return ret;
> +}
> +
>  static const char *parse_pack_header(struct pack_header *hdr)
>  {
>  	switch (read_pack_header(0, hdr)) {
> @@ -1773,6 +1829,9 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
>  		const char *unpack_status = NULL;
>  		struct string_list *push_options = NULL;
>  
> +		if (use_push_options)
> +			push_options = read_push_options();
> +
>  		prepare_shallow_info(&si, &shallow);
>  		if (!si.nr_ours && !si.nr_theirs)
>  			shallow_update = 0;

