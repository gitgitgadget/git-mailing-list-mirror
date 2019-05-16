Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SORTED_RECIPS,SPF_HELO_NONE,
	SPF_NONE shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F06351F461
	for <e@80x24.org>; Thu, 16 May 2019 22:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfEPW7q (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 18:59:46 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37331 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfEPW7q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 18:59:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id g3so2617359pfi.4
        for <git@vger.kernel.org>; Thu, 16 May 2019 15:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :in-reply-to:references:subject:from:cc:to:user-agent:date;
        bh=zlhlRtJeasseLSHTIydrTmO9zbtDDlI+0Ya/YOKB9/s=;
        b=ZF81zHWkfI0S/B9G0QIu6aPxZ9DY+1UlvX28C634pwUbInCy7H4xgp+9jbCjxouLza
         iJ/A9TUvY2+TCnRA/rmnl0BoWsy8jBnb+G6Dg7VBunKlGJTzTXGJAnFtOTO+kRPHKIMP
         CcWvtzXSGiLdbJO+3ANAxl3SDIv9n/XLMCmaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:in-reply-to:references
         :subject:from:cc:to:user-agent:date;
        bh=zlhlRtJeasseLSHTIydrTmO9zbtDDlI+0Ya/YOKB9/s=;
        b=M6v+4AT9khE9lKHiTd8fbAwgEt4/VDr+Py+bOV/sUfUu7UCAcVufZi/u8chtCq3ybR
         QbOqj9P7OYiOwsxsGlOoIj/RmFmLRd9daPIYWXT0uMA8taSCwLtSYg+kwz9JPBlAHgKn
         0Y4Ic4c/7T0uGJAujWOHkFf1RsK9I+82+9Dq6JI/jIz2wTpOc+HR4vfrgUV6XzvvlIoj
         lf7XEK7GgQNKExls0P1h2nFkQkegDLIuV03bYekwYWaNset1wlJWOzlMURbIt/eGPRTJ
         5bYzqMyAe0bt4g9RpWkd9huZAMX2E4OQg0RP1IUN47fTrCZWaQE+h/xGOEbPtiAkipiY
         i2Uw==
X-Gm-Message-State: APjAAAWF9ND9458RRHHv6FSlBEl+8uvYXHiFxV/Jt7GVErxY7p8ZmTbo
        OPzhJK4XZIx4ruI4zrg3f9kG2hnCRZjwYw==
X-Google-Smtp-Source: APXvYqzgMNcT3ejxEhT9jjIBSZMqryaQHJUOHD/DLT4REITJSJ0rteT8QrWjrFpPzqVwMfC4fg+qeA==
X-Received: by 2002:a65:62c4:: with SMTP id m4mr52900188pgv.308.1558047585836;
        Thu, 16 May 2019 15:59:45 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g17sm10983540pfk.55.2019.05.16.15.59.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 15:59:45 -0700 (PDT)
Message-ID: <5cddeb61.1c69fb81.47ed4.e648@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190509114830.29647-4-avarab@gmail.com>
In-Reply-To: <20190509114830.29647-4-avarab@gmail.com>
References: <20190508105607.178244-1-gitster@pobox.com>, <20190508105607.178244-1-gitster@pobox.com>
Subject: Re: [PATCH v3 3/3] send-email: do defaults -> config -> getopt in that order
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com,
        sandals@crustytoothpaste.net, sunshine@sunshineco.com,
        xypron.glpk@gmx.de
To:     avarab@gmail.com
User-Agent: alot/0.8.1
Date:   Thu, 16 May 2019 15:59:44 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Sorry for weird reply, I'm not subscribed and my MUA is not prepared
for this)

> Change the git-send-email command-line argument parsing and config
> reading code to parse those two in the right order. I.e. first we set
> our hardcoded defaults, then we read our config, and finally we read
> the command-line, with later sets overriding earlier sets.
>=20
> This fixes a bug introduced in e67a228cd8 ("send-email: automatically
> determine transfer-encoding", 2018-07-08). That change broke the broke
> the reading of sendmail.transferencoding because it wasn't careful to
> update our fragile code dealing with doing this in the previous
> "defaults -> getopt -> config" order..
>=20
> But as we can see from the history for this file doing it this way was
> never what we actually wanted, it just something we grew organically
> as of 5483c71d7a ("git-send-email: make options easier to configure.",
> 2007-06-27) and have been dealing with the fallout since, e.g. in
> 463b0ea22b ("send-email: Fix %config_path_settings handling",
> 2011-10-14).
>=20
> As can be seen in this change the only place where we actually want to
> do something clever is with the to/cc/bcc variables, where setting
> them on the command-line (or using --no-{to,cc,bcc}) should clear out
> values we grab from the config.
>=20
> All the rest are things where the command-line should simply override
> the config values, and by reading the config first the config code
> doesn't need all this "let's not set it was on the command-line"
> special-casing, as [1] shows we'd otherwise need to care about the
> difference between whether something was a default or present in
> config to fix the bug in e67a228cd8.

This broke my workflow.

I specify --identity=3D<account> on the commandline and I want that to
pick out my send-email config from my global .gitconfig file that
corresponds to that identity. With this change, the config is parsed
before the getopt part so --identity on the commandline is a nop and
never looks into the config file to figure this out. So at least
--identity is special in addition to --to,cc,bcc.

