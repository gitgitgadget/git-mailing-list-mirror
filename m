Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 801191F404
	for <e@80x24.org>; Tue,  6 Mar 2018 23:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933055AbeCFXhU (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 18:37:20 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:54646 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932604AbeCFXhT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 18:37:19 -0500
Received: by mail-wm0-f54.google.com with SMTP id z81so1389587wmb.4
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 15:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=K1Jf19AXkUD+7TTTfLhm8lXQ3KVQWECpsYA5Ly/LJw4=;
        b=eyow6Z2RGiJb1qNOmV2TvRKhD+dk/CrMHg/j3r5uj2laz6sLJhGYxrkUXL4LPqLlZl
         HiwSQQ2uCy1AO+ehwBqhtlgtfOj34vRHGAjt4mL6ZcxpuYwHe1zqG0ZjO6TMbb+jvf5V
         YcpgEeCw5KNBWzX/fB2PeYt6ziBuvV3LsaIXeVCwnyxorcp3SYGAcANnG96gb5yuwfcx
         KrH8lr/5l8sJgErlipgs/y5o9ofIu9BAO27BBO1sw1QDmZ/DGgK3IXXQ1pVTrj/BDUm4
         GsZcX0bJv2X2L0alMtswTCGVkEmENG9u9adxC1CY4gEUw1mORG1dKeZAHHjHG2H8OoBv
         Ykpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=K1Jf19AXkUD+7TTTfLhm8lXQ3KVQWECpsYA5Ly/LJw4=;
        b=GTVEc/GFNWPyDUF0IBYjeYONkymkBVTxoAEvlcG8PLtRz011bqB7pk8te0M5R5Ua3Z
         GDO5a2Pn6nowJR3g4qpffPZf6GZjO4nDSK7Por/RFo/orrDU7hEaUS+xocitdN9HI0/o
         yC7/HM2MebvGzrWyU0mjkJwsrjPjheSWSrInOsW8ordV0cYWntR0tiDew5R3Q8YYLA61
         4DMMJxCbtU69//D4mzxURxCAR3JQ9awP348B9ahLpA3sCr9q3Eh3gS5LD0MuS8qqoII4
         h0yprXxnFrY8jWOFu/Zg8XLBvWyIRPQE2DKhzBxiSyP5PdcZYW2EK9eldeL1ULw+6P35
         tReQ==
X-Gm-Message-State: AElRT7GXH5xsiNoBMYccDlnqGyR//UiAcqXV3/UUpWe7ry36R6Sy5JMQ
        E3ZUryAEFMcTvoMGuDrdEm8=
X-Google-Smtp-Source: AG47ELvFwFowpzKH/35jPVwfrKrk1/a//LdQZWWswKsB+yfXlmtbChnjJS4VESbuCXdYGEhOpcx1lw==
X-Received: by 10.28.54.226 with SMTP id y95mr9010420wmh.15.1520379437880;
        Tue, 06 Mar 2018 15:37:17 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x17sm17781162wrg.32.2018.03.06.15.37.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Mar 2018 15:37:17 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org, tboegi@web.de,
        j6t@kdbg.org, sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v9 4/8] utf8: add function to detect a missing UTF-16/32 BOM
References: <20180304201418.60958-1-lars.schneider@autodesk.com>
        <20180304201418.60958-5-lars.schneider@autodesk.com>
        <xmqqvae92ajv.fsf@gitster-ct.c.googlers.com>
        <0DCED348-C6DB-49B2-8C0A-E4E1F485B255@gmail.com>
        <xmqq8tb43jfe.fsf@gitster-ct.c.googlers.com>
        <xmqq4lls3irx.fsf@gitster-ct.c.googlers.com>
        <EC8DF4D3-CDF5-4CEB-BD18-585341BBB2C5@gmail.com>
Date:   Tue, 06 Mar 2018 15:37:16 -0800
In-Reply-To: <EC8DF4D3-CDF5-4CEB-BD18-585341BBB2C5@gmail.com> (Lars
        Schneider's message of "Wed, 7 Mar 2018 00:12:44 +0100")
Message-ID: <xmqqpo4g22tv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> After thinking about it I wonder if we should barf on "utf16" without
> dash. Your Linux iconv would handle this correctly. My macOS iconv would not.
> That means the repo would checkout correctly on your machine but not on mine.
>
> What do you think?

To be bluntly honest, I prefer not to have excess "sanity checks";
there is no need to barf on utf16 in a project run by those who are
without macOS friends, for example.  For that matter, while I do not
hate it so much to reject it, I am not all that supportive of this
"The consortium says without -LE or -BE suffix there must be BOM,
and this lacks one, so barf loudly" step in this topic myself.
