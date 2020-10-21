Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6C8C4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 20:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A171724182
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 20:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgjXJhId"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505551AbgJUUx0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 16:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505512AbgJUUx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 16:53:26 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86709C0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 13:53:26 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id b8so4615238ioh.11
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 13:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d7ZWedoJonvxxGEZGoaG7frIvR+ufJCThO2bUZxIbvU=;
        b=PgjXJhId+yBvIzWI1/ih4V29o5KvIxebmZsr1seLBxGdL4BxQ1XLm0ViF/0c8CA25v
         k7+nFtKEhprZ+VohIvkxZjwYvNtBvWVHZ6gpT4ggWmKdfzmRIsAocZklPmLyyflphTwe
         XOO/mxCxzNp/DFiNBggOu4vev5C++hbJBJcyV/3NLLoCmItOiyZ3cGDuOO+b+5IgYd1f
         mqofQA1pb1v3uUO2JHIPw44fM397wnVPuUIpTjfO5rbDh9B32cBH54hbjNwNo4NH1hgG
         Zmi0dhHhMSwxvUEvHM3gDWiqXbBQe8bWLi/UZyh3tPhl9HAa6PR6So4W1Hi0qWdIiZ1q
         eOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d7ZWedoJonvxxGEZGoaG7frIvR+ufJCThO2bUZxIbvU=;
        b=aWdMkmJsqkeXESqihWvjWBLjYTm+0+LB0MdXRmt87REkw4CPdNxROMECzVaYHTQsZi
         39djrYUmhBQ6F/ZmVd10J0pDP/oCuVbOAVVcfkgORXlWtCndolMJkz9aOFZK6b5HLPXd
         UJnfYUX6AMk2/rtyqNQHqB+iZT5MfNtwx4UQxvzyUVOc0awHLHERlrY5sQrkdyYsjqxt
         j5nZuMElKYqWR9HhMkHxFzD+IgNMyvGWu8PADv42nc5/KrTLPL3YP/piifPGBOOIYym3
         mrGoW8N1hjVQI3puj8sYbiUYfdYs15dTzE6ydOBoNlaNHAwoXRM972U5+3cR4sud6W2e
         IVUg==
X-Gm-Message-State: AOAM5301H5GTMF9BSqAESN3DUgf6+mR1yM5hJQfDLamqKqddzYmxN3Al
        XJgxy6j+rAIxAV1rauNtBS5Mp8Dxo07dlknld5iaLN3cbO20Rg==
X-Google-Smtp-Source: ABdhPJxbL6tLh2W8JdJDRSPyWqpwKp5WBH+OBIEma8KNl34rWZoeSugMFBV/hJfzmez9eqFex3J6GetGfftlZldWF9o=
X-Received: by 2002:a05:6638:2412:: with SMTP id z18mr4328398jat.56.1603313605931;
 Wed, 21 Oct 2020 13:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <20201021062430.2029566-1-eantoranz@gmail.com> <xmqqv9f37476.fsf@gitster.c.googlers.com>
 <CAOc6etbSbg0rDrqu__MASTEdz2FhnhxtQLn6gvhBZL8BLz+AQQ@mail.gmail.com>
In-Reply-To: <CAOc6etbSbg0rDrqu__MASTEdz2FhnhxtQLn6gvhBZL8BLz+AQQ@mail.gmail.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Wed, 21 Oct 2020 14:53:15 -0600
Message-ID: <CAOc6eta+ZiqDSh30X8SDmcPE2M3OuHBt+zx5vQY6pwWr1DYWFw@mail.gmail.com>
Subject: Re: [RFC] sequencer: allow metadata to be saved if using cherry-pick --no-commit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 21, 2020 at 2:45 PM Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> If there were, I would correct the EOL format of the files. Then,
> successful cherry-pick or not, I would run cherry-pick --no-commit and
> it would work.... but that was when I realized that cherry-pick

I meant success cherry-pick or not, I would run cherry-pick --continue
