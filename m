Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1ECC34056
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 18:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D5424656
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 18:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="quNvZ8iR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgBSSKs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 13:10:48 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:52392 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgBSSKs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 13:10:48 -0500
Received: by mail-pj1-f74.google.com with SMTP id u10so635367pjy.2
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 10:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KrCchBkPu1HP/+eCecIbuDIyWiZLq2AC273+Kma71Tk=;
        b=quNvZ8iRS6iX+H0xRzNdfHMhRCGgSwx2XIQ/mgr5VFYF7ZoFMF+A8CPeKsMYE6DX7g
         dGcy7yYK8kSxpXbgxXBoJrmnTWDwC22zBlG+Qo30yxEFsBVbbfwvqImRelV4Fju+cftM
         QFsMrO6vzHFwdYbMn41AX0kzEcJ94oqJx/AU31woap4T1VB4r8nBI2lRNP3w2gmbSREy
         7ByBIWJaxBgt+ug1Q0EZC0TixhNS75eu5nlFG5NBU58K0bdKBXTXyaTsZfg2BcQLZ2GN
         F+9m8lwaGW4LTt7VqEfOLb+zoG8WCRVeS+hXd94yZLbrIoajC2IE/1bUYV6Cci2NkcjL
         +bIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KrCchBkPu1HP/+eCecIbuDIyWiZLq2AC273+Kma71Tk=;
        b=FUydpLoRmvdwvz/ROH8a6mDspxRdd1OKnWbgjPOe1Uhd+dPq/l8YN+44hnnljEWTL2
         UvtcHbttUKrL5A0LV0+rfG5RzWeLfCDIRdiSZbYVDmE+eWU2KFrXQ7p4n5WhcwqStZ0N
         tsxrusoe37okV/EV2zFJsFTsnye/XBon44aDp9oEl+ep3F20YBRm6pA4AdC1NAVtN0bh
         1jrvLjticKluVVePFrqeLUEBcVaCCq6OPdlGkt4DA0rSE/PkV9slxdqCTlEcv6gvKqkq
         G2awZ1hBR9aIzl40HEVOvukEMAkQVGIgQaFfsYt5RWyAJUUMtA4k1wkRBxdnptBVde3Q
         mEIQ==
X-Gm-Message-State: APjAAAXPBRyz2XNaZ+tkCNNLEKUuOtJuTK8h4knOmAQnpRfOSLTDRKY3
        IxXH38B5huckWQjrPI7fjF/vk9lKMUYQBYk3qFj9
X-Google-Smtp-Source: APXvYqy2ES1oNMgKy1zDr+zZOgtekJ2naaY/VL7PGu4Dh0bzl3lKYSvr9Iiq8Eq1vtmnrHT+vglcd8zJ0Y52bMg5kmvR
X-Received: by 2002:a63:26c4:: with SMTP id m187mr29367504pgm.410.1582135846121;
 Wed, 19 Feb 2020 10:10:46 -0800 (PST)
Date:   Wed, 19 Feb 2020 10:10:42 -0800
In-Reply-To: <937a882261d4d4552a144e5f0efad8abd8002ab4.1582129312.git.gitgitgadget@gmail.com>
Message-Id: <20200219181042.2192-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <937a882261d4d4552a144e5f0efad8abd8002ab4.1582129312.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: Re: [PATCH 2/2] partial-clone: avoid fetching when looking for objects
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        jonathantanmy@google.com, jrnieder@gmail.com, dstolee@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> When using partial-clone, do_oid_object_info_extended() can trigger a
> fetch for missing objects. This can be extremely expensive when asking
> for a tag or commit, as we are completely removed from the context of
> the missing object and thus supply no "haves" in the request.
> 
> 6462d5eb9a (fetch: remove fetch_if_missing=0, 2019-11-05) removed a
> global variable that prevented these fetches in favor of a bitflag.
> However, some object existence checks were not updated to use this flag.
> 
> Update find_non_local_tags() to use OBJECT_INFO_SKIP_FETCH_OBJECT in
> addition to OBJECT_INFO_QUICK. The _QUICK option only prevents
> repreparing the pack-file structures. We need to be extremely careful
> about supplying _SKIP_FETCH_OBJECT when we expect an object to not exist
> due to updated refs.
> 
> This resolves a broken test in t5616-partial-clone.sh.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

Thanks for catching this.

I wonder if the commit message in this patch could be better worded -
the first paragraph seems to say that fetching missing commits and tags
are expensive, but that is not the problem here; the problem is that the
client lazily fetches refs advertised by the server, thinking that it is
lacking them due to partial clone, even when there is no expectation
that the client have them (so the commits and tags are not truly
missing).

So I would reword the first paragraph as:

  When using partial clone, find_non_local_tags() in builtin/fetch.c
  checks each remote tag to see if its object also exists locally. There
  is no expectation that the object exist locally, but this function
  nevertheless triggers a lazy fetch if the object does not exist. This
  can be extremely expensive when asking for a commit, as we are
  completely removed from the context of the non-existent object and
  thus supply no "haves" in the request.

All this rests on my thinking that "missing" has the connotation (or
actual meaning) that we expect the object to be there. If we think that
"missing" can also mean that the remote has it but the local doesn't,
then you can ignore what I just said :-)

Other than that, both patches look good to me.
