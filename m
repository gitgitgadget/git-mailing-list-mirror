Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AF571F406
	for <e@80x24.org>; Tue,  9 Jan 2018 22:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756279AbeAIWYy (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 17:24:54 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38319 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756065AbeAIWYx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 17:24:53 -0500
Received: by mail-pg0-f67.google.com with SMTP id t67so8961123pgc.5
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 14:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fyqMRZMSj+aZ/8smS/rZnIixDBO+b5oGCn6v9B+zaeE=;
        b=jeo9hYDlAYPypNtZnR3WxuUbBxbQFSZQC0DhSrE27UYVh1dEE60k+uSmIvw/g77LQc
         h+jSk/Lil8/ce3QRwUpRt7H67Tb+J84Wg68FXmP3vocC5Z4anIXEOjm1xQc9s7R7UCaa
         LDbT8IRB0fp3JZoNHFBOsFACe0dxIwuPtMdzA3Xd9jPzjCftOKhE0pc+ORToeqgL3p5Z
         ib3R+ugwHT+3bcifBLxyme188oL78ubfVQeX45ezHBrXwIqNWkR9EByJpDdhrUVPux+H
         2g1qBTNusBvgDF0KWANvlUen6yQ9lFE51avg12zDH9wnu0jckiGCmQwU7h69d6dw4MuV
         4wJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fyqMRZMSj+aZ/8smS/rZnIixDBO+b5oGCn6v9B+zaeE=;
        b=G5nqFXPym7A+FeXWOoymxsDA9GOJFusg5G7L4XHBvNP0t0SIK8QpwQnXCd9hK9KpXi
         COLfwsO6X8Tk8xhdU6UTlTZjdk2pRSQlpTcXrwnh2/oxnQL23FO5T4L2XGWUuvs1eKHm
         PFnfx4r1Un2cqemtutA4km6n2bEyXQwXu3BdkpsQyGvETHyWqJ2NXaIr/0tOAw1uC5Oz
         txdpeWGnAFQuu5C1nhsJrl+lnUhrGBSPU8LHmVfzQZsm+feKja7ZE78Emxp7TXQlfzB3
         lpjgST6EiYSwruyCNJS7yqassfOaolRV5NeTfBVHSUK+jZ0MblzNPMYWWJeTs4zyzCEA
         8OAA==
X-Gm-Message-State: AKGB3mKXA0wpiXpd+NkYlo1vbGsPJOBBPxsLiZawYVu/6JmDNMYdmBf8
        MYe5HI49pTMnpq38vW5cFNqt7t+8vyc=
X-Google-Smtp-Source: ACJfBotAgQ5Jmn1Z1SRt9DJEuzYsRovOeItCl5fOS5VIrkR3UHbeplMAAjtPIO360Vl5rLEjhHbZ1Q==
X-Received: by 10.101.82.205 with SMTP id z13mr13240967pgp.403.1515536692748;
        Tue, 09 Jan 2018 14:24:52 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:592e:240e:24e2:56aa])
        by smtp.gmail.com with ESMTPSA id s189sm28517091pgc.5.2018.01.09.14.24.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jan 2018 14:24:52 -0800 (PST)
Date:   Tue, 9 Jan 2018 14:24:51 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        peff@peff.net, philipoakley@iee.org, stolee@gmail.com,
        jrnieder@gmail.com
Subject: Re: [PATCH 13/26] connect: request remote refs using v2
Message-Id: <20180109142451.1e10f3936eafc270c9bb8b76@google.com>
In-Reply-To: <20180103001828.205012-14-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
        <20180103001828.205012-14-bmwill@google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  2 Jan 2018 16:18:15 -0800
Brandon Williams <bmwill@google.com> wrote:

> diff --git a/connect.c b/connect.c
> index caa539b75..9badd403f 100644
> --- a/connect.c
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
>  static const char *parse_feature_value(const char *, const char *, int *);
>  
>  static int check_ref(const char *name, unsigned int flags)
> @@ -62,6 +64,33 @@ static void die_initial_contact(int unexpected)
>  		      "and the repository exists."));
>  }
>  
> +static int server_supports_v2(const char *c, int die_on_error)

Document what "c" means.

[snip]

> +static void process_capabilities_v2(struct packet_reader *reader)
> +{
> +	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
> +		argv_array_push(&server_capabilities_v2, reader->line);
> +	}

No need for braces on single-line blocks.

> +static int process_ref_v2(const char *line, struct ref ***list)

The "list" is the tail of a linked list, so maybe name it "tail"
instead.
