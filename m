Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 600561F461
	for <e@80x24.org>; Tue, 20 Aug 2019 21:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730925AbfHTVj3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 17:39:29 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:51642 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729900AbfHTVj3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 17:39:29 -0400
Received: by mail-vs1-f73.google.com with SMTP id 125so67143vsr.18
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 14:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hjQPpgU68kbPDZPmzHXLRBmcgTaalusGOHM/pXUAWsY=;
        b=gmZZl+VhTGtPIbbfhjONhR/hm/grVfP8oY0+FPpYMkgDi/8lsRMmunCEafTJZuqGnd
         g1xYjoir6vpSSXDK4TJBnzgG4zz9e4awrpgv6uPx7m8HGhEpUDL5+Qt4UPFmzlZRaY0O
         WxBvf9XDDkuoZRTFkhCmb05hKqV+52E9PZhEy3KWfO5rtPZAJ60fBxCr+yPmCaOjmUqA
         69lO3tIa9mdmRFmQaDkesk3RkTtFljYoVM6vqWp2tm3Oi5stXFkJ2Z+QTsyTxZNHkQvX
         6lcx63Lq+ndtztAJ9lTYKC5zdwxQQvKlMs6kxTsj7xqvoiSAnY01w4DuAifcHYhKP0st
         7crg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hjQPpgU68kbPDZPmzHXLRBmcgTaalusGOHM/pXUAWsY=;
        b=dX+Njy5GA4B0N+uViKwiPbI2siLe+PuJ42f/obSepq/7LyQT35zpxRiNr03r/Hk0h2
         TmMHNHvhEOy3GICJe7/u6n+Ul/XfLcfgnJXGBWGxr+iVeuXnRHFCuAE4wNAU/LRRiPiO
         QItC0JivB055AnpMb9K9llWYH7SOZPeLMKNCEWxZ98CVNRc3wbxBgyjqENZxlhAhtBS+
         7a2tT1ON6BVPgDqp9clJy5h5wLQ1ImQy+FrKpSFsLgECuhTXpKbuD7ScjbwYsEXMpZj9
         jbLaw9EVELBAOXeJBj4YD7NpaeBzYCk8Ks5vJ2/C8gTSSGqaaG/0PI+2ktH4JW0cp2vv
         By/g==
X-Gm-Message-State: APjAAAXaXG+aDg235M8Z4W14Z4nLe1y4X/U55oo0Y2peePkFb1B6C9Uc
        /MhMu51Fs5W19OssLDJo4bwWfm5Q0BVPL6dRcGaI
X-Google-Smtp-Source: APXvYqy34Xden8p+Rrg5vPt8/rfIkHx8Jbsju4+vFKV6gqHO6eo9wXUCUyE814A+ovjKAoOyYn/Mp+83nXeFTpZ9Yy5O
X-Received: by 2002:a67:f043:: with SMTP id q3mr18288338vsm.219.1566337167925;
 Tue, 20 Aug 2019 14:39:27 -0700 (PDT)
Date:   Tue, 20 Aug 2019 14:39:24 -0700
In-Reply-To: <xmqqblwjtu1b.fsf@gitster-ct.c.googlers.com>
Message-Id: <20190820213924.154253-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqblwjtu1b.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: Re: [PATCH] diff: skip GITLINK when lazy fetching missing objs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > In 7fbbcb21b1 ("diff: batch fetching of missing blobs", 2019-04-08),
> > diff was taught to batch the fetching of missing objects when operating
> > on a partial clone, but was not taught to refrain from fetching
> > GITLINKs. Teach diff to check if an object is a GITLINK before including
> > it in the set to be fetched.
> 
> OK, so in a lazy repository, running "git diff" (or "git log") could
> have resulted in "git fetch" of a history of a submodule, which may
> likely have failed?

Yes - it would attempt to fetch the submodule commit (as stated in the
GITLINK) from the superproject, which is very unlikely to succeed. (And
succeeding would allow the operation to continue, but will cause the
superproject to have unrelated objects in its object store, which is not
what we want anyway.)

> Sign-off?

Oops...here you go.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>

> Makes sense.
> 
> Thanks.

Thanks for looking at this.
