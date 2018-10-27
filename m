Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB52B1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 07:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbeJ0QG4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 12:06:56 -0400
Received: from mail-it1-f175.google.com ([209.85.166.175]:40206 "EHLO
        mail-it1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbeJ0QG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 12:06:56 -0400
Received: by mail-it1-f175.google.com with SMTP id i191-v6so4309948iti.5
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 00:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ATCu3Eq9Ojh5b/IRx9qU+0BPsKLxF51nvoOrr8ae6Xw=;
        b=mVFqrB/JyUDBKvVzQT1Wea3MnAshUdlYO8wLXBpLz7f8EOS5AGAnTeSbODeYpZp2zX
         xvIKXqkHVfoXags7aEfvfQbn7Na+0EwQdW+f39LwPTYcXL049iZi8KYB2BJ1HbBeZLSG
         cqkeqGBpjTbqsTnQgQf4zxcfaBu9ZxhaqlUwPfeu6bQrYNh3BPLd4+deo/xbQB+uUbC6
         ySWCyW6qMvoBqMW0hgxIfvJ3uyDFaDll/yBo2RYyDQo/SxVTUGSrREjF81dwQ8rUcuDl
         kzJFCYBY7h/Oc9t5H6/LcuucHLoB/xjbEdyJg3fbdFPk0WK5wGkf8yCw9LQ+h7obyX3h
         izsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ATCu3Eq9Ojh5b/IRx9qU+0BPsKLxF51nvoOrr8ae6Xw=;
        b=e4YDghmyZCT4b8rLCPkmWvudXNRMnxcIBtO2+Pd3Y6k5tpGtw1ba0T1NKhqXnSCJv0
         h70aHl+CubalpTSUIDyVSm/xBjcrsnC1Rl+Y21J4mivnpN9xT45J+v7lMGUy0dkVGLzS
         ZoMahyFZQrBbW6DGfN1ZOUfj2UBf8E7qzTdD0i3JekdkJaKEv8uhoD5T0AmEuMfzvysL
         uSAhpzfFSZi9ijdqY8mC95/PSZLCycoTQwvJRLswv39eS0qXUgIL0+Al6qQdCh7Z5nbW
         +DO2JtXBwzOeb38kJqaGQ7yH1zbJVW7fTi+t9Jnds35qak5h28sXlBHZa8Kx6RTqplPr
         fCAw==
X-Gm-Message-State: AGRZ1gKXz2vyO8mTF7/EjK92HiKCU9bryVoPnInM++sOuFLhUDOme+TE
        rtrNeOQ1ORoKKjZ4YXwIuqVgUZAQswzw8OsKNHE=
X-Google-Smtp-Source: AJdET5fw6GMVRTmIfzoE9VU9HfI+5c4sqBsR8F4Vb4sD3uIhIxAE03YNde/gQITMJRJrjUAi5gDXT5ZiRbwJOgUExbg=
X-Received: by 2002:a02:958a:: with SMTP id b10-v6mr4794517jai.130.1540625214002;
 Sat, 27 Oct 2018 00:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <20181018170934.GA21138@sigill.intra.peff.net> <20181018180522.17642-1-pclouds@gmail.com>
 <20181023202842.GA17371@sigill.intra.peff.net> <852ad281-09df-c980-790c-df25e82b3331@gmail.com>
In-Reply-To: <852ad281-09df-c980-790c-df25e82b3331@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 27 Oct 2018 09:26:28 +0200
Message-ID: <CACsJy8D8a-0R=J6nCPwBAypYF=rejgT-3QFnuK1h3vMcJGG7_A@mail.gmail.com>
Subject: Re: [PATCH/RFC] thread-utils: better wrapper to avoid #ifdef NO_PTHREADS
To:     Ben Peart <peartben@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 26, 2018 at 4:09 PM Ben Peart <peartben@gmail.com> wrote:
> I agree though I'm still curious if there are still no-threaded
> platforms taking new versions of git.  Perhaps we should do the
> depreciation warning you suggested elsewhere and see how much push back
> we get.  It's unlikely we'd get lucky and be able to stop supporting
> them completely but it's worth asking!

NO_PTHREADS can also be used even though the platform supports
multithread: to make keep git execution in a single core/thread. It
might matter on hosted systems with limited cpu power and you don't
want git to hog it all. Yes it can also be achieved by setting a
zillion config keys to "1", this way is just simpler.
-- 
Duy
