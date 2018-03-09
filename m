Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F8DB1F404
	for <e@80x24.org>; Fri,  9 Mar 2018 19:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932697AbeCITAO (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 14:00:14 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55875 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932468AbeCITAL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 14:00:11 -0500
Received: by mail-wm0-f66.google.com with SMTP id q83so5730857wme.5
        for <git@vger.kernel.org>; Fri, 09 Mar 2018 11:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/0PUF4Vw//16840KKltCvU5su7jC07zZ2PihUC69Vng=;
        b=S4kYG1DUteuEYOICktdJMNj3xxvyKzfu0sXkne5PburtKObyNzu/IT8fy3ae1krE6t
         P/g9pm6RNWNLyi1CUzwadgtRwln3n24aT3GZk0iqPYsC3PnFPfngvUMeQFNAWZH1O1nt
         EVE0858jfsS+6czHX2MqURyURmgOuUsDhDiDcWJRtHn77m2jYHakbcdyShLFmx10u+rF
         Ovzd7wbDiMHVs9DlGLZYiG/K8XNADy+OHBDROtRO8fenMPRRdLCxzaKDBJlhxAI9SDuo
         vSnEphTfdTt13pD+x47h6ClqB6zcHiKH+5NKgNH2cLyoP+1wc/jeXa+Ga/1Ps98VmAys
         ptMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/0PUF4Vw//16840KKltCvU5su7jC07zZ2PihUC69Vng=;
        b=W1X4WHBSVpFP8815EMhOq2SOIZ9bPJ2SdQSRaXDLOj6IkJcMUFQQVSB3mA+I7gBwX4
         t6nNvmKQmehnWDOvwP8YDfqKTBKAUh5X2hNXWOUC8/ru4Jvq7vatLYCiREQfVOJbxkvD
         KpwOqyDJYds2UYD1p+IUKX8w9ZoQjiMJlQ7mK0p/X8Jww3vF9thZ5q1WRPQNcwTLIjKF
         wyggKgUyBz8SuS7Ve6swkxMstTVr7Rhr6cnlbbFMboIe5YkaimRHso+LZxDVbrG6SOhg
         1t2Qq8MHO/Ign8POZ9mqlAkCHal0TbcR0nNgCxDVjf88Qonvp1rP1kHvzut906vlHwR2
         7qVQ==
X-Gm-Message-State: AElRT7Gz/z3e5gAaDSRZICt5ILLqV8No+epG2gHS4OnIxXc7iSl3Yf9H
        mhMffJChAj0+rA85EXaG+E4=
X-Google-Smtp-Source: AG47ELubDpvmsx7FzsaSNQ9fsCLO88bsqSMOUnI+GnbTa9MCSePdDYU3BYQpUU2qNOhcwXbO5IAjPw==
X-Received: by 10.28.109.148 with SMTP id b20mr3047527wmi.92.1520622009935;
        Fri, 09 Mar 2018 11:00:09 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q21sm1988114wmd.12.2018.03.09.11.00.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Mar 2018 11:00:07 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     lars.schneider@autodesk.com
Cc:     git@vger.kernel.org, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com, Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v11 07/10] convert: check for detectable errors in UTF encodings
References: <20180309173536.62012-1-lars.schneider@autodesk.com>
        <20180309173536.62012-8-lars.schneider@autodesk.com>
Date:   Fri, 09 Mar 2018 11:00:06 -0800
In-Reply-To: <20180309173536.62012-8-lars.schneider@autodesk.com> (lars
        schneider's message of "Fri, 9 Mar 2018 18:35:33 +0100")
Message-ID: <xmqqy3j15b2h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
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
