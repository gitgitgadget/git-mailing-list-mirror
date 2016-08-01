Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4EFE1F855
	for <e@80x24.org>; Mon,  1 Aug 2016 16:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754230AbcHAQax (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 12:30:53 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:34876 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754198AbcHAQah (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 12:30:37 -0400
Received: by mail-oi0-f44.google.com with SMTP id l72so199910274oig.2
        for <git@vger.kernel.org>; Mon, 01 Aug 2016 09:30:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8Gx7d9K2YttpzDTUrTtV6AUZVirNx7WIrwizuOpRFZc=;
        b=JaFwT7U446QtOXNtVrjvqkK29iEb/4kqeBLWb8lTai64PpQN9PpoiWjL8jrqer3i+T
         0skTbw8lpYiAEh8s/ubJYsvfE20J7ObR6BtizNzPduKJ07yvOKotc1nJ9hYj0/ZXbbPI
         HdrU7mCyUuSFpq0njS0KHNIOPcU+bllV/TQ0D97B7s8duw3k3pSGSCuWKmWB1Y7dT7pu
         X7FVrKJNZHTDry5VVtopx1ZgbrusBojV2B4yKeGyPLRxOgRCrLd85I9YIBOs+zzOk2z6
         CJvPaWCrUSHbeCfGnP3wOSUBEBQgT3VZoCIxsZQU6S7MiuO1sLOTZyGF7gELe30pVFyh
         6oiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8Gx7d9K2YttpzDTUrTtV6AUZVirNx7WIrwizuOpRFZc=;
        b=GaVhrE5jcCqioe5V7hZFULV+HovSUfjbXTvSH3RyCjcSSW/93x4OUmumNUQi79XopI
         259Emw1PxJi3Az+VnxgbDoLpvi6/7bxCcLKRDqYDCem/GNMlAifyVPVNABPvUtFvt+qx
         gK7Rhl4eVmijCm5cbCX+bE4kuY5ntekZrYwJ5cfhriL63CxKEAI4Fk5F65LfUV/xDmXJ
         uz11Xmced5xYfGFnwKuOtzuyeYqiz4Zdn/DS+SbEfnXHZedljRnnJnX6qGf4j3NcHEFQ
         fPBhsB+tudMqUnMH/FtfIyEN80uJyXoI1liwWrdn4rci6HSIGusz6b2YeZWPlg4gVkKT
         OZ0Q==
X-Gm-Message-State: AEkoousu6IkPTXn8uJxZvEhRr78x+6FZQqeRjMjlwLLJs+gteUHYLY7S+Q7qLR3g1dBWj5ZXN1JBdnjVYQ7DfM9L
X-Received: by 10.157.39.136 with SMTP id c8mr35783955otb.34.1470068688816;
 Mon, 01 Aug 2016 09:24:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.149.226 with HTTP; Mon, 1 Aug 2016 09:24:48 -0700 (PDT)
In-Reply-To: <20160730172509.22939-5-chriscool@tuxfamily.org>
References: <20160730172509.22939-1-chriscool@tuxfamily.org> <20160730172509.22939-5-chriscool@tuxfamily.org>
From:	Stefan Beller <sbeller@google.com>
Date:	Mon, 1 Aug 2016 09:24:48 -0700
Message-ID: <CAGZ79kaijAFndjxUd93a49No1AwCx-VzFcwKhkrQNjdmyxodwQ@mail.gmail.com>
Subject: Re: [PATCH v9 04/41] builtin/apply: read_patch_file() return -1
 instead of die()ing
To:	Christian Couder <christian.couder@gmail.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jul 30, 2016 at 10:24 AM, Christian Couder
<christian.couder@gmail.com> wrote:

> -static void read_patch_file(struct strbuf *sb, int fd)
> +static int read_patch_file(struct strbuf *sb, int fd)
>  {
>         if (strbuf_read(sb, fd, 0) < 0)
> -               die_errno("git apply: failed to read");
> +               return error_errno("git apply: failed to read");

which always returns -1.

> @@ -4425,7 +4426,8 @@ static int apply_patch(struct apply_state *state,
>         int res = 0;
>
>         state->patch_input_file = filename;
> -       read_patch_file(&buf, fd);
> +       if (read_patch_file(&buf, fd))

In case a reroll turns out to be needed, check for
"read_patch_file(..) < 0" here,
as we only want to error out in case of errors from that function?
The return value of read_patch_file, is not documented as it seems
trivial at the
moment, i.e.

  0 for success
  negative values for errors
  positive values are currently not returned, but are reserved for future use?

The current implementation is correct as-is, though I think we follow the
"negative values indicate a serious error and positive values are to
be expected,
and not necessarily an error" pattern in lots of other places, so we
could here as well.
