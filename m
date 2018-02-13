Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6BCF1F404
	for <e@80x24.org>; Tue, 13 Feb 2018 22:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965988AbeBMWtc (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 17:49:32 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:42804 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965942AbeBMWtb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 17:49:31 -0500
Received: by mail-pg0-f52.google.com with SMTP id y8so943883pgr.9
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 14:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RpmGAbDR70iWp4cF2j7DUEl/+I1/ZrveohNEJim8jbI=;
        b=YtjSVhZG8n2j5JDdX2r9d67ZngCjuRBBLhSxulC7pNfPX2dF8mr1hI2i7Te3LafEjy
         DjDfxP3Q1ENssjxk1mfvIbAGVGmNqLiiXol2qrqB+8sdg5dnx0dWC67HZ1gU1OE98h5Z
         ugksuI9IVNng1XpQOjMwkg55lIrOz9Aee6Mq1XYwfVQ5I08sP1Zm9+9vswGTrJtNWSgG
         yUBBrsXP/k2idBTNL3/7+OvaZyKdfFZEIl1+HpPrPrrViNwaE+OXoQ9tnT3L4oCSqY3y
         w70ZY/RddEGvaR/zdKrsMA9KZohI+npHl3yKxAvFfTMNskmbyGrBeOfgAgX3UJCNGo/5
         sW7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RpmGAbDR70iWp4cF2j7DUEl/+I1/ZrveohNEJim8jbI=;
        b=gWV2V9QLoq6X1/KTsBmKVKvnlD8GiqcH8++gk7rlWhQdFoKqUoqdJ2lB2fBfVILvwC
         qoM0yOb7kkr2WZ2gdKyvhebXGWimQ7aw+sfzMs54WEV6z3pNm+ZVBZgFRIU85dMNmPJL
         x4P9FCCTkE0jjCGst5MSod2Aln1NttThYpOjKgsyMwpassfyhX9TDM4kpq8nDJeChnrh
         +jOtLlmD6xuNFbiTfvM8C1wDhjBN/DHJz/gxTmTpt1B8d2D0PzIKejrFTstSHJsECeuD
         PRH1CSjme/ZxuptpU0o8esPAJQvrcngZ60ARmT0YuCDeWdW+admHsZl2xhV/urKhauIS
         JImw==
X-Gm-Message-State: APf1xPB0Wq0LBPuCl0CZb5dziIq6uHYqKK6y428RVf8pSt+uPJUXygHF
        PM9+yyRQdyjtEiIAicNOythvrQ==
X-Google-Smtp-Source: AH8x225/aLUjXMb4bLJ63J4ZvhN9xSTnMJgIXW6UlCOem/WZYEOO0bSez7KmrNk533LwBF7OFO44OQ==
X-Received: by 10.99.67.133 with SMTP id q127mr2182802pga.365.1518562170992;
        Tue, 13 Feb 2018 14:49:30 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id y63sm10832273pff.90.2018.02.13.14.49.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Feb 2018 14:49:30 -0800 (PST)
Date:   Tue, 13 Feb 2018 14:49:29 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        gitster@pobox.com, peff@peff.net, sbeller@google.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v3 08/14] commit-graph: implement 'git-commit-graph
 clear'
Message-Id: <20180213144929.174b7e3304ab592d2f8c0aea@google.com>
In-Reply-To: <1518122258-157281-9-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
        <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
        <1518122258-157281-9-git-send-email-dstolee@microsoft.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu,  8 Feb 2018 15:37:32 -0500
Derrick Stolee <stolee@gmail.com> wrote:

> Teach Git to delete the current 'graph_head' file and the commit graph
> it references. This is a good safety valve if somehow the file is
> corrupted and needs to be recalculated. Since the commit graph is a
> summary of contents already in the ODB, it can be regenerated.

Spelling of graph-head (hyphen, not underscore).

I'm not sure of the usefulness of this feature - if the graph is indeed
corrupt, the user can just be instructed to delete graph-head (not even
the commit graph it references, since when we create a new graph-head,
--delete-expired will take care of deleting the old one).

>  extern char *get_graph_head_filename(const char *pack_dir);
> +extern struct object_id *get_graph_head_hash(const char *pack_dir,
> +					     struct object_id *hash);
>  extern char* get_commit_graph_filename_hash(const char *pack_dir,
>  					    struct object_id *hash);

This file is starting to need documentation - in particular, the
difference between get_graph_head_hash() and
get_commit_graph_filename_hash() is not clear.
