Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B357B20D11
	for <e@80x24.org>; Thu, 15 Jun 2017 23:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751789AbdFOXNZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 19:13:25 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:32901 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750899AbdFOXNY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 19:13:24 -0400
Received: by mail-pg0-f45.google.com with SMTP id f185so12795173pgc.0
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 16:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JWUs0pjH3q3tk626IM1qNEMF1NZlOi8mBnlMLM6e+ns=;
        b=uVSFsbIED9f2PUegRuh5zo46nQi9frfKNBxRSGTG6jd9R7StGY6h6H2jRkAXcDVfar
         rQy7/EdkvpTzRc0orlM+iCtjemaVJylw/FZ+QayEb2GIJhFuuyCL2b98OkI9LuDpx3ta
         yT3OrTs6aA1q4XBIQr652pPVP47zPBHqyFmUFkQOJb8Q88Pg2jib8QWS0MOLTgBuUiz9
         AD8HKPQkiToekD+2G5ozTkqIkzkcf6LnTS9TmT0hKlKfI+ApqC1/XIbMhq8J3/NFsh54
         Dt73WkFiWptaSftp5oKq+cv8GKikYj8mWEp9CCbt5gw0FKcXR950q/5MS13Tb+emRGU4
         0BRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JWUs0pjH3q3tk626IM1qNEMF1NZlOi8mBnlMLM6e+ns=;
        b=kMEhC+1nPkT66PNIaD2unZe/Qm5RueFh5jGBE0J6EXeSfjyxyXZqDxN4mypVrN+eSX
         hLTwv8nNlW2whrllm/Wz+3D6HjPDF4WJRcEWB4PWpAA7BK0xZ0bdSXuTWK8OH1LCDsSD
         v744txI318AoVlPnyf6u8b65ZgnsKENWhpzGONi90ybcxGPPZwy4jyRRZ0taMuyuUo/o
         ls1P+KjAmVbr6p4Ry/cOm8hRZpG2+OegGNsFDms0sDcVLgb1ztOO7D3S5cScIfvECw7V
         8zmywX+Vj6RDeoboD4vaB8nw76+DfLlGo48mkKstpT7jUf3spPg/Rs5wuIx8wgHh2uNh
         vfSw==
X-Gm-Message-State: AKS2vOygf2HJGV+w1npksjObMqgIRmNteeMc1O5WHIubpmcyvCjuVshY
        jtCDJnV72JwvPg==
X-Received: by 10.84.174.131 with SMTP id r3mr8755810plb.90.1497568403974;
        Thu, 15 Jun 2017 16:13:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:88c8:4433:c52b:12d7])
        by smtp.gmail.com with ESMTPSA id u74sm619916pfg.20.2017.06.15.16.13.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 15 Jun 2017 16:13:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Liam Beguin <liambeguin@gmail.com>
Subject: Re: [PATCH v5 00/10] The final building block for a faster rebase -i
References: <cover.1497444257.git.johannes.schindelin@gmx.de>
Date:   Thu, 15 Jun 2017 16:13:22 -0700
In-Reply-To: <cover.1497444257.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Wed, 14 Jun 2017 15:06:58 +0200 (CEST)")
Message-ID: <xmqqo9toyhd9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Changes since v4:
>
> - replaced the "sha1s" part of the names by "ids", to reflect the
>   current effort to move away from the cryptographically unsafe SHA-1
>
> - replaced the confusing term "instruction sheet" in an error message by
>   the more commonly used "todo list"

Both are good changes.  Once this follows the API properly, it would
be perfect.

Will replace.
