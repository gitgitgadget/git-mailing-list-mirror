Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 542B01F404
	for <e@80x24.org>; Thu,  8 Feb 2018 18:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbeBHSYg (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 13:24:36 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33246 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbeBHSYf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 13:24:35 -0500
Received: by mail-wr0-f194.google.com with SMTP id s5so5747282wra.0
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 10:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=hqFQz5IswHONrBtWQKTECb2xDEw4kDhGH/UBy1pIA14=;
        b=DZG7BOX+9I9xppapCeFcB2sw7Fib4xygYT8C3j+xkI3pvqwIlendGKd34IugrTGDjn
         vbpSKjMc6m9Zte4rC2nVQuRVpoCDwTOFxRzYWvUf0Bxw/Mgq7+81TUBkEdKG5YpukPbP
         2xKZdrPSPG/2fjSQbZ4nEbAUwZYBo2CEm8RkB5Ah+770F5gYf1qs6nhGE7xE9XqlDxjQ
         ZvddGXdoBr5o4lMK+bIojBDzgFjv4YWZybPp6MfWDiuaCpEjB+P9w/N1ftnqRZFf3tkC
         gbSuv5A+xueulOgKiLf38zQ6w5fevRI1xbBIOclv82fI0Vjr7rOoOnDo8DjgkIhrDnnl
         kCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=hqFQz5IswHONrBtWQKTECb2xDEw4kDhGH/UBy1pIA14=;
        b=CzjLEh+Ak21Sb9gBkfcpZTT41zRe83RtRj3ElW+DkQv/e5bezse6TyWLTgD2F8/BCh
         rqpwY5GOKjKQnvPCvLzasyecL42zPcC3UzXKbU+exZO+5sqYbLMAHgZrZoHJMGiZBZ6K
         GUEF02NikRvid55G1RdN/UwIfCnVZc/6RiWVqrWu+/ig8jWOao+6vH8cje9TqqbdQ8QQ
         2bhbgNR2tAC5BPZZj39A6vQR5sUfbWs/xb0914kspnUQpWfT3a6kh65XgY4mQrDI7DAw
         ziY1GBUCt7Ec0Of60uw3Leeq2d64EIHN7W6xztrp3PhyTpaEpxwspz1mUVjZ5v5myW/E
         MC5w==
X-Gm-Message-State: APf1xPDnB4c3+QrIlDMmicHwSN4WnQXFDX1LokoxKCv96IynWZnLtQ8F
        81Ggt2XjwseC8fqQLNKitiw=
X-Google-Smtp-Source: AH8x224cAJT7/8kZ0vxkos51ExqaoAP0Us2t4u2ELwske8A6dRmX1VHZRRixtZOaAH/0x/VYLhF/dA==
X-Received: by 10.223.160.250 with SMTP id n55mr110335wrn.82.1518114273812;
        Thu, 08 Feb 2018 10:24:33 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z74sm583142wmz.21.2018.02.08.10.24.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Feb 2018 10:24:33 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Ben Peart <benpeart@microsoft.com>, git@vger.kernel.org,
        prohaska@zib.de, sunshine@sunshineco.com, novalis@novalis.org
Subject: Re: [PATCH v1] name-hash: properly fold directory names in adjust_dirname_case()
References: <20180208004156.36224-1-benpeart@microsoft.com>
        <20180208172153.GA30760@tor.lan>
Date:   Thu, 08 Feb 2018 10:24:32 -0800
In-Reply-To: <20180208172153.GA30760@tor.lan> ("Torsten =?utf-8?Q?B=C3=B6g?=
 =?utf-8?Q?ershausen=22's?=
        message of "Thu, 8 Feb 2018 18:21:53 +0100")
Message-ID: <xmqqfu6b5ogv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten Bögershausen <tboegi@web.de> writes:

> My personal favorite would be to spell out what we expect and run a diff.
> When it fails, we can see what fails, and the function would look
> like this:

I'd rather not to have the "sort" there; output from ls-files is
meant to be stable; passing it through sort would miss breakages.  I
agree that comparison between "expect" and "actual" is a good idea
nevertheless.

Speaking of styles, I'd prefer to reserve use of "touch" to cases
where resulting timestamp matters, and not "make sure it exists".

Thanks.

> test_expect_success CASE_INSENSITIVE_FS 'add directory (with different case)' '
> 	git reset --hard initial &&
> 	mkdir -p dir1 &&
> 	mkdir -p dir1/dir2 &&
> 	touch dir1/dir2/a &&
> 	touch dir1/dir2/b &&
> 	git add dir1/dir2/a &&
> 	git add dir1/DIR2/b &&
> 	git ls-files | grep dir2 | sort >actual &&
> 	cat >expected <<-\EOF &&
> 	dir1/dir2/a
> 	dir1/dir2/b
> 	EOF
> 	test_cmp expected actual
> '
