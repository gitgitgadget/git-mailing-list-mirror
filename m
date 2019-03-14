Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C054D20248
	for <e@80x24.org>; Thu, 14 Mar 2019 04:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfCNEeR (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 00:34:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46814 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfCNEeQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 00:34:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id 33so4291116wrb.13
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 21:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Tkqq80KtgL7mazsxRdVmaqQzsnA9IVdlTGcDGqCaDec=;
        b=A2ZdIXpHiHfrJ+ZDSUZaXddEkCk+6W5OeoBM9jfn362XVTQOOZ8bWrtqASIwChzwph
         QpMP0o86bIzYMQHnONtD9jgwYEz6xeKFq6rGXclah64msNzECQGZ6OyBYqMsMxTpjbWa
         YGHp5nfHsalmYa9BNnztVbSakbMkQD8OTqkjpaUW5Exjn3FV0wEGJO1qykQUoVHmLSCL
         6UUvBkQgcpPUDpGb8nmUAiWeyV2tlcN4oQCWAkpTC6a1WM3T/TenfLB3fVbT2ftml2iR
         RvRpwPMndDT9tXOTqq+5eKuNkr7CDwIgsjoAsvJEt4Hq0mir8Xy8lTPbFx4XFWeEfjmA
         PXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Tkqq80KtgL7mazsxRdVmaqQzsnA9IVdlTGcDGqCaDec=;
        b=TBVsLLp/qQmR0tHciqtOHF+Tz8eMVvlgDQqry1UmPx3nQZA/I+iB+m3u1zpmlEeCXZ
         mqzCT+A71Cpzh1fS6MBHXsMMa5NmwD4RMWGUal85OUj/b+NeUQGUb4+gawjZqEtZuQUv
         WJhWxMP50teHVGM7IsPsD4Q2ypmDR4/t387pIwg+vKAlGI61h/Hjtgc6Y/8ESrl0Db6G
         +BwERQ1Yn4Cqv1x/KzjQAHpE1dvpWI8IepoDipzBQPSx2vMxfooPgg4IfyAzOBZGfydd
         Bwwu8uzFIeSCkC9M2exji/jXYRaxfwgWALODk0XgEBU6GLzQMhuKgaoKzQ0sZUQ+h6iN
         YTgg==
X-Gm-Message-State: APjAAAUKrRuLkwrnYZ/yI597sZ3Uy4uVk8ds9cbhZkIML9atiDmnaFXm
        jxHGyNTWk7i9kc3jhdFvSEs=
X-Google-Smtp-Source: APXvYqytZOCOWlaZ05DS5D6DdNj6HHiwmIDqFgXTxnJ3FWpofUpqmPILeLr+XnMC79GWqrs8CrWp0w==
X-Received: by 2002:adf:ebc3:: with SMTP id v3mr2730535wrn.35.1552538054617;
        Wed, 13 Mar 2019 21:34:14 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id u4sm1537746wmb.25.2019.03.13.21.34.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 21:34:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Luke Diamand <luke@diamand.org>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 05/11] tests: use 'test_atexit' to stop httpd
References: <20190313122419.2210-1-szeder.dev@gmail.com>
        <20190313122419.2210-6-szeder.dev@gmail.com>
        <xmqqd0mub0d8.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 14 Mar 2019 13:34:13 +0900
In-Reply-To: <xmqqd0mub0d8.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 14 Mar 2019 12:28:35 +0900")
Message-ID: <xmqqva0m9ire.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I see most of these changes are removal of stop_httpd because it is
> done as part of start_httpd() to arrange it to be called at exit.
>
> But ...
> ...
> ... I see we lost many "trap 'die' EXIT" in the orignal.  Is that
> something we want to lose as part of this commit?

And the answer of course is that we cannot afford to, and it does
not make sense to, keep it, as one of the early thing die() does is
to execute the atexit cleanup scriptlets.
