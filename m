Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D5D11F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 11:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfDVLTH (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 07:19:07 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54331 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfDVLTH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 07:19:07 -0400
Received: by mail-wm1-f65.google.com with SMTP id c1so14018933wml.4
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 04:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=AnaxJCPIAPav9dxElULYIjmD/aMrb6Td3Q8JZdv90KI=;
        b=uZv4ie9o7Gp/VyltUlROiA5TssjPqmNxpNvr5kVT+uU/IMoPXMTV72t1gtEZEsYpLT
         +Onnqv6SgbVvNuditF0uJ0WgtclyhPISCDqHU2hA8uePYjWeWqZS7qBzuT/V0h9DMKyB
         dx8s6hyFQs4gZqp5vsj3vtya/W85ZqGQiVYsSasb64XlBEDC5v3SJqzLD/NPCkgmesjl
         Aga6gXT8EQP3KIqYERjb26IDFZ6VxAWNQq4RZdvZ6mrnFs+pCEVZRiadyrIdGplbsjLY
         /BmP1rTCclhzAaWqvTqaikYLp0KaqLfCGSZ3ZopBgMrG2mdQuObvozRi9jxnm138va7e
         m3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=AnaxJCPIAPav9dxElULYIjmD/aMrb6Td3Q8JZdv90KI=;
        b=Q4gV4J6iWnffUYHXCRE94D6snYN4cjYtfYEmFI3NIZ8JLEu4nqxTTH0m1x4RNdyZJQ
         PC+Tq9VYb4QIjjOJEmsguMZWEFO/69viPWbOb7phcVc9r5relW9YtcOXw4ZXGqRDxFzR
         V7xG7W7tSDbYK1wUnYvjv+fUZoFaCk/xJP3HJkt0I9OavSOpk+94mcVv5Xiw6PufCUPB
         OXvYOSQwrm9kJoL5t4KSzR6IAECeEWKdYYcINJgziuFYbYD9QlmeUoKaLcyqkgoAm6y6
         1FJY/9BsM1VsSGkB1tiZMh+A3gmKzqsZPgpOHejXt6NnWNgRI2UXYBUqUr1Hq3KLUUBk
         4ycg==
X-Gm-Message-State: APjAAAW4wuWfBBKmAp3w7azGOtVk56ACWdFub/06rNzpD299C/JtigZR
        /rd3Y8fjHvEe90CCPHUjBPE=
X-Google-Smtp-Source: APXvYqxB+UuUeBNqFdjr5zdUI/PD5hYGPmTISD9hPxRb03dYTgQBfWAvMlom6UCXrmXcNY0qTWNTlQ==
X-Received: by 2002:a7b:c053:: with SMTP id u19mr1927256wmc.63.1555931944900;
        Mon, 22 Apr 2019 04:19:04 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id t17sm9921335wrr.26.2019.04.22.04.19.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Apr 2019 04:19:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] cache.h: fix mismerge of 'dl/no-extern-in-func-decl'
References: <cover.1555487380.git.liu.denton@gmail.com>
        <9d6c51b2118b24cd94f3e2951ff0e9ee82afbd98.1555911520.git.liu.denton@gmail.com>
        <xmqqzhoi7drp.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 22 Apr 2019 20:19:03 +0900
In-Reply-To: <xmqqzhoi7drp.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 22 Apr 2019 15:30:34 +0900")
Message-ID: <xmqqr29u70ew.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Denton Liu <liu.denton@gmail.com> writes:
>
>> After merging 'dl/no-extern-in-func-decl' into 'pu', it seems like the
>> conflict resolution mostly went well except for one spot, which this
>> patch should fix.
>
> I do not think this is a mismerge per-se.

I looked at the merge again, and I agree that it was a simple
mismerge.  THe function was already there in the common ancestor,
and was not changed on the mainline until the "remove extern" topic
was merged, so the result should have been a clean 3-way "the
mainline did not touch and kept extern, the side branch removed the
extern, so the result is to remove it" merge.

It was just the change was dwarfed by nearby noise conflicting the
"remove extern" which pretty much touches the entire file, with
different topics touching different part of the same file.

The merge (and more importantly, the rerere database) has been fixed
up.  Thanks for helping.

