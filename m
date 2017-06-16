Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2186C20401
	for <e@80x24.org>; Fri, 16 Jun 2017 05:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750989AbdFPFme (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 01:42:34 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35982 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbdFPFmd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 01:42:33 -0400
Received: by mail-pf0-f177.google.com with SMTP id x63so17851101pff.3
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 22:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Hu/8zEe6hYYbew2aE5mZNZgdH12JAaILKuaTrGH3ARI=;
        b=IXyql8bpJb5x/rZUiB+kFNyQkPkfD3dnwNVe0XzNATadjP0qGhaWethQirsbHDMWvq
         Bq+sTM9YUsPmRxlVAbjtFjvo5SO+DxPBBgqunm3Y/Nr1Gv7Qhf6CuyMmF1y1IIEd1w25
         qp0x6mt/txxzrqA3P60goak7Xrn8E9UnUdZGjgygPdmjNNsu72cO3JUmohYALtTZwSEy
         pWpgOakRYUdmpWDJ5I8B2BRkffMhIvPR4TftWiNkMyXkQQHFM/df1M1GvfYeWklRtAS+
         LtBDqQ8ks4w3PbkJwZ405DTA3CsaAr5B++DZDbuHLPpbodWKVWCq9g03+cG4wWxj7zrm
         Y+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Hu/8zEe6hYYbew2aE5mZNZgdH12JAaILKuaTrGH3ARI=;
        b=kNAd4AKjFuhXT0B5s3+fMNn+rduhlJvje0YgCN+vp/m24P6LO1f9vMsiojEqvKU0Lz
         H+wk9IUSzjVnNllY9lANGU/bSEZqqg9Vu0yO0yYetil1WvuW2SoQQwwkhRo7v6WAn1uE
         YKMoCAIP0LBr0h78IiISnjeaYQKl/e5nXiUxxS4kOy8KH8WyxsYdXXPyRY+bDpK1NmBj
         PA5bIUSp7O4mSfdyDfXMiUc3IY9v82m/aMkCiNYcJK4mxyN+M8AvykKU0jFB+tOSOoNV
         1Xqz6JWZxBbR3QtxZGIOUdzANNieuPT5Eq/Gsoa+VJuXTXVn63tuo0Yd4F8EnjHcxKZ2
         7JXQ==
X-Gm-Message-State: AKS2vOw8rjCxH7nJQoPq39XQaGQJzhLe2qKgaibbO/wpGjjWohFYnFUE
        IqP0V5GAawaQjKglJoZCCn0fGvUa7vOi
X-Received: by 10.99.186.91 with SMTP id l27mr9267039pgu.87.1497591752695;
 Thu, 15 Jun 2017 22:42:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Thu, 15 Jun 2017 22:42:32 -0700 (PDT)
In-Reply-To: <f9c4c47e52c076c42896d22d89591a93163afda3.1497534157.git.mhagger@alum.mit.edu>
References: <cover.1497534157.git.mhagger@alum.mit.edu> <f9c4c47e52c076c42896d22d89591a93163afda3.1497534157.git.mhagger@alum.mit.edu>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 15 Jun 2017 22:42:32 -0700
Message-ID: <CAGZ79kbeJk5PmJVdLva-VauLPa4MbQdNRWfQmyHtVqVa3JDL+A@mail.gmail.com>
Subject: Re: [PATCH 15/28] packed_peel_ref(): new function, extracted from `files_peel_ref()`
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 15, 2017 at 7:47 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> This will later become a method of `packed_ref_store`.

Also while touching it, maybe rename sha1 to object_hash
(not saying object_id as that would be confusing with the actual
oid struct), maybe?
