Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58413C77B61
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 18:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbjDYSW3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 14:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjDYSW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 14:22:28 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467BBB463
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 11:22:27 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-63b4e5fdb1eso7364713b3a.1
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 11:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682446947; x=1685038947;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=MODXo6ZDDO0VMKW/10MDdhr8zR6WK/zIwYD51Al/vC8=;
        b=gf6Mf9sTDfSheQ1LMeycpXBP0ZHISMXhTCtq8xajyaPytgm0XvY51v2sVRYnicIoLA
         KjbKu7rPsMbytWHNcOi7a1vgONt82jV5eOAXjSFT+W+OSPjtl1WmV7GDFCfz2csNw2et
         5KgjsH6ICiqongxjLk4JrZuMF1MIlQTTBtcK1/fS3MXD1Qyf9LoctVOSZeCrMG9bfK1y
         PEHxUG2pQpvXInsnScic4uBSZi7oHGI0s23+pLKQOKn9CoYDIHn7XfxHfY6D0LEFxqtL
         uLVALICC/PxthyRzHyhPradldx9u/OeTUrwGU9mYb657/EgIxM7hWJlK+ChwVcVYjicg
         kCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682446947; x=1685038947;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MODXo6ZDDO0VMKW/10MDdhr8zR6WK/zIwYD51Al/vC8=;
        b=AdqAYlOvxNPjiMO2CCLbi2G2EdaszbNRNyl4IZ9NXPSvGpOTwR8nd5ZroFYUUNQsnE
         r+gqdB9Z4sChY+ZWMZFe8l8WSdjT8+LehS+nAv84P/m7tBmmYgPPMcoZfkyUdANwSjLN
         0JtZd3LgYAIWLCSn3HfERsjqTP15W3BskVatl5lKbD0733sziA/Aqj3vQPIK4h3kqeAz
         RmqE+sEkHMh7zMXuDk4coYOzTp2jKtDgJXCMq7qrM2QHwawwxU5m/sUc59bhlE37aZ0S
         U9mgJWrA9pKBhQ0+WFhFCJhp17VlKGv3AXP6Fy8zC0sjyFCHj2Bzj2bUrKwj0QKNIbyO
         ukRA==
X-Gm-Message-State: AAQBX9fxbqserGZbG8S03h+JVSpQZEGQMP7fIQo/JpmqkZt89KNrO/id
        QEjE9LfbFYszkyPgjBfyjc8=
X-Google-Smtp-Source: AKy350YZeHuqbE5LJ5C6ND/O3KqHuhSdqZbmD1V1ly9qh+fYgMDJW48MpBDCQs12P3jgx2xpsAkteg==
X-Received: by 2002:a05:6a00:c8a:b0:626:cc72:51ac with SMTP id a10-20020a056a000c8a00b00626cc7251acmr25295380pfv.30.1682446946588;
        Tue, 25 Apr 2023 11:22:26 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id p23-20020a056a0026d700b00634b9132694sm9573413pfw.126.2023.04.25.11.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 11:22:25 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/3] revision: support tracking uninteresting commits
References: <cover.1682380788.git.me@ttaylorr.com>
        <a643678c0ff7d1a910b1d6c33a839166e2a6a7b2.1682380788.git.me@ttaylorr.com>
Date:   Tue, 25 Apr 2023 11:22:25 -0700
Message-ID: <xmqqsfcnzuse.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> The boundary-based bitmap walk will want to know which commits were
> marked UNINTERESTING in the walk used to discover the boundary.
>
> Track which commits are marked as such during list limitation as well as
> the topo walk step, though the latter is not used.

There are many more places, other than these two that are touched by
this patch, where a commit is marked with the UNINTERESTING bit
(e.g.  mark_parents_uninteresting(), process_parents()) and it is
not quite clear if the commits smudged with the UNINTERESTING bit in
these other places are eventually seen by these two places that
somebody else smudged them and get collected.

Or am I wrong to understand that the idea is to collect all
UNINTERESTING commits?

Also don't these two places see the same commit more than once, say
when traversing from two branch tips with UNINTERESTING bit set and
the traversals meet at the fork point of these two branches?  Would
such a commit get added to the array in duplicates?

Thanks.
