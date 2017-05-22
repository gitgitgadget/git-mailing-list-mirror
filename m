Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C3D31FF30
	for <e@80x24.org>; Mon, 22 May 2017 02:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932794AbdEVCsE (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 May 2017 22:48:04 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36481 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932173AbdEVCsC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 May 2017 22:48:02 -0400
Received: by mail-pf0-f195.google.com with SMTP id n23so16621937pfb.3
        for <git@vger.kernel.org>; Sun, 21 May 2017 19:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vmyusrsClTGpBpIBZ4+W+gmlUll2slOjzfSwjgwE5XA=;
        b=glUK0YJdnaZ2JNEIyQ2Cma5f2uuJ8tyl1LTfDZ4PN8uUWKX4Ekg2rW0y1+i4qaufSQ
         SfFqWCB3H2tZQMEfHDZwVddFKP69a+Q4ZEf5laxyZOYhzYbt90R9KlsYZFjfC8FuXhwC
         0Au1F6xFeHF9ZUmb/u5TFnRCqtTlCoILzJm5/02IcIJQjLj9asujXLoFwy4PNte/r/Tw
         iMCPhjKfE19MkFylaR5BjCKmr4VSZqfY9FZoqL0QEgZ+MRgcqe417hKIbIQ0AnFbvNwo
         fH0BupXBTLTzngxcNd7rbf4dFDMGu2xJpEdZr/W4ysryrph9SsukcOdDm0iJXe6G+L51
         KpnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vmyusrsClTGpBpIBZ4+W+gmlUll2slOjzfSwjgwE5XA=;
        b=XURDGdd6I2E13PVRIGQl5UyMCsSETxhsK3TUMr25L7G0nQi7BFJP2A7U+FcVVxtyPS
         IenQgTK1LsExfgqRq69ss0o5eSNfyEJAgmT4LrtvO7kpahqtfzjYm8lZYQuwaRkc54wX
         sA8byNeJjtojo3Xt45Tf7pW/j/G5L+tV9hRi8jed675MiP93GAex3nw28yIWtb9N19jn
         QbrCdooFfnOECKAzGS3IF9sGOAoK9DOujponZYezHs/WgXKbVH10HNjAYsMPKaS5NNto
         NOsq9EzW56gxtjwRUpKJ00/OVAly9M7MJ+JxxRQZoaLmRwd3gO2brS7h1hEJhpLJeBj5
         lpCQ==
X-Gm-Message-State: AODbwcB7ElLxvrS8GMhwG8Z3h5S7KgQX0ZgpmBVAQg0fOcPLdLNxfeE0
        /DRCHmsfppNHDg==
X-Received: by 10.84.217.222 with SMTP id d30mr26439826plj.156.1495421282314;
        Sun, 21 May 2017 19:48:02 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4439:f55c:c49b:d0dc])
        by smtp.gmail.com with ESMTPSA id b65sm4369550pfl.48.2017.05.21.19.48.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 21 May 2017 19:48:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Marc Stevens <marc@marc-stevens.nl>,
        Michael Kebe <michael.kebe@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v2 2/2] sha1dc: optionally use sha1collisiondetection as a submodule
References: <20170520115429.12289-1-avarab@gmail.com>
        <xmqqpof3srw4.fsf@gitster.mtv.corp.google.com>
        <20170520115429.12289-3-avarab@gmail.com>
        <xmqqtw4dptek.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 22 May 2017 11:48:01 +0900
In-Reply-To: <xmqqtw4dptek.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 22 May 2017 10:33:23 +0900")
Message-ID: <xmqq7f19ppy6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> But when somebody (like me?) feels strongly enough, such a change
> can always come on top of this patch, so let's have this
> manual-configuration-only version as our first step.

Just so that I have something I can come back to, here it is with a
log message.

-- >8 --
Subject: [PATCH] sha1collisiondetection: automatically enable when submodule is populated

If a user wants to experiment with the version of collision
detecting sha1 from the submodule, the user needed to not just
populate the submodule but also needed to turn the knob.

A Makefile trick is easy enough to do so, so let's do this.  When
somebody with a copy of the submodule populated wants not to use it,
that can be done by overriding it in config.mak or from the command
line, e.g. "make DC_SHA1_SUBMODULE= all".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index 6baad1669e..8d33936a12 100644
--- a/Makefile
+++ b/Makefile
@@ -989,6 +989,10 @@ EXTLIBS =
 
 GIT_USER_AGENT = git/$(GIT_VERSION)
 
+ifeq ($(wildcard sha1collisiondetection/lib/sha1.h),sha1collisiondetection/lib/sha1.h)
+DC_SHA1_SUBMODULE = auto
+endif
+
 include config.mak.uname
 -include config.mak.autogen
 -include config.mak
-- 
2.13.0-440-g3ce6d2d5b8

