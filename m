Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 205D820960
	for <e@80x24.org>; Thu, 13 Apr 2017 19:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755576AbdDMTMY (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 15:12:24 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:33821 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752196AbdDMTMX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 15:12:23 -0400
Received: by mail-lf0-f52.google.com with SMTP id t144so34207525lff.1
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 12:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=s6skOMMKM+YgNFmcVysm+36Ukf6wU+wfhmZrB1Sk9kQ=;
        b=ozBVudknHvwDO3VVflWpvrgoJTum4zdDbcj3kywnNTde7Eb+nu3OHZmtU1w2AHvy/F
         vOimdUdN7gdO5v5WuXC2OpZoRvacbQoRmx5eP+U7aNc8ugf42BE4xXyDi5/Ylk0bGQoc
         zhK/WaIuyxLrKmLDGU9FRAzBP+TMeXpzAeCLweDxLneWIF2J1gC3CS9QmVTKvLZq/++j
         3SucHEzbeIAilZf5ULqEyJZzKX4EZDkJzcgDyJG7lLRdmZ6KOKGDuWv5C0sbwHB3CENT
         VzkLx6rMOrKbXrKNjkL1KyG3JuMC1tQkxX1yihwNpyaxZQXUO5SZqfcjWQJOl/Tqhq6O
         VYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=s6skOMMKM+YgNFmcVysm+36Ukf6wU+wfhmZrB1Sk9kQ=;
        b=V5wgwmbDVfvSF7iahP9Yo+vIlz/lJT8on+BlPijUS3fIEqhtRuxXtWxRyLbyxOdJiI
         Ggd/hbhdk9ffDhymLgNcff8ZHNoT4hg3wrgpw/caWyA51ZtJwc0SqiEYbcKn9V9+pqSn
         GUfEBvbMZaCA2YvtO1o2XaBqng2ByRYMRdhfuPwPZLcH0Tl+30TxrOcPS1jTBO2xwxsL
         W16XU54smL3Vl/2qVoSoYgoqdJb2IK0suvQaFHnVrSEFlOJpbqxeJgSAbw6zi4rLd4+r
         BHKJilx+8ZDxjOnujYwcB6+LeAB/CKOMtwPEDTaQzNtycG/CwR2wtoXJ/BIDo9Ck89C0
         urqg==
X-Gm-Message-State: AN3rC/5nAU1SOV6eoEux0X1GIP92wn+wh5/UonLsZsehWOVF+tOTjfV/
        jQ8ZMyp7EvrvCOBPHCxvVPoOLFejMXB5
X-Received: by 10.25.141.73 with SMTP id p70mr1852824lfd.147.1492110741695;
 Thu, 13 Apr 2017 12:12:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.17.155 with HTTP; Thu, 13 Apr 2017 12:12:01 -0700 (PDT)
In-Reply-To: <CAGZ79kZ8KV+c2StKR8tp=s_E1+uEaSezgsmUfyyO9HUrmzdT+g@mail.gmail.com>
References: <20170413171224.3537-1-jacob.e.keller@intel.com>
 <20170413185707.97746-1-bmwill@google.com> <CAGZ79kZ8KV+c2StKR8tp=s_E1+uEaSezgsmUfyyO9HUrmzdT+g@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 13 Apr 2017 12:12:01 -0700
Message-ID: <CA+P7+xp=1PUsq1_or=J8ED+-1NMaF=BckC9bK4jqWbA+RFeszw@mail.gmail.com>
Subject: Re: [PATCH 3/2] ls-files: only recurse on active submodules
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 13, 2017 at 12:05 PM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Apr 13, 2017 at 11:57 AM, Brandon Williams <bmwill@google.com> wrote:
>> Add in a check to see if a submodule is active before attempting to
>> recurse.  This prevents 'ls-files' from trying to operate on a submodule
>> which may not exist in the working directory.
>
> What would currently happen on recursing into non-active submodules?
> Can we have a test for this?
>
> Thanks,
> Stefan

We should be able to test for this. Is it possible that we can recurse
into a submodule as long as we have the clone in .git/modules/<name>
even if we don't have it checked out currently?

Thanks,
Jake
