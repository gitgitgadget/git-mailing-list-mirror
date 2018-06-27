Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B8A91F516
	for <e@80x24.org>; Wed, 27 Jun 2018 22:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751004AbeF0Wkh (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 18:40:37 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:38082 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbeF0Wkh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 18:40:37 -0400
Received: by mail-ua0-f201.google.com with SMTP id f18-v6so1048236ual.5
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 15:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=BXw7pAdpbTB2lvg6eDO/SPR/vKD0U/CvJ1uh4oDC2xk=;
        b=m/QeV/QDBSGSEep7hINCOv1WGezwAKgk8iA5uayAkgrnzDS3N94ENxNsTEwKY+a0PD
         N8qXMlYK4Uma8Tma8FWg+n0s1rQvWQK0dyh6mAUi/GTRus/Hp51xuxRaTJeaf/BBybx3
         YAu/YkH6QhTM/+3lMs8FwLE+oBNZ8v69k2ujGVIeuT3oSQ+V7hZ+WoProHBdaftyhzD5
         8Ipbuy9X7T9KQPOdB8ToL1mPkZ0Gc9xNslFDNXVUyRrO+BevBWupK0Q3JAstpZ+H+UIN
         aLU6uFkjWr3RmYQGnkhp1ibLcXUp4+0/SAMzFP3bjLOLeZ3Ai53JgTobzBLi8bZR0uby
         CdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=BXw7pAdpbTB2lvg6eDO/SPR/vKD0U/CvJ1uh4oDC2xk=;
        b=NhLIDQxPg0DgLatbp/9ypOlZW7vfoUCmFluG1V8BWBTXKR7Gye/Rq1h7GeZ8A2DT3C
         i6IhmsrmLSEgTPBKwfssE4uyskrJaS6i6kNHhk1HQuVWGaVbRwLCmZRCNcnmVCTY6PNn
         XyOHKbcQA8Tt75GVVdEEXO+moeohHiSBbfjftB/gWq2kpKdpiIaWGWAgx1NjBPqxQ/rF
         xXhsabqH0khA91wztxg8GoMRwJiixVQqmBnzVfZhyun93tzDpVsGx81lMgyQqcI/JSBr
         15423zTsRmZ3OXZjmUrwAS5Qxf2WJWC6MEvjvMfN7rOSUxptOU0UFcgu1Tj3v5tOUWEG
         UShA==
X-Gm-Message-State: APt69E2zLvlFpvQyGLVRoiwiLnCdvP+IOzxmUmaG5AT5FOusWuDk8IwE
        OyMTi6b7JOZumEnoyINQCoTlDxQ++oZELDyAAQOC
X-Google-Smtp-Source: AAOMgpdsoEMlICDoWZRRiqmoZSiPtODjim/aNnuz5v03hlOncaQfQAjqqQcWQGBK9bG5gFFAJ7I9OgZFZvSYwx2UDFpF
MIME-Version: 1.0
X-Received: by 2002:ab0:1b4b:: with SMTP id n11-v6mr3189602uai.90.1530139236379;
 Wed, 27 Jun 2018 15:40:36 -0700 (PDT)
Date:   Wed, 27 Jun 2018 15:40:33 -0700
In-Reply-To: <xmqqin64dmui.fsf@gitster-ct.c.googlers.com>
Message-Id: <20180627224033.150025-1-jonathantanmy@google.com>
References: <xmqqin64dmui.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: Re: [PATCH] fetch: when deepening, check connectivity fully
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Hmph, remind me how old and/or new shallow cut-off points affect
> this traversal?  In order to verify that everything above the new
> cut-off points, opt->shallow_file should be pointing at the new
> cut-off points, then we do the full sweep (without --not --all) to
> ensure we won't find missing or broken objects but still stop at the
> new cut-off points, and then only after check_connected() passes,
> update the shallow file to make new shallow cut-off points active
> (and if the traversal fails, then we do nto install the new shallow
> cut-off points)?

That is the way it should work, but after thinking about it once more, I
realize that it isn't.

opt->shallow_file is not set to anything. And fetch-pack updates the
shallow file by itself (at least, that is my understanding of
update_shallow() in fetch-pack.c) before fetch calls check_connected(),
meaning that if check_connected() fails, there is still no rollback of
the shallow file.

So to directly answer your first question, only the new shallow cut-off
points affect this traversal, and not the old ones.

> If so, that sounds sensible.  By not having "--not --all", we
> potentially would do a full sweep, but if we are really deepening to
> the root commits, then we do need one full sweep anyway (as these
> deepest parts of the history were previously hidden by the shallow
> cutoff points), and if we are only deepening the history by a bit,
> even if we do not have "--not --all", we would hit the updated
> shallow cutoff points (which may be at older parts of the history)
> and stop, and for correctness we need to visit there anyway, so I
> think we are not being overly pessimistic with this change, either.

Yes, this analysis makes sense.
