Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A972C433DF
	for <git@archiver.kernel.org>; Thu, 21 May 2020 02:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E20982070A
	for <git@archiver.kernel.org>; Thu, 21 May 2020 02:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3TBwTKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgEUCPh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 22:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbgEUCPg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 22:15:36 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFCBC061A0E
        for <git@vger.kernel.org>; Wed, 20 May 2020 19:15:36 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x18so1065060pll.6
        for <git@vger.kernel.org>; Wed, 20 May 2020 19:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iGUrq94kbqJ//hvyppHZ+VUuAGisLZb5N9UpGJLpAAs=;
        b=M3TBwTKjaPphCK+0Wfz/sb+ObJRycKCkK3bG0Hgqbn++UtaCd7G9hxmbZGiiFWkvSS
         V722bL59z4d/o/x+65WTzYC/OeAOdFghf/Kf0464stFexyOveAHC9bqcq+KkprYA/Xmo
         bsIJabjGILMq8STXqL2CNhmv6Zq3KoYetXhLO4MnS+0UpfMh5OXXCAL6Kyw38Ux5RD+j
         pDFoJFIJaee51DJSzAMGWXaGNkt73OsBmj9FpKmqlDYl46YwopxCpAjoXWMt99Ug/9lA
         k4cI+BYfamdo01hg/JhN+aLOtROqg7CfVqAn+KTvI7ZTTz4GvXbz1GErOtTbINSbxAcK
         9FJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iGUrq94kbqJ//hvyppHZ+VUuAGisLZb5N9UpGJLpAAs=;
        b=B0JAOHsYSalTrUh59ZxF8GkwhmWZoeg/ley3bdlStf7k2aQlvWaMfcV00gwJqffVMM
         OXFZVMdpOaYofgOMZr7HWqmJ7aLNXRLGziuWgh6YVOeBgvQjNSNcISffJh1ACFUSRzAY
         oKhu7gR0PyAA2ZLCjuMEnbCTyg4cpdGu1RqJiamNrjEoaujgWUjMw6pU5de2dQhXBaDB
         l8QpMfy122DTJcQpH2c2lF76Ysn4FI5zl4ybMDW93kdr3rPi4UBzV5IJ/3DoplGQFEmw
         jeaJx47Ym4i5UUKVPd8zPKX//mEUwVhc7BwmfN7eobqCdV9KCMib46Sk5lRX9DvRcSbO
         c0XQ==
X-Gm-Message-State: AOAM532CAw/reZYGP+c27Yo1Qd//3ovFQGTYaGunS2cPKVyAh5B6Pbxs
        me1JD31lnOKl5EVDgZueyb0=
X-Google-Smtp-Source: ABdhPJwbStZ4Zb8nfDf+6TFoM1DEfKkWsZkR9TZjAa9vxiGNsERV/uekDeZZ1zvbBqzFRLdl7fhDXg==
X-Received: by 2002:a17:902:32b:: with SMTP id 40mr7207934pld.73.1590027335959;
        Wed, 20 May 2020 19:15:35 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id w69sm3309368pff.168.2020.05.20.19.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 19:15:35 -0700 (PDT)
Date:   Wed, 20 May 2020 19:15:33 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: Protocol v2 in v2.27 (Re: Re* [ANNOUNCE] Git v2.27.0-rc1)
Message-ID: <20200521021533.GC3648@google.com>
References: <xmqqsgfuv2ko.fsf@gitster.c.googlers.com>
 <20200520193156.GA4700@coredump.intra.peff.net>
 <xmqq5zcquz4t.fsf_-_@gitster.c.googlers.com>
 <20200520220023.GB3648@google.com>
 <xmqqlflmtaxq.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlflmtaxq.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Speaking of which, should we enable protocol v2 by default for people
>> with feature.experimental enabled, like this?
>
> It is an excellent idea, but is something that had to have been
> proposed before -rc0 to be in the upcoming release, no?

I would love to go back in time, but I only have the present to work
with.  Here, I'm hoping it makes the switch of default back to v0 less
of a regression for some interested users.

> The patch looks good; do we have the master list of things that are
> under control of feature.experimental knob in the documentation, or
> is it a feature that we do not have to have a centralized control?

Good catch.  Here's an updated patch with (1) a commit message and (2)
that doc update.

-- >8 --
Subject: config: let feature.experimental imply protocol.version=2

Git 2.26 used protocol v2 as its default protocol, but soon after
release, users noticed that the protocol v2 negotiation code was prone
to fail when fetching from some remotes that are far ahead of others
(such as linux-next.git versus Linus's linux.git).  That has been
fixed by 0b07eecf6ed (Merge branch 'jt/v2-fetch-nego-fix',
2020-05-01), but to be cautious, we are using protocol v0 as the
default in 2.27 to buy some time for any other unanticipated issues to
surface.

To that end, let's ensure that users requesting the bleeding edge
using the feature.experimental flag *do* get protocol v2.  This way,
we can gain experience with a wider audience for the new protocol
version and be more confident when it is time to enable it by default
for all users in some future Git version.

Implementation note: this isn't with the rest of the
feature.experimental options in repo-settings.c because those are tied
to a repository object, whereas this code path is used for operations
like "git ls-remote" that do not require a repository.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks,
Jonathan

 Documentation/config/feature.txt  | 4 ++++
 Documentation/config/protocol.txt | 3 ++-
 protocol.c                        | 4 ++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/feature.txt b/Documentation/config/feature.txt
index 4e3a5c0cebc..28c33602d52 100644
--- a/Documentation/config/feature.txt
+++ b/Documentation/config/feature.txt
@@ -22,6 +22,10 @@ existing commit-graph file(s). Occasionally, these files will merge and the
 write may take longer. Having an updated commit-graph file helps performance
 of many Git commands, including `git merge-base`, `git push -f`, and
 `git log --graph`.
++
+* `protocol.version=2` speeds up fetches from repositories with many refs by
+allowing the client to specify which refs to list before the server lists
+them.
 
 feature.manyFiles::
 	Enable config options that optimize for repos with many files in the
diff --git a/Documentation/config/protocol.txt b/Documentation/config/protocol.txt
index 0b40141613e..c46e9b3d00a 100644
--- a/Documentation/config/protocol.txt
+++ b/Documentation/config/protocol.txt
@@ -48,7 +48,8 @@ protocol.version::
 	If set, clients will attempt to communicate with a server
 	using the specified protocol version.  If the server does
 	not support it, communication falls back to version 0.
-	If unset, the default is `0`.
+	If unset, the default is `0`, unless `feature.experimental`
+	is enabled, in which case the default is `2`.
 	Supported versions:
 +
 --
diff --git a/protocol.c b/protocol.c
index d390391ebac..d1dd3424bba 100644
--- a/protocol.c
+++ b/protocol.c
@@ -17,6 +17,7 @@ static enum protocol_version parse_protocol_version(const char *value)
 enum protocol_version get_protocol_version_config(void)
 {
 	const char *value;
+	int val;
 	const char *git_test_k = "GIT_TEST_PROTOCOL_VERSION";
 	const char *git_test_v;
 
@@ -30,6 +31,9 @@ enum protocol_version get_protocol_version_config(void)
 		return version;
 	}
 
+	if (!git_config_get_bool("feature.experimental", &val) && val)
+		return protocol_v2;
+
 	git_test_v = getenv(git_test_k);
 	if (git_test_v && *git_test_v) {
 		enum protocol_version env = parse_protocol_version(git_test_v);
-- 
2.27.0.rc0.183.gde8f92d652

