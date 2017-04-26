Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CFF5207E4
	for <e@80x24.org>; Wed, 26 Apr 2017 03:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1171618AbdDZDcT (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 23:32:19 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36858 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1170946AbdDZDcR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 23:32:17 -0400
Received: by mail-pg0-f68.google.com with SMTP id v1so7559061pgv.3
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 20:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mrVbPtY+Gv6rMBLIIg5mwjrToSoIj+JjEcaiS2W/Z7E=;
        b=Rlq4cPQdCx9C2DyVqtWokiPNAcWKulNbgdbuV4paIFXD+Pr2j+E30C8g8t4lrmz4PU
         FZoz/EyKdHyNJcAM/vMpxW21clrqCoubXM/TxkWNwmYlujcuipgadKs9gh1PVAtCPC50
         ERpA6NHONUDdbVcycRqzYj9yopmarR6Ux9MzkT2OLKeyfA0CXrysoTY1LPnhdCYwn5Aa
         8Oi10SKIJm9KbFEse+2wM72Uyl2ecUQ0NLAgNLnzqIbMlRHbQXBWb7ZUKM1PI7QONcNO
         rKk3WSptCNzS37+ddB3c5/Ed6MH0O5H+f9RWiucNyDgGKdkis4i/441MPeyElxUq175m
         qwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mrVbPtY+Gv6rMBLIIg5mwjrToSoIj+JjEcaiS2W/Z7E=;
        b=ctPAjw8VXr/3qp3OpXt6vLS8PnOeYuLCOi00MBkFiLXmlcmQ7PjPhJMdtgdfS9rRRK
         AzVNP9EVAQcfuwDb96GJE5VHPlc1n6DoS8578kL03mxtuYyav6lstS4Nf2JdhFRL9XkX
         gZc5YIxixYYAfFudpYcU7crsIz7EIm9NGOF5Hex/xyevYApQ1cCCUgv7DAbBhN+35uPL
         lV5gjbhzboTTfRUfCZbxdD5/flpUPVXrRAGwZp65Fye5tqiwi+YVfzFh7T8S9vKmRhFn
         blmTMW4k7ztnnfVIbjY4R7T7jU2EJhJz94wZ3PwVCRU5VSxAfH+Hcrf7wkv6KpcvHYQ+
         m2kg==
X-Gm-Message-State: AN3rC/7I9+paD9LvKhaQCsNfn4quAR9finggcG/ufq4GQDAJ8/uKrQLC
        9Q1bhe3XRsCLIw==
X-Received: by 10.99.146.93 with SMTP id s29mr30297288pgn.144.1493177536921;
        Tue, 25 Apr 2017 20:32:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3179:d004:20b:b383])
        by smtp.gmail.com with ESMTPSA id r1sm38849059pfg.12.2017.04.25.20.32.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Apr 2017 20:32:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH v2 0/9] The final building block for a faster rebase -i
References: <cover.1472833365.git.johannes.schindelin@gmx.de>
        <cover.1493128210.git.johannes.schindelin@gmx.de>
Date:   Tue, 25 Apr 2017 20:32:15 -0700
In-Reply-To: <cover.1493128210.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Tue, 25 Apr 2017 15:51:46 +0200 (CEST)")
Message-ID: <xmqq1ssfu9mo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> This patch series reimplements the expensive pre- and post-processing of
> the todo script in C.
>
> And it concludes the work I did to accelerate rebase -i.

I noticed (this is merely "I felt"; I didn't measure) that recent
"rebase -i" sessions I do on a Linux box is already plenty faster
than before, and it is good to finally see the end of the long road.

Thanks.
