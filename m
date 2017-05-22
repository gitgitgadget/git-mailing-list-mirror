Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 180331FF30
	for <e@80x24.org>; Mon, 22 May 2017 01:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757056AbdEVBd0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 May 2017 21:33:26 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36300 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756846AbdEVBdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 May 2017 21:33:25 -0400
Received: by mail-pf0-f193.google.com with SMTP id n23so16293505pfb.3
        for <git@vger.kernel.org>; Sun, 21 May 2017 18:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=IWeiqWruqQpsgZ+i1oxCQ6OwbV9Vvedr9zbR3Ayn4j4=;
        b=nslW1fcKeHAWscOwR8J52H67XymXlasRuKqhXcdARK7NoZlwBUhkTVZiETXPtXk4wb
         vKDTqkdPmhSmtZ9cXJOqIOqMDPhjnFBfy6XuHu3X+Be/Kz+srYtAdqqEqHxkTVcvugjy
         ODkDTAis3EHuTTyyfz71uojQoJI4Gz4egmRlSzX0WF/CX3Gu0s7uPQi1VRsKW1Yy0Qxp
         KHHicX1zyzcjMM7m0hHQbIYq59yhWZBqDkpuYsb+O2t1AxlXSehboBA6p+0j+Zy1Gdbr
         WaO1j3DHATC6IkxFkhxpdzn9eEqmKwFMc2B3RjRBDaUpOK3ZVM149AMO8ya12zQaX9+t
         AWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=IWeiqWruqQpsgZ+i1oxCQ6OwbV9Vvedr9zbR3Ayn4j4=;
        b=ioIbmMXQG6tmz5N+dGo8m9RcmclRSbbt6CkuaYIoZOIA886BUUDsficxsPvWDI8fZ0
         Z29u+k3woFn5BWJrB//NHrAgetnoas6N4f2XHGJdstVpjpbvFNcOdT4vUyU5i8hLxypg
         Uxm4L8P2gXlzxctIG1fD3P3eXNQEid35u11Ou9c3L465cR8XSmFTdsnrxOtz5Tq0ylkt
         Pdqxtom6+JFDDFeHaK5w6N6p+pShJWjurO1USoVPBHHXUSCKPq2tltUvUqQ3hQgc281M
         rl4+Reg4pCly9xV3U3Z7s6TcQEPcdB+nZsD9yHAW6tm83kZOAe1aN70PyqfTv3q9q/fx
         w0xA==
X-Gm-Message-State: AODbwcA+Y0rSXL4mpNfDcNGifbdQYvOdchLOjpBRZGL9w56X3PjumoqC
        wW72B8mpDGsWj7xSWJs=
X-Received: by 10.98.70.198 with SMTP id o67mr22078461pfi.79.1495416805007;
        Sun, 21 May 2017 18:33:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4439:f55c:c49b:d0dc])
        by smtp.gmail.com with ESMTPSA id c19sm24277641pgk.32.2017.05.21.18.33.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 21 May 2017 18:33:24 -0700 (PDT)
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
Date:   Mon, 22 May 2017 10:33:23 +0900
In-Reply-To: <20170520115429.12289-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 20 May 2017 11:54:29 +0000")
Message-ID: <xmqqtw4dptek.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> +# Define DC_SHA1_SUBMODULE in addition to DC_SHA1 to use the
> +# sha1collisiondetection shipped as a submodule instead of the
> +# non-submodule copy in sha1dc/. This is an experimental option used
> +# by the git project to migrate to using sha1collisiondetection as a
> +# submodule.
> +#

Yup, thanks.

I actually was envisioning something like this instead, though.

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

That way, a user can say "git submodule init/update" it to use it,
and deinit it to use the frozen version.

But when somebody (like me?) feels strongly enough, such a change
can always come on top of this patch, so let's have this
manual-configuration-only version as our first step.

Thanks.
