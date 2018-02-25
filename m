Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 784911F404
	for <e@80x24.org>; Sun, 25 Feb 2018 03:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751568AbeBYDw0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Feb 2018 22:52:26 -0500
Received: from mail-qt0-f179.google.com ([209.85.216.179]:36794 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751505AbeBYDwZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Feb 2018 22:52:25 -0500
Received: by mail-qt0-f179.google.com with SMTP id c7so15150331qtn.3
        for <git@vger.kernel.org>; Sat, 24 Feb 2018 19:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Nj1REYG18C85qy7VsAUQEUfWbFDyYQQ+zB16ODQUv/A=;
        b=BYQqEq0+c94VmGRQw396S1kWE08Cqz73mdh8qvH6v4zXFU+31BurS/sr4hNNaJEFyJ
         03mA39ML8HiMM21hpOIvoTLbIk0jOUVDWvJBpkn2/v5YHAy+YryCOGshbvZY1RgtI9iw
         iC4JifVvIXl01miTZVWdSAIHTn+Hi7vZ+N/Ydox1uDi9Y8tMn8hXnNvR/W767vbguSUV
         KefC6cGOIhudpPNKvJmepPxG0ztuYZquf2EC/HDwkBSP6YO4YHE2AXW1b4AkY18K4xHk
         mUTqOQBaHYZyt2z2IKCMTPMP9VFhqh4mcUWC3PUpykDaNFDTyqtD8Qb0GOdZog7r5SV2
         8ljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Nj1REYG18C85qy7VsAUQEUfWbFDyYQQ+zB16ODQUv/A=;
        b=l5ktcVibv5f6jyFTDsUPh7FUv1gRTtFwSGfDe+becdKBwtWuhuIhgOmujl6KhBa1YW
         RuoLcSAvZdplauny/gxv2njNOAN6lG5KABqTuwpje6Wefxi/j6AOT5PtPJyrWhq2mR46
         jsQf8BsgcCXJsbEAM9Ozosiw4SWN7YfnO4yM9ZS3InEjbEa+o2NUTnJIieghn5QW86/T
         Ri48iIVswmjkz58eYksNRk7mC5ufUNwoT2sghvbwKgysKzo/lHsCqrlEXHGYk6S3MrtO
         Z0raEcdJxvUjwkBf60xmcBbLMkULs9WY4xzRVDkrD3gWI7lR8o8RJPfUSAFUY8UW69gS
         riSA==
X-Gm-Message-State: APf1xPD+nIGzIkF2vILV5fNNVMTZhoKwZkN7FsPK6Kgd/xSbC6ndnmmL
        kYs2WYXE99UmPLa+kLw1pJBkLzOT5hwj3OnS2n4=
X-Google-Smtp-Source: AG47ELuSP9Y3nrqp3Fjk6tg1u6rPa58MKKVgYtnmvn4jnsnXRTnemTiW3BIMWG08FLEBj0iRC95cXTkEkXwMZwxmqYQ=
X-Received: by 10.237.62.233 with SMTP id o38mr10530828qtf.3.1519530744743;
 Sat, 24 Feb 2018 19:52:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Sat, 24 Feb 2018 19:52:24 -0800 (PST)
In-Reply-To: <20180224162801.98860-5-lars.schneider@autodesk.com>
References: <20180224162801.98860-1-lars.schneider@autodesk.com> <20180224162801.98860-5-lars.schneider@autodesk.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 24 Feb 2018 22:52:24 -0500
X-Google-Sender-Auth: mX-jlwcOmcYgqt9fNPn0JAnLMLY
Message-ID: <CAPig+cSX9uLWi++3pOis+iPGqEbrAL5px70CB-aUjDVGYZqweA@mail.gmail.com>
Subject: Re: [PATCH v8 4/7] utf8: add function to detect a missing UTF-16/32 BOM
To:     Lars Schneider <lars.schneider@autodesk.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 24, 2018 at 11:27 AM,  <lars.schneider@autodesk.com> wrote:
> If the endianness is not defined in the encoding name, then let's
> be strict and require a BOM to avoid any encoding confusion. The
> is_missing_required_utf_bom() function returns true if a required BOM
> is missing.
>
> The Unicode standard instructs to assume big-endian if there in no BOM
> for UTF-16/32 [1][2]. However, the W3C/WHATWG encoding standard used
> in HTML5 recommends to assume little-endian to "deal with deployed
> content" [3]. Strictly requiring a BOM seems to be the safest option
> for content in Git.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
> diff --git a/utf8.h b/utf8.h
> @@ -79,4 +79,20 @@ void strbuf_utf8_align(struct strbuf *buf, align_type position, unsigned int wid
> +/*
> + * If the endianness is not defined in the encoding name, then we
> + * require a BOM. The function returns true if a required BOM is missing.
> + *
> + * The Unicode standard instructs to assume big-endian if there
> + * in no BOM for UTF-16/32 [1][2]. However, the W3C/WHATWG
> + * encoding standard used in HTML5 recommends to assume
> + * little-endian to "deal with deployed content" [3].

Perhaps you could tack on to the comment here the final bit of
explanation from the commit message which ties these conflicting
recommendations together. In particular:

    Therefore, strictly requiring a BOM seems to be the
    safest option for content in Git.

> + */
> +int is_missing_required_utf_bom(const char *enc, const char *data, size_t len);
