Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 729FF20954
	for <e@80x24.org>; Wed, 22 Nov 2017 23:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751673AbdKVXpg (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 18:45:36 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:34623 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751559AbdKVXpf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 18:45:35 -0500
Received: by mail-it0-f67.google.com with SMTP id m11so11042960iti.1
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 15:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NvyCqgZ/l/lLmbDMSWMe7cWXlKiG4J6+NaV+FQ1n5qo=;
        b=KrDWutW5PFc9ypVVMD9MJOtbRdS1/MM5eRnxN+++TZ5u1wguC1jGHLxCHXaivcvdJm
         tWVeofGy4e0CrxXAtTJVWW1/Rqoy/3GgTwvFXchDy+ZosLdSHnAJg5ZLip15M3ZsMqbA
         9JtR5Ny56ELuXWkoIsFkgZA/HhnFxLvEeMsGcnGr1f4uIKyrSOgxecuzQOIRotPXcMHy
         a92ek8IB94fGGJxERAtG0Go270PiCYYQJgsZmL0r9333Lhjr/o4DmS3v26IbHZVr3xW8
         ODWXKmZQjPBeJdlG2L/GGdEucHsk3FfI85cHUYWztm9RtLzc+6BKJkRoii//8mehnyVQ
         PMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NvyCqgZ/l/lLmbDMSWMe7cWXlKiG4J6+NaV+FQ1n5qo=;
        b=H4IKF+kngByaBoC1dEYSKOlQ0zZ63mi/D9VO1R7EirNztC9RWM/Ow7IoSyzV6KyG4z
         eHSiNgTNxUBnhwei5K+vAIfnv2OY4ToQ0pJApn2gHPL/Sa7IUq7e3LEjeyixpzAs8uTg
         RhNax4LsIC6l7pQolm9glPSkwEH+kqvWUpVo9175vy7g1xGlLYKKZBZuXUZSqkWaDklh
         U0+yf3y4qVYX3DLFRbPmEtrjcuDhranCL4MxFW+p1yg36WR12rzsonXziq27Sv++kTqa
         kTP0CJmteD6uV9gj/QnIT/Px+rMpenpludsvWCOvcfIQxwap1n2GCDb/1KPCJ/mKyZn9
         7u4g==
X-Gm-Message-State: AJaThX7r6KuDrhZ2lzVMjHmsDu22n/CdG/CvzeVF2FCk6VYgO/lJOLBt
        2Wwpr+euk1tBYERyx7bR6N7sspqj
X-Google-Smtp-Source: AGs4zMZL3aNIypH0lCFMCk4YYD4qj5K74OBfQR6fXl/21wR7zbEqUq4oroWUZGLRNHrrxNsqxezCSw==
X-Received: by 10.36.254.71 with SMTP id w68mr9075647ith.24.1511394334534;
        Wed, 22 Nov 2017 15:45:34 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id v19sm2638169ite.4.2017.11.22.15.45.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Nov 2017 15:45:34 -0800 (PST)
Date:   Wed, 22 Nov 2017 15:45:32 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        git@jeffhostetler.com
Subject: Re: [PATCH 0/3] Introduce BUG_ON(cond, msg) MACRO
Message-ID: <20171122234532.GI11671@aiede.mtv.corp.google.com>
References: <20171122223827.26773-1-sbeller@google.com>
 <20171122232457.GA8577@sigill>
 <20171122232814.GH11671@aiede.mtv.corp.google.com>
 <20171122233905.GC8577@sigill>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171122233905.GC8577@sigill>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> Yes. I'd be fine having a single-argument BUG_ON() like that. But then,
> I'm not sure what it's buying us over assert().

It lets you build with NDEBUG.  It also goes through our own die()
handler, which means that e.g. the error message gets propagated over
remote transports.

Please please please, don't rely on side-effects from assert().  They
will cause me to run into pain over time.  This issue alone might be
worth banning use of assert() in the codebase, if we can't trust
reviewers to catch problematic examples (fortunately reviewers have
been pretty good about that so far, but banning it would free up their
attention to focus on other aspects of a patch).

Jonathan
