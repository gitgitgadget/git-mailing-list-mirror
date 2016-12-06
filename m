Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3B7F1FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 22:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752469AbcLFW0l (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 17:26:41 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:33639 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752437AbcLFW0l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 17:26:41 -0500
Received: by mail-qk0-f175.google.com with SMTP id x190so395832964qkb.0
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 14:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XFuDoPHWbKSKNHioYYnJSzPp94KqicFL4+DfLKbkXbo=;
        b=GLRJ5mI7RwsVcT923BB6akF2R211x/tYWfj8bo0Y0BtrK82fEQDGAZyXwtlYJ2qXzz
         eEtFf7fGesZowEMMLAYhfi9vthz0CE/QeSZIgeJyEFAgGx1Hs5Odm4E7Dbdeu8kCoMo6
         ap4NAGbdt2E3Jg8I46OSCQ7tr8xu56w8L7nCYNdRghXEA2j9N+HA/OkUzRAyOqOmyTNb
         /D2oSPOdrDAEpb/xUL2g23kUBXDXACsx4ei9dJXMAfXaNWsLSAwsizNQh+aaUej5/oDV
         AZ4yui95vgFmWxY8mPg1RdniWBpKwJAgOPxH2z5JxzhCHNzwIwdZKx9rT/NVFpKk+an6
         WM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XFuDoPHWbKSKNHioYYnJSzPp94KqicFL4+DfLKbkXbo=;
        b=eW8zKGWGsw/NjujuZqz0nDhB6f2Z+6xSvimMiZ+D64l7G2eMgSoklcH8gsGlWviGjI
         fiwkBiznKcfK1JhJq9P1Afvo8hvFdCsPxjvyBgrGemXequtdRNWIZcIr3CpBw02ZkoK6
         ccQiRbfGFixolrkPsqTe/6+csUxXHPdqzTDlygrbzyOzWxq6Zmutq3ozopEK2wi3mirS
         94k7yDoWPxwU0nv97PYSqVRhacKQMWdL7lFnVFAFI6iXCgklmMCK7HxkHebZ/ATG501L
         7DiGtJEnqbWIUuZ0nMw58JrL/Zn2fWSTV2tjrcKnh/ImYWaIZHrFJ3+QkUqg2rGI1Sqj
         gJRw==
X-Gm-Message-State: AKaTC03Dd9Zo55aZyMa4c60MvoJ0ilN5zs7gUUXSJ6Kh5WUag8dc8TGU3o7VKxJXlZoxOquj1XOCxp/kfaOaH94s
X-Received: by 10.55.16.147 with SMTP id 19mr56597396qkq.255.1481062819467;
 Tue, 06 Dec 2016 14:20:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Tue, 6 Dec 2016 14:20:19 -0800 (PST)
In-Reply-To: <1481061106-117775-11-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com> <1481061106-117775-11-git-send-email-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 6 Dec 2016 14:20:19 -0800
Message-ID: <CAGZ79kausxZMinZymG8mE4jQ1pi4yJ80WRBUGFhUK7mmfOBCvg@mail.gmail.com>
Subject: Re: [PATCH 10/17] pathspec: simpler logic to prefix original pathspec elements
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 6, 2016 at 1:51 PM, Brandon Williams <bmwill@google.com> wrote:

>                 struct strbuf sb = STRBUF_INIT;
> -               if (prefixlen && !literal_global) {
> -                       /* Preserve the actual prefix length of each pattern */
> -                       if (short_magic)
> -                               prefix_short_magic(&sb, prefixlen, short_magic);
> -                       else if (long_magic_end) {
> -                               strbuf_add(&sb, elt, long_magic_end - elt);
> -                               strbuf_addf(&sb, ",prefix:%d)", prefixlen);
> -                       } else
> -                               strbuf_addf(&sb, ":(prefix:%d)", prefixlen);

This fixes the issue with add -p . mentioned somewhere else on the mailing list.

> -               }
> +
> +               /* Preserve the actual prefix length of each pattern */
> +               prefix_magic(&sb, prefixlen, element_magic);
> +

Did you find a reason why we passed magic literally, i.e. short magic
was passed as short magic and long magic as long magic before?

I cannot think of any reason why that would have been the case,
but I assume there had to be a reason for that.


Another note: This collides with the attr system refactoring, which I
postpone redoing until the submodule checkout is done, so maybe
you want to pickup this patch:
https://public-inbox.org/git/20161110203428.30512-31-sbeller@google.com/
which only relies on one patch prior
https://public-inbox.org/git/20161110203428.30512-30-sbeller@google.com/
