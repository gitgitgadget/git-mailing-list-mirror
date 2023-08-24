Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554F2C3DA6F
	for <git@archiver.kernel.org>; Thu, 24 Aug 2023 22:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243898AbjHXWXe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Aug 2023 18:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241943AbjHXWWv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2023 18:22:51 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047231BF0
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 15:22:49 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58f9cd8a01aso4628567b3.2
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 15:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692915768; x=1693520568;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6I6MZPv6OrUONmnGXc2C4YdaOPjmJU1Xx6qqhkCt4VM=;
        b=XCqXu3aB+CKfesbvzfULO71r+nOyF8nNu/ekzrtsE9+Er+nfwYmf0vgqNrRoDNd2p3
         XKpgKwOFi6F8nNl+R0L+DgvDYQuWFVaCWU0VJiOeXhQM4gKPLm65WHHTu8x1q64zrUZt
         g6aZee8Loj5t8FIfc3lyV1qmDoH9cL3fRgWw6GkrDINE8HDldC05U3hVSDURfZ5L3TFK
         pXy4k2ax4da9uBYpTww5VCKWiOGKXqj50USY3Xp2wvwyq2L4QtdOmQnOb3LKCIcR3JHN
         W5a3CarsFzBDw5FHRO+bPy7I2Kcc7lf8R+lG4vr4WHg1W3W7gLdM2JUbKbPa8jouR2Zx
         xnsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692915768; x=1693520568;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6I6MZPv6OrUONmnGXc2C4YdaOPjmJU1Xx6qqhkCt4VM=;
        b=Ayo6N43VPP/pxSI9QLvF1+t8AnAaRzguigK+DWw29FIm9FGa7lwplyHRXH95Vyb1YN
         xlFc/+VeJuadq2C8l1F9bLTylZbiApIDWAF1pDkJGmi1VF3rIvDnsqVzLKWlTXS3iyYZ
         fVwn1Mu71OGpZDtriHP//HU9SMV/smw26qzB5tS14UaZLl7gPmxUzIi3aNLu9kpElWFT
         IkBDzBd1L934Kd1+1j2GBnk3lXlnev+8YwEmbO7tpYnHcFj+gIwM8dzy5VHqr2UKJJFk
         /a68EKoukrNYD5Lv1awODBkgosGJt3vUYjFdbUBai+KFSLg3teSnc40SrzGl7AbFqjKq
         Vebw==
X-Gm-Message-State: AOJu0YyLj4WtNi0BEO8wpoaBbQ0LgEZwg5uooo94TUReDA6npH9b7Yca
        lamfQGFoc4IK2ZSKmIkRfl2QzKRrP40H9HCldS4+
X-Google-Smtp-Source: AGHT+IGPd6Ulx9A9NlO3jC2hk7FB9v0wHrPviAD9dS+GDoV993595WBBcJkAWq8EFS9ijLRmDmk7mVRdYSXlIWgE7ePY
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:d0eb:2757:7b54:470])
 (user=jonathantanmy job=sendgmr) by 2002:a81:7653:0:b0:586:5d03:67c8 with
 SMTP id j19-20020a817653000000b005865d0367c8mr326630ywk.3.1692915768227; Thu,
 24 Aug 2023 15:22:48 -0700 (PDT)
Date:   Thu, 24 Aug 2023 15:22:46 -0700
In-Reply-To: <cover.1692654233.git.me@ttaylorr.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230824222246.2320443-1-jonathantanmy@google.com>
Subject: Re: [PATCH 00/15] bloom: changed-path Bloom filters v2
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:
> Jonathan Tan (4):
>   gitformat-commit-graph: describe version 2 of BDAT
>   t4216: test changed path filters with high bit paths
>   repo-settings: introduce commitgraph.changedPathsVersion
>   commit-graph: new filter ver. that fixes murmur3
> 
> Taylor Blau (11):
>   t/helper/test-read-graph.c: extract `dump_graph_info()`
>   bloom.h: make `load_bloom_filter_from_graph()` public
>   t/helper/test-read-graph: implement `bloom-filters` mode
>   bloom: annotate filters with hash version
>   bloom: prepare to discard incompatible Bloom filters
>   t/t4216-log-bloom.sh: harden `test_bloom_filters_not_used()`
>   commit-graph.c: unconditionally load Bloom filters
>   commit-graph: drop unnecessary `graph_read_bloom_data_context`
>   object.h: fix mis-aligned flag bits table
>   commit-graph: reuse existing Bloom filters where possible
>   bloom: introduce `deinit_bloom_filters()`

Thanks. I had one small comment (sent as an email reply to one of the
patches), but everything else looks good.
 
