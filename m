Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671ACECAAD8
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 18:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiIVSgZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 14:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiIVSgX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 14:36:23 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A579A5C70
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 11:36:22 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id n10so16865351wrw.12
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 11:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=4Glx4LxX9Hn1QNiu9sQCqptrLaR9z9Q48EIVp5D1YGs=;
        b=AQU/4kSagASBe+DRQXdHwcggkHowAr25sqaI19E/YmOei4u3ZMi7dQATYeyOfnvAbX
         6eWZSRJhTh4r+pNJ8u2UzPWxIf+Lha3HnU71BZeKwwowZW7u3Af2mFCyBRuXjQGWFKeJ
         gwSi1dEpKRJ+HuWksGr7x8uNoR8CN55hhmXvjkoqIiS9WimJXFACNKXbvCKfe7+57ZzS
         kpmp4O08PR5/Q/Mlx73AsnyC7SbDRxHmP4IkhiXEOmPv3+CtSe3vmFrBxr+/Ai8wYTjS
         x6DkFMmGOyKjZlazVct1kIIXdI6pyKXA9Qlujq7XMlMpMChmq3HQz6ZGZ1wX2TMzzkxy
         03FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=4Glx4LxX9Hn1QNiu9sQCqptrLaR9z9Q48EIVp5D1YGs=;
        b=2BZzzW5shlXipkK8fV3e8MMaZT60ocryGtGE+qyiv43UlPvLHjEhkt5wYBq1MA4vW5
         1hnPHYoW6NlUt9Evkd1xHbD/PhU0bI2dbDvry3CHyuXMQOcB+jcYCmEUkICJn1IgezX3
         CImIxKwG7MekLcjkZ+P2Ro3XcXlL7uv+K0dls3/woG1MsRzOpcaMmm6/RFXa1f9WR2ri
         LdVHnNfdlBV8P6zKaoczanIoUxx5aixKyZvltY4DnEThik0F/qvpWX9xK+AgoUwexqfH
         39TrVo/K6iXjNg299FINu2DPpNEFUWQl7mU6dvT1an781Io3c5Cuwt6t1ISWS3cz3FCH
         teSw==
X-Gm-Message-State: ACrzQf0AfdcwcFx7Rjv4oyUUSxL5WUgy5sJedUkR6Tg9Yrrhfl+QR9sJ
        R1zaIKhYHfmfzbuGSQhA9p09ppiDYI7qh7WC78z5qvrtJJk=
X-Google-Smtp-Source: AMsMyM4r+NM/3Yetgw9LpMVsPWTohwxc6ir5dHeJE5C+oS9BGFPrHs2nOOC3dugnm0N3MIlxoXDLyJg9nyKQW3vC39s=
X-Received: by 2002:a05:6000:1004:b0:22a:f5a7:747c with SMTP id
 a4-20020a056000100400b0022af5a7747cmr3119470wrx.612.1663871780976; Thu, 22
 Sep 2022 11:36:20 -0700 (PDT)
MIME-Version: 1.0
From:   Lana Deere <lana.deere@gmail.com>
Date:   Thu, 22 Sep 2022 14:35:45 -0400
Message-ID: <CA+4x=b-myNFKfN1n1jrU+wMYfXbA7VrnrKVi7vj9LU4E9wb_rw@mail.gmail.com>
Subject: 2.38.0 rc1 and explicit openssl version
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I built 2.38.0 rc1 from the tar file today.  One of the configure
options I used was "--with-openssl=<path>/openssl/3.0.5".  As
expected, configure reported
    configure: Setting OPENSSLDIR to<path>/openssl/3.0.5

When it got as far as linking git-imap-send, the link command pointed
at the subdirectory "lib" within the openssl/3.0.5 installation.
    gcc ... -o git-imap-send ...  -L<path>/openssl/3.0.5/lib ...

However, this version of openssl put the libraries into a "lib64"
subdirerctory rather than into a "lib" subdirectory so the link
failed.  An easy workaround is to put a symlink from lib64 to lib
inside the openssl directory.  It would be nice, though, if the
configure command could figure this out automatically.

.. Lana (lana.deere@gmail.com)
