Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDE6A1F404
	for <e@80x24.org>; Fri,  6 Apr 2018 21:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751598AbeDFV2m (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 17:28:42 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:42613 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751435AbeDFV2l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 17:28:41 -0400
Received: by mail-yw0-f196.google.com with SMTP id z82so823362ywd.9
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 14:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=n9Fj1YgNOiFFqM0M5zgDj99GZVq3ZnBC67axkK1LMd8=;
        b=c3c8qWe4Rbe3wvOvo/SSLeRRp+eakJcDbWXcFnjYHiCS9+MbrEnNWHGLQLuw10zkDc
         Nx0tWfiOTyWMHpsY8Xh/ueUhs5M6D7tVqXwB4X6ufj7827QhGtNRnTQfDIS0usFp++7Y
         MWj2Z2UJRSF71QqBtoSRAaH7yWOcn4dOmVLpIuxTAHpzko1AGYTcAC3Q3XFLYlR8Qgav
         sdgqrbeH9CaFs+7GjJg79uNRbkN8Wl81ba7QArI4whfhQu9bpM0Q0/WViTz9czQSMU+M
         CRkcUFM7WyiSw12lQnnzKgvlYo1n1gRihBj0JMNQr2ULF6qR6mTeScLyVo3XEy7Avg3d
         2IDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=n9Fj1YgNOiFFqM0M5zgDj99GZVq3ZnBC67axkK1LMd8=;
        b=lJACPmjS/zgZqQc5of8ocNE1xgLMEDMcYWeYbEy1cSDe7gWP6OV/pSzKOUnkFRGwTy
         CXrqlQ205MaopGFG3MmO9+bcbuctNUDlxrQooQhlm76VzgeYZ/94Rx5dF+ZBP7AsnXNs
         Z++8n2cjWlzw+FZKG+/0Zo0X7mRPXbe8DRVpo2eNJQzNbqLgSsY7XWEueNd6tDPH/CDR
         1Ev0o1uudcwN7yFenhHhe8a1gCx3JuvtOS+6ARjjNk3Ymk9qIrNvRpcXNuELJtAa+9bU
         iWdVE5ZBieLlMe/UH+ogLvjSNBZiumQ2fTHl8JdW+J5ok5/If15xYv1Gm8bOp/8jV3sn
         dEFQ==
X-Gm-Message-State: ALQs6tBQchKpzmHinz2Yx4X+L2xz6J7+8Yantt69ZlvzbeI6nl7JgDhc
        iwJCIGv0qB/9s7Zxe5aeucpqcHcf3CG7ohTptwr4+w==
X-Google-Smtp-Source: AIpwx4+eY7MBtd2fGvREIxlX8oqcK+d7WnuJMkUeH8AjguKC9ZZIh/wxMtepZgYt5BY1piuroMYo7/MhoE2rC+sEtIc=
X-Received: by 10.129.232.5 with SMTP id a5mr7927512ywm.421.1523050120538;
 Fri, 06 Apr 2018 14:28:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Fri, 6 Apr 2018 14:28:40 -0700 (PDT)
In-Reply-To: <20180402165144.73e701d7816ddfcf00006d95@google.com>
References: <20180402224854.86922-1-sbeller@google.com> <20180402224854.86922-6-sbeller@google.com>
 <20180402165144.73e701d7816ddfcf00006d95@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 6 Apr 2018 14:28:40 -0700
Message-ID: <CAGZ79kZe1SEy2PkYGe200KwZHZVieAJJaiWYLD7GadOCCcmeOg@mail.gmail.com>
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
> this.

Now that I redid it another way[1], I have the impression that this was the
right approach, because it allows for a short
  if (o->color_moved)
condition. If we treat white spaces separately, then we'd have to
have implications such as:

  if (some white space option)
    the enum = default if not given explicitely.

which we do not need in case of a flags field.

[1] Keeping the enum around and having an extra variable for the
white space related configuration.

> We are not under any size pressure for struct diff_options, and
> the additional options that we plan to add (color-moved-whitespace-flags
> and ignore-space-delta) can easily be additional fields instead.

The  traditional white space flags would want to be a field and occupy
the same bits in that field for ease of implementation, and the new option
would just fit in by picking a new place in the bit field.

Thanks,
Stefan
