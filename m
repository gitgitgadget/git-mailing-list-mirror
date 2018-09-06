Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 020F31F404
	for <e@80x24.org>; Thu,  6 Sep 2018 10:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbeIFPBK (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 11:01:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40934 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbeIFPBK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 11:01:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id n2-v6so10802514wrw.7
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 03:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=cCrJuhtO80rS7z9zeK8I1IBtTRn8ygDlyNt6szJSgiU=;
        b=ezzSlAsHxXk37UDAvrJSGXNhdwmvZrehjYiX33Ygu3yUkmp4IT/XDDO2ZEbBry2hw9
         aY3CnSCi5OcCm+BK1F+h8yDQsCuQnY6YxcJOqYbSR8CtWe/drJoJVdwe946BMx8TkJ3o
         +oYGUsU1W4ntPw8HGjoppW3/wGt7+p+JhSD+5MGblNTy/0bbDFVdJZP1nEdsJuwFgsoE
         gZEPWFgGymyHpUsE/50l5ZPFWIxNOeUYx7nzsZq/WQq5Niplts7uy3PiwCoBDEK3TsfX
         EeqT71gXj+bFhtIfPJsFm6ByOROwzTp8+bKfHC6V3p6FzgqvK5Y+FvaJu8kmx2pos635
         RjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=cCrJuhtO80rS7z9zeK8I1IBtTRn8ygDlyNt6szJSgiU=;
        b=gLRM8/Spkkat8ecxlhHaNzbOZ3vb22T+pYNUc7Q/B7qieIHVF6EaE8tos13KfzQSXy
         inHJulWKQi2TKMbB8ECtUAu5gbPL/9XDthRRgN8BGg10zZMztadgTMnndlzBerUKmun1
         wk3vzL9fNOe/BkCklTv4EtUYkWbamEgJ/uCNoT/oeySuU9s00jKAXXNlJ9esRZZ5LLQQ
         aXRgtw/1nYQNa+53+Tc38EiBd1N04MLy2b2V3A/ILaYo5AsTssWCcLDLJvJhLvD9U64S
         rTMadU/ikb44mtO+dWvZNyLjr2d5kaL8pkDfoIMPa0WTIoMZNVQJWZyWQ5/1eX5OhtRW
         AC4w==
X-Gm-Message-State: APzg51C9ytmO01+j7OuLrv3nnv8ghBw8k/bL+EuYwD7KdritFHtqSr1f
        GPMOh9JRIjzFwrUFusia70Dgg3WG
X-Google-Smtp-Source: ANB0VdbkJJWiqRuFCMkTpKpakyZEblj3Ch76vM7Q0w+w0uS1unn1ius2dZ+8VHrQ79IlSedxWj3OBQ==
X-Received: by 2002:adf:9e06:: with SMTP id u6-v6mr1716978wre.51.1536229581507;
        Thu, 06 Sep 2018 03:26:21 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id v5-v6sm3326148wru.60.2018.09.06.03.26.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 03:26:20 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [RFC PATCH 5/5] split-index: smudge and add racily clean cache entries to split index
References: <20180906024810.8074-1-szeder.dev@gmail.com> <20180906024810.8074-6-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180906024810.8074-6-szeder.dev@gmail.com>
Date:   Thu, 06 Sep 2018 12:26:19 +0200
Message-ID: <87woryrkfo.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 06 2018, SZEDER Gábor wrote:

>   t3903-stash.sh:
>     https://travis-ci.org/git/git/jobs/385542084#L5858
>
>   t4024-diff-optimize-common.sh:
>     https://travis-ci.org/git/git/jobs/386531969#L3174
>
>   t4015-diff-whitespace.sh:
>     https://travis-ci.org/git/git/jobs/360797600#L8215
>
>   t2200-add-update.sh:
>     https://travis-ci.org/git/git/jobs/382543426#L3051
>
>   t0090-cache-tree:
>     https://travis-ci.org/git/git/jobs/416583010#L3679

Nit: That last test name is missing its ".sh", as I found out when
copy/pasting all of these into a terminal :)
