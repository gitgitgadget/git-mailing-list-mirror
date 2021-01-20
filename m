Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C36C433E0
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 19:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E50B233FE
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 19:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbhATTMY convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 20 Jan 2021 14:12:24 -0500
Received: from mail-vi1eur05olkn2015.outbound.protection.outlook.com ([40.92.90.15]:15745
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392409AbhATTMS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 14:12:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmEcTO7HCD6OI5jP1UygMwe+hJo3k04w6PXKTiqgbb1Jz31X69YavBW0QUw7JfbskaOsaAMZ8Sn8x/xvVChgjUCYFKfW81EiEcIC7/A0Ydak6TEe0Q69roVjIizaiCcW45dBs7QMgTMZAlSJ1qrW6rlrXt4FO+FLXb9Qedzd1i5WaVDRqLT24HOr9N/iiDN3NrEfpOKEClk0IZY4nUK6RnD7mqdpox9H7BvgzIaxFB8KkmKi0ulpnB0BVzFnHy4O40487RK7I3So001sWZWMYhv+g9JDL2G7zMquzf2U49cF7Rl6KWfQDF4akJ08cSD4iUjJJJVgWMoWV0H2VRQYeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JN1b0ud4RSZ+m97LQKicq6585I6N+IqzOarKZviYMgA=;
 b=VRPGuhS2PmmyRlQOvFhyScIs6AIfWVs/1Ejmr3mRhw5DWfu2QK+so2S3jqdLuCg7tNwlnHHHtfV9c01MQVVd+Lq2pAaEaV8HI2r0dj6FrLYC78+66I/DUs3nsBF+TV/I8ukmXC5jHS6wnlla74i9I7csC6Dh8fu/mS9R2Uv3xxVbEDBCV5xvCfkjQWM9qnTJSlRnha03wTCbG29VWF7I4NfTxFZvDcdwNcg+k5f8Zw5G73aEhbOVb/Pyk8eIdtgpPn2dgPccuQLJkOjdS1+a9iT7MMxN0C083LBr3javBzsn8IWmm6VRE34En4MroQU0Fb1Lt7V0t6AY+AwyPdSS/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DB8EUR05FT065.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc0f::41) by
 DB8EUR05HT185.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc0f::310)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Wed, 20 Jan
 2021 19:11:21 +0000
Received: from DB8P189MB1046.EURP189.PROD.OUTLOOK.COM (2a01:111:e400:fc0f::4d)
 by DB8EUR05FT065.mail.protection.outlook.com (2a01:111:e400:fc0f::306) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend
 Transport; Wed, 20 Jan 2021 19:11:21 +0000
Received: from DB8P189MB1046.EURP189.PROD.OUTLOOK.COM
 ([fe80::90c3:9e51:1c92:5464]) by DB8P189MB1046.EURP189.PROD.OUTLOOK.COM
 ([fe80::90c3:9e51:1c92:5464%7]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 19:11:21 +0000
From:   Harley Paterson <harley.paterson@hotmail.co.nz>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: False negative authentication with multiple accounts on a SSH-GIT
 server
Thread-Topic: False negative authentication with multiple accounts on a
 SSH-GIT server
Thread-Index: AQHW7iZGAHFuVSSO1Uqz0Q5kDb1cxqovlI6AgADisgCAAB+GgIAATJ+I
Date:   Wed, 20 Jan 2021 19:11:21 +0000
Message-ID: <DB8P189MB10465B7C7C89FDCD8F8C6155F9A20@DB8P189MB1046.EURP189.PROD.OUTLOOK.COM>
References: <DB8P189MB10460B9A3CA31ADF5C05A39FF9A30@DB8P189MB1046.EURP189.PROD.OUTLOOK.COM>
 <YAdnJabiJlu9Qlli@camp.crustytoothpaste.net>
 <87im7r93u7.fsf@evledraar.gmail.com>,<YAg/wV05JYbzOdck@coredump.intra.peff.net>
In-Reply-To: <YAg/wV05JYbzOdck@coredump.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:8A86D5E3BD23E6E6236B44C9D0AFF76FBDF8C6C2576C8964B09253162424C906;UpperCasedChecksum:5858774BE51379AAA8BAD0879F0949FB33952234581D04EA62F76DA0036D0B94;SizeAsReceived:7052;Count:44
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [F0sthKmG+NyQ8AtrJgj3yDG4lbfmzcXf]
x-ms-publictraffictype: Email
x-incomingheadercount: 44
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 77a7d7ce-ae78-4bfe-06b3-08d8bd772c51
x-ms-traffictypediagnostic: DB8EUR05HT185:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nAsJPH6OJYL5qOGS/XfuMThuYPihTc2sZkrNwS/JZQCJ+1sTEGJtoOIFlIXNXZDxWqLv7BdPZyAHF1MrmdFP6oV7PQE26Tzq8OGqRysVaOr99VC3n0dqOgDy28awqTm2whlBj4MhRZWl4g6xHD6C+R7W71B6wScehWg7TM985L3lEk/AwBYKnddmqtPN4yX4Jb5O4vf0j4vGaw0W2WuCNQthSKkk5mzmqCGqJ7g0CGADND7Q+E66EcsirkjHp7Xe
x-ms-exchange-antispam-messagedata: puNDhSkIxJRthkazzG/jnCuZKZYeGNZC39VF6LlTiwSgcUi/vh1vnGgFYOXq9lnPOaD0glZ5X+3VJPkMFIZJjIrF7+Z5Vj0PgOOlWWZFj8fhWkjI/A9keKVnhFOI2V0arqVoUdMn2k1gbeTgYNeJ3Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR05FT065.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a7d7ce-ae78-4bfe-06b3-08d8bd772c51
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 19:11:21.4384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8EUR05HT185
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Repost: Accedentialy forgot to CC this to the mailing list.

>> Unfortunately, this leaks whether a repository exists.  If Company XYZ
>> has a repository for each of its clients, it then becomes easy to see if
>> Company XYZ is doing work for a particular client by trying to see if a
>> repository exists.
> 
> I wonder how many hosting providers are confident that the code involved
> in this isn't vulnerable to a timing attack.
>
> I would say "not very certain" in the case of GitHub. I don't recall any
> analysis of the timing ever having happened.



I have to agree with this... It's certainly a risk, but if an attacker has enough
information to guess the repository names/URLs without triggering a rate
limiter, they already have a pretty good idea who Company XYZ is likely working
for, and what on.

HP.

