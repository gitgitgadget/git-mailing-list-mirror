Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63A791F51A
	for <e@80x24.org>; Fri, 11 May 2018 18:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750852AbeEKS7d (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 14:59:33 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:40991 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750722AbeEKS7d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 14:59:33 -0400
Received: by mail-yw0-f180.google.com with SMTP id q125-v6so1872855ywc.8
        for <git@vger.kernel.org>; Fri, 11 May 2018 11:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=05iOtVk264Oq8uh9uZNtm+SE3pwcW7qNtJaaH6m4BPA=;
        b=roRWhSrEG9HHIhHbZBc7vhcC8a8uV7HCW9r12nSO0J19o2UanvTj6wu1/YyrQbAgcZ
         cB486kQSwEwrDCp3cT7REKWJQpnZIaWTaeaPyX7+if5Wypcwq79rSFrSgXe1zPl9VzGY
         wMP2DFpoMMsLZhvuuqZsym1SDWtfDzl1d/FkKw/1FieHtkx3DkjTp70/XWHxwL1LFnVR
         3cu2WW6v5GmTKaZO7k6WMUrc8OJ9QVuqQL+vUTJExyvWpxCj8JJg6sy2TG1bMt3SMcJB
         21yyCxQ0D1VadboddvQxE8I/kayOudtv+5ZTSeG5LPNoT+6opuLKZ9PDVq2zfLDhaZJM
         OdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=05iOtVk264Oq8uh9uZNtm+SE3pwcW7qNtJaaH6m4BPA=;
        b=dYXp2WJsXmB1vMOYZHeIHOkXNaC/k3yf3YkrM2M9KBqov9KXm9xf28CjTXihADznwD
         jauN/uHSH42YhxHD1K6NmblA4JhIK6L45CZQaVE/cOUwt9pANprvMuSdGTnmu2G7+Dqh
         a8wIy2b70E/VNhlrxzgeECN1Qd8iCDfwTxnW8/dT2Zl14p4u9znn0Echg7vCJcMN7ykf
         JK4lFjErW67rfBQ+IdbiUrDlsISWpf3Qj/eDIYV7X80f5sPc9arc8OnJIjiMoVmwQP77
         qW65yNtwMP2W94aVr+Ny3eCts75CaMjEQXTlEPZAKrryGjzwfoU1GmF6cMfF/Cco3Nsd
         Q5pQ==
X-Gm-Message-State: ALKqPwdoT/oZY5vNlrcIaDdx1SnILnqqg4JWtwEHbY0GHW/vMlZg+xa9
        nRChY1jJYIRd47C9hjpxD/tM1UrC6sZFNDQXb1zOHE0X
X-Google-Smtp-Source: AB8JxZp/4NRf5+3SNSkyjg7UG6ZdPJ3VFoZjfz13NDruvAjLcXMlWKR04lwx3F99+tUfDtva95byxtA+FbTt4ePo8w4=
X-Received: by 2002:a81:4ec9:: with SMTP id c192-v6mr110455ywb.421.1526065171965;
 Fri, 11 May 2018 11:59:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cfd8:0:0:0:0:0 with HTTP; Fri, 11 May 2018 11:59:31
 -0700 (PDT)
In-Reply-To: <20180511083723.GB22086@sigill.intra.peff.net>
References: <20180510195849.28023-1-sbeller@google.com> <20180511083723.GB22086@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 11 May 2018 11:59:31 -0700
Message-ID: <CAGZ79kafGk3YPu1yuagHJRZYxpHpRUoCbSH0JCeLrdzz9ehOvQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Fix mem leaks of recent object store conversions.
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 11, 2018 at 1:37 AM, Jeff King <peff@peff.net> wrote:
> On Thu, May 10, 2018 at 12:58:45PM -0700, Stefan Beller wrote:
>
>> This series replaces the two commits that were queued on sb/object-store-replace,
>> fixing memory leaks that were recently introduced.
>>
>> Compared to v1, I merged the two independent series from yesterday,
>> rewrote the commit message to clear up Junios confusion and addresses Peffs
>> comments for the packfiles as well.
>
> Mostly. :)
>
> My one remaining complaint is that the bitmap code may hold on to a
> dangling pointer to a packed_git after this series.

Ok, I'll look into that.

>
> I think that is part of a larger problem, though, which is that the
> bitmap code's globals need to be part of the struct raw_object_store.
> I think this can already cause problems before your series if we were to
> try to use bitmaps in both a superproject and a submodule in the same
> process, though I think we'd at least hit the "ignoring extra bitmap
> file" code path in open_pack_bitmap_1(). So right now it's an annoyance,
> but after your series it becomes a potential segfault.

Ok, maybe we'll need to convert bitmaps into the object store for that.

Thanks for the pointer,
Stefan
