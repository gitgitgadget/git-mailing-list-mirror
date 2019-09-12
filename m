Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA4E81F463
	for <e@80x24.org>; Thu, 12 Sep 2019 17:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387582AbfILR22 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 13:28:28 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39830 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387579AbfILR22 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 13:28:28 -0400
Received: by mail-pf1-f194.google.com with SMTP id i1so7577882pfa.6
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 10:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hQOtC8ne+qpC/cbePFTCC2fVWrEuE+7R9ikyTPrftNY=;
        b=dVFnNiF4JPxwoL1RNOVR/Y7nL+8p0Kl3EC4xeygfBkE3NJ43HIYC4Aq+ScT1qIYNMr
         FifFGXvRVzsSSKp6SaqWGnpwhLgXwlbLl309hYqlA05Y9krsyE6t1VDnrS2wUPzh4QMi
         ZHWcYqak+Xt+ANkMGTnr+qYqQSnp/L4+I3t++g/qpQR+gRvwjMZM2olXb7pYu1h4UWLW
         bf+3o4QHJZg5Lp7gKiN4cejZe/qmjy+gHJHHYJs6gt5p/J6KSk7xuviwuYOY9QS4T24d
         RuK9W6qAsM/d8kxfBxn6otuE98eP9SogOVHwF9XMs5Z5ngEt/fJ1TahkGCI1DgjIz7oS
         U/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hQOtC8ne+qpC/cbePFTCC2fVWrEuE+7R9ikyTPrftNY=;
        b=fO1NKo7rx4vPBL6woYKIJjEJckDS9TqaxWJwXybVR3AAabbYubIpjNgqeS/ekHIyhV
         sGMXPbZOM8Z+kt0/xq9Vo2/Rafut2VGcRMiBJ2HE7MI5rraFFpAaSfnpvJmQsEUUWSyK
         USa45dxr+3674vU3OyR+IqnB6DTIl4fa07wOQPPPtRWGZ/5T3frH78Zmi0AM56X6eXxU
         8dy/UmAs+m7JWLTaZQ64JKIdJv4xMa4OUSZPNPCcq3vz3sqiYO/19Z3JwAURfEcQFgR6
         ihoGm0uX1sja/ovrOyDmgLv/jiv0yveT8c3mW8i2orgPDG34TXl8mMEkmMAwBGWCqIaF
         59Rw==
X-Gm-Message-State: APjAAAVuru1C6yRX80Pydet24eUnz+9xfiDXrOgri8Z3AjdHeP0Ehto/
        Aw94t2Zi4oAD1KKeY1xNdVIpuEOHxMA=
X-Google-Smtp-Source: APXvYqxbUf047xqLus2D7Kyxg4UH79rlZRz+5wFZD90x3XLf2JLzIyt8X3dlaBaxcMzNwm+XgcBnJw==
X-Received: by 2002:a17:90a:9503:: with SMTP id t3mr1336731pjo.81.1568309307201;
        Thu, 12 Sep 2019 10:28:27 -0700 (PDT)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.55])
        by smtp.gmail.com with ESMTPSA id 2sm46718105pfa.43.2019.09.12.10.28.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 10:28:26 -0700 (PDT)
Date:   Thu, 12 Sep 2019 10:28:24 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/3] Makefile: run coccicheck on all non-upstream sources
Message-ID: <cover.1568309119.git.liu.denton@gmail.com>
References: <cover.1568101393.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1568101393.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, when we ran coccicheck, it would only run on files that are
currently being compiled. However, this leaves us with a blindspot where
Windows-only sources are not checked since Coccinelle does not run on
Windows.

This patchset addresses this by making the "coccicheck" target run
against all source files in the repository, except for source files that
are pulled from some upstream source.

This patchset should serve as a continuation of the original discussion
about running coccicheck on all sources[1].

These patches depend on "ds/midx-expire-repack" and "dl/compat-cleanup".

[1]: https://public-inbox.org/git/nycvar.QRO.7.76.6.1905031127170.45@tvgsbejvaqbjf.bet/


Denton Liu (3):
  Makefile: define THIRD_PARTY_SOURCES
  Makefile: strip leading ./ in $(FIND_SOURCE_FILES)
  Makefile: run coccicheck on more source files

 Makefile | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

Range-diff against v1:
1:  bc3cd4637a < -:  ---------- Makefile: define UPSTREAM_SOURCES
-:  ---------- > 1:  3878cb2598 Makefile: define THIRD_PARTY_SOURCES
-:  ---------- > 2:  239ffa690c Makefile: strip leading ./ in $(FIND_SOURCE_FILES)
2:  f62b0c7d17 ! 3:  89b7e17469 Makefile: run coccicheck on more source files
    @@ Commit message
         Coccinelle currently runs only on Linux.
     
         Make the "coccicheck" target run on all C sources except for those that
    -    are taken from some upstream. We don't want to patch these files since
    -    we want them to be as close to upstream as possible so that it'll be
    -    easier to pull in upstream updates.
    +    are taken from some third-party source. We don't want to patch these
    +    files since we want them to be as close to upstream as possible so that
    +    it'll be easier to pull in upstream updates.
     
    -    This results in the following sources now being checked:
    +    When running a build on Arch Linux with no additional flags provided,
    +    after applying this patch, the following sources are now checked:
     
         * block-sha1/sha1.c
         * compat/access.c
    @@ Makefile: check: command-list.h
     -COCCI_SOURCES = $(filter-out sha1dc/%,$(C_SOURCES))
     -endif
     +FIND_C_SOURCES = $(filter %.c,$(shell $(FIND_SOURCE_FILES)))
    -+COCCI_SOURCES = $(filter-out $(UPSTREAM_SOURCES),$(FIND_C_SOURCES))
    ++COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES),$(FIND_C_SOURCES))
      
      %.cocci.patch: %.cocci $(COCCI_SOURCES)
      	@echo '    ' SPATCH $<; \
-- 
2.23.0.37.g745f681289

