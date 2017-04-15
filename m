Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FEB020D09
	for <e@80x24.org>; Sat, 15 Apr 2017 11:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752696AbdDOLoI (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Apr 2017 07:44:08 -0400
Received: from forward13o.cmail.yandex.net ([37.9.109.182]:43749 "EHLO
        forward13o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752046AbdDOLoH (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 15 Apr 2017 07:44:07 -0400
X-Greylist: delayed 470 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Apr 2017 07:44:06 EDT
Received: from mxback10o.mail.yandex.net (mxback10o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::24])
        by forward13o.cmail.yandex.net (Yandex) with ESMTP id 072CD215EE
        for <git@vger.kernel.org>; Sat, 15 Apr 2017 14:36:15 +0300 (MSK)
Received: from web25g.yandex.ru (web25g.yandex.ru [95.108.253.234])
        by mxback10o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id xu1XtyArzM-aEHSJr8k;
        Sat, 15 Apr 2017 14:36:14 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1492256174;
        bh=PZ4FUwCUbkZzp5jEhhRUzYOUh5jjm2jlan3KF3c5y/I=;
        h=From:To:Subject:Message-Id:Date;
        b=BSCaGIv6GMy0tl+SOePaVr98hI8ybXXFerDX3n+rwnGfYYtnhUBPE7upnCN40bjo5
         l6i6Klkg4KVeyzdlyHPhjWOsWD0lpbBC0wYIi1eDZJDWJ3YyN8qw0j3xotBQmIzQ82
         IoJwFrIjadfDqO3M70aZboA1nxzxODJzrpSXr64o=
Authentication-Results: mxback10o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by web25g.yandex.ru with HTTP;
        Sat, 15 Apr 2017 14:36:14 +0300
From:   KES <kes-kes@yandex.ru>
Envelope-From: kes-kes@yandex.ua
To:     git <git@vger.kernel.org>
Subject: Git allow to unconditionaly remove files on other developer host
MIME-Version: 1.0
Message-Id: <4747541492256174@web25g.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Sat, 15 Apr 2017 14:36:14 +0300
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.

That curious, but git allow to unconditionally delete files on other developer host when he do `git pull`

How to reproduce:

1. File should be ignored:
echo "somefile" >> .gitignore

2. Add this ignored file into repository
git add -f somefile

3. Push changes to origin
git push

4. When other developer has also 'somefile' on his host and when he does
git pull

Content of hist local `somefile` file will be replaced by content pushed by first developer

EXPECTED: git should warn about that content will be replaced and do not pull/checkout until we force pull/checkout
