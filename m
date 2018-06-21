Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A450B1F516
	for <e@80x24.org>; Thu, 21 Jun 2018 09:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932723AbeFUJhC (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 05:37:02 -0400
Received: from forward101o.mail.yandex.net ([37.140.190.181]:39966 "EHLO
        forward101o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932674AbeFUJhB (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 21 Jun 2018 05:37:01 -0400
X-Greylist: delayed 458 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Jun 2018 05:37:01 EDT
Received: from mxback5g.mail.yandex.net (mxback5g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:166])
        by forward101o.mail.yandex.net (Yandex) with ESMTP id 71B5D1345758
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 12:29:22 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback5g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 7pVmw9t60g-TFamfp8u;
        Thu, 21 Jun 2018 12:29:15 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1529573355;
        bh=NM2NycixveYPH5VEfhlX4aKqxYdQLVBDLSD9s3xU6OI=;
        h=From:To:Subject:Date:Message-Id;
        b=oZQDXRnvHWh8E3RTjbQhL72UFNdCvEdMecTUZlzT1oDIZ6WhUk7SaKTbQ29CliQ0w
         D20b6bFnyuyDJCC6qUDmjt7rybBr67x/cZOEk2CychvIXnvnDKV+kd14nJVERGiz3s
         8RRRNmayMolW9DmX7AaxFp1p8w794qx2I6PN9TP4=
Authentication-Results: mxback5g.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by web55j.yandex.ru with HTTP;
        Thu, 21 Jun 2018 12:29:15 +0300
From:   KES <kes-kes@yandex.ru>
Envelope-From: kes-kes@yandex.com
To:     git <git@vger.kernel.org>
Subject: After rebasing and reset I am on unexpected commit
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Thu, 21 Jun 2018 12:29:15 +0300
Message-Id: <242401529573355@web55j.yandex.ru>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.


I am on my current branch:

$ git log --graph --decorate --pretty=oneline --abbrev-commit
* 5b85d64 (HEAD -> SCTT_for_other_tables) Implement script to test CORS
* f45a919 Create SCTT for Contractor
* 702fcdd (xtucha/SCTT_for_other_tables) Create SCTT for PartnershipAgreement
* 7e4cac9 Create SCTT for Language
* a0607d1 Fixed broken tests for 'Person'
* 1d0a1b2 Create SCTT for DocumentFile
* 92837c1 Fix SQL quoting problem


Now I want to pull new changes and rebase my work on top of it:

$ git pull -v -r amazon SCTT_for_other_tables
From amazon:/v1/repos/tucha
 * branch            SCTT_for_other_tables -> FETCH_HEAD
 = [up to date]      SCTT_for_other_tables -> amazon/SCTT_for_other_tables
Created autostash: 97ce867
HEAD is now at 5b85d64 Implement script to test CORS
Changes from 5b85d647ecd503cc03b26ed4e33bf8266bc8e96b to a0d92dc11ec11023f6d492497e043170d7128f56:
 lib/MaitreD/Controller/ContractorTypeI18n.pm |  54 +---------------
 public/maitre_d/api-v1.yaml                  | 158 ++++++++++++++++++++++++++++++++++++++++++++++-
 t/MaitreD/contractor_type_i18n.t             | 117 +++++++++++++++++++++++++++++++++++
 3 files changed, 276 insertions(+), 53 deletions(-)
 create mode 100644 t/MaitreD/contractor_type_i18n.t
Note: checking out 'a0d92dc11ec11023f6d492497e043170d7128f56'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by performing another checkout.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -b with the checkout command again. Example:

  git checkout -b <new-branch-name>

HEAD is now at a0d92dc Merge branch 'SCTT_for_other_tables' of amazon:/v1/repos/tucha into SCTT_for_other_tables
Rebasing (1/1)
 lib/MaitreD/Controller/ContractorTypeI18n.pm |  54 +--------
 public/maitre_d/api-v1.yaml                  | 158 ++++++++++++++++++++++++++-
 t/MaitreD/contractor_type_i18n.t             | 117 ++++++++++++++++++++
 3 files changed, 276 insertions(+), 53 deletions(-)
Successfully rebased and updated refs/heads/SCTT_for_other_tables.
Applying autostash resulted in conflicts.
Your changes are safe in the stash.
You can run "git stash pop" or "git stash drop" at any time.

As you can see the rebase finished successfully except applying autostash

$ git log --graph --decorate --pretty=oneline --abbrev-commit
*   a0d92dc (HEAD -> SCTT_for_other_tables, amazon/SCTT_for_other_tables) Merge branch 'SCTT_for_oth
|\  
| * 5b85d64 Implement script to test CORS
* | 0c1ac6c Create SCTT for ContractorTypeI18n
|/  
* f45a919 Create SCTT for Contractor
* 702fcdd (xtucha/SCTT_for_other_tables) Create SCTT for PartnershipAgreement
* 7e4cac9 Create SCTT for Language
* a0607d1 Fixed broken tests for 'Person'
* 1d0a1b2 Create SCTT for DocumentFile
* 92837c1 Fix SQL quoting problem

1. Why I got merge? I did not ask that. Thus I want to rewind back

$ git reset --hard HEAD^
HEAD is now at 0c1ac6c Create SCTT for ContractorTypeI18n

2. Why I am returned to 0c1ac6c Create SCTT for ContractorTypeI18n
instead of: 5b85d64 Implement script to test CORS ?

I expect to be in the state when I start my rebasing

$ git log --graph --decorate --pretty=oneline --abbrev-commit
* 0c1ac6c (HEAD -> SCTT_for_other_tables) Create SCTT for ContractorTypeI18n
* f45a919 Create SCTT for Contractor
* 702fcdd (xtucha/SCTT_for_other_tables) Create SCTT for PartnershipAgreement
* 7e4cac9 Create SCTT for Language
* a0607d1 Fixed broken tests for 'Person'
* 1d0a1b2 Create SCTT for DocumentFile
* 92837c1 Fix SQL quoting problem


Now 5b85d64 Implement script to test CORS is not any branch and with less attention will be lost

What did I do wrong? is this behavior expected?
