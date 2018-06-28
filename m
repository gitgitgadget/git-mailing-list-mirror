Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 931311F597
	for <e@80x24.org>; Thu, 28 Jun 2018 16:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964949AbeF1QMW (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 12:12:22 -0400
Received: from mail-oi0-f73.google.com ([209.85.218.73]:48349 "EHLO
        mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964936AbeF1QMV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 12:12:21 -0400
Received: by mail-oi0-f73.google.com with SMTP id h188-v6so1006575oic.15
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 09:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=CsZkpb0u3CUlwHwtzADtj9u8wl7/4wSwRy2i5h72riQ=;
        b=rcjb/1iGdGzyseYlOXYl70V/UQdlSyHABA1zK+uAPPaqfF7PrMOjI0xGFturn608Le
         Oub2fAbsG2h0hIEMJaAfJpMpYMkvDay7ay4eTUSixi/HBX50BiN1zkp87CinElhptp0k
         OjoS71TXgAHDlwC0qFq2IcgkpY5On0VgvuNYVi/fhufIx8OB6tSE5eIziLSDkqIBWfpa
         K2vxQkhEknhjmKTsbhny01enaW8YSE+uP/8gn3iPBibbHuBl+3eBcYB1Ya+Wr9rGqUVh
         5YBwF8oHVVFY+ESgN6h2WyY9yz5MI7prG6kJ0sSQrrMeSN8RheH8kH4t6Da1HWtzkTkh
         mufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=CsZkpb0u3CUlwHwtzADtj9u8wl7/4wSwRy2i5h72riQ=;
        b=h3U3JodQ4v9AU3pUQKb7172/EevAatA+XziPFc+zeECjqiWf1Zw6LOYWXCCdDaV8it
         sZNpQUKFaqaBqO4gsW9lkt4HqMJj9RPb791BELpFR4wb0OilPPY8JZQ69SyBTGIMH0WA
         oi76JNtylRdCDMpAPtkR8om/Bu0Dysu0tlgEJb8FC0uPpp4Sq26yYVsJ0bGN/7mBHgpj
         lv8sf0UHMVopeTvZtwM1RzBeS1+08O+WHll2VQyU4pFjy3CV/0/LiW/xcYm5q1W8LSPX
         OFwwRWvrgWOrS7KZYP5i6d/KMJow8k/XNQ5oXPDDy2RWRHHDfZmwWusL/ilbRyufz3Ex
         grAA==
X-Gm-Message-State: APt69E1yIALdNOJJugfyHQPQTHXIQ9dhUicxB4a8yEKVeCKgzROgeT/E
        YXNfK/PVA/XEqK5tg7hmm1IpNiw4GNemaeWEfAqw
X-Google-Smtp-Source: AAOMgpcIiFlEt9gUmTeFAW1RTRYKEP75EL/GIxf6qlsnpVtLrTawJodujbZiDduAo1P1kUDXIN/b2DyZshXKxX9BSxcL
MIME-Version: 1.0
X-Received: by 2002:a9d:7083:: with SMTP id l3-v6mr6677otj.54.1530202340628;
 Thu, 28 Jun 2018 09:12:20 -0700 (PDT)
Date:   Thu, 28 Jun 2018 09:12:16 -0700
In-Reply-To: <20180628155630.GL19910@google.com>
Message-Id: <20180628161216.68872-1-jonathantanmy@google.com>
References: <20180628155630.GL19910@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: Re: [PATCH v2] fetch-pack: support negotiation tip whitelist
From:   Jonathan Tan <jonathantanmy@google.com>
To:     bmwill@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, jrnieder@gmail.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This seems like a pretty difficult to use feature, requiring that I
> provide the actual OIDs.  I think a much better UI would probably be to
> accept a number of different things ranging from exact OIDs to actual
> ref names or even better, allowing for ref-patterns which include globs.
> That way I can do the following:
>   
>   git fetch --negotiation-tip=refs/remotes/my-remote/* my-remote
> 
> in order to easily limit the tips to all the refs I have from that
> particular remote.

Actual ref names are already supported - it uses the same DWIM as
others. As for globs, I thought of supporting both DWIM objects and the
LHS of refspecs, but (1) it might be strange to support master and
refs/heads/* but not heads/*, and (2) I can't think of anywhere in Git
where you can provide either one - it's either SHA-1 and DWIM name, or
SHA-1 and refspec, but not all three.
