Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F5781F453
	for <e@80x24.org>; Mon, 29 Oct 2018 00:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbeJ2JZz (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 05:25:55 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39681 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbeJ2JZy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 05:25:54 -0400
Received: by mail-wm1-f65.google.com with SMTP id y144-v6so6294455wmd.4
        for <git@vger.kernel.org>; Sun, 28 Oct 2018 17:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RJmoRZGhAPZMFb46NhF/xAtb6ipqgW6/fL4dVmdrvew=;
        b=eeyWaXYMyWoP/LqUjPX2qB3IGEoYkj4NCoCfNNJOOREMMAXECgZ60xT1SHAqs1YaU+
         1b1v2Vls+wKjctlyZoZEVOLpnbpoi3C7kDMzUr+FvNdeCDPyBpHf7ZzRz6E9hLfCjU6Z
         6SOlRYCi9L+1k+9OcXmhIr4UEJKFDKdVI5K2FzXtJr9ROfo6oZ1tR7MY4Kgv1S2bBfPT
         TtKh/jTPoeFUbIJ59JfuQ5NVyazpj4TH0oglHHIiiOfr0t5ma6vmKCUULMqTRGy3nmfW
         aJxxPPbTtqZKFWE5xkqAZttZL05n2SD2KGvzMrIOgVXNlutiEEBfWMRYVVV+RAJXPzRE
         CBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RJmoRZGhAPZMFb46NhF/xAtb6ipqgW6/fL4dVmdrvew=;
        b=Sf4hbz5nMwXURS/7VlfUfgmbT/I8aotslcw2nZFF55OnrEi/SUvxx7UhSAh0vNoKug
         xgiNL4xhBUfHRDQ0mx+5MpTpK/rtNN0kgAgta0DEFXHqmhnkT0W4jz7NhjJGsJ3l1xe0
         HAJYPQOx5oKg0T8nAWMxT+jSRjH4+lmaFgTvngO8A62bHK/VLAAIAHImIqMTjByxGZV4
         6DcOBdbBK6bPfFcs2RrhJiKWo8O88YNo/Y4q/cAEhBJx1nBnQ5QO9YxXlumbpPhqRBN3
         SAj3ykc3fBADS6PLa8a40umM4sov190Fn9ZzKhRmYGkfDCivf/dgRrb3dSpEtTjVs3Uk
         HFMQ==
X-Gm-Message-State: AGRZ1gIePpoys59TpH2ajbtXHZtQjisagFKVdhrQ04HWFWd0hJTx0Wtc
        wzjsoarz6mjqPClYtu8U42Ozjh02/0o=
X-Google-Smtp-Source: AJdET5dOLEFIqqHrj70ZlmBLf1b3yUD3ZiRC6EQN0U2FNVsaboI+l0iqDnjjAB6JEIBEOcksn6OfoA==
X-Received: by 2002:a1c:aacd:: with SMTP id t196-v6mr11629869wme.121.1540773576557;
        Sun, 28 Oct 2018 17:39:36 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z15-v6sm925991wrp.8.2018.10.28.17.39.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 17:39:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org,
        stolee@gmail.com, avarab@gmail.com, pclouds@gmail.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v4 10/12] Add a base implementation of SHA-256 support
References: <20181025024005.154208-1-sandals@crustytoothpaste.net>
        <20181025024005.154208-11-sandals@crustytoothpaste.net>
        <CAPUEspjCjFiwCO8TCM23f2jqFSpy2z05+Ea_zGATy0jh1L83iQ@mail.gmail.com>
        <20181028155206.GI6119@genre.crustytoothpaste.net>
Date:   Mon, 29 Oct 2018 09:39:33 +0900
In-Reply-To: <20181028155206.GI6119@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Sun, 28 Oct 2018 15:52:06 +0000")
Message-ID: <xmqqftwpa8my.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> > +
>> > +#include "git-compat-util.h"
>> 
>> this shouldn't be needed and might be discouraged as per the
>> instructions in Documentation/CodingGuidelines
>
> This may not strictly be needed, but removing it makes the header no
> longer self-contained, which blows up my (and others') in-editor
> linting.

That sounds like bending backwards to please tools, though.  Can't
these in-editor linting learn the local rules of the codebase they
are asked to operate on?
