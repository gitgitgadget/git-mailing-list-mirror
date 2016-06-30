Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE65E1FE4E
	for <e@80x24.org>; Thu, 30 Jun 2016 15:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbcF3PFK (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 11:05:10 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:35307 "EHLO
	mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932102AbcF3PFG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 11:05:06 -0400
Received: by mail-it0-f67.google.com with SMTP id g127so9128481ith.2
        for <git@vger.kernel.org>; Thu, 30 Jun 2016 08:05:06 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3Ige54COERMXY3O5Fb4FX2rLuwlzc8KA5Cp3EDCXJZc=;
        b=RnNSAIK4ZE/gBZy0cxm2hfjJRdOLKk35OUGNXQSVoH7c5mQCZH5PmVq8aaNDc2sy02
         6K+g1heJ4gmkS2/X7bTPUNs+bKkcUb0q8adguL3eYfBdfSZ0yPX8wcqKhb0mQIkp4i0s
         5FZKZjp5/BTC5/VXBiZKckc2Y2M5PF0z4aKyzTWT9ki4+8QRln5IdornrtbUfaRrvSLb
         kZAeBUBWkTJ3NlejpaHsdIuTLAgqps0HxA2DXv9ooPtPhGxLlnYt7hrZTiEORtPTX3ot
         clLgq6MAgSXc0MVXPtbzwUFtSFvSHtsCf61uAKDF7VRhvzTR1luMQRFL6FvCYSK32H7s
         3pnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3Ige54COERMXY3O5Fb4FX2rLuwlzc8KA5Cp3EDCXJZc=;
        b=DLP5NJXhvpbTyVvCLQja5eof0lAIL5CxMqesCNSD7OvGEBeOpr/+qPT7dxrmg5dNPz
         +GlM7U9vZFMSSmY/s0EPzMqXLs7n9PZpwySBt3UtdidpyVB7ib+cixqoVrDq9xFFtRuY
         K5jBHHYfJXOOK5q+xRoSZ+9a+/UFAanBmcXYqCtMVw40cyx80qVHvEDQTde7H/oBg8gi
         6wuajNwLyJpoKKguZjC0p29flZgnTjg/iL4FqBcFQt8Z8cKVRolXwtWklap1ao0YDgBs
         d1jBq3yUdKYFGBQEdKBTStEsVOI+1zRrqPtWSg/UAVw3uMLPh2Xiad5Ws5ynZl45vakM
         UJjQ==
X-Gm-Message-State: ALyK8tJ2HEMkD72iqDqnNFe19pl0d1ySePw9NPttIwqYgS42X9y+ShhPMNyJ/HkvWMicc+oDKYhe9uadfC8OPg==
X-Received: by 10.36.33.22 with SMTP id e22mr11395784ita.42.1467299105499;
 Thu, 30 Jun 2016 08:05:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Thu, 30 Jun 2016 08:04:35 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1606301457340.12947@virtualbox>
References: <1466914464-10358-1-git-send-email-novalis@novalis.org>
 <1466914464-10358-4-git-send-email-novalis@novalis.org> <alpine.DEB.2.20.1606301457340.12947@virtualbox>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Thu, 30 Jun 2016 17:04:35 +0200
Message-ID: <CACsJy8DuTsDAYzRVk=mW7WX5CZb0Z5bAPnzV_2KXK-BcX=tcVg@mail.gmail.com>
Subject: Re: [PATCH v13 04/20] index-helper: new daemon for caching index and
 related stuff
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	David Turner <novalis@novalis.org>,
	Git Mailing List <git@vger.kernel.org>,
	Keith McGuigan <kamggg@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 30, 2016 at 3:06 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Even when NO_MMAP is empty, there might be no Unix sockets available (such
> as is the case on Windows). In any case, you really only want to skip
> these tests when index-helper is not available, so would you mind
> squashing this patch in?
>
> -- snipsnap --
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Subject: [PATCH] fixup! index-helper: new daemon for caching index and related
>  stuff
>
> ---
>  t/t7900-index-helper.sh | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/t/t7900-index-helper.sh b/t/t7900-index-helper.sh
> index 6c9b4dd..12b5bf7 100755
> --- a/t/t7900-index-helper.sh
> +++ b/t/t7900-index-helper.sh
> @@ -10,8 +10,10 @@ Testing git index-helper
>
>  . ./test-lib.sh
>
> -test -n "$NO_MMAP" && {
> -       skip_all='skipping index-helper tests: no mmap'
> +git index-helper -h 2>/dev/null
> +test $? = 129 ||

So when NO_MMAP is set, "git index-helper -h" will set $? to 1. And we
correctly skip the tests as well. It's a bit subtle though. How about
"git help -a|grep index-helper"?

> +{
> +       skip_all='skipping index-helper tests: no index-helper executable'
>         test_done
>  }
>
> --
> 2.9.0.270.g810e421
>



-- 
Duy
