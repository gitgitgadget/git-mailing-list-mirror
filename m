Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA11E1F991
	for <e@80x24.org>; Wed,  9 Aug 2017 18:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752945AbdHISSY (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 14:18:24 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:34067 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752240AbdHISSV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 14:18:21 -0400
Received: by mail-lf0-f48.google.com with SMTP id g25so31544127lfh.1
        for <git@vger.kernel.org>; Wed, 09 Aug 2017 11:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8BYwa905k1UecOF57PtdotpmouJpTtZIkD5+95W3lcM=;
        b=cXelD408NYQV1uGuBF4g1Qei1cR3lKfCCT30cQRy0CLu9G/HUApDuS4jN/g0eDH1pA
         znR7skmpTvLV8R0RjEnu2X/A84HMumssxJsur69lDI45QB13H3WhMPyW+NWiN1IGX0PM
         9hoUivJoCb3ktSbp8lU+h+J7CaAQBvncSzdHWhc7SA0DwL+gv0h2Jnj49d46ZFE/BpbU
         4bgKkrXBXaMRuYKniUwub4ykfwxqknwiWO0jm9K2JzGCgKVan5MIAL/OnxE12TaoOeQ9
         j5KXc74KlOissFUOG80FvH2iWJhy/6cPNoAboQhVdtfDqTG4Up5MtSdZA0ikwxYCRFjg
         D+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8BYwa905k1UecOF57PtdotpmouJpTtZIkD5+95W3lcM=;
        b=kPGBDWhkONiFv8bZjxS1IkfLJHZfXNpoW2LGPk9tpeeU3ZwZGNS9r89WwTYvL03Nd9
         r/BReP+2ZKuzeogETsgtGV4C7QNcUCgVgEioHt7tBuqejskgqcjgxZFtWyH+d2NSX4sT
         RGVw0NYJTIC0OiOT2z+4mHwP2ZyLYiBPR254cPoFDg/5O27csNP79IBADP80N6/Hoy79
         QBfRA9BiW9njrl8pSfNPeYRcAqBIFMIQO7Y57L1J6HZZjPjBpDDUzZ2Tx6ohyHxt7mIp
         PDBhsGdJsRCkyuTCn5Hu6wMLNXv1pejWKP6QoP8dOBTb4JPU00ecj74jBQhLXiqHFBlZ
         YrxQ==
X-Gm-Message-State: AHYfb5gh/WSJc9jwTzoIVUT92Rl9P66RTVX/RZ8Auho972FPKQaPFZ/C
        oyYxys9nos+RnU1SvXeyV1IoB7GRdoIGRvY=
X-Received: by 10.25.161.209 with SMTP id k200mr3251002lfe.132.1502302700073;
 Wed, 09 Aug 2017 11:18:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Wed, 9 Aug 2017 11:18:19 -0700 (PDT)
In-Reply-To: <20170809122439.fscozhyvxcx2oq2n@sigill.intra.peff.net>
References: <20170809122147.g44nwaitzctbadzm@sigill.intra.peff.net> <20170809122439.fscozhyvxcx2oq2n@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 9 Aug 2017 11:18:19 -0700
Message-ID: <CAGZ79kYqq_EhRxckM4iV=99r59Y7_y94j+-65xXLUF4y2vNUUw@mail.gmail.com>
Subject: Re: [PATCH 3/5] interpret-trailers: add an option to show only
 existing trailers
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 9, 2017 at 5:24 AM, Jeff King <peff@peff.net> wrote:
> It can be useful to invoke interpret-trailers for the
> primary purpose of parsing existing trailers. But in that
> case, we don't want to apply existing ifMissing or ifExists
> rules from the config. Let's add a special mode where we
> avoid applying those rules. Coupled with --only-trailers,
> this gives us a reasonable parsing tool.

I have the impression that the name is slightly misleading
because 'only' just reduces the set. it does not enhance it.
(Do we have a configuration that says "remove this trailer
anytime"?)

So maybe this is rather worded as 'exact-trailers' ?
