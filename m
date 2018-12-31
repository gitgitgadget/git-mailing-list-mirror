Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A74E01F770
	for <e@80x24.org>; Mon, 31 Dec 2018 20:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbeLaU5m (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Dec 2018 15:57:42 -0500
Received: from mail-io1-f53.google.com ([209.85.166.53]:39672 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbeLaU5m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Dec 2018 15:57:42 -0500
Received: by mail-io1-f53.google.com with SMTP id k7so21913819iob.6
        for <git@vger.kernel.org>; Mon, 31 Dec 2018 12:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Rk4gJUcylS08BoMewM1IRyIFw+H2FXRjopnsmw089Co=;
        b=DgIX6IurgoN8dzdVQXPULOdlRyAPTIH4fbC8YZKILaqDJEAhsDGiYDYSZOOAOfmyjT
         pL+h3QFBjTyk3Z4PHdN3I96sDMlLscFlMsm27r93aSFqBTZnQoBFwGi6gVrSOEvhOMg3
         M7984j/gWO9DcjiTGn05uGOuVKCvXsU0T4D6MozxCHGgZ3lxQ0sC784p1Y1s71BXOju1
         qVaXN3Sj967gnvf+I10TCA7wG+vUxBiS2cWHWewBGsKkWxcqArIX98hYd+OrteNGj1z1
         oC5VneohpMQzDsX4NGz06zXeJa/5yBhU5YpVCkqUmaPgcYeedtgTIvdGMHn9QW/MFukZ
         PC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Rk4gJUcylS08BoMewM1IRyIFw+H2FXRjopnsmw089Co=;
        b=U48K5EJwPkdyjTWf4DxtI0Q4l3G61BeJqMwhaQC8mwLbl6mPrmfUQ425lv9EB6s2eR
         wrTzJmV+veg4lp30zF8dAYHQfhkHB2MCoXHjLMGYFzINSY6KiADERdHuAKhmGlCPPFnB
         GTH+Lv8rL5ZOqiyioBd61bq6MP0iPCoBNR1TapeEc47hA8rSXbbUkCE+0fF6CflbtByY
         9hyKd/kq7bOyv28nwdRVk1L4q6LC7bRmAZCJVp2Pw6PR2QeKdFMkNL0CmuDs+hEWuINI
         GDyxVyTun6SCZhSBwEaATLZoR2U5LDlTCuQQNPxNPK1B0xGe5HTk2T5OOXFx8w9T51x7
         4kUw==
X-Gm-Message-State: AJcUukcb1B/aDKA0ggu2GqysXHe0KD0sqfNJSdgnZow48mWupDsualAl
        mEW+180EtjOjCGTsaTyHJxnjFKypcmzIXQl1NQ4ir4X4
X-Google-Smtp-Source: ALg8bN7qHW+D4kw+6np/NTOhp+gIyR8Tp4L90/ZNJ/BVkQptaD9uUgOGvr6nfz3PrVZg/8pb0hKYPros7C4s5zXo85M=
X-Received: by 2002:a5d:94c7:: with SMTP id y7mr5700231ior.285.1546289860739;
 Mon, 31 Dec 2018 12:57:40 -0800 (PST)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Mon, 31 Dec 2018 15:57:10 -0500
Message-ID: <CAH8yC8n1BB4ZBqd7VcLXdRzovbOxCRrmztsCBK8ENAexbxSyBA@mail.gmail.com>
Subject: Unusual library path on OS X
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

I'm building Git 1.20.1 from sources on OS X. Git (and its dependents)
were configured with:

  PKGCONFPATH: /usr/local/lib/pkgconfig
       CPPFLAGS: -I/usr/local/include -DNDEBUG
         CFLAGS: -g2 -O2 -march=native -fPIC
       CXXFLAGS: -g2 -O2 -march=native -fPIC
        LDFLAGS: -L/usr/local/lib -Wl,-rpath,/usr/local/lib
         LDLIBS: -ldl -lpthread

For Git it results in a configure called with:

    PERL="$SH_PERL" \
    PKG_CONFIG_PATH="${BUILD_PKGCONFIG[*]}" \
    CPPFLAGS="${BUILD_CPPFLAGS[*]}" \
    CFLAGS="${BUILD_CFLAGS[*]}" \
    CXXFLAGS="${BUILD_CXXFLAGS[*]}" \
    LDFLAGS="${BUILD_LDFLAGS[*]}" \
    LIBS="-lssl -lcrypto -lz ${BUILD_LIBS[*]}" \
./configure --prefix="$BUILD_PREFIX" --with-lib="$BUILD_LIBDIR" \
    ...

BUILD_PREFIX is /usr/local, and BUILD_LIBDIR=/usr/local/lib.

Linking produces the following, which seems a bit unusual. It looks
like PREFIX and LIBDIR are being concatenated:

    LINK t/helper/test-fake-ssh
    LINK t/helper/test-line-buffer
    LINK t/helper/test-svn-fe
ld: warning: directory not found for option '-L/usr/local//usr/local/lib'
ld: warning: directory not found for option '-L/usr/local//usr/local/lib'
ld: warning: directory not found for option '-L/usr/local//usr/local/lib'
ld: warning: directory not found for option '-L/usr/local//usr/local/lib'

When I try to use --with-libdir=/usr/local/lib, I get:

    configure: WARNING: unrecognized options: --with-libdir

Jeff
