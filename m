Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95F741F462
	for <e@80x24.org>; Wed, 19 Jun 2019 10:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfFSKam (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 06:30:42 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42813 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbfFSKam (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 06:30:42 -0400
Received: by mail-ed1-f68.google.com with SMTP id z25so26412395edq.9
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 03:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Iswq88c/854UBE6BIlf8BANSwC99YQcJK5jeK8NC2Y0=;
        b=PeVJBG25xvfFYFqjEnuZOeHJym5RV5FYNKT/WZ2+9TmuIVawlNpKBUClJs8B/35owA
         EN50i6oHbaTsr4FcTyViAapfliMLGK3YTuQlz0c7xMEpmob52+oSEnlxB1/bDZmjA37s
         wJEQe+385o2bSWzHRuIgmSFRB7VJZqsG1Xs/Srfwu/TB98ae0aj/LBaJ9c3/lBxl6PD4
         ejKMqIE2+T9zNDnuLo32lvabUz1xRol+8cGRlNe0gobQJYUnM8bgpqou5n7hwNdL5ylW
         2U96M3mA7/Virl1eQLHFrI+yVMh0hyPDu5O7ywCOnI1XbuoNh2RNFuCiIG6para4DJX1
         dZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Iswq88c/854UBE6BIlf8BANSwC99YQcJK5jeK8NC2Y0=;
        b=EB9s0NEouAkYfPjcTuP222uQYHFlHAtrzJMniUjhz3vhefrIOG3GDz5GCKHlBgnFvl
         rGSa2Aeu9hi1mVMfr13e3z7+ihm9SV2lmhEQJu9vlN1PAnmZp5VlUcYrg5Sbp1c10VDL
         QLbq8lyZwzaYKA5kxK2LMnmN0RgASgbGQTHlTb8AVZvnrvyOuinV/acl/OQEIvkutZKG
         g2YoEVWsCFFPo/Df9j7PZHonPZrMbhwARIJOljuaCDKeVflmtN1V7EiMjUXtslGLNgEC
         MmcqAS17oF3c14XUxcUEfuNIgD9quxFg/3WAzRgECbGi3nDBHdyEfnaMk/ENJzs+XUAX
         xQzg==
X-Gm-Message-State: APjAAAUzb4fwftVnmo+z0N/wH6yYELIuspqOnuVtc5iLnB1z7MnX5jZk
        wHm6eFN3fX6ppYceEv9EDLFDAVUnJ0w=
X-Google-Smtp-Source: APXvYqy7QVpjMmqC2AZv27hPWsqb8v1eRD6Iz56w9I+Cu3UG4mLy9StxLtPRc70TipYZ9J0gkLfPbA==
X-Received: by 2002:a50:b329:: with SMTP id q38mr130441038edd.246.1560940240157;
        Wed, 19 Jun 2019 03:30:40 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id bq8sm1496582ejb.42.2019.06.19.03.30.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 03:30:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/8] ls-files: add --json to dump the index
References: <20190619095858.30124-1-pclouds@gmail.com> <20190619095858.30124-2-pclouds@gmail.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190619095858.30124-2-pclouds@gmail.com>
Date:   Wed, 19 Jun 2019 12:30:38 +0200
Message-ID: <87lfxx98a9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 19 2019, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> +		die(_("--show-json cannot be used with other --show- options, or --wit=
h-tree"));

Should be --json, not --show-json, right? I assume --show-json is left
over from an earlier version.
