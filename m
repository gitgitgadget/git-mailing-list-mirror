Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6751F1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 23:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732565AbeHOCDz (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 22:03:55 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:44708 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732523AbeHOCDz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 22:03:55 -0400
Received: by mail-ua1-f73.google.com with SMTP id d22-v6so11214311uaq.11
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 16:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rRRuKsFaHC9gAVhLkp8Xqvhu89bwSi7CgsJaVQbk7Go=;
        b=ojSmJCkG1dHAwRNEEiQXl4uv/HkO7hcqKomlBMEklg/4ILkrUpYLcr2PbBZ363Q/MH
         y4RoOSDzed/UVTwwPnKvi0eAbJkpU3h90CS3KfEOp7P1Zp6zaV0OXS0i37EIyA2wU/WF
         RSG+mDfL9KYriBr4yYXWSsvPIMJ6F85KVlk3iRZKlBrheK2v8FAyVa8wHBq+p3woZpHa
         CwFtVScQOOj0Ww9nx/tc+Y61eP+2eVMwgoIzwXup0YmpxgLcFG28rle/gy1AUSBeQG3H
         VyFcQSH0tCsiaLSGEH/bH5hjrbnGAC4rhn28KgMp67S3CbgA2YrJP8X+ZOY4afiliFL3
         Q7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rRRuKsFaHC9gAVhLkp8Xqvhu89bwSi7CgsJaVQbk7Go=;
        b=p9pV9CQoopPWz8P3Yd3IutzRLUd7fqrvjJtCU0SB5+dfJo6niSAOLy7g84TiIGwEQQ
         NMKobyk/nYUpY5O53lwKRiXXbdY54VbHISFlIx80t2G0F1qj7xW9QdgyzKx6j7u/s+Wh
         hnBm81Owv3k4n63lmMc3wvooFjUgDTp3UKmuM0hR3jP8jPh7TC+tP3ha8iAWxRHDPXdS
         dG2Bk1fbueEpAr08gBkluSd0GBpP3gizu09RttKOjldV6p9pGPIv1FqDjLgsUhXbf4nV
         6HKqmEGcuMNMO/hPXm/QVTgHlcnC8uwPZODCW+wmlSZIbfFaB0f8HZQYxgDYYnJCEg85
         qEAw==
X-Gm-Message-State: AOUpUlFdL0OyXk8wuZjkq5yzMi+X1T3OHASvrJ0HX/pLBZCRzozXPhC1
        u7850mJ/YkmeQujNjqocG5wuxw56EIYW2KLSVrPg
X-Google-Smtp-Source: AA+uWPx2RuobryVx/V8lzWkzUx1oZknvQT61XkJ+FHVTvFEUVqkrMovYOaP2P9ljVYl07Y3L0qfuVmjLv10Mlm5MoaVh
X-Received: by 2002:ab0:55c8:: with SMTP id w8-v6mr11167910uaa.96.1534288468800;
 Tue, 14 Aug 2018 16:14:28 -0700 (PDT)
Date:   Tue, 14 Aug 2018 16:14:25 -0700
In-Reply-To: <20180814225633.90251-1-jonathantanmy@google.com>
Message-Id: <20180814231425.94903-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20180814225633.90251-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: Re: [PATCH v4 4/6] rev-list: handle missing tree objects properly
From:   Jonathan Tan <jonathantanmy@google.com>
To:     jonathantanmy@google.com
Cc:     matvore@google.com, git@vger.kernel.org, git@jeffhostetler.com,
        jeffhost@microsoft.com, peff@peff.net, stefanbeller@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > So we don't want to die in list-objects.c. If we
> > fail to fetch, then we will die on line 213 in rev-list.c.
> 
> Why don't we want to die in list-objects.c? When --missing=error is
> passed, fetch_if_missing retains its default value of 1, so
> parse_tree_gently() will attempt to fetch it - and if it fails, I think
> it's appropriate to die in list-objects.c (and this should be the
> current behavior). On other values, e.g. --missing=allow-any, there is
> no autofetch (since fetch_if_missing is 0), so it is correct not to die
> in list-objects.c.

After some in-office discussion, I should have checked line 213 in
builtin/rev-list.c more thorougly. Indeed it is OK not to die in
list-objects.c here, since builtin/rev-list.c already knows how to
handle missing objects in the --missing=error circumstance.
