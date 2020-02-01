Return-Path: <SRS0=aK8K=3V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A67FC33C9E
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 11:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50721206E3
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 11:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKUIouoU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgBALjg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Feb 2020 06:39:36 -0500
Received: from mail-il1-f175.google.com ([209.85.166.175]:35326 "EHLO
        mail-il1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgBALjg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Feb 2020 06:39:36 -0500
Received: by mail-il1-f175.google.com with SMTP id g12so8604929ild.2
        for <git@vger.kernel.org>; Sat, 01 Feb 2020 03:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=5wLiyd5Wz7xN4mHdYs+Ol7+IpohG0DvhKDSoiY3WMNU=;
        b=XKUIouoULUMIBzZzohd0XiXThmgOEp6RS6Ej2RE42eZxO+bU9a+g/Z0xbxVquPC8ag
         z83lrzaS7sf38x9N1X7E0ej7F7LLe0d33ZGVDRvgTM9Bujx6kkcBV1sPkKjapLGU3tC5
         ebm82wjubUFAPnQ5foVTuPgnBsokZf5kD639IFq+ciWD66ZNbvUdXtivvpzdhDd1IMih
         XqHJLDMMrIGYldZGqGgTZU09ESgIvpYZYzu1LsK1Skfn9x/lk0QKUjuUSHacYf325eRt
         JPObEStxxBCxMSH5cfOLl1YORd3NBI5aOjXCYtG2P5ZCtQcrP7wMMlNiFm2D5+Md9xhP
         v6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=5wLiyd5Wz7xN4mHdYs+Ol7+IpohG0DvhKDSoiY3WMNU=;
        b=QiuAvSuHreyivfnOwtvg64/x9CuvJUWLK5XzurAmK9gDw8QI6taYruolVeyiz8sJ+B
         e4Y2ruO/h2Yf10vWRXyWccAr/X0gm/CIcRglO9kIpH0VMWNzlyI6Wbz2mOdjXx2Zxf2o
         843Dss8JMIhBdqhQDkBot71SGQSViXyKOjnsc/U2pJlpQLC7bfMAtn+ldgSHf0nlCojz
         a1CsxS6rN4KjbRZIw0QVrkvMWNFAr8M/qBf+wseCUM4qTocLc6kecvOjfLwg8HFVw3th
         999T23H9Q7XJl4u/PSj8oSt7h7knvJBZ2rB49r4K9/v1e3qpqcnGMc84wkLh7iZodKrf
         8Unw==
X-Gm-Message-State: APjAAAU18uGi4zq2XKfmc0gXTPGDWvV9erSFi5TGkexHshALDe2xfZRC
        EKSb0xI4BLNQyhW3gCc+WXDANZbNNQafzIltuYT4Xfuw
X-Google-Smtp-Source: APXvYqxBOGWxezxtqErr1PjtUCGc3GHI6QsNbnG7pmThv72mtbW+7OfVMHsEKctzhamLZpI6Wn2bW/vJDmttld4mikc=
X-Received: by 2002:a92:9857:: with SMTP id l84mr6949713ili.41.1580557175325;
 Sat, 01 Feb 2020 03:39:35 -0800 (PST)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Sat, 1 Feb 2020 06:39:24 -0500
Message-ID: <CAH8yC8m3JFvEcfFF3z1rrRnEPK-adHGObmkOhNZiph7QJKUWqA@mail.gmail.com>
Subject: =?UTF-8?B?Z2l0LWNvbXBhdC11dGlsLmg6Nzk4OjEzOiBlcnJvcjogY29uZmxpY3RpbmcgdHlwZXMgZg==?=
        =?UTF-8?B?b3Ig4oCYaW5ldF9udG9w4oCZ?=
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

I'm building the 2.25 release tarball on Solaris 11.3 i86pc. I'm
catching an error:

$ gmake
    CC fuzz-commit-graph.o
In file included from commit-graph.h:4:0,
                 from fuzz-commit-graph.c:1:
git-compat-util.h:798:13: error: conflicting types for =E2=80=98inet_ntop=
=E2=80=99
 const char *inet_ntop(int af, const void *src, char *dst, size_t size);
             ^
In file included from git-compat-util.h:226:0,
                 from commit-graph.h:4,
                 from fuzz-commit-graph.c:1:
/usr/include/arpa/inet.h:43:20: note: previous declaration of
=E2=80=98inet_ntop=E2=80=99 was here
 extern const char *inet_ntop(int, const void *_RESTRICT_KYWD,
                    ^
gmake: *** [fuzz-commit-graph.o] Error 1

And:

$ cat -n /usr/include/arpa/inet.h
...
    41  #if !defined(_XPG4_2) || defined(_XPG6) || defined(__EXTENSIONS__)
    42  extern int inet_pton(int, const char *_RESTRICT_KYWD, void
*_RESTRICT_KYWD);
    43  extern const char *inet_ntop(int, const void *_RESTRICT_KYWD,
    44                          char *_RESTRICT_KYWD, socklen_t);
    45  #endif /* !defined(_XPG4_2) || defined(_XPG6) ||
defined(__EXTENSIONS__) */

Jeff
