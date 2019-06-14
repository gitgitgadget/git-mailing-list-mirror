Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 988A71F462
	for <e@80x24.org>; Fri, 14 Jun 2019 10:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfFNKBJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 06:01:09 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33187 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfFNKBI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 06:01:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id h19so8529339wme.0
        for <git@vger.kernel.org>; Fri, 14 Jun 2019 03:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KTJ5+vSuR9YZlyLkl9AHl7yF18toOGAZIJZtMbWiQIY=;
        b=m6TqfNpVTBKY0TMTzjoNGw9KhFWHF1YLXOr1AoFo3bjTXkH+dWU95l0SxXYM2Kpbgm
         G/0EvYckQbJwFSTMPUIhul8ztr93KPz7QNPkr1vt6YplA8sXaQfcz4i9Nj0RqUKv3RX3
         4m67FzelnDVjolReuSctom1E7g3Etx9AlEzMhCoRYPWbaOqqI0AdwVusH34zbormjcL6
         E8IVE7iE7ndiNA3xLJkegBuLqTr6NrK/j4KyHq2RvWOWn1hfNjfZZjZCfvDN73+c9E8q
         BJTf8rBXBQ8GxeWgPe9Op1oSzVEFAZzdILrzvH7F5yziu1Wb+y/l7aO11ZH7M2r0dWcY
         vbiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KTJ5+vSuR9YZlyLkl9AHl7yF18toOGAZIJZtMbWiQIY=;
        b=AN1wR3GFdst0c7MliybIiVqHnytDgftKZXl8nCSReKfVw52Pz49G5SCDqmjjgc+ESZ
         16i2I+BBmHsEu1vX4NSSrJhDTmGYJcSxU1nroufFEMxQYDxmni87M9DgSQNz8x+eOti2
         VfbKM1iDDcl+yJCdhkB09rUg/+NYUKqPvwpPDqpjzr6ImxQ6UhmpE5gonXoRo15KBQIv
         hXY9gjVifFw7yW1CRNtw5yUcUiqgMvIMZ2W4+4A+dzGzW3Lx5GWUge8u+DcgtMJv445X
         aT3ZerdmAyb0A0POI2dlUNMwqqX1CMQg6fn489XOtDR9PSOcFUjor302+1rsJuvML6MD
         6TQw==
X-Gm-Message-State: APjAAAX0Dwe1iWTSKUQZyK4vjCH3U5vvEOAHjiRfMogwferquiGUoOA+
        JME+Lpg4VU67EAHAQu+6Zip6EUB9
X-Google-Smtp-Source: APXvYqzjHVKRQzdYIGoEjhvetRK1k8Of2LelKD7fcMS9LBN5ImONXjsreeiNWVA22cHATg5v7lzhaw==
X-Received: by 2002:a1c:9cd1:: with SMTP id f200mr6971293wme.157.1560506465820;
        Fri, 14 Jun 2019 03:01:05 -0700 (PDT)
Received: from localhost.localdomain (x4db35d93.dyn.telefonica.de. [77.179.93.147])
        by smtp.gmail.com with ESMTPSA id d3sm1986988wrs.8.2019.06.14.03.01.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Jun 2019 03:01:05 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v1 2/4] SQUASH??? compat/obstack: fix portability issues
Date:   Fri, 14 Jun 2019 12:00:57 +0200
Message-Id: <20190614100059.13540-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.22.0.589.g5bd7971b91
In-Reply-To: <20190614100059.13540-1-szeder.dev@gmail.com>
References: <20190614095308.GG31952@szeder.dev>
 <20190614100059.13540-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is sort-of a cherry-pick of d190a0875f (obstack: Fix portability
issues, 2011-08-28), which is necessary to make 'compat/obstack.c'
compile again.  Only "sort-of a cherry-pick", because the divergence
between upstream and our copy was just too bit and I gave up on the
conflict resolution, and instead made the still necessary/applicable
edits in the spirit of d190a0875f by hand.

With this patch 'compat/obstack.c' can be compiled with GCC both on
Linux and on macOS (well, at least in our 'osx-gcc' build job on
Travis CI), but, alas, not with Clang.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 compat/obstack.c | 29 ++++-------------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/compat/obstack.c b/compat/obstack.c
index 6949111e4d..17fa95d46c 100644
--- a/compat/obstack.c
+++ b/compat/obstack.c
@@ -16,13 +16,9 @@
    License along with the GNU C Library; if not, see
    <https://www.gnu.org/licenses/>.  */
 
-
-#ifdef _LIBC
-# include <obstack.h>
-#else
-# include <config.h>
-# include "obstack.h"
-#endif
+#include "git-compat-util.h"
+#include <gettext.h>
+#include "obstack.h"
 
 /* NOTE BEFORE MODIFYING THIS FILE: _OBSTACK_INTERFACE_VERSION in
    obstack.h must be incremented whenever callers compiled using an old
@@ -305,23 +301,6 @@ _obstack_memory_used (struct obstack *h)
 /* Define the error handler.  */
 #  include <stdio.h>
 
-/* Exit value used when 'print_and_abort' is used.  */
-#  ifdef _LIBC
-int obstack_exit_failure = EXIT_FAILURE;
-#  else
-#   include "exitfail.h"
-#   define obstack_exit_failure exit_failure
-#  endif
-
-#  ifdef _LIBC
-#   include <libintl.h>
-#  else
-#   include "gettext.h"
-#  endif
-#  ifndef _
-#   define _(msgid) gettext (msgid)
-#  endif
-
 #  ifdef _LIBC
 #   include <libio/iolibio.h>
 #  endif
@@ -339,7 +318,7 @@ print_and_abort (void)
 #  else
   fprintf (stderr, "%s\n", _("memory exhausted"));
 #  endif
-  exit (obstack_exit_failure);
+  exit (1);
 }
 
 /* The functions allocating more room by calling 'obstack_chunk_alloc'
-- 
2.22.0.589.g5bd7971b91

