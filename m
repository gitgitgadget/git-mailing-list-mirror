Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16DD21F404
	for <e@80x24.org>; Fri, 16 Mar 2018 21:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751319AbeCPVOS (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 17:14:18 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37543 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750921AbeCPVOR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 17:14:17 -0400
Received: by mail-wm0-f42.google.com with SMTP id 139so5454160wmn.2
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 14:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=XubJuEgk4eGoNOQyjVqKE5k6mvWQPcuZbjRx+1hwCvs=;
        b=XE5EH3EjsuGeF8DW9cTNEljb18Bsge8cM9CcR1objn6QwaRansLuJe9xAmPLR0NUFA
         hNye1b5lDU/B8HNU5s1U9Xzx7apsjKVxbnCd0XPsyHtX7rIIcxgvcWj3YOzGVLb2Oq0+
         RiZ+JjAFAm4Cx/QgEgq+TNDC3EGpAFEFiortfcUZZZ0vdzpPWTbGBsdoCev9aslbOmCm
         xcQ3a5kX7Bb4F+FgNMG75pZinvKMK+R4ikEzbC7bUdlAuKY2XmCF/pvZu4ZphKtpB3B7
         rz5L7k6SqWOj0vb2EIB77V/EFLV/ftHWoP39aGYiWbdmKvr6PjX6cjTg7q6s8KKkN2BH
         2zdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=XubJuEgk4eGoNOQyjVqKE5k6mvWQPcuZbjRx+1hwCvs=;
        b=Lk7pxMId1j/fucppElhk46eKM0f+v56kSASYkpCEMZVk7taox77/8O8zy7Dkr7bvO1
         WQD6SWofY04vqKhQNPpW0ALGSDfL1IQMn2bvdT9A/uAykKfKtoYds87v0Fh0uFjWjlLH
         ZAuMYCoCaKO0juOlTp1wvF1P5sYXBCIXNUuLhLnzeAQNuEXcy2Kao8DkN2GQ/rkmknow
         hROKr98xNI8t/iHykmwFBWQO8SawlFnmuNGJQfpJvLz+u6pK2aRkTwUlkaW/x4Oh15EX
         Ryl0brHldOTTprwxd6NUVkNCA0NJ9nRmx0D1WuqIV+/ewHFYFF0ixrfmzPJPDUB9khEg
         10vw==
X-Gm-Message-State: AElRT7F34N40+6OBlolDpAtkv20bqDmqMfIXIDljaNjyxtUI4qyE4FJd
        Qk4fgYYWU7ka1WhSTacu4DU=
X-Google-Smtp-Source: AG47ELt3GjsMgij6qq9BZ8znRZ31DFkL0kWK5KRm2gNRyoljOVRrsuAhpxHESmWz6jgj5tVdcCjGeQ==
X-Received: by 10.28.92.208 with SMTP id q199mr2683411wmb.91.1521234856747;
        Fri, 16 Mar 2018 14:14:16 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id d8sm6143668wmd.20.2018.03.16.14.14.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 14:14:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     e@80x24.org, git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH v3 4/7] gc --auto: exclude base pack if not enough mem to "repack -ad"
References: <20180306104158.6541-1-pclouds@gmail.com> <20180316192745.19557-1-pclouds@gmail.com> <20180316192745.19557-5-pclouds@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180316192745.19557-5-pclouds@gmail.com>
Date:   Fri, 16 Mar 2018 22:14:14 +0100
Message-ID: <87woybd8pl.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 16 2018, Nguyễn Thái Ngọc Duy jotted:


> +			struct packed_git * p = find_base_packs(&keep_pack, 0);

Style nit: space after "*".
