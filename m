Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A34F1F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 21:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390173AbfAOVLe (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 16:11:34 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35651 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732985AbfAOVLd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 16:11:33 -0500
Received: by mail-wm1-f66.google.com with SMTP id t200so4773617wmt.0
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 13:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=G2lR4M9s238Ddbr8e9T3RZ0Uhlz2GHFIVpMe/56npME=;
        b=MSR4hkTil9/mugimaQBnqa6gBRU7rBQDkDzke6zGOEYLIPrXc5nhAqihh6X4WSrxMv
         MGSHo7NoNXQORZYeega6+Kzcz6Ud6OELcF2xXR6y1lmGNSWnJqrrAfazquSM5IHKonQc
         z+4T2Fa7vpIjN3bRIUM4EKb95tnDIk5e0R7R8uv5uqUquWlS52lWNkM6Mc11Z+Pq6Gao
         s4MYF+OaXooG0QItlUgCwIYn1L/f2KN2A1WUlrGET/L93D/gGobHdYCT7waZ7M3XbMjz
         cPaCqVUWA6laD5APJUuvsO5dTok7SwpV3hY8bBrGZzjVEoXrKJ7YoQvz0OxOgo5Eifhp
         25yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=G2lR4M9s238Ddbr8e9T3RZ0Uhlz2GHFIVpMe/56npME=;
        b=Tv0/WNQsWfUtCUGGycXG2vfuf53ecSiYlmC4GO8gfhvzBIH6/E6ZYNbHAti9zizrRb
         /EA6zYPyiiU1CkXTsDRkFxTQaC6WBXvXfm8z34+MEHobEaSUHNJsOpxaIYNPOiQ3n5Km
         t/334NV0Qd8prljNl3hUqE8HDMrm8PY7/tbu/9PwCwzcyDlBitR26iOm3JQMwJjz+c49
         zWWRVY74A21XPugyznP4nYWDtF5k6E1n5CI+Obg3SGLfDwUXpemCqMG7hMlXq0uiUPqK
         iFH4WKFHukeH8rogZ8g3V6xgdyBV2ciEtoN19EtJAL9chujmxskYr11mFbUbcM52tQmA
         CVTg==
X-Gm-Message-State: AJcUukdmsMGcBUypJFHjOhRVsb7ttsNriqN5GG7r1mz5ZhF54/prhmyH
        7SlHJ29jgCTB4SFAIfeDQ2E=
X-Google-Smtp-Source: ALg8bN5e1GzW0Raa3m+qzZyNTzqh5qYoJNEjr1A9RwTFeyg9Z1lS2GK18TKlTTqxRexoQyfSdKyu0A==
X-Received: by 2002:a7b:c315:: with SMTP id k21mr4682437wmj.145.1547586691897;
        Tue, 15 Jan 2019 13:11:31 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c12sm74358195wrs.82.2019.01.15.13.11.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 13:11:31 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Sideband the whole fetch v2 response
References: <cover.1547244620.git.jonathantanmy@google.com>
        <cover.1547581039.git.jonathantanmy@google.com>
Date:   Tue, 15 Jan 2019 13:11:30 -0800
In-Reply-To: <cover.1547581039.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Tue, 15 Jan 2019 11:40:26 -0800")
Message-ID: <xmqqa7k1r5h9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Like v1, this is on origin/ms/packet-err-check.

By the way, when merged to 'pu' as one of the earlier topic, t5409
starts to fail under --stress.

	$ git checkout 'origin/pu^{/^Merge branch .jt/fetch-v2-sideband}'
	$ make
	$ cd t && sh ./t5409-col*.sh --stress

This is not new to this round; v1 exhibited the same symptom.

Thanks.


