Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0EC92021E
	for <e@80x24.org>; Wed, 16 Nov 2016 00:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752742AbcKPAHi convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 15 Nov 2016 19:07:38 -0500
Received: from mxo2.nje.dmz.twosigma.com ([208.77.214.162]:57759 "EHLO
        mxo2.nje.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752194AbcKPAHh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 19:07:37 -0500
Received: from localhost (localhost [127.0.0.1])
        by mxo2.nje.dmz.twosigma.com (Postfix) with ESMTP id 7B786100050;
        Wed, 16 Nov 2016 00:07:35 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo2.nje.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo2.nje.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0ktgU0QLlVWj; Wed, 16 Nov 2016 00:07:35 +0000 (GMT)
Received: from exmbdft5.ad.twosigma.com (exmbdft5.ad.twosigma.com [172.22.1.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo2.nje.dmz.twosigma.com (Postfix) with ESMTPS id 6B0FF8002E;
        Wed, 16 Nov 2016 00:07:35 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft5.ad.twosigma.com (172.22.1.56) with Microsoft SMTP Server (TLS) id
 15.0.1156.6; Wed, 16 Nov 2016 00:07:35 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::9966:e831:c693:7cef]) by
 exmbdft7.ad.twosigma.com ([fe80::9966:e831:c693:7cef%17]) with mapi id
 15.00.1156.000; Wed, 16 Nov 2016 00:07:35 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Brandon Williams' <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "jrnieder@gmail.com" <jrnieder@gmail.com>,
        "mogulguy10@gmail.com" <mogulguy10@gmail.com>
Subject: RE: [PATCH 09/16] update submodules: add scheduling to update
 submodules
Thread-Topic: [PATCH 09/16] update submodules: add scheduling to update
 submodules
Thread-Index: AQHSP5T8ef6XB/RO7kyMz1tq6Fru9KDauk8AgAABCPA=
Date:   Wed, 16 Nov 2016 00:07:34 +0000
Message-ID: <7d6c85faf2f94a65947c65bad350532a@exmbdft7.ad.twosigma.com>
References: <20161115230651.23953-1-sbeller@google.com>
 <20161115230651.23953-10-sbeller@google.com>
 <20161116000236.GF66382@google.com>
In-Reply-To: <20161116000236.GF66382@google.com>
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

> -----Original Message-----
> From: Brandon Williams [mailto:bmwill@google.com]
> > +struct scheduled_submodules_update_type {
> > +	const char *path;
> > +	const struct object_id *oid;
> > +	/*
> > +	 * Do we need to perform a complete checkout or just incremental
> > +	 * update?
> > +	 */
> > +	unsigned is_new:1;
> > +} *scheduled_submodules;
> > +#define SCHEDULED_SUBMODULES_INIT {NULL, NULL}
> 
> I may not know enough about these types of initializors but that Init
> macro only has 2 entries while there are three entries in the struct
> itself.

In fact, only the first NULL is necessary; unspecified initializer entries in C default to zero.

