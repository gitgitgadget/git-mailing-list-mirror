Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2ACDB215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 23:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755381AbeD3XWj (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 19:22:39 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:34227 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753594AbeD3XWi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 19:22:38 -0400
Received: by mail-qt0-f169.google.com with SMTP id m5-v6so12961946qti.1
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 16:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=NRtlqn3Ozxj6E3xZEmAcWvjmhisK5MMl0RxZdLDQ9EA=;
        b=Yx6jlAIMopmnoZiZfm7nKLdTTLPi8l9K11umP/Oh07DiW2zh47MXg+oID5UlGdm9ve
         5nbO8H8C+2Zm6wLnHyKaa6Z//mkcJR83rx+NwFHS8p4lrGtHc2/SsDpKfJb2aWp1l/yL
         zjtsGU+ceUu8vPCJdFmGHIQLSVIi4kdi9hNKKvdXTVN8NxNUfJnlJgn/cIlwIOPbjnL6
         +vO9lJQPUwht7kDbacf11EUat2YIDmIpX0lxW8y6BSu9CyF3RAhTXFB9JXjF2URkvUnW
         6s/kiSzk5LxR9WOtHsE/XO9/74kuX61PHkGA0MnxxGd+2hWfV58zOnpEUzucOsqKp33p
         IyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=NRtlqn3Ozxj6E3xZEmAcWvjmhisK5MMl0RxZdLDQ9EA=;
        b=PjJzfnllR4SZ94mBfh5ZCzcMlivhG+Rz3kvKr8QYHRyK1dP+E7jlB+vIWf5bBx2X1l
         bQmATEI9YungOB2BuvhlFEq8EV0sgmdGfN+6nAjUWLCll7zWAsIBr026nDILJLG7pQYu
         70Iipq+ufviClyfawA/tGYVnSYUOVA2VFJUeBxPAr5bQUy4HI3XfrUMWCiWEqOQb9SQA
         5aF6tFHOR1yCv71KYD6ae1/1PMnxMIft1oN3SA5Yu/EmwjjOBOMHv1l4ZQbM4gD6O+jL
         aP6rT2IsdGtDibTeDFv2DAHtSiK7N4xeEa7LYR6m+7eYuIMUJlTJKG6iEa+7pspMQvnV
         jYZQ==
X-Gm-Message-State: ALQs6tCBQpR7om4uNMnlbbnGO3YKJNmGvwN/w9dmIpee6KmiRcrMh6mm
        A7BrQItrotAxjSkbsCB6OFe55gUYWgZHa9Esoyw=
X-Google-Smtp-Source: AB8JxZqRSuxzy90onspF0cnN/syDeMrzHOeGu/RFgWfxaD+ofbYsZl6bBZHEt4K7p2MIcQqUNoQ1Sr4U5A9ylAYX8kQ=
X-Received: by 2002:ac8:1204:: with SMTP id x4-v6mr12740182qti.35.1525130557672;
 Mon, 30 Apr 2018 16:22:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Mon, 30 Apr 2018 16:22:36 -0700 (PDT)
In-Reply-To: <20180430220734.30133-9-avarab@gmail.com>
References: <20180430220734.30133-1-avarab@gmail.com> <20180430220734.30133-9-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 30 Apr 2018 19:22:36 -0400
X-Google-Sender-Auth: pxJQDFQYyD6XKJr9mIxwkKEG7tk
Message-ID: <CAPig+cSxdLe=dg2MUNBAZ94z4bXZYfrP1w43R_4Fr0XKVe5jdQ@mail.gmail.com>
Subject: Re: [PATCH 8/9] get_short_oid / peel_onion: ^{tree} should mean
 commit, not commitish
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 30, 2018 at 6:07 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> get_short_oid / peel_onion: ^{tree} should mean commit, not commitish

s/tree/commit/

> Continue the untangling of peel disambiguation syntax. Before this
> e8f2^{commit} would show the v2.17.0 tag, but now it'll just show
> ambiguous commits:
>
>     $ git rev-parse e8f2^{commit}
>     error: short SHA1 e8f2 is ambiguous
>     hint: The candidates are:
>     hint:   e8f21caf94 commit 2013-06-24 - bash prompt: print unique deta=
ched HEAD abbreviated object name
>     hint:   e8f26250fa commit 2017-02-03 - Merge pull request #996 from j=
effhostetler/jeffhostetler/register_rename_src
>     hint:   e8f2bc0c06 commit 2015-05-10 - Documentation: note behavior f=
or multiple remote.url entries
>     [...]
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
