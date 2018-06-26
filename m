Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D0EF1F516
	for <e@80x24.org>; Tue, 26 Jun 2018 19:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754882AbeFZTiX (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 15:38:23 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37012 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932406AbeFZTiV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 15:38:21 -0400
Received: by mail-wr0-f195.google.com with SMTP id k6-v6so18379597wrp.4
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 12:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/49oawnySHOTKfwmzdnn656vGGIJ27viISjXyeV3Py0=;
        b=uJLBqzFwtAKpmpOcVTzPQDISU8mZblFXspn2CUuNPTNcfRaVb2G4gzt/vSXhbU6YE6
         hE+BrfWdPXJAHOhnzHDq1a7dGKsn1KWpQTwXHk6VZgGw+JZ7xq3gvZzIoLalUcT/AaJp
         AnHYjdTXTHTSiwelZXixU/4imu6xnOL86xxZEAh/+m6fHcnNv9J4BgbrcxNPB2/rr7zd
         K0V1TkA3TeZ2V9wenbYGa5cYp2/Ak9dHD1uSW+DgZnPmJA0LfJIgMVwYfkOYZL3Q0KQL
         3KRf5ZUQREGGKuvAZTA8/RMQQ3Uhrwk3Gg+d82WQ5Gel7bT2N3W5qcXbbFYj/83r2jzy
         sSGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/49oawnySHOTKfwmzdnn656vGGIJ27viISjXyeV3Py0=;
        b=tCH4zNnc5YpCLTW5uRiSnCEXLqPwkYQApMO7j8VyUBMYsMzykKFb/1l8MOrVNrX4jd
         WWNbFTV1VX228wvTeJL3NY/doJh6a3fJv1Z6QtfIt5w0zfJOz1nhUaL4m7V1rsUIyzBi
         rF+KmXUvetbBNhbE8GhCuP3vq/H5nZIDfiCmQUJTSidXQzb5SunbXXKKCl9+8VJNfJo9
         i80LqLZVOcn7+Lx3CjK2T5R6afIP8XEV3dRCveEVLZQ6NJZxdFuDjOh8wK/ghtYtFK7t
         m5wwpLK9MQAR3767FCF6L6DlFVBvkfWKjEVI9D6BLMErFa6q8Cpe3qpE6yV3e+l2kCj3
         TcZg==
X-Gm-Message-State: APt69E3d6882Gi+End+7i42eIjiNcKwReyJVT/t971IciW4wQPRJdkFw
        Eewmd331FUS/17gVSJKDW+Y=
X-Google-Smtp-Source: AAOMgpc/SmQXIlUJqBFo3Wf6y9/pAdws/VErerCfiIB7a0ZUsysHIUJO25PPQBWF+2L7JsnyIs92kw==
X-Received: by 2002:adf:db91:: with SMTP id u17-v6mr2532227wri.217.1530041899888;
        Tue, 26 Jun 2018 12:38:19 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id n17-v6sm4301496wmd.14.2018.06.26.12.38.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 12:38:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 00/29] t: detect and fix broken &&-chains in subshells
References: <20180626073001.6555-1-sunshine@sunshineco.com>
Date:   Tue, 26 Jun 2018 12:38:18 -0700
In-Reply-To: <20180626073001.6555-1-sunshine@sunshineco.com> (Eric Sunshine's
        message of "Tue, 26 Jun 2018 03:29:32 -0400")
Message-ID: <xmqqo9fxjq39.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> The --chain-lint[1] option detects breakage in the top-level &&-chain of
> tests. This series undertakes the more complex task of teaching it to
> also detect &&-chain breakage within subshells. See patch 29/29 for the
> gory details of how that's done.

I first looked at 29/29 and got heavily inclined to reject that
step, and then continued reading from 1/29 to around 15/29.  

I like these earlier changes that fix existing breakage, of course.
I also like many of the changes that simplify and/or modernise the
test scripts very much, but they are unusable as-is as long as their
justification is "chain-lint will start barfing on these constructs".
