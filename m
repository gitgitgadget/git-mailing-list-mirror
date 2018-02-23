Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 466B61F404
	for <e@80x24.org>; Fri, 23 Feb 2018 23:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751910AbeBWXS1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 18:18:27 -0500
Received: from mail-yw0-f173.google.com ([209.85.161.173]:38360 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbeBWXS0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 18:18:26 -0500
Received: by mail-yw0-f173.google.com with SMTP id b70so3349888ywh.5
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 15:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NP6KhBvUZWd+NhMeNyrt/XoA02E/YMXBi4YrKjKGLMY=;
        b=L3i3bpGqdivwJEcs1UwgMqwkMdB1/tqkugRWi6AeXcbDb8U3MMCPqkATbasfEGRpPX
         WAB6pWCc7PVdhj4VF9xTDiERrmu/akYcpiEEargctrQRhSmkRqRkvLoCxei/haJA6zfT
         FD4J6vB32lyb6GON1QTiM5PDeuAuUPf1N6tgHopN8IoC7ExBsZ/b0+6936emp3lgm+XT
         CLhksejsatEm1CmzbgjisD6rniQoSrHJL1tkDZluQZtNiWWB/N6ga4uKE2GK9T+VGgBq
         paQnq9ffTsdmfRfUFE1Hs5pd61wWYyZHlGAvPMBZEiBIPIDgMpIi+RP0vxcKnOkdYUmv
         B0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NP6KhBvUZWd+NhMeNyrt/XoA02E/YMXBi4YrKjKGLMY=;
        b=iYEAPfFaUKA+TUsz1+Aco6y/4CHvxQYczrv5cimQn3BbLvcr3gQ32f+eJuEs9FmFSQ
         iSqexptHvWHRNIC+VGjkbsaStZDm0gG8dvEBHVHkPr9K2ICUySRUMgP8phnFDpHY99hE
         DUMGRTabkN8qsHTvO4LNNN1NQ52nFIZ8D+21qZsUX5/rVM4rcrFb8C1klpUiXdcX5AiO
         R5kZ/KtKiQ5pg6jCxDpl1inkHUaE521c7F0AGCJiNvfO7jeyrjyMPfqRvYhSpcvaw2VG
         nIhjeDcqxnUbV91YVtWhkSdrJEPh8Y4s0GSuov1KPZe4Y1jYC1kbOr0vxq+/j1UF/ip/
         LA+A==
X-Gm-Message-State: APf1xPCxplLv4WuLX4IapGpcfGjNXspvL8qXSR9tpJYee3vb948Iszzj
        J6ZGL0cw72mufSuA1Ow8PYjusdP1gZlDFJPGiEehjpRM
X-Google-Smtp-Source: AG47ELsY+TVrGpVkqYQL41pMhXSobrQ1/NZXTGaeebTXwfavGi+6YgiAqWjle8MYgZyeA7tXhx3NZhUrY+4UWlvnmz8=
X-Received: by 10.129.196.74 with SMTP id s10mr2287199ywj.33.1519427905526;
 Fri, 23 Feb 2018 15:18:25 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Fri, 23 Feb 2018 15:18:25
 -0800 (PST)
In-Reply-To: <20180221163530.3a6659b8e0bec5dfab835232@google.com>
References: <20180216174626.24677-1-sbeller@google.com> <20180221015430.96054-1-sbeller@google.com>
 <20180221015430.96054-16-sbeller@google.com> <20180221163530.3a6659b8e0bec5dfab835232@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 23 Feb 2018 15:18:25 -0800
Message-ID: <CAGZ79kZBP3tVEAFwDMGcSnuHYk2TUnAbwf3qowzJ-=hb8PdE3w@mail.gmail.com>
Subject: Re: [PATCH 15/27] sha1_file: allow prepare_alt_odb to handle
 arbitrary repositories
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 21, 2018 at 4:35 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> On Tue, 20 Feb 2018 17:54:18 -0800
> Stefan Beller <sbeller@google.com> wrote:
>
>> -void prepare_alt_odb_the_repository(void)
>> +void prepare_alt_odb(struct repository *r)
>>  {
>> -     const char *alt;
>> -
>> -     if (the_repository->objects.alt_odb_tail)
>> +     if (r->objects.alt_odb_tail)
>>               return;
>>
>> -     alt = getenv(ALTERNATE_DB_ENVIRONMENT);
>> +     r->objects.alt_odb_tail = &r->objects.alt_odb_list;
>> +
>> +     if (!r->ignore_env) {
>> +             const char *alt = getenv(ALTERNATE_DB_ENVIRONMENT);
>> +             if (!alt)
>> +                     alt = "";
>
> alt can be NULL, just like in the existing code, so these 2 lines are
> unnecessary. (link_alt_odb_entries() will just do nothing in either
> case.)
>
> (I also think that the check of absence of alt should be done by the
> caller of link_alt_odb_entries(), not by link_alt_odb_entries() itself,
> but that is much beyond the scope of this patch set.)
>

reverted to a literal translation of s/the_repository/r/, I forget
why I implemented this change in the first place. dropped for now.

Thanks,
Stefan
