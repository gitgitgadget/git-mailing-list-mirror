Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0A6B20248
	for <e@80x24.org>; Thu, 14 Mar 2019 14:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbfCNONb (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 10:13:31 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:34451 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbfCNONb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 10:13:31 -0400
Received: by mail-it1-f196.google.com with SMTP id l4so1016459ite.1
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 07:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p4zZ+nm/2itcOojdvmrmTiX8r67KojaI656wjtjAoU4=;
        b=PtJRhK6/oLZ+jf48b4xNFqdgYN1C0WKmTGAj7Ga+dy7gHhnSILdna46ktFz2WJb+Ew
         CsEyRBXVpzSmHckN/HnpRWFw588awX6a8EoGyzyu1JfissOaWARguFkgZr4mgSj+fs1u
         MbyKPMKbsWIHvNDkyhoK/LOeDVLnSBsUWlykXbBUdWOa11n7rq7WtO/LEpmGJ/w1q2ZD
         Hdqj1eZYHgfK8FuyjRxweC10ATGWfF3QFX5EqXT9ZuDTujtk22UWMtsTEPbVO5LtiywB
         HxJoCVFS0ZbpKh02ShsrL9X574RuxBkOCSKBXlWHvDez5L4aGT2OP1tJOS7h4lG5OLme
         D3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p4zZ+nm/2itcOojdvmrmTiX8r67KojaI656wjtjAoU4=;
        b=qkLUYnUUJ7sjNiYwuWl6ihABa/eBY5CWuSAOMrE5zrAoDEcIIhrD6LUfi2QcSLAfs8
         vPD5pAOgXq6MhGnGk8VFlmmCzTZuQmysLQhDOQ6m0DD38t4u+mwtMCNbCO0GzQ8bTkpD
         cArr9Ehd68rc7MhFNiEF3gdls9zxXoUfKjwJhUL2qqjGqlEokn+SVET+S0LeHOej9Txj
         kIQGqTmbZzMnv5xvdA7O8yKkfzdw5wC8DFptW3pkYm+FyM0CLAcSmdXDouFV/ZOeB2E+
         9I7U6eTJaEeKfxCbVcyoZj026Q9tIVBiy1ddQnOTTkrt5MSxRaOGIrRmPauS4jZhqC8Q
         UAWQ==
X-Gm-Message-State: APjAAAV3O7ONpFxD6JhzGm3pv4+sTkz5dh8dKCsdvjMVSPoE4xitBTa8
        jaVTob16eqajraful86ykyIhae+gHHlmofdmJPQ=
X-Google-Smtp-Source: APXvYqxrLcec5NitjNJdt8M0tyECje1sZm5eNZetHm3ETFxLOYixgoBIPWQu+m2Ht74fgct4jb+EoncRQjalQyBm56Y=
X-Received: by 2002:a24:ccc5:: with SMTP id x188mr2101786itf.123.1552572810637;
 Thu, 14 Mar 2019 07:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190208090401.14793-1-pclouds@gmail.com> <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-11-pclouds@gmail.com> <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
In-Reply-To: <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 14 Mar 2019 21:13:04 +0700
Message-ID: <CACsJy8BATpbAG8hDs6n2sfDCgY_XTJtU0MRxT+2FpHETqr+bCg@mail.gmail.com>
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command 'switch'
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 11, 2019 at 6:16 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
> > +-f::
> > +--force::
> > +     Proceed even if the index or the working tree differs from
> > +     HEAD. Both the index and working tree are restored to match
> > +     the switching target. This is used to throw away local
> > +     changes.
>
> I'd always thought that --force meant "throw away my local changes if
> they conflict with the new branch" not "throw them away regardless"
> (which is better as it is deterministic). Maybe we can come up with a
> clearer name here --discard-changes? At the moment --force does not
> throw away conflicts properly (see the script below in my comments about
> --merge).

First victim of --discard-changes (or maybe I misread your comment),
it's too much to type even with completion and I'm so used to the
short and sweet "switch -[d]f".

Unless people object, I'm going to keep --force as an alias for
--discard-changes. -f could be extended later to cover more
--ignore-stuff when it makes sense.
-- 
Duy
