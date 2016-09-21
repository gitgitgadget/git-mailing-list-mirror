Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81D091F935
	for <e@80x24.org>; Wed, 21 Sep 2016 21:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936578AbcIUVGN (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 17:06:13 -0400
Received: from mail-by2nam03on0095.outbound.protection.outlook.com ([104.47.42.95]:30144
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935416AbcIUVGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 17:06:09 -0400
X-Greylist: delayed 8347 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Sep 2016 17:06:09 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=7LMLsS2VIIk38yRGU4FH48FwHWWSLW+Buhq4hJDGhdU=;
 b=dIvjemJ9/RKS7SUZcr01/CNzVSEEz/XSEurHw7YCjwNacNa3y+xvO97RoIbnanW4Lek1cTVjJ8Ys+w6tvhsfh1FTOGCSH4zJKBfr1i8Mvee28XqdR4CduNVkCtTo00av8Mc2US7iaXpkRzRHSrUbM4kuyQ7m+wAMvChhsofJGOU=
Received: from BL2PR03MB323.namprd03.prod.outlook.com (10.141.68.22) by
 BL2PR03MB322.namprd03.prod.outlook.com (10.141.68.17) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.1.557.21; Wed, 21 Sep 2016 18:32:19 +0000
Received: from BL2PR03MB323.namprd03.prod.outlook.com ([10.141.68.22]) by
 BL2PR03MB323.namprd03.prod.outlook.com ([10.141.68.22]) with mapi id
 15.01.0557.032; Wed, 21 Sep 2016 18:32:19 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     Junio C Hamano <gitster@pobox.com>, Ben Peart <peartben@gmail.com>
CC:     "pclouds@gmail.com" <pclouds@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [PATCH v3] checkout: eliminate unnecessary merge for trivial
 checkout
Thread-Topic: [PATCH v3] checkout: eliminate unnecessary merge for trivial
 checkout
Thread-Index: AQHSDcrj6lTI9mDLUEanK50RVr8Sl6B4AorSgAAssNCAAPjOwIAHrOgAgAA1uDmAAAleFYADOqqQ
Date:   Wed, 21 Sep 2016 18:32:19 +0000
Message-ID: <BL2PR03MB323ADC371E49EFD1CBBC566F4F60@BL2PR03MB323.namprd03.prod.outlook.com>
References: <20160913142628.15440-1-benpeart@microsoft.com>
        <xmqq7fafv376.fsf@gitster.mtv.corp.google.com>
        <BL2PR03MB3232D3128A72D4EC9ADC2C6F4F10@BL2PR03MB323.namprd03.prod.outlook.com>
        <BL2PR03MB323E1B2F810C63CB01AA234F4F30@BL2PR03MB323.namprd03.prod.outlook.com>
        <007401d21278$445eba80$cd1c2f80$@gmail.com>
        <xmqqzin3g8di.fsf@gitster.mtv.corp.google.com>
 <xmqqr38fg6tk.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqr38fg6tk.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-originating-ip: [65.222.173.206]
x-ms-office365-filtering-correlation-id: 961bc3be-a74e-4dab-aa55-08d3e24d9eb8
x-microsoft-exchange-diagnostics: 1;BL2PR03MB322;6:x94a+OAwvaX5VBcdT+I3endexyaJIFBF2LaVzf/9S3SrIO8ApqQcOTsRaRmc8Copcv6fxX3Pr7y6hX2oVVjKnp0iSXwsIjfQn/T6ZZW2IrwtjCbGNNwmBcJDwXAsXZx0M8DZBFX3dANUv9PKaOwDSNNa8wcFxbXTwGz5Mhb2u26ya/++hTCQp6cvo4jXUmJnvK9sejlTsvzoNezP/s5+1ucmcKZnrAht3aBdVlfDqJ8nusjTngW4d5GOeN/RW9pnBy0Do+aHnPkiAO+07kq+uVrc7eF8a7D2TRqMJJXvk05FcOgXx4fBw/DbvEMWVQBcUmdrov5jVGKFDmt8xfU65g==;5:eTzb0T5xk/pvlW7ad4q0YdJV4T6D2tpiQux4aEJ7aF0/E4X5eftS9Hs614DWRPT3L2Wzfdet3KaFEv87wmuEGBhLQ169ShvcXoPq+EdQNBkCv4q2af1dHFXVKeiLJrnsuhEcqud2v5NxdSNsVKAiRw==;24:vL3TO8Td7KiYm/i3K/QhIlTO1346Orhr1egmvdln/7n/T7O8mbXTvdtPJsWj2qL2s2IlbqueapY+4zSTE+PQ5MHVP9gnbUYxH2vCGrEbEr0=;7:+xEsnXOihbGnONHUYXDAq9v4ixkDonzowMPr5CaRP+Htvb8q/fWCInGgQ+VijdRw/E1ItoZEWmkiCXY+5588Izemjvnzukcgd5mZrZGcY/kRjzHwE91zmhcJ+t8iruHpqmVNR+DeKKYEMyEHChoC9621Wjrl0gc8bltfaQt8Yd5nZaqE6PHScxdzZu8ovJ1X/V5Kr5jVDCCSMGn4B1G+yHx9fMRVJeypU2k6Wm5ON3i5h1gGx8U1/ARv3epYh4o/FrL94nBD5YJOQvY+IDVMs61DUFCplSdNOtnTABGoMMvYnGpNBGb/zxw43Vp0xWy9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BL2PR03MB322;
x-microsoft-antispam-prvs: <BL2PR03MB322809AFF5F1D8AEDE9736EF4F60@BL2PR03MB322.namprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(100324003535756);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040176)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001)(6055026)(61426038)(61427038);SRVR:BL2PR03MB322;BCL:0;PCL:0;RULEID:;SRVR:BL2PR03MB322;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(7916002)(199003)(377454003)(189002)(13464003)(2900100001)(76176999)(106116001)(101416001)(68736007)(2950100001)(99286002)(8990500004)(50986999)(10090500001)(86362001)(74316002)(105586002)(586003)(8676002)(8936002)(97736004)(5005710100001)(81156014)(5002640100001)(87936001)(81166006)(5001770100001)(19580405001)(77096005)(86612001)(19580395003)(189998001)(11100500001)(4326007)(10400500002)(8666005)(7696004)(54356999)(92566002)(305945005)(2906002)(93886004)(122556002)(7846002)(66066001)(76576001)(3280700002)(102836003)(9686002)(5660300001)(3846002)(7736002)(3660700001)(106356001)(33656002)(10290500002)(6116002)(7059030);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR03MB322;H:BL2PR03MB323.namprd03.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2016 18:32:19.1383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB322
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I understand the reluctance to change the existing behavior of the "git che=
ckout -b <new-name>" command.

I see this as a tradeoff between taking advantage of the muscle memory for =
the existing command and coming up with a new shortcut command and training=
 people to use it instead.

The fact that all the use cases we've observed and all the git test cases a=
ctually produce the same results but significantly faster with that change =
in behavior made me hope we could redefine the command to take advantage of=
 the muscle memory.

That said, you're much more on the frontline of receiving negative feedback=
 about doing that than I am. :)  How would you like to proceed?

Ben

-----Original Message-----
From: Junio C Hamano [mailto:gitster@pobox.com]=20
Sent: Monday, September 19, 2016 1:04 PM
To: Ben Peart <peartben@gmail.com>
Cc: pclouds@gmail.com; Ben Peart <Ben.Peart@microsoft.com>; git@vger.kernel=
.org
Subject: Re: [PATCH v3] checkout: eliminate unnecessary merge for trivial c=
heckout

Junio C Hamano <gitster@pobox.com> writes:

>> "git checkout -b foo" (without -f -m or <start_point>) is defined in=20
>> the manual as being a shortcut for/equivalent to:
>> =20
>>         (1a) "git branch foo"
>>         (1b) "git checkout foo"
>> =20
>> However, it has been our experience in our observed use cases and all=20
>> the existing git tests, that it can be treated as equivalent to:
>> =20
>>         (2a) "git branch foo"
>>         (2b) "git symbolic-ref HEAD refs/heads/foo"
>> ...
>
> I am still not sure if I like the change of what "checkout -b" is this=20
> late in the game, though.

Having said all that.

I do see the merit of having a shorthand way to invoke your 2 above.
It is just that I am not convinced that it is the best way to achieve that =
goal to redefine what "git checkout -b <new-name>" (no other parameters) do=
es.
