Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D267C2055E
	for <e@80x24.org>; Fri, 27 Oct 2017 10:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752484AbdJ0Kvv (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 06:51:51 -0400
Received: from bitergia.com ([146.255.100.9]:34965 "EHLO bitergia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752467AbdJ0Kvu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 06:51:50 -0400
X-Greylist: delayed 530 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Oct 2017 06:51:50 EDT
Received: from dellx (pct-empresas-204.uc3m.es [163.117.202.204])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bitergia.com (Postfix) with ESMTPSA id 732F925CA05
        for <git@vger.kernel.org>; Fri, 27 Oct 2017 12:42:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=bitergia.com; s=mail;
        t=1509100979; bh=YinHhymLPy8r4eMupNNE+r9NHt3lo/0dAHv7DB6P6G8=;
        h=Subject:From:To:Date:From;
        b=npWwRmmy5a4Q4OpRmAhbzMwl6ubx4lt8BZeznuXHTq0Y7wdRCGYjYnz/CJbeuHor3
         nonb7KIDrJt5l8o/Sqgy771Zq5cf9oXT1fPvUs7IFlr9eMm9PJZiAGT4r8CsOUqyBS
         /8Pq86CGsD4sQ50RnL6BPTSXHZ9dSJ8woZkAxyYs=
Message-ID: <1509100979.32292.19.camel@bitergia.com>
Subject: Why does fetch-pack not works over http?
From:   Alvaro del Castillo <acs@bitergia.com>
To:     git@vger.kernel.org
Date:   Fri, 27 Oct 2017 12:42:59 +0200
Organization: Bitergia
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear all,

We're wondering why "fetch-pack" (when is running from the command
line) doesn't handle "https://" protocol. It only works with "git://".

For instance, this doesn't work:

$ git fetch-pack https://github.com/git/git refs/heads/master
fatal: I don't handle protocol 'https'

while this does:

$ git fetch-pack git://github.com/git/git refs/heads/master

The funny thing is that under the hood, "fetch" calls "fetch-pack"
using "https" procotol. Example of a trace below:

12:03:07.512558 git.c:344               trace: built-in: git 'fetch-
pack' '--stateless-rpc' '--stdin' '--lock-pack' '--thin' 'https://githu
b.com/git/git/'

Cheers
-- 
Alvaro del Castillo San Félix
acs@bitergia.com - Chief Technical Officer (CTO)
http://www.bitergia.com
"Software metrics for your peace of mind"



