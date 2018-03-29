Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AF361F404
	for <e@80x24.org>; Thu, 29 Mar 2018 22:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751199AbeC2WD7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 18:03:59 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:40611 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751191AbeC2WD6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 18:03:58 -0400
Received: by mail-pf0-f180.google.com with SMTP id y66so4136385pfi.7
        for <git@vger.kernel.org>; Thu, 29 Mar 2018 15:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2yyap8yNqcoRcKyj8yDsHuPTVyaGO9pUg9Rdew9DpzU=;
        b=cPHlRiNZ52ncvOgEKGR4/v/M854vktXDBnJTP5LVb2xBerPzyRdvl5LAi4+PVG+G1h
         kSVYn6Njv5VSUNTpV6/8ml82FLlhnSlL0M91NrH11lNISISpxhR++YnDoog3wSoQu5dS
         aAHat+7q5VOZobWTD4ZLw2gJfbdvS/v9QcUf13p6LB/Lv69TjeXZBPkXqELoa/m4lO+r
         IRKCI8Njjo38CvA9IqiMx/a2YlH1Eq6kSJo1LetY6punkw71Y22GPClAQiQQVgJKc/Cy
         cZ41ay+WDEh7OPQ2iLSQ7L8yIZaIsrT3UugbI/W1Q13nzqirIMpIhpL2E3wB5KYI8SbU
         IxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2yyap8yNqcoRcKyj8yDsHuPTVyaGO9pUg9Rdew9DpzU=;
        b=b6mQEn8L78xtklppWxYqHeuWGFpeS+JA1HNAMSCG7rCkWhxH3asnGq/g60yYqV7aau
         711mpWLwYhJDjMydQm9WXaI6DIt7ztW1N/BwWF2v8tMqZxEZbd3S422xmLScUVhXAvge
         0Cuut0IhtdBEumPJ/TEUTJu/2EJKZTeg/rZ4ANG7tDm+Ffo1Q74H+llRoM7xTMfOonb7
         gINaPOG8rON+/F3xbA2jmq+2XC/Cnda5uLHg4dw4F6xsAmp+ngG+iVqJd/xyFoVaUbCs
         stG9v1xNUIhJa0phOY+MOrGMNn+KKJbx1XcbdhzObJdq/xFlENAYYExidZEiY7F310RA
         cQVg==
X-Gm-Message-State: AElRT7HbcYQcD/FsYJeB+S7WzAIHg6dJlDwJyJ8AJh1JkInh11mVmCyf
        CSp3wTnrArBXi7Tmi84xrF0=
X-Google-Smtp-Source: AIpwx4/QWeyLhg5rGK3vbemCQHBidoSliIpqXkBv6+ck6h1aDZF+e982joKjs2M8LQJOvTUFxGPomw==
X-Received: by 2002:a17:902:887:: with SMTP id 7-v6mr10315295pll.319.1522361037555;
        Thu, 29 Mar 2018 15:03:57 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id p1sm916938pfp.48.2018.03.29.15.03.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Mar 2018 15:03:56 -0700 (PDT)
Date:   Thu, 29 Mar 2018 15:03:54 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [RFC/PATCH] upload-pack: disable object filtering when disabled
 by config
Message-ID: <20180329220257.GA209272@aiede.svl.corp.google.com>
References: <20180328203303.GA260688@aiede.svl.corp.google.com>
 <20180329215502.GK2939@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329215502.GK2939@sigill.intra.peff.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Wed, Mar 28, 2018 at 01:33:03PM -0700, Jonathan Nieder wrote:

>> When upload-pack gained partial clone support (v2.17.0-rc0~132^2~12,
>> 2017-12-08), it was guarded by the uploadpack.allowFilter config item
>> to allow server operators to control when they start supporting it.
>>
>> That config item didn't go far enough, though: it controls whether the
>> 'filter' capability is advertised, but if a (custom) client ignores
>> the capability advertisement and passes a filter specification anyway,
>> the server would handle that despite allowFilter being false.
[...]
> Great catch. If I understand correctly, this is an issue in the 2.17.0
> release candidates. Is this worth delaying the release?

Yes, IMHO this is a release blocker.  (To put it another way, if this is
going to delay the release, then we need to revert that patch.)

Thanks,
Jonathan
