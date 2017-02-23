Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B7CD20254
	for <e@80x24.org>; Thu, 23 Feb 2017 09:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbdBWJNW (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 04:13:22 -0500
Received: from mail-wr0-f175.google.com ([209.85.128.175]:35696 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751275AbdBWJNV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 04:13:21 -0500
Received: by mail-wr0-f175.google.com with SMTP id s27so17718614wrb.2
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 01:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:references:cc:newsgroups:to:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=DjTdsM9a4B45nHTNqHpoRkGa68UqGt69YVJYZoOc6hM=;
        b=XiRKnLsyhMaVspOJ0murZbOio4IjOhS5+LrEVJXyfiDf/If5gmrcR4jWAKRYWsT3Ya
         vMa+pKt36tKWyANIfPO0VzYvv2foB9jDZlRXFbPo/pVOs5FL1d7YiCvaPiut973Fei6N
         ja0ltni7vhE8cXUSdDwJkgQH/PMzPY7AYPzqCwTsgUBfq0xRrnC3bfEUsOyvMmQUFahC
         iQpUMuM/ABOVCwFweb9reEXdPq1lwvquhJnrFPDgm1vPTiUy9U6OryBAJAGMAJJqzZ/o
         CXcY6PO/uO928a5xHL9VbjmGvVqEWFeGiBFCblYc2yUXCCZen4TsYOZ0DxHn3IqTxA/T
         WeAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:cc:newsgroups:to:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=DjTdsM9a4B45nHTNqHpoRkGa68UqGt69YVJYZoOc6hM=;
        b=JarQPhrLHM8UnhM9+AKYLKkwiz6OjXW5+zMRUAlBYvH+/PdBKaA1jgzaCj2SqQ1A4O
         pOKEizszCnJFqwWS09qtgEoKVdymJVJIZmYXMQbDOx/sCb3CKszrbixlh8dg84bBwTt1
         +i0GDaTavx8P8UcIyVbiv/Um/VBqa0KCyF/Wn6ThvQlpz3fkDgMzerqnBr76M6+Bgc+C
         4RJ+NmyObyOxyO63WNJ6mzymx1TtGRuT9BqJuE8cwl0q8toCUnwYkh1Thn9yjGfuu9Cw
         UXUjnnMEPAKvqpKcaXFgh6bMaYUQzWtvnzee0aQy2KaKveyppjg1fCxz0Xc4LF9Z9QDx
         eTcw==
X-Gm-Message-State: AMke39nxEqNmfDfTML2EfdTb4GFmwWhPCcbkgBWB/eWaSus01lB25UwRMa79E7yKluv0Gg==
X-Received: by 10.223.153.174 with SMTP id y43mr27882366wrb.55.1487841195231;
        Thu, 23 Feb 2017 01:13:15 -0800 (PST)
Received: from ?IPv6:2001:778:e27f:a23:36c4:e19f:3c1:8a8? ([2001:778:e27f:a23:36c4:e19f:3c1:8a8])
        by smtp.gmail.com with ESMTPSA id o70sm5485378wmi.26.2017.02.23.01.13.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Feb 2017 01:13:14 -0800 (PST)
Subject: Re: [PATCH] http(s): automatically try NTLM authentication first
References: <20170222173936.25016-1-dturner@twosigma.com>
 <xmqqpoiaasgj.fsf@gitster.mtv.corp.google.com>
 <97ab9a812f7b46d7b10d4d06f73259d8@exmbdft7.ad.twosigma.com>
 <20170222233419.q3fxqmrscosumbjm@genre.crustytoothpaste.net>
 <b152fad7e79046c5aa6cac9e21066c1c@exmbdft7.ad.twosigma.com>
Cc:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        'Junio C Hamano' <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Newsgroups: gmane.comp.version-control.git
To:     David Turner <David.Turner@twosigma.com>
From:   =?UTF-8?Q?Mantas_Mikul=c4=97nas?= <grawity@gmail.com>
Message-ID: <d5375d24-cfdd-2348-84ae-b878c4aaa369@gmail.com>
Date:   Thu, 23 Feb 2017 11:13:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <b152fad7e79046c5aa6cac9e21066c1c@exmbdft7.ad.twosigma.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-02-23 03:03, David Turner wrote:
> Actually, though, I am not sure this is as bad as it seems, because gssapi
> might protect us.  When I locally tried a fake server, git (libcurl) refused to 
> send my Kerberos credentials because "Server not found in Kerberos 
> database".  I don't have a machine set up with NTLM authentication 
> (because, apparently, that would be insane), so I don't know how to 
> confirm that gssapi would operate off of a whitelist for NTLM as well. 

NTLM and Kerberos work very differently in that regard.

Kerberos is ticket-based so the client *first* has to obtain a ticket
from the domain's KDC, so a malicious server at minimum needs to know
what principal name to provide (i.e. which real server to try
impersonating). And even if it does that, the ticket doesn't contain
crackable hashes, just data encrypted with a key known only to the KDC
and the real server. So the whitelist is only for privacy and/or
performance reasons, I guess?

NTLM is challenge/response without any third party, and yes, it requires
the application to implement its own whitelisting to avoid the security
problems.

-- 
Mantas Mikulėnas <grawity@gmail.com>
