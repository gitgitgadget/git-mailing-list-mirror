Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6378F1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 20:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbeIEBTg (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 21:19:36 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:32979 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbeIEBTg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 21:19:36 -0400
Received: by mail-wr1-f42.google.com with SMTP id v90-v6so5389019wrc.0
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 13:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Z2kzNZqMNLjH17rSu5Vt7GRInGd3+xQJnrc5c4eEfls=;
        b=dQLI+H+AFNIjWetM658BiZudljs54PVW5XgVd+WfOVY1EziiAx+YBeHXfYSAj+XrIF
         DMzWEQw3G0AH8A3E76Vt0v7Ffbt8OlS860HESw/vPlwZdRzdeXioHxUNywYkxTpA1P2L
         USKxZ+7tucLoIiBAqC2vAjMjLB/W2NuMzv+F54JaogvMltFkHB7TBGJOBnSPvfN2iZts
         Nr1iwUMn89WlLU+E2tLtkQhUe7JXBvgdEHYkrg3bhl1Fyn8EHQlANe/EhlJivcNJfzz3
         Z2dAmB8r1fSBjpeKkY8OF5YQunH9BXXst2l5z+HE0ZjZZ912pyrAgfYjc8ul5y4s19hc
         Di0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Z2kzNZqMNLjH17rSu5Vt7GRInGd3+xQJnrc5c4eEfls=;
        b=ozcfzNEidrG/s77s/zR32t1LTPFyTsUjPdHQN2EcmAG7+fdmHC7CkdGKeNJSf8GBei
         5CEBDKkQnM5/6PafCjXKEWD7ufTy79w79AbEpbd/B7sPt3A+UIXZK8UrB5Li5b5/eFXk
         yRpNzD35+LCe2s2A/SOhTEZ5HG4OH3gI5j9HmaIRdB9LtQ/xgUjmHGCo3lXnPOYQiiAM
         FVF99UFEIU45VKuYyObQaFeKlgj1ktm/Ho6o8WbgbMXjutcimJc8E5CuvA+Ug8SRdyUL
         mDYQIiQI6tiJr2s0d5k5rhr9H0YfzEo9/H5XKeq3Ehrx8WWxA41BrkrQRB+6issRb8x7
         n2Jg==
X-Gm-Message-State: APzg51C/ckTxCZUmejoPMfZvRoylDYRuS597dIrV73ImVerx20k4eXu0
        dzSkGLzpsT7g6opwzdkFScE=
X-Google-Smtp-Source: ANB0VdZf81CaVLrWZlfBY5aSAyZySAfBWrqSpDTEWYKyS7ftgzLncyrUPjOukNFMoNZjzu1wTqVpcQ==
X-Received: by 2002:adf:9306:: with SMTP id 6-v6mr24879458wro.211.1536094365592;
        Tue, 04 Sep 2018 13:52:45 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j66-v6sm29549380wrj.28.2018.09.04.13.52.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 13:52:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH v2 22/24] revision.c: remove implicit dependency on the_index
References: <20180826100314.5137-1-pclouds@gmail.com>
        <20180903180932.32260-1-pclouds@gmail.com>
        <20180903180932.32260-23-pclouds@gmail.com>
        <CAGZ79kZi=qt4LyeA4U8nSGKx3_sOEF2m8=K_YNE2JpesF5ybTA@mail.gmail.com>
Date:   Tue, 04 Sep 2018 13:52:44 -0700
In-Reply-To: <CAGZ79kZi=qt4LyeA4U8nSGKx3_sOEF2m8=K_YNE2JpesF5ybTA@mail.gmail.com>
        (Stefan Beller's message of "Tue, 4 Sep 2018 13:05:45 -0700")
Message-ID: <xmqqsh2p6l43.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> -       init_revisions(revs, prefix);
>> +       init_revisions(revs, the_repository, prefix);
>
> Thanks for this patch!
>
> At first I wondered why we put the repository as the second argument,
> but that comes down to personal preference, so I wanted to keep it silent.
> (FWIW: Thinking about it, I'd either go with this order or with (repo,
> prefix, revs)

FWIW, I would also find it more natural to have the_repository as
the first parameter, for the same reason why the "index" functions
(as opposed to "cache" convenience wrappers) have the_index as the
first one.
