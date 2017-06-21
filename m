Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A45D020401
	for <e@80x24.org>; Wed, 21 Jun 2017 20:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751130AbdFUUXh (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 16:23:37 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35468 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbdFUUXg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 16:23:36 -0400
Received: by mail-pg0-f68.google.com with SMTP id f127so29858736pgc.2
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 13:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3C0wKgXfwnho/MvzbXNnJY+g+hh1WMFd4NekN3SuNjI=;
        b=en8MgW80JsYAHkqIO0nKsdeOtmJ61gXSS4t14tTT1Z6JGYXgBZcvcQIGVbbpHJ1STS
         k4AKL9vglOs8KTExDEipGoTb30EbF7/Z3MIuw+XcVIeTVxMVcxk/NMsTCAKJOktS6/Qc
         xx2wuOZ7AfLNCXPSi/EncDw/kieZmh0gsOoAZtPuso8dZ0x3QePm70sLVSlPaXH5Hwmr
         y3G9XmAtjaHg1JvGrAKA6g67QoyW3rRum9kLhAjtTkvCFKpRJCZ2VCUegA8t1VK2+P2u
         06gVAJsZCJVbX8BjoVrHu3TNF6tQ2p/TMpuKyAGl3YAaNXUYgQhOdpASQoMDZTjnwI5S
         B02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3C0wKgXfwnho/MvzbXNnJY+g+hh1WMFd4NekN3SuNjI=;
        b=LmZhfHIeZkC8seWW8OMQ1jVSN8yUjZrBD2Mb2VPcJXggFGc0vyvYHJ45G29Qa+qiyC
         EhgVdxL6VQBJfOdt8Np8W3F5fdLoKw+DoxmAHKQvDq1ybUpV68S0WMhJrN9OK1oQ3urw
         19kFOio4UrBEJEuCeOqXPuPvYlYeqDWlXc8XMnLFXqAsflzsXAx7YewcPnXL9xdD5sWv
         O0GXhHYalvWrlxrP7Z5WjXuOS4/fPycOVkQ13GaT5hzH8OxQVfg757d0elJ32qbIMKXu
         INxatYo9IlNqmBCUddKvFLsswCWJNHRrLxG4Tn817UaNugC+f7ixtUeWUzkUTwBfbohV
         g8iA==
X-Gm-Message-State: AKS2vOzjFlgJPOm+gp2SfP4ZzsflELA3TdRLy62uqzE6U61xz7YaG9s6
        J+I/VlrTp9NxxWzW1+k=
X-Received: by 10.84.132.79 with SMTP id 73mr6252839ple.142.1498076615981;
        Wed, 21 Jun 2017 13:23:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b0bd:d7d3:4f2e:5016])
        by smtp.gmail.com with ESMTPSA id e13sm2275004pfh.96.2017.06.21.13.23.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 13:23:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, git@vger.kernel.org, jonathantanmy@google.com,
        jrnieder@gmail.com, mhagger@alum.mit.edu, peff@peff.net,
        philipoakley@iee.org
Subject: Re: [PATCH 24/26] diff.c: add dimming to moved line detection
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
        <20170620024816.20021-1-sbeller@google.com>
        <20170620024816.20021-25-sbeller@google.com>
Date:   Wed, 21 Jun 2017 13:23:34 -0700
In-Reply-To: <20170620024816.20021-25-sbeller@google.com> (Stefan Beller's
        message of "Mon, 19 Jun 2017 19:48:14 -0700")
Message-ID: <xmqqinjpnl89.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Any lines inside a moved block of code are not interesting. Boundaries
> of blocks are only interesting if they are next to another block of moved
> code.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  color.h                    |   2 +
>  diff.c                     | 139 ++++++++++++++++++++++++++++++++++++++++-----
>  diff.h                     |   9 ++-
>  t/t4015-diff-whitespace.sh | 124 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 259 insertions(+), 15 deletions(-)
>
> diff --git a/color.h b/color.h
> index 90627650fc..0e091b0cf5 100644
> --- a/color.h
> +++ b/color.h
> @@ -42,6 +42,8 @@ struct strbuf;
>  #define GIT_COLOR_BG_BLUE	"\033[44m"
>  #define GIT_COLOR_BG_MAGENTA	"\033[45m"
>  #define GIT_COLOR_BG_CYAN	"\033[46m"
> +#define GIT_COLOR_DI		"\033[2m"
> +#define GIT_COLOR_DI_IT		"\033[2;3m"

I can and I think most naive readers understand what BOLD, BG and
BLUE means, but I do not think the same can be said to DI and IT.
If you meant FAINT and ITALIC, it is better to spell them out.  You
do not have to type them to too many places anyway.

