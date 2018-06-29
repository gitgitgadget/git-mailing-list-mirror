Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BC971F516
	for <e@80x24.org>; Fri, 29 Jun 2018 22:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936799AbeF2WK2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 18:10:28 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36245 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936795AbeF2WK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 18:10:26 -0400
Received: by mail-wm0-f42.google.com with SMTP id u18-v6so3442733wmc.1
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 15:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=YIZw00rs5AgxZO4jh3IW4dgkBkSYxR+XYEjKsVZCM9o=;
        b=b2KqTFD2rXCU1dJhb9zMLzwQRGhYiSUkgwEX/jdwAPvz8DjBDnvJXxwh5f/ebbyXIv
         M2M4CPsqQ83NoqGP5iKeUtziNtbtv4SUWwkofMovpO0UMwNe8/dZXctzhi/cHiim4076
         QknP3C5bqGfxeBfmM9V/vb+04DeCAXU/e7TseQfKX20QI06fKypdkWF1DnrjsA35o2VY
         RFUzGnH7+bL3WMa3ZUwVo1juOsb6IVArsbjOYAcUYfU8z76oRgrWy4Js3kHNVCVqPOPB
         Jo+Kqd7YDSrKgKY7Xn7CrU7Y4SkDcKKsIlaVN08O/+LSzFjcOO++3I0Xkr67NmAyL7Vg
         Ji2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=YIZw00rs5AgxZO4jh3IW4dgkBkSYxR+XYEjKsVZCM9o=;
        b=gm3M9UDuc15M0ERsVuIMgcrBjdVc1OxPzyShscWRsHgF9fscXq4OKKlyLIiZ3iv1Wg
         otKXzmqBGCWtIuzSzdWVQQR/Tw6FPVuCEzp6iEFTzCz4hOqt2aLxZw2HbLoP5g3GfSMC
         te/8wblPLIyriRGoAVL+/DVDNx9FyeloFdiClxTXuWRE/Yy0gv+6hi9th+LMv9w/UREc
         uW598iZ304GvMuWK45crFP5SgiikstcmJoZMl5BTOysf0BQ7m+7ablkv1F8F1Dq48XkI
         cXrYxU3NhwQr1OZWHGVdpYWUNlyXuE5ZECwZaSybLNHjKW2xnOWwkX1wo+saxfmzkAUh
         sH9Q==
X-Gm-Message-State: APt69E1bSP9RHgWcLe/mbWr1j3w8b39Qs3QHOs2z8IyiJ4bRDz9WHaO/
        2viM612AVnh332LjdrPVnQCvNK4V
X-Google-Smtp-Source: AAOMgpdmfdqXOkdasjN+QTcOgRLCx2HyqDEIyDgxx0R8ZuRHa3lIpe2W7EBxSULiX8WsyFlyDJIBvg==
X-Received: by 2002:a1c:b94c:: with SMTP id j73-v6mr3041846wmf.104.1530310225291;
        Fri, 29 Jun 2018 15:10:25 -0700 (PDT)
Received: from evledraar (240.red-79-145-32.dynamicip.rima-tde.net. [79.145.32.240])
        by smtp.gmail.com with ESMTPSA id s79-v6sm3946320wma.37.2018.06.29.15.10.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 15:10:24 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org
Subject: Re: fast-import slowness when importing large files with small differences
References: <20180629094413.bgltep6ntlza6vhz@glandium.org>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180629094413.bgltep6ntlza6vhz@glandium.org>
Date:   Sat, 30 Jun 2018 00:10:24 +0200
Message-ID: <87o9ftckhb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 29 2018, Mike Hommey wrote:

> I noticed some slowness when fast-importing data from the Firefox mercurial
> repository, where fast-import spends more than 5 minutes importing ~2000
> revisions of one particular file. I reduced a testcase while still
> using real data. One could synthesize data with kind of the same
> properties, but I figured real data could be useful.
>
> To reproduce:
> $ git clone https://gist.github.com/b6b8edcff2005cc482cf84972adfbba9.git foo
> $ git init bar
> $ cd bar
> $ python ../foo/import.py ../foo/data.gz | git fast-import --depth=2000
>
> [...]
> So maybe it would make sense to consolidate the diff code (after all,
> diff-delta.c is an old specialized fork of xdiff). With manual trimming
> of common head and tail, this gets down to 3:33.
>
> I'll also note that Facebook has imported xdiff from the git code base
> into mercurial and improved performance on it, so it might also be worth
> looking at what's worth taking from there.

It would be interesting to see how does this compares with a more naïve
approach of committing every version of this file one-at-a-time into a
new repository (with & without gc.auto=0). Perhaps deltaing as we go is
suboptimal compared to just writing out a lot of redundant data and
repacking it all at once later.
