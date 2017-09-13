Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD0DB20286
	for <e@80x24.org>; Wed, 13 Sep 2017 15:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752409AbdIMPHM convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 13 Sep 2017 11:07:12 -0400
Received: from relay-ff112.magwien.gv.at ([217.149.228.140]:51311 "EHLO
        relay-ff112.magwien.gv.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751988AbdIMPHL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 11:07:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by relay-ff112.magwien.gv.at (Postfix) with ESMTP id B1BB420695
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 17:09:40 +0200 (CEST)
X-Virus-Scanned: by amavisd-new using Sophie and ClamAV at magwien.gv.at
Received: from relay11.host.magwien.gv.at (relay11.host.magwien.gv.at [--])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by relay-ff112.magwien.gv.at (Postfix) with ESMTPS id 9EA5F2068F
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 17:09:40 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by relay11.host.magwien.gv.at (Postfix) with ESMTP id BC39F166A31
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 17:07:09 +0200 (CEST)
Received: from mail.fsw.at (sfsww2k12ex02.intern.fsw.at [--])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by relay11.host.magwien.gv.at (Postfix) with ESMTP id AFA99166A20
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 17:07:09 +0200 (CEST)
Received: from SFSWW2K12EX02.intern.fsw.at (--) by
 SFSWW2K12EX02.intern.fsw.at (--) with Microsoft SMTP Server (TLS)
 id 15.0.1293.2; Wed, 13 Sep 2017 17:07:09 +0200
Received: from SFSWW2K12EX02.intern.fsw.at ([fe80::a1d5:6bb5:fb11:2572]) by
 SFSWW2K12EX02.intern.fsw.at ([fe80::a1d5:6bb5:fb11:2572%15]) with mapi id
 15.00.1293.002; Wed, 13 Sep 2017 17:07:09 +0200
From:   Ekelhart Jakob <jakob.ekelhart@fsw.at>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Matthias Lischka <matthias.lischka@fsw.at>
Subject: RE: merge-base not working as expected when base is ahead
Thread-Topic: merge-base not working as expected when base is ahead
Thread-Index: AdMsnWsjP09HlRSfQ6CzncqiwXoHgwABAbVg
Date:   Wed, 13 Sep 2017 15:07:09 +0000
Message-ID: <e697e5f0da0845ee92ffdb88a4fa48d9@SFSWW2K12EX02.intern.fsw.at>
References: <c76e76a4ef11480da9995b0bec5a70e1@SFSWW2K12EX02.intern.fsw.at>
In-Reply-To: <c76e76a4ef11480da9995b0bec5a70e1@SFSWW2K12EX02.intern.fsw.at>
Accept-Language: en-US, de-AT
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git,

git merge-base --fork-point "master" not working if master is already newer then my current branch.
Very oddly it seems to work whenever you had the expected commit checked out previously - what made it very tricky to detect this problem.

Example:
 - Clone "https://github.com/jekelhart/GitInfoTry"
 - Switch to branch "v1.0.0"
 - git merge-base --fork-point "master"
   - or: git merge-base --fork-point "origin/master" 
 - expected result: fork point "fbb1db34c6317a6e8b319c1ec261e97ca1672c22"
 - but result is empty

In the repo where we created this example tree in the first place the command returned the expected fork point. If you clone it new and fresh it does not return any result anymore.

Works, however, on branch "v2.0.0". Assumption: because "master" is older.(?)
I think it works locally because the command uses the reflog in addition(!), however, it should work without the local reflog as well. (since the history was not modified in any way)

BR, Jakob
