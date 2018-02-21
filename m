Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9A6F1F404
	for <e@80x24.org>; Wed, 21 Feb 2018 23:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750842AbeBUXvr (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 18:51:47 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33610 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbeBUXvq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 18:51:46 -0500
Received: by mail-pl0-f66.google.com with SMTP id x18so1868601pln.0
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 15:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+dEcMjgQm3ybkLK5Yq91WMDHNQaPCZCQJD5s5QWMvtg=;
        b=db1pYOXQhbcZfchSp5SO5PIHZYIvFSy0pGsSzXLdK2x5JrMeyd7qPRGh+7pbWf3POU
         ibLeULw4qpJZFLnS5Mknfcqfqr0fYvCfJxwB6i5/RLVu5YQ41896Oir18thssWzW+ggl
         5z+/b4SBtdDeO66MzSVLD2BM/2NSrokxV3X+MLPmyPAURcD5UB1qeKY3zPEQYJXTF9Yv
         AFJwulVTnpSUxZfgiuu5hxuileqdIceeMJkMu1AOfgotHQ7IOkkp0XSIP4AM8GeD8rty
         eGNdIRBWcL2HQ47GDy4+M2QoyVoEL4CKQzK22ECr7Grenn1S2eyKsOT0hKlNNNfSEcpn
         bF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+dEcMjgQm3ybkLK5Yq91WMDHNQaPCZCQJD5s5QWMvtg=;
        b=l18yiCk+mPNca/CR7dOAkjxzWOuLb+AwH9wJ8ibTl7E0LHpNriLswBzJews2Gri/TT
         1PUrK1ulvvfkjF+Zp339URlh/m+Q0oWlZ2mFSu6paf1E7l53wWZcFEkdjSNIfOb2/xwb
         uegEuBEEzCbM91b4ib/8ZP4y9txfgQVIPJpxLS/FJVlJRsXXPtgkZ1D+ryRERJ27mlJK
         QlKLAwkYnwD25WRqPZx7S/l+yfjPMMWxcmyS00N3i8bJJwhBpbU7pTsjmzh8mMBByljW
         vgM211R3GlP06bCxr93u7TrKr5BUg5XoNmD2v7SxXkacZ9cUrHyzltyibISN6gFlIZgy
         +XPg==
X-Gm-Message-State: APf1xPAp9jY18U6aVWegk6I4mf+btWxXAyl2zzdAFwlm3Te0jcHroNev
        8pyu2tMgSgKY84d1KPEHfqbhOA==
X-Google-Smtp-Source: AH8x225Cj+upH8uZ1Ps237t09KReusOI0WZAPXped6PC1ZuFVRwQthduswcblDB5qOjjG/UD5cNd9g==
X-Received: by 2002:a17:902:d24:: with SMTP id 33-v6mr4570787plu.8.1519257105873;
        Wed, 21 Feb 2018 15:51:45 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id w88sm31712804pfa.50.2018.02.21.15.51.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 15:51:45 -0800 (PST)
Date:   Wed, 21 Feb 2018 15:51:43 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 24/35] connect: refactor git_connect to only get the
 protocol version once
Message-Id: <20180221155143.02c9a1c15e54f13ae99464d4@google.com>
In-Reply-To: <20180207011312.189834-25-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
        <20180207011312.189834-1-bmwill@google.com>
        <20180207011312.189834-25-bmwill@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  6 Feb 2018 17:13:01 -0800
Brandon Williams <bmwill@google.com> wrote:

> Instead of having each builtin transport asking for which protocol
> version the user has configured in 'protocol.version' by calling
> `get_protocol_version_config()` multiple times, factor this logic out
> so there is just a single call at the beginning of `git_connect()`.
> 
> This will be helpful in the next patch where we can have centralized
> logic which determines if we need to request a different protocol
> version than what the user has configured.
> 
> Signed-off-by: Brandon Williams <bmwill@google.com>

Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
