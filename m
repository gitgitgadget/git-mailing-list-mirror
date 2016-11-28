Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38C181FBB0
	for <e@80x24.org>; Mon, 28 Nov 2016 18:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752292AbcK1SEC (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 13:04:02 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:35851 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751033AbcK1SEB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 13:04:01 -0500
Received: by mail-pg0-f49.google.com with SMTP id f188so59074724pgc.3
        for <git@vger.kernel.org>; Mon, 28 Nov 2016 10:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EoQQf/SKLaSjWqjHd60Tsbem8jwHspbzhxCf6HMd/d8=;
        b=Wk922dn0hkzda0Z0Ithfdq9SVlTYmRZw738Cqcf9Ghl5OZ9wCxelwTnp2XPNV1zx8+
         t/E+3xcZi9jTRyFKF/Nuwy6YfO7JP5IJIshk8t5sFRqykB5fLGcFihOniRZ8tgSpWdxa
         E5BeCBIqZh/LyeL2ev/E11186HaILfyHlKQH0Sl2d1cEXNy8175+CuIgVlzmN2uctknZ
         yiFax+YTkeFmpNE18NpsJeqWL2xtiCYaDcrg4lwinbiyVnL0iwn4lBorX45dmsVL5vx4
         ozidQyrMz3m2t7YSrys2A6eTwqFhEZ7BKEpU7giiD8dcSh8rm++XZ4AGrX2YZF3wV6iO
         TI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EoQQf/SKLaSjWqjHd60Tsbem8jwHspbzhxCf6HMd/d8=;
        b=VcFiG3bGRz0aoDbS/xT9l/vCizsVyQO+UWGswvuoPO+qTZGkFBBIrPopUDX5zs7RY6
         VnhKdlRKUxxpG7mkNL/e/SYr6BKkyD4Ce8HEJujTSwzsSTAKTKhDeEnCrqtJUUDgTJSy
         gEfiVxHGOWEqBHm3s3SDZkivI6rk59nl6Vyo6JmByXaFrL/bZ4oklDCF3lV5XM0DK5CZ
         XWEtSM8GxM3Yf4KfR/Wu89Cia/4Bxvtf0q3lBreqi0koN4TqTBJqzhIHKsTJz1/bSDt4
         WUDIsviHuaXRFqt63lZDzxjIkfPN8Hro43oZ5T9O8LlGApfV70G5RWqnh0PGZc1wQomd
         ZMfw==
X-Gm-Message-State: AKaTC021veQGpZNrpLD0uGN2/ws/RwO9aIrvTWgw3tGeGs9Jue3wVd6xVJVXqcdgYY8HnLdk
X-Received: by 10.98.93.201 with SMTP id n70mr23056457pfj.161.1480356240351;
        Mon, 28 Nov 2016 10:04:00 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:6409:b611:8934:17a0])
        by smtp.gmail.com with ESMTPSA id o126sm70974132pga.34.2016.11.28.10.03.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 28 Nov 2016 10:03:59 -0800 (PST)
Date:   Mon, 28 Nov 2016 10:03:58 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, pclouds@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH 31/35] pathspec: allow querying for attributes
Message-ID: <20161128180358.GB150448@google.com>
References: <20161110203428.30512-1-sbeller@google.com>
 <20161110203428.30512-32-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161110203428.30512-32-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/10, Stefan Beller wrote:
> +static void parse_pathspec_attr_match(struct pathspec_item *item, const char *value)
> +{
>
> [...]
>
> +	if (!item->attr_check)
> +		git_attr_check_initv(&item->attr_check, attrs.argv);
> +	else
> +		die(_("Only one 'attr:' specification is allowed."));
> +
> +	argv_array_clear(&attrs);
> +	string_list_clear(&list, 0);
> +	return;
> +}

Unnecessary return statement, maybe you want to remove it?

-- 
Brandon Williams
