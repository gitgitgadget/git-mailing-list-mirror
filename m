Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32719200B9
	for <e@80x24.org>; Sun,  6 May 2018 19:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbeEFTW1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 15:22:27 -0400
Received: from black.maple.relay.mailchannels.net ([23.83.214.19]:54284 "EHLO
        black.maple.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751820AbeEFTW0 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 May 2018 15:22:26 -0400
X-Sender-Id: p38ruhd5tl|x-authuser|ms@kilabit.info
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 035C51214D2
        for <git@vger.kernel.org>; Sun,  6 May 2018 19:03:53 +0000 (UTC)
Received: from sg09.dewaweb.com (unknown [100.96.15.83])
        (Authenticated sender: p38ruhd5tl)
        by relay.mailchannels.net (Postfix) with ESMTPA id 53843121BBC
        for <git@vger.kernel.org>; Sun,  6 May 2018 19:03:52 +0000 (UTC)
X-Sender-Id: p38ruhd5tl|x-authuser|ms@kilabit.info
Received: from sg09.dewaweb.com (sg09.dewaweb.com [172.18.41.110])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.14.1);
        Sun, 06 May 2018 19:03:52 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: p38ruhd5tl|x-authuser|ms@kilabit.info
X-MailChannels-Auth-Id: p38ruhd5tl
X-Stop-Cellar: 43e9b4f246cb9eb3_1525633432789_1310507487
X-MC-Loop-Signature: 1525633432788:3544634963
X-MC-Ingress-Time: 1525633432788
Received: from [139.228.118.230] (port=60708 helo=localhost.localdomain)
        by sg09.dewaweb.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <ms@kilabit.info>)
        id 1fFOwn-004ije-Nk
        for git@vger.kernel.org; Mon, 07 May 2018 03:03:49 +0800
Date:   Mon, 7 May 2018 02:03:48 +0700
From:   Shulhan <ms@kilabit.info>
To:     git@vger.kernel.org
Subject: [bug] Multiline value should error if the next line is section
Message-ID: <20180507020348.31b473b4@kilabit.info>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AuthUser: ms@kilabit.info
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

## Environment

OS: Arch Linux
Git version: git@next d54016d9e

## Reproduction Steps

(1) Create the following `git.config`,

```
[alias]
        tree = --no-pager log --graph \
                --date=format:'%Y-%m-%d' \
                --pretty=format:'%C(auto,dim)%ad %<(7,trunc) %an %Creset%m %h %s %Cgreen%d%Creset' \
                --exclude="*/production" \
                --exclude="*/dev-*" \
                -n 20 \
[user]
        name = Shulhan
        email = ms@kilabit.info
```

(2) Run `git config -f git.config -l`


## Expected Result

Error message,

  fatal: bad config line 9 at git.config


## Actual Result

The command print the following output,

```
alias.tree=--no-pager log --graph
--date=format:'%Y-%m-%d'
--pretty=format:'%C(auto,dim)%ad %<(7,trunc) %an %Creset%m %h %s %Cgreen%d%Creset' --exclude=*/production                 --exclude=*/dev-*                 -n 20 [user]
alias.name=Shulhan
alias.email=ms@kilabit.info
```
