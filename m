Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1D0C54FD0
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 22:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1081B20736
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 22:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=narod.ru header.i=@narod.ru header.b="Y8meLd6I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgDWWtp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 18:49:45 -0400
Received: from forward103j.mail.yandex.net ([5.45.198.246]:42724 "EHLO
        forward103j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726057AbgDWWtp (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 23 Apr 2020 18:49:45 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Apr 2020 18:49:43 EDT
Received: from forward102q.mail.yandex.net (forward102q.mail.yandex.net [IPv6:2a02:6b8:c0e:1ba:0:640:516:4e7d])
        by forward103j.mail.yandex.net (Yandex) with ESMTP id 973416740695
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 01:42:27 +0300 (MSK)
Received: from mxback12q.mail.yandex.net (mxback12q.mail.yandex.net [IPv6:2a02:6b8:c0e:1b3:0:640:3818:d096])
        by forward102q.mail.yandex.net (Yandex) with ESMTP id 939EB7F20013
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 01:42:27 +0300 (MSK)
Received: from vla5-e763f15c6769.qloud-c.yandex.net (vla5-e763f15c6769.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:e763:f15c])
        by mxback12q.mail.yandex.net (mxback/Yandex) with ESMTP id m0SHhZzQvP-gReGfglS;
        Fri, 24 Apr 2020 01:42:27 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narod.ru; s=mail; t=1587681747;
        bh=3o5DqZuBmroMX2yTB/z9BOCn8mKTYR8G7KIPNHL6hCE=;
        h=Subject:From:To:Date:Message-ID;
        b=Y8meLd6INDQKbBVihkpWkkDceDrYDuLoNV46zPzEtJwDM1/U/H520oW5tZZNrg/8t
         gzLPrXVGWdpFSJx7xPiQWpRWbxNWs2m3oPb2JOyPzZUrsNps5TwyifYY1QtCMacCYu
         YeSeswDf2O7fQhKYYthxiJZuzX9A+95zr+F/NOxI=
Authentication-Results: mxback12q.mail.yandex.net; dkim=pass header.i=@narod.ru
Received: by vla5-e763f15c6769.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id lQazpkp8Lm-gQXiJhog;
        Fri, 24 Apr 2020 01:42:26 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
To:     git@vger.kernel.org
From:   Victor Porton <porton@narod.ru>
Subject: [Bug] Misleading error message when run in a non-Git directory
Autocrypt: addr=porton@narod.ru; keydata=
 mQENBFNuyHwBCAC/mCl4R1GQ15hzH3ocG0jUDp8OU5eKPrEzBkNscSv6GnNAZ+JyoblUnmTt
 HVkigeWnCwpwuRr9qqWZPffS7r3iQrD1RgcWw3uNBA7Eo1NBscKXDH+Nk5gaVwyvVlmZcCry
 /RL/Z+8HxW7sguyrOPPsR5JRe9vVA8hA5lRRPtj/dy1oDq530XjQeyWfkL9TLXa+ji7cPRD/
 K/z3NDEZBOETLnq7itAHPFul44vadBcElfJ1bCpXffOKDw7pRIZxanMMMpDTPUWigME/B/gt
 7bkSgFiGvrHLHAeOnIwE6KvVkcohHvkOdZFUwsgjlEJJDVYrVrSmB9qi4KF17+RUeoa1ABEB
 AAG0H1ZpY3RvciBQb3J0b24gPHBvcnRvbkBuYXJvZC5ydT6JATgEEwECACIFAlNuyHwCGwMG
 CwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEAk/AOWfbyPVcjcH/ilVVaOxDIPEdUX6HgQH
 r9CnZweOC7zo4F8hh6ursgnNSZf7rIXEqcECMlqRTvfJfwbWz+jyk8+EP5lHPs5D+uinvVbT
 sglDkTjENPnLhqbxcWgg9FvDB3Dvd0G37oJnFH6QKtKwg66RPiQinm0bzBumsMaPlI4EwUsG
 BuB63CZs5njoDrQEI1pk3826qw+kmVmljLX4HVTmU9/77Lu0i00FDJIuuhcLxAWNgM8bB8AI
 RkH+Hhp5jrau5NdmWgzH2tPB2mU8WZ4Xe0sk5ojIr8Q/+2ebC07uR73xZVljeI1oTnN4m3+h
 tI2jkebDg8r9UYn5/ICfk9CwKn+HedVRdQS5AQ0EU27IfAEIAOMN8NmSoQ94T+QHjo/ZcB4A
 XWOw4rd02iKjdtyQyGlXVRNPHOI9UzeAo6Neo5Cf92iq6w7u3n51pt7Mgg47cdPYwjEfr0lW
 ECfJuWrTmlL5xsSCShPoowfFfAKFx7zkhPvTA1sMLZ5xPZwhKvnlKH5VFph9IKltqMFe6g5u
 JXXdAsaFHQS2i2H3ZobYx8/lQgjtVHGLJX19Eqisg72MClMMl6gUlNxzfpY5tPwuzkpz8hLb
 ygNJN4bwDCBUWqTt5dn26bp16Qt4KQjUpo4XjbLOPFWDcprW2gfMt2Z10b1a7JKavPNBzTW1
 /vf+CInOnGUIxu8bO5zoI1wB4Q7sjLMAEQEAAYkBHwQYAQIACQUCU27IfAIbDAAKCRAJPwDl
 n28j1bi7B/9XpmjC3lBcHAVDJB+lYDigh/zguW4YprCByglRUBgxqA4RUfDeWNpv47ArIkjr
 MKKJj49p4NlQU1tvzI9tgTIYYmSSm6AljagL9eQqvDeG5P16PE1rQB8UGh4+i0YG684tys1d
 rcjFgUlLHpUS0aF/BVDbVvK7sNvuxlm1NHyEtOnxkYrhQNy7tuGzysw4sywDHd+wqV3s6AGM
 ghninx66vTVjLDkLSzL+ZU8him/Tb53fqMPBFUFGPUCtpoAYYmmqoYh2blGsYLw4yBmrN/Ki
 d5e4sncB2Qdc9HQXN0aqnirD3D3QkLUcvHIlFwBeQF/O5TO/xTRDgSwvnRFvI6AB
Message-ID: <c0e916fb-7b0e-1192-e71d-ea6449863e9b@narod.ru>
Date:   Fri, 24 Apr 2020 01:42:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git remote add origin ...

produces the error

fatal: remote origin already exists.

when run in the directory which is not initialized by Git (has no .git
folder).

This error message is misleading.

git --version
git version 2.20.1

