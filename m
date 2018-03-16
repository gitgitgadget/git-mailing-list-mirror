Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E8841F404
	for <e@80x24.org>; Fri, 16 Mar 2018 17:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751855AbeCPRjn (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 13:39:43 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35212 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeCPRjm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 13:39:42 -0400
Received: by mail-wr0-f196.google.com with SMTP id n12so12531210wra.2
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 10:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=j1y9wb+hvc+dGWu9jYFB2r459/9PiuCdn1KoDmSuAxY=;
        b=CCQFLUSQE52TEhR1NUewlRm2p9KBkfQwpEnOMXKjuLBOPdFfUbDR0JnVbcGsRW3dxJ
         KcrkgpkkKu2V61gs+I78ozKKHP9BBK3+RVIUri7jellxPw0L6M1ksNjv41PQ38awYF9Z
         7SoiswOW5aP7P87xPoMbsaB8dNQjr0wJ5XKh4Yg1XP6tmHPzespCs61wyK3oylOi6kau
         YziZgdUoevS9wh+22lAse1mxb66A3Z4i9eW4K1GkgM03+CyPIS9md6YWNiKfgcwV33le
         +trYT/mHmUUrafuV1/T6bCV4df7gRujiu10CnUBKHg7MJI1FDD5JExukahQwBcPGv4eF
         FrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=j1y9wb+hvc+dGWu9jYFB2r459/9PiuCdn1KoDmSuAxY=;
        b=p9hdUmnPITGlOjMqeN5YUnLcqVLGgJo9r8rFki3wW/75aP/6Pusa0qfpnksjbfLmJ1
         xtINpTXHzWpDNM/3ShuTz4dImp3O9JBDgpBhPSOsiYn01BY2RSIL70XU4GRtqTy1V9MD
         gclz+oXnrazxNTcyYP5ECQ9TaaXzuKRmfB84MoZBOlH6gX9mVSOzOTdUb+esG/pfy3c9
         wBdnUJOoKgwFCaNcRVDoQTWWRxrUgy7q0jb83lK6gnvoOjNd7pM/OJ879LLKDwPCl7Dn
         VNJJBG6ajhN/hHcQ62ZlOCEB9sxIC2iBzEP5tQWYCuLPeGM9VRpKFpZh6IMy5u2av+pM
         DerQ==
X-Gm-Message-State: AElRT7HtHggbk+UcDXyvkNU5cRUp8MIa3O5jbUdxOSBBVndpjgYFKdDb
        bsPNQp8HGe6Vu1E3Fky3UTM=
X-Google-Smtp-Source: AG47ELskFYSJ1FDnLqEUfP06ON34C4VGSaQlIeiOCULC7GA/pW+MgFmuier78WUWXc1oo+2x3/UwQg==
X-Received: by 10.223.181.152 with SMTP id c24mr2515743wre.233.1521221980879;
        Fri, 16 Mar 2018 10:39:40 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q77sm6034039wme.41.2018.03.16.10.39.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 10:39:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Morten Welinder <mwelinder@gmail.com>
Cc:     lars.schneider@autodesk.com,
        GIT Mailing List <git@vger.kernel.org>, tboegi@web.de,
        j6t@kdbg.org, sunshine@sunshineco.com, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        pclouds@gmail.com, Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v12 03/10] strbuf: add a case insensitive starts_with()
References: <20180315225746.18119-1-lars.schneider@autodesk.com>
        <20180315225746.18119-4-lars.schneider@autodesk.com>
        <CANv4PNmx9ok0pYxQD1TLfTveWyF8LqhhvT_JpvqrnP8q6+UbKg@mail.gmail.com>
Date:   Fri, 16 Mar 2018 10:39:39 -0700
In-Reply-To: <CANv4PNmx9ok0pYxQD1TLfTveWyF8LqhhvT_JpvqrnP8q6+UbKg@mail.gmail.com>
        (Morten Welinder's message of "Fri, 16 Mar 2018 13:33:50 -0400")
Message-ID: <xmqqlger3oo4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Morten Welinder <mwelinder@gmail.com> writes:

> You need to cast those arguments of tolower to (unsigned char).  That's
> arguably a bug of the language.

Don't we do so in git-compat-util.h already?
