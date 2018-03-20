Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58A1C1F404
	for <e@80x24.org>; Tue, 20 Mar 2018 22:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751396AbeCTWZJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 18:25:09 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:38594 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbeCTWZI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 18:25:08 -0400
Received: by mail-pg0-f54.google.com with SMTP id a15so1206886pgn.5
        for <git@vger.kernel.org>; Tue, 20 Mar 2018 15:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NhcHGU9yH1QWy1Ujo3Prsco7NqjPavlMl1fvVist9EM=;
        b=wGmm/HfNuKbNlzQMPGqBwOr0gtBTlmuSl3pMq/xHwbnG+fRWgLyDnwz0C+9NkzvQoD
         5B3pHL065zNricr2hHchqTfQBzLqAA+BKhhY2h4VShJMcH7/AVWujQd0hGiA42mUOiG/
         Z2CkorQ22EAZZXfkvnCsTgpuMiLVdwjHchFA/qBaaQffIgCLLYZZh0m74/X/fzj77Pww
         cd9wndzIlSVKoVO9Pb15VHIQO3BqnbhSBdU50jx+0Q5ZoPwjPPnGnEb6ZJBh1xcHHzeJ
         mggvZOGg3tbsAGP6j5M+i/vrdaLlURucANTWfITL5od0iriAXbtfxfdSqV0n9EkMFFAJ
         whog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NhcHGU9yH1QWy1Ujo3Prsco7NqjPavlMl1fvVist9EM=;
        b=CpMMVp/KHAz2lqH4T8b+GN2sLVFtdwYcn9bOHta475ZP023I9aq2eaSALHHNbNtxD5
         LCBR3tbRpWiyoVD+A8OHJGpVelfmSsicNjWwsfLvjm4YIQNlcpFA3FI0RT4NTV8270f3
         HjC7kGp5JRITrrQt09104StALkbfNinoijUOx+ortrJwxYclTm0QsCnjDWA6Ci25Q2+3
         VBrZ/c1GnYclrOZIjepktZ0ClXsSwzynrIfIgeKdYDAaSDQyJMuWo7vx0LDLGAoRafEP
         rJGMuVjU4MNJRiFLxcLe5eCn8hb3nMonirGrx4Q0JV3bGwQT0+YgOtOU6JFYFbG2qMNF
         7AKQ==
X-Gm-Message-State: AElRT7FIFvDorE4ee6MhIdZAe/1QAGWq0rp5Me2h6F9r1ZH4Pg7cUk+v
        wShyeRx3wT6pJrJrA0WcXcNJEw==
X-Google-Smtp-Source: AG47ELuO39Fd5VHK+lSmsyPzy8NtzzT6SVOCUbQaVfnZe1Nj41iumnb080WCKJ9cqVukyfb7dnC5TQ==
X-Received: by 10.99.36.193 with SMTP id k184mr13182394pgk.80.1521584707476;
        Tue, 20 Mar 2018 15:25:07 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id q13sm4567377pgr.52.2018.03.20.15.25.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Mar 2018 15:25:06 -0700 (PDT)
Date:   Tue, 20 Mar 2018 15:25:05 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, stolee@gmail.com
Subject: Re: [PATCH] sha1_name: use bsearch_hash() for abbreviations
Message-Id: <20180320152505.bd66f0deaecf6d92fa6d62de@google.com>
In-Reply-To: <20180320200325.168147-1-dstolee@microsoft.com>
References: <20180320200325.168147-1-dstolee@microsoft.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 20 Mar 2018 16:03:25 -0400
Derrick Stolee <dstolee@microsoft.com> wrote:

> This patch updates the abbreviation code to use bsearch_hash() as defined
> in [1]. It gets a nice speedup since the old implementation did not use
> the fanout table at all.

You can refer to the patch as:

  b4e00f7306a1 ("packfile: refactor hash search with fanout table",
  2018-02-15)

Also, might be worth noting that this patch builds on
jt/binsearch-with-fanout.

> One caveat about the patch: there is a place where I cast a sha1 hash
> into a struct object_id pointer. This is because the abbreviation code
> still uses 'const unsigned char *' instead of structs. I wanted to avoid
> a hashcpy() in these calls, but perhaps that is not too heavy a cost.

I recall a discussion that there were alignment issues with doing this,
but I might have be remembering wrongly - in my limited knowledge of C
alignment, both "unsigned char *" and "struct object_id *" have the same
constraints, but I'm not sure.

> +	const unsigned char *index_fanout = p->index_data;
[snip]
> +	return bsearch_hash(oid->hash, (const uint32_t*)index_fanout,
> +			    index_lookup, index_lookup_width, result);

This cast to "const uint32_t *" is safe, because p->index_data points to
a mmap-ed region (which has very good alignment, as far as I know). I
wonder if we should document alignment guarantees on p->index_data, and
if yes, what guarantees to declare.
