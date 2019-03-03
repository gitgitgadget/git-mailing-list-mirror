Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67A7520248
	for <e@80x24.org>; Sun,  3 Mar 2019 10:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfCCKD5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 05:03:57 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38235 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfCCKD4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 05:03:56 -0500
Received: by mail-wm1-f65.google.com with SMTP id a188so1918521wmf.3
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 02:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0Wv7KcIM7hjz1Bzp/Qe1+oQlC1pd90YP4qCNDteU2Vk=;
        b=dvwpBNeuSgVtqNiLKUTsxDxJ+b+JWZ+5DAtuvY/ad3pBK8BZ4cZYpfsj+wtRSgLWi8
         2225c4s4RV6IBGDkq2s3qwkp6jw+qk46TwaOoPZMer8+Qmu11q43U0yBzky+H9wPyh9u
         9LhnCCN4dXY1RmV5HBxAlf+Tq9LBpXL4Lr2ulWsz5Q2f8MN177BZqE/CLzR9xM2TI4MW
         zVY4PdjnuF3K8pMTr09vqG6foN5W008Q8hIGVBNl+i6S4O3mPDsX2T1g+xSUM32BfDn3
         MW8KN8g6n601L3sp+5FqtBP5669Zdh7Xey7bp4Lg6FTMsgMP0Bqk/2ZJSI8mRqH+uZLs
         jpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0Wv7KcIM7hjz1Bzp/Qe1+oQlC1pd90YP4qCNDteU2Vk=;
        b=jSgbubmV/99nPDSdoMGaVqH4DppD1fLgN2ahj2YXz+8CrVf9rP+f2d+EvWG6Pwni2Z
         De7cfZpkC5K9xwIiPD1gdPYTQa40k2xc7FUoQCvmbU3I/BX6hjE4vKBSDntIINh8FLcu
         gk8+xMM4NTZw/AqWg4LSJk2ZlJkvEcnm67y/PHgGjWwJTw918d0H3GyFgwFF7j5JoIiC
         ki/SqIaalLBYGPYqWRh+WMemQf1teHg4ZqiRb/f6C2/YK9vXcvxHbRImcUpIHJ52VYHl
         i0axua21LqoEuF0LEIKFsPvN/PAmuT3NAxBqMrdHKb9AHVlBmEzUJ8NCkQ42iq/NiOzx
         4m9A==
X-Gm-Message-State: APjAAAX0PSDnHxSMa6IMki2JhpJ1kxOfM+9JbgMXaklSYtRr+enkJd3n
        GCXZYDP2dmfjP9P5av/XTgeyPcyU
X-Google-Smtp-Source: APXvYqxiYf0AMMWuW7IvGtuTz3x7Lpjk6ezMLc12990n8MJs/0xo4dGgByT5zdMMctQI9rjFGv7HQw==
X-Received: by 2002:a1c:f510:: with SMTP id t16mr7769878wmh.105.1551607435163;
        Sun, 03 Mar 2019 02:03:55 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id l130sm2639594wmf.13.2019.03.03.02.03.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Mar 2019 02:03:54 -0800 (PST)
Date:   Sun, 3 Mar 2019 10:03:53 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v13 00/27] Convert "git stash" to C builtin
Message-ID: <20190303100353.GV6085@hank.intra.tgummerer.com>
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
 <20190225231631.30507-1-t.gummerer@gmail.com>
 <xmqqtvgk3g1u.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtvgk3g1u.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/03, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > As I was advocating for this series to go into 'next' without a large
> > refactor of this series, I'll put my money were my mouth is and try to
> > make the cleanups and fixes required, though without trying to avoid
> > further external process calls, or changing the series around too
> > much.
> 
> Thanks for a well-written summary.  One thing that is missing in the
> write-up is if you kept the same base (i.e. on top of eacdb4d24f) or
> rebased the series on top of somewhere else.  I'd assume you built
> on the same base as before in the meantime (I'll know soon enough,
> when I sit down on a terminal and resume working on the code ;-)

Right, I forgot mentioning that.  Yes it is still based on eacdb4d24f,
as there was no good reason to change that.
