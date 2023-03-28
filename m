Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F0FC6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 13:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjC1Nrs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 09:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjC1Nrq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 09:47:46 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04225271
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 06:47:43 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id l7so10842707pjg.5
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 06:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680011263;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=NrFsBlEa9k2OqvYk/TZCvz1BKhWdrurY+1w44uyHcI0=;
        b=OahCnm/58d+AOIqpwV+kd1Z3yBqAFfcpxFRBHdSY8fsy5H3jZlgMg8jbd7hi9faRrT
         ehdiNI+kcprV3c/jQxA/62AlNQyE4xz/okNNze4htv6ocd2hIgAhZN8zAZi4Q3smPSUa
         suPBxUXGg2DpSd9YaGdHnu6ADzSVotgez2jLqbtXMf6sJGETFkoNkIDQZwgP6Lo2kcAt
         sCasLgM6okaZ8ixhloTHxeGHJ/jzHXGF8WYngPlvbqc0z/5s05aOLuYenuuIkjTb+6D4
         EdlX2avwoAEOypK0tBBBmukRotY4r20Fz8GOru8o/itTrA40UeGv99511qreSstRm/2/
         8kIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680011263;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NrFsBlEa9k2OqvYk/TZCvz1BKhWdrurY+1w44uyHcI0=;
        b=qrdG7sLWBaZ0abwYptz6kI+kXtos5ZESWn//Epu+kZliUN6zYEdrZp+ciQ9kt0FgX8
         YLZoh/iccbd9WXp1xeIAwCgUvubYrp/HWsPYyvl8IjihFkO8eqXsGhKhdlE3t0gEOwBJ
         JD3sjGASznimeWUkuY38jFoFYHQf/7wCYnvorktJZGWgJExMHEe+GMrb2IY9WUoPW71F
         OtHemggTHmkzPmHlV5fLhx/7jt5yN5wxxWgRu5gkYJvCTLeGzwEkLCOWxwAudWjQeHhE
         jataDjzD21Q8rGmqAKV9ROewWwdPBoygPAr9fqJ7FtvGh1z15PLpqQE7BiMkPs2QdPNC
         Y1/A==
X-Gm-Message-State: AO0yUKVjsmdndP32TS99t5kA6RCTy/BoGsTe+fPomQKpRfb/OW90U8Om
        wnU12jcqgpj45adhe8nle/c=
X-Google-Smtp-Source: AK7set9IoMImSqGW3Lxbs41noV56sNjdQtWoc8Ix54bp+SM5CzLtgy89ZDVBVsLdjatvx3OkE/Rntg==
X-Received: by 2002:a05:6a20:2921:b0:d3:84ca:11b with SMTP id t33-20020a056a20292100b000d384ca011bmr13129029pzf.40.1680011263021;
        Tue, 28 Mar 2023 06:47:43 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id x8-20020aa79188000000b0062622ae3648sm20968372pfa.78.2023.03.28.06.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 06:47:42 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Mario Grgic <mario_grgic@hotmail.com>,
        demerphq <demerphq@gmail.com>, git@vger.kernel.org
Subject: Re: git bug: Perl compatible regular expressions do not work as
 expected
References: <MW4PR20MB5517583CBEEF34B1E87CCF1290859@MW4PR20MB5517.namprd20.prod.outlook.com>
        <CANgJU+Vn8ZLGcAYbuDeNkv6T5YdX6t20BqGQDPB0VL_TzoGSWg@mail.gmail.com>
        <MW4PR20MB5517888E63C13099E284B97590859@MW4PR20MB5517.namprd20.prod.outlook.com>
        <eba23dc4-c036-fd1b-a1f0-028e8fff602b@web.de>
        <xmqqh6u6cg4l.fsf@gitster.g>
        <03fd7ddb-8241-1a0a-3e82-d8083e4ce0f7@web.de>
        <xmqqjzz1nalp.fsf@gitster.g>
Date:   Tue, 28 Mar 2023 06:47:41 -0700
Message-ID: <xmqqsfdpj8ci.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I suspect that 54463d32ef was done in a conservative way to avoid
> unintended side effects to make ERE "enhanced".  I am not 100%
> certain, but after reading the documentation you pointed at, I do
> not see a valid expression without ENHANCED flag starting to mean
> totally different thing with it (well, an extra '?' turning a
> pattern from greedy to minimal may count as such a change in
> semantics, but I do not see anybody sensible adding an extra '?'
> in a pattern in the first place).

Sorry, but that is nonsense.  We cannot avoid being backward
incompatible if we suddenly flip the "enhanced" bit for BRE.  A
sane pattern written expecting non-enhanced BRE can change its
meaning when the "enhanced" mode is enabled.

But if "enhanced" is what users want, and if that is what the other
tools on the platform use, then perhaps flipping the "enhanced" bit
may not be a bad idea.

