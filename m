Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 235B320A78
	for <e@80x24.org>; Wed,  1 Feb 2017 23:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750789AbdBAXTX (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 18:19:23 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:40944 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbdBAXTX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 18:19:23 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 0C3B71E3089;
        Thu,  2 Feb 2017 00:19:20 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id vC3qg5XydwN1; Thu,  2 Feb 2017 00:19:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 92EC41E308A;
        Thu,  2 Feb 2017 00:19:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id x4BrocFUYXij; Thu,  2 Feb 2017 00:19:19 +0100 (CET)
Received: from [192.168.178.29] (aftr-185-17-206-21.dynamic.mnet-online.de [185.17.206.21])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id 465AD1E3089;
        Thu,  2 Feb 2017 00:19:19 +0100 (CET)
Subject: Re: [PATCH] doc: add note about ignoring --no-create-reflog
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <20170201220727.18070-1-cornelius.weig@tngtech.com>
 <xmqq4m0do86p.fsf@gitster.mtv.corp.google.com>
 <20170201223520.b4er3av67ev5m3ls@sigill.intra.peff.net>
 <xmqqmve5mrpe.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   Cornelius Weig <cornelius.weig@tngtech.com>
Message-ID: <dd0a1d56-aa39-a2a4-0ea2-cb64f79dd640@tngtech.com>
Date:   Thu, 2 Feb 2017 00:19:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqmve5mrpe.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 02/02/2017 12:11 AM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> This might be nitpicking, but it's _not_ ignored. It still negates an
>> earlier "--create-reflog". It is only that it does not override the
>> decision to create a reflog caused by the setting of
>> core.logallrefupdates.

This corner case is quite important. Glad you thought about it!

> -- >8 --
> From: Cornelius Weig <cornelius.weig@tngtech.com>
> Date: Wed, 1 Feb 2017 23:07:27 +0100
> Subject: [PATCH] doc: add note about ignoring '--no-create-reflog'
> 
> The commands git-branch and git-tag accept the '--create-reflog'
> option, and create reflog even when core.logallrefupdates
> configuration is explicitly set not to.
> 
> On the other hand, the negated form '--no-create-reflog' is accepted
> as a valid option but has no effect (other than overriding an
> earlier '--create-reflog' on the command line). This silent noop may
> puzzle users.  To communicate that this is a known limitation, add a
> short note in the manuals for git-branch and git-tag.
> 
> Signed-off-by: Cornelius Weig <cornelius.weig@tngtech.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-branch.txt | 3 +++
>  Documentation/git-tag.txt    | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index 5516a47b54..102e426fd8 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -91,6 +91,9 @@ OPTIONS
>  	based sha1 expressions such as "<branchname>@\{yesterday}".
>  	Note that in non-bare repositories, reflogs are usually
>  	enabled by default by the `core.logallrefupdates` config option.
> +	The negated form `--no-create-reflog` does not override the
> +	default, even though it overrides `--create-reflog` that appears
> +	earlier on the command line.
>  
>  -f::
>  --force::
> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index 2ac25a9bb3..fd7eeae075 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -152,6 +152,9 @@ This option is only applicable when listing tags without annotation lines.
>  --create-reflog::
>  	Create a reflog for the tag. To globally enable reflogs for tags, see
>  	`core.logAllRefUpdates` in linkgit:git-config[1].
> +	The negated form `--no-create-reflog` does not override the
> +	default, even though it overrides `--create-reflog` that appears
> +	earlier on the command line.
>  
>  <tagname>::
>  	The name of the tag to create, delete, or describe.
> 

Your amended version is quite concise and says everything there is to
say. Thanks
