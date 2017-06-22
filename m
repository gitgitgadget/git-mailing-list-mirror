Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87B6120803
	for <e@80x24.org>; Thu, 22 Jun 2017 20:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753492AbdFVUZ0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 16:25:26 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36786 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751147AbdFVUZZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 16:25:25 -0400
Received: by mail-pf0-f193.google.com with SMTP id y7so4506673pfd.3
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 13:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HTc3NguK4Z5KtjNAMuKPdJ4GZR8g3cy7vgC+KwAhl48=;
        b=dsujU+TrY6bnvtbwda847ZohuQGmXjmOlWgY176zETLbxcs8v8tgN0u5tPz/cJk9yF
         LOLic4kSmmrtFDla2l0loB7VZ7Xf34HObfYSQnJyepBVI/+oGfPnarxcWAv7rZm/U+Xu
         QS7Fwts2CNpvEycEmBMIa5p6T6IFbtJ+x/VEMWfSSvdFaqfV0pIWDNqEUTr6W5ditDsr
         Q8tkz6r0cxYXQnRn8+jE8xQEIutXQ3NBHsfiXShKMOMBWE7PlJAou5qBgF2BsDq85jKA
         IEQYagF9Dbjz7qjeNCvqfn3p1ztMXRP8vwYyeub4QooZbFE8UgedrdogPLVU4iX5MZhP
         Lepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HTc3NguK4Z5KtjNAMuKPdJ4GZR8g3cy7vgC+KwAhl48=;
        b=qcA0IJNFuTIts2uAzO92FdJtGyVjm0LnP7EipWsSLYCjPxELFL3l2bxrbJMXay9//4
         mgvRFoQf24QMcO7ruhD9zKjBLOehASvDswI7nkFL25wdt2jbnRUafMn45wPAdaUAH+DF
         cP140zLEIGBQlPspguQ2ix7bubalIqbWhJSfoTjBe9vKEb8LSMBKV9VQuv6IDAomv76z
         1Ax9CWfViRBQlcIQuhQvk1yRmPZKv7OXBSjh12pzf6CbTyYM/7BAoDu+VhG68eJPv2Lr
         b94/cNTvT8YsfaXGN2dJKmX0nUnuh53qQsHTA/mvLlhwPDrFX98PEIuf3b4FDO0uoaqK
         RW6w==
X-Gm-Message-State: AKS2vOxPr+Ks/lr+sJLio4JQYgzBX1nTcwHyAUC+I6ox0vm5LpievOpM
        VxEPmp3I7uUxgQ==
X-Received: by 10.99.23.100 with SMTP id 36mr4524705pgx.118.1498163124357;
        Thu, 22 Jun 2017 13:25:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:20f6:6e44:6707:50bd])
        by smtp.gmail.com with ESMTPSA id u78sm5613954pfd.109.2017.06.22.13.25.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 13:25:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/3] t1700: make sure split-index respects core.sharedrepository
References: <20170622190158.13265-1-chriscool@tuxfamily.org>
        <20170622190158.13265-3-chriscool@tuxfamily.org>
        <xmqqzicziyss.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD2QwN_8Mn3eFT_FRRbXNfnQFwt53nofh8AUzR0Zhx5EgA@mail.gmail.com>
Date:   Thu, 22 Jun 2017 13:25:23 -0700
In-Reply-To: <CAP8UFD2QwN_8Mn3eFT_FRRbXNfnQFwt53nofh8AUzR0Zhx5EgA@mail.gmail.com>
        (Christian Couder's message of "Thu, 22 Jun 2017 22:19:46 +0200")
Message-ID: <xmqqh8z7ixcc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> We use "git config core.sharedrepository 0666" at the beginning of
> this test, so it will only apply to the shared index files that are
> created after that.
>
> Do you suggest that we test before setting core.sharedrepository that
> the existing shared index files all have the default permissions?

I think it would be sensible to see at least two values appear.
Otherwise we cannot tell if the right value is coming by accident
(because it was the default) or by design (because the configuration
is correctly read).

