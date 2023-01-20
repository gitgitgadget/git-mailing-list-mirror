Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC87C05027
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 19:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjATTlk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 14:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjATTlj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 14:41:39 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1468E78567
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 11:41:37 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id z3so4772645pfb.2
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 11:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QAWcgsmCfqMjEeqZ3B/EqQHLG5xKIsOI9tJR35mNhTE=;
        b=bJ1KpyJ6wSij7qpAAZ2y+NuaAhFJ6yNl/jKLnysuennPhbdG5T3h/otUQCbHBexK+b
         S7kpoBD9RKwKxvmcsIFy1DGT/q2lLdJOLT+zVv2SRwRJiGmvkNrcQHG7FWLxgObUqhMl
         FI0R581Kz6eZNpwhwwrbzE8E4iDwVA3Ue1+AhmIbrIZa+mV1ZrJVY7TVahDRIkE0pm0r
         +4haNMRPzZLIPbVBFNtdh2uPOlnIY9R0JmEoAXX2fSpJ37HyMP8QIfQwYEdg0voflbaG
         kB3QCMEs5kov16F4JO4E6j/7YdcbFpby9Xp4oliZDcIgi3HR9SyfcQxKhrrHkIoXfZ1r
         pbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QAWcgsmCfqMjEeqZ3B/EqQHLG5xKIsOI9tJR35mNhTE=;
        b=5SlMmTt9lEWB8Ck1sZlL8LHN6CN3Uu6NxA6bZ3dh8ImSejslqNDu9IIQa5jehei8AC
         P2tMpYimqnFy0Tl5psQmSP1aHC3BDeT+tZE/ZLCp1sc1EuDoWt0FGnC5EasLQ65wtQh3
         ZJmkoJAn7ntOA37cOdJe1otC82+3BxB/UG/4R1lNdZfooxX+mBNzl50dPSGlHufFY10A
         SS9IyCTDht8f5SSqaSTsL8al3rrOxbTfPBo5Cq9OdICvobxx4xx78Ia8idHPmjiH0pES
         tYdNZYfmfmn54kacaAJTXcZ/cpcG6RzxssBZU5BVPvaHm9KwcJGtTjcptLzX55F2QH9H
         BLow==
X-Gm-Message-State: AFqh2koNLIYbEiz6a+FCWxvJDmNn/HeW8BcRW3eKPE0o32fbVzWAMy7d
        DVYdeq8U73RYmDKMTYnoon4=
X-Google-Smtp-Source: AMrXdXue26fmMQATig+G6Cx6XwjKohneb1+BjFBCeZpfV7AghqJFEzWBTueYVtG3CSbaBxRJsYyyfw==
X-Received: by 2002:a05:6a00:438b:b0:588:441:d0d3 with SMTP id bt11-20020a056a00438b00b005880441d0d3mr17098488pfb.23.1674243696402;
        Fri, 20 Jan 2023 11:41:36 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id u197-20020a6279ce000000b005855d204fd8sm26479782pfc.93.2023.01.20.11.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 11:41:35 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH] Makefile: suppress annotated leaks with certain ASan
 options
References: <b1efe56ab5193d5505ccb9334f7d15e1795c27fb.1674240261.git.me@ttaylorr.com>
Date:   Fri, 20 Jan 2023 11:41:35 -0800
In-Reply-To: <b1efe56ab5193d5505ccb9334f7d15e1795c27fb.1674240261.git.me@ttaylorr.com>
        (Taylor Blau's message of "Fri, 20 Jan 2023 13:46:16 -0500")
Message-ID: <xmqqsfg5vvrk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> However, it is possible to use the leak sanitizer without
> `SANITIZE=leak`. This happens when building with `SANITIZE=address` and
> enabling the leak sanitizer via the `ASAN_OPTIONS` variable (by
> including the string "detect_leaks=1").

Yuck.  I cannot tell if this falls into "don't do it then if it
hurts" or pretty common thing people do that is worth helping.

> Making it possible to rely on `UNLEAK()` when implicitly using the leak
> checker via SANITIZE=address builds.

But as long as you did all the work, sure, why not ;-).

> I found this while playing around with GitHub's ASan-enabled CI builds
> for our internal fork following a merge with v2.38.3.
>
> The check-chainlint recipe in t/Makefile started using "git diff" via
> d00113ec34 (t/Makefile: apply chainlint.pl to existing self-tests,
> 2022-09-01), which triggered a leak in some of GitHub's custom code. I
> was surprised when marking the variable with UNLEAK() didn't do the
> trick, and ended up down this rabbit hole ;-).

Thanks.  Will queue.
