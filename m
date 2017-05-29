Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF6912027C
	for <e@80x24.org>; Mon, 29 May 2017 08:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750871AbdE2Iaz (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 04:30:55 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36417 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbdE2Iay (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 04:30:54 -0400
Received: by mail-pg0-f66.google.com with SMTP id h64so5808225pge.3
        for <git@vger.kernel.org>; Mon, 29 May 2017 01:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GA3qJWz4kdEP/hsvOVoRlAQumSZS5oL8cb2zX0h369M=;
        b=THHGUn3Cvomhil9M3gGUJS2/9CcdGabN4dsUHCBJ3b8uPgJJoClbxCEzWJdOmmz2aL
         DPEbipL8kQh82Qj6+QBpCCt1CZp2D71AOhcWbPJJ/7jyq8p6Y3nolOWvu+DSWzL+bCpA
         Gv3fZp0wLJwX8iqqIPyIgIBa9BaJ2ZMeGZ9f/R4wF1QRV2y3DzoWVWOKSgY538hiW4kH
         cYnJOG/P83f4g4Aok9eUh1yD/bujg6TdCWUZLR1ejQ34V/xZFsf3dhgtWKe7kn/dJhGl
         FmwpwG6p1UMIOsGAPkg+F1zCrNeFTN5RGHxRbDz/8/U2qJP0Xo2ayPwNF8AaDC+Xp+MC
         K32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=GA3qJWz4kdEP/hsvOVoRlAQumSZS5oL8cb2zX0h369M=;
        b=hqLtm++jsIUjTgV4OSjlXjCbDcXKAXt6Z+K5gm2Let6YS41+iCefJMWrr1lTj/nozC
         a9+x83yYM+9CTL/fPtwYgBti96rpRZo+Xx4jJSJNgur7n4VtB/zY/q/VZNI9ezcGVETm
         DeOw0xuCtZbZctX+eUhBvjTWNV4y+cWrPRPuhMZHorVOM3SyPYGN8gZMk9vU2UMLkjvw
         9cW1GS/uduxYhsgsIBNrmnAD1OtW912GRLPniTQXe02zHTHSzcmeqwlycoFJ0q4wsnem
         hrRvO1DFe65K3bYjoOpcavRNx1UC9F1N9DqKy6WfzYAR2KAumPlEmJpZZRZ/r2/DUmZB
         mBiw==
X-Gm-Message-State: AODbwcDkrT33F7dYNooElE01E5rOlyUlPQrLKU5b2YxWGcojwqej/P3+
        w8Q+AfRl1TkC9g==
X-Received: by 10.98.196.18 with SMTP id y18mr16406226pff.49.1496046654255;
        Mon, 29 May 2017 01:30:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:393e:d787:9be9:17cc])
        by smtp.gmail.com with ESMTPSA id s68sm16500543pfj.5.2017.05.29.01.30.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 May 2017 01:30:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 00/10] The final building block for a faster rebase -i
References: <cover.1493207864.git.johannes.schindelin@gmx.de>
        <cover.1493414945.git.johannes.schindelin@gmx.de>
Date:   Mon, 29 May 2017 17:30:52 +0900
In-Reply-To: <cover.1493414945.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Fri, 28 Apr 2017 23:30:42 +0200 (CEST)")
Message-ID: <xmqqefv86p4z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> This patch series reimplements the expensive pre- and post-processing of
> the todo script in C.
>
> And it concludes the work I did to accelerate rebase -i.
>

I took another look at the series (as "What's cooking" report was
listing this in the "Needs review" state).  Except for an inssue
that I already pointed out in an earlier review, I didn't spot
anything glaringly wrong in this v4 round.

Thanks.
