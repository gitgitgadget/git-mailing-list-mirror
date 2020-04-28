Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88934C83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 16:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61A3320730
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 16:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgD1QHI convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 28 Apr 2020 12:07:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53886 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbgD1QHI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 12:07:08 -0400
Received: by mail-wm1-f68.google.com with SMTP id k12so3415541wmj.3
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 09:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nn7sox43ZIPqWASsl/K4JYjdc2Jd7su+WbJRnvsRElg=;
        b=rizyNA69D5sLxrGEwckcJm3bNNprRQ87cQG/raUVpUD2qU5UrXBwUMqpTb0R/CEdjg
         RaPBf7cGI4WkU+jYtGJh2MwJtdYtrqfwGxdOlx5so5/Qc1bNLPLGjmkgtHO5W2hGWBzc
         d/vn7xNzMT+/Nf7HbhpeEOWpN7tPbjIfJ0BOSNKaLGIFfHalxwSlXBpm3rmqCtJYJhG3
         pChknFBSUpLGDh75fzwuHPr7MCsgubkHxrTbzIpD7UDTqMADeX1MzLS8wSWYQ6kJiDMk
         MBnkj8f2xn8TvC2+V+vs5MAfvRdHvz1tka9DPgzG4GBGINDXTLkd5PCCA/AgCRguB4Hq
         Q5DQ==
X-Gm-Message-State: AGi0PuYuEwOOHwuKzGgZIaSNLFlnsncsn+CB3QdR5ToLkOrae7KLUofo
        k0IsBYPt6Ol2xOzoMALJ4Iq63BbHBfxiPVlh8tngxw==
X-Google-Smtp-Source: APiQypIhf1hoyF7T3hCzvfYh540FD1BcQYaJ15Nv5++gFhRh+Az+Ds3sX+16CK1Pu/9hnD5Jc3I1W0p84ldjJeLO9HI=
X-Received: by 2002:a7b:c213:: with SMTP id x19mr5232228wmi.53.1588090026099;
 Tue, 28 Apr 2020 09:07:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200428104858.28573-1-carenas@gmail.com> <20200428105254.28658-1-carenas@gmail.com>
In-Reply-To: <20200428105254.28658-1-carenas@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 28 Apr 2020 12:06:55 -0400
Message-ID: <CAPig+cSJDHhUDQ3PGQRen32w9-8xVVFijDDoC5nqzioBHSL7Yw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] credential-store: document the file format a bit more
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Dirk <dirk@ed4u.de>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 28, 2020 at 6:53 AM Carlo Marcelo Arenas Belón
<carenas@gmail.com> wrote:
> Reading a malformed credential URL line and silently ignoring it
> does not mean that we promise to torelate and/or keep empty lines
> and "# commented" lines forever.
>
> Some people seem to take anything that is not explicitly forbidden
> as allowed, but the world does not work that way.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/Documentation/git-credential-store.txt b/Documentation/git-credential-store.txt
> @@ -94,6 +94,10 @@ stored on its own line as a URL like:
> +No other kinds of lines (e.g. empty lines or comment lines) are
> +allowed in the file, even though some may be silently ignored. Do
> +not view or edit the file with editors.

I suggest dropping the "even though some may be silently ignored" bit
since it's both mysterious (providing no concrete information) and
unnecessarily confusing since it flat out contradicts the earlier part
of the sentence. The fact that the implementation has accidentally
been loose in its parsing doesn't warrant introducing such ambiguity
into the (newly-added) documentation.
