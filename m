Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178D3C35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 00:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD0B22084E
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 00:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvae6UUK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgBDAAz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 19:00:55 -0500
Received: from mail-io1-f46.google.com ([209.85.166.46]:35695 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbgBDAAz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 19:00:55 -0500
Received: by mail-io1-f46.google.com with SMTP id h8so18899825iob.2
        for <git@vger.kernel.org>; Mon, 03 Feb 2020 16:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to;
        bh=LdYKTrRkmONm6VCAQWjQ2DBGqP/eMWyegKS0suQb8aI=;
        b=cvae6UUKIDlpmx5vm11INX+BpnVioG8HBUjDEZDYzn/z+gDveDYilDfExCHc6ykGBc
         JqmnCQL1dVD8k2JrOKoUHXq6cS4Uho6VfaICLIYXtd9kQdsGGJmq2z+zzVcHKSi+hnpm
         nIFCBDF3mNuqWkqYmyExNPB0eIQJPZmJUWoBLs8Riba5C12p8WhwZwd7AF5GLm9Npwlo
         cNm1GMWuzhAcRZQApyt7G0bhSfzx9YD0f7Bk/tlcTdo3zpcYhIUdU48w6juLG9ILZsuZ
         lZm4/hmSSW5Jdi3oMz8lV122ZUJs5xe2AkjyPibWy+vxDPdGw6cFIoS4eCzcELy+Mr2X
         aEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to;
        bh=LdYKTrRkmONm6VCAQWjQ2DBGqP/eMWyegKS0suQb8aI=;
        b=IDZLVtsJJXEgfpCMBUN5TXWhWWXiDV8TB6UyCv4zgMmT0awJ5rOj7IX6cCRip2pJp7
         Mg32VMWMyESEHeZgrzVoQeNHaoPVh3Zvv3zvMW23Su1W0fGV6843TAO2QE/JZA8klRcm
         acoC0RS8PjI6KVGhnT4SfqFaQrJcSg39zVqbUve7efZYijnnAH6hPvV6hBBt4uzMwubX
         yjFTNxEt2kenHwq/2l1gScvONX/SOP17q5HeDvfj9VdFcMcPgFRXl9qrnKJSyk/x1RZz
         wxSl8qKtdyCPrt/4gD+65Gp4igZMrG8A4FKDC0t9uyusS0uKNOI65KVKLjIYZH52lpLq
         Rszg==
X-Gm-Message-State: APjAAAUGwGj6VoKdB+RDiZ2gL+sFW7WqkLmox8UT7r9OK5K1jxZ+qZan
        jERWFoZn69SXIPJGdQ60WWci40pYJ3zffyenXB/0bg==
X-Google-Smtp-Source: APXvYqybVn5Ha7a2aDfXBddDD3vQPpcV+Gt2f/iTGtgyPQ0xpRqlRuxj9ninLQW9VrAgvA02xcQYP9VQQI4jVMfHsRg=
X-Received: by 2002:a6b:b74a:: with SMTP id h71mr20492337iof.212.1580774454686;
 Mon, 03 Feb 2020 16:00:54 -0800 (PST)
MIME-Version: 1.0
References: <CAH8yC8kaWXbN+RYMJnM9em7KKW54+N07JtyS1MZk0qppD=m2BA@mail.gmail.com>
In-Reply-To: <CAH8yC8kaWXbN+RYMJnM9em7KKW54+N07JtyS1MZk0qppD=m2BA@mail.gmail.com>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Mon, 3 Feb 2020 19:00:43 -0500
Message-ID: <CAH8yC8njDV9t+qF=EwFftVW5OkwKzaDMR-7ZGOBnqPbdt1R95A@mail.gmail.com>
Subject: Re: Fix inet_ntop and inet_pton on Solaris
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 3, 2020 at 10:22 AM Jeffrey Walton <noloader@gmail.com> wrote:
>
> Hi Everyone,
>
> inet_ntop and inet_pton were not being detected properly on modern on
> Solaris. This patch revisits the the socket gear configuration on
> SunOS and brings it up to date for Solaris 11.
>
> According to configure.ac, the three or four functions of interest
> include hstrerror, inet_ntop and inet_pton. The libraries of interest
> are -lresolv -lsocket -lnsl. The configure tests now look for
> inet_ntop and inet_pton in -lsocket -lnsl per the man page. If not
> found, the configure tests fall back to existing behavior by searching
> in -lresolv. And if not found in -lresolv, then NO_INET_NTOP and
> NO_INET_PTON are set.
>
> Here's the configure fly-by:
>
> checking for socket... no
> checking for library containing socket... no
> checking for inet_ntop... no
> checking for library containing inet_ntop... -lnsl
> checking for inet_pton... yes
> checking for hstrerror... no
> checking for library containing hstrerror... -lresolv
>
> And config.status:
>
> $ /usr/gnu/bin/grep -E 'RESOLV|SOCKET|NSL' config.status
> NEEDS_RESOLV=YesPlease
> NEEDS_SOCKET=YesPlease
> NEEDS_NSL=YesPlease

The patch tested good on Linux (Ubuntu 18.04), Solaris 11 (SunOS 5.11)
and Darwin (OS X 10.9).

It is the same patch used for Git Master maint branch and Git 2.25.0
release tarball.

Jeff
