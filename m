Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFA2C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 16:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbiDMQFf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 12:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiDMQFe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 12:05:34 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F42353A5E
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 09:03:12 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id s25so2490446edi.13
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 09:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Ezk4V7lCb9QArHtzUIdJpOtX6aXc53EPYeeAttMvh0s=;
        b=fYlkmpAqqOMbxQ/NCs8SMazENyNqCUXGJTzRWAbnuMRlULnwgMRAwT07vr19erJ+wQ
         p6rCxSzHVg3g64KKewAe7P0grBctAf6XZ8DHd5uvLFAjpLFC8lMf+6kQPVl81m3oRaMA
         hQWt23PVHEj64HrASMkDiCi03MGYwxPuLI3BOsXiK+pbdHR9mHFY8xAlJZgyi/4ItrTQ
         ruW7ftU3PusuMLd4Jpzs5yJ1sOyi2npybXOk21jhziNXFTPVAaoakUAwSrWFuufcCCGi
         BPNAJNxogKziyezBnojQVvrq9fpdPeNOI2Hm1uhBCK/szs2MXZnyTszDNRd72oh1uEZ9
         RKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Ezk4V7lCb9QArHtzUIdJpOtX6aXc53EPYeeAttMvh0s=;
        b=6sKxn9MvePpbOz+amQvGFzga5FmCuKVSgPGxR3pefXvh4exDIHO0uZbiYg0873IE7X
         MfWF5Pih8zDqEsbsDgxSWN3CImdAgI0QUdm/MU3F5YMtaJQ62BI0mpJrcHy2q59avvK8
         ZLGWLOtvn/hSP1tzMAaICyuDo0is+S/C5YICYv+J2Zj1q+eTqf1xxT9c/9LeUKYBRBo4
         o4UU66H+7CerZUoSdZdR76FJCsS50HYwVfCEarbog0NhtREfRp2eqOJ4OWkwqYSr3W8Y
         hfqh8pcSh0PDm7nNovbjgtaaagJ3U0UAmxYxOVyI+fKVag0T+Ph5my+b4DN3sVXuZGye
         Ae7A==
X-Gm-Message-State: AOAM532QKUY5HNyxhiPzMObJE7xQ57jX8vlQLZqhjBYKfQ7pVdlc+eUF
        rhiOFs4mO1uKHUYcqEo2hLIYZS+1os4=
X-Google-Smtp-Source: ABdhPJxqz78hLXddmGfB/y/YV3Xq5HoGBc+F4gZw4rEs78PQERmpn69THV3M7zh7GblXQbiyawucAw==
X-Received: by 2002:a05:6402:7d3:b0:41d:9152:cad with SMTP id u19-20020a05640207d300b0041d91520cadmr9500154edy.370.1649865791147;
        Wed, 13 Apr 2022 09:03:11 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id l10-20020a170906938a00b006e88c811016sm115930ejx.145.2022.04.13.09.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 09:03:10 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nefSX-0058Qp-Tl;
        Wed, 13 Apr 2022 18:03:09 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 3/4] builtin/stash: provide a way to export stashes
 to a ref
Date:   Wed, 13 Apr 2022 17:55:23 +0200
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
 <20220407215352.3491567-1-sandals@crustytoothpaste.net>
 <20220407215352.3491567-4-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220407215352.3491567-4-sandals@crustytoothpaste.net>
Message-ID: <220413.86a6cpezsy.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 07 2022, brian m. carlson wrote:

> +	/*
> +	 * This is an arbitrary, fixed date, specifically the one used by git
> +	 * format-patch.  The goal is merely to produce reproducible output.
> +	 */
> +	prepare_fallback_ident("git stash", "git@stash");
> +	author = fmt_ident("git stash", "git@stash", WANT_BLANK_IDENT,
> +			   "2001-09-17T00:00:00Z", 0);
> +	committer = fmt_ident("git stash", "git@stash", WANT_BLANK_IDENT,
> +			      "2001-09-17T00:00:00Z", 0);

Hrm, reproducable with what? Because you're doing this we won't get a
different OID every time you do:

    git stash export --print

That part I'm completely on board with, but not pick the author/date
from the tip of the stash we're exporting instead?

AFAICT the only negative side-effect of that is that we'll create
another such "base" commit for every stash we export, which is a bit of
garbage churn.

But I think it's worth it to not create magical author/committer entries
with nonsensical dates.
