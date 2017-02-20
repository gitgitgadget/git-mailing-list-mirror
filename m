Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3897201A9
	for <e@80x24.org>; Mon, 20 Feb 2017 21:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750948AbdBTVac (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 16:30:32 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34326 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbdBTVac (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 16:30:32 -0500
Received: by mail-pg0-f68.google.com with SMTP id s67so3965842pgb.1
        for <git@vger.kernel.org>; Mon, 20 Feb 2017 13:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=O/57xYZP1cZ0E0nxOMBSi+9cWaZ5LLJrsVkitv3FQFw=;
        b=Qabb6pFJas2nQ6wIJK1N17ufDEu9DyBwwlD15F6sPUjy6+DUD7jM9GtvDe0vGBsBzO
         wfa3hj9g2QxzbwsAw7JJmeNS08lc3J86Xkq9Mkxris8OlyTC7p+OTCV+BqeCxtfJVEzJ
         Q18dBxp5xJCuTlkXgtppDJ6psRayF21POKZKZOxNXw3fSeC33RCqTkczJ/tVStkY+ypY
         +fieU4WFZaWTAWmLHRsQEaCXuwepZ9zz/WL/qzflS2RwmL8ddQ6aGRqK8VDhYoAhpgEO
         ywV+aMwVaaDlxUQZVZebrKnlTYj12jvOy3yGg2U1irebwnjSK4mzeS/e6BtqvIjJ1V3X
         1whg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=O/57xYZP1cZ0E0nxOMBSi+9cWaZ5LLJrsVkitv3FQFw=;
        b=ESESM0Bhl4xWkxe3gblekM3ugKhNPXrzJ4xDy7bDVOgFhpj7axdkzPHdKhCc0o+1iP
         yTIRK20PdDKFLSvMEsl459hkSX0xRoO1RLX97y+fji7laaGYrI4Cob7uuhQMrms52AuC
         n0oIMAfMp/CI1bK46wtKqaO2KHVWvwNkqAjTHlB4r6SSEUwZqFm0RJ1Esm89UP5D5rOF
         CoAY+0JdRl9N8xTfGJTaoMOl88k0uT0VKUOl3X8n76L1ckG7JFykHsSn3K4G2PRykuOP
         XTcDfPhwij9i7RZSMJx9j/tAXxrFmqFmU9YE8Ud+Byhoid/2n+ZIaUl77DykUp1qaMPv
         nRSA==
X-Gm-Message-State: AMke39mbG971OogIA8HxuLtpfY+ztzdNZrsNxWaedybug+yJw/vcEN5WkjLBmo3gT5lykQ==
X-Received: by 10.98.67.72 with SMTP id q69mr28313029pfa.14.1487626231206;
        Mon, 20 Feb 2017 13:30:31 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:71d2:895f:c7:4f5e])
        by smtp.gmail.com with ESMTPSA id v9sm36768798pfl.102.2017.02.20.13.30.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 20 Feb 2017 13:30:30 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Sokolov\, Konstantin" <konstantin.sokolov.ext@siemens.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: Inconsistent results of git blame --porcelain when detecting copies from other files
References: <71BF70CE41AEE741896AF3A5450D86F11F4268FF@DEFTHW99EH3MSX.ww902.siemens.net>
Date:   Mon, 20 Feb 2017 13:30:29 -0800
In-Reply-To: <71BF70CE41AEE741896AF3A5450D86F11F4268FF@DEFTHW99EH3MSX.ww902.siemens.net>
        (Konstantin Sokolov's message of "Mon, 20 Feb 2017 17:59:06 +0000")
Message-ID: <xmqqd1ecim8a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Sokolov, Konstantin" <konstantin.sokolov.ext@siemens.com> writes:

> However, when using --porcelain DirectoryReader.java is reported as the origin of lines 502-504:
> ...
> This is not only inconsistent with the other outputs but the output is also inconsistent in itself because lines 496 -498 do not even exist in a previous version of DirectoryReader.java.

Hmph, this sounds vaguely familiar with

    http://public-inbox.org/git/20170106042051.nwjiuyyp7ljhs4sr@sigill.intra.peff.net

which is part of Git 2.12-rc0




