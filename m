Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB3AE1F404
	for <e@80x24.org>; Thu,  1 Feb 2018 23:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751697AbeBAXAU (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 18:00:20 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54960 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751567AbeBAXAS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 18:00:18 -0500
Received: by mail-wm0-f66.google.com with SMTP id i186so9007994wmi.4
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 15:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=PE24feJ51rR5fO4G8KYZFuolKTTJ0EbipTG5+EpSlYI=;
        b=U/crMOCtOXeNdb4gaf1DEXtW7tAJUMJCBzgTFCY5CKgs9mQdGeNqdWQGj+KHwTCdki
         VOouKyZA5101JcUxRECpD4tWa/X1T+2K25+wKotGyKe5m4eHwN57XesSNJH67vWI1OE2
         6LP+hvcMDG0HDumiG6DXgYqWhJVeUSopfyXnkRGqn7Q2lc559n8Pc2w839+3MeW1Eq9I
         riYrVerNFS2gI8lB/fTLvSIkcWLflauaZtKHXR1j4CSzgyOuET07jq8AHqXYS/sQ+1ux
         RIAwW6DDXJVizSVh9J0FLJutbWC9UaNgxcl+IPrB2PW3ZvffbHtOHvu3H05u5aoTkiFU
         Bz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=PE24feJ51rR5fO4G8KYZFuolKTTJ0EbipTG5+EpSlYI=;
        b=BjAyFLy8V5/8ZgDmvGAchKUkoK4t4ok9GoKPMNSdGKpu/2n4Vp/rayqVB+0YikMe+5
         KTLmxc4ZsUFHqh40UgUa+f4NSrFmQjc+z8cSgZONie7a1lQVGbYHcE2VJkR1Fj444gzk
         oVQithwseKfjYk81B8UqimdEVUqbN8dmIYmik4noSxBWEkaVxgzfjax6IYAM3/lsni/Z
         V5zQ3e1VL8GM5ucbBOHqRgVgBnUb4fU54cc/BoTdIkCZPOTe0deBD6BP3Ygatn3KzcFX
         /eapPVZRNe9+ZwjvKnWWLaBZHNVfGH2X+8bCzTWpGzJ1SuBPOtLqhlfSn72wN9/Iz9g4
         DGfA==
X-Gm-Message-State: AKwxytdkaMw/9wbg5z/w3Rh/v7paO3wYTEdgSxjd8b66neBY+aeRvktm
        FHUdcZiWy0g9ILc2QRKaXeQwVuIV
X-Google-Smtp-Source: AH8x227iWg5NzTix/jRNBqLvo365D9CvjvjDg3SVRYlGHE2HJqdkphtym1ejeKU6Nim3fIO1OtX3sQ==
X-Received: by 10.80.176.163 with SMTP id j32mr52484244edd.270.1517526017185;
        Thu, 01 Feb 2018 15:00:17 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id q11sm547383edj.64.2018.02.01.15.00.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Feb 2018 15:00:16 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] dir.c: stop ignoring opendir() error in open_cached_dir()
References: <20180118095036.29422-1-pclouds@gmail.com> <20180124093023.9071-1-pclouds@gmail.com> <20180124093023.9071-6-pclouds@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <20180124093023.9071-6-pclouds@gmail.com>
Date:   Fri, 02 Feb 2018 00:00:15 +0100
Message-ID: <87d11omi2o.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 24 2018, Nguyễn Thái Ngọc Duy jotted:

> A follow-up to the recently fixed bugs in the untracked
> invalidation. If opendir() fails it should show a warning, perhaps
> this should die, but if this ever happens the error is probably
> recoverable for the user, and dying would just make things worse.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  dir.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/dir.c b/dir.c
> index 44b4dd2ec8..55736d3e2a 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1787,11 +1787,16 @@ static int open_cached_dir(struct cached_dir *cdir,
>  			   struct strbuf *path,
>  			   int check_only)
>  {
> +	const char *c_path;
> +
>  	memset(cdir, 0, sizeof(*cdir));
>  	cdir->untracked = untracked;
>  	if (valid_cached_dir(dir, untracked, istate, path, check_only))
>  		return 0;
> -	cdir->fdir = opendir(path->len ? path->buf : ".");
> +	c_path = path->len ? path->buf : ".";
> +	cdir->fdir = opendir(c_path);
> +	if (!cdir->fdir)
> +		warning_errno(_("could not open directory '%s'"), c_path);
>  	if (dir->untracked) {
>  		invalidate_directory(dir->untracked, untracked);
>  		dir->untracked->dir_opened++;

I haven't found the root cause yet, but we should not release a 2.17
with this patch.

I tried deploying a 2.16.1 + various patches (including this) internally
today, and on a test set of 236 machines with existing checkouts
(already using untracked cache) 79 would spew "warning: could not open
directory" warnings, warning about a lot of directories that did not
exist at the currently checked-out commit.

The warnings go away on a one-off:

    git -c core.untrackedCache=false status

So there's some issue where an existing index with stale UC will be used
by a newer version of git, and will start very verbosely warning about
every directory referenced that can't be found anymore.
