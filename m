Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13A141F404
	for <e@80x24.org>; Tue, 27 Feb 2018 23:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbeB0Xa3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 18:30:29 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35498 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751800AbeB0Xa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 18:30:28 -0500
Received: by mail-pg0-f68.google.com with SMTP id l131so228221pga.2
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 15:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LCBoipjlxAQjr7l3PRZ9jiQ1v/jopfIGlx1ZoJB2xf0=;
        b=GFh1QwrkOIadfD/dN7E1KkXY1qICQZL8T4Fog2+kHs8qJOx9ySSlCxwMMp891xXVWa
         NXJkp/vzIIeLQDOGlkwiPFADv1nOzX/JsDOBl85K4+yjiZg0wLMtf+R+/IcywDePBtVK
         /r/XnP5IVDm1X1y9Cou4ddm8BJ/cTlwFjyD9NFlWAAHykWsJtuAyf+sLlaSNltJ/wuA+
         CsJLUc5hTu+/zBAz80WzgrXzaQ/jgJzchrqOgGrFoqp2+VgDA1sGtIjVzERGyrm3y2Lc
         kkVCs9rpCcwkTF3uVHeQtI+0wVbgu++3nUTeReLVwKV1zFG9LB295fFhlLwD2aMIA/0n
         z/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LCBoipjlxAQjr7l3PRZ9jiQ1v/jopfIGlx1ZoJB2xf0=;
        b=rgn0Ls4D37EHfXO69zDx3F/r5ENqqT7tfhIPtIQr24KTcDychgb3fXH/M7MSCCodA7
         CmNjzCCtechPHKTiXx/A1BfMIZlAuy4aMUWfiNWoet8VqnjrE8H6o08etPZ1PZJlzoDN
         D9xOCbNzfCL/3/Tvbtr1Xn7Cif2OiW17CiHAJsvRR0oHWvUaHESKxtH11jOMZuyEk+4q
         7vHGre9I8OMUB73x1kT7lUXO+mEGBSithMqdeWwdnPgUS5iBMUmWzsvZw9BZjC5Ldz+I
         BbiTpbXJb1zMsNrQ8L4C4AB4bsV0O0EtXUphnLmbtN3cmNPtTXlRnLnHolrMGk9kSgX9
         nT4g==
X-Gm-Message-State: APf1xPA9bToTn36CYv4DM/AF8LUvajtecB6FudgYu2yG/F/ffXccxrqS
        wZe4kiY7m9POfDIvmK1bjWk=
X-Google-Smtp-Source: AH8x227JnqzXNCSE4WE6qC0Pyp8UeJDkIM/c1CHbSanoVhRYffg3ZVQomAyQ+agSO80lBeREtP3piw==
X-Received: by 10.101.74.208 with SMTP id c16mr12643799pgu.116.1519774228010;
        Tue, 27 Feb 2018 15:30:28 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id f190sm326938pfb.158.2018.02.27.15.30.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 15:30:27 -0800 (PST)
Date:   Tue, 27 Feb 2018 15:30:25 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com
Subject: Re: [PATCH v3 28/35] transport-helper: introduce stateless-connect
Message-ID: <20180227233025.GH174036@aiede.svl.corp.google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-29-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207011312.189834-29-bmwill@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:

> Introduce the transport-helper capability 'stateless-connect'.  This
> capability indicates that the transport-helper can be requested to run
> the 'stateless-connect' command which should attempt to make a
> stateless connection with a remote end.  Once established, the
> connection can be used by the git client to communicate with
> the remote end natively in a stateless-rpc manner as supported by
> protocol v2.  This means that the client must send everything the server
> needs in a single request as the client must not assume any
> state-storing on the part of the server or transport.
>
> If a stateless connection cannot be established then the remote-helper
> will respond in the same manner as the 'connect' command indicating that
> the client should fallback to using the dumb remote-helper commands.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  transport-helper.c | 8 ++++++++
>  transport.c        | 1 +
>  transport.h        | 6 ++++++
>  3 files changed, 15 insertions(+)

Please add documentation for this command to
Documentation/gitremote-helpers.txt.

That helps reviewers, since it means reviewers can get a sense of what
the interface is meant to be.  It helps remote helper implementers as
well: it tells them what they can rely on and what can't rely on in
this interface.  For the same reason it helpers remote helper callers
as well.

Thanks,
Jonathan
