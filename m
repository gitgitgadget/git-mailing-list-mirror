Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F46D1F453
	for <e@80x24.org>; Fri, 15 Feb 2019 18:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbfBOSpy (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 13:45:54 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38009 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbfBOSpx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 13:45:53 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so11385513wrw.5
        for <git@vger.kernel.org>; Fri, 15 Feb 2019 10:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7D/6pWAFTOVZPsIWFxF/88UTJeUYI++OIg4luU9//ek=;
        b=vecdUOqJtAwsHyt8ArmHO8IBvuilVW8BncxPgxFFO3MUca2xIqIZZz44zc86HP0BBL
         XfolTeb8/u7KCq7dHPyTpFJ3mXyjrC/L0GqB+NS/pysjcI9x8SA01juFP3FA3e6VozHw
         IrCqfejSruJ0apEpXTcRNilAnyx/36QNMKvh0oH9md0+FDTM4v1ZinXVDrDPbfROTcXe
         d0UP+2uXDjMQEySPk9axdPVYtX2+YtSQKtDEHcsO4iOXOkalO1p5058SMzhm6TpxaEGg
         r3+wKm7uL/ntzFfLheUzxTlGwy6HTpOIyicIV7YkAuzXY49lZVOeezGHNO0TIt9MB5Ag
         Zx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7D/6pWAFTOVZPsIWFxF/88UTJeUYI++OIg4luU9//ek=;
        b=Ujm2qqJjFDQ8kgp0MUxp2EFmCSpmTUt6e0GuvMjTk3QjqZOtpHkgn0MWZrQ030HxiI
         SNeAQ07ia5n2/KgC+jEn1GH4uIeys1qVc2qdFQDZ2xRvLmKyF/wkv3mgq68q/ar3birp
         7LwuLF508qHnjwFcTMf5uHtficCvtM7GB/uGaFHsGHGvpqvrvqpeOo4mweobKjoZBtU7
         7RMgObhZetveK4ALG1Tu2fqdiQN381q9HfO17BUJWolMqsU+4subE+i8j98br2tEt3kt
         5/p7vra0llir5+KFZ8H9qhXYGCnQSWVCjaJ/nB0eeN9IwlGyqTnwuMuaKI0N1qyXdGcg
         hNKg==
X-Gm-Message-State: AHQUAuadIadaRTwasBBgEEADGlwd7q5mYLoUj07mQLMZD69DHAd2gagX
        MMjdxS3u+aM2QsSGBh8DPJQ=
X-Google-Smtp-Source: AHgI3IZtfxRj2ZajOHVGicUopCzEUKqfQFVHx9fZbqqSPr5uKQQJZ6srALldFZijiJHLcnMX0sMteA==
X-Received: by 2002:adf:b3c3:: with SMTP id x3mr7907836wrd.294.1550256351624;
        Fri, 15 Feb 2019 10:45:51 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y25sm4574554wma.6.2019.02.15.10.45.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 10:45:49 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'Max Kirillov'" <max@max630.net>, <git@vger.kernel.org>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t5562: do not depend on /dev/zero
References: <20190209185930.5256-4-randall.s.becker@rogers.com>
        <20190215164237.12250-1-max@max630.net>
        <001601d4c551$d0f24c30$72d6e490$@nexbridge.com>
        <xmqqsgwp53uj.fsf@gitster-ct.c.googlers.com>
        <001d01d4c559$b4f62b20$1ee28160$@nexbridge.com>
Date:   Fri, 15 Feb 2019 10:45:49 -0800
In-Reply-To: <001d01d4c559$b4f62b20$1ee28160$@nexbridge.com> (Randall
        S. Becker's message of "Fri, 15 Feb 2019 13:10:12 -0500")
Message-ID: <xmqqd0ns6gbm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> On February 15, 2019 13:01, Junio C Hamano wrote:
>> To: Randall S. Becker <rsbecker@nexbridge.com>
>> Cc: 'Max Kirillov' <max@max630.net>; git@vger.kernel.org; 'Johannes
>> Schindelin' <Johannes.Schindelin@gmx.de>
>> Subject: Re: [PATCH] t5562: do not depend on /dev/zero
>> 
>> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
>> 
>> > FTR, this particular subtest is not the one that is hanging. This
>> > subtest passes on NonStop with any and all (now) 4 solutions that have
>> > been floating around.
>> 
>> One thing I'd like to know more is if this test passes on NonStop with
> this
>> patch, i.e. /dev/zero replaced with /dev/null.
>
> Yes, this particular subtest passes replacing /dev/null. The other three
> subtests still hang. This subtest never did.

Thanks.
