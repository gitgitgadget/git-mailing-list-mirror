Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2FBC83004
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 05:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2387206A5
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 05:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNdRDz+6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgD1FzS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 01:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725917AbgD1FzS (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Apr 2020 01:55:18 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64647C03C1A9
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 22:55:18 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id n11so1680597pgl.9
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 22:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=dA+EZeEpBBPr4dLt83HMAJSYGFMmBG9xd7lRNf/aQFE=;
        b=iNdRDz+6u2xNVwvwZXA00tYuXiwudq5pfUmAMzII0sUdhXO/Ws3XwiEE0lF66QVf9d
         ikSpoQWWURInc3cvyfpON7aCk6LBv1enz3LTbrKu0HkheMPMhsRNllz2+6A5lp7syhSU
         UaRvRVdD7pEOFRKg7ndg8NZIHqUJr1Vp+VdCpPJzfSkcOUd+nFmzitcAGsoWXiOyUOBn
         ClEotYHfu6z610MuAkooS60nRs7qKQZcppmhUgyfdG54cNE6czE8iSoCdiaaFZAsAHnm
         Lm24cc2xxx5txJOUUy/QncKJ6ccv2UK7JiHATLy9Kpi6GB4ZHWRdBPXKg+ZAe0eKqzLD
         8y9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=dA+EZeEpBBPr4dLt83HMAJSYGFMmBG9xd7lRNf/aQFE=;
        b=kxAXxW0Rsn5Os+usi7uv+hpdvIEqgY8MXkCzsFNjatlQQ5hOWeOIATefps4aM+iq0M
         eTORLynr84KPtlSt1sC0lWDKWF+X0ZIZEBY/dnxKmowt9ZOOE8MfQpHoE3tLAWXvBP/k
         rc6HONidbWTd1sIxkypxJt7DKhBJKK2TQHvUYbEP0CKUDqs1FzuiWrDUKK+MM7z1Eh3y
         wV6oU2/tMKHelVisK1tsATZxyeHh/8IV844RsQ7rX619SaDrksfALnAMDdbfq8PP5ldu
         1F4pr+YeK9z4aGaJS8Rxk0WXM/ZH4bPGUTGGjlWNCM2kRCTYDcSBUiYKTMNpNqfGcPON
         faRA==
X-Gm-Message-State: AGi0PuYNNpKFQDaFeAuTrPNESsZj5tUbH2rBh2zYKarglz2offzerRGX
        rC7+10tmHkVW8HZrZRxgCbE3pB9q
X-Google-Smtp-Source: APiQypJ4E9MXVm6PU0LZrUDBMPRouWbsWEneI7yU4vhXUVYwm+GEsPHM9dA/kxSiEHLY6gPckzSqAw==
X-Received: by 2002:a63:33ca:: with SMTP id z193mr11963168pgz.210.1588053317032;
        Mon, 27 Apr 2020 22:55:17 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id a15sm1041828pju.3.2020.04.27.22.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 22:55:16 -0700 (PDT)
Date:   Mon, 27 Apr 2020 22:55:14 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Subject: Preparing for a Git 2.26.3 release
Message-ID: <20200428055514.GB201501@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Last week and the week before Git released 2.26.1 and 2.26.2 in quick
succession, to address some security issues (CVE-2020-5260 and
CVE-2020-11008).

Since then we've heard about a few related (non-security) regressions.
I'd like to avoid giving people an excuse not to upgrade, so this
morning[1] I promised a discussion of what I'd like to see in a 2.26.3
release to help with that.

credential_from_url fallout
---------------------------
The credential_from_url hardening affected http.c in the way we'd
like, but it also affected credential-store[2].  We may want to relax
that.

(only affects 2.25.y and earlier) The credential_from_url hardening
also affected credential.<urlpattern>.* parsing[3].  Depending on what
semantics we decide on for those earlier releases, we are likely to
want 2.26.y to behave the same way[4].

2.25.y -> 2.26.0 regressions?
-----------------------------
The main major changes from 2.25.y to 2.26.y were the change of
default rebase backend and protocol.version defaulting to 2.

I don't believe there are any major outstanding issues with the
change in rebase backend, but I'm cc-ing Elijah Newren to get a chance
to be corrected :).

The protocol version change was painful for users that fetch in the
same repo from linux-next and other linux remotes[5].  The problem has
been isolated and fixed, so we could either apply the revert or apply
the fixes[6].

credential helper hardening
---------------------------
Lastly, after seeing a v2.26.1 security release and v2.26.2 security
release in quick succession, I'm looking at what it would take to make
Git more robust so we don't end up need .3, .4, .5 security releases
soon after.  Perhaps we can make the credential system a bit more
robust to prevent future similar accidents.  For example:

- teach in-tree credential helpers to reject repeated fields in their
  input (Just In Case some variant of newline injection that uses \r
  or something pops up)

- teach in-tree credential helpers to require the host and protocol
  fields to be set (e.g., [7])

- update git-credential(1) to document the newly tightened protocol

That might go against the goal of getting rid of excuses not to
upgrade, though.  Where we see regression potential, we can be patient
and wait for 2.27, but if we have some examples with particularly low
regression potential then they might be okay 2.26.3 fodder as well.

Thoughts?

Thanks,
Jonathan

[1] https://colabti.org/irclogger/irclogger_log/git-devel?date=2020-04-27#l65
[2] https://lore.kernel.org/git/20200426234750.40418-1-carenas@gmail.com/
[3] https://lore.kernel.org/git/pull.615.git.1587588665.gitgitgadget@gmail.com/
[4] https://lore.kernel.org/git/pull.620.git.1587767749.gitgitgadget@gmail.com/#t
[5] https://lore.kernel.org/git/20200422155047.GB91734@google.com/
[6] https://lore.kernel.org/git/cover.1588031728.git.jonathantanmy@google.com/
[7] https://lore.kernel.org/git/20200420224310.9989-1-carenas@gmail.com/
