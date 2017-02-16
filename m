Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE4111FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 22:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933596AbdBPW4l (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 17:56:41 -0500
Received: from mail-it0-f51.google.com ([209.85.214.51]:36497 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933157AbdBPW4l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 17:56:41 -0500
Received: by mail-it0-f51.google.com with SMTP id h10so8351604ith.1
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 14:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dUC6TMXZMyz3vOEdDcQsO6OZSQhCsqOuuu6LIFPActg=;
        b=dtM/Nqje3b+NKj0tHD8W9Wung2DEUxufiZy0T8sjQasrqFfT3qOj2TpNdAMEF7ziDv
         IpLZGUhTXMKhrkq+83v2scU63yRgMGIccK9JnF7vWMb3yz58131tl9rURfbnZ2zWKzXL
         5wcvVFQihUOCnOwypaHZnQf/Z803nSlG1BJfOu1o7y1rGU5mlkVaVs2airJWC46S8bNe
         z2b0ohPrlyH4W6fs1uDQXKpEEHRg8RirFEER5Gqli2jWdslTseYkWdiuN0FokbiS4Mj4
         uX13+cwEwrylJhNhTrJ1yNdGSgXpQIdWVJXGIFn/9aYK4SgVKoyUuwtE0KZwFLEgpqhX
         LEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dUC6TMXZMyz3vOEdDcQsO6OZSQhCsqOuuu6LIFPActg=;
        b=iw1aEwGVK6XsGiqxNrDRH7VaxZZoti7XbXnbY+pcvg9cloPv+nUy0AENT6+7P3Ls9w
         ZQbYlNfe+Dp1TPDP1n69GnUVJ4qYGr57KA+wuek+jMBwcavK1/nVxuZUSIn/mK/VxZ1N
         VslvtgF6Lh3dNbfR0bSdrPiStwQQEOtb3DOiohH3TWdMiGAp/60BdoM3otuN1LutRGpX
         q9K5qzFxolFthURLKE6x9i1dTyOVRvIsnfyn7qx08EgZs+heJRbshRSjMxfuyidCa/k4
         5iB5PvCI2rfqa4YDl/7s4BMKEoxyqBvNKc2PxT5ey5GRdyeURJs8v+Zs8OEPkeWAjYP5
         tQlg==
X-Gm-Message-State: AMke39kGwWdTW3NaWZ9ONoa8FPDEMCgqNEgP5393Fp8DLD9TdDbSm/uQWNpkxaSMOuSNwZ5AUiC9TzaPZ1fDLDPF
X-Received: by 10.36.65.161 with SMTP id b33mr4556042itd.114.1487285799935;
 Thu, 16 Feb 2017 14:56:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Thu, 16 Feb 2017 14:56:39 -0800 (PST)
In-Reply-To: <CA+P7+xpWqiWeMOMauYgtVaiUngd73_dUqRxyWcp0QPHvgOe+vg@mail.gmail.com>
References: <xmqq8tp74823.fsf@gitster.mtv.corp.google.com> <20170216003811.18273-1-sbeller@google.com>
 <xmqqlgt5vlse.fsf@gitster.mtv.corp.google.com> <CA+P7+xpWqiWeMOMauYgtVaiUngd73_dUqRxyWcp0QPHvgOe+vg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 16 Feb 2017 14:56:39 -0800
Message-ID: <CAGZ79kYQf2SL-RVETv8=6NaZHhub2kQmKevK32X_xfFkr_0yyA@mail.gmail.com>
Subject: Re: [RFCv4 PATCH 00/14] Checkout aware of Submodules!
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2017 at 2:54 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Thu, Feb 16, 2017 at 2:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> Integrate updating the submodules into git checkout,...
>>
>> It was more or less a pleasant read, once I decided to pretend that
>> I were a machine who uses identifiers only to identify locations in
>> the program ;-) IOW, for human consumption, the new names introduced
>> were sometimes quite confusing and went against helping understanding.
>>
>
> Based on my cursory reading, I agree. I had trouble understanding how
> the process worked because the names were somewhat confusing. They
> started to make some sense as I read more. I think v4 had better names
> than v3, but they were still somewhat confusing to me.
>

Now if only you could tell me what names were better to understand. ;)
I'll reply to the individual patch remarks and hopefully there we find
good names for these functions.

Thanks,
Stefan
