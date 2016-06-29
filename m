Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8785020FCF
	for <e@80x24.org>; Wed, 29 Jun 2016 19:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752872AbcF2TAT (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 15:00:19 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:33256 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645AbcF2TAR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 15:00:17 -0400
Received: by mail-qk0-f181.google.com with SMTP id q79so105088149qke.0
        for <git@vger.kernel.org>; Wed, 29 Jun 2016 12:00:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ixvb3VpqSmfsxnPiCosmMFvajmhDzmmluCvvbJFH71k=;
        b=IHJBYyoN+pvdXC6hzIZ/Dt6da3J1pwJA6kGNopJGMeu3G6ydZKxtuoD9IwVk1nxXwI
         AtvD07MJ7y4yYwwz93txyuBXwFhNj7ovZDG8pbTGV4XxnoWdDHwt2e1t8kvYO5VJdQrJ
         4DNLO2zz49x3hEaSQRZ87mikpNKx0wG/W3ZrHTgNtBVk1mzxd0xaBz+VCMsrS65E6iqE
         BuLG8rupOrl1HcZ2oONjQdf33shMJ2EObXhTQSz4yTCYnPnFhZ8njuBXOxNN8N0ci4Te
         wZ957mCvAJpBooZgkl6kajwY9+hRlmVgQCahLHBUioWk9nJ9rQYP15zzMHGOuKX3RWiu
         JV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ixvb3VpqSmfsxnPiCosmMFvajmhDzmmluCvvbJFH71k=;
        b=dosFSBJ+5435m0wp3mtMDtrOpIlKQO6y5mx5yjwH2A57PeN8XHFYATOTvmpGbtrFAf
         3hUdTXLZ1P9s+WtaYTNK6cm7YUTNVeFN0bxd4sXh//TttqPhNwtZe5KOoXYGoqLgrsxb
         YR+7oZDOXllEbEJuIx8K8oaQKt+p6Nx83vxEBJocPqxMD3hy5ZoWBYi6/KjNuGFVvtnv
         I3EXyRgywU3XOMO6I2IS7HH8FRYOyzal54R7E8tSNFV1s8dIbIh8/zasO7y5VQMDCrYT
         0gV1fQcczHb/NDLq8RU017uQv1s5yYaGCTwhj8IuEJM0yU2fjiaWf6XA7ziahHN7Bhgk
         AFwA==
X-Gm-Message-State: ALyK8tIRmcJPjYFhjjgynFdzJkORiKEN8gQQVhrpsWYHzlezUSewZHqqqtR3yvSO4FhNzoK2jEssoje7rsA9CQ==
X-Received: by 10.129.82.135 with SMTP id g129mr4661389ywb.163.1467226816230;
 Wed, 29 Jun 2016 12:00:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.251.71 with HTTP; Wed, 29 Jun 2016 11:59:56 -0700 (PDT)
In-Reply-To: <f15a14a5-f39d-9c41-16b9-fe0a48d7450b@syntevo.com>
References: <f15a14a5-f39d-9c41-16b9-fe0a48d7450b@syntevo.com>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Wed, 29 Jun 2016 11:59:56 -0700
X-Google-Sender-Auth: nQfAmUdXnt3o_0wK8W1DsKRi1nA
Message-ID: <CAPc5daVC-+0Vr30L_pbcL0GN2OmnGm-+V4tE2WTos_vPRb_S1g@mail.gmail.com>
Subject: Re: topological index field for commit objects
To:	Marc Strapetz <marc.strapetz@syntevo.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jun 29, 2016 at 11:31 AM, Marc Strapetz
<marc.strapetz@syntevo.com> wrote:
> This is no RFE but rather recurring thoughts whenever I'm working with
> commit graphs: a topological index attribute for commit objects would be
> incredible useful. By "topological index" I mean a simple integer for which
> following condition holds true:

Look for "generation numbers" in the list archive, perhaps?
