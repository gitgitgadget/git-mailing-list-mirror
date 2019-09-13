Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E0961F463
	for <e@80x24.org>; Fri, 13 Sep 2019 08:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387451AbfIMIRG (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 04:17:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43161 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725446AbfIMIRG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 04:17:06 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Sep 2019 04:17:05 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digitalasset.com;
        s=mimecast20170911; t=1568362624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8FD922U9oi/hAKCLpVx6yyuVmZthkKESZHM+EHYAvzg=;
        b=gAIXM+Q3ZLu4yZZQE1akjfLTK3PAAEYo6XSkeG21UZSIrj3HlLoOzscZI3ubhqjoGZ8kAu
        CkgzKe3SlI1QSIK+OUwJ/IU9BMxeZiKxD9vpwmQhd+x6AWnFjt6fG/e6urj0szTMy4cJE4
        pXKp4TAqSksJ4U9T07/Ncyz6+5BFQ+4=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-AS2HgE7uP3WmDkEKTonc4Q-1; Fri, 13 Sep 2019 04:10:23 -0400
Received: by mail-io1-f69.google.com with SMTP id j1so37097758ioj.6
        for <git@vger.kernel.org>; Fri, 13 Sep 2019 01:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=8FD922U9oi/hAKCLpVx6yyuVmZthkKESZHM+EHYAvzg=;
        b=ip2RqarxkBNCW+rMfpJfnaLe3JKAVD8RRi6MyJxjmez6SUbB2rzg0S2EkkXgSZy/wn
         qPtmR7BKAI0R2aXTFYKJTCmc6Rp3bpT38k2b6KlaU+2yGhEhnkH0Fl7ZzqFLsI0DVRe2
         P95rLLz5gBgQl3HZ9il46uLoEUPl2PkTXMtd3wknXrd4XRwB6ExX4QxXI8Ws+WPw4SpH
         NmTbLad2QZtaLwVDItpdzc0FR6JQHfNhoRCsERL5Fa3hvz2vOpIPPz6Umzb/6tGeY4Qj
         mJFYAtYqa35Hs16hO5NLaqCgUqO1V2l10O+JCEaxAyYCkLphtEI4fr6Arc+SkqQdPzyl
         FxXQ==
X-Gm-Message-State: APjAAAUw0OwN2SL8c9HyPEyn5cXJz71setD17teFyHKgX2y4DbYgNGtA
        C7UAHfyl+JKs/sSFM9rSbbITsjgUPLfjqH6NyNUoTxZlt/LHmTF2cTbUM0gnr+gkhYfs2bkmxre
        /IFN2n5LoQvSVBa2/1stfOhTzjG9w
X-Received: by 2002:a02:3785:: with SMTP id r127mr24397968jar.40.1568362223102;
        Fri, 13 Sep 2019 01:10:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxe6zRUmT/ML0C3eVCNSU4wB9jZVoHoCcvD9YPKV45G5TS7T36UT7LChz5zFaFu1OI5SkWb5+aV7kit9SK00/o=
X-Received: by 2002:a02:3785:: with SMTP id r127mr24397954jar.40.1568362222836;
 Fri, 13 Sep 2019 01:10:22 -0700 (PDT)
MIME-Version: 1.0
From:   Luciano Joublanc <luciano.joublanc@digitalasset.com>
Date:   Fri, 13 Sep 2019 10:10:07 +0200
Message-ID: <CAPYWsc08bROfbSHuiuFMrHK99NgqZ=euOkRh-KQHrEWC3w3NnQ@mail.gmail.com>
Subject: bug: report `rebase -i + subtree add --prefix = disaster`
To:     git@vger.kernel.org
X-MC-Unique: AS2HgE7uP3WmDkEKTonc4Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I would like to report what I suspect is a bug in `git rebase -i`.

The problem in question is that when a `rebase -i` is run on a repo
which has had a subtree added with `git subtree add --prefix=3Dxxx`
previously; the later command will be executed without the `--prefix`
argument, resulting in the `subtree` command being replayed to the
_root_ of the repo.

To illustrate this example, this is what happened to me.

1. I ran `git subtree add --prefix=3Dui ../ui/ui.git master` on my repo
to merge a sub-project into the `ui` subdirectory.
2. Sometime later, I had to re-write history to remove a large binary.
I did this using
  a) `git rebase -i` and
  b) removing the file with `git rm bigfile.bin` and then `git commit --ame=
nd`.
  c) completed the rebase with `git rebase --continue`.
3. The resulting repository had all the files of the subproject 'ui',
but in the root directory. e.g. previously I had folder `./ui/python`,
now I have `./python`.

Please let me know if I can produce any more information.

Regards,

Luciano

--=20
Luciano Joublanc
DAML Commando Team
c: +41 765 3223 82
e: luciano.joublanc@digitalasset.com
Digital Asset (Switzerland) GmbH
Thurgauerstrasse 40
8050 Zurich, Switzerland
digitalasset.com

--=20
This message, and any attachments, is for the intended recipient(s) only,=
=20
may contain information that is privileged, confidential and/or proprietary=
=20
and subject to important terms and conditions available at=C2=A0
http://www.digitalasset.com/emaildisclaimer.html=20
<http://www.digitalasset.com/emaildisclaimer.html>. If you are not the=20
intended recipient, please delete this message.

