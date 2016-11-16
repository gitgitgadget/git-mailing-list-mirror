Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A4AE2042F
	for <e@80x24.org>; Wed, 16 Nov 2016 17:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752375AbcKPRF6 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 16 Nov 2016 12:05:58 -0500
Received: from mxo1.dft.dmz.twosigma.com ([208.77.212.183]:53398 "EHLO
        mxo1.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752015AbcKPRF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 12:05:57 -0500
Received: from localhost (localhost [127.0.0.1])
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTP id 9131B100065;
        Wed, 16 Nov 2016 17:05:55 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo1.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo1.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7A0wqkEBL9DW; Wed, 16 Nov 2016 17:05:55 +0000 (GMT)
Received: from exmbdft8.ad.twosigma.com (exmbdft8.ad.twosigma.com [172.22.2.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTPS id 7FF7180035;
        Wed, 16 Nov 2016 17:05:55 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft8.ad.twosigma.com (172.22.2.84) with Microsoft SMTP Server (TLS) id
 15.0.1156.6; Wed, 16 Nov 2016 17:05:55 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::9966:e831:c693:7cef]) by
 exmbdft7.ad.twosigma.com ([fe80::9966:e831:c693:7cef%17]) with mapi id
 15.00.1156.000; Wed, 16 Nov 2016 17:05:55 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Stefan Beller' <sbeller@google.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "bmwill@google.com" <bmwill@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "jrnieder@gmail.com" <jrnieder@gmail.com>,
        "mogulguy10@gmail.com" <mogulguy10@gmail.com>
Subject: RE: [PATCH 14/16] checkout: recurse into submodules if asked to
Thread-Topic: [PATCH 14/16] checkout: recurse into submodules if asked to
Thread-Index: AQHSP5UABD/l8VQ2lkOrL+nq828ECaDb16Wg
Date:   Wed, 16 Nov 2016 17:05:55 +0000
Message-ID: <d9b50f01144f4c9a99b42230d4216222@exmbdft7.ad.twosigma.com>
References: <20161115230651.23953-1-sbeller@google.com>
 <20161115230651.23953-15-sbeller@google.com>
In-Reply-To: <20161115230651.23953-15-sbeller@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.14]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, my previous message accidentally sent before I was done.  One more comment:

> -----Original Message-----
> From: Stefan Beller [mailto:sbeller@google.com]

> +test_expect_failure '"checkout --recurse-submodules" needs -f to update
> modifed submodule content' '
> +	echo modified >submodule/second.t &&
> +	test_must_fail git checkout --recurse-submodules HEAD^ &&
> +	test_must_fail git diff-files --quiet submodule &&
> +	git diff-files --quiet file &&
> +	git checkout --recurse-submodules -f HEAD^ &&
> +	git diff-files --quiet &&
> +	git diff-index --quiet --cached HEAD &&
> +	git checkout --recurse-submodules -f master &&
> +	git diff-files --quiet &&
> +	git diff-index --quiet --cached HEAD
> +'

It might be worth adding some comments explaining why you expect these to fail.  

