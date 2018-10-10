Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E46D21F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 09:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbeJJRO5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 13:14:57 -0400
Received: from devianza.investici.org ([198.167.222.108]:20898 "EHLO
        devianza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJJRO5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 13:14:57 -0400
X-Greylist: delayed 1225 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Oct 2018 13:14:56 EDT
Received: from [198.167.222.108] (devianza [198.167.222.108]) (Authenticated sender: najamelan@autistici.org) by localhost (Postfix) with ESMTPSA id 10E7C1D2;
        Wed, 10 Oct 2018 09:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autistici.org;
        s=stigmate; t=1539163991;
        bh=hIAim7DO4a8gwP/OIjiTqZn7S693EjbZcd2aof0Gr3s=;
        h=To:From:Subject:Cc:Date;
        b=WxhpfYOUpZqQD9rwT1/Jo0uh5+iaSf1qjamQ6HXOxPFqsTgPFjKuw05GaveHn91rU
         y7uH+NLquu9kfb+bscnqo5v3tBlg6W3GxxIa/kVR+ybaRaN8dXXO3szYS9wMuJ+Vw0
         lT/34bLHz+tssJqLllvOewY49i9Lzvg8mbP40IBo=
To:     git@vger.kernel.org
From:   Naja Melan <najamelan@autistici.org>
Subject: bug when combined with etckeeper
Cc:     id@joeyh.name
Message-ID: <4d7cddf8-34b3-eaa4-dc9e-e190062e6135@autistici.org>
Date:   Wed, 10 Oct 2018 09:33:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am running:

Linux  4.18.12-arch1-1-ARCH #1 SMP PREEMPT Thu Oct 4 01:01:27 UTC 2018 x86_64 GNU/Linux

git version 2.19.1

etckeeper Version: 1.18.8


I ran into a strange bug. In the following script the commit at the end will fail with: 

> The following paths are ignored by one of your .gitignore files:
> .etckeeper
> Use -f if you really want to add them.

Note that there is no .gitignore file and no `.etckeeper` file in the repository, there is nothing in .git/exclude. There is no `core.excludesFile`, not locally, global, nor system. There are no userwide or systemwide ignore files. In fact there is not a single text file on my system which matches the regex '^\.etckeeper'. 

Also `git check-ignore .etckeeper` returns exit status 1. Thus I conclude that something isn't right. I don't know where the exclude rule comes from...

It works as expected if the `-a` option is not used on `git commit`.

I have not found any hints in the scripts from the etckeeper package that might explain this.

#------------------------------------------------
#! /usr/bin/bash

rm -rf gitignorebug

mkdir gitignorebug

cd gitignorebug

git init

git config --local user.name  "git bug"
git config --local user.email "git@bug.com"

touch file

git add file

git commit -am"add file"
#---------------------------------------------------

Thank you for looking into it.
