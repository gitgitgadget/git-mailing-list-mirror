Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16290207D2
	for <e@80x24.org>; Fri, 23 Jun 2017 21:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754727AbdFWVUe (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 17:20:34 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34483 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754719AbdFWVUd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 17:20:33 -0400
Received: by mail-pg0-f66.google.com with SMTP id j186so7528374pge.1
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 14:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zEIBqofO30BNnI2ymaNK8UdaxqvLnr414E6UE5Gsgeg=;
        b=aniR7WvP4bmrei017rfSgJj2+YsOXr2QexsZ/6sfCw0IxvBpAICC56vYN5pcammIev
         SXlk9FNQY4tCdG9yWVufdPGW7ToQMN7NC+gvochYfrFQqHDozRYlWTLPqlAhshGotO+s
         sQye7rESlt+ZIXvl25gwzGJVOfCRyMcXomzcgbdkCkT6T7959lzyIfAO/lsIuAD2Sy4K
         ytlEOmgK6RdSWMn7GOiAmC7+cw2ONvlBRMSh3UpqVg6/0NpbEsrYtsUWdoQTVRVVuxwv
         8qdokZTPpC8CKQ0lulNsdp/C0muJ/UmMwiJ7z87HsS+cdu28Hw0sHrzFFZ+FZgMk/xwT
         Algg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zEIBqofO30BNnI2ymaNK8UdaxqvLnr414E6UE5Gsgeg=;
        b=hdxoqUo3gAY+oRQ6zYFb2V9HJn/5ltEKK7oimfm9Wq7NpN+zFvdsPY6rWH65ZveziH
         W9+9a1ZrlZ7yYvFrvMVrp674KdbsWpth3G5iYUw+13XphmgBg6maVV8RsA3Wiqs0DUOf
         botxEbuXUKLYu/zMWosCsMwpuQ5C7UfmcI9MJyIDv7ZTVHjZHfu1hzw0DVvqoP3SEbgm
         Vv0DwGg/4GnE7Jg/lMMfqEs273BnB2XsOWRqiofVYVEcIynmOFUXcP5LGyBTjv5EVZAT
         LHwD6xAIeVFPBT6k7AHaD6LK7D8pUvUgeiKveKzBauYlkGR81duJfNxzp0Ai/5K8626u
         1GYQ==
X-Gm-Message-State: AKS2vOxpLeThQwRHFjOJftezAksdJ2HlKwZmVN9Ww93Le/cQLMlmD9oB
        NSwJPApCx/KiSA==
X-Received: by 10.99.39.194 with SMTP id n185mr10154043pgn.94.1498252817342;
        Fri, 23 Jun 2017 14:20:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4cd0:d6d2:1e09:4052])
        by smtp.gmail.com with ESMTPSA id n71sm11560847pfi.95.2017.06.23.14.20.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Jun 2017 14:20:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        =?utf-8?B?Tmd1eeG7hW4gVGg=?= =?utf-8?B?w6FpIE5n4buNYw==?= Duy 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 19/29] packed-backend: new module for handling packed references
References: <cover.1498200513.git.mhagger@alum.mit.edu>
        <0a7aba93b5f3378df5aa8a3ef342d36cac9d4c6e.1498200513.git.mhagger@alum.mit.edu>
        <20170623193508.xjcyqvf32l7wmwzx@sigill.intra.peff.net>
Date:   Fri, 23 Jun 2017 14:20:14 -0700
In-Reply-To: <20170623193508.xjcyqvf32l7wmwzx@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 23 Jun 2017 15:35:08 -0400")
Message-ID: <xmqqmv8ycsfl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Jun 23, 2017 at 09:01:37AM +0200, Michael Haggerty wrote:
>
>> Now that the interface between `files_ref_store` and
>> `packed_ref_store` is relatively narrow, move the latter into a new
>> module, "refs/packed-backend.h" and "refs/packed-backend.c". It still
>> doesn't quite implement the `ref_store` interface, but it will soon.
>> 
>> This commit moves code around and adjusts its visibility, but doesn't
>> change anything.
>
> Looks good. Stefan will be happy to know that I used --color-moved to
> look at it. ;)

This patch shows OK, but when applied to other changes in the
series, e.g. "packed_ref_store: make class into a subclass of
`ref_store`", it was somewhat irritating that all new blank lines
are shown as a copy-move of a single deleted blank line (also a
single "return refs" in an entirely new function being a copy/move
looked confusing).




