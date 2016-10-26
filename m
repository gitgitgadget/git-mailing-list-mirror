Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C8FD2022A
	for <e@80x24.org>; Wed, 26 Oct 2016 23:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932702AbcJZXKG (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 19:10:06 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:35135 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754265AbcJZXKF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 19:10:05 -0400
Received: by mail-qk0-f178.google.com with SMTP id z190so23156208qkc.2
        for <git@vger.kernel.org>; Wed, 26 Oct 2016 16:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=C+yoEpkemtvDewj6lgZg9Iu/4FQA59tlT5ELRb0mgdc=;
        b=e5KsmSYrW31GKthzIrdMeruwZbIZZlPLr7cRSqi1YDtOTaH0YvSSA+zLl+e1QWzQ2c
         HtBajzN96njxM0VDsERUeBtudLPHQvcoUBzEc8LyPxTSTkh7oO3aG/j24NtwaqwIRBSJ
         MEUVJFyP90tw/Uin4nP9YNawvO71ChVS94+r1aAxn6psoKyAqioCVdEstqA7/gcsrnU6
         GbvmPHpFFoVrXinoZATjSXkQ5LEtRIGdlNrGcIZe7/tI0gJlL/tMix+EZJJWy7gthYrt
         y7SKfjvCwafnH3Km9uFKo4Vq3d+uPE46/SFA3sW7koD7/8ImqrhDtU0SX6kJ4IXpVZ59
         thRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=C+yoEpkemtvDewj6lgZg9Iu/4FQA59tlT5ELRb0mgdc=;
        b=c9OMH2NJg/7MrzVTo5mrR4AgG51Q4DD3MsxgdNXrC4J0hRqshlITAYqifzaslqnvsR
         QkNHZNI976bk+K0W2RtsxSU7E5jhgO6FjLdieSKdF3gBAJiAHLHnTuUvK3Ls3xx4d2tu
         Klf0OiasAf+HYxqgsgq1UXqr26beFfJJihDie5mv7ezWfdX81VcY2j/XN4BZvLPJJIS4
         RcW06718g290ss9JXSKa7iZzcnFr+lZbhDheTrem9xoX0MbvbdzEN6YN9lLbeZ+ybrg7
         +tTFTrI5H5rmUUU3og78Jv6Bfel04TtUTLbYMGu5jPcg38tw4Ph84xI13ZLLU/sHF2p5
         NFcA==
X-Gm-Message-State: ABUngvdw2JOdn9P8vSfpFrd0DekBdJ5Jebi8wAqh2KMtVAWGgyx3oX6urBGBO1Ai8p1gagMCY16yaFcz4u3eyIuH
X-Received: by 10.55.184.2 with SMTP id i2mr4224986qkf.47.1477523404274; Wed,
 26 Oct 2016 16:10:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Wed, 26 Oct 2016 16:10:03 -0700 (PDT)
In-Reply-To: <8a91d287-5413-3f8f-9d0e-edd67fb36557@ramsayjones.plus.com>
References: <20161022233225.8883-1-sbeller@google.com> <20161022233225.8883-29-sbeller@google.com>
 <8a91d287-5413-3f8f-9d0e-edd67fb36557@ramsayjones.plus.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 26 Oct 2016 16:10:03 -0700
Message-ID: <CAGZ79kZ6ENdDPZ79+tyVoXiyyN+o7fwkd8MeHDuvvK7yJqf_Dg@mail.gmail.com>
Subject: Re: [PATCH 28/36] attr: keep attr stack for each check
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 23, 2016 at 8:10 AM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>> +
>> +struct hashmap all_attr_stacks;
>> +int all_attr_stacks_init;
>
> Mark symbols 'all_attr_stacks' and 'all_attr_stacks_init' with
> the static keyword. (ie. these are file-local symbols).
>
> ATB,
> Ramsay Jones
>

This fix will appear in a resend of the series.

Thanks,
Stefan
