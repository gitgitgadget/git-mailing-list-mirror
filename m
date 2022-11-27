Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F49C4321E
	for <git@archiver.kernel.org>; Sun, 27 Nov 2022 09:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiK0JBT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Nov 2022 04:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiK0JBR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Nov 2022 04:01:17 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D060F9FC2
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 01:01:16 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1432a5f6468so9822515fac.12
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 01:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ogBW0faOXrCwqajIXVbeyiSe3IT8DEeQP6u5d6Ij5+8=;
        b=RYm5mmnF8WvRzAq61J1/11sJKSf0omZxN+MOoXJE83QxRuQWkfCjWG1hr0toAN9dXc
         0NVuFD88sHC0cOBI4jWaPJP5se4lrKuWiwFBonekWXxSL3zAHx108qlOmUJ1gCBXJd5v
         34ip+OJb84sFp588R+6mbTXHVwDquJGsVnZ87lyrANp2ayQrEYeTYnHEj4U3hwh4nXca
         H1bRhwhR9cuJp517UzT9VAj5OeJA22A3zpHD7KxSmeViM6eSj34bsIFBstx7Xae92fvQ
         NjzCCe9KdKH3/jQUjuEOa1g54UMdUncWVwaFNLHKjvH39hzTpMu3fzpQMm0UPJN3bW6g
         o4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ogBW0faOXrCwqajIXVbeyiSe3IT8DEeQP6u5d6Ij5+8=;
        b=lp9Q6Ee6HORzVYlEyOUSfp58jKBqNkhRfrTTS/GciZXb/xI+T7nzCaY54QlJb1wsaa
         MeaFWlsk7bSAKb3AfNyG0fC1RmVsrgHbJSTfMVsrhmg9G/CMpTl8N3G02e1z6/I/IPVk
         nJ10fYZ9+LjpvDTU3Pz1T8+QDRM/Y4+crhFuQBtEakt8dW6bltSj/nUi4hPbAA3MxL1u
         qCNdJV1rIZfErS/YKLzo5ew0hLrbiZB7VwfPUP3d/bGA218W91m/78zymeUARzKgMi3z
         PzqmfnW3vv7tQyj59ZNO5DRWWPnLkOJj/BSVKu3cReiReDoT4PGtJsX+mxakbSNoyilU
         4H5Q==
X-Gm-Message-State: ANoB5pmvauL0fEvkrsQzM7JuGZLuS5ir5TYQkSLYjlu5GjtsaH/gHvfc
        /TpPGN+1pHWQhxwDZfDorfME0Lq5096uJWYajywMIsZjO+o=
X-Google-Smtp-Source: AA0mqf7b+tsQMNzSY6p2Vmv8S2COQEJ+Or/TXaZpc7WlwAyAQ7PA03tEpE4Qg0dOjSZ5BQh82GEoeKNloQBA8cuKv5A=
X-Received: by 2002:a05:6870:aa09:b0:143:8729:ee47 with SMTP id
 gv9-20020a056870aa0900b001438729ee47mr3607353oab.251.1669539676167; Sun, 27
 Nov 2022 01:01:16 -0800 (PST)
MIME-Version: 1.0
References: <20221124153934.12470-1-worldhello.net@gmail.com>
 <20221125095954.4826-5-worldhello.net@gmail.com> <xmqq4julb5nk.fsf@gitster.g>
In-Reply-To: <xmqq4julb5nk.fsf@gitster.g>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Sun, 27 Nov 2022 17:01:04 +0800
Message-ID: <CANYiYbGmZjBzRNd9W2kws9KCnxXAvVpkGNUzRJs4LtLKW+ukmQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] ci: install python on ubuntu
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 27, 2022 at 8:30 AM Junio C Hamano <gitster@pobox.com> wrote:
> > Since the "ubuntu-latest" runner image has a higher version, so its safe
> > to use "python2" or "python3" package name.
>
> Makes sense.  Just out of curiousity (read: not a suggestion to
> change anything), what happens if you say "apt install python" on a
> recent system?

In order to reproduce, I start a docker container like  this:

    $ docker run -it --rm ubuntu:22.04 /bin/bash

Fetch the latest apt source list, by running:

    $ apt-get update

Then install python with the following errors:

    $ apt-get install python
    Reading package lists... Done
    Building dependency tree... Done
    Reading state information... Done
    Package python is not available, but is referred to by another package.
This may mean that the package is missing, has been obsoleted, or
is only available from another source
However the following packages replace it:
  2to3 python2-minimal python2 dh-python python-is-python3

E: Package 'python' has no installation candidate

We can also find python package name from packages.ubuntu.com:

1. form the link below, we can say Ubuntu 18.04 is the last version
(LTS?) which has python package:

    https://packages.ubuntu.com/search?keywords=python&searchon=names&suite=all&section=all

2. Ubuntu 20.04 is the first version (LTS) which rename its python
pacakge to python2 package:

    https://packages.ubuntu.com/search?keywords=python2&searchon=names&suite=all&section=all

> Will queue.  Thanks.

Thanks.

--
Jiang Xin
