Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F1F41F42D
	for <e@80x24.org>; Fri, 25 May 2018 04:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751889AbeEYELV (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 00:11:21 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44557 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751235AbeEYELU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 00:11:20 -0400
Received: by mail-wr0-f193.google.com with SMTP id y15-v6so6729336wrg.11
        for <git@vger.kernel.org>; Thu, 24 May 2018 21:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=v9TuF/OFGVDqJVLmYAa+YUFRUbW0svauBzJl1NSfqew=;
        b=R1SdkFqkpwqq+RO6cnCdNkCQGibBK0Bf3lPooFcD8YSRx09HENZVsEojxYBoscmtnp
         EDF7pG7SxmbI8Rt5/EciMOAKUioTqAI8FDnEfjW/uCfsjtvyk16joy6e8FtrhLLbCcXD
         gVIh+Z2IwSPHauDcKrE9IiQ+1FTFqyK5nToeeGp8p3FTLXnkA9qWT819xCtwNCMhqFOm
         IMZ75e79rMQbnzBdFOpFyLFaBV7l9o8vz21EKDasM1hPzGR/aYyIt4XTh7ftKgrz8bi0
         YRw02XPq4x9eUurzVe3gHZBLesusOD9pWIXVv/C266M0K22dMxFGxFnU2iqfxVHiIHYd
         uCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=v9TuF/OFGVDqJVLmYAa+YUFRUbW0svauBzJl1NSfqew=;
        b=qLdSAl8Zq+ZkzVONhbmx7+5BMK2hQLnxJ8Qz5E5Ag0NIcT4Q9qbiAicFIE+PgeKxR7
         UBn7NkZ6qhW5/VIwN1Ci8LqnU4Z7WZpmY4PL7v6KlBqrCdilWDcCGR/4aAp+1lG9HWAv
         QFJU6oKYZdboeKtwuh7DKiq81GGiFxFPxIP7Ayh27AxTjicDq6+tZ7+8QZHlz72QibvJ
         +OPOazKd+qQXUxrpXq+P7/ZfWvRM2fvfzwOKsnxfX9zk5WxxPGF59/reoNxkbHRxLeuh
         YObkfeF/RfnwQG+TezwWaskuzpS6DWkV5J20hvXKvxE9f+wD23Va4+8Qs+8PYpmauVPn
         VDDw==
X-Gm-Message-State: ALKqPwfK+hTzvGumc7sKoFk/KspVWBtNYP9CYRl4YEpxkfN8UMINLswE
        J5nkbLo497ZqFdRTTFTo86rdynsh
X-Google-Smtp-Source: AB8JxZrKb/21b/D7hD/9+GpnSkoDJf7xyun+sN8mgahOzNWjUOQLoGzqPXWNn6fDbokwKIbSpFknqw==
X-Received: by 2002:adf:92e2:: with SMTP id 89-v6mr547656wrn.64.1527221478915;
        Thu, 24 May 2018 21:11:18 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p38-v6sm9152999wrc.11.2018.05.24.21.11.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 May 2018 21:11:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "jnareb\@gmail.com" <jnareb@gmail.com>,
        "stolee\@gmail.com" <stolee@gmail.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "marten.agren\@gmail.com" <marten.agren@gmail.com>,
        "peff\@peff.net" <peff@peff.net>
Subject: Re: [PATCH v3 00/20] Integrate commit-graph into 'fsck' and 'gc'
References: <20180511211504.79877-1-dstolee@microsoft.com>
        <20180524162504.158394-1-dstolee@microsoft.com>
Date:   Fri, 25 May 2018 13:11:17 +0900
In-Reply-To: <20180524162504.158394-1-dstolee@microsoft.com> (Derrick Stolee's
        message of "Thu, 24 May 2018 16:25:23 +0000")
Message-ID: <xmqqtvqwnzmi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> One other change worth mentioning: in "commit-graph: add '--reachable'
> option" I put the ref-iteration into a new external
> 'write_commit_graph_reachable()' method inside commit-graph.c. This
> makes the 'gc: automatically write commit-graph files' a simpler change.

;-).
