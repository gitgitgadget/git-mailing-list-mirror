Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8274A1F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 23:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbeJFGvY (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Oct 2018 02:51:24 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:41740 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbeJFGvY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Oct 2018 02:51:24 -0400
Received: by mail-ed1-f46.google.com with SMTP id f38-v6so13007793edd.8
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 16:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=996JrFm4ExlNO0mqQCOJa3c94U77yErMT7B+Ck2VPDM=;
        b=WIJed7VwL9XBQ4637O4ASITNZzeLwCTikfy0PbB+PDsV/PI4nKRbRxZfWZEYU6bKv0
         xnuLYO+U13eTI/RCmeMzpPZcuMbxZOX5mJO+h3idxAdY3FWgFYWOY6I02ZePT+vHwaVL
         /zQkzPFDFqEzoZuUPwSxLvrvISExDjA0/u/VZ8NrORLEFh2Av1m0s9kuAaIhPfq41KdQ
         Er7ZbadtLtWBhko16sRbE3tU+UGac1nOttJ6bBVqMD4nGzVPsFDt8z+nSYuTQn2syIeM
         NLpUxhwtTQ20g4jBpsul25gpG2qoXhH2NWDOf0Zk21JF/rtvSs7X1xWmeYjgOeCeL7Yc
         m51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=996JrFm4ExlNO0mqQCOJa3c94U77yErMT7B+Ck2VPDM=;
        b=fVhueRlk+wcyPrp6uHgxzgM5WlUTHS2meY2kWrp+UcsHdsj8sojpQpiGHshqHBdju4
         dCHHPD/AbEJqx+qGA5V8uPEY4MkZ5CW4Wh0fKz1hboExy09IyiSOL6IHJMMTvtvubtCU
         aXxlh2posfTcopiCDuqUTsGUTfVQJadfnzrmktv/zfr8Dthimr3hYvRlHhjJjWVIl7/Z
         WBSo0PGWdtYHv2MRtWLouJbDeNEOc+1hWbQymb7EqmItFnKql7wxvQBjcYDmStyIq+Cz
         hoWRl0rijHitkdJ6bGmiGsIOh5BcA48n/IkGxhf4Pu1eI/L/tZ1yt1uERHlOIkQFmkwJ
         hrkA==
X-Gm-Message-State: ABuFfog0CfYzPYJIcWwB1ZmZJ9kZhCMtv5jQsjXwfbCWFzYuU2ulV7em
        1KXokhEFBgt9gxD4XUMJaDOD6u4/4n4wCOWwkb80fQ==
X-Google-Smtp-Source: ACcGV60SzdHhQMEFSDELNHhfY/hOy5LXhkorhkgP6yVuO+VvVxnwoHVap33aYgrVZCiNQF45FvNf1/Jml0hC7jsWrUg=
X-Received: by 2002:aa7:c742:: with SMTP id c2-v6mr12211570eds.231.1538783421403;
 Fri, 05 Oct 2018 16:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <20181005130601.15879-1-ao2@ao2.it> <20181005130601.15879-9-ao2@ao2.it>
In-Reply-To: <20181005130601.15879-9-ao2@ao2.it>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 5 Oct 2018 16:50:10 -0700
Message-ID: <CAGZ79kbaeRVBLhYiqzisADHs+Af+c2giXcsCySAEe4jue_rWwA@mail.gmail.com>
Subject: Re: [PATCH v6 08/10] submodule: add a helper to check if it is safe
 to write to .gitmodules
To:     Antonio Ospite <ao2@ao2.it>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>  static int module_config(int argc, const char **argv, const char *prefix)
>  {
> +       enum {
> +               CHECK_WRITEABLE = 1
> +       } command = 0;

Can we have the default named? Then we would only use states
from within the enum?
