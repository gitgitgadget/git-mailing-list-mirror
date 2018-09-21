Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D6841F453
	for <e@80x24.org>; Fri, 21 Sep 2018 18:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391191AbeIVAMq (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 20:12:46 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:56895 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390076AbeIVAMp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 20:12:45 -0400
Received: by mail-vk1-f201.google.com with SMTP id s204-v6so2840884vke.23
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 11:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5gxPsnl68u0+IFEciIdOex9m17v0Fs5FoM6mphcz40A=;
        b=rMU2WGuU74LpAZ/8T9IawhfgzSjlFvkRGUZG37tHBRWKc3Dx+YuEelhpykwO+HUYXX
         GyH6HHIr9QjZMJNxA0aKsDfYKT354KrOEHz+4TNyG9ALHAG498D52rE/xsSuCPJ72Izb
         s0TNoIpYCPibtczvGIESNSEAx4ZLFpLByvHscwJ4Uztt0CbcLQBu/7otLhdMemheTGh8
         cSnbix/sNIAvYDaPrfcJBCaKxWgLJQ828s40+5Wu9FzdPLgkfvLhEfM1I9Bezm5M81B2
         Vcd59CjaO0V8gHmx+w+CFmS23XfGgytJXHT/fuuzy2QIJ9csJcifRjX0nyU/lmK/xrGb
         pS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5gxPsnl68u0+IFEciIdOex9m17v0Fs5FoM6mphcz40A=;
        b=DXyb8NY5SaMmZW/W/WjrR9rmAADtWYoaVIr2EDqsoB41oX3LtGG6gZraWRDPZSuc0n
         7eDc8DyqjfCdipIuphG66BqgJBylkbGwhxTeyfovfx0IjhZs1CmqZtI9fne/Eoy0Uxau
         rrV+LRuTJ515oYQyJlxb1dS6cKrTzU2ToQkST6dYk1y+k39NU/hgkIHsXtzAiR0A8apq
         XtnDDTJMoEOu2YKBeNdsqXAdkglpX2PZHxZTD9VZzoMViPWRusOF1q7vg66yahr44VSc
         oJljbitscKbQSrQRCNJj6VrkIFnhNU9vLKpDF6Y9RLb15eKY7i4Hro/PTlwQbRjwI2GF
         PMdw==
X-Gm-Message-State: APzg51BetV9znmlIiHsqghIjPJYffYsXEnjFXYzi/pNV/6ZcAMkge74k
        XQfmM9wYfD0VbAqPwCWJQkdOsTBl1hMHCXDF72ijbRz3xRsivKjDShcRIMeTOJYeP+l/WNIodB2
        GtADnXPz+4EghWUURmKLnuNhiOjcG1TacFbZluAacY0SzVijb0JlA/hVajjzDExAepploPzlq1O
        oQ
X-Google-Smtp-Source: ANB0VdYlAlAHAVRWGkDEcQB8D+i8ck2HXvYRMuiZMnmvjn9rPGaPNqUJdZZdNTz/c7ZdDotLOBCaL8d03plQ3hYct3e8
X-Received: by 2002:a1f:c18a:: with SMTP id r132-v6mr10587167vkf.9.1537554160919;
 Fri, 21 Sep 2018 11:22:40 -0700 (PDT)
Date:   Fri, 21 Sep 2018 11:22:36 -0700
In-Reply-To: <20180920184843.20898-1-jonathantanmy@google.com>
Message-Id: <cover.1537553700.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20180920184843.20898-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH v2 0/2] Check presence of targets when fetching to partial clone
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

New in v2:
 - added patch to clarify in documentation what check_connected() does
 - renamed quickfetch() to check_exist_and_connected() to better reflect
   what it does
 - also updated its documentation; I avoided usage of "wanted objects"
   and used "fetch targets" instead to clarify that I'm only talking
   about the direct targets, not all objects referenced by those targets
 - in check_exist_and_connected() (previously quickfetch()), check
   existence directly regardless of whether the repository is a partial
   clone or not

This should resolve most of Junio's comments in [1], except that I chose
not to modify or rename check_connected(). In this current world, it is
true that we usually require existence of ref targets, but that might
not be so in the future (having said that, I don't know of any schedules
for this future). Also, check_connected() is used in a few places, so
such a change would cause some churn in the codebase. So I left this
function alone.

[1] https://public-inbox.org/git/xmqqy3bvycie.fsf@gitster-ct.c.googlers.com/

Jonathan Tan (2):
  connected: document connectivity in partial clones
  fetch: in partial clone, check presence of targets

 builtin/fetch.c          | 15 +++++++++++++--
 connected.h              |  6 +++---
 t/t5616-partial-clone.sh | 17 +++++++++++++++++
 3 files changed, 33 insertions(+), 5 deletions(-)

-- 
2.19.0.444.g18242da7ef-goog

