Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 650B3201A8
	for <e@80x24.org>; Sun, 19 Feb 2017 21:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751470AbdBSVvL (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Feb 2017 16:51:11 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35804 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751307AbdBSVvK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Feb 2017 16:51:10 -0500
Received: by mail-pf0-f193.google.com with SMTP id 68so7839799pfx.2
        for <git@vger.kernel.org>; Sun, 19 Feb 2017 13:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lefvPHD3BovfNsppO8pLjmQW/lIQJOaDsbI66PwkjZQ=;
        b=taHjS36DrjYzGIL9u5R8l9Vm/pGUbvIjfiMQd42wcvA3mgUjA2moBt7DuwVOpA867P
         3IQlDSz+gA3Zo5VNGyfi6lq3CFfVDgKR7nXRGeXkbMK8u32rQ+UEg/13A2vsnI8EHGRo
         9n417Lc5gJxWQ+NIXZawgHHvOyIMMGG+woW21jow7H0hQ3krwwtvNzjeIG397XMbMWyy
         wiLdJfQjVBZ60Oym1SnFNLZEELIQvVlxL0nfMgBQaw+MCzu5WbKX8u2skBGUnt3sjxgS
         VGPqoNf29ehrn1kAJLMOVo+Krm126vWeB7ynHheDmZG/mX6iT3x2GgI3LrsV+/18EeMK
         1zew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lefvPHD3BovfNsppO8pLjmQW/lIQJOaDsbI66PwkjZQ=;
        b=JQADbSIdqN33UrGjed18LCsd/QBuObCwdJOYZqELVeNSUiDlS8XsiecjRiDvw4hHO/
         Q9Mu75YjhEr8AW9OBl+2Cc1awh12HEWaOB/TzBZPScVVSJlEhOcWNWksA14xh4biuONE
         FXTHjDTqi++/7oXfc3i12Jh76M0m3oYDcfYjcu4LrKCiJYrynqW5OwWE/PKAXdmezhyX
         tp9WitRpjuwhE4gYHI4T/ZwPAD5jCgqJIVSTGciko4GtGXk0Trkx0aY/yaFL8JbxAknR
         69QlFVxdohzQkifVL/Cen14eRqXkpjUcfnyM98Ew2Z0WqhHrQDXiIUwt/8NE0xUshK8K
         9tsA==
X-Gm-Message-State: AMke39lJ+Bq151UhzPZRI/7+3SjpYCRV98aK4sKgaUKD5QeOa2MvR2G8UNw+1sqkddCb7g==
X-Received: by 10.98.138.155 with SMTP id o27mr22211654pfk.113.1487541029414;
        Sun, 19 Feb 2017 13:50:29 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:110e:6fae:3b03:324a])
        by smtp.gmail.com with ESMTPSA id w75sm2594025pfi.50.2017.02.19.13.50.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 19 Feb 2017 13:50:28 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <Jeff.Hostetler@microsoft.com>
Cc:     Jeff King <peff@peff.net>, Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 0/5] A series of performance enhancements in the memihash and name-cache area
References: <cover.1487071883.git.johannes.schindelin@gmx.de>
        <20170214220332.753i4tgclm62er4f@sigill.intra.peff.net>
        <16b1259c-4cdc-8f4d-db47-d724386a3d2b@jeffhostetler.com>
        <xmqqo9y0m45e.fsf@gitster.mtv.corp.google.com>
        <20170218062943.j2llxuuylqs2qemy@sigill.intra.peff.net>
        <xmqqk28nmdi4.fsf@gitster.mtv.corp.google.com>
        <MWHPR03MB2958D975B3B3022D6BC9AFBB8A5C0@MWHPR03MB2958.namprd03.prod.outlook.com>
Date:   Sun, 19 Feb 2017 13:50:27 -0800
In-Reply-To: <MWHPR03MB2958D975B3B3022D6BC9AFBB8A5C0@MWHPR03MB2958.namprd03.prod.outlook.com>
        (Jeff Hostetler's message of "Sat, 18 Feb 2017 23:52:20 +0000")
Message-ID: <xmqqwpcllujg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <Jeff.Hostetler@microsoft.com> writes:

>> But the other Jeff sounded like a follow-up was to follow shortly if
>> not imminent so I decided to allocate my time on other topics still
>> only on the list first while waiting to see what happens.
>
> Sorry, I was out of the office for a family emergency on Thursday
> and Friday.  Add to that the long weekend, and I won't get back around
> to this until Tuesday or Wednesday at the earliest.

The open source process makes progress at the pace of its
participants, and it is expected that some topics come fast while
others don't.

Hope things are all OK for you and your family now.

Thanks.

