Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DF931F403
	for <e@80x24.org>; Fri, 15 Jun 2018 06:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755769AbeFOGgT (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 02:36:19 -0400
Received: from mail-pl0-f48.google.com ([209.85.160.48]:44980 "EHLO
        mail-pl0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755723AbeFOGgS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 02:36:18 -0400
Received: by mail-pl0-f48.google.com with SMTP id z9-v6so4839527plk.11
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 23:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Td/9UPVdUYtIa1bFpAJvdisa7aT9jm+kaTl1wYcu5yE=;
        b=jx3v0bgIDWVdIRfKo5VYxqdqZPjR5kGzzKm9uzCY7OS/b/fRUMl39qSN9uX+igjjUs
         BbnOk6X3KtwMgyR9w4pExba6oJukd3K4XkZNk8ppnqv//VAX3xKItGWAvNGtqqcCT0g7
         XPUTOV1ROeNJs+ytFGnyoH4XUuOwTF+IHhZRcmp1Q9GdJ+T4HlDM8Co2BQNBiuqShPHQ
         pOFMqTPnXOWpiKVL/feYze6/ryUDpMaX3LriNHgbPuBPPQkkc9GK62Bx91eZeOXPTv5Z
         Wy3G35o+mgPrN9J1BoN8p3/lE78UPKpiPepiuosUufIurewFdFddTs6kCsWTfnmZVrel
         S0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Td/9UPVdUYtIa1bFpAJvdisa7aT9jm+kaTl1wYcu5yE=;
        b=Z02NjwHaWBmy8mKmxICct8zBbJOCOnFF75RszdsScqNUuzgNuIUffa+h5A2ipQnPJ6
         rnFDmofik9WICrzXWHGB/97TATq2awPhzllHtngIw/HjvLgzG4RKz43eG2j/Uh++17lH
         ZckPRCpWDnsehN5mP62ZMFTD9KjvXGI+OpQPEWLy27p2t2GLiXUNHWoDdBK0kRuzAqzk
         89bMXla/0Pte54cwGjB/LTi0sT1Rlh3J87oN0U3nkT4NhE6KA5iw9jrVEsgX1bxUPHf5
         9GXh9rLq946xZG7hxL3CMBK/Mjp2XLLGHwhY8+67hntzloM+Ng0HTydxNUZJka1ShNWQ
         MxEg==
X-Gm-Message-State: APt69E2wkNkiGzDNbkiRzUf/GxBN3QjfpfqydlS2448HtdA/3J/+v2bQ
        W8qyFScFa7+cnnaVFuD2ZAi1kQ==
X-Google-Smtp-Source: ADUXVKJ6LNvHjeJjWNA3ldVSkNwVQEEV7cvQpau681qIvlIwD1144PuRbayJn8ECwWC5uwq2qDGDfg==
X-Received: by 2002:a17:902:a416:: with SMTP id p22-v6mr518431plq.228.1529044578122;
        Thu, 14 Jun 2018 23:36:18 -0700 (PDT)
Received: from [172.22.44.62] ([103.233.242.8])
        by smtp.gmail.com with ESMTPSA id j3-v6sm8479958pgp.47.2018.06.14.23.36.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 23:36:17 -0700 (PDT)
Subject: Re: [PATCH v6 1/2] blame: prevent error if range ends past end of
 file
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com, peff@peff.net,
        bturner@atlassian.com, jacob.keller@gmail.com,
        sunshine@sunshineco.com
References: <20180531050030.43364-1-istephens@atlassian.com>
 <xmqqh8mnb8j2.fsf@gitster-ct.c.googlers.com>
From:   Isabella Stephens <istephens@atlassian.com>
Message-ID: <db426610-90e3-e936-b630-a3d83e345e79@atlassian.com>
Date:   Fri, 15 Jun 2018 16:36:13 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqh8mnb8j2.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Don't t800[12]-*.sh need adjustment for this change, too?

Apologies. I will make sure I've run the whole test suite against my patches in future. I've sent through a 7th (and hopefully final) version.
 
