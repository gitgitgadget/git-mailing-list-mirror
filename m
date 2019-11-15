Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 012FD1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 18:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfKOSD1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 13:03:27 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:35194 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfKOSD1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 13:03:27 -0500
Received: by mail-pf1-f201.google.com with SMTP id x3so8273545pfr.2
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 10:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zuVg/AImWrpRvDwulPuz4fPkkDblrzT/FgyCRFszhyg=;
        b=a+zwksG31t1d2uBckTngzT0/q05MOxNYQf/xu8VV0yxYeaIVxcSAloYQjxoVn+Ydcu
         QsF/Fd4fOcZ7LwTIDzPmg67DHb8bIE/zOHIxjeKiWDFLOCkuIqGNW6KtayROb1zKWn/1
         EiSdrkm6WfezcB6rOuqAGml+2MF4dEIjzRzIIK3PL7Urxx5nR1+5p3EqVmBLFMqEIFgZ
         U24VrqnLNGCt9bPTf1yOMt61djwAvvoqgJizy1D/Ora7UE5hKpP5VtYqc9NHwEd+5v2l
         uE99XJbIEnLk0zu5AMk77+d/GCYzY3pVXMtiIdiMc6OeaKSMk+nv9yrnO/dvm97x7f54
         6/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zuVg/AImWrpRvDwulPuz4fPkkDblrzT/FgyCRFszhyg=;
        b=ai/JYK3suPpIH079zTITRJJc3M8dhsysE4IJc3MdtQn1KqnoE5Nbp6yv3F1/aDpPlB
         bCRnZTy0YMolDsS2crr5143tw2cjXzMNM6d/ZurvB9b9LW/0yiMkUpb6foAEnoMZukkU
         zrLVc6C0M7DLyqVFOJ5+jFi/ompLkCfPqBlJyiH7J5qM+8B5ubUKRsv0xbJnRwGkgo/u
         7Rdk3+m0o2FIkv7DfvBDSz3cMQTNA0+R/Zq+25J2okbipQhIo0gIF4TAs1Gwn8vlT6uT
         06N/s3mYRoqBx79Jkt6BPaGfGdjxJt4HOKfToLO3tqjQrR9h6qvKUzFHuGDBvYya+6lF
         DsrA==
X-Gm-Message-State: APjAAAVRNZZjEnO45iIpQ2/gv/vO19U2IB7FilMM12s/OJuKtRwuzJ9X
        5TkvDklZzDghUzU2ecKTXmg2ddM4Zt0tALmx3YOB
X-Google-Smtp-Source: APXvYqytt3U62K6ssWcDb/3Inzg0ymx8Pagm1fuLj6sln0/ohikUzg2Hs6Xc14Z1DtPtVDSHQTqA5OHMLgYiSS5E2w48
X-Received: by 2002:a63:5801:: with SMTP id m1mr17497026pgb.139.1573841004929;
 Fri, 15 Nov 2019 10:03:24 -0800 (PST)
Date:   Fri, 15 Nov 2019 10:03:19 -0800
In-Reply-To: <20191115141541.11149-1-chriscool@tuxfamily.org>
Message-Id: <20191115180319.113991-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20191115141541.11149-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: Re: [PATCH v3 0/9] Rewrite packfile reuse code
From:   Jonathan Tan <jonathantanmy@google.com>
To:     christian.couder@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        chriscool@tuxfamily.org, ramsay@ramsayjones.plus.com,
        jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> It could be a good idea if Peff could answer some of the comments made
> by Jonathan Tan about patch 9/9.
> 
> I have put Peff as the author of all the commits.

Thanks. I think the series looks mostly good except for the questions I
raised in patch 9/9, so I'll wait for Peff to respond too.
