Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C9461F597
	for <e@80x24.org>; Sun,  5 Aug 2018 06:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbeHEIQq (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 04:16:46 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:44748 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725729AbeHEIQp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 04:16:45 -0400
Received: by mail-pf1-f171.google.com with SMTP id k21-v6so5265563pff.11
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 23:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zYxr6lUnXeyaquwUv0Pya7q5k0OfAcRFHlfV++Dql8Q=;
        b=qIg+s7gilGyR168JaB2U+TBY2A67fb3RP1nBlu/TehgrfJhCG2gI9oJ5JAwWv4+UwY
         aS8Hzw5ATpuSPNkk1ckf6q15stWWm9RG09VBfqid7uA2vfzWoS11qCuz7OkD5SwJa7JF
         D5v/mjn8bqmc+sMVMQQJY1uNR4Ye7Ero4UEoiz4eFxI8Yvd7NlM8fnQVfPO8NRjTdGER
         +cnpjU8lnFHRl6dku4eOb+8FdzpA2R6QIM6xzzp40GBfjCwbFW8oEPetkMrYwJ7NtXoK
         BD/ewT4L5QMxMPoiomZZUmO1lRlykvyqGhue/Cbe0rtZNsL3TbC58+Ef0PTEnkxoAApW
         QuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zYxr6lUnXeyaquwUv0Pya7q5k0OfAcRFHlfV++Dql8Q=;
        b=m+T/+fjYlWY89CU+5jog8S4DkYQGS9Ur0dxPfzIJbXGXYTEMoj5KYQCRiKrRIfC6vu
         Afqh7it4b0aElgtOycQypmhetgvPEq7GzCAEUY3i2GaItNCKifWeo2zMlt01/W35MaiY
         joH44V/y7DL1mq8z/Gsts7yNMv39hsOonL6Y3nZlZ7BTXQsICp7GiJdJhH56Br4ydK7n
         FR2bY3hvyOmwlHixMzIoXje57n8+LxWTSNRLx47qhQXFCDnlsU61BB4RP9BY0FEJlCSK
         fdmdB7e8g+FDBZsW8XvWKWGsqhEUJom40fk01/ahHbuBbfh+a6uhrepm34BQH2Hot/7r
         /q6g==
X-Gm-Message-State: AOUpUlH6t1uOt7f1BIvgJqe5Gr/6GGMg05IjxcoG0NfEiv15FYUIcfRb
        JddW8LH7M0qSp0MygyLe7/TqWTEf
X-Google-Smtp-Source: AAOMgpeYe63caO4ChLRhZmkH2rWm72SsqoUpiSr5B4SRkJySlf40zrjV1nyuYoobZJ0gSImEcAYKYw==
X-Received: by 2002:a62:9349:: with SMTP id b70-v6mr6883620pfe.193.1533449600160;
        Sat, 04 Aug 2018 23:13:20 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id d75-v6sm615954pfd.49.2018.08.04.23.13.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 23:13:19 -0700 (PDT)
Date:   Sat, 4 Aug 2018 23:13:12 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Alexander Mills <alexander.d.mills@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: concurrent access to multiple local git repos is error prone
Message-ID: <20180805061312.GA44140@aiede.svl.corp.google.com>
References: <CA+KyZp4fxRfnPNozEtwgLPuFAnEsXCBPPubzNjv0wUMnBV_eww@mail.gmail.com>
 <CA+KyZp43YGf1qLDHOtrfjJxREcaVQNN12iMLDL5qX=RXhmMCYQ@mail.gmail.com>
 <20180805014631.GD258270@aiede.svl.corp.google.com>
 <CA+KyZp5i0EXPJ10v+SXmHWCYvZ7=XT8K8gcka0qxCBYXq=OevA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+KyZp5i0EXPJ10v+SXmHWCYvZ7=XT8K8gcka0qxCBYXq=OevA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Alexander Mills wrote:

> Yeah as long as git shouldnt fumble wrt concurrent access across repos, it
> was most likely the same repo being accessed concurrently and that's what
> was causing the issue.
>
> that being said, it would be really nice if git itself could handle
> concurrent requests to the same repo, that definitely seems to be a
> limitation.

Instead of all these guesses, I'd prefer if you describe the actual
symptoms.

Git is meant to support concurrent accesses of the same repo as well,
and I haven't heard of any rumors of that being broken, either.

Sincerely,
Jonathan
