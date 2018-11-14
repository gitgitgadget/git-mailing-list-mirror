Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE3231F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 19:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbeKOFWN (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 00:22:13 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53961 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725757AbeKOFWN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 00:22:13 -0500
Received: by mail-wm1-f68.google.com with SMTP id f10-v6so16500998wme.3
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 11:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sb1j1oiFqByVmjEmGMGuqNzkGTmdCrHJe+qvifva9mY=;
        b=Uzog+zINLq4wwiu6YMdxfbp0i3rSTf8P34ih1XQRdyzXe01r6fwaLicUW00qI4P0WF
         pHqD/I0Dj09QmdGyR4Ipe4T1FDx0myACdkvyI8iBMQ6jbieA9976uiYFwFymw1l55oMP
         93rwyT3T+tLKynCHpPnDDRNg4t6Ls5dRNorVkwfvNnTlbyfE2JHqhgMzFdvXRt8k5vDf
         egMzWSXmqCHHRXMklHLTS2ahTeTFWby5vBXPAeXUBjjekbX2gFwr96xp2A6UwTayodyX
         r1kcxO0viMt5uv3RFiz/t5IGF9rWiCyo2MeICHdaSzHdS5THpXCntS0LH/MPNuqZ/uYX
         MFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sb1j1oiFqByVmjEmGMGuqNzkGTmdCrHJe+qvifva9mY=;
        b=aUZUpfCLT+yCQtSrxLAJJetWJzFQzoFl0nKrmwLJoZXXptIZyB5RlfBSw4FKCYt9Hv
         VjKmZE8xqLubATLDbTJuhOZwevYUf2axV9sKPmVwnc2c82a/JWm06L1TRZMeos6kggJf
         CDOdS2xITTFE01NeLuWOQ8JE0ujOVbwLd3Si4ltYKwoMv8O/qEKCQD8fn8XfBkg1yJ0d
         AYrkQEThEvEi9PiVmZOL5HjYrw1Q5VU+apE/m9TqRmltQ/qKC/stE5+hLS4kts8CJJt9
         6T2CFDcZCke9uFSj/uMSthk0o8JF1RNQyxxqCSIoWpMDFrY8+ZokAAKxweCelxLk2f3o
         D22w==
X-Gm-Message-State: AGRZ1gLlKzX/AwrHsCZP+lCmgfjnhSDNCt095+L4JRcLjUizPWyiB8dH
        s0FbBPsRC2qUQZqlWG90VZc=
X-Google-Smtp-Source: AJdET5fb8AYxafrOQWgR+8jldPlE0IoEx8EbM/WMP3SOVU8DFrPmwaaV3TMrdIN4/8e10mAeFE3dPw==
X-Received: by 2002:a1c:85d2:: with SMTP id h201mr2275530wmd.151.1542223064555;
        Wed, 14 Nov 2018 11:17:44 -0800 (PST)
Received: from szeder.dev (x4db1d05b.dyn.telefonica.de. [77.177.208.91])
        by smtp.gmail.com with ESMTPSA id m69-v6sm21826054wmb.8.2018.11.14.11.17.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 11:17:43 -0800 (PST)
Date:   Wed, 14 Nov 2018 20:17:41 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, larsxschneider@gmail.com,
        sandals@crustytoothpaste.net, peff@peff.net, me@ttaylorr.com,
        jrnieder@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v2 04/11] fast-export: avoid dying when filtering by
 paths and old tags exist
Message-ID: <20181114191741.GJ30222@szeder.dev>
References: <20181111062312.16342-1-newren@gmail.com>
 <20181114002600.29233-1-newren@gmail.com>
 <20181114002600.29233-5-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181114002600.29233-5-newren@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 13, 2018 at 04:25:53PM -0800, Elijah Newren wrote:
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index af724e9937..b984a44224 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -774,9 +774,12 @@ static void handle_tag(const char *name, struct tag *tag)
>  					break;
>  				if (!(p->object.flags & TREESAME))
>  					break;
> -				if (!p->parents)
> -					die("can't find replacement commit for tag %s",
> -					     oid_to_hex(&tag->object.oid));
> +				if (!p->parents) {
> +					printf("reset %s\nfrom %s\n\n",
> +					       name, sha1_to_hex(null_sha1));

Please use oid_to_hex(&null_oid) instead.

> +					free(buf);
> +					return;
> +				}
>  				p = p->parents->item;
>  			}
>  			tagged_mark = get_object_mark(&p->object);
