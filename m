Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE26C433E0
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 19:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7889E206A1
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 19:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="iJJ3bzF4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgF3TPG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 15:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbgF3TPF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 15:15:05 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7465AC061755
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 12:15:05 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id q7so10674918ljm.1
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 12:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DKt3kqtKLKLDyXdaY37fif/QAfo5Lp0yM1Nax2YCdnk=;
        b=iJJ3bzF4SvpxbW46PXbxic1VX7FZeDIjIU4Th9e385K3+gZMg/bQhUZmg9jp+KiiMc
         HqOrETzv/6OFhwJHlGHxCv2SPuK8mwY1Fk95pxl+tzRr/YD2ce9+p6BfH6uKiSWSzMU/
         eTp4wYRITP1NWqfAG5mJh5+lf9//7fQDnuSELngTXuVe62YA2ifmdR2PEUvTkSP51p48
         WXVTKC7oJ9S9y/2tiTtT2nASNR8/ywswQUOHku5mysIP/0bESD/CEAA1DbEYX8gHAdbz
         9ZMPTK5wmwt7N02uJEj4xvH9iiEMjep2+mlFFpQNKVy85CFX75LRyiJ9AbgXBPJqIZBC
         40CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DKt3kqtKLKLDyXdaY37fif/QAfo5Lp0yM1Nax2YCdnk=;
        b=ncF/Um7yt+d60O81ZMd+DiTbggZsU21KncbgLOb6DGsiSUTNeFWR9vfh0u1cHQg8tI
         tqp/W8Ui90Xe1zIL46jAFL2RqHu/XJKnGGRRTo/AniDaZJ+lAaGC0/KIkWjhyB/CYXU8
         q5TKoh6Nc4XIaid0QSz9ZJh6oYXnH8CLn7ZGu1ftrFlUd84T9kn/AT8ImQM/s9Nwk3+8
         kdD+9IvlAR5ySYX3sEtsFwbZnHG2hLygBAGRIJ5jchgKUXt1IzX6geEIcz7yrrCrnoaZ
         V0wrlsSnlMI5LygFW/2jkC6aKyRMIMdg7jYpJJ45AgIoPqHRLUDQ3rjC9pGEfNHgUquK
         XttA==
X-Gm-Message-State: AOAM532D5mTpgLkpiY5E6jt8GXU122ztGVZv45WPfZZrG9X2wYgUlAa2
        BPcsTzBjl6M54SdkuGrLaFcJI1SVO43nYi/8MSQkjg==
X-Google-Smtp-Source: ABdhPJyBVpjMBhEKf/SCsOD1+8oqz71ah3FweS37g7fsM3lTgliuluHvbv5qz/2fVGCVgFDNf89ZxGIY4C8Tc1/b960=
X-Received: by 2002:a05:651c:2006:: with SMTP id s6mr824485ljo.74.1593544503947;
 Tue, 30 Jun 2020 12:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqa70lfjvo.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqa70lfjvo.fsf@gitster.c.googlers.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 30 Jun 2020 16:14:52 -0300
Message-ID: <CAHd-oW6A2aBHg80R9kyifvF7thwzam5EYYoN9d2TaBcHJrcKWw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2020, #06; Mon, 29)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Junio

On Mon, Jun 29, 2020 at 10:00 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> * mt/hash-to-hex-thread-safety (2020-06-26) 2 commits
>  - hex: make hash_to_hex_algop() and friends thread-safe
>  - compat/win32/pthread: add pthread_once()
>
>  hash_to_hex() used a set of rotating static buffers, which was not
>  safe to use in a threaded environment.  This has been made safer by
>  using thread-local storage.
>
>  Will merge to 'next'.

I'll send a re-roll of this series to address some changes recently
suggested by Dscho [1].

[1]: https://lore.kernel.org/git/nycvar.QRO.7.76.6.2006291646420.56@tvgsbejvaqbjf.bet/
