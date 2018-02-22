Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 804081F404
	for <e@80x24.org>; Thu, 22 Feb 2018 19:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750967AbeBVTZh (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 14:25:37 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39934 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750776AbeBVTZg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 14:25:36 -0500
Received: by mail-pf0-f194.google.com with SMTP id c143so2480265pfb.6
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 11:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WINEbht5e6fZsdm3eqbQB2xaRvLq4gWhWuTEiHrVpTk=;
        b=ayClUaaGGhWvuh3/H1rx10zsEYAzSYE0ORK73yg4i5Qwdk7wTwmp7zTZjryj/Nv7P8
         a+FX1XrJN58fxHY1E26Hlpcl41yN84N0q5dUgu5huFTrAnGsoTn5TFPCqcDn3/ToEzgF
         E/GvlTjZesKS1y6cRKWnRouuV6d/CUtXiv37Glc9vGVTZnhst33uhLkCP25oNapa65uW
         IY2tWNW4+fOUtPbAX7EQvLrv4GeR8TvEmE28jZYkFEFXF1sr3yeNfEPmA7xw12q0N0Kz
         Ni2OI71SC6bDxZdtjXzpCSv8OWV0yS3z5Y1qvd7HRXAPfieitbSfCzMwj0YHZcGWjjW3
         veZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WINEbht5e6fZsdm3eqbQB2xaRvLq4gWhWuTEiHrVpTk=;
        b=Qi9Jnzbq9XAjgzbA7eHZYO4k5FlSSnsRv2E7W+DpbgS0MQTXYpzmsmXISrwi/Bny38
         TG3MBnQJM8BS2Euq7ba2j9Sr0gSyoP8HrlqNmBEUTUeNMkxDrtfj28jI8kseA6aJqTKc
         95Z/Z1r4OLcbFZUpl7ZeWJDgDhvYE/HPEpXc1o546pXXVbDCRP7BKhfawgaaZOW/RkiX
         R/cBFPLtQIRf46BVAr0BkjmU8bKgKEVIe2fL5iC1SqEpFDiOqYq2ayEKiUT64h8/pqp2
         z8BUl4CeRvEEqfo7YFjcqCMok8zqBdijVOsUBvwuZsqgriyuhvIrs+NF2Tx6EpXAXZw2
         l0Fw==
X-Gm-Message-State: APf1xPD0l10Y1R4bEsFrUuIJJMfh5D+4QdofHWKv9BV6C6t9nm8gko2S
        jitVb7ayfrBPp+Jj3UQ4m5B/XryAMZ4=
X-Google-Smtp-Source: AH8x226reXp2UBxyeSqlmTsJt4fD9PJikmYYy1UIendgtBPyIxMaOwz5P5wjHt0rPlMugp6pTBuVDg==
X-Received: by 10.99.96.73 with SMTP id u70mr6285706pgb.199.1519327535504;
        Thu, 22 Feb 2018 11:25:35 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id 83sm1212215pfj.151.2018.02.22.11.25.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Feb 2018 11:25:34 -0800 (PST)
Date:   Thu, 22 Feb 2018 11:25:33 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, gitster@pobox.com, jrnieder@gmail.com,
        stolee@gmail.com, git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 14/35] connect: request remote refs using v2
Message-Id: <20180222112533.0d7c6023fb8e4098efedfe31@google.com>
In-Reply-To: <20180222182657.GE19035@sigill.intra.peff.net>
References: <20180125235838.138135-1-bmwill@google.com>
        <20180207011312.189834-1-bmwill@google.com>
        <20180207011312.189834-15-bmwill@google.com>
        <20180221145411.35b2ea84747518a499276bdd@google.com>
        <20180222181922.GD185096@google.com>
        <20180222182657.GE19035@sigill.intra.peff.net>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 22 Feb 2018 13:26:58 -0500
Jeff King <peff@peff.net> wrote:

> On Thu, Feb 22, 2018 at 10:19:22AM -0800, Brandon Williams wrote:
> 
> > On 02/21, Jonathan Tan wrote:
> > > On Tue,  6 Feb 2018 17:12:51 -0800
> > > Brandon Williams <bmwill@google.com> wrote:
> > > 
> > > > +extern struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
> > > > +				    struct ref **list, int for_push,
> > > > +				    const struct argv_array *ref_patterns);
> > > 
> > > I haven't looked at the rest of this patch in detail, but the type of
> > > ref_patterns is probably better as struct string_list, since this is not
> > > a true argument array (e.g. with flags starting with --). Same comment
> > > for the next few patches that deal with ref patterns.
> > 
> > Its just a list of strings which don't require having a util pointer
> > hanging around so actually using an argv_array would be more memory
> > efficient than a string_list.  But either way I don't think it matters
> > much.
> 
> I agree that it shouldn't matter much here. But if the name argv_array
> is standing in the way of using it, I think we should consider giving it
> a more general name. I picked that not to evoke "this must be arguments"
> but "this is terminated by a single NULL".
> 
> In general I think it should be the preferred structure for string
> lists, just because it actually converts for free to the "other" common
> format (whereas you can never pass string_list.items to a function that
> doesn't know about string lists).

This sounds reasonable - I withdraw my comment about using struct
string_list.
