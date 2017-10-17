Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45C021FF32
	for <e@80x24.org>; Tue, 17 Oct 2017 18:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937451AbdJQSWX (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 14:22:23 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:47518 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937448AbdJQSWV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 14:22:21 -0400
Received: by mail-qt0-f170.google.com with SMTP id z50so5572871qtj.4
        for <git@vger.kernel.org>; Tue, 17 Oct 2017 11:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5oWZmn+pMoB1VHelNRWvVBedToRrjqmMkzLyYDnuiEE=;
        b=Rtd0AFjYtPIya/3KUT9XK5ezv8mJBBuAdQndF/JjMNC6rb5fFXLh2fnR0zZWeM8qD4
         lTMmI/X9n3wx7vHw0t3C7h4Fst8lqSk+SHO67ZtOe29KwITyMzX/OSsn7Ax0h+Fz85qN
         5ulggaoNZkuiSmezMStI0VivkFXKShVTDMgQUbVNRuBEQEfJRwvYNr0jBrgE02S6vHhw
         DDIlEJ58BFq+9eBQ8+M+avDopKMx5Rq/KZsPnfDtRbutyzW4w804gFchiNllYEN3Y9Hl
         QVxLtmQYcahgcpLx+NdRZN2ZZQetPkUXZrJzsehsWZRb17iO8dQZ08s+1MQ8x+7DXSmC
         5K4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5oWZmn+pMoB1VHelNRWvVBedToRrjqmMkzLyYDnuiEE=;
        b=HYPEUo1+d6bUzSuFKIgU1xH5pY/yMmo1HvwwxtnWT1ipNZSLky0voMWxIRIgI6+gkW
         3tyuXAt9TAb1nUXyD8h9UvgUEYrYlUXEWiRl3IBPLRc3064OARCN9iHvIx2vky2MAeJd
         CgNTF1Tqzt6HJp40Ud7G9S+41loMxXo2fiqYNiSrUvuxBByIK4xa6UNka8DPH1cce4SP
         A947EDUz4W1LG6TKE6VcHO3gbrJRQ6oJgmWsOvBUII1fz1DAa5U/2SLTj+dMSloIt3mC
         BoWVWghw11p9pStczTQOGf5y16uc0UctGxA6KpixWr5cGGb29v1abFe2J0BhKnVZL7/0
         AvuQ==
X-Gm-Message-State: AMCzsaUJYPE1FTKL3pnAtPzilgW4uEg933ykZ5pawcBj8agCyyDgay2z
        QT/Jojv3xWtGgmNUgZQ1YWEUMdz4Hz7Hu9ln1gxrMA==
X-Google-Smtp-Source: AOwi7QDCq/d/Y8UQmUrnjwi+B/NxT2o2AwW9kcab9Q3B44hffRPuP4FXfeB1wcOFuzuggi3KCrEWcM8W6ZPmg5mg1XY=
X-Received: by 10.237.53.137 with SMTP id c9mr22455443qte.125.1508264540868;
 Tue, 17 Oct 2017 11:22:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Tue, 17 Oct 2017 11:22:20 -0700 (PDT)
In-Reply-To: <20171016135905.GD12756@book.hvoigt.net>
References: <20171016135623.GA12756@book.hvoigt.net> <20171016135905.GD12756@book.hvoigt.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 17 Oct 2017 11:22:20 -0700
Message-ID: <CAGZ79kaOqynvWsWxReKT=c33+EA2FSAbBicY7vsHuvAxOnAwZA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] submodule: simplify decision tree whether to or
 not to fetch
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 16, 2017 at 6:59 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> To make extending this logic later easier.
>
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>

Thanks for this readability fix!

Stefan
