Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 940C220248
	for <e@80x24.org>; Wed, 27 Feb 2019 14:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730543AbfB0OFH convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 27 Feb 2019 09:05:07 -0500
Received: from cisrsmtp.univ-lyon1.fr ([134.214.188.146]:46208 "EHLO
        cisrsmtp.univ-lyon1.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730392AbfB0OFH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 09:05:07 -0500
Received: from localhost (localhost [127.0.0.1])
        by cisrsmtp.univ-lyon1.fr (Postfix) with ESMTP id 77204A03D8
        for <git@vger.kernel.org>; Wed, 27 Feb 2019 15:05:04 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at cisrsmtp.univ-lyon1.fr
Received: from cisrsmtp.univ-lyon1.fr ([127.0.0.1])
        by localhost (cisrsmtp.univ-lyon1.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mcux5I_gak79 for <git@vger.kernel.org>;
        Wed, 27 Feb 2019 15:05:03 +0100 (CET)
Received: from BEMBX2013-02.univ-lyon1.fr (bembx2013-02.univ-lyon1.fr [134.214.201.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by cisrsmtp.univ-lyon1.fr (Postfix) with ESMTPS id 5C674A03D4
        for <git@vger.kernel.org>; Wed, 27 Feb 2019 15:05:03 +0100 (CET)
Received: from BEMBX2013-01.univ-lyon1.fr (134.214.201.247) by
 BEMBX2013-02.univ-lyon1.fr (134.214.201.248) with Microsoft SMTP Server (TLS)
 id 15.0.1263.5; Wed, 27 Feb 2019 15:05:03 +0100
Received: from BEMBX2013-01.univ-lyon1.fr ([fe80::b1ea:14ef:61b9:d4cd]) by
 BEMBX2013-01.univ-lyon1.fr ([fe80::b1ea:14ef:61b9:d4cd%15]) with mapi id
 15.00.1263.000; Wed, 27 Feb 2019 15:05:02 +0100
From:   BOMPARD CORENTIN p1603631 <corentin.bompard@etu.univ-lyon1.fr>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     BERBEZIER NATHAN p1601409 <nathan.berbezier@etu.univ-lyon1.fr>,
        "CHABANNE PABLO p1602176" <pablo.chabanne@etu.univ-lyon1.fr>,
        MOY MATTHIEU <matthieu.moy@univ-lyon1.fr>
Subject: [RFC] pull --set-upstream implementation
Thread-Topic: [RFC] pull --set-upstream implementation
Thread-Index: AQHUzqP0XviS325WvkW8tlg78BQIeg==
Date:   Wed, 27 Feb 2019 14:05:02 +0000
Message-ID: <1551276325342.31383@etu.univ-lyon1.fr>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [134.214.126.172]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We are currently working on adding "--set-upstream <remote> <branch>" to pull, that will work like "push --set-upstream <remote> <branch>"
The main usage should be "git pull --set-upstream <remote> <branch>"
However:

* <branch> could be a refspec like "refs/heads/*"

* If there is an error such as invalid URL or unreachable host we don't want to edit the config

It makes more sense to us to implement the "--set-upstream" logic in git fetch which would let us test the remote and manage when called with a refspec. As a side effect: it will add the "--set-upstream" argument to fetch. 
Essentialy we see 3 options:

1- add the "--set-upstream" argument directly in builtin/pull.c it will make it harder to parse the refspec and test the remote

2- add the "--set-upstream" as a visible argument of fetch as fetch --set-upstream could be useful

3- add the "--set-upstream" as a hidden argument of fetch

Option 2 seems the best choice to us, any suggestion? 

Thanks in advance.
Corentin BOMPARD, Nathan BERBEZIER, Pablo CHABANNE.
    
