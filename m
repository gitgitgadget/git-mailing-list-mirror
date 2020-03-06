Return-Path: <SRS0=QY2u=4X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E26C3F2D7
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 04:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10F220728
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 04:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTt68RXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgCFEQz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Mar 2020 23:16:55 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43085 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbgCFEQz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Mar 2020 23:16:55 -0500
Received: by mail-qt1-f196.google.com with SMTP id v22so817083qtp.10
        for <git@vger.kernel.org>; Thu, 05 Mar 2020 20:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8PRvotR1fuK/dOzysyBINQvX196JZtnu9YIwhbYRifw=;
        b=LTt68RXRtRJr0heYzM0v8aA9ZpFQytSEw6UKQqf/OPe0hgJLR0h7c6oLq4Cm7dHOF+
         YU4MZPZstNSZSm51SXYjM74RpwcRy3ZLTLUrQcpQbQRjPvi0A80NuxktCz4NWU6lxo8E
         v+bQCHBUGQEtLyvWFNWITEwsj60LT9L/ienNbO1OsTI/ENu1j3JsV4qzPHoH4KI1z/4q
         +cYJpOm7ai2IL97DFmupXNKcB3EiVFkPhqDT3S/RN0gTPzZYZCqdCR8de/AF5GlT5q2E
         nAku8l5ybvvuwUfPeyw1SrqgQiEof7KMFC7IpPs4jQeTRTjNY+au3UTg6MznBKFdvD3P
         h5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8PRvotR1fuK/dOzysyBINQvX196JZtnu9YIwhbYRifw=;
        b=pDro2D3SgfDttj4wnYjZVwSmh9mEhrk2xBVDp+PKzzZp6rCMg9PgltAhaAQgI1pwSV
         OSmx2ZcSCSC3zutohkqVmS50xyupT7lUqEdzYLGiAqVAX6uulVlEDUj+nM+Sj9dF1T9Z
         zp3BB6Jc6yKb/kNMNX81fTXBNE95XlRZELCYiZlhLuHGXhGGQFgYqYEUt1v5LuaNG1/q
         ykgLOrTDeeHEpwot3nVkWCa+rf1GAOmmZSWDDJgcBFR311ZfzKMYRXSvrXEsMPBnGnQA
         RmS6dv32xg6BlPx/Qk5Wq22iBhQbf0W34Gz41mUBPOhQEfz0VJzjm6KzELD0tFs74t5c
         4qmg==
X-Gm-Message-State: ANhLgQ2dlcGDmvT/X4l17Tp7YOi2RB9SNrkETZHFFwZlKDJ6w1o9UTWd
        SLlXZ7HOBjVGE6UVlDI3C7JZuW4o
X-Google-Smtp-Source: ADFU+vvh1VkUzjuyH2ylgFVHY771vJIVwpJcdBwAz16OeMzZO4TI9Oz7OGApanBPgkS5S+7AoGf+NA==
X-Received: by 2002:ac8:1bdb:: with SMTP id m27mr1333950qtk.283.1583468214745;
        Thu, 05 Mar 2020 20:16:54 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id m26sm4821787qtf.63.2020.03.05.20.16.53
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Mar 2020 20:16:54 -0800 (PST)
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 3/5] doc: explain how to deactivate recurse.submodule completely
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <20200303220409.xebesh3ygbuwgwgo@doriath>
Date:   Thu, 5 Mar 2020 23:16:53 -0500
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <26A32704-BA98-4EBE-A982-F38830EEB8B5@gmail.com>
References: <20200228103558.1684937-1-damien.olivier.robert+git@gmail.com> <20200303170740.1879432-1-damien.olivier.robert+git@gmail.com> <20200303170740.1879432-4-damien.olivier.robert+git@gmail.com> <20200303220409.xebesh3ygbuwgwgo@doriath>
To:     Damien Robert <damien.olivier.robert@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Le 3 mars 2020 =E0 17:04, Damien Robert =
<damien.olivier.robert@gmail.com> a =E9crit :
>=20
>> +	since `submodule.recurse`. In this case a solution is to =
temporary
>        ^^^^^^^^^^^^^^^^^^^^^^^^^^
> Sorry this is a leftover from a previous formulation, I'll clean that =
up.

Also, the commit title still has the option name reversed:
s/recurse.submodule/submodule.recurse/

