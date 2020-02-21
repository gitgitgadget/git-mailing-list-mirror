Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB80C11D00
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 00:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B632071E
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 00:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="OASvfQJv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbgBUALx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 19:11:53 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40138 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729417AbgBUALx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 19:11:53 -0500
Received: by mail-lj1-f193.google.com with SMTP id n18so325802ljo.7
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 16:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zp7ce4eJTF0a5jurpyHak8b8Bwj+lBJidv61MT+z7kM=;
        b=OASvfQJv9OjggbW9te7e3LKWkyevGGSpMzpCwcXEVstCW0Bm0EC316y5O5ReYMnqao
         b3AUGU0VOPWd3FZUsi+LEWzwqeM5kz2/VXktvsxyLmMCAVX4pKDUYxWNmkflec1sJPHC
         edazrqHusdU+vUggXH2/FzFvkbJkdE6t3u0RW+6WrtDXrF/ShJWgvQGRR6+6UlBOLs0R
         wXqdHtaGy7aBoy/u0iVRYIyDMkruEF7w7J/XSjm9iKZa/10GOPZaB4TxKsk2E2JkJg6C
         W3CH8QGU5i3EXgjYfCxrzsfIwd1TaUa258/E1YyP8AmAD7I4CcLAwOq4h+akZfCInkA1
         hd5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zp7ce4eJTF0a5jurpyHak8b8Bwj+lBJidv61MT+z7kM=;
        b=UhTQVhdaOXlQ270B2QZlRzjI+gIKPgUajV6wuA8ubanfEkW/llgzjX9axCWMhKdsPA
         9wAeV1SZ8eVI6ExIj7Xle/CTDB6F9bPkFyfnNgPhwkwQgp6gxTCjWmkr4b6vR1bThYhA
         EPXBgL65PA8h6/ylJvS3jDYNRN4YMvHiduaJ8EF+x794RwJ+vCeIgmLeL5w+MtB7OBPv
         tsjCdhObHghk2vZokZyH++hplzoG/VBfkyOaW/yVxH2DKrvaJE24nvhVdjUGZE8ZmMhb
         gzK8XZxLpYbIRxqlywXFEftJxLokfkk8TzpgbGx236CYL0hONl8aYnGmKCPaXfOSl5UT
         iNgQ==
X-Gm-Message-State: APjAAAUDb2NNN70m8sar549er/TE5FL3cgyCRVBb6F3472dj6THIFnqL
        NX9J1R4Pdbk0R/oP5eO7nyxBUMZ+WF+/USij1YzAlVmSg34=
X-Google-Smtp-Source: APXvYqzPVerzIVtsegH4G8EAgDNo5bWrOwMQYT1s6a5+5dkGUTYfh5uMrSmaUkxu0USoxVCighlGSgiuWEAeBNMsgfk=
X-Received: by 2002:a2e:880c:: with SMTP id x12mr20722836ljh.44.1582243910708;
 Thu, 20 Feb 2020 16:11:50 -0800 (PST)
MIME-Version: 1.0
References: <20200220214647.451064-1-kolyshkin@gmail.com> <CAHd-oW61vuuvs25iOkLJ--Wv39ZXFF87_-pV=vX=oTibRinn5Q@mail.gmail.com>
In-Reply-To: <CAHd-oW61vuuvs25iOkLJ--Wv39ZXFF87_-pV=vX=oTibRinn5Q@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Thu, 20 Feb 2020 21:11:39 -0300
Message-ID: <CAHd-oW6ytdEfmyCDtuPZ1uMc57jovnc334jMpombx-90POynkw@mail.gmail.com>
Subject: Re: [PATCH] completion: add diff --color-moved[-ws]
To:     Kir Kolyshkin <kolyshkin@gmail.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 20, 2020 at 8:30 PM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
[...]
> (and there might even be a bug in bash-completion involving this [1]).

Oops, nevermind. I misread the issue, it's a problem with some of
bash-completion's pre-shipped completion functions, not regarding the
"complete" builtin. Sorry for the noise.
