Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EF4C1F404
	for <e@80x24.org>; Fri,  9 Mar 2018 19:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932524AbeCITKu (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 14:10:50 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50512 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932183AbeCITKt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 14:10:49 -0500
Received: by mail-wm0-f65.google.com with SMTP id w128so5822571wmw.0
        for <git@vger.kernel.org>; Fri, 09 Mar 2018 11:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version;
        bh=/0PUF4Vw//16840KKltCvU5su7jC07zZ2PihUC69Vng=;
        b=OkTSsO1jlGq1YJAZRp+jZZ3Ib1PByLz7oND/NGvnUkDTqRBzK7ZnvreyxyT6NrNG1E
         w/302dgkx1iFI6dsDe55qtwzbbIIGy7tKWEy+Uwp+RbiQPG+XAGPlIVjMZfMaY+YQIQr
         5KY/W6V4Xg0zYhF4JgxXOihuIGsN3JRNAfQ4Icb+EcNFhtPBK5Zgx6r5Iscer881n9eG
         AoM3jq1cmOhf52zlCdxEhJS+hQhearAJ3kJHYmSKuIwfilhX1lRG+r7tORoK7dE4FAr4
         vCTS/aeu6Id3h9NYPJjBgs4EDKym6E8qAQ7FuYSscaSnsYvkDoAQi/aX99IJiluIBeB8
         XzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version;
        bh=/0PUF4Vw//16840KKltCvU5su7jC07zZ2PihUC69Vng=;
        b=AG28TooJqnCRNJdDrMvG4Euva6WEmTt12mgf9pGZ20sDaSH8Qsj6HdBkyD7j8l1HB9
         C3b1lxBjR1fT0qlT8WUxKNuWqBHFQ2o9FqFySGTDgqaz0X9mub4xupMfNPKXlukEcC4O
         7ynuI5I2fENZ+6U0NHD+qD/l6IvEypHcn10SdoCF2XTmU5ZVZlMhiYLtKf287iVFooTZ
         ZJ/Bs57muS3wjJ/hoXzmb04RbzxFvE3pJDEc1wAPpD+w+limnjmWMPsNaNSMfSZLBoSZ
         hliuE9a++G49mAKIR6Q40zWcR+CVK3HAEzB+PRQbnZZG2zgpeUXa8gujk80tmHpFUfLy
         bqXQ==
X-Gm-Message-State: AElRT7FA3AxTelJdxTx5wp5qBjjZ/kTOkbQctWA8L+WeNAV2Ke9FHIf/
        o0sujL3jCQ2BRvBAoJ+pBXo=
X-Google-Smtp-Source: AG47ELvD2E9nlB2llp1L3vdf8Sdc4vU8H/WWCV5M9KEEVSVAaFtxzLnbyYuGJrxQC56svwhEhHiWow==
X-Received: by 10.28.225.130 with SMTP id y124mr2792226wmg.60.1520622647767;
        Fri, 09 Mar 2018 11:10:47 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 55sm1884538wrz.6.2018.03.09.11.10.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Mar 2018 11:10:47 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     lars.schneider@autodesk.com
Cc:     git@vger.kernel.org, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com, Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v11 07/10] convert: check for detectable errors in UTF encodings
In-Reply-To: <20180309173536.62012-8-lars.schneider@autodesk.com> (lars
        schneider's message of "Fri, 9 Mar 2018 18:35:33 +0100")
References: <20180309173536.62012-1-lars.schneider@autodesk.com>
        <20180309173536.62012-8-lars.schneider@autodesk.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
Date:   Fri, 09 Mar 2018 11:10:46 -0800
Message-ID: <xmqqlgf15akp.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

lars.schneider@autodesk.com writes:

> +			const char *advise_msg = _(
> +				"The file '%s' contains a byte order "
> +				"mark (BOM). Please use %.6s as "
> +				"working-tree-encoding.");

I know that this will go away in a later step, but why ".6"?

> +			advise(advise_msg, path, enc);
