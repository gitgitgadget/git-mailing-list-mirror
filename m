Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C1F61F6C1
	for <e@80x24.org>; Fri, 19 Aug 2016 02:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753514AbcHSCdb (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 22:33:31 -0400
Received: from mout.gmx.net ([212.227.15.15]:64250 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752904AbcHSCda (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 22:33:30 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MLfLH-1bafVL3OqZ-000qip; Thu, 18 Aug 2016 16:50:48
 +0200
Date:   Thu, 18 Aug 2016 16:50:47 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Ben Wijen <ben@wijen.net>, git@vger.kernel.org,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 2/2] mingw: ensure temporary file handles are not inherited
 by child processes
In-Reply-To: <xmqqd1l79rxz.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608181650030.4924@virtualbox>
References: <cover.1471437637.git.johannes.schindelin@gmx.de> <77e7c4e4de6c45a1b24bb4d08ca20a1385f43444.1471437637.git.johannes.schindelin@gmx.de> <xmqqd1l79rxz.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:LUv+55Rs64X043svC06qmk+NhBwI9uYkUQcYWq8rwA/UBxylHen
 bz6qOVj+mEkTskAf+JjH/2x3m2zOIiD+iF5u/oFrRikEHVgaBhsPfhY1+hdAEhJZ2CLc4BM
 wLxrwshXwOsstVEmMVj7cnTO6tKy/Nd+U60vPm0K6US5nIPv+BHdeh7t27Q99AeVK0lfn/D
 FMlhBDuT+09sn8+NQeDOA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:q7f6IOK4Fnw=:92hDrKQuIO6bjNcNmAoE6R
 nlTHcfREvZSUBHORfwtvl2wMyT4YIBv1D9sVkL1sgE5t4zJhB5wZV9+ilT0bmikjfAnBhi1iy
 iQQW+EoKATOiKdrmRdD99FNLYsZ19zvv4FqeowIOjvh+QLt607qI225DSaCVWhHP3/dLAXDpD
 Kp3+GsSogqofBn2WqJJGsnFFwVLAX8YeakR2HQcIqP0GyKh6ZkK7GSAUdSG42SwESIAxnid8D
 yAML8s0VCLTfE0xc+V1+ObpUcWLpRazi80L0d8nFaJG6Bf/Io7hMGAlFD10mMuRTMN7buGQN3
 z5TnNFJ/6rr7rbl21dAcZ0oza2EUVPdsgnnzjOxv/Vjdook6SYku28E2A76/D4VWPuvFwrvOU
 63O8Y0d7a3af1yK6nNqBF7g1AW6W6I2iXMedkhGlgm8BA43HGJV3dbIXX6uCeoiTCCR+uEGqE
 u8AIYhXZMmei+SX0qqgoZXEPgqtMxuYgF3s1YQjIThdXTXMQ55VNyj5WVv0iR1ung2th0Rp7S
 W0BT7+UUBI/BmVk0vOcb7XSINHQGeaJuhqGbbMkLCfXmRWfsttKj5p6yLmw0fGz/h2dLnE3Da
 Wcx913lg1m5KFdWdoOrLKLnAkaDox2iOfM/kAcg3hEESZhDIYalfJb0V/gPu/ESz8Tgp0BTf6
 IMLXobAp5UtNup6O0WsqmZbeIznO0wt9K2xJOQxuJkwXMRuFJezLXCWAhZEveHwZoPyhQJFYd
 JnHvJSepic8TNFAMxwr2iaOLSvBWu2CobJkjGL7RBFqsOIo0Cyc+7EkwGDIu9062iVsNt0oZ2
 IjMfu/1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 17 Aug 2016, Junio C Hamano wrote:

> But it deserves mention in the lockfile and the tempfile API docs in
> <lockfile.h> and <tempfile.h> that the file descriptor returned from
> these public entry points does not survive across fork(2).

I touched the comments up a little bit, and I also fixed the first commit
message as per your reply.

Will send out v2 in a moment.

Thanks,
Dscho
