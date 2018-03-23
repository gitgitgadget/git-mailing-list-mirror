Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A0F91F404
	for <e@80x24.org>; Fri, 23 Mar 2018 20:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751847AbeCWU1P (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 16:27:15 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35160 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751541AbeCWU1O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 16:27:14 -0400
Received: by mail-wr0-f193.google.com with SMTP id 80so12250807wrb.2
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 13:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Fi/V160vhnkvyJ+RwWh782Bu3Q2v2h9eeWUqHZowXjM=;
        b=VkXPNITfB/iFrNK3FhDDwPV0Tn2hqlnEwWOChmP2qN/Ib21L48Wo8HKBxYjGNBpNT1
         FcLhE0kz7GhFQ8kxo8d+iI5cGmx7uInyIWJXNnDr642mjXkJ/cTnc0870l7zpYE+PlcQ
         eXXPNbREIHm3IU3jplQQQMShSuZIXxMXEmCO+A+bqf6VhsqWKNK9+CsLRiI5qyVp6D7A
         ILaaSCGREbwWd5ERuBipwKUjfllBwV4DkqBNQ5l1TzV3BV00wUgPkiHgZQP+2zLXPfKZ
         e0ZrCSBELfg/FIFpJ3ijLoigAVf8+uyvYMGP9p2FfPymxarcjtTAcXSi9v2sWnWfob5q
         ywtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Fi/V160vhnkvyJ+RwWh782Bu3Q2v2h9eeWUqHZowXjM=;
        b=klNpQrks+LO5IZ+g5x63UOS4ts44lmhA6yN98dm+N4ETM0OvHfxfSgAQZ69VtMXYPq
         nBlr9YpmafnaEzFjp+vXA2G2AvpLaXESwOoDkwsUlTZhB2U+JCgtFm+qvkcIC1t/s5X5
         sHFs6h0m5N2xtfqNlnjkZLBE1tfUHd8kzosGEEvbDJDq9Myyg6AK8iGZP6xyAmkuVrP1
         sOiQZfMGuGlotRTab0p/u8AIg0plKi1XwLO0kNyGZDmp+BOH+EfORzU9oKbzYSTPqKH1
         klXX9C41KckNmKMhydSyur45dTZllTmIbVmGdIGWo/tS2RvGPkgSKHckhFRjCbvYaXF9
         0AjQ==
X-Gm-Message-State: AElRT7HnPgD08lbFy3c40b8K3NLCydr5nbEBz1LJMSR+iEarKd64FprV
        H/SY3mUsrwQNVTiFzzFPMJU=
X-Google-Smtp-Source: AG47ELt/tru0qAR9XkqaIwJjBbU/Ucn9M000oOk1sVmKqj8blKwXEOhIy53gj/nzMUwe96RoVBeg9Q==
X-Received: by 10.223.179.195 with SMTP id x3mr19597778wrd.94.1521836833063;
        Fri, 23 Mar 2018 13:27:13 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id i44sm8808671wri.23.2018.03.23.13.27.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Mar 2018 13:27:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jameson Miller <jamill@microsoft.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2 4/5] Move the reusable parts of memory pool into its own file
References: <20180321164152.204869-1-jamill@microsoft.com>
        <20180323144408.213145-5-jamill@microsoft.com>
Date:   Fri, 23 Mar 2018 13:27:12 -0700
In-Reply-To: <20180323144408.213145-5-jamill@microsoft.com> (Jameson Miller's
        message of "Fri, 23 Mar 2018 10:44:07 -0400")
Message-ID: <xmqqr2oaillr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jameson Miller <jamill@microsoft.com> writes:

> This moves the reusable parts of the memory pool logic used by
> fast-import.c into its own file for use by other components.
>
> Signed-off-by: Jameson Miller <jamill@microsoft.com>
> ---
>  Makefile      |   1 +
>  fast-import.c | 118 +---------------------------------------------------------
>  mem-pool.c    | 103 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  mem-pool.h    |  34 +++++++++++++++++
>  4 files changed, 139 insertions(+), 117 deletions(-)
>  create mode 100644 mem-pool.c
>  create mode 100644 mem-pool.h

This step looks totally uncontroversial, provided that the result
after [1-3/5] is in a reasonable shape ;-)

Hint for other reviewers.  This

    $ git blame -s -b -C HEAD^..HEAD mem-pool.c

can be used to see that most of the lines in this new file are
imported verbatim from fast-import.c at the receiving end.



