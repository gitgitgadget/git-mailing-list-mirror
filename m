Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98CFB1FBEC
	for <e@80x24.org>; Fri, 10 Mar 2017 19:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933056AbdCJTCY (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 14:02:24 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64011 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932705AbdCJTCX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 14:02:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F1546586B;
        Fri, 10 Mar 2017 14:02:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Weygzy7sX0x1ug1iml2JCJi6jZE=; b=no1Vs6
        3cQrdHhEXKMhw5JkPpgr1k2fxtNiV0uBcAEaVESrBD8Id/kdcR154b3xbMnVHrqp
        gpTz6M4uSzTlB8yi964byDErXbc+jEiJ/ERARLUK9KlmY4n3fyjLKHxsHVoP8xpn
        SYEOh+sQvCk1ZnY6Tqei1QoMQYvwDyftbPVa0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IbAyJ/s2eJGt4dGe/71/K3e8GaZ37UEL
        +csChBZOPPfqerLsFPRrNzs5aOS32WiPgxOhly0ILeK0RPtro3bJQcCgNkub9CvP
        n09ehNEDilTr3PMjYlB3etO1gtDZBPe7k2gQZFNorjWrbWO4CEbGQrVRFEGqCnqz
        9ZlgQDavg3c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 290286586A;
        Fri, 10 Mar 2017 14:02:21 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7E8E765869;
        Fri, 10 Mar 2017 14:02:20 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v5 09/11] Test read_early_config()
References: <cover.1488897111.git.johannes.schindelin@gmx.de>
        <cover.1489098170.git.johannes.schindelin@gmx.de>
        <72b36d27cefc0060f170b33f19cf504bb0338c1c.1489098170.git.johannes.schindelin@gmx.de>
Date:   Fri, 10 Mar 2017 11:02:19 -0800
In-Reply-To: <72b36d27cefc0060f170b33f19cf504bb0338c1c.1489098170.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Thu, 9 Mar 2017 23:25:06 +0100
        (CET)")
Message-ID: <xmqqa88tymys.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1661FD50-05C4-11E7-813D-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Subject: Re: [PATCH v5 09/11] Test read_early_config()

Let's retitle it to

	t1309: test read_early_config()

> So far, we had no explicit tests of that function.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/helper/test-config.c  | 15 +++++++++++++++
>  t/t1309-early-config.sh | 50 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 65 insertions(+)
>  create mode 100755 t/t1309-early-config.sh
>
> diff --git a/t/helper/test-config.c b/t/helper/test-config.c
> index 83a4f2ab869..8e3ed6a76cb 100644
> --- a/t/helper/test-config.c
> +++ b/t/helper/test-config.c
> @@ -66,6 +66,16 @@ static int iterate_cb(const char *var, const char *value, void *data)
>  	return 0;
>  }
>  
> +static int early_config_cb(const char *var, const char *value, void *vdata)
> +{
> +	const char *key = vdata;
> +
> +	if (!strcmp(key, var))
> +		printf("%s\n", value);
> +
> +	return 0;
> +}
> +
>  int cmd_main(int argc, const char **argv)
>  {
>  	int i, val;
> @@ -73,6 +83,11 @@ int cmd_main(int argc, const char **argv)
>  	const struct string_list *strptr;
>  	struct config_set cs;
>  
> +	if (argc == 3 && !strcmp(argv[1], "read_early_config")) {
> +		read_early_config(early_config_cb, (void *)argv[2]);
> +		return 0;
> +	}
> +
>  	setup_git_directory();

Makes perfect sense to have this as the very beginning, before we
even do the usual setup ;-)

