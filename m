Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C1C91F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 03:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbeJLKxA (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 06:53:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33063 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbeJLKxA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 06:53:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id y140-v6so17056993wmd.0
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 20:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MNntpcRR7uoGS6v7GjXN9mjs/eXpbCFMrxUAlHoWYYk=;
        b=keFbbj4HinvzorMDpuLVbIEiF1SL+ocYwv/kNazaQTGTJCcs6PMvrLmRo6Gepm+hJf
         RLbLpoMsIpsE4DsQToPFNKwlvo/FuojvGqhn2AIR/3BmQQbuj1QdRPazHKeZ454fkn14
         JAek/sGRIzDAoNmaUPS/wtzyxYeKk1TN/+OYZeAlct3vcMRm/+nXRg303ZfpsQVIkAn+
         MBAfsrV+vII19lIJOmfukbAibIfB36gTmegN8aiVYXMrojcH1gJiPzI/qXyXSM7M5+qN
         0KyzCXrJsKA9cAToJCO7edaqlYm0oVRRmo2Ej9KFXTF/slvAgf96jiFV7wupVfsbi/NG
         E52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MNntpcRR7uoGS6v7GjXN9mjs/eXpbCFMrxUAlHoWYYk=;
        b=ClV97+NCQw3ppJo8DNSwr288TCKMkDl3QiwwhKUjQbxWOjuNVIhTfyypZH7ysCc3cs
         hIC2pUGZkp1Dc0qVC5jsstRqK6/+bSxWFCeOAXAx5nkZ1iujh/Y7x4zOUWeWFr+mO9VK
         AfqAUvCf4+S5gK07L+p4BZZMHPUpAAdisQTDsmM5Ur+v3doV936vGBj9SKT73MOowY4Y
         BjwaQOq+z3INH9KHN53ZsduxRqHVI7uFySvQJClEGUvTBpzYrXiYBK3znC77C2qHovX0
         2usGBfIzJjPZYwygICRND5jD2R0T4rvsku0mroKFlsrHO6mzmh1okblUuD2yURw38s8w
         iwlQ==
X-Gm-Message-State: ABuFfohspcuG0dBvt+pqZ+FCpI5msDSIy7wcdVF2wcajOu88SuGwr72q
        myzsu2vTNfjxdUQdvDnqGiso0YkmiY4=
X-Google-Smtp-Source: ACcGV61CSJjY3z62sSsTax6P0A9oZcunh96TgSFfCALzih+goGZMoyEOjm0w7PkqWg/96zcPCVUg6g==
X-Received: by 2002:a1c:13c4:: with SMTP id 187-v6mr3792100wmt.66.1539314561855;
        Thu, 11 Oct 2018 20:22:41 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o17-v6sm19143913wro.2.2018.10.11.20.22.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 20:22:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Noam Postavsky <npostavs@users.sourceforge.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v6] log: fix coloring of certain octupus merge shapes
References: <20181010003743.17198-1-npostavs@users.sourceforge.net>
        <xmqqzhvmmv8v.fsf@gitster-ct.c.googlers.com>
        <CAM-tV--Jzq6DOAfWtvk3FVX3=TT8X6bvu_4VfaJQY=M0mSQV4w@mail.gmail.com>
Date:   Fri, 12 Oct 2018 12:22:39 +0900
In-Reply-To: <CAM-tV--Jzq6DOAfWtvk3FVX3=TT8X6bvu_4VfaJQY=M0mSQV4w@mail.gmail.com>
        (Noam Postavsky's message of "Thu, 11 Oct 2018 20:23:46 -0400")
Message-ID: <xmqqlg73df28.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'll do the s/octu/octo/; again on the title while queuing.

Let's merge this to 'next'.

Thanks.

