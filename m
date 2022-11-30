Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB6AC4332F
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 04:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbiK3ERT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 23:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbiK3ERS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 23:17:18 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F3E26499
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 20:17:17 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso789111pjt.0
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 20:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GP6s8oZwY/Id/w8evh7Jk+tYzQnKF/9RVhc+PDsddG0=;
        b=VLwcXCCxtrmq9Bttb4IzSPlUoBszZ5XFqAecNyUMxAExWH1p3YstwKxN8JXw5qBIrd
         9ZLXyMMzyyBRjECnALdtfsQBHkVyxJgPOHZfPFpNIPuVC1Yg11Wu4Ul1EU2kYMNtBabw
         kzsIxjyZD30eAdW3mrvE9y/kBlLBM1gSk0Lnd9VUZmbnp6F9V7wb1UQ9TYv2aO2vfDIi
         X0MMyBNn9depw1UYzxne9uowQsbr4o5+kjOa/NC8/yNAYiTLaqzETUh3QyPPomstqWVm
         BCdS1UDCUXjiSlkkCPF0iiZgf05Q7+YrDMwFElknWbDuShXUUFu00JWZjkiJu5A/a1/1
         mpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GP6s8oZwY/Id/w8evh7Jk+tYzQnKF/9RVhc+PDsddG0=;
        b=Mc4TxiaLjxJPGT20GsKfGCx6i/j5vqlAQQHDhzFUfqUZVZP5AzsVwJWxWEiDuFZx+B
         c7Y/6CqRIrGn+CB5a/C87/eFZfF5mtpUhKA6Nhf5OgFILTWeaTKHDZDOy7Pk71N5PqUq
         pCAy12AU/EWAgIP75BYpxGas/PEm65tqcPb2BsL+CsigWjrUkyaO1AXrbeIjAxIpi2GF
         neXUagwNY38+6A1uOO96pRzYuw7Lf0rB+tutGWHU/twVh7q53KFQDIet6peCXI0KFD52
         TiHrOt/5y0xlbbs4fyMZHDlvgEhBwabvzT1Db7MMbJO+gZR5HV2xVBnZf7KTjlbR83w0
         m5/Q==
X-Gm-Message-State: ANoB5pntqJfqYmGjEgw2QfQ7KhzbHB1A1p//mXzgzrEmLsN6widnfHmQ
        0aDZbyPusmFe+2NSgU4FVEk=
X-Google-Smtp-Source: AA0mqf4r+vNB8J1NigxhcBu5u6FxeYvRsXClMn60CtyKn+bbv3ITbYKoLKN/TCqfh03fmuJnsOiXvg==
X-Received: by 2002:a17:902:7006:b0:181:b55a:f987 with SMTP id y6-20020a170902700600b00181b55af987mr40833830plk.67.1669781836493;
        Tue, 29 Nov 2022 20:17:16 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id e17-20020aa798d1000000b005742ee445fdsm295489pfm.70.2022.11.29.20.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 20:17:16 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Paul Smith <psmith@gnu.org>
Subject: Re: [PATCH v2 1/4] Documentation/Makefile: de-duplicate *.[157]
 dependency list
References: <20221127224251.2508200-1-psmith@gnu.org>
        <cover-v2-0.4-00000000000-20221129T140159Z-avarab@gmail.com>
        <patch-v2-1.4-42b4f241c97-20221129T140159Z-avarab@gmail.com>
Date:   Wed, 30 Nov 2022 13:17:15 +0900
In-Reply-To: <patch-v2-1.4-42b4f241c97-20221129T140159Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 29 Nov
 2022 15:09:14
        +0100")
Message-ID: <xmqqtu2hyt2s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> -%.1 %.5 %.7 : %.xml manpage-base-url.xsl $(wildcard manpage*.xsl)
> +$(DOC_MANN): manpage-base-url.xsl $(wildcard manpage*.xsl)

Not a new issue, but to avoid getting affected by an untracked new
xsl files, shouldn't we expand the wildcard at the source level
here?  I.e.

    $(DOC_MANN): manpage-base-url.xsl \
            manpage-bold-literal.xsl \
            manpage-normal.xsl \
            manpage-quote-apos.xsl \
            manpage.xsl

or something?

> +%.1 %.5 %.7 : %.xml
>  	$(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
>  
>  %.xml : %.txt $(ASCIIDOC_DEPS)
