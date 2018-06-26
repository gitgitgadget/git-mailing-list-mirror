Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 315421F516
	for <e@80x24.org>; Tue, 26 Jun 2018 20:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933741AbeFZUYv (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 16:24:51 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45734 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933552AbeFZUYu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 16:24:50 -0400
Received: by mail-wr0-f193.google.com with SMTP id u7-v6so3215453wrn.12
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 13:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6uJ9eUj6mhyBCXbdm6hgymjqrHyxVvnMgeAd1KzT9Q0=;
        b=ZIKH75rgOsD8y6zDhsqHAvvYJ7MTRDW/PbnCJ02EK9mrD3hhU0KWrmZN1BzGEcfz1Q
         QdoFpInjl7IBMDa/zlv8fNlwegN5pscxq2isnmFkRwo6pWQ39QSwzZE0d938VbQGZbAr
         cMF0mIQ5Ivqw/Lw/7khiGv9zvJdQuMb1ra6nn+ZuM4/Ifalcbk0MfeIucKZq+oo+GVvw
         JzLKvHyVmmS4uFzgm8b8mK9niUDe6RRin7MDfxz6etKYNqGU29gvl5QVPiB6gBU6a+Gc
         obJxl2RUz6ZdraNu32N/NUbgnfmSMhqD4UAJ32l00SrbDtME/OXOKMKHL1mozFVVTQfL
         2DCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6uJ9eUj6mhyBCXbdm6hgymjqrHyxVvnMgeAd1KzT9Q0=;
        b=G4vcI0yRlzU2XnVSXsymi9WcZYjfq/3U5C+c7jGbQSpsfRccegHwA7H/iHVIo6AXN1
         uepnLr1FAH7Bkv+KnCZ4Zofsp8oYnKJX4ktsoX5XAc3WjhQ9XDCp3ZLxkzip9SvU/AF1
         GC6lVCxoRSLmRKfdWBBmSLRKBeDYYmJemWWmbXJ21cHIXyvgwxhjTBlmr0u1CdMW8JZx
         zxEZVeqMrb8tspm6xNWQQBoEIncMk+w5w0K+8Ud+gdbkPLCmz8bS/2DmVLPzcWy4isy9
         caTsKKaIw3oGUnFQQjRNopRFw7dmupEtlTPQeU/BXdSyRh0bruMQ/oHHvVp0NozOY+Lz
         8dGQ==
X-Gm-Message-State: APt69E0rdiiFCjxc1KVxfVjKBXDxSeAztr6QHTLvi4tsrSv+2UbHlYhK
        Ej6O0WDNaE8efIFE5SukyXI=
X-Google-Smtp-Source: AAOMgpdtIQ64+rHYlXGP8fX5lgIJIX5hME01tkyUUJiFJOiXmPZuPZLrrxFpEVXCg1ADhTzOXY5IdA==
X-Received: by 2002:adf:992d:: with SMTP id x42-v6mr2672696wrb.81.1530044688851;
        Tue, 26 Jun 2018 13:24:48 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q17-v6sm3000569wrr.7.2018.06.26.13.24.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 13:24:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Antonio Ospite <ao2@ao2.it>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/6] Restrict the usage of config_from_gitmodules to submodule-config
References: <20180626104710.9859-1-ao2@ao2.it>
        <20180626170529.GF19910@google.com>
Date:   Tue, 26 Jun 2018 13:24:47 -0700
In-Reply-To: <20180626170529.GF19910@google.com> (Brandon Williams's message
        of "Tue, 26 Jun 2018 10:05:29 -0700")
Message-ID: <xmqq36x9jnxs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

>> Changes since v1:
>>   * Remove an extra space before an arrow operator in patch 2
>>   * Fix a typo in the commit message of patch 3: s/fetchobjs/fetchjobs
>>   * Add a note in the commit message of patch 6 about checking the
>>     worktree before loading .gitmodules
>>   * Drop patch 7, it was meant as a cleanup but resulted in parsing the
>>     .gitmodules file twice
>
> Thanks for making these changes, this version looks good to me!

Yup, thanks, both.
