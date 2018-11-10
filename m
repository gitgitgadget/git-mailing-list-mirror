Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17B731F453
	for <e@80x24.org>; Sat, 10 Nov 2018 00:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbeKJJxy (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 04:53:54 -0500
Received: from mail-vk1-f202.google.com ([209.85.221.202]:39535 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbeKJJxy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 04:53:54 -0500
Received: by mail-vk1-f202.google.com with SMTP id k8so873265vke.6
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 16:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=tsKcqAn57U3VV3uRHCVxOYpyZ2jKvFqr/oH0KKan0tg=;
        b=ZKiTCOUsBy1O+Su1BsPHbxncO+QXSHTdevsxh8zN7y4XvkPzFjUzkwNlu+rwaSocdd
         RmkFp9JcsbTOENHFYH/s+eLeJKrzf+TFaBcFyIW3iKZfDuC7/71D/UfGcYtTTrPAgW5y
         OfokC00P/oHZRNN0w0K2Sa86wtAJZQZkA25v0vf6k/Rc4BAwjHx6Y421hvhWUKv6s2QU
         ewdQL1qXpKO6DouJ0mNJsE9lluveTzRp6MtIQm9VXBOmNhtjW79byytbEyqRIneMWKBn
         eSrC5SGDkB27WCxHEZZbuRXXoG/iynSoKF/j4gYzz1DfCqqNrDC1OQ+q7Wd9mEPyk3ht
         WcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=tsKcqAn57U3VV3uRHCVxOYpyZ2jKvFqr/oH0KKan0tg=;
        b=mr43j2PIQqmg+p5DhXJoMsbI5QUdaAFx06s/35EkdiexYCTVMlFX0hP+aBIPegl7fI
         xoPr2DNjcFc1hwef+uw8YeiLD5YLOK95j3/QZCu7kBmFf7cXxVtDvDn8eREhqtLooArJ
         XgS5CyYNyq/hKAZHO5lDfN/Fftqkc8eJO+OnYEP6cYtM594D7152PlYtiZoHN5wSsgrm
         5XUfCMVAt1pz9aVfoxafBvvwr/yhkkuMnvWOC0tdzPshpr76IoQK4LHgtk2LuCWoUU15
         mSlTDzWOQG/AIRnz4V6Y5Au24HwvmNQiNrb4W+RjWJfYt1/qnHO18J0MjdqU53eJ0nmF
         IY1A==
X-Gm-Message-State: AGRZ1gII5dGzNdxzP2Vl5WGBwOQ+8cmlUHE/mPksW5iCX1Ce8bXq5+rm
        pZ00JA7LSjdQhgCDTyD/UIe+rx0E7Si6
X-Google-Smtp-Source: AJdET5cdaSuwV+FOUoETH9cKyXCqf0lnpCzcoei0avqwEbn0KPe4h7WDPKQS30w50ObQutqDmo51JfK+X8ie
X-Received: by 2002:ab0:3347:: with SMTP id h7mr9328345uap.4.1541808655352;
 Fri, 09 Nov 2018 16:10:55 -0800 (PST)
Date:   Fri,  9 Nov 2018 16:10:52 -0800
In-Reply-To: <20181108205255.193402-1-sbeller@google.com>
Message-Id: <20181110001052.101290-1-sbeller@google.com>
Mime-Version: 1.0
References: <20181108205255.193402-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
Subject: [PATCH] coccicheck: introduce 'pending' semantic patches
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        szeder.dev@gmail.com, martin.agren@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: SZEDER G=C3=A1bor <szeder.dev@gmail.com>

Teach `make coccicheck` to avoid patches named "*.pending.cocci" and
handle them separately in a new `make coccicheck-pending` instead.
This means that we can separate "critical" patches from "FYI" patches.
The former target can continue causing Travis to fail its static
analysis job, while the latter can let us keep an eye on ongoing
(pending) transitions without them causing too much fallout.

Document the intended use-cases around these two targets.
As the process around the pending patches is not yet fully explored,
leave that out.

Based-on-work-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

I dialed back on the workflow, as we may want to explore it first
before writing it down.

Stefan

 Makefile                  |  7 +++++--
 contrib/coccinelle/README | 41 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index bbfbb4292d..6bc4654828 100644
--- a/Makefile
+++ b/Makefile
@@ -2740,9 +2740,12 @@ endif
 	then \
 		echo '    ' SPATCH result: $@; \
 	fi
-coccicheck: $(addsuffix .patch,$(wildcard contrib/coccinelle/*.cocci))
+coccicheck: $(addsuffix .patch,$(filter-out %.pending.cocci,$(wildcard con=
trib/coccinelle/*.cocci)))
=20
-.PHONY: coccicheck
+# See contrib/coccinelle/README
+coccicheck-pending: $(addsuffix .patch,$(wildcard contrib/coccinelle/*.pen=
ding.cocci))
+
+.PHONY: coccicheck coccicheck-pending
=20
 ### Installation rules
=20
diff --git a/contrib/coccinelle/README b/contrib/coccinelle/README
index 9c2f8879c2..f0e80bd7f0 100644
--- a/contrib/coccinelle/README
+++ b/contrib/coccinelle/README
@@ -1,2 +1,43 @@
 This directory provides examples of Coccinelle (http://coccinelle.lip6.fr/=
)
 semantic patches that might be useful to developers.
+
+There are two types of semantic patches:
+
+ * Using the semantic transformation to check for bad patterns in the code=
;
+   The target 'make coccicheck' is designed to check for these patterns an=
d
+   it is expected that any resulting patch indicates a regression.
+   The patches resulting from 'make coccicheck' are small and infrequent,
+   so once they are found, they can be sent to the mailing list as per usu=
al.
+
+   Example for introducing new patterns:
+   67947c34ae (convert "hashcmp() !=3D 0" to "!hasheq()", 2018-08-28)
+   b84c783882 (fsck: s/++i > 1/i++/, 2018-10-24)
+
+   Example of fixes using this approach:
+   248f66ed8e (run-command: use strbuf_addstr() for adding a string to
+               a strbuf, 2018-03-25)
+   f919ffebed (Use MOVE_ARRAY, 2018-01-22)
+
+   These types of semantic patches are usually part of testing, c.f.
+   0860a7641b (travis-ci: fail if Coccinelle static analysis found somethi=
ng
+               to transform, 2018-07-23)
+
+ * Using semantic transformations in large scale refactorings throughout
+   the code base.
+
+   When applying the semantic patch into a real patch, sending it to the
+   mailing list in the usual way, such a patch would be expected to have a
+   lot of textual and semantic conflicts as such large scale refactorings
+   change function signatures that are used widely in the code base.
+   A textual conflict would arise if surrounding code near any call of suc=
h
+   function changes. A semantic conflict arises when other patch series in
+   flight introduce calls to such functions.
+
+   So to aid these large scale refactorings, semantic patches can be used.
+   However we do not want to store them in the same place as the checks fo=
r
+   bad patterns, as then automated builds would fail.
+   That is why semantic patches 'contrib/coccinelle/*.pending.cocci'
+   are ignored for checks, and can be applied using 'make coccicheck-pendi=
ng'.
+
+   This allows to expose plans of pending large scale refactorings without
+   impacting the bad pattern checks.
--=20
2.19.1.930.g4563a0d9d0-goog

