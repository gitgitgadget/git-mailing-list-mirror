Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24EB21F463
	for <e@80x24.org>; Tue, 10 Sep 2019 18:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfIJSTX (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Sep 2019 14:19:23 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:48145 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfIJSTX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Sep 2019 14:19:23 -0400
Received: by mail-pl1-f201.google.com with SMTP id k11so5541537pll.15
        for <git@vger.kernel.org>; Tue, 10 Sep 2019 11:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dbvMQl8H4HfAuGsSFi9FoLCJ54OoLv7W7qo2bZSM1Cs=;
        b=rZIdwf2Fjpuhsm4iMAVe/b+PaKFVIoDHA8Hb8LUBVlsmBvxGnVIn35HYBi5V0OY9H5
         yIAWra4gkxrg6Sw5tPHop2bwq+yJ5Yr0fP20a5Cbw2/4LTKHDXGx7gV7Dn1ITjAD/kwb
         A9mQwidIxUyadHAybE6k7psofOgJrjHn7NxKMXnVZoS94wr84axaQtTtvzPVzdbNJta8
         kPPgDmqWhIgKk8Cf9RdkoW/luu1pqiCVYmYPfGZ87SPlozc0dtqDqh2+ELWtBsDea2ft
         HeagfriO1IgbK2dbyyP7A9viYNasvGJk9GgsKw44C78TYoSHX76P10jSL+LavpPJ1W6G
         ZKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dbvMQl8H4HfAuGsSFi9FoLCJ54OoLv7W7qo2bZSM1Cs=;
        b=Q/zwxbUkTTzIawanrG65br2aRm0YVWzA6timHyh8sz4IpZCaPBKfcHyxXFvWxOT2E5
         11O9Ao8wh5wwXnGzQSK76+2XrUt7rOCLsTUMiPPfgGsr3E6sPZFi5VQ/9ITOYa6j5MJ0
         6VYf9mMePM6cmk7tV9bisxHlRrHg8SIJCSjcpP6S+2LnAlFXgCYLQ5ux6psyenSP/3DE
         tz9gRRzCWlNEPh25vM18EVJgWdjuxVUBVvQMNm5wm8tv9yWlTcEqOHV6QAwUYl3NBZ+H
         rSsf3BgkKgKwiGVoNoZk9NBfFBCpq4wCNPHw299/e9HNGI5FEU8sHdAXO/McpMAUJdLj
         ghsw==
X-Gm-Message-State: APjAAAUp05afFczk6Orpf7RINRwjic5mRhNUhHUWqXyRj74TGVGw/qMh
        NMvPf7XY3N9C0apNxlewwP3eD8TihQbzsq6nfsVF
X-Google-Smtp-Source: APXvYqw5ZTQRo528lI5cHKysFE+K4zrxm2RuHx+FpZqIUP9UGij8hLRgMJIcAoW4RnehGcz93w9Q5P9pbwGU2V7caI9E
X-Received: by 2002:a63:590:: with SMTP id 138mr3424513pgf.78.1568139561911;
 Tue, 10 Sep 2019 11:19:21 -0700 (PDT)
Date:   Tue, 10 Sep 2019 11:19:18 -0700
In-Reply-To: <20190910124920.GI32087@szeder.dev>
Message-Id: <20190910181918.137494-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190910124920.GI32087@szeder.dev>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
Subject: Re: [PATCH v2] cache-tree: do not lazy-fetch merge tree
From:   Jonathan Tan <jonathantanmy@google.com>
To:     szeder.dev@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Sidenote, just curious: did you originally intend to add this test
> before the test script sources 'lib-httpd.sh', or you were about to
> append it at the end as usual, but then noticed the warning comment
> telling you not to do so?

Honestly, I don't remember. I do try to put tests near similar tests, so
I might have seen that we had HTTP tests at the bottom and non-HTTP
tests at the top, but in this case, I don't remember if I had that
thought before putting this test where it is now.
