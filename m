Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94506C47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 15:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 772956124C
	for <git@archiver.kernel.org>; Mon, 31 May 2021 15:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbhEaPbR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 11:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234701AbhEaP2B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 11:28:01 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E58C061344
        for <git@vger.kernel.org>; Mon, 31 May 2021 07:19:29 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ci15so13570631ejc.10
        for <git@vger.kernel.org>; Mon, 31 May 2021 07:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=D7YGa7F92ykWybAKEHD8A5qTpI2uAGsfFTyBWMZII00=;
        b=gDGDXSqhXrL7/NJ8xwA0f4a9051FD69+hETk1xnhekZCXo9MgQ7DkybLvUDajag5kK
         sLvJdTyIotydvjAW+XJMg8spiO1TpWAdCPt9u2Fl+rTMq/n4Cm0h/X1ATqkfRc5Ay/FN
         w+QthEd+4jOaTDt8Ls+eG+0r02q3Ynb0rYxzWX0hk4kCkRM0MITMrhP6b+aIyoJeyf/o
         dRqhYa8xTQv8jjC0wtT9pzYJ37SqJKBSzKgYrtt3+yvQ/hg8OVP1LU66XLQfqcQ/Iqr9
         D+rEY4l7afDgUAGbQp3EhltRL3Lg1dMt9Oeld2CYkupYslRvLQHUZZk5FjE94gUL6SVw
         +ULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=D7YGa7F92ykWybAKEHD8A5qTpI2uAGsfFTyBWMZII00=;
        b=L5ANfTWd8HMRE+7x0lO1tn5uf4ootK3YbSBllyRWQJDnphU3JSS9Xm8hdRqIitnDiY
         v0EB8Oiuqpcq9dpKURkP3rxIfmpMjQ/eIDRL1wbQ8Bzcgs0CPcWA9xNBKMmyVgdhN4Pl
         9368hxuMZZoQxs9V3GJ/h06gRKlyj+QOsXUkTaSBFrLvpyEBpSSjFwixFypzc5Pi1Dbt
         ma9I4lcQqZcPcu0h3VqmJsPQQKK0rrLJNUq3mHyecVuAYqe/mGTYnIWTpE2iZD/ftpa2
         nBbdOIrDqafaOpcoyboXSZZQqPWN0x7byfCSMo1ssUA6ZuQdW+a3t688RDNtuRBCWzpM
         1l5w==
X-Gm-Message-State: AOAM53292M4Ya76/QNhC9C957cxiw9EQAQuDH5P202IXVwJiUpEm/EQU
        HOnPhSv39iBMoHrWVGMRLNg=
X-Google-Smtp-Source: ABdhPJyTl+kdbr0F5ua6ES88DH8sqSuP1MI4G7i1h0ZACDcXgWhghmfHtEqLEOO/IHYsQprqdWqvNA==
X-Received: by 2002:a17:906:4088:: with SMTP id u8mr22792946ejj.240.1622470768107;
        Mon, 31 May 2021 07:19:28 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id o64sm5920060eda.83.2021.05.31.07.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 07:19:27 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] packed_ref_store: handle a packed-refs file that is a
 symlink
Date:   Mon, 31 May 2021 16:18:46 +0200
References: <20170720232040.GA159617@aiede.mtv.corp.google.com>
 <d0da02a8b6f0272fa70ae3b1dc80fee6c6ee8d18.1501111803.git.mhagger@alum.mit.edu>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <d0da02a8b6f0272fa70ae3b1dc80fee6c6ee8d18.1501111803.git.mhagger@alum.mit.edu>
Message-ID: <87y2bv0yvl.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 26 2017, Michael Haggerty wrote:

> [...]
> +test_expect_success 'pack symlinked packed-refs' '
> +	# First make sure that symlinking works when reading:
> +	git update-ref refs/heads/loosy refs/heads/master &&
> +	git for-each-ref >all-refs-before &&
> +	mv .git/packed-refs .git/my-deviant-packed-refs &&
> +	ln -s my-deviant-packed-refs .git/packed-refs &&
> +	git for-each-ref >all-refs-linked &&
> +	test_cmp all-refs-before all-refs-linked &&
> +	git pack-refs --all --prune &&
> +	git for-each-ref >all-refs-packed &&
> +	test_cmp all-refs-before all-refs-packed &&
> +	test -h .git/packed-refs &&
> +	test "$(readlink .git/packed-refs)" = "my-deviant-packed-refs"
> +'

FWIW this broke tests on AIX because we can't assume readlink(1) exists
at all. See d2addc3b96 (t7800: readlink may not be available,
2016-05-31) for a workaround.
