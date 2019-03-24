Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D4BE202BB
	for <e@80x24.org>; Sun, 24 Mar 2019 12:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfCXM4m (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 08:56:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43090 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfCXM4m (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 08:56:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id d17so7054336wre.10
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 05:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=WGN2PGF/L2af5n/UPta6JV2LpE/wFLGwdrm5ekwbqsI=;
        b=O3c6B8/Wy6qFZGH9mJ5ehHOPGb2pQbjRt384rU6Z1ycysBkndYRQ7Pxq6RsEaFOELS
         aMM4Njmu4id6+EFM64xzx7SuvgrnFiwFA9CyaJJySDLM5tl3/VpKg4FRWGL8/uTjWpNx
         nsw16V6W7tr421/99vDPFGTsjYNn1DZ/dAI8UynRW5N2hcF/NCw7fV/bPjpE8gtUdiJ/
         gyMS/+/05zsbYTDnefFeZwzSvqLrXB14mLdhYHFgTnDWGFfvP0l5btxSAcCbd69C2p6A
         lzm1sng48RAi4oKSnTfXdwAvsw0flh43WwnXFSqFK5pQxnHhB4FbgWJiRZf1i4YTjAYu
         znYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=WGN2PGF/L2af5n/UPta6JV2LpE/wFLGwdrm5ekwbqsI=;
        b=P37BMyFCGacJ2AHhEFRxQEE/jM05vo5SCGjxnRMiOG/EBa380KQNDedyvih6LpD6He
         0Mq1JFhdYJXGlXeXw3WVwinoTfP+rFf2Ry9C+xFvgVvFUtH79mZQOw//xsETzdDa5HWi
         EfpuaM63pgLOZ9OPhFYjNTkvkIRK7JYxwyounQLGjGQ0tIciTGqP4vLKKht7f7+gNCi8
         GLPO+URtuisjZd6OLhV0K3uvab+7eLMAQ9miYMZg4qS0WO0EFgQA1drMt2qRymjz/kvo
         gPzJc6jjcMx2sAP3VrwXrUm/RtgBIkcakSQNvCqdGky1dQb0KLYM9/kbU8VnO2uMd9bv
         1img==
X-Gm-Message-State: APjAAAWN12UmCUhik8kHUu010XwX5e271TX4kUxOqJFT+PwW4BOizkfr
        jXPbjG1GvbzNGBJ2RZvSXTk=
X-Google-Smtp-Source: APXvYqw4XIh3ev9ptWuNerFtb+39J0iiE+v3TMHwu1ArP9ynrkNdequSiEluxKsY0GN3PdyOqa7pIA==
X-Received: by 2002:a5d:5287:: with SMTP id c7mr13114559wrv.127.1553432200772;
        Sun, 24 Mar 2019 05:56:40 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id z129sm12009337wmc.33.2019.03.24.05.56.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Mar 2019 05:56:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     jason.karns@gmail.com, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] config: correct '**' matching in includeIf patterns
References: <CAKNmmv26G05GO7hG9bNvMsjpuUMHZRA+2f94TuG2wDNUwNhHkw@mail.gmail.com>
        <20190323034535.23364-1-pclouds@gmail.com>
Date:   Sun, 24 Mar 2019 21:56:39 +0900
In-Reply-To: <20190323034535.23364-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sat, 23 Mar 2019 10:45:35 +0700")
Message-ID: <xmqq7ecoph14.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> The current wildmatch() call for includeIf's gitdir pattern does not
> pass the WM_PATHNAME flag. Without this flag, '*' is treated _almost_
> the same as '**' (because '*' also matches slashes) with one exception:
>
> '/**/' can match a single slash. The pattern 'foo/**/bar' matches
> 'foo/bar'.
>
> But '/*/', which is essentially what wildmatch engine sees without
> WM_PATHNAME, has to match two slashes (and '*' matches nothing). Which
> means 'foo/*/bar' cannot match 'foo/bar'. It can only match 'foo//bar'.
>
> The result of this is the current wildmatch() call works most of the
> time until the user depends on '/**/' matching no path component. The
> fix is straightforward.
>
> Reported-by: Jason Karns <jason.karns@gmail.com>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  Sorry I didn't notice this until Taylor's reply. Not sure how to
>  explain git-lfs behavior though.
>
>  config.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

The analysis above is very good, and the updated code is a natural
consequence of the analysis; very well done.

Would it be easy to protect this fix from future breakages with a
test or two?

> diff --git a/config.c b/config.c
> index 0f0cdd8c0f..c2846df3f1 100644
> --- a/config.c
> +++ b/config.c
> @@ -242,7 +242,7 @@ static int include_by_gitdir(const struct config_options *opts,
>  	}
>  
>  	ret = !wildmatch(pattern.buf + prefix, text.buf + prefix,
> -			 icase ? WM_CASEFOLD : 0);
> +			 WM_PATHNAME | (icase ? WM_CASEFOLD : 0));
>  
>  	if (!ret && !already_tried_absolute) {
>  		/*
