Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C69C9201A7
	for <e@80x24.org>; Wed, 17 May 2017 17:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752318AbdEQR0j (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 13:26:39 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:35768 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751398AbdEQR0i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 13:26:38 -0400
Received: by mail-pg0-f43.google.com with SMTP id q125so10128979pgq.2
        for <git@vger.kernel.org>; Wed, 17 May 2017 10:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mJcsMXRX3643ALvs2ypa++CeDV1GyQkcdHLZZFXApgg=;
        b=ZztBi1qYb5UjA+tgLWHtT0UpB1fY2Y7M8ZVU/k18VXDUaRUar2y6V7ZCvPFW2hI7M7
         KpLta+oUrGfPBUymHDMaGCb9Z25r2L5jWjxV1iVBDuRBDPVGiP9Lg6u1lR+J8tQ+D1Ir
         bUa2Eahw8InN1887kHwJ33v0fF3JXTEBxpg5aZekOpaldPzmrMts9oGnumJiMCAh+dRW
         hWa0fRlpRdyVS9Fe3Z9ZsWwZB0AMCJMJEnCRpr+6Drpq14pczU3zJcy3FHNhRZFQ9gti
         jUK2JZe1QUDKluIAIEYlDVi/tchf/ALlrnUfXaxVvLuZnhKZvX80GFh2kSu9IyKqOyWh
         lLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mJcsMXRX3643ALvs2ypa++CeDV1GyQkcdHLZZFXApgg=;
        b=l0NKVlWMKOgGY/1w0UKUjdVpaHx9njpRRIDoXczWJ6/UYW8htfhIVA3Wy7AwgqglwF
         DyNB0gpSygjqr4z/ztJpBK+oTVpEzUhUUvXY4sG+EmW6NK8u8ivzkAZC6qNJylR0SoxZ
         9ou9dIH4X0xGfYkwCLooK+zddADb70rmzMzUAvICew0HYD5+QCn1CGRrylk45iftpMwb
         UaARoP343tMOVOiezF8RAhDkXrsfY4KyUXQewEoGOLBNKY30CcFaWcSb0c+ZHsMyP57G
         azbXtYhhAu2LO3ADh/NoM9ue9hqXgBLT/nBFL0P70JQo8WV2ZzQXZNgRwx38jV/Cm0P9
         JTRg==
X-Gm-Message-State: AODbwcBISgSwTPKeYVg12DsqdFCt1W66H22aEjmN8jHyzO1TfERe1pUT
        imKHt3uJ5nCZYT3Buj1VF/3h8ZM/WHnS
X-Received: by 10.98.205.65 with SMTP id o62mr4882841pfg.105.1495041997388;
 Wed, 17 May 2017 10:26:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Wed, 17 May 2017 10:26:36 -0700 (PDT)
In-Reply-To: <d6374d948f4424e4e6b4d999460597d226028be0.1495014840.git.mhagger@alum.mit.edu>
References: <cover.1495014840.git.mhagger@alum.mit.edu> <d6374d948f4424e4e6b4d999460597d226028be0.1495014840.git.mhagger@alum.mit.edu>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 17 May 2017 10:26:36 -0700
Message-ID: <CAGZ79kaRZB=VTe+c-M-qnkQJGQcYb0f-V0OMRuj4o6KAUvZrrA@mail.gmail.com>
Subject: Re: [PATCH 11/23] files_transaction_cleanup(): new helper function
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2017 at 5:05 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Extract function from `files_transaction_commit()`. It will soon have
> another caller.

This sounds odd to me. Maybe it is missing words?
of s/function/the functionality to cleanup/

Code makes sense to me.

Stefan
