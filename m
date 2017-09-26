Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CA6B2047F
	for <e@80x24.org>; Tue, 26 Sep 2017 06:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965375AbdIZG2Z (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 02:28:25 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:46829 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965122AbdIZG2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 02:28:24 -0400
Received: by mail-pf0-f179.google.com with SMTP id r68so5084985pfj.3
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 23:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=j3fNKKfLtU0AhcRxu0mvHjVBulRqHb3gDxD6HnmR0AE=;
        b=MyiWVtgjVRKee1paQ1WKt7GnI+TREOkTOa0KcmHD18gGTrG9r6wJDvRADGWP9BxmGF
         XTM1I/0uwve/Lqjj6xxBxAZfT1+qs8GBaUEcQLtkUcZETkPzLuy21ji1Qa+gl0P2UkW9
         0YVL9l7bjRKUnd4XHvtJAsZHZXv75T0grYeQgFCBmRO+NmvmxHkoZv9qCwZDq94KzZxi
         ZsFDsUknl4c10mm1MpgIB+VMA1DGtjmF0Ez94eovKC9GWl/r3yRv4tjBAUd4t2pr6RWH
         qE13n5TkFykiQPN/2uO0ic4XLQ6oK/hSz9nM1Gt5RdWj9eVbFcZxIlK2a25hcFK+DuQh
         0lwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=j3fNKKfLtU0AhcRxu0mvHjVBulRqHb3gDxD6HnmR0AE=;
        b=qtyEV66GYYNSQY2N48ZA2HxNNYFvTu7wgdlpjydvzNpMcClwMY2zr0Y/9eqGLn/69E
         SpIUdsyK8H15MFqx1zebwYGfSdo7W+RX+FqISfPFEz8b+yAqtGnpAnII0/SB3230gMMj
         GXbamQS1pjGTV1YrV6YWVezR59pYLPOO0jTknsmMuESjqyYeyT+/BgFRRvYsQDFQydB3
         l1Ak3NWXvSdwKhLLsZzXh7kGOGrP4C6NTBtTI/3/dZtH/SlMrS4DFSrZHpBHj1W78val
         ddtn7Cez5q/OlngJj4U9irZbDpJiBzkuHmpUVco/MqtfliwmvibBFozZ8PB8hc2litrK
         Skzw==
X-Gm-Message-State: AHPjjUi0yEAW6pGmYa+fZ9M7WXmbf6gmAPxUE3TqB0QId+lZ73Q9i77x
        vcFrJnZfcBvnMnE7avuKvnA=
X-Google-Smtp-Source: AOwi7QBhuvGCl1MpAF2TVJCPU7+bpucGvkHWYInthACoFRC4uqSiv/LvzZqyhyiYZyTaohsVIBJH8Q==
X-Received: by 10.98.210.67 with SMTP id c64mr9728857pfg.60.1506407303817;
        Mon, 25 Sep 2017 23:28:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8cad:f525:a0b8:9738])
        by smtp.gmail.com with ESMTPSA id n18sm7038080pfg.44.2017.09.25.23.28.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 23:28:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Stefan Beller <sbeller@google.com>, jrnieder@gmail.com,
        git@vger.kernel.org
Subject: Re: [PATCH] t7406: submodule.<name>.update command must not be run from .gitmodules
References: <20170925200448.GY27425@aiede.mtv.corp.google.com>
        <20170925225054.10819-1-sbeller@google.com>
        <0aa754b4-93fb-3f23-be51-4af5227ac847@kdbg.org>
Date:   Tue, 26 Sep 2017 15:28:21 +0900
In-Reply-To: <0aa754b4-93fb-3f23-be51-4af5227ac847@kdbg.org> (Johannes Sixt's
        message of "Tue, 26 Sep 2017 07:37:30 +0200")
Message-ID: <xmqqshfa9doa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

>> +	test_when_finished "git -C super reset --hard HEAD^" &&
>> +
>> +	write_script must_not_run.sh <<-EOF &&
>> +	>$TEST_DIRECTORY/bad
>> +	EOF
>
> I am pretty confident that this does not test what you intend to
> test. Notice that $TEST_DIRECTORY is expanded when the script is
> written. But that path contains a blank, and we have something like
> this in the test script:
>
> 	#!/bin/sh
> 	>/the/build/directory/t/trash directory.t7406/bad

Nicely explained.  Thanks.

