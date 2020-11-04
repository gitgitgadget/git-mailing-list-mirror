Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AE4C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 21:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE09C207BB
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 21:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KWKwPSIB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbgKDVLt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 16:11:49 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56890 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729914AbgKDVLt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 16:11:49 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 853A6A37F1;
        Wed,  4 Nov 2020 16:11:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=igErxSKDtzvxk235iU2F04wWV1Y=; b=KWKwPS
        IBD+HBVCN7va0JjOhPznvhNogp3qO/6w23XxMTT64X1cCy+HpqOgpqZMlNM4QLIJ
        W28xRzlK7Pxth1TRugZw61vIKHftDEcSDqWDXrZ/zAwd1U2XAbUfyJ5rq1IqoEXc
        FKA4yxIEo/aRphtgC72Nq8KDVFWPesSAeOhJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=J3kuzAWBE7nW9jGU8z/k1hX4tTk3ywcZ
        dtxuO16UWnhd0HfHb+zDKe0ywF47wR8QI6uN023G69F1iP1ekDL8dE3lsF4sYcCv
        nW9uJlLcyGn6oxOURx5Ul1tg15m+MaMQLhO29uabhGgqLuKzWmsiXyCbjz0VKnVK
        dHmRKfyzGYk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D260A37F0;
        Wed,  4 Nov 2020 16:11:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 09690A37EF;
        Wed,  4 Nov 2020 16:11:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 06/11] serve: advertise trace2 SID in v2 capabilities
References: <cover.1604006121.git.steadmon@google.com>
        <cover.1604355792.git.steadmon@google.com>
        <9573428cc02111d3141ec2481bf679b31a5139e2.1604355792.git.steadmon@google.com>
Date:   Wed, 04 Nov 2020 13:11:46 -0800
In-Reply-To: <9573428cc02111d3141ec2481bf679b31a5139e2.1604355792.git.steadmon@google.com>
        (Josh Steadmon's message of "Mon, 2 Nov 2020 14:31:04 -0800")
Message-ID: <xmqqtuu4ltd9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 590EFB04-1EE2-11EB-8A0F-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> When trace2 is enabled and trace2.advertiseSID is true, advertise the
> server's trace2 session ID for all protocol v2 connections via the new
> trace2-sid capability.
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  serve.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/serve.c b/serve.c
> index f6341206c4..b40d7aad34 100644
> --- a/serve.c
> +++ b/serve.c
> @@ -8,6 +8,8 @@
>  #include "serve.h"
>  #include "upload-pack.h"
>  
> +static int advertise_trace2_sid;
> +
>  static int always_advertise(struct repository *r,
>  			    struct strbuf *value)
>  {
> @@ -30,6 +32,15 @@ static int object_format_advertise(struct repository *r,
>  	return 1;
>  }
>  
> +static int trace2_advertise(struct repository *r, struct strbuf *value)
> +{
> +	if (!advertise_trace2_sid || !trace2_is_enabled())
> +		return 0;
> +	if (value)
> +		strbuf_addstr(value, trace2_session_id());
> +	return 1;
> +}

To both 05/11 and 06/11, the same "if the user instructs us to
advertise, shouldn't we arrange the thing we were told to advertise
to be automatically available by at least allocating a session ID,
if not enabling the entire tracing?" applies.

>  struct protocol_capability {
>  	/*
>  	 * The name of the capability.  The server uses this name when
> @@ -66,6 +77,7 @@ static struct protocol_capability capabilities[] = {
>  	{ "fetch", upload_pack_advertise, upload_pack_v2 },
>  	{ "server-option", always_advertise, NULL },
>  	{ "object-format", object_format_advertise, NULL },
> +	{ "trace2-sid", trace2_advertise, NULL },
>  };
>  
>  static void advertise_capabilities(void)
> @@ -261,6 +273,8 @@ static int process_request(void)
>  /* Main serve loop for protocol version 2 */
>  void serve(struct serve_options *options)
>  {
> +	git_config_get_bool("trace2.advertisesid", &advertise_trace2_sid);
> +
>  	if (options->advertise_capabilities || !options->stateless_rpc) {
>  		/* serve by default supports v2 */
>  		packet_write_fmt(1, "version 2\n");
