Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E8951F404
	for <e@80x24.org>; Tue,  3 Apr 2018 18:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752480AbeDCSVk (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 14:21:40 -0400
Received: from mail-pl0-f54.google.com ([209.85.160.54]:39256 "EHLO
        mail-pl0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752447AbeDCSVj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 14:21:39 -0400
Received: by mail-pl0-f54.google.com with SMTP id s24-v6so9994035plq.6
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 11:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7ZQZ+JVPYOLBR1fjgqySOXEQ0T6ont9In6KUrlK8Ak4=;
        b=lY16TLkAP1l5+vX9mLIQyX3rB0oIyZJtGzUZ9DCc+vYi8pbF06F0NBxlgoo4NWBea5
         6UsdCEYdsePqdaVvWHSUq5jvBcqRJJkIUU9ypye7GfzyhYMIWdl2O9P04tJYBwRjaTJt
         e5ubnazqTSV02O2kdtFRjpO15kOJnHn91jVYMhv4FvErxLZZPlTB/s7/Yaw2J/jp30k6
         mVmQScwxt2qfRY2BzBJbFL5w81N0Kar3KBVVPc66rj3nIH+MawsAOOtv8oXdIo9tfvAo
         NzEyCAR5hZaH7pq/1LlRBhmtMMJY96lEwcdQku75wzA4D+N/cDldjHxWnuA8CxptCYlz
         6qkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ZQZ+JVPYOLBR1fjgqySOXEQ0T6ont9In6KUrlK8Ak4=;
        b=pu3geRJBzUK9Yz6uyUu6LSUKD4vv8D+jf2EqaFO5YwGdmAJ5W3HAGNjGLvoU4Fy6zB
         QmFPF4kEZs/vhjT+MzCUJBKuEe6whmnTOa7gDjy/fvtBC7LpstDuuetoyWnsZPRiRqJD
         s1hNncdkNdqqNbZgguvtLsjbEU9hkQwhnjbCucI2zwTC/kLMDnv4pdOFL9k2laWxWAt3
         oLsEPc1k5MRljTfMFLvfjh5DR8IqxrBGPYQt1/mTpCX/lY4D+XfSMaW8X8/rFRLdc/5h
         c1A69CccQR2no566EXCRBq5ep+58503d3nDRS308P4Pttuzg6+lt61Almu02HWrl1EQF
         RQzQ==
X-Gm-Message-State: AElRT7EEKCGIr/MB+q4Vc1spo77n/MwQMXyK3AdInTGuSzJ3+eqJ08Fm
        i31jButZFLuDDs0PmMVencWCufzKwJI=
X-Google-Smtp-Source: AIpwx4//m0WOK3AuDXUX8N0udUGz5m3ArzuJF+kbonejaiULRHFjpfoPK/MA7+W5lvtrDFkENk3Zog==
X-Received: by 10.98.246.25 with SMTP id x25mr11428210pfh.138.1522779698789;
        Tue, 03 Apr 2018 11:21:38 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id m11sm6627543pgc.30.2018.04.03.11.21.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Apr 2018 11:21:37 -0700 (PDT)
Date:   Tue, 3 Apr 2018 11:21:36 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, sbeller@google.com,
        larsxschneider@gmail.com, peff@peff.net
Subject: Re: [PATCH 1/6] object.c: parse commit in graph first
Message-Id: <20180403112136.db2aeda65afe0c09f262dfb9@google.com>
In-Reply-To: <20180403165143.80661-2-dstolee@microsoft.com>
References: <20180403165143.80661-1-dstolee@microsoft.com>
        <20180403165143.80661-2-dstolee@microsoft.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  3 Apr 2018 12:51:38 -0400
Derrick Stolee <dstolee@microsoft.com> wrote:

> Most code paths load commits using lookup_commit() and then
> parse_commit(). In some cases, including some branch lookups, the commit
> is parsed using parse_object_buffer() which side-steps parse_commit() in
> favor of parse_commit_buffer().
> 
> Before adding generation numbers to the commit-graph, we need to ensure
> that any commit that exists in the graph is loaded from the graph, so
> check parse_commit_in_graph() before calling parse_commit_buffer().
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

Modifying parse_object_buffer() is the most pragmatic way to accomplish
this, but this also means that parse_object_buffer() now potentially
reads from the local object store (instead of only relying on what's in
memory and what's in the provided buffer). parse_object_buffer() is
called by several callers including in builtin/fsck.c. I would feel more
comfortable if the relevant [1] caller to parse_object_buffer() was
modified instead of parse_object_buffer(), but I'll let others give
their opinions too.

[1] The caller which, if modified, will result in the speedup to
the merge-base calculations in the Windows repository you describe in
your cover letter.
