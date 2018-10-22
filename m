Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ACED1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 10:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbeJVTI6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 15:08:58 -0400
Received: from forward100j.mail.yandex.net ([5.45.198.240]:44404 "EHLO
        forward100j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728101AbeJVTI6 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Oct 2018 15:08:58 -0400
X-Greylist: delayed 464 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Oct 2018 15:08:57 EDT
Received: from mxback1j.mail.yandex.net (mxback1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::10a])
        by forward100j.mail.yandex.net (Yandex) with ESMTP id 60C165D82921
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 13:43:11 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id Y1dqybZHSm-hAtS9jNB;
        Mon, 22 Oct 2018 13:43:10 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barak.in; s=mail; t=1540204990;
        bh=PL+XShyUASADkAOluBICQzN5wExo8Qj8/pZDFlA8Y4A=;
        h=From:To:Subject:Date:Message-Id;
        b=CcXq53y4yBSV0zqR0PTMv7nDJE5TaOHTkzZu1NN68iSe7nyMiufWe79XH7CWs26FD
         3sptwCwrrVGjWA+TCyH41kSBrwSxXJJeKRKCK5xzDdPEBTH1pzjN6qquIxgmt6X7xn
         8LII8p2cUFpj0tGgjVF832Gf+HAnJiEuFPRRxCYA=
Authentication-Results: mxback1j.mail.yandex.net; dkim=pass header.i=@barak.in
Received: by iva3-0d9a30469759.qloud-c.yandex.net with HTTP;
        Mon, 22 Oct 2018 13:43:10 +0300
From:   "alexander barakin (aka sash-kan)" <alex@barak.in>
To:     git@vger.kernel.org
Subject: wrong info from 'git remote show <remote>' about 'git push' configuration
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Mon, 22 Oct 2018 13:43:10 +0300
Message-Id: <7871821540204990@iva3-0d9a30469759.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git remote show <remote>" shows wrong information
about not yet configured for 'git push' local ref.

steps to reproduce:

$ git init
$ git remote add origin https://github.com/git/git # for example
$ git pull origin master
$ git remote show origin
...
  Local ref configured for 'git push':
    master pushes to master (up to date)
$

but the local branch "master" is not yet configured to push to remote "master":
1. there is no section '[branch "master"]' (with required content) in the .git/config
2. attempt to push results in error (and that's right):
$ git push
fatal: The current branch master has no upstream branch.
