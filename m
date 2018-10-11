Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 657A41F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 08:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbeJKPvR (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 11:51:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51799 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbeJKPvR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 11:51:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id 143-v6so7993500wmf.1
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 01:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=py1zbIaq5wqMeIpYhmwUWC839mb+/V97AeTvSoVs/gg=;
        b=piZOjzV8jTTPt5WwbsSH8+rM6fqVx7sADtuNU6CoUB42w9tiOraVqiQVsVFp7Xdksv
         kiVVRR1YTAsANgIrFXFt+cNw/K0IS0Ye6yeMjHnuB3400YcuBL9YPqMGypC2PFLTxgEZ
         P2o40FCkqpHvXYV0Lk3/Rc6e9qIIfsR3y6al9gwoUuFttuywxtLmN9RMVOfSDf9JvSIF
         Js58Kbw1saiUwgDRaLpW7v1aesPilTfBz5gA6HidkpTAWb978HVdHzRjo76QPYx+M9P4
         wytjHcDNP95cFVavZUoBeMgDSvV43K5nLC3XeanqSk6g3q5Wuo7WgTDabpxVWu6rLFPx
         KIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=py1zbIaq5wqMeIpYhmwUWC839mb+/V97AeTvSoVs/gg=;
        b=ZwxoE0ipYjsSqPHFRVqXa4nXUvCmixpsCNJFnNYrbWmcG9gTsZswq0ZkmL5ikYwgSs
         V3GHh6+BP080uOnuve41urUzVb3+nShYSyjeq9ITVDv4HEDSFt0G9ai6dMSW9Oa80LGQ
         Ax0TkAg3GNYoSvdAxp0oAZSuVRwQoCMyOfyT70hZPZwDK4oypvMDVuji+4brS+/9wHfP
         zcT26ZloWgJuf2U5sl6bs1keitFXOTqNvBr5L+e0ZoUbztFWgjw7DyMFPN/q2KAoTT+2
         Ny1zmrQfqcUZ35CnvOy2rGREqsjGTVulM74+WI8zEfDyAbs3a4C1a7ydgNHO+wEQ9f96
         4JtA==
X-Gm-Message-State: ABuFfojUUUO7VyksPwAR0HUNMtyZ6rdVgQCkTOhpjIAnGKkGowncyxGi
        UVVIuGlVpYinNge7iGYpOBs=
X-Google-Smtp-Source: ACcGV60tkdz6nDFHprAU/9rDgnwJnPEh7PSpCaLbxHzzbX8PCVekWzyOzCCH7/t8xiYDOdnLOz0KEQ==
X-Received: by 2002:a1c:2846:: with SMTP id o67-v6mr775909wmo.60.1539246303935;
        Thu, 11 Oct 2018 01:25:03 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k63-v6sm18404308wmd.46.2018.10.11.01.25.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 01:25:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        lucas.de.marchi@gmail.com
Subject: Re: [PATCH] range-diff: allow to diff files regardless submodule
References: <20181010150916.4295-1-lucas.demarchi@intel.com>
        <87in29dj55.fsf@evledraar.gmail.com>
Date:   Thu, 11 Oct 2018 17:25:02 +0900
In-Reply-To: <87in29dj55.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 11 Oct 2018 09:42:14 +0200")
Message-ID: <xmqqmurkgaap.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Wed, Oct 10 2018, Lucas De Marchi wrote:
>
>> Do like it's done in grep so mode doesn't end up as
>> 0160000, which means range-diff doesn't work if one has
>> "submodule.diff = log" in the configuration. Without this
>> while using range-diff I only get a
>>
>>     Submodule a 0000000...0000000 (new submodule)
>
> I'm not familiar enough with this to tell what the real problem is
> that's being solved from the commit message, but if it means that now
> range-diff works in some configuration, presumably that can be reduced
> to a simple set of commands that didn't work before but now does, and
> therefore a test in t/t3206-range-diff.sh.

Yes, I agree on both counts (i.e. it was totally unclear what
problem is being solved and what the root cause of the problem is,
and we would want a new test to protect this "fix" from getting
broken in the future.

Thanks.
