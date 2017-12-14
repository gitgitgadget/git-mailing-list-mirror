Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA2551F404
	for <e@80x24.org>; Thu, 14 Dec 2017 18:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754065AbdLNSTz (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 13:19:55 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:33385 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753865AbdLNSTx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 13:19:53 -0500
Received: by mail-qt0-f171.google.com with SMTP id e2so9132161qti.0
        for <git@vger.kernel.org>; Thu, 14 Dec 2017 10:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9SjkhTRTHYrym0L0BfRar8aQlPofQSuNYARnOHiwYiU=;
        b=novgjruqgK2GI8pI53LkKpe153zqjhPhcNM0XrV0EUUWOQtM+Q8movAtdN75zH9Cho
         5z1F91I0WDiRRrrhbWbpn++nLB1PQhk16ioshW84bYKH4X1W19JiiLIZOwuTuBRFcILB
         JqW42IfNNYSIiDYAY7aUg/iRTK4DAA/bbnEnm2LS4te6cTBpA6Celfxc/Ai/XCeZZP4E
         lsN8ZzqpGxXWK3J//bifybD49GRfDbZ8SkwNxKBKFehaz/a0O+Fga2qKhoiVlkFd7sIi
         XyLAktk0K2czwfW2AcLTiJp4kHy5q2jeiiaFgPanf3BYEm5/dOvKQekYDpEGGiVayr2T
         mBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9SjkhTRTHYrym0L0BfRar8aQlPofQSuNYARnOHiwYiU=;
        b=O4JvLiywGXPQlPxxwOPokQeuLT7SSsxwXDMNV715iMtIAeO0Z5Jhv6i+LbXxUC3XPa
         aAwnZ366ZHgJb7oxS5K4t+qT9ogm5KDg+pF/m4LnaUHcouQHy3p+9uRxMFhec3WSObqG
         z5X7KlKbEipbgDwVMI+0va6ClZWZv4NkjBu0nW/l9IMb4hjs/jnSv3vLDjg07V0SVriG
         qhInj8BfATOyRsreAEzF6x9xWgGJJ04W5Wx79jYxkoHwsfiz879RMomkPK0lqZdl0xD8
         1xIm4hI9Mt4LH/JfCwu92wBycfZ2UikXfl2qeDncW065AGfe/9OLhCtQ5LwjNbg1CXSV
         UXXQ==
X-Gm-Message-State: AKGB3mIkbQVa5PnAXwaO9s+mHar14JpcCvprAkr4FtdSn9Xly455+f9o
        eYFY6ukJtQFsYHEuu9JIwX8=
X-Google-Smtp-Source: ACJfBovnCeBDV2wZzcoyWtzZrhz1n4irXpwM8axMpm3btZpOeFzgsUJq34BbauHPErWoYRwHZfwoCQ==
X-Received: by 10.200.19.7 with SMTP id e7mr14329824qtj.181.1513275592116;
        Thu, 14 Dec 2017 10:19:52 -0800 (PST)
Received: from zaya.teonanacatl.net (pool-173-67-181-41.hrbgpa.fios.verizon.net. [173.67.181.41])
        by smtp.gmail.com with ESMTPSA id v17sm2964685qtj.35.2017.12.14.10.19.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 14 Dec 2017 10:19:51 -0800 (PST)
Date:   Thu, 14 Dec 2017 13:19:49 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/2] t/lib-git-svn.sh: improve svnserve tests with parallel
 make test
Message-ID: <20171214181949.GC3693@zaya.teonanacatl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171201023239.26153-1-tmz@pobox.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

I wanted to check if this minor patch series had slipped
under your radar.  If it's waiting patiently in your queue
for other topics to advance, that's fine, of course. :)

Finished patches: <20171201155653.29553-1-tmz@pobox.com> and
<20171201155653.29553-2-tmz@pobox.com>.

Thanks,

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Anyone who is capable of getting themselves made President should on
no account be allowed to do the job.
    -- Douglas Adams, "The Hitchhiker's Guide to the Galaxy"

