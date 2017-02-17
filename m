Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 983CB20136
	for <e@80x24.org>; Fri, 17 Feb 2017 13:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933847AbdBQNKy (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 08:10:54 -0500
Received: from 19.mo3.mail-out.ovh.net ([178.32.98.231]:43820 "EHLO
        19.mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933794AbdBQNKx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 08:10:53 -0500
X-Greylist: delayed 11987 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Feb 2017 08:10:53 EST
Received: from player797.ha.ovh.net (b9.ovh.net [213.186.33.59])
        by mo3.mail-out.ovh.net (Postfix) with ESMTP id AD043A4F1C
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 10:31:37 +0100 (CET)
Received: from [10.0.0.189] (unknown [78.192.188.175])
        (Authenticated sender: postmaster@greg0ire.fr)
        by player797.ha.ovh.net (Postfix) with ESMTPSA id 388672E0095
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 10:31:37 +0100 (CET)
To:     git@vger.kernel.org
From:   greg0ire <postmaster@greg0ire.fr>
Subject: dotfiles in git template dir are not copied
Message-ID: <ebd661c3-7d99-54d2-dda9-09c4a76cfe93@greg0ire.fr>
Date:   Fri, 17 Feb 2017 10:31:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 14049260515843018205
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 50
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelhedrtdeigddthecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecuogetfeejfedqtdegucdlhedtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I noticed yesterday that dotfiles inside the directory configured in 
init.templatedir are not copied when creating a new repository.

Here is the line I think is responsible for this behavior : 
https://github.com/git/git/blob/master/builtin/init-db.c#L48

Is it a bug or a feature?

Steps to reproduce, provided you already have a template dir configured :

cd $(git config --path --get init.templatedir)
touch copied
touch .not_copied
cd /tmp
mkdir whatever
cd whatever
git init
ls -la .git

On my machine, the last command does not list .not_copied .

--
greg0ire
