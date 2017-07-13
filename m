Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B34C3202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 19:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752593AbdGMTC3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 15:02:29 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34366 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752525AbdGMTC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 15:02:28 -0400
Received: by mail-pg0-f66.google.com with SMTP id j186so7894485pge.1
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 12:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZO9JcogAPYn/dcX5b8ORCpAy4/w4pYs247FCCsrw4gQ=;
        b=H6pD2RUkCh3O3k/0zPzje4IXpxghma1VuxvwllhF2XhFG7s6Xt6v4LJCLWkIGqYEUN
         XB6Rg1Usd5IAmqBQecckjIxe+NWb6PFATMCm17d7gDql12evv9Bhi2rjP+ENBea1GRqy
         ffL3jzHSjCXYIWpmxwaXvj+KQCdgF8IIGfBBxz1U9gKA9sMGNRvCbuRfADW6fxTc76mH
         /lu0OwXM8gBaaXX/T8dJaV7XDTgk4v2+wObAGAZ3qSJzqoUV3FelLQo2piT1QQLS+ZB3
         Js3G3P43Q7MbYG09E56HUjxE1pdWyCbu4ciU0z/rB4aIcqRtkY7OD9F467d5UraQScNj
         37Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZO9JcogAPYn/dcX5b8ORCpAy4/w4pYs247FCCsrw4gQ=;
        b=ejctEaC3YVdICNQozcYuLaLOq3mE4mTIwTrvX630/hMUm6V7zo5Xg0pSm3C1uApIPK
         xnRQLCdU2/lmtEwylEPPRQAub4Clp9dhUP93+6pUedndZelObAeSjtxOXt1oUfpY5AWG
         +G95/PZmyox7ZsUzjAAmDHvgz4/71iyCdwoNyedIVQncEBSLxFjjSJamggWrAAgHR4eE
         ypdjP1XA/uaLyQCRQwROhJXFOyuy9cgMvWDgQjOihOEHoajrgVi9X8Q72W0b4hGQX1y7
         Yepps8lkMu+ij5USIxcZ+ez67PIh0IOwol9lBkTtsafJwU/yjCnAm1wA+IwyxUn67KPw
         +UAQ==
X-Gm-Message-State: AIVw1114LAwdADeFYOqaTOD1rWN8o11jqtnhrFEdH98n9EKE/0RP5hhp
        HtwsHV5L98R5+Q==
X-Received: by 10.84.224.11 with SMTP id r11mr11551785plj.267.1499972547519;
        Thu, 13 Jul 2017 12:02:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3079:9e61:8883:4f9c])
        by smtp.gmail.com with ESMTPSA id m68sm13252595pfi.12.2017.07.13.12.02.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Jul 2017 12:02:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] tag: convert gpg_verify_tag to use struct object_id
References: <20170713004415.5051-1-sbeller@google.com>
        <20170713004415.5051-2-sbeller@google.com>
Date:   Thu, 13 Jul 2017 12:02:25 -0700
In-Reply-To: <20170713004415.5051-2-sbeller@google.com> (Stefan Beller's
        message of "Wed, 12 Jul 2017 17:44:15 -0700")
Message-ID: <xmqqzic8w472.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>  		if (fmt_pretty)
> -			pretty_print_ref(name, sha1, fmt_pretty);
> +			pretty_print_ref(name, oid.hash, fmt_pretty);

The next step would be to have pretty_print_ref() to take an oid; as
there are only two callers to it, both of which pass oid->hash to it,
that should be a small and conflict-free conversion.

>  
> -	type = sha1_object_info(sha1, NULL);
> +	type = sha1_object_info(oid->hash, NULL);

sha1_object_info() has a handful of callers that do not pass the
pointer to the hash field in an existing oid object, but it does not
look too bad as a candidate for conversion.

>  	if (!buf)
>  		return error("%s: unable to read file.",
>  				name_to_report ?
>  				name_to_report :
> -				find_unique_abbrev(sha1, DEFAULT_ABBREV));
> +				find_unique_abbrev(oid->hash, DEFAULT_ABBREV));

So does find_unique_abbrev().

Overall both patches look good.  Thanks.
