Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 093392018E
	for <e@80x24.org>; Sun, 10 Jul 2016 21:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757309AbcGJVVI (ORCPT <rfc822;e@80x24.org>);
	Sun, 10 Jul 2016 17:21:08 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:36282 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757215AbcGJVVG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2016 17:21:06 -0400
Received: by mail-oi0-f50.google.com with SMTP id n8so22217977oif.3
        for <git@vger.kernel.org>; Sun, 10 Jul 2016 14:21:06 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=wTiWkwKyusEnt8EjdVru9D3CepYgtktlpuK42pK3gyQ=;
        b=B5Rrnu0cpbt6W4AetzkwaDF4HwjFIWkBkcUt0Xxn/PSkReocp5V832hNg6BXew/PMF
         8hy0SlAKU+GK3o168d2svJO8COAmiuAmgpGWLlqru+KeZTkZFXaRllkfXTEX1osV6ICj
         NjnQ9EPFA4aNVpKN6ZR01HsNZ5VYx3qAMUonaAcOLEQ81sFA5k2moAgql8W868mIPidy
         AZGYdFDlOsq6NVgT1eRGVnrzxkVZrJsyII+3oj+humHuvz7lA535QVjoCH9xfxzUSR2f
         lchRRFOvz1ZRnmdk9DGWYNryJvcs4HOvcXDetYz8LKlo92FstXirwT2mHCjncT2dUAYv
         OIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=wTiWkwKyusEnt8EjdVru9D3CepYgtktlpuK42pK3gyQ=;
        b=JsXHxORZbVVz8dejIfxtlF+EtF+DhNWX5iyyc47XD1HbtVSujI0enKfzNvZfbNA5BB
         Nn55BOMW4VIDAdrpS7EIUVefCSJZo91yYuKJy5byym7kuC8uaLMl4gIlzFaHgN87aTbT
         wRJImLq8HNhRjnyqcNgyxWCHJiUKo8pDKU4JP3tGnVPp/AIJcztUR6XrmGNcFLdlKkLF
         9A4ggVfrpLBM6tp5bHyepc3vcNcxn88tD0PSrVMqYtdPmdTFyH/zfUpGHubgg4N6rtHS
         tP+SnSwvt4xElsj5S8NUuMNn0b/lsrQ0L5raeiT6r0y7HigS2G/BwISfDgDfYBTqCg+L
         1hWA==
X-Gm-Message-State: ALyK8tKCMPudZy1IW4m9woz1ndDjVZGQ43PVyXKwL2nOuJOGAS6w4d4PIxoiKVj6kttf6geDaZ5uEePxAqUzEQ==
X-Received: by 10.202.73.205 with SMTP id w196mr7493030oia.121.1468185665575;
 Sun, 10 Jul 2016 14:21:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.221.68 with HTTP; Sun, 10 Jul 2016 14:21:05 -0700 (PDT)
In-Reply-To: <CA+55aFymKO5Bi2qZ-zaiZKQAk7RxusEMJ9Y0Gw6ywdznK+TaRQ@mail.gmail.com>
References: <CA+55aFz=sZnABJr6F2yF_xvx6J6fZod6BbiL2OwszEnjjn-dEw@mail.gmail.com>
 <87eg712v5o.fsf@linux-m68k.org> <CA+55aFyJP8FLaBtsMekzQDsCjDbFPa-qUZNHZNpvva2vZTRGgQ@mail.gmail.com>
 <CA+55aFymKO5Bi2qZ-zaiZKQAk7RxusEMJ9Y0Gw6ywdznK+TaRQ@mail.gmail.com>
From:	Linus Torvalds <torvalds@linux-foundation.org>
Date:	Sun, 10 Jul 2016 14:21:05 -0700
X-Google-Sender-Auth: MS9zD5Jh0DxR4utT4rEUk76folo
Message-ID: <CA+55aFwvZqqSkphgL+UBqfXnSGAFEzmqyH83OMGnpco3ZVZUnA@mail.gmail.com>
Subject: Re: Odd git overrflow bug?
To:	Andreas Schwab <schwab@linux-m68k.org>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jul 10, 2016 at 2:05 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'm getting "extra" being -1 in strbuf_grow(). Let me dog deeper.

"dog deeper"? My typing skills are deteriorating.

Anyway, I dug deeper, and the reason is that "tabwidth" is -1, and then

 pretty.c:1669: strbuf_add_tabexpand():

        strbuf_addchars(sb, ' ', tabwidth - (width % tabwidth));

ends up having the number be -1.

I'm not sure why it doesn't happen in current git master, because that
function is the same, and the logic around expand_tabs_in_log looks
similar too.

That all came from

    fe37a9c586a6 (:pretty: allow tweaking tabwidth in --expand-tabs")

and I suspect the code just needs to protect against negative or zero,
rather than just zero.

Junio?

              Linus
