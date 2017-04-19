Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D465207BC
	for <e@80x24.org>; Wed, 19 Apr 2017 01:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758917AbdDSB24 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 21:28:56 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34907 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758914AbdDSB2y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 21:28:54 -0400
Received: by mail-pf0-f178.google.com with SMTP id v14so960169pfd.2
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 18:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1MXbAqpfKoi/i7a85yCsmYOzXjWoOkBHaYn5M22DPvA=;
        b=TusjIXmdzae22aodYzPQx0AWyrcPl6FWm8ZH3h3DjTcC7oUXI62RMs2JduO/jceNLV
         jVNCo4FBYwLaHh3tV6prEF28b/uFPHL1yZrnrVR7oMekGCCwwLQkJAY0o5iuOr/qnmgV
         rcbgJkZvJCPDD5wwWFBO6T6qjct8cunAcTkEvfs6LjVFPFlCndDJMfIGSmHH9i0tTUEr
         dgdZ1xpiNRGM1wbcjYYYAIWrs5cdp9scPnOJ6FAOduWyFpHKkUHLJNFMS7Up6Ax0xoI4
         T3td9DsfXLkrQPvboisz5dFwfU6uf5Q/dN8Ma8wKSoKILLtaPL9ezn3wq6rwgJ8B960d
         FLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1MXbAqpfKoi/i7a85yCsmYOzXjWoOkBHaYn5M22DPvA=;
        b=SFxF+OHZ2+7rQM8RmrxtS6Ajg2+VXZisn/qlouOGnbI+zR1+s9Hu1mqve7dd4kl884
         YN58SOMSEgMJkRJ45cLeyAFOqEgVcYn5W58p7p7A8ZECPkdrHAyb/qNHmSDtqSZLlhHE
         DeItthJ+tVF0fIIdnF4IlR7L8LmgU4G5vh7dr0bt1QwTGJYTTxtNpe73gGQAYq5r8RDp
         IzkZdEsjyvl8S+3DGhkY0Bjif3EUwpyX0M5MK/c5YjJe1Hk0uQY/puyCDIciNgh8IUW1
         fFNKAavC4bynumC8wkgmZLhww/XPv+Luy3mID7mH+Bp+lwc9YCkd8Xw5Ge9X7/gGalTd
         ITMQ==
X-Gm-Message-State: AN3rC/7A7Bd3MJTZrkixmNBx0c/iNA34iCARk0ZXpuvRdsiNRHB0ZwfO
        9qoGCFEsj2mUIQ==
X-Received: by 10.99.154.9 with SMTP id o9mr398014pge.54.1492565333462;
        Tue, 18 Apr 2017 18:28:53 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:b1:d67a:b688:bae6])
        by smtp.gmail.com with ESMTPSA id e22sm754549pgn.11.2017.04.18.18.28.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 18 Apr 2017 18:28:52 -0700 (PDT)
Date:   Tue, 18 Apr 2017 18:28:24 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org, l.s.r@web.de
Subject: Re: [PATCH v3 1/2] use HOST_NAME_MAX to size buffers for
 gethostname(2)
Message-ID: <20170419012824.GA28740@aiede.svl.corp.google.com>
References: <20170418215743.18406-1-dturner@twosigma.com>
 <20170418215743.18406-2-dturner@twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170418215743.18406-2-dturner@twosigma.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

David Turner wrote:

> From: René Scharfe <l.s.r@web.de>
>
> POSIX limits the length of host names to HOST_NAME_MAX.  Export the
> fallback definition from daemon.c and use this constant to make all
> buffers used with gethostname(2) big enough for any possible result
> and a terminating NUL.

Since some platforms do not define HOST_NAME_MAX and we provide a
fallback, this is not actually big enough for any possible result.
For example, the Hurd allows arbitrarily long hostnames.

Nevertheless this patch seems like the right thing to do.

> Inspired-by: David Turner <dturner@twosigma.com>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> Signed-off-by: David Turner <dturner@twosigma.com>
> ---
>  builtin/gc.c           | 10 +++++++---
>  builtin/receive-pack.c |  2 +-
>  daemon.c               |  4 ----
>  fetch-pack.c           |  2 +-
>  git-compat-util.h      |  4 ++++
>  ident.c                |  2 +-
>  6 files changed, 14 insertions(+), 10 deletions(-)

Thanks for picking this up.

[...]
> +++ b/builtin/gc.c
[...]
> @@ -257,8 +257,12 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
>  	fd = hold_lock_file_for_update(&lock, pidfile_path,
>  				       LOCK_DIE_ON_ERROR);
>  	if (!force) {
> -		static char locking_host[128];
> +		static char locking_host[HOST_NAME_MAX + 1];
> +		static char *scan_fmt;
>  		int should_exit;
> +
> +		if (!scan_fmt)
> +			scan_fmt = xstrfmt("%s %%%dc", "%"SCNuMAX, HOST_NAME_MAX);
>  		fp = fopen(pidfile_path, "r");
>  		memset(locking_host, 0, sizeof(locking_host));
>  		should_exit =
> @@ -274,7 +278,7 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
>  			 * running.
>  			 */
>  			time(NULL) - st.st_mtime <= 12 * 3600 &&
> -			fscanf(fp, "%"SCNuMAX" %127c", &pid, locking_host) == 2 &&
> +			fscanf(fp, scan_fmt, &pid, locking_host) == 2 &&

I hoped this could be simplified since HOST_NAME_MAX is a numeric literal,
using the double-expansion trick:

#define STR_(s) # s
#define STR(s) STR_(s)

			fscanf(fp, "%" SCNuMAX " %" STR(HOST_NAME_MAX) "c",
			       &pid, locking_host);

Unfortunately, I don't think there's anything stopping a platform from
defining

	#define HOST_NAME_MAX 0x100

which would break that.

So this run-time calculation appears to be necessary.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
