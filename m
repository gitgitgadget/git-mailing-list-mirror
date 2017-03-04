Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6147820133
	for <e@80x24.org>; Sat,  4 Mar 2017 01:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751677AbdCDBHV (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 20:07:21 -0500
Received: from mail-bn3nam01on0094.outbound.protection.outlook.com ([104.47.33.94]:24600
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751551AbdCDBHU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 20:07:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=4recirjz1AbUqGCaofRF/0Ioav7i4kvQWe68dcTxnuU=;
 b=nYzvlWwrTJxE8vZp6UC1Q3e4KK7WMm5UA4MvWINZ/XdrWPQKNBcPiYyRpMAJocwpLdNcT68zA9hX/rJTAAdrqYYi7LtpNz53cELDFQcN6MkthbwGgTq6T1BD1yHg9cNZE7FOftvVR5fd3je7PZdqgwhRTPoVLRtTbZkwiPWstHI=
Received: from CY1PR0301MB2107.namprd03.prod.outlook.com (10.164.2.153) by
 CY1PR0301MB2107.namprd03.prod.outlook.com (10.164.2.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.947.12; Sat, 4 Mar 2017 01:07:17 +0000
Received: from CY1PR0301MB2107.namprd03.prod.outlook.com ([10.164.2.153]) by
 CY1PR0301MB2107.namprd03.prod.outlook.com ([10.164.2.153]) with mapi id
 15.01.0947.015; Sat, 4 Mar 2017 01:07:17 +0000
From:   Dan Shumow <danshu@microsoft.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Marc Stevens <marc.stevens@cwi.nl>
Subject: RE: [PATCH] Put sha1dc on a diet
Thread-Topic: [PATCH] Put sha1dc on a diet
Thread-Index: AQHSkiMIUGTsYtffFU+WRTsYHJQFFqGAUwj9gAAB7oCAABGiAIAABgQAgAAFjoCAADN5AIAAEf1ggABBsMWAAujfkA==
Date:   Sat, 4 Mar 2017 01:07:16 +0000
Message-ID: <CY1PR0301MB2107112BCC2DECD215E70549C42A0@CY1PR0301MB2107.namprd03.prod.outlook.com>
References: <alpine.LFD.2.20.1702281621050.22202@i7.lan>
        <xmqq7f48hm8g.fsf@gitster.mtv.corp.google.com>
        <CA+55aFx1wAS-nHS2awuW2waX=cvig4UoZqmN5H3v93yDE7ukyQ@mail.gmail.com>
        <20170301195302.3pybakmjqztosohj@sigill.intra.peff.net>
        <CA+55aFwf3sxKW+dGTMjNAeHMOf=rvctEQohm+rbhEb=e3KLpHw@mail.gmail.com>
        <20170301203427.e5xa5ej3czli7c3o@sigill.intra.peff.net>
        <CA+55aFz4ixVKVURki8FeXjL5H51A_cQXsZpzKJ-N9n574Yy1rg@mail.gmail.com>
        <CY1PR0301MB21073D82F4A6AB0DAD8BF1FCC4280@CY1PR0301MB2107.namprd03.prod.outlook.com>
 <xmqq1suge1jn.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqq1suge1jn.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pobox.com; dkim=none (message not signed)
 header.d=none;pobox.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2001:4898:80e8:b::7ac]
x-ms-office365-filtering-correlation-id: 38b85b4a-5f91-43ed-88ab-08d4629acd0f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(48565401081);SRVR:CY1PR0301MB2107;
x-microsoft-exchange-diagnostics: 1;CY1PR0301MB2107;7:Et1ioMEkNin/Ifl3h7PGXlhHo1sTNuNbnsmrKs1eaCHKMn2qNFtHS08sJwaUMP3CaUVCyq6+6H6OaBKPyU3wWgz0KX/4o02y56DcPOPhXZx14gMPcRpluGQOFKlimdp4mfyFxfjbVHcIqJoB0HA99ocJ8EElXGZRhJ7UNm7bgeYgPHjMuesOQEKfJttcEkSzNYmOxBp4lEGYT2tsxzV8nUOaFK2wYduiWbRDc9LkWPNLIu8cqIVX8a51u9r6wwhH/Ug7aVEQmHNwAL+NCyu/+TAXfRTIN5QZLeeqCW5AwL1Am/2XnsZ2XaHfjda8OZLWol6snPjR/QJzDeZy0Lsd/hKJLzqL+yfyg3istW9ItdU=
x-microsoft-antispam-prvs: <CY1PR0301MB210764FF007104DB39D0345AC42A0@CY1PR0301MB2107.namprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(100324003535756);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040375)(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041248)(20161123555025)(20161123560025)(20161123558025)(20161123562025)(20161123564025)(6072148);SRVR:CY1PR0301MB2107;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0301MB2107;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(7916002)(39850400002)(39450400003)(39410400002)(39860400002)(39840400002)(43784003)(51444003)(99286003)(189998001)(110136004)(53936002)(6246003)(33656002)(50986999)(345774005)(76176999)(54906002)(54356999)(86362001)(122556002)(4326008)(3660700001)(25786008)(9686003)(102836003)(6116002)(55016002)(7696004)(81166006)(77096006)(7736002)(6506006)(8676002)(2900100001)(38730400002)(6436002)(5660300001)(8656002)(92566002)(93886004)(229853002)(74316002)(6916009)(8990500004)(10090500001)(8936002)(3280700002)(2950100002)(10290500002)(2906002)(305945005)(106116001)(5005710100001)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR0301MB2107;H:CY1PR0301MB2107.namprd03.prod.outlook.com;FPR:;SPF:None;MLV:sfv;LANG:en;
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2017 01:07:16.9509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0301MB2107
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano [mailto:gitster@pobox.com]=20

> As you and Marc seemed to be still working on speeding up, such a customi=
zation work to fully adjust your code to our codebase was premature, so I t=
entatively queued what we saw on the list as-is on our 'pu' branch so that =
people can have a reference point.  Which unfortunately solicited a prematu=
re reaction by Johannes.  Please do not worry too much about the comment.

> But if you are willing to help us by getting involved in the "customizati=
on" part, too, that would be a very welcome news to us.
>In that case, "welcome to the Git development community" ;-)

> So,... from my point of view, we are OK either way.  It is OK if you are =
a third-party upstream that is not particularly interested in Git project's=
 specific requirement.  We surely would be happier if you and Marc, the ups=
tream authors of the code in question, also act as participants in the Git =
development community.

> Either way, thanks for your great help.

You are very welcome.  Thank you for the warm welcome.  As it turns out, Ma=
rc and I are working on the simplifications / removal of c99 and performanc=
e upstream in our GitHub repo.  I am happy to help for any GitHub specific =
customizations that are needed as well.  But for now, lets see if we can ge=
t you everything you want upstream -- I think that's the most simple.

Thanks again,
Dan

