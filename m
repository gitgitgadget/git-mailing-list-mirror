Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 787351F6BF
	for <e@80x24.org>; Wed, 31 Aug 2016 08:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758906AbcHaIGa (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 04:06:30 -0400
Received: from mout.gmx.net ([212.227.15.18]:63417 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757955AbcHaIG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 04:06:26 -0400
Received: from [192.168.1.9] ([92.227.144.23]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MLvGW-1bkVm61PBM-007ofL for <git@vger.kernel.org>; Wed,
 31 Aug 2016 10:06:22 +0200
From:   doak <doak@gmx.de>
Subject: bug: 'core.logallrefupdates' is not set by default in non-bare
 repository
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <c46d36ef-3c2e-374f-0f2e-ffe31104e023@gmx.de>
Date:   Wed, 31 Aug 2016 10:09:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:V1UHgwI7+3IOhNTX2C4k9gGRldx8d7wcQri8LohwaS/p5TQFyOd
 xLWjiKmhptwBaQ6lnmyY/jQ3o3Xo22wsjqdbtiUVbkPod4zKDvXpWKEjYOFHEWFxnSgEd4X
 vQjnOw6zlvcW1KWADxzCVDDowYn1G+9paLRUOIzfS5cBNTQY4f0G+CcQSWos0Go+Fl5gIJQ
 QKVxneCXrBQuBxnk0QkVA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:th+i8pJOJUI=:bb44LRYe/gh3RmIa0cfRNS
 Z5pRsMQy/wtBusK+Wa6EjmvGAu/PyKo7KGr6MvVQqcMtQNizdflEQ5fao3IB7ZK/+GxFFakI2
 JVR1BKGNrsUAv2ixlnCYcV9CydBpG8LYogh28HgBG87SJJIt4kzcglUcthn1M7XP41iaIyOBP
 W1qX1aiNf9RwSvlyghPiKO5P6bCvtYKBshZVwJDMmKhDzuCS62xnkSQ8TdeP9ttw8MlVj0WD7
 Is/0osLqKJUJ1ZtrXyiHwO2SBOXgZOSGXG4IkaZIph/9Vbe6o42LBpD/S9eBLjF8wMto93NTl
 ro+6bc9mUVSrAwWZ5F8Y7KRNsiaqj8hYNxf1e4y9ZURUE3UryUoUC5dvzDBc5BMirMzOjDkGx
 3pUN2XbEE06ti9leGxqlditTrRMMRPS6mw+PEkXhL25AX3ZNuXzqay8qQy+IkCeC1ge+fTvb4
 LMzJwCtBnB1uHYB4q78eoyRAebgtx6A3M+fsViHt6ekL6ammI0IbtkZAo/qDJjeGT21rpAImH
 M+kw/3M5qwYTYJPGeKOK4/8LoZWukhNxQ7xiqi/e/WRSZ0dqy7tGftWvtUA0Zuyc5XWZyV6pO
 iG34+xSlFYTkFwZneDq4aubXosyAHJwtj3AVBx5FJ3fICyYBcgL0sdwe3o15G1qikSk42jLc0
 CtNu2w/z11Z4gvNADYsNxSrqFgYSu1chaXqt8tyWCpWkhB8pYHTBtBDJxRHuBZrrmX2LLGkBo
 sNxgKjACDrqTcUHAYXyAWr/H6wa+oOhX3/Hf7Bxo+K/2eCn+FivmY6Xpw+XwWoI20JqwmbqpD
 gBXDOPY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there,

If 'git init /path/to/repo' is called inside another repository with 'core.logallrefupdates' set to true, it will be not set by default in the created repository.
This seems to be a bug.
I am using Git v2.9.3 (Arch).

Steps to reproduce:
    ---------------------
    git init t1
    cd t1
    # 'core.logallrefupdates' will not be set for 't2'.
    git init ../t2
    ---------------------

Stated from 'git-config(1)':
    ---------------------
    core.logAllRefUpdates
        [...]
        This value is true by default in a repository that has a working directory associated with it, and false by default in a bare repository.
    ---------------------


With best regards,
doak


