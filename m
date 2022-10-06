Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FA4C433FE
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 19:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbiJFTil (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 15:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbiJFTig (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 15:38:36 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB2E1144D2
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 12:38:32 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y136so3001119pfb.3
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 12:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Angw+INXGj39e6oJkoK/qocYPDAgGVn/8ZpvQ3bOY2k=;
        b=BcNKp4uzkA5zHjkeV/Fz+6K5/XSoB+qqKIihj2sccmS0ZCrxBw1begWEOxBkKlr+5S
         OeQLgPbNK6LzcWmdeexKsfxbeGfqRlhlCmZCXTB8mx/tshgHTZzE9YJypwcEAWqZBUfj
         XwXTPPptPjfSRBvqGgzQqMSns1j4AHO2l1tL6a5k6TUThTgiNDXchr7dg+WuRKQeLk9z
         Sf6d9BwtnykXOHO+qc2UvHMDnN/jfRG9ebyTvViNaTgvrcyTCyseThEmSHHNR35s/T5Y
         FWYYX8/wl7Mw70lmHE6MTtKzDv6CUhYGcO0j69KrrA1KmMmnUizPdOVk1PZaDCjcGZu6
         Tetg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Angw+INXGj39e6oJkoK/qocYPDAgGVn/8ZpvQ3bOY2k=;
        b=AIQPfwUCewgYoJpPdTaSpFYc4zZJwWSiY9U7WY7FJ6t+U+UViE29PLk+CBMIuy3Dit
         gL1XoMXm+q4M3hCO9aXIwv7Zdy6Zg4C1f52VWonSdzncWf7IZc4qjFmV7yaNSNoWo5Yn
         vupX0DaONF3894F4OU6TySkEOTYV7JXxOhgWebWNQGWQHGfJ24NGi5uHqANeuTeiDEcK
         EbV5WY3eFmZfJu1rAeSg1KlDmux32HA7BmBOk4Zpkre4SglpnwLcUlfiKgYL7vphonHs
         CI0yYwpStHkJMtFBL7WMcUCmk8JPGpCrrSezzwJaw0bzF3zNw9gE2z756CFnxsgUlh49
         lQ7g==
X-Gm-Message-State: ACrzQf3HgZOZURmkre8SPgRwsc5KhSBgcswUpvThpAJOYljmtqKA0Ksv
        XrQJBLa7Wp6MVWgzrT3u4dE=
X-Google-Smtp-Source: AMsMyM5Nb+7Z0avNAKxcWZLWz2pmum4g+7FU2t+KFFfD7viIshU3j8111xgG1H/D/buwl+jPtWJ3uQ==
X-Received: by 2002:a05:6a00:23ca:b0:557:a75c:b430 with SMTP id g10-20020a056a0023ca00b00557a75cb430mr1107346pfc.16.1665085111710;
        Thu, 06 Oct 2022 12:38:31 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902a3c800b00179eb1576bbsm2584618plb.190.2022.10.06.12.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 12:38:31 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Martin von Zweigbergk <martinvonz@google.com>,
        Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: Bug report: `git restore --source --staged` deals poorly with
 sparse-checkout
References: <kl6l35c4mukf.fsf@chooglen-macbookpro.roam.corp.google.com>
        <54ee4a2a-1937-8640-9297-8ad1516596cc@github.com>
        <CAESOdVAh68HoQoyicfZn4XbjGfiRFCu1zFQmUjMcSAg3tUzr4Q@mail.gmail.com>
        <96c4f52e-bc66-f4ee-f4f6-d22da579858e@github.com>
        <xmqqv8owkaww.fsf@gitster.g>
Date:   Thu, 06 Oct 2022 12:38:31 -0700
In-Reply-To: <xmqqv8owkaww.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        06 Oct 2022 12:30:07 -0700")
Message-ID: <xmqqr0zkkaiw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I think you misread 183fb44fd2, ...

Ah, now I see this was already resolved yesterday while I was
offline.  Sorry for the noise.
