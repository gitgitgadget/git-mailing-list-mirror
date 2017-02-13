Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12E921FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 16:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752746AbdBMQtW (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 11:49:22 -0500
Received: from smtprelay05.ispgateway.de ([80.67.31.93]:48039 "EHLO
        smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751702AbdBMQtV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 11:49:21 -0500
Received: from [91.113.179.170] (helo=[192.168.92.25])
        by smtprelay05.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES128-SHA:128)
        (Exim 4.84)
        (envelope-from <marc.strapetz@syntevo.com>)
        id 1cdJoU-0006Im-FV
        for git@vger.kernel.org; Mon, 13 Feb 2017 17:49:18 +0100
From:   Marc Strapetz <marc.strapetz@syntevo.com>
Subject: git remote rename problem with trailing \\ for remote.url config
 entries (on Windows)
To:     git@vger.kernel.org
Message-ID: <da730b21-58ae-bfa8-705f-7669c0f56764@syntevo.com>
Date:   Mon, 13 Feb 2017 17:49:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of our users has just reported that:

$ git remote rename origin origin2

will turn following remote entry:

[remote "origin"]
	url = c:\\repo\\
	fetch = +refs/heads/*:refs/remotes/origin/*

into following entry for which the url is skipped:

[remote "origin2"]
[remote "origin2"]
	fetch = +refs/heads/*:refs/remotes/origin2/*

I understand that this is caused by the trailing \\ and it's easy to 
fix, but 'git push' and 'git pull' work properly with such URLs and a

$ git clone c:\repo\

will even result in the problematic remote-entry. So I guess some kind 
of validation could be helpful.

Tested with git version 2.11.0.windows.1

-Marc




