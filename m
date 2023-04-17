Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A167C77B72
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 12:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjDQMEZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 08:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjDQMEX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 08:04:23 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on0704.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1f::704])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787C959F9
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 05:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deichmann.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qg8Z5lH6zeKUyGGc8mnn5vigi5DZrb1rsWIEVPL6aIU=;
 b=l3dUF2fL1OYGY5FGoU90iTO5zFhhdtwTXiswoc9JW0MA2WBNifH/Ju/uo0Z313lg7ysHXnsDVn4zPy8Xi7JeNsqBgsGGLjNxeuRyV5LOaDKJeJ5XcmFswF3HednhSpgW7axd7p5mCa9qPlNzAOHrGllb1QdPis3W0USSEGshSZ8=
Received: from GV3P280CA0050.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::13) by
 PAVP194MB2037.EURP194.PROD.OUTLOOK.COM (2603:10a6:102:322::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.30; Mon, 17 Apr 2023 11:57:15 +0000
Received: from HE1EUR04FT013.eop-eur04.prod.protection.outlook.com
 (2603:10a6:150:9:cafe::6d) by GV3P280CA0050.outlook.office365.com
 (2603:10a6:150:9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.46 via Frontend
 Transport; Mon, 17 Apr 2023 11:57:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 104.40.229.156)
 smtp.mailfrom=deichmann.com; dkim=pass (signature was verified)
 header.d=deichmann.com;dmarc=pass action=none header.from=deichmann.com;
Received-SPF: Pass (protection.outlook.com: domain of deichmann.com designates
 104.40.229.156 as permitted sender) receiver=protection.outlook.com;
 client-ip=104.40.229.156; helo=eu1.smtp.exclaimer.net; pr=C
Received: from eu1.smtp.exclaimer.net (104.40.229.156) by
 HE1EUR04FT013.mail.protection.outlook.com (10.152.26.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.6319.19 via Frontend Transport; Mon, 17 Apr 2023 11:57:14 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (104.47.17.107)
         by eu1.smtp.exclaimer.net (104.40.229.156) with Exclaimer Signature Manager
         ESMTP Proxy eu1.smtp.exclaimer.net (tlsversion=TLS12,
         tlscipher=TLS_ECDHE_WITH_AES256_SHA384); Mon, 17 Apr 2023 11:57:14 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 6902382
X-ExclaimerImprintLatency: 2135876
X-ExclaimerImprintAction: 75543da0704944bebdf8ff868e44e9e3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcqtR0dO/pYDD68xmeBUf+fvtdH1kXC6SgpvnuDKfQyJZoJhPv3Z0UwMLg3gtgZ84/Q//mAl1cz0RjlWW1rzxdLA/0mlr39Tzy3O+uDyTiVswgMioCrDsyTsUPCYrqpx7kBh7ciKYqpG33eXsc2kAmqZLaDICrait1tp74y+b0DhjIyuQP6Tu1tfDyF9X+35LDzKPvKPOrwugPtn8gZJPwGscWX2q1qCtIF3qHouh2NufLSYvTg4Qxfn7Mcer170hdBulhONo4q9lU3LGvC2MFrpFbvOdNiofWDGxFKmw8LMtA7KtX2QAhcbWClM3GtBOdV7yeKMe7eN3JoORVbsMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qg8Z5lH6zeKUyGGc8mnn5vigi5DZrb1rsWIEVPL6aIU=;
 b=jTXP9fI/L4EQ/1+3yoaI+R3fWID60GHID2P7GCfRdKn8UsQIsVSRHtPqsjJdXkMf60xbOifwEjwUaqfQmHq0lGOPPhpCdSJhlw+xuxeCfH4JBz2MH63cqabqshSGbLDWecNbUcaneYmO0SGokTtw/mhyqRsj0tyxjHjNoSzkcY1bUWNoNBNoNexvVQFcB++Vbb/gaw7O3U3SyWH+OkoCDaWrP3NIz8a64uggxK9rdw9D3lv65TKeSkLRfx4Wx/l9xzL3HlI+d1wG2BWqnxGfxx1iNISpIMLy1aGpfI03ocEjOlGpKbu1rt6sWOPYRyMMTVqq42UBv5BE4DWN2rWNGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=deichmann.com; dmarc=pass action=none
 header.from=deichmann.com; dkim=pass header.d=deichmann.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deichmann.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qg8Z5lH6zeKUyGGc8mnn5vigi5DZrb1rsWIEVPL6aIU=;
 b=l3dUF2fL1OYGY5FGoU90iTO5zFhhdtwTXiswoc9JW0MA2WBNifH/Ju/uo0Z313lg7ysHXnsDVn4zPy8Xi7JeNsqBgsGGLjNxeuRyV5LOaDKJeJ5XcmFswF3HednhSpgW7axd7p5mCa9qPlNzAOHrGllb1QdPis3W0USSEGshSZ8=
Received: from AS8P194MB1575.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:372::8)
 by DU2P194MB1582.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:239::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 11:57:11 +0000
Received: from AS8P194MB1575.EURP194.PROD.OUTLOOK.COM
 ([fe80::b2ee:a527:333a:e615]) by AS8P194MB1575.EURP194.PROD.OUTLOOK.COM
 ([fe80::b2ee:a527:333a:e615%6]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 11:57:11 +0000
From:   =?utf-8?B?QmVyYXQgw5Z6ZGVtaXI=?= <Berat_Oezdemir@deichmann.com>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: AW: Bug/Weird behaviour with git pull
Thread-Topic: Bug/Weird behaviour with git pull
Thread-Index: AdlxEsp98ywESsSTQ8WqTPG1IA8Q/gAC77GAAAE0iqA=
Date:   Mon, 17 Apr 2023 11:57:11 +0000
Message-ID: <AS8P194MB1575BD2B73178D3CA0E7D35AE29C9@AS8P194MB1575.EURP194.PROD.OUTLOOK.COM>
References: <AS8P194MB1575B12A6A11E3CBC6537C26E29C9@AS8P194MB1575.EURP194.PROD.OUTLOOK.COM>
 <7a9bf99c-8a28-4842-ad65-97ce4a75e72f@app.fastmail.com>
In-Reply-To: <7a9bf99c-8a28-4842-ad65-97ce4a75e72f@app.fastmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=deichmann.com;
x-ms-traffictypediagnostic: AS8P194MB1575:EE_|DU2P194MB1582:EE_|HE1EUR04FT013:EE_|PAVP194MB2037:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a8e0f6f-440a-446d-c60f-08db3f3ae2c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: b5UCK1TJECyrD2WDAufYWdUpYGW7BNKi2B8hM9vomG/P6vyH72FH7FoP7q0VBtEBeTMZu4g1vlav1t8tKOnjXQPdb3FgqgsuN8ZfnHoA5c4CqVbYXTHggrGcJSz8CPMFstR1ytkSQtVHufqLCvDbyPUgYv8GHjKaI2FMXHZB74kOVtkHont3Z7x8biq6hupzpEdye0CwQz9rSUvbtOynEQZRl0xw4YVl61pz7ZaKwvkf0IPSAZL1FDdkON9ZIheyLP6l/FgPkc4W88KZFI2j2yqOy/v8Z4NJQNN5vnTaT89q0CR0gaG4tzjSURX5t9QL1+bp//KsniLeOz7FdPy18lw4ub9mkDJkTtwILnu0UZ4hFqrf0lOxj1eJuYSlh1dyihenOB6rKNyFHfGOL5BZDWvnDzfYuAHpC4dsj+GmKUa2luQ3VtzpEF1bRHr3j1Zt7SWJbuaMc2uD9TlLwLrGsicROyypQMrsfzYGN7pHue1PrUxAgeDGtrt12J1dC4mxO45TLDLRKHMP2BbMfl4u5nUdimL5uE45mFyJumfwpFwC4x0f3cxZqxrER5xUiVakq54tW7oWV+ofwMrTZWXkf36qd286e8+4Adk5UloVAmI=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:de;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P194MB1575.EURP194.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199021)(122000001)(38100700002)(2906002)(85202003)(15974865002)(38070700005)(33656002)(66899021)(55016003)(478600001)(71200400001)(7696005)(66574015)(26005)(6506007)(9686003)(186003)(86362001)(41300700001)(316002)(5660300002)(85182001)(8676002)(8936002)(52536014)(6916009)(66556008)(66476007)(66446008)(4326008)(64756008)(66946007)(76116006);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P194MB1582
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR04FT013.eop-eur04.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8c8e646b-73c8-47cf-b4e2-08db3f3ae08e
X-MS-Exchange-DSD: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ApJYbDTEyUjjoJERQAcDnKRe8k4hHN+g1IHf4GvTHus8AOOCXdtDrAlaBO4yhhxlPrtQ/vpYS9ZeWDWX+7j6pVPogSV20WFM5H+nSUNwr3Ha1pQnIuWiu9xi3cseGFmMXS13qL3VI7oddjS73kUQ3UzM/Uoo9p0DSoDxcJI8G09ZJazQrsQsrUMWyY5u+9nYzHXLOwb8yuuttFHZtnDVR3AjtgGkgOYPf3h4FRws3RoMdTUSrVNaM+Iby60bk7KScqU49PX8TRLdOKCK9akfbU4+GcyikyRCRBZT2NJeqHc78/Ebrqgp61y9katPGFWK1p4bN/yETYTkzY52cqDaTZ46Y2KU4ydnxDKgIdc9SIv8bD1CwVGbxLF+Yoc6bAzEHY41QYqJICOXOsjPQtsR2xGAUuIAKMuD1we20SDAYApkMyhgfxpzIeN8rJMucn4fk30cFhXOcl+OKSRkLdI7YKXmHOfwbYeHHgc7q7HVEqhh0hBZKrH4bEQZb9nt/nJ7WCryjMN78iDMarfCKLxaJe/tdDRP9Fxqahdp75VaI791xCLZsSoGpmAa8SXkb/0uNgtB56lmZjG90OlC8zX7CU28eTj6VTfw6NMG3VE6e8M1X1GcW8/h/UdWMibYfQpsm+An+z6YrBFBSc/oqdrLCYHbq3CbkMJuNK1myI8GFnqLpL1BHNyTMzRpZc1tdOyu
X-Forefront-Antispam-Report: CIP:104.40.229.156;CTRY:NL;LANG:de;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu1.smtp.exclaimer.net;PTR:eu1.smtp.exclaimer.net;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199021)(46966006)(36840700001)(40470700004)(2906002)(8936002)(85202003)(85182001)(8676002)(70206006)(5660300002)(66899021)(52536014)(70586007)(478600001)(41300700001)(40460700003)(316002)(40480700001)(82740400003)(7596003)(55016003)(15974865002)(33656002)(336012)(4326008)(6916009)(86362001)(6506007)(186003)(7696005)(26005)(9686003)(36860700001)(356005)(47076005)(7636003)(82310400005)(66574015);DIR:OUT;SFP:1102;
X-OriginatorOrg: deichmann.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 11:57:14.4728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8e0f6f-440a-446d-c60f-08db3f3ae2c5
X-MS-Exchange-CrossTenant-Id: 577d96da-adf0-4fa5-a756-7b3cd3e267fd
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=577d96da-adf0-4fa5-a756-7b3cd3e267fd;Ip=[104.40.229.156];Helo=[eu1.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR04FT013.eop-eur04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVP194MB2037
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGVsbG8sIA0KDQpUaGFuayB5b3UgZm9yIHRoZSBxdWljayByZXNwb25zZSENCg0KVGhlIG9ubHkg
cHVsbCByZWxldmFudCBjb25maWcgSSBjYW4gZmluZCBpcyANCg0KJCBnaXQgY29uZmlnIC0tZ2V0
LXJlZ2V4cCBwdWxsDQpwdWxsLnJlYmFzZSBmYWxzZQ0KDQoNCk1pdCBmcmV1bmRsaWNoZW4gR3LD
vMOfZW4NCuKAi0tpbmQgcmVnYXJkcw0KQmVyYXQgw5Z6ZGVtaXINCklUIFNvZnR3YXJlIEVudHdp
Y2tsdW5nDQpQaG9uZTorNDkgMjAxIDg2NzYgIDE0NDAyDQpCZXJhdF9PZXpkZW1pckBkZWljaG1h
bm4uY29tDQp3d3cuZGVpY2htYW5uLmNvbQ0K4oCLRGVpY2htYW5uIFNFLCBEZWljaG1hbm53ZWcg
OSwgRC00NTM1OSBFc3Nlbg0KIA0KU2l0eiBkZXIgR2VzZWxsc2NoYWZ0OiBFc3NlbiwgUmVnaXN0
ZXJnZXJpY2h0IEVzc2VuIEhSQiAyMTAyMCwgVVN0Li1JRC1Oci46IERFIDExOSA2NjMgNDAyDQpW
b3JzaXR6ZW5kZXIgZGVzIFZlcndhbHR1bmdzcmF0cyB1bmQgZGVyIGdlc2Now6RmdHNmw7xocmVu
ZGVuIERpcmVrdG9yZW46IEhlaW5yaWNoIE90dG8gRGVpY2htYW5uDQpHZXNjaMOkZnRzZsO8aHJl
bmRlIERpcmVrdG9yZW46DQpBbGV4YW5kZXIgQmVsbGluICogU2FtdWVsIERlaWNobWFubiAqIE1h
cnRpbiBGaXNjaGVyICogRHIuIExhcnMgSmVuZHJpYW4gKiBNYW5mcmVkIEtyb25lZGVyDQotLS0t
LVVyc3Byw7xuZ2xpY2hlIE5hY2hyaWNodC0tLS0tDQpWb246IEtyaXN0b2ZmZXIgSGF1Z3NiYWtr
IDxjb2RlQGtoYXVnc2Jha2submFtZT4gDQpHZXNlbmRldDogTW9udGFnLCAxNy4gQXByaWwgMjAy
MyAxMzoyMA0KQW46IEJlcmF0IMOWemRlbWlyIDxCZXJhdF9PZXpkZW1pckBkZWljaG1hbm4uY29t
Pg0KQ2M6IGdpdEB2Z2VyLmtlcm5lbC5vcmcNCkJldHJlZmY6IFJlOiBCdWcvV2VpcmQgYmVoYXZp
b3VyIHdpdGggZ2l0IHB1bGwNCg0KRVhURVJORSBFLU1BSUw6DQpLbGlja2VuIFNpZSBrZWluZSBM
aW5rcyB1bmQgw7ZmZm5lbiBTaWUga2VpbmUgQXR0YWNobWVudHMsIGVzIHNlaSBkZW5uIFNpZSBr
ZW5uZW4gZGVuIEFic2VuZGVyIHVuZCB2ZXJ0cmF1ZW4gZGVuIEluaGFsdGVuLg0KDQpFWFRFUk5B
TCBFTUFJTDoNCkRvIG5vdCBjbGljayBhbnkgbGlua3Mgb3Igb3BlbiBhbnkgYXR0YWNobWVudHMg
dW5sZXNzIHlvdSB0cnVzdCB0aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUu
DQoNCkhpDQoNCk9uIE1vbiwgQXByIDE3LCAyMDIzLCBhdCAxMjozNCwgQmVyYXQgw5Z6ZGVtaXIg
d3JvdGU6DQo+IEhpIHRoZXJlLA0KDQpXaGF0IGRvZXMgeW91ciBHaXQgY29uZmlnIGZvciBgcHVs
bGAgbG9vayBsaWtlPw0KDQotLSANCktyaXN0b2ZmZXIgSGF1Z3NiYWtrDQo=
