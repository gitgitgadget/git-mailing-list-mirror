Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5C34201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 17:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752371AbdF3Ryp (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 13:54:45 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35010 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751710AbdF3Ryo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 13:54:44 -0400
Received: by mail-pf0-f194.google.com with SMTP id s66so17792646pfs.2
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 10:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aPzoHei+yoh0I+FhH29/WLHsTD9keYANJzQb+pEGAcA=;
        b=Y3Dzw5HxCNuDdUIw2vl40UP7Nri5g0ecFfHGqOu9eovyE6ER5knbUj59XD7IymRwRr
         P49v1hYW8c2+vOkBMPu78jAo5N48GOZaoFDrHVxQxnWWE5cXt+wHEcvPdqkVr+WyzrL9
         pHRnbt5Ca+O/Px2ZbmFOH7gBZTKkUic80T3IuwmDIQnpnwzKrtZ0vppRIwfEk38bL86j
         ZIIn+VhnY+SJbor4P/XHbcsZUTLv2kRkcFDaBjqHIlPPrvYtbYycNntRmWHiEf72GtFP
         zS986m4dpAhHNTeS+L2R6Bb6nTKhBgt6GGo+dNP1fom0y9g/YcNqT07d/gZQ6MIGD5ro
         OFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=aPzoHei+yoh0I+FhH29/WLHsTD9keYANJzQb+pEGAcA=;
        b=B+/Ik+NkyXmcBydBKixChHZj3ux18K/fWxP9cAFtbPmrwXRKp3zwrOyqlOGBC7r3eY
         Pl+1UkyqOKJsAb5bu/Be9iZWnEYqtelPgdROpWr9oUaRu7Wr3fk6aJnM4P5O2M1TYPny
         VF+AW2Qvzb/cg6B6qN7oRPSCZgCMnkIzUh8xXSvTP20pBta/eBUTSClQ+tWeHw+4keJc
         7rvtYyn/YdTspNtYyUE0e4fQQ3SmVB3ev5E5ddyyLhvslrtLn5oWrYi/9nHemzyj1t8M
         oivfEaGQABEQ2jTnyFaFDMU+B+/toFuqPMKT2lOGTE/9EfJLajfzsmDAOfFt2rmeBsTX
         RQoQ==
X-Gm-Message-State: AKS2vOyLcEZMb4wLEKQZ4TbJ6uFvg1Wy1RwmVspegQ/OX58iOSi0yDj4
        fLC9di8/IJPuDQ==
X-Received: by 10.99.95.216 with SMTP id t207mr22622749pgb.19.1498845284136;
        Fri, 30 Jun 2017 10:54:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:54f:b41d:dd9d:3de0])
        by smtp.gmail.com with ESMTPSA id s15sm15271004pgo.48.2017.06.30.10.54.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 10:54:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] merge-recursive: use DIFF_XDL_SET macro
References: <20170629221932.3773-1-sbeller@google.com>
Date:   Fri, 30 Jun 2017 10:54:42 -0700
In-Reply-To: <20170629221932.3773-1-sbeller@google.com> (Stefan Beller's
        message of "Thu, 29 Jun 2017 15:19:32 -0700")
Message-ID: <xmqq8tk9s6n1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Instead of implementing this on our own, just use a convenience macro.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Good eyes.  Thanks.

>  merge-recursive.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 59e5ee41a8..1494ffdb82 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -2210,11 +2210,11 @@ int parse_merge_opt(struct merge_options *o, const char *s)
>  		o->xdl_opts |= value;
>  	}
>  	else if (!strcmp(s, "ignore-space-change"))
> -		o->xdl_opts |= XDF_IGNORE_WHITESPACE_CHANGE;
> +		DIFF_XDL_SET(o, IGNORE_WHITESPACE_CHANGE);
>  	else if (!strcmp(s, "ignore-all-space"))
> -		o->xdl_opts |= XDF_IGNORE_WHITESPACE;
> +		DIFF_XDL_SET(o, IGNORE_WHITESPACE);
>  	else if (!strcmp(s, "ignore-space-at-eol"))
> -		o->xdl_opts |= XDF_IGNORE_WHITESPACE_AT_EOL;
> +		DIFF_XDL_SET(o, IGNORE_WHITESPACE_AT_EOL);
>  	else if (!strcmp(s, "renormalize"))
>  		o->renormalize = 1;
>  	else if (!strcmp(s, "no-renormalize"))
