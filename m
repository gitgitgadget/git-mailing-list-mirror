Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ADE41F404
	for <e@80x24.org>; Thu, 25 Jan 2018 23:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751532AbeAYXVf (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 18:21:35 -0500
Received: from mail-yb0-f170.google.com ([209.85.213.170]:38186 "EHLO
        mail-yb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbeAYXVe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 18:21:34 -0500
Received: by mail-yb0-f170.google.com with SMTP id l3so3707094ybk.5
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 15:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4cE65ZQmCmJc64SZdoTxziG9hxyoSbdjmbSs3N/At2s=;
        b=ALD3nwxE/vRddhinBBMOxKisfdNzDSW7a1mJJkUShU05pV3282AR0+Q94PNbvxCRE0
         Tf2B7JWAZuWGt0AC19oVw7Dczlb/is/GEhDXnNStYCx69/pmjcTYq4tqtgSf2ndPemjW
         ITQefONAjE2NGhU2dvN1NDDABcbaD/UgjEXduwcDlwByP5yc+qorQgwe91neMiI/o18g
         yP4fGdDYUL1E9unxJgO4T/eLNyfVFmBk2SyKMhmpTU9kWzmBEiR+ZIDmRMzp44KGwmQn
         IG6kqXzBonjk8BTz6AfnpEnv+auyuphwKxBv2Y8vRzJ7/0cn8TnBpC3tc+Kjb3BpJ07t
         ZQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4cE65ZQmCmJc64SZdoTxziG9hxyoSbdjmbSs3N/At2s=;
        b=txoAQfDuk3dTz4OY85qsiiepNw75+i+ttAXZQ2Rc9W3w40ZL9RMmmev/2tBw3ehMx2
         IkoKZsHb3dgN6vcvpuMd78Hw7wukkJtH9O/FBaERcoL3f3+oPX9R5M3blf4d7G5e6//a
         QkPGxWac9U8IiIoEFwVBy/GLOe+jIJghBjWcIzLHp28olY8ZaMY1lr38xhiM0SFFiQ7G
         zH9ZjTnjr1JctCPoJDnkZj7lHDG2Fqu9Ww26rhv8oY0mZlUBRIpSvnHT+SrMyuNOfhAX
         DOeDsmBFxaU8cH6DaE4sg6+U8W46OjR102wOXAhOTfkU4ntDvcMgkR1qUknZFuGlGDbO
         vzHA==
X-Gm-Message-State: AKwxytcHGy36IF1/C7pNU+Hw6CltjYkZZ7/vhL3SyKGs1dPfKDyBQLWO
        anjzSMsgLcSEr1qebW27XnM5rhT1rYY/Zf/k8DAL/A==
X-Google-Smtp-Source: AH8x226FMcssia+R6yky9b+NIaYTV1IVzlyqv/fAHYCxcobGqm8ushI3fAOB1TyrMwKyqURuf/2HvHRS4QOAFYdqZpM=
X-Received: by 10.37.219.83 with SMTP id g80mr9839289ybf.201.1516922493622;
 Thu, 25 Jan 2018 15:21:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.210.209 with HTTP; Thu, 25 Jan 2018 15:21:33 -0800 (PST)
In-Reply-To: <20180125140231.65604-6-dstolee@microsoft.com>
References: <20180125140231.65604-1-dstolee@microsoft.com> <20180125140231.65604-6-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 25 Jan 2018 15:21:33 -0800
Message-ID: <CAGZ79kaNj-+oBNmbTKtOE8P-ZFcBVZSaBtwzrB4RQTWnYXcoqA@mail.gmail.com>
Subject: Re: [PATCH 05/14] packed-graph: implement construct_graph()
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 25, 2018 at 6:02 AM, Derrick Stolee <stolee@gmail.com> wrote:

> +struct object_id *construct_graph(const char *pack_dir)
> +{
> +       // Find a list of oids, adding the pointer to a list.

Comment style.
Here is where the bike shedding begins. ;)
