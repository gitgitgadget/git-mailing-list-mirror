Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E70C01F428
	for <e@80x24.org>; Wed,  3 Jan 2018 00:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751074AbeACAVu (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 19:21:50 -0500
Received: from mail-io0-f170.google.com ([209.85.223.170]:42454 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751046AbeACAVt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 19:21:49 -0500
Received: by mail-io0-f170.google.com with SMTP id x67so464218ioi.9
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 16:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0LVrSfBlZDELRdQoGMVWYJHZSXFNfMQzMlGlCo0trxo=;
        b=IUUdfACNiKJI/8dK0qlyGv9Ay+BtoJS/TU1hsTgpZ3SljoTqkpk3FiPw/V5CF3ghNd
         7jRtkGWltG6Dudusgpx8+a1lfzho0aX5vWiqED9EUjRzLFHJPMr04YvaapCi1GqctfIJ
         8mLp7iRQo75lb6adPKPcNKfDruGBlCLe/zwiK5oilyK2LrbDPR1ktyNlCSgT6+0mAC8l
         Y3eDfJCpT5FlfXi6SCh+SKvnClb2qucrcpa3lhqt28J3He69+VUVqIy4M/sCcPqBmTLc
         Lqc4DTbyuNiLQFTE1f7FwqOr80lzBXE2mcA1uR+HJdEkOaGJsAIH0U9/Rd2+sqt0SGkD
         KLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0LVrSfBlZDELRdQoGMVWYJHZSXFNfMQzMlGlCo0trxo=;
        b=R4W9VGUEnDhdmJnw6q5z6IMJhObbfdYA7gD7IWawUSFTZPMoAEONe3rUp65oCn4av5
         P9Ofz+/NMhwWX/hSQpaeP5ouY6iXaz1CNTwTlFPCBJgNcq10vjdewj/P5cv3x5ceux0p
         1+xjX+f8IWDvBCQv7qPuznCNe3Qok6n9OIrXla5PuRKmcoJQs5FS4pPBe7au8bi149hm
         5F/IPI27PQ8HKouurxlSoIRRnx8Gd/6vQzhXxoZO7BxlzRHu5kuFMuzKAbhnWjIeUq1c
         EqWdukXB7VGsksz/4j2FkH48/+WZrkBbSTy+QdDr/xy3yE8H5wpcI8a58DJVR1JwsR+1
         9T7g==
X-Gm-Message-State: AKGB3mIOg3wgCux7o785K4EK3K1TURpBgmYGMWijyU769O5fSxK6szpg
        mL86DO1VxFlZSfm52dKwELKhxxXcwsg=
X-Google-Smtp-Source: ACJfBovWFKY4GmUQcMrRDFqes6m1CQMKr09TQhFr8j/qu7nTfgZKLNOCYifFCKKsZbnA8OMzVGbWUw==
X-Received: by 10.107.175.208 with SMTP id p77mr8673062ioo.216.1514938908407;
        Tue, 02 Jan 2018 16:21:48 -0800 (PST)
Received: from google.com ([2620:0:100e:422:a0cf:c1:975f:7d91])
        by smtp.gmail.com with ESMTPSA id g9sm16176124ioi.81.2018.01.02.16.21.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 Jan 2018 16:21:47 -0800 (PST)
Date:   Tue, 2 Jan 2018 16:21:45 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http: fix v1 protocol tests with apache httpd < 2.4
Message-ID: <20180103002145.GA242551@google.com>
References: <20171231023234.21215-1-tmz@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171231023234.21215-1-tmz@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/30, Todd Zullinger wrote:
> The apache config used by tests was updated to use the SetEnvIf
> directive to set the Git-Protocol header in 19113a26b6 ("http: tell
> server that the client understands v1", 2017-10-16).
> 
> Setting the Git-Protocol header is restricted to httpd >= 2.4, but
> mod_setenvif and the SetEnvIf directive work with lower versions, at
> least as far back as 2.0, according to the httpd documentation:
> 
>     https://httpd.apache.org/docs/2.0/mod/mod_setenvif.html
> 
> Drop the restriction.  Tested with httpd 2.2 and 2.4.
> 
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
> 
> These tests fail with 2.16.0-rc0 on CentOS-6, which uses
> httpd-2.2.
> 
> I removed the version restriction entirely rather than adjust
> the version.  I believe SetEnvIf works on httpd >= 2.0.  I'm
> not sure if we aim to support anything less than httpd 2.0,
> but I'm betting not.  If that's incorrect, I can add some
> IfVersion conditions.
> 
> As noted in the commit message, I only tested with httpd 2.2
> and 2.4 (on CentOS 6/7 and Fedora 26-28).  If anyone has older
> httpd systems which need support, it would be great if they
> could test this before 2.16.0 is finalized, so we can avoid
> shipping with any failing tests.

Seems good to me.  I think I was just being overly cautious when i was
implementing those patches.  Thanks!

> 
>  t/lib-httpd/apache.conf | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
> index df19436314..724d9ae462 100644
> --- a/t/lib-httpd/apache.conf
> +++ b/t/lib-httpd/apache.conf
> @@ -25,6 +25,9 @@ ErrorLog error.log
>  <IfModule !mod_headers.c>
>  	LoadModule headers_module modules/mod_headers.so
>  </IfModule>
> +<IfModule !mod_setenvif.c>
> +	LoadModule setenvif_module modules/mod_setenvif.so
> +</IfModule>
>  
>  <IfVersion < 2.4>
>  LockFile accept.lock
> @@ -67,9 +70,6 @@ LockFile accept.lock
>  <IfModule !mod_unixd.c>
>  	LoadModule unixd_module modules/mod_unixd.so
>  </IfModule>
> -<IfModule !mod_setenvif.c>
> -	LoadModule setenvif_module modules/mod_setenvif.so
> -</IfModule>
>  </IfVersion>
>  
>  PassEnv GIT_VALGRIND
> @@ -79,9 +79,7 @@ PassEnv ASAN_OPTIONS
>  PassEnv GIT_TRACE
>  PassEnv GIT_CONFIG_NOSYSTEM
>  
> -<IfVersion >= 2.4>
> -	SetEnvIf Git-Protocol ".*" GIT_PROTOCOL=$0
> -</IfVersion>
> +SetEnvIf Git-Protocol ".*" GIT_PROTOCOL=$0
>  
>  Alias /dumb/ www/
>  Alias /auth/dumb/ www/auth/dumb/
> -- 
> 2.16.0.rc0
> 

-- 
Brandon Williams
