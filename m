Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57C8C433E0
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 01:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3FD421744
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 01:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rit.edu header.i=@rit.edu header.b="XHt4DnAA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgHGBNE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 21:13:04 -0400
Received: from mx03b-out01ag.rit.edu ([129.21.3.135]:8365 "EHLO
        mx03b-out01ag.rit.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgHGBNE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 21:13:04 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Aug 2020 21:13:03 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=rit.edu; i=@rit.edu; q=dns/txt; s=rit1608;
  t=1596762782; x=1628298782;
  h=from:to:subject:date:message-id:reply-to:mime-version:
   content-transfer-encoding;
  bh=gQ1DPaynmgM/1xIyuFEb5mFXm7SFPT6jrw+JtKt2XU8=;
  b=XHt4DnAAxh2sFUTGXr6MM6vLZIBh6idb4kEYJYEnNNkTySvIy6r/vJNO
   yUurTvVIiRCG3FqDgd/AvvHgbgMUU5dd4MFuDoHeivu8SOZKYvc2gCzCZ
   49+hgnagN0xud4zYTMXa1O6bJjX1X3UWTMRap6Z1U3XkjjVb1vtUHRM3Q
   0=;
IronPort-SDR: 9VzvBqsRxB5zv5jOfwU6u5QTwXiGHrW9sUce8x2jBlkYy/ASLSMXvmEeJyAg6ZcnflRshM+KMX
 dXTPxIUVCA6aMwTFFE5oOZtoS+nyFwosHuHCBiGOEZT5CRPmYcqXuExTVHNUw7YsrGRC61W4jB
 S7eaLprvJkV4mHbwRwrkk32LH55xhSLt/UTyXjInMQ/dEbLjqHPJWXXRfFVM9L3SF3RxDC4I9f
 /9Fy6RsIBzdMq5WZm9YGedYaCLkoZujbucubGdyiplMBxb3S5glcX2ICAoMXjQR01ghrXPXh+5
 W+g=
X-RIT-GSuite: Yes
X-IronPort-AV: E=Sophos;i="5.75,443,1589256000"; 
   d="scan'208";a="254671054"
Received: from mail-qv1-f72.google.com ([209.85.219.72])
  by smtp-server.rit.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Aug 2020 21:05:54 -0400
Received: by mail-qv1-f72.google.com with SMTP id q12so312259qvm.19
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 18:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:reply-to
         :user-agent:mime-version:content-transfer-encoding;
        bh=V8SAfV61y4xm0iKlLwpknvq4zo4CTJ6VW+EzoVt7L3E=;
        b=gjc2JUxRaggPn8kP5Abn7tJb+5CFry8BRGnhmI5eCSEp7FFyipEi5V1hYchpSlPgMf
         Dn5vqtRHe09kzz7kk2zDHCdhrMChB/kgr41DDwPdk6O2cK7mlGpv83Q8d2f7mHhwO+sI
         OWOkU0UCb27r3+1iWmiGid2IOMd7BWeGLP2oq9i/X9pcMNsvN9TaBHSVpYp/mIHV/URN
         CISRRSdVTry9i9RJ/f1nZO3wC6WBKCtXk82+0H5NnDKQxsFgY3s2LJbII5lBD0zO3I6H
         dVlXUTuGoKp6nK0QBDITR4hPY62T8Cy/NY3mqh63eOp6X8Mt/AX0wUeqtRGv5Lddlq/a
         v1pQ==
X-Gm-Message-State: AOAM531Ha4FLPGfblzegSQKyMA88zT/hJVOA21yPgWjrlVTTNMCaVtTW
        UVmNqpWjzsQE+zdVsSI3D8OfkquBODCHR7PSQlobqlEYLE/zJv2gYjoidR1AeuOhzJNj5T3NJlo
        TWmTuCg8ZAAzCcRrzR9dnpZU=
X-Received: by 2002:ac8:72cb:: with SMTP id o11mr12246347qtp.13.1596762354639;
        Thu, 06 Aug 2020 18:05:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxigsgvfuaHw/tAy+96HmQ43ANIzFA4ZKOI0UR7gcD2KsLbwPYbKYohO8Ja29EAW4fqt5q2Iw==
X-Received: by 2002:ac8:72cb:: with SMTP id o11mr12246318qtp.13.1596762354246;
        Thu, 06 Aug 2020 18:05:54 -0700 (PDT)
Received: from [192.168.0.7] (cpe-67-242-160-230.rochester.res.rr.com. [67.242.160.230])
        by smtp.gmail.com with ESMTPSA id x23sm1611180qkj.4.2020.08.06.18.05.53
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Aug 2020 18:05:53 -0700 (PDT)
From:   "Nuthan Munaiah" <nm6061@rit.edu>
To:     git@vger.kernel.org
Subject: `git blame` Line Number Off-by-one
Date:   Fri, 07 Aug 2020 01:05:51 +0000
Message-Id: <emc6590292-832a-4a35-8815-d5707731d605@sanctum>
Reply-To: "Nuthan Munaiah" <nm6061@rit.edu>
User-Agent: eM_Client/7.2.37929.0
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)

  * Clone https://github.com/apache/tomcat
  * Run `git blame --root -leftw -L 21,21 -L 23,23=20
51844327d8613448bb0bf9667e1a61e462e2043c^ --=20
modules/jdbc-pool/java/org/apache/tomcat/jdbc/pool/PoolProperties.java`

What did you expect to happen? (Expected behavior)

`git blame` shows the last commit that modified lines 21 and 23 of=20
`modules/jdbc-pool/java/org/apache/tomcat/jdbc/pool/PoolProperties.java`=20
starting at the parent of `51844327d8613448bb0bf9667e1a61e462e2043c`.

```
$ git blame --root -leftw -L 21,21 -L 23,23 =20
51844327d8613448bb0bf9667e1a61e462e2043c^ --=20
modules/jdbc-pool/java/org/apache/tomcat/jdbc/pool/PoolProperties.java
c65a429f06f4e4a025a306e377211863d9ff2a0c=20
modules/jdbc-pool/java/org/apache/tomcat/jdbc/pool/PoolProperties.java=20
(<fhanik@apache.org> 1226896977 +0000 21) import java.util.ArrayList;
c65a429f06f4e4a025a306e377211863d9ff2a0c=20
modules/jdbc-pool/java/org/apache/tomcat/jdbc/pool/PoolProperties.java=20
(<fhanik@apache.org> 1226896977 +0000 23) import java.util.List;
```

What happened instead? (Actual behavior)

Line 23 is not shown in the `git blame` output. Instead, line 22 is=20
shown.

```
$ git blame --root -leftw -L 21,21 -L 23,23 =20
51844327d8613448bb0bf9667e1a61e462e2043c^ --=20
modules/jdbc-pool/java/org/apache/tomcat/jdbc/pool/PoolProperties.java
c65a429f06f4e4a025a306e377211863d9ff2a0c=20
modules/jdbc-pool/java/org/apache/tomcat/jdbc/pool/PoolProperties.java=20
(<fhanik@apache.org> 1226896977 +0000 21) import java.util.ArrayList;
c65a429f06f4e4a025a306e377211863d9ff2a0c=20
modules/jdbc-pool/java/org/apache/tomcat/jdbc/pool/PoolProperties.java=20
(<fhanik@apache.org> 1226896977 +0000 22) import java.util.HashMap;
```

What's different between what you expected and what actually happened?

Line 23 is not shown in the `git blame` output. Instead line 22 is=20
shown.

Anything else you want to add:

  * The issue is reproducible on git versions 2.28.0 (on Ubuntu 18.04.4=20
LTS), 2.24.0 (on Ubuntu 18.04.3 LTS), 2.17.0 (on Ubuntu 18.04.4 LTS),=20
and 2.27.0.windows.1 (on Microsoft Windows 10 Enterprise 10.0.19041=20
Build 19041).
  * The addition of `--porcelain` does not resolve the issue.
  * The issue is not specific to a particular repository. For instance,=20
the output from `git blame -L 1466,1466 -L 1468,1468 =20
35e69fc7cf9421ab04ffc9d52cb36d07fa12984a^ -- c/dec/decode.c` in a clone=20
of https://github.com/google/brotli shows last commit that modified=20
lines 1466 and 1467 (instead 1468).
  * The issue seems to present itself only when there is exactly one line=
=20
in between two specifications of `-L`. For instance, `-L 20,20 -L 23,23`=20
correctly blames lines 20 and 23, `-L 20,20 -L 21,21 -L 22,22 -L 23,23`=20
correctly blames lines 20, 21, 22, and 23, `-L 23,23` correctly blames=20
line 23, but `-L 21,21 -L 23,23` blames lines 21 and 22 (instead of 23).

[System Info]
git version:
git version 2.28.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 4.15.0-88-generic #88-Ubuntu SMP Tue Feb 11 20:11:34 UTC=20
2020 x86_64
compiler info: gnuc: 7.5
libc info: glibc: 2.27
$SHELL (typically, interactive shell): <unset>

[Enabled Hooks]

