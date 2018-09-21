Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EF251F454
	for <e@80x24.org>; Fri, 21 Sep 2018 16:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390844AbeIUWgk (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 18:36:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38618 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390658AbeIUWgk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 18:36:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id t25-v6so3983180wmi.3
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 09:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=09VeOSNH3RyVZaIy17cnU7jzMXFKRlE1OYXAo7fmYNw=;
        b=RVALyE7UKtd0dC4R8YEtJM1kchtQKB1h1JnoRnzWMX1y/b+HOJ1z1vu60eacA+cGR7
         velum/SnRGF/W2QG8tLmVFZRX+pIMHwm8PLUInbqq04AWCrDEBQ7BeUBhFmwylnM413d
         kvtC72P7KyOFtC5I/IFx2gROjCNuz+m47uITsF6GEdGkNRol8bsq85sf75er3/CJylIX
         1sgMfe311WrF4A8LkOjr8/3cIS5FdUUPkwcVoGizLdWCAjmMvLRl5OAwtisISSPrI8jg
         DvJTmEqP02OsaO6NudGBhlZkS1N9KCT2Ie7y5VaLWR3ujjvrIqJTqWNhvYC9zlcNi1rh
         rQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=09VeOSNH3RyVZaIy17cnU7jzMXFKRlE1OYXAo7fmYNw=;
        b=J5c4Wfjz9zpwUsJK6dNUy9LfMIlAD7YQCG2a1blrhYDH4Psc430Y73U/CusYH2gIil
         5nhjXvxzhjRLwC+Ejxum2c94vjJ3Brj++tgonf8rfvTBni1damkNhVI+AhE2xmHvmclM
         z9MjtGRu8pkuEami3lQtUZ/po/3B8nCB+MhBKGVFgdNRE0Bk0vCrqH1iLerHm4PJ5Xj6
         NyAJWyxpJJKVEo5IHyBCtXjoSTbTXhlLK6ydH5BZh9qVpe2Ncc8KUzhn6DrK7lRD9ftP
         bPFLy2EmwEyq1MJnQX/o0UBO7aiEfvZdJaP4DbcwFJzkSQuZbyc61pEogTnreG3HCqii
         iyQQ==
X-Gm-Message-State: APzg51BQaJX5SfoasUz92LhgIKDMbGOiqajTQE6rr+zuya3C7e+a3xR5
        Y46FK1x5I9H/EXAGoiDngHU=
X-Google-Smtp-Source: ANB0VdaYzKVHXKPRDv1WTCgDSJguLpGePXbtZGIgj4QJMhHHD45X6iXc0ya1Ul2rnVEHQldk2x0RSg==
X-Received: by 2002:a1c:3282:: with SMTP id y124-v6mr8277260wmy.11.1537548415565;
        Fri, 21 Sep 2018 09:46:55 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y206-v6sm6500682wmg.14.2018.09.21.09.46.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 09:46:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v5 17/23] userdiff.c: remove implicit dependency on the_index
References: <20180915161759.8272-1-pclouds@gmail.com>
        <20180921155739.14407-1-pclouds@gmail.com>
        <20180921155739.14407-18-pclouds@gmail.com>
Date:   Fri, 21 Sep 2018 09:46:54 -0700
In-Reply-To: <20180921155739.14407-18-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Fri, 21 Sep 2018 17:57:33 +0200")
Message-ID: <xmqqbm8qx0g1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> diff --git a/userdiff.h b/userdiff.h
> index 2ef0ce5452..dad3fc03c1 100644
> --- a/userdiff.h
> +++ b/userdiff.h
> @@ -21,7 +21,8 @@ struct userdiff_driver {
>  
>  int userdiff_config(const char *k, const char *v);
>  struct userdiff_driver *userdiff_find_by_name(const char *name);
> -struct userdiff_driver *userdiff_find_by_path(const char *path);
> +struct userdiff_driver *userdiff_find_by_path(struct index_state *istate,
> +					      const char *path);
>  
>  /*
>   * Initialize any textconv-related fields in the driver and return it, or NULL

This needs fix described in

https://public-inbox.org/git/c46ca4a9-6822-436c-8e84-95b977527912@ramsayjones.plus.com/

I can squash it in.
