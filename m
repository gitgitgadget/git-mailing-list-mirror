Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A84C433F5
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 03:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241272AbiBSDvu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 22:51:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235431AbiBSDvt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 22:51:49 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CA13F89D
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 19:51:29 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id h9so18683205qvm.0
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 19:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=oCaJlbNJqKfANTaWA2yTErbn5Gd2yxZo8AVq3AVrZtw=;
        b=ZSsRf7XT0OVy8tHz8qjDJdtzom/Q1UcahcnCultUL82knT1Fvsdg2uQVmaTnUU1b89
         3ElkaHUfx6ufuUJyKyVZ029SETtkONBAVksTHVMi2JXthtOc/9Zqv2GCvBlQfAM0Yavb
         4GZNf/2DZ3ANT+U9jfD5zchlONRZ68o03oa4TAd88luiLSu08vRwYvOxsZKrf2CLILw1
         vBps5BbnyDNY/Q2yitjHSApcWFOY0XBibF2r75NDTz+T4WMzVrzpCkhfI6JVWGDlkH5h
         fsSyaMN7KvYU+X/wIKMtHy2TZ2KwHFUg2ymGy2HuWBCaIrkT2KMq++F6D6iMrAfk7jPq
         xbuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=oCaJlbNJqKfANTaWA2yTErbn5Gd2yxZo8AVq3AVrZtw=;
        b=NFLTnxBkKWjkIbGArfmuzazknWe81wetpiqs3ZFQxciAPJGH5qAhWFD0CjSITLIa1A
         /LqXrZc/9Zifaey3P6FQTdx9+jbN0bLVUc47wr0im4fUAFeqO/AHEv7baN5E2ttP9mAW
         Z89lRG34GTUeyR9EMht1B8FccIzAZSrVDzzqPaNHMUaN0RnLFj9WgyxlIEL/xfP69B3r
         nStdh/ObvEiwvMZz+O61dLo0ccKpF3wr/5FA06BCqAHEJTeLq+1hHRUh5xn1dS3XN/i5
         nshCIgxX4je/+lyaw2l4vr+tQbq6eMPdWCzUWSB2+lFgTTDEQRBHEwbX/DmaBIO3K8ER
         apCw==
X-Gm-Message-State: AOAM532DOxD8L0n04EflPojqFf7BkXfKcKvzV6eIMllk02CdMPGHZRBF
        Djoto+uuOGTY49K+/s4uIBvQpbcEbMF3bQ==
X-Google-Smtp-Source: ABdhPJwXAl7/8ztxKGAgjoVsdePjkOmdLB+sj+RGyASAiH7HDPVxnXYbfL8Rc7qmubNxmYVN1K8u/w==
X-Received: by 2002:a05:622a:13ca:b0:2dc:4f1:fafd with SMTP id p10-20020a05622a13ca00b002dc04f1fafdmr9644466qtk.423.1645242688491;
        Fri, 18 Feb 2022 19:51:28 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u17sm23544094qkp.90.2022.02.18.19.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 19:51:28 -0800 (PST)
Date:   Fri, 18 Feb 2022 22:51:27 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/4] test-lib: add XSAN_OPTIONS, inherit [AL]SAN_OPTIONS
Message-ID: <YhBpP0idXDB2a0Sy@nand.local>
References: <cover-0.4-00000000000-20220218T205753Z-avarab@gmail.com>
 <patch-1.4-75c8f7a719c-20220218T205753Z-avarab@gmail.com>
 <xmqqley7yd6e.fsf@gitster.g>
 <YhBY8oD/xJZUQsj9@nand.local>
 <220219.86ley7fu3k.gmgdl@evledraar.gmail.com>
 <YhBclvZUYcsTabye@nand.local>
 <220219.86czjjftde.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220219.86czjjftde.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 19, 2022 at 04:02:23AM +0100, Ævar Arnfjörð Bjarmason wrote:
> Once you get to tweaking some more advanced options it makes sense to
> share a lot for both. One change I have locally on top of this is e.g.:

Makes sense. I run the tests with sanitization quite often, but rarely
use any fanciful options like you.

Thanks,
Taylor
