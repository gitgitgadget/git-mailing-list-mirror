Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D96D1F462
	for <e@80x24.org>; Thu, 13 Jun 2019 19:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbfFMTnF (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 15:43:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36838 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbfFMTnF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 15:43:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id r7so6572601pfl.3
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 12:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mCxAc3fNUrmxYcffuQQfGPyPCGVSqBzC9OcVe2mH5Ug=;
        b=RhyA3qk9dVuBYexyXwZWoSSqdxTceoRDOtoNY6BJ3mbIubwaxk+m3WXRBHwQZN7LFx
         EBgrOI45fgjzacahdVjomRs5zwKgpvZS07crF9J5phPMPGY74xtTQE9isFqLwtKdgZs4
         qj0DKxc00hitLM/YI3B97ZIY6Jqm34f1NE42EEbrLlODaXVTIBcqMYXJ5ilFR2XlNAXQ
         b6rBGV83iEXB8hDpeSr2HaljRY0YrBUtobrnw7CT0FRBtMULtaEan/l7VcJe9V+DtsAe
         PJ4Sh+KwQAIj2XKNA2wTlSlFZT+vYGBdH0qPIlR6Y8kaSmkKNnmzze0x3OMlPZii/vWR
         VVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mCxAc3fNUrmxYcffuQQfGPyPCGVSqBzC9OcVe2mH5Ug=;
        b=jG23apKHgQ1FZxqXYnsO9ireZJgreYkrlyG2LwXINUm8b7UeYk5qsDMacQr+bDRGeR
         bKRfCSGdiH4ByjTQlEQGrw8BcQpVq40ec+oEyLOSkuUUSS5VUG3nu9otHDka1I+l0cwE
         Ohd8hGvZd4vvNoi3u+ttyZsbSNXwDnkdfWTrWEULuXpMxvmeDhjlgp2FEGOgDbT3OuHB
         cfySl8PCVE9ZRF53jOTfmQXNjYByOZJjZzcVhLlMH0N/xY9QkFcRMznJDr9OEQ/J2TR+
         EDOxsbFDkW5OiwJ7Hpld2/Y15h8eUwSyzB7lezLe1if9oj34durOxqGlowdUSik/a/pT
         x4TA==
X-Gm-Message-State: APjAAAWxAsZ2+gPCmHRuTKCJL0Ql5xIWJ4iUqEB8OBSt5FVyvQNTshY6
        VkInyfUiX3r4gdohNvLiESBVcuAt2P82144yNhY=
X-Google-Smtp-Source: APXvYqwIAD4lG/Ss5tl+DM+czyybet9UOcGaqGfVjfURJV3A8YzJrpBgs0EW5W8gXxnEqKByBhey/NZWeEpB+Ef8GhI=
X-Received: by 2002:a65:6495:: with SMTP id e21mr17860042pgv.383.1560454984635;
 Thu, 13 Jun 2019 12:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <f0059613-d3e4-a1e2-2c01-727579e069d2@web.de>
In-Reply-To: <f0059613-d3e4-a1e2-2c01-727579e069d2@web.de>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 13 Jun 2019 21:42:53 +0200
Message-ID: <CAN0heSriaQV7zd4h8gfazi0dY_Dc5qLBWfJBtZGxOtm1+cgZqw@mail.gmail.com>
Subject: Re: [PATCH] cleanup: fix possible overflow errors in binary search,
 part 2
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 13 Jun 2019 at 19:54, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> Calculating the sum of two array indexes to find the midpoint between
> them can overflow, i.e. code like this is unsafe for big arrays:
>
>         mid =3D (first + last) >> 1;
>
> Make sure the intermediate value stays within the boundaries instead,
> like this:
>
>         mid =3D first + ((last - first) >> 1);
>
> The loop condition of the binary search makes sure that 'last' is
> always greater than 'first', so this is safe as long as 'first' is
> not negative.  And that can be verified easily using the pre-context
> of each change, except for name-hash.c, so add an assertion to that
> effect there.

Right, with "safe", one might mean something like "no undefined behavior
due to shifting a signed value with the high bit set". Especially since
we're worrying about overflows, we're obviously having large values in
mind, so we're right to consider the sign bit. But, we're fine as you
note.  Because we subtract, and `last` doesn't have its sign bit set,
and `first` is non-negative and not greater than `last`, the sign bit of
`(last - first)` is always zero.

So all is well. But maybe we should write `(last - first) / 2` anyway.
We could then drop the extra parenthesis, and we would keep future
readers (and static analysis?) from wondering whether we might ever be
shifting a signed value with the sign bit set. A few spots fewer to
audit in the future...

Martin
