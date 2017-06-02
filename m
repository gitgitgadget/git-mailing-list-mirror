Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B98E20D11
	for <e@80x24.org>; Fri,  2 Jun 2017 01:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751129AbdFBBAl (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 21:00:41 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35995 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750851AbdFBBAk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 21:00:40 -0400
Received: by mail-pf0-f195.google.com with SMTP id n23so9924505pfb.3
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 18:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=YkPG8A+sVVN1/1VLxcZ1uL/w2hlOwaVKfvBDUF8tQKA=;
        b=ZcFDp1F3gCc4LntWOOvAC5fbi0jQxqgsgjFAJJuv5fBBCE/eZsRXUasmPYYV08D1Xi
         0ek8Tw7ek2CswY6k5TVY4MMHW4SZFAfzSJRESMuZO1Um9y2ib86ExKPeZTVurL8hlI2s
         iIGSCxRkOYeVfzKH09S5j0WKDQN7dMk0VW80h2IxHXBeKmvKabh3cLje1tdwg17w17uq
         lSZy3AzDL35S4ErrkNMy199jqY/InfWFiNZTAMJN09YGTnbA7uGr35ptdC5jtlClRl7U
         i+jrpnq1P8APZqf+NXcODepGFd/CHPO5jHHPqD+0aDSwasedJrrMYqOnAZTJ6IFQDsxO
         tgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=YkPG8A+sVVN1/1VLxcZ1uL/w2hlOwaVKfvBDUF8tQKA=;
        b=JY1eJ/MXCoZ6R0FRyFEJz3OA4yCJave/RNTHlop3bbOGkJaDyHX2fuQCEIzO+tQcbc
         uvhc2I1vceGqzUYPFMR+Iq1ipIc9HT1ACu3BDNWCMLBYKLHmoWEe/Tcf5dCfTTt9Eiwb
         a1vv3Wc4LmjN1U8gGbCAzlzyAtAGIjhMwAgdXTy6lxi1ng+ut5YC/SoYe5GTPtRT1+mv
         y2z2wDTX4U2hsF8qFvZxPOsUZYcRjnVGzWP+YoaQK1st9jRwMLZfFxEywxVRWd5Pv+8x
         2E8O8IZJL8Lx3Xdp01m2dxTgw9g7FMHMfIAY37M1MDI1Ee98ToWxFtA7vwVpzE1wcBHe
         9t9Q==
X-Gm-Message-State: AODbwcBKjNgLx+s9RETCITqyBRrZqRFaNVmEPCqcZmUk5hSN0FPI1TGn
        O4p9z2U4vIkb9K9mhKYdcg==
X-Received: by 10.99.53.4 with SMTP id c4mr260344pga.165.1496365239449;
        Thu, 01 Jun 2017 18:00:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ec2c:8ebb:3fc7:e0d4])
        by smtp.gmail.com with ESMTPSA id z69sm8675482pff.0.2017.06.01.18.00.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 18:00:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, sandals@crustytoothpaste.net
Subject: Re: [PATCH 08/33] grep: convert to struct object_id
References: <20170530173109.54904-1-bmwill@google.com>
        <20170530173109.54904-9-bmwill@google.com>
Date:   Fri, 02 Jun 2017 10:00:38 +0900
In-Reply-To: <20170530173109.54904-9-bmwill@google.com> (Brandon Williams's
        message of "Tue, 30 May 2017 10:30:44 -0700")
Message-ID: <xmqqlgpb2og9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Convert the remaining parts of grep to use struct object_id.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  builtin/grep.c | 22 +++++++++++-----------
>  cache.h        |  7 +++++++
>  grep.c         | 17 ++++++++---------
>  grep.h         |  2 +-
>  4 files changed, 27 insertions(+), 21 deletions(-)
> ...
> +static inline struct object_id *oiddup(const struct object_id *src)
> +{
> +	struct object_id *dst = xmalloc(sizeof(struct object_id));
> +	oidcpy(dst, src);
> +	return dst;
> +}
> +
>  static inline void hashclr(unsigned char *hash)
>  {
>  	memset(hash, 0, GIT_SHA1_RAWSZ);
> diff --git a/grep.c b/grep.c
> index 47cee4506..a240b4cdb 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -1747,9 +1747,8 @@ void grep_source_init(struct grep_source *gs, enum grep_source_type type,
>  		 * If the identifier is non-NULL (in the submodule case) it
>  		 * will be a SHA1 that needs to be copied.
>  		 */
> -	case GREP_SOURCE_SHA1:
> -		gs->identifier = xmalloc(20);
> -		hashcpy(gs->identifier, identifier);
> +	case GREP_SOURCE_OID:
> +		gs->identifier = oiddup(identifier);
>  		break;
>  	case GREP_SOURCE_BUF:
>  		gs->identifier = NULL;

These hunks triggered my "Huh?" meter a bit, simply because I tend
to wonder not just "is this useful in many other places?" but also
"is it a good idea to encourage the use of this thing?"; these look
OK.

Thanks.

