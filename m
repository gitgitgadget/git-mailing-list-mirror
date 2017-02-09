Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E5111FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 16:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932345AbdBIQ7K (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 11:59:10 -0500
Received: from mail-it0-f45.google.com ([209.85.214.45]:35773 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932343AbdBIQ7I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 11:59:08 -0500
Received: by mail-it0-f45.google.com with SMTP id 203so129813422ith.0
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 08:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xhkAA2t0lR/7lwyrR71tcpRskb71zMhzpXVYGFsC4Xk=;
        b=ZfOT4/bDvpsOv9Xkr5A4YttNiqa5Xo0rp4W0qFnDAADC/72uUD7u9y+L6A1LtjwmdD
         eBdhM45BADDnV+4MN6vWSmJ4tey81u0sHFwTNuOrFxRL4kKRVxbkPVCl67Et1duSN8aJ
         rqJ7uA3jfx8soA9trcunODeOLq2P1vIVQxhCwQe8LNZXAl3Dw/HsYSmijFqZj1Sz91oN
         u2ygbr96sSPLZTT7jIIRY4RFqhx/gQpb2Uq6gq7JRIKSytXJgha41UFSG+ICz5pHEzav
         GJv+PCKiKGsZVi9Jc/s+iyk5nymnRHIRJZSdX4tfNXmMJf+0GB4hdTsyNeChhvUnJFQg
         RDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xhkAA2t0lR/7lwyrR71tcpRskb71zMhzpXVYGFsC4Xk=;
        b=NMNnckTo70sDwMAyF27ufFp0OPDqFAxa59amJ+t80L/mJW9Zml0wwVj93xnleMyFCF
         D+KDQRN1fS7Qqmg/jcHac9AnlQHiFpVKqVmZDlDRwjjr3XlVWyA8DH737TkfM+krC1SR
         6Xlb/vR03HU2iVpZ9E7esmoVbB6bixOpDghDEdyNlJdwojDpzS06IXHQvtvKbxVaG0be
         2kKaISDI1wN1t6PvP+9UTSSEh575tEtQOPQ+0qswdXQXS1g2/AdA43r2LxmZdYBg9zbI
         KgvEEUaJbJOgH83CvJRVrjmbuiKEb1gpQN4HZbNCpitnoGTsF9Gw3LzG46KQOKytzJ11
         R+eQ==
X-Gm-Message-State: AMke39n3zqZN4FjgDLSLp12N+inKE6JZTsbwYMAHNDJKztXGOPQnibnK3dJnShC7ENE6PjANa8n/AoH2uQqKo2Ll
X-Received: by 10.36.34.79 with SMTP id o76mr3977652ito.116.1486659524932;
 Thu, 09 Feb 2017 08:58:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Thu, 9 Feb 2017 08:58:44 -0800 (PST)
In-Reply-To: <a944446c4c374125082f5ad8b79e731704b66196.1486629195.git.mhagger@alum.mit.edu>
References: <cover.1486629195.git.mhagger@alum.mit.edu> <a944446c4c374125082f5ad8b79e731704b66196.1486629195.git.mhagger@alum.mit.edu>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 9 Feb 2017 08:58:44 -0800
Message-ID: <CAGZ79kau2bYs7zegEiacAdbhn1LyOfAH9__rePfbQkX2iLgmMQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] refs: store submodule ref stores in a hashmap
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> @@ -1402,17 +1435,17 @@ struct ref_store *ref_store_init(const char *submodule)
>
>  struct ref_store *lookup_ref_store(const char *submodule)
>  {

> +       if (!submodule_ref_stores.tablesize)
> +               hashmap_init(&submodule_ref_stores, submodule_hash_cmp, 20);


So we can lookup a submodule even before we initialized the subsystem?
Does that actually happen? (It sounds like a bug to me.)

Instead of initializing, you could return NULL directly here.

Otherwise looks good.

Thanks,
Stefan
