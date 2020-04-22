Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B744C55185
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 15:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE53F2076E
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 15:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pz3fEqsn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgDVPuv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 11:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbgDVPuv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 11:50:51 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E538C03C1A9
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 08:50:51 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id n16so1282809pgb.7
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 08:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/0Z+6j0wSkJBclu0bbq/7wMOa5ogo/wg2EOvykcddRY=;
        b=pz3fEqsnM9Uo4Hs19cCstKkRr50vT2eU1mKjsX9v0vq19WlzvTEO+weRwlWsmPkA08
         m56nWeThONkLovja4nWKLZCMGuchFGlOPwe5BlBkLXaWglZe/p3GVKJIKO9DDgbReRCw
         2/Nah+2WkBRVbaIjw19r8cWvSLVR+3+KLY291d6AHCSXe038RbM33dBc/fmtuR0XzVOh
         VRK5wHLtzQ0Quaj+s8pITCBNtFIr5oDkX7TLm8nmswfW1RC7PISREI7f6gQO84gWBTK3
         7Wx0cfdb67BDTWuBiQY7fsh4uQ1bzJvIEjWBNSXr4laZN+V+D+KAHnKweiz7xQ8/6p/6
         zxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/0Z+6j0wSkJBclu0bbq/7wMOa5ogo/wg2EOvykcddRY=;
        b=j6vVHcMW2C95vhvL5SbvlNcmRB526qBFlKDu6kumC7Ig7ClhnF+TVVL9b18lMCowZS
         ZtnPTviRGUb5Tn1QY6VQk+ip8CKq7x8hbge7JpHqTDyhixdqYVSybG29HfdP5PUPrAMt
         yw/KRkegiq9E5DiGpbkZrMP+irhb+nRZ6LGK4rvkjhowifCZkDRmD6DI/NdyzmW88sCo
         gAcAIz5/Ytl2RrCNcP57i8JauH2zJAn7phL8xZLbhdIGAXWngbLbrqtHOfiPcchZi9/6
         DvGdiuKGypl7zDmFtP+6w1NURFGnyfWSfAflM6ERA9Jcn0z8jUuApl6yJ+xbziWx/KKQ
         DX+g==
X-Gm-Message-State: AGi0PuYa5OPqD/+3NA3L3S5qwitkzQ+fCj7pCwXcS4ZvePukqvMDICnB
        irtQqWAqcHsgtl8taSpdMVY=
X-Google-Smtp-Source: APiQypLjdCjJMCovRiXKWP0dA7Tmyags+D1eOSWGzHXwmeTCgyUws9VLGY9hySxARHnchYK58aFddw==
X-Received: by 2002:a62:7bc3:: with SMTP id w186mr2882824pfc.295.1587570650743;
        Wed, 22 Apr 2020 08:50:50 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id m14sm5383270pgk.56.2020.04.22.08.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 08:50:49 -0700 (PDT)
Date:   Wed, 22 Apr 2020 08:50:47 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Lubomir Rintel <lkundrak@v3.sk>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>,
        "Dixit, Ashutosh" <ashutosh.dixit@intel.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Revert "fetch: default to protocol version 2"
Message-ID: <20200422155047.GB91734@google.com>
References: <20200422084254.GA27502@furthur.local>
 <20200422095702.GA475060@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422095702.GA475060@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This reverts commit 684ceae32dae726c6a5c693b257b156926aba8b7.

Users fetching from linux-next and other kernel remotes are reporting
that the limited ref advertisement causes negotiation to reach
MAX_IN_VAIN, resulting in too-large fetches.

Reported-by: Lubomir Rintel <lkundrak@v3.sk>
Reported-by: "Dixit, Ashutosh" <ashutosh.dixit@intel.com>
Reported-by: Jiri Slaby <jslaby@suse.cz>
Reported-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi again,

Jeff King wrote:

> Thanks for this report. We've been tracking the issue but have had
> trouble reproducing it.
>
> To get you unstuck, the immediate workaround is to drop back to the
> older protocol, like:
>
>   git -c protocol.version=0 fetch --all

By the way, I'd recommend the immediate workaround of

	git fetch --negotiation-tip=refs/remotes/xo/* xo

instead.  But that's a separate subject.

[...]
> There are a few data points we've been wanting to collect:
[...]
> I'm attaching for-each-ref output before and after the xo fetch. That
> should be sufficient to recreate the situation synthetically even once
> these repos have moved on.

Excellent --- I think this is enough for us to have something to use
to investigate, switching users to protocol v0 in the meantime.

Thanks,
Jonathan

 Documentation/config/protocol.txt | 2 +-
 protocol.c                        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/protocol.txt b/Documentation/config/protocol.txt
index 756591d77b0..0b40141613e 100644
--- a/Documentation/config/protocol.txt
+++ b/Documentation/config/protocol.txt
@@ -48,7 +48,7 @@ protocol.version::
 	If set, clients will attempt to communicate with a server
 	using the specified protocol version.  If the server does
 	not support it, communication falls back to version 0.
-	If unset, the default is `2`.
+	If unset, the default is `0`.
 	Supported versions:
 +
 --
diff --git a/protocol.c b/protocol.c
index 803bef5c87e..d390391ebac 100644
--- a/protocol.c
+++ b/protocol.c
@@ -39,7 +39,7 @@ enum protocol_version get_protocol_version_config(void)
 		return env;
 	}
 
-	return protocol_v2;
+	return protocol_v0;
 }
 
 enum protocol_version determine_protocol_version_server(void)
-- 
2.26.2.303.gf8c07b1a785

