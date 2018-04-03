Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53F811F404
	for <e@80x24.org>; Tue,  3 Apr 2018 18:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752759AbeDCS7m (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 14:59:42 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:43820 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752132AbeDCS7m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 14:59:42 -0400
Received: by mail-yb0-f194.google.com with SMTP id z5-v6so6659118ybo.10
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 11:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1p2gd6iEJVtWHDAIPFwRDBVHCcpMyxGYQ+rMnUy9oWk=;
        b=qaZ8KUk3ps0Rwy5kJaKC6h/10P+BepZzW85WB7EmUOwsr0y+RGsHse+njN+UBwfnoM
         lejE5nUxypnOM5XtWSQmLyEzVhld0QAjqzN53TVXITpuBLxFPDo0LhjRqRwha+8Tvm93
         o7mxTDnMdsErPZUKrXMgfA3t/MPpoEXiExie9NjO6/0AiWcwY1TM3z7m19N2SFUiVCI8
         cquohNLtuQH+zEjLotNW1zb3DxCAd3DO54JlmpndLV0fOEwam5mVrdnSNFREdViklZr9
         8a3u0qaYJgQNriQp4KVgKyN2BtWoPMaB0T5+Y6fIWJDbD3CbmnRtaYXFdwBmeM/wfIks
         OzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1p2gd6iEJVtWHDAIPFwRDBVHCcpMyxGYQ+rMnUy9oWk=;
        b=YcB8xhcFYeKCU9g/OtelfnN67WYYmMsVbZh8lVkgXEN73gf1Ac4b/iuDKQV0pT3zzP
         4+N5dNQV6Y6I8YVRJLw8O7/pBdKENhqyRTqnHK4OhjGanpoJZhER9GLCNuDeWkFnPPBC
         fIROVq776nf0RbwdU7jPQBAtyX+bUhx/9voYLK1IkbI2/7zsN+2flwZypa2PbZnRBF8E
         //CKyFQeLy7njrpEs4gvOq8WvK4/VuyXIMcwN2sO4H2iCTBRR9+wwA2AjAnsm4JT/jMN
         fE54tkesfjx79cqMgYOmqy99bp7XGc/Dbmbuh3MvjUPNJdX2N8wpKcYmCLGTTC1LWNOC
         XBbg==
X-Gm-Message-State: ALQs6tB2x2TSPR3J6NIUqI8ZgTtB3lmyHhV1wv9Cd9e8UF83ioccHZ7v
        tFMKNlGNXXuWjcaV4Eu9S5wafesbkQBksRpWsqi9nQ==
X-Google-Smtp-Source: AIpwx48efDetkWQFf1LqHf9Lst5Wi3OsaxrqFgLOWMU81JH6yRCdTbTs5Giy1m4ubUos9uwh5LamX2xbQapugNa8Fig=
X-Received: by 10.129.84.66 with SMTP id i63mr360695ywb.340.1522781981218;
 Tue, 03 Apr 2018 11:59:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Tue, 3 Apr 2018 11:59:40 -0700 (PDT)
In-Reply-To: <20180402165144.73e701d7816ddfcf00006d95@google.com>
References: <20180402224854.86922-1-sbeller@google.com> <20180402224854.86922-6-sbeller@google.com>
 <20180402165144.73e701d7816ddfcf00006d95@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 3 Apr 2018 11:59:40 -0700
Message-ID: <CAGZ79kawikdHRK_HpB53R8c-B3K1JEVSmfR9V27X1=1OuXbmhw@mail.gmail.com>
Subject: Re: [PATCH 5/7] diff.c: refactor internal representation for coloring
 moved code
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Simon Ruderich <simon@ruderich.org>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 2, 2018 at 4:51 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> On Mon,  2 Apr 2018 15:48:52 -0700
> Stefan Beller <sbeller@google.com> wrote:
>
>> At the time the move coloring was implemented we thought an enum of modes
>> is the best to configure this feature.  However as we want to tack on new
>> features, the enum would grow exponentially.
>>
>> Refactor the code such that features are enabled via bits. Currently we can
>> * activate the move detection,
>> * enable the block detection on top, and
>> * enable the dimming inside a block, though this could be done without
>>   block detection as well (mode "plain, dimmed")
>
> Firstly, patches 1-4 are obviously correct.
>
> As for this patch, I don't think that using flags is the right way to do
> this. We are not under any size pressure for struct diff_options, and
> the additional options that we plan to add (color-moved-whitespace-flags
> and ignore-space-delta) can easily be additional fields instead.

Gah! I'll give it a try.

When I came to the conclusion that the features of this series is
orthogonal to the existing code, bit fields came first to mind.

Let's see if the alternative is easier to read.
