Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C18A208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 23:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbeHHBjx (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 21:39:53 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:37487 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeHHBjw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 21:39:52 -0400
Received: by mail-yw1-f73.google.com with SMTP id 133-v6so452834ywq.4
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 16:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8EOnoM0rSheaClTqWYMtlG2lniJxHAU2JlUN9SNPU24=;
        b=j77Ujk5ssZ7aoSs3gnTNXskmoLLLzHNF1uQ252xpgHZKpus8ZBtRJ5g/5/ONJQkKzs
         2kHp4EQY2eWmgeu8qqcCGjinUpky5vf3Fhtjs/lTd6OprUGbkAZu8wj2PChTebO9K4jE
         kTfTd97Iluq88rFsMW7LDopx7vFvsSBxNyhLSly8yAol0ZzHmzzTqamo7BIL3S4gs3Yq
         DkuCt6rDN9GNYx9934wGzIor3VTFw3FgOa9ZbZ/ZZ5TIk2mh41M8lUlLoP7Gw2tsmoMe
         U4NZgI4s6S3vaZi/xJy36BsSHhR7OyIgHmwdfnw0igB0ovpsymMF9dnlNp8Y2BLBx/ro
         Q4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8EOnoM0rSheaClTqWYMtlG2lniJxHAU2JlUN9SNPU24=;
        b=YjI6npZY7vEJkbulp2orT5cdojy6BOXh7jN78iQ7Te53TP7eisrTj0N7q4DJG8F1Nj
         WYDNEtqSiVwEjvnMaIy+Cs2hxIH73ajw/7Sv3T+7UbzcvJ6ycRDBPBcpzGXkVReDNrx7
         VwbI2o3Hapn8DHR0hOHqQtIak7S2scd8vboly/xCoDNPQl7EipJWPkU5jHSAZtd8uQi0
         OJdsxqs87cD2wEn2IX/4TXNNgRN98vIeM1D622BQmEc1go/W+47EuGtrM1EQP1GGQYUc
         E+IRYtIde7QPBX/lqwY0tZbAt8KLjadDoecnsDVhxyfKFxKcG9/UBYs7r/kCiIvsl5y0
         AAWw==
X-Gm-Message-State: AOUpUlEDdGjReunZtcf2nlyq9IqjamOVsw/S9+Jai5Q8hvnQKXfWnYWn
        LlGhTjYkACn6P+ZeBe5lLNaw84NE/jWCXG0DgDQF
X-Google-Smtp-Source: AA+uWPyDxq/XipHCMXkRbahfVwcrVRfUG9EXVGahPA+2gfajNXGII0O3FmAMNSp2Y1C+LZtDLe0xQ1iSzIXdvW2g3tPc
X-Received: by 2002:a25:9185:: with SMTP id w5-v6mr144772ybl.78.1533684188654;
 Tue, 07 Aug 2018 16:23:08 -0700 (PDT)
Date:   Tue,  7 Aug 2018 16:23:04 -0700
In-Reply-To: <xmqqzhxxki84.fsf@gitster-ct.c.googlers.com>
Message-Id: <20180807232304.181764-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqzhxxki84.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3.dirty
Subject: Re: [PATCH 2/2] repack: repack promisor objects if -a or -A is set
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> for_each_object_in_pack() is a fine way to make sure that you list
> everythning in a pack, but I suspect it is a horrible way to feed a
> list of objects to pack-objects, as it goes by the .idx order, which
> is by definition a way to enumerate objects in a randomly useless
> order.

That's true.

> Do we already have an access to the in-core reverse index for the
> pack at this point in the code?

As far as I can tell, no. These patches construct the list of promisor
objects in repack.c (which does not use the revindex at all), to be
processed by pack-objects in a different process (which does use the
revindex in reuse-delta mode, which is the default). I guess that we
could have access to the revindex if we were to libify pack-objects and
run it in the same process as repack.c or if we were to add a special
mode to pack-objects that reads for itself the list of all the promisor
objects.

> If so, we can enumerate the objects
> in the offset order without incurring a lot of cost (building the
> in-core revindex is the more expensive part).  When writing a pack,
> we try to make sure that related objects are written out close to
> each other [*1*], so listing them in the offset order (with made-up
> pathname information to _force_ that objects that live close
> together in the original pack are grouped together by getting
> similar names) might give us a better than horrible deltification.
> I dunno.

Before I write the NEEDSWORK comment, just to clarify - do you mean
better than horrible object locality? I think deltification still occurs
because pack-objects sorts the input when doing the windowed
deltification, for example:

  git rev-parse HEAD:fetch-pack.c HEAD HEAD^ HEAD^^ \
	HEAD^^^ v2.17.0:fetch-pack.c | git pack-objects --window=2 abc

produces a packfile with a delta, as checked by `verify-pack -v`.

> 	Side note *1*: "related" has two axis, and one is relevant
> 	for better deltification, while the other is not useful.
> 	The one I have in mind here is that we write set of blobs
> 	that belong to the same "delta family" together.

As far as I can see, they do not need to be adjacent in the packfile to
have one be a delta against the other.

> I do not think such a "make it a bit better than horrible" is necessary
> in an initial version, but it deserves an in-code NEEDSWORK comment
> to remind us that we need to measure and experiment.

OK, I'll do this in the next reroll.
