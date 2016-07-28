Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 663C51F859
	for <e@80x24.org>; Thu, 28 Jul 2016 11:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756631AbcG1LGV (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 07:06:21 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:59095 "EHLO
	smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756249AbcG1LGU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 07:06:20 -0400
X-Greylist: delayed 490 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Jul 2016 07:06:20 EDT
Received: from [192.168.2.201] ([92.22.55.62])
	by smtp.talktalk.net with SMTP
	id Sj0ybR6b2gKstSj0ybn7zs; Thu, 28 Jul 2016 11:58:08 +0100
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
	t=1469703488; bh=MHG3zPIVKzCcBXiRqUQkqCowIWXT8JMidOWyqBDHLqs=;
	h=Reply-To:To:From:Subject:Date;
	b=ldCQzWn0LcrQJ2hOsufLJrsLI+Ro17tzCQ60aq42DkNEo782XxcwF+33nF4bZ2pUR
	 NyH8tOuDdX+6ZkaTmGS9D5pZUHxJo939gltD8Xubnj0BI9N4b6YhzuAeTWsDCnhFRQ
	 T04JLGyJQ6uZNcA6hYR2X5yV2pV0JAVuW7ILP24Q=
X-Originating-IP: [92.22.55.62]
X-Spam:	0
X-OAuthority: v=2.2 cv=GdBVpkfL c=1 sm=1 tr=0 a=emT4YZXqgNgQELh026CzWg==:117
 a=emT4YZXqgNgQELh026CzWg==:17 a=IkcTkHD0fZMA:10 a=Wbk5UPypNhkl8-st9gwA:9
Reply-To: phillip.wood@dunelm.org.uk
To:	git@vger.kernel.org
From:	Phillip Wood <phillip.wood@talktalk.net>
Subject: Bug? git rebase -i --autostash fails to restore working files
Message-ID: <222a3e5b-ff2c-799e-0fcb-cba23815019f@talktalk.net>
Date:	Thu, 28 Jul 2016 11:58:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfB9HJGAUpaRmxLrHsIcETPIei5duvsiRqHHMIYF9P+Tn92ZWKNkPuJIuPbLCF0te6FZ89ZSqKqjv0q2+B+EcAkwmG82piFedBXdMqHlw2nx3EE6n07Ko
 jQtvqtYqEa4xms3Kqe12/TtFCinUIACLnRDpL21KG45ztTfHyrWEB5dfokzifluaN7F+oAOqQXj4AA==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When running ‘git rebase -i --autostash’ if the editor fails then the
rebase fails but stash is not applied so the working files are not
restored. Running ‘git rebase --abort’ replies that there’s no rebase
in progress. If you notice what’s happened it’s not a problem if you
know to do ‘git stash apply <autostash id>’ but it’s confusing as
normally the stash would be automatically applied. This happened to me
when I messed up my editor configuration but you can reproduce it with

$ GIT_SEQUENCE_EDITOR=false git rebase -i --autostash HEAD^^
Created autostash: ff960d4
HEAD is now at f1b8af7 [git] Turn on rebase.missingCommitsCheck
Could not execute editor

$ git rebase --abort
No rebase in progress?

Best Wishes

Phillip
