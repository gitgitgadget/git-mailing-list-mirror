Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA95D2022D
	for <e@80x24.org>; Thu, 23 Feb 2017 23:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751297AbdBWXQe (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 18:16:34 -0500
Received: from mail-it0-f51.google.com ([209.85.214.51]:33734 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751265AbdBWXQc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 18:16:32 -0500
Received: by mail-it0-f51.google.com with SMTP id d9so7496870itc.0
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 15:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=M+yirZVeLK+7rHdzInuihXLlmMJO2garqywTC91ertg=;
        b=k7hCWqU50IB3MPlY8oy/7VMC6Gcnplj6nCj5K+qlAj+IcSBnmpV/wDiIvaG/WGl070
         yIZe1BDP28tDjuYdNcU3Dt+VcykLKFBHuchjmNsPpFWvu91SPE1lR++7aTCnRAmC5TS4
         iJBHOVlRWZYztPqasUW0gzyjMZtOS32ZdcwhXh0UfGJh4D94GKQ3Ai1CmKFwQSuSGW2h
         zmW7DBeKiYE+fK3Ps6mvdMAI2GuZUpZD1L+/S5qfutt44KRtFlsSTEBtvzABNw6PpxxA
         syql8KrK+x/S9ds9NWs4vAAF9+Ek4pGRITr1u+3moZt6Yn5bQvRgVNcxfNSYDxc4e7f+
         UxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=M+yirZVeLK+7rHdzInuihXLlmMJO2garqywTC91ertg=;
        b=HpjL6Um4K/1ZbsvR46wHSfoykYAl/j8aqYIk3Vj1NN0qDK1QAkqJPT2jYTn7DM1gMb
         8GX4QrTLZQj7j4O+BNLnFtyA+bBof77CZQiLvHnRHKmzElFHmgnxgOF1BsanNeaVSa8v
         hvCLflCoDJgMBsq4rF2ZqM2i/zqDL/yAPgykB49IrV2nrt/ULqbuWhds7WXXMlLw4eRF
         CsaxaCd/HxL97XkDkbJbnLsMKRUR45Qz5M71lNgc0oXc11+uBipIKOjLVkQTSHEybdSL
         zF5Ao+Ozm+TE8pGT7UCJPjfvmO+MOTq+BlL/3oLnnTjEqZa8ueWZhSaWKHnpYypphLmy
         UanQ==
X-Gm-Message-State: AMke39lo72GyA0tVEw8qxjOekpuYpmiD8Qos9rC8wHfbvRp2tvsuWi1k0l+CK+g2qve2ZL98pmmAwQ7Wd8+aqBVs
X-Received: by 10.36.169.12 with SMTP id r12mr72175ite.69.1487891712356; Thu,
 23 Feb 2017 15:15:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Thu, 23 Feb 2017 15:15:11 -0800 (PST)
In-Reply-To: <20170223230536.tdmtsn46e4lnrimx@sigill.intra.peff.net>
References: <20170223230507.kuxjqtg3ghcfskc6@sigill.intra.peff.net> <20170223230536.tdmtsn46e4lnrimx@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 23 Feb 2017 15:15:11 -0800
Message-ID: <CAGZ79kZHPdBTKEqJeAa5xDcsC5v9x4DdUuDOiRNSgOV5aCx9Kw@mail.gmail.com>
Subject: Re: [PATCH 1/3] add collision-detecting sha1 implementation
To:     Jeff King <peff@peff.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Joey Hess <id@joeyh.name>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 3:05 PM, Jeff King <peff@peff.net> wrote:

> +* Copyright 2017 Marc Stevens <marc@marc-stevens.nl>, Dan Shumow (danshu@microsoft.com)
> +* Distributed under the MIT Software License.
> +* See accompanying file LICENSE.txt or copy at

The accompanying LICENSE file did not make it into this patch,
that is more specialized/verbose than the one at
https://opensource.org/licenses/MIT
w.r.t. copyright notice requirement.

Apart from that MIT seems to be compatible with GPL
according to the FSF, though IANAL.
