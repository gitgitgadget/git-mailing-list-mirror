Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37E902035A
	for <e@80x24.org>; Tue, 11 Jul 2017 23:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755483AbdGKX61 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 19:58:27 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:32923 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754451AbdGKX60 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 19:58:26 -0400
Received: by mail-pf0-f170.google.com with SMTP id e7so3679721pfk.0
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 16:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sfQDy2p4JpqZPErHXeCaW7hPMMlL+50nupcB2t9eNsU=;
        b=t9QPJlcMnCCOsZkT3RdZX59GflIIS77QdJ7PYh93Xub62Im01Go3ynYv+7aIWHm4ec
         wejhZPLjBpTi+BzuJUJAA3MqHAel1iuPxAURj//bA27tE0JVOTrDuReTQxIzhxnFlz1/
         +fMhkVSsESAAxz4a70K+WFYFRNktb8UVob7+9SbH7xZ8D/NrN98z2c7xeivXPq7rZJ3a
         ZFHvXC/RtFIY/HLiUPM251z8n5FHODWzeNQwhwF1Ey/A3LZjriyGFFj4L5bo5cdu6nSN
         HKCj2UkKvtDA3CMQz7aOriqIwDCoxGXioFmdSBtcdanoYi9tNKLnEfECuSpVGzu4xOwV
         ucYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sfQDy2p4JpqZPErHXeCaW7hPMMlL+50nupcB2t9eNsU=;
        b=Qmmd4kd3AbCUXi1LJtO1s/6/PhLWWiuXfbAsadNi8ZNorFt67CrybT7hLDEBFj9vog
         lpILZQFz3lgF5i1tiBdPqqn5O8L3G7D8CYJHDXwisDvENXdR/iihgVq5rZg9Wnv6AhJ6
         zTl1KsLHg10QaNYIvPztStR17kMjHC73F3NboUa9k/FD1btEx4W9nLr7+KhnPplQIOW8
         CenRY/e2714iOCAR9/EY6xr80tLM+nyDD5SOeNEzV+GTvGc+c/SZ5Q9VZb07nyqBrQOD
         VsfmGbBZqIKpkSJcfDZJMlhKrXEwzYoQD7jIBOnAJN6cleb3vj68dVB0c8z9h1iPUFd3
         fyEA==
X-Gm-Message-State: AIVw110TgVIUrMIw2NHbyYLZrdhkmbmi6DHow/81aKvERxm8a5znxG9g
        z1axoBlNN8AUTDadmAoeD/8kmv2vpJor
X-Received: by 10.98.19.136 with SMTP id 8mr52691280pft.105.1499817505839;
 Tue, 11 Jul 2017 16:58:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Tue, 11 Jul 2017 16:58:25 -0700 (PDT)
In-Reply-To: <20170711220408.173269-2-bmwill@google.com>
References: <20170711220408.173269-1-bmwill@google.com> <20170711220408.173269-2-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 11 Jul 2017 16:58:25 -0700
Message-ID: <CAGZ79kbsjBMW0TBha=+uyZ4JN-vFaXVa1DeFkJ21w2Zrqfhi4g@mail.gmail.com>
Subject: Re: [PATCH 1/3] repo_read_index: don't discard the index
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 11, 2017 at 3:04 PM, Brandon Williams <bmwill@google.com> wrote:
> Have 'repo_read_index()' behave more like the other read_index family of
> functions and don't discard the index if it has already been populated.

instead rely on the quick return of read_index_from which has

    /* istate->initialized covers both .git/index and .git/sharedindex.xxx */
    if (istate->initialized)
        return istate->cache_nr;

such that we do not have memory leaks or other issues. Currently
we do not have a lot of callers, such that we can change the contract
of the 'repo_read_index' function easily. However going through all
the callers and then looking at the implementation, may hint at a
desire to have repo_read_index documented in repository.h
(There is a hint in struct repository, that its field index can be initialized
using repo_read_index, but what does repo_read_index actually do?)
