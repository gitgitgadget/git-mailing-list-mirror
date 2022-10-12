Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA3FC433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 16:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiJLQuC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 12:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiJLQt7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 12:49:59 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F13FB875
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 09:49:56 -0700 (PDT)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1oieva-0000nF-BV;
        Wed, 12 Oct 2022 17:49:54 +0100
Message-ID: <19e5b678-6014-d783-347f-9169371aaa09@iee.email>
Date:   Wed, 12 Oct 2022 17:49:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3] docs: git-send-email: difference between ssl and tls
 smtp-encryption
Content-Language: en-GB
To:     sndanailov@wired4ever.net, git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, aaron@schrab.com
References: <20221012150619.12877-1-sndanailov@wired4ever.net>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <20221012150619.12877-1-sndanailov@wired4ever.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sotir,

On 12/10/2022 16:06, sndanailov@wired4ever.net wrote:
> From: Sotir Danailov <sndanailov@wired4ever.net>
>
> New explanation for the difference between these values.
> It's hard to understand what they do based only on the names.
> New description of used default ports.
>
> Signed-off-by: Sotir Danailov <sndanailov@wired4ever.net>
> ---
> Changes since v1: Expanded explanation, covering more terms.
> Link to v1: https://public-inbox.org/git/20221010172859.13832-1-sndanailov@wired4ever.net/
>
> Changes since v2: Added a description of what the option actually does.
> Link to v2: https://public-inbox.org/git/20221011164927.1516-1-sndanailov@wired4ever.net/
>
>  Documentation/git-send-email.txt | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index 3290043053..765b2df853 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -178,9 +178,18 @@ Sending
>  	for `sendmail` in `/usr/sbin`, `/usr/lib` and $PATH.
>  
>  --smtp-encryption=<encryption>::
> -	Specify the encryption to use, either 'ssl' or 'tls'.  Any other
> -	value reverts to plain SMTP.  Default is the value of
> -	`sendemail.smtpEncryption`.
> +	Specify in what way encrypting begins for the SMTP connection.
> +	Valid values are 'ssl' and 'tls'. Any other value reverts to plain
> +	(unencrypted) SMTP, which defaults to port 25.
> +	Despite the names, both values will use the same newer version of TLS,
> +	but for historic reasons have these names. 'ssl' refers to "implicit"
> +	encryption (sometimes called SMTPS), that uses port 465 by default.
> +	'tls' refers to "explicit" encryption (often known as STARTTLS),
> +	that uses port 25 by default. Other ports might be used by the SMTP
> +	server, which are not the default. Commonly found alternative port for
> +	'tls' and unencrypted is 587.

Can we insert a sentence something like "Use the `--smtp-server-port`
option to set non-default ports." to direct users that need it?


>  You need to check your provider's
> +	documentation or your server configuration to make sure
> +	for your own case. Default is the value of `sendemail.smtpEncryption`.
>  
>  --smtp-domain=<FQDN>::
>  	Specifies the Fully Qualified Domain Name (FQDN) used in the
--
Philip
