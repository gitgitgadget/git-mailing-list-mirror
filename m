Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0076FC4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 12:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAA3D23443
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 12:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgLRMb4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 07:31:56 -0500
Received: from pa-mailgate2.prudential.com ([12.42.50.176]:26696 "EHLO
        pa-mailgate2.prudential.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725903AbgLRMb4 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 18 Dec 2020 07:31:56 -0500
X-Greylist: delayed 547 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Dec 2020 07:31:55 EST
IronPort-SDR: bXvLsYL7Nlp1fvn/cxPvJi12oWrsWG66BBiDLKvROe3b+7h1QzNwSFtvS8PFPiteAr/Yw5z2IL
 fYfMyqmqsRrA==
Received: from p2erscba1086.prudential.com (HELO ironportpaprod2.prudential.com) ([161.151.153.22])
  by ironportpaprod2.prudential.com with ESMTP; 18 Dec 2020 07:22:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qmaw.com; i=@qmaw.com; q=dns/txt; s=20200731;
  t=1608294127; x=1639830127;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=A1iDR9sSl4P93tDle5IRw/kRl+XVSEZA7qLpuzP9ROQ=;
  b=R0JZ3+a2bpXV8h1kxtncL4L2vwYL7Nh9v0dOoHTjOHXIxm4VoZvWctF9
   9u6EBY2TVdIZUqPfde+Z6bwwnmt0OnavXJVaq38MmT0FdScnFDgMoztAN
   Y/ATOnFUyqNJtkVwltuDvY412WZ2kCYWNS9GNGXftQkM6Q6TdEQCrVVph
   HoGaDg14qCTo7Zu7NfWk0Et6SxhRhSTUmXlc4vZMS1f3COaVIdo6O80tW
   XgOUZY+PaUqoEAUopIK8+HLpPFnGCUqhrvxFPMtEHWEDKwTQHDa5/xKep
   I7NcTu4KN7HHvh/cohBsVWeUAsBRvIRbLqaiK3PxXTLKfc/+gMYt1IDg+
   Q==;
IronPort-SDR: qT/oylugQlF+2Ym4kG+DZRDCu+D8KKgrBRWG9qNhELXkv7lQ7dwpwZlO3LWKuIphfTrWJ4F1dJ
 ckBnsqRj9goA==
Received: from NAM11-DM6-obe.outbound.protection.outlook.com ([48.96.18.187])
          by njros1ngw23.prudential.com (IBM Domino Release 9.0.1FP8 HF450)
          with ESMTP id 2020121807220574-729312 ;
          Fri, 18 Dec 2020 07:22:05 -0500 
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvCIE2upOGIgoCQI3R6n6sCDb2HpaYOBUl6SaMr+f0v+ZrIHLwbB3X+LehvgK8eyaWpC61oPfA8jq7zeyQlquO2FkxTtdcIvWIHTy+o43g7Khu4FCKzcJe1WwlWZ3hhe/JVw5HV5dv9RjRgcbohHQ8R29W+oeeaFiX3/kfYfsvQea1OZ2JDCBKz4A4ptQm7fWshsnHtSqk6t5p8jZfprmtkKThZbWhm+vmaVBLEfo2VEkNcl8v8LL189Ev1Eil1Ic+TYGqVH0RUx1t1MAG66OaN7ir+jN4lqYoVJai2KkAjJOc1EeY50l8JqK3J3cTtEP+UrV5PofCK+qNY0vGpsAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1iDR9sSl4P93tDle5IRw/kRl+XVSEZA7qLpuzP9ROQ=;
 b=cesCHcBslwwedOteRUBv5LEKK6a9PYBvHmoZhpAs5BKyhB3a+2nc/q+/zbJC6wZURhRLUAr+HLQYIblu9xLJNSmSq6oaAi/h/qQ6nYIHEnt32gtWGKI6B5fGENql1Pau4lLJn+vziY+qk56o1fmQ1QPhTcClOx7271gw5nStv0RcBQZ22JAaGujZPul3xsYsoL40XrO731Hsmv7mwq2txHNqhqTawp6IM1rFLwowKkGW8xyKZ+IcNDuV/uDAZ8TiL7nLCZkhdUG9BwDWMSypxFyGaxyoWVAdyDppBexqTH/vfbaVC0P3BafCYO3CNAcdDfCm2NFaZtvWPSsMIChOFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qmaw.com; dmarc=pass action=none header.from=qmaw.com;
 dkim=pass header.d=qmaw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prudentialus.onmicrosoft.com; s=selector1-prudentialus-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1iDR9sSl4P93tDle5IRw/kRl+XVSEZA7qLpuzP9ROQ=;
 b=Spr20jYRTCW2zsmEFrrQb7pwS0rYY2mHpXLCsZNhJsJ4Xqw7U51v2DCa5xyNMF1falh+ZZFrlzzaifrn2B5OsRbZIaeEOtN61OHDE2zEnZfOt15BgxjC8/Lbd2sghvzr4/CGCoddGss3Eh4nZGpEHA7q5DkGEnys3jKP/sup5DQ=
Received: from PH0PR11MB4887.namprd11.prod.outlook.com (2603:10b6:510:30::18)
 by PH0PR11MB4933.namprd11.prod.outlook.com (2603:10b6:510:33::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13; Fri, 18 Dec
 2020 12:22:04 +0000
Received: from PH0PR11MB4887.namprd11.prod.outlook.com
 ([fe80::c848:ea0:68ec:9e4d]) by PH0PR11MB4887.namprd11.prod.outlook.com
 ([fe80::c848:ea0:68ec:9e4d%6]) with mapi id 15.20.3654.020; Fri, 18 Dec 2020
 12:22:04 +0000
From:   Ed Avis <ed.avis@qmaw.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Feature request: 'git bisect run' option to redundantly check start
 and end commits
Thread-Topic: Feature request: 'git bisect run' option to redundantly check
 start and end commits
Thread-Index: AQHW1TUxba6WMMXzoEiRVvxIrsQ8Qw==
Date:   Fri, 18 Dec 2020 12:22:04 +0000
Message-ID: <PH0PR11MB48875130A7DF30A7394DD3619DC30@PH0PR11MB4887.namprd11.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=qmaw.com;
x-originating-ip: [2a0c:5a84:3409:fc00:a1b1:7235:4d58:4ae7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49655f0b-83bb-47bc-f9db-08d8a34f87bd
x-ms-traffictypediagnostic: PH0PR11MB4933:
x-microsoft-antispam-prvs: <PH0PR11MB49333872FDFFC36FD57F09EC9DC30@PH0PR11MB4933.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nUNNM5HJhNETg8rDOhTLJh1sSJcZzrN0EQSlZ5Hpd8gJOa8OfsNJdBhgy9l6+eGaEuaPupjr0zIqy7ezRYHfrSjAdqN8G8+4BUV3HonUrfCctvDCTMfxErDm+t8Ck81GzG4iDP7WfnUa2RwPK6jnz8y0FmiqotRvoCZias24ynt1AUL+9YYe3D1vaC5PFgArMmersTtyjBBLKto4lZGUH8hcf4vIxEcsQbfO5UqMNVay/syuEf0i8EB2xINoIeuT9Tm8JIYXZCEIqRZOMJ5LQhEcsS+DK4NcSClOAT6cUK53j4u3iZuCpTKZmQzTf3HhLAIGh7SC+pq8QkL+8KwH4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4887.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(76116006)(91956017)(7696005)(52536014)(6916009)(2906002)(66476007)(5660300002)(66946007)(6506007)(66556008)(66446008)(64756008)(44832011)(83380400001)(478600001)(55016002)(186003)(9686003)(33656002)(71200400001)(8676002)(86362001)(316002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cHhOY1V5ZTdtUlVoVlUvbzd2ZVVqQWZ2c0djbTRKd3JvbXA4Njc0ZVJucGNF?=
 =?utf-8?B?em1UbUpOekFXcjRWSFJuanpQTkdsS2RvNUQvZUZHTWV6VDJHMFFFb2l3b05r?=
 =?utf-8?B?aXZseHloSkEvUjMvRHJLVnRjNFo4am5kNVlMYU1FQTgzOGg0bWxuZCs2Z09l?=
 =?utf-8?B?N3NkNTROWENlRlJLK2x0ek5wRGgwblE3akoyTEhUUnc3Q2lOQUk5b2tmRCtr?=
 =?utf-8?B?T1VqNTU4bmJHZTU1Y2ZPNWNkSHhZT3RoT0pBamhhZFJ6d0ZXVWV5RmR4VDBr?=
 =?utf-8?B?Y0ZIemZvbUFrTlQxWFZmbjg4a2w0WEJFL1ZkdzBiUlN6VGsvK1AyeTZOTWY1?=
 =?utf-8?B?eHNWZ1BMd3JUWld1TCtZNDJNV2R5Vk16akJEWERHMFhzSGRuWXdDTXZWNVdR?=
 =?utf-8?B?VG5kckZyS0JydE9HbEc5SUNhd1FFQjNaQ2ZsTGdjS1BJVnhaM1FySHVueDlz?=
 =?utf-8?B?QmhTWUM5OFFxZFdtbS9Sb1Z2d2VXUXFCcldsWjBibllBQk15T3NCTG90MzRH?=
 =?utf-8?B?ODFwQjhlWUp4MjBTTGZ5b1g1TzBDUFhWLzRHTldBaXl4MDIyS01UQzdlVFdG?=
 =?utf-8?B?RzU3RjhONEd6T1hrSkU3VTJIMEJCNzUxVzF3Zk9zS2pVT1owQzc3dUxtTEhH?=
 =?utf-8?B?d3hXR0NNcStKQ0NNSS9TVnR6dUw4OFV4c01KKzRJd0VMSXBsR0twbG5jb0Ro?=
 =?utf-8?B?ejFRZWRySHdDOC91d2ZObnFXNUFtMllMbEhPVTJ0Mi9EQkZQUWFjVE9QeDhj?=
 =?utf-8?B?UW9CSkxaWHhjL2x5TXpsWDNwQndLNGJNcCtZYnZNSXVvUlRmd3VlWlpVR2tB?=
 =?utf-8?B?KzNHZ3dEb3d1Y1BGY1pIZ2FIVDB4cllYOWNBWERZanZLUUNMcmFXZ1IxbTlM?=
 =?utf-8?B?N3hETElVNkI5OFBXUmViUEQrM0RKNURkZEh0QVl6UllyZFJlYkJXWlFUQTBS?=
 =?utf-8?B?a0dvTm4vZTVGRjIrL2NTVG5kUENRTFYxMFV4UForbkVqUkNVaEwvdVp5NFNC?=
 =?utf-8?B?M2h0TmZuK2hHcitoSWN4dThhRGk5VWVzU1JDMmwrZVV2ajBNQU9iZ3RxMm5h?=
 =?utf-8?B?Ung1cW5YN2plSUpiV1pGaTI5R0dyMzZvZGRRZjNyTkJKeUFEV3VpK3ZzelJD?=
 =?utf-8?B?aU1xL0twZmhtTjgxN1VST1A0SFROd0hVM0xCdGtUajZOY1QwbUZxVUVvWVRJ?=
 =?utf-8?B?Z1NIaEFvK3dHNjFpUFgwVTltVGQyZmRUc0ZnOE55MzdqSXhNQWkxRXBQd0Zl?=
 =?utf-8?B?NnJmMmRxcFRqNTRzZUxJY2RSREVEbmIvOWsrZk1CcHBFREpOVmRCTXVDWDJq?=
 =?utf-8?B?QTlDaU5IS2JDMzJ1NVB3ZTVOdVJCY05MVVdFdGI2KzJWb1JqWWV5R1N5M3Jy?=
 =?utf-8?Q?aSVUzUGYh9v3NL4VVLBqvocCL5hxA3LA=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: qmaw.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4887.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49655f0b-83bb-47bc-f9db-08d8a34f87bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2020 12:22:04.7137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d8fde2f5-9392-4260-8a03-0ad01f4746e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rl5XzZE53x4wfazVRmDHS5Ygr2HPYSXxEt51Lr132bUmc/zkmGc1H6xSwauzBW3IqdRPdiWf+VofmrurFWDloA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4933
X-MIMETrack: Itemize by SMTP Server on NJROS1NGW23/SERVER/Prudential(Release 9.0.1FP8
 HF450|June 28, 2017) at 12/18/2020 07:22:05 AM,
        Serialize by Router on NJROS1NGW23/SERVER/Prudential(Release 9.0.1FP8 HF450|June
 28, 2017) at 12/18/2020 07:22:06 AM,
        Serialize complete at 12/18/2020 07:22:06 AM
X-TNEFEvaluated: 1
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

V2hlbiBraWNraW5nIG9mZiBhICdnaXQgYmlzZWN0IHJ1bicsIEkgaGF2ZSBtYW51YWxseSBjaG9z
ZW4gZ29vZCBhbmQgYmFkIGNvbW1pdHMsIGJ1dCBJIHdvdWxkIGxpa2UgdG8gZG91YmxlIGNoZWNr
IHRoYXQgdGhlIGNvbW1hbmQgZ2l2ZW4gdG8gcnVuIHJlYWxseSBkb2VzIHN1Y2NlZWQgZm9yIHRo
ZSBnb29kIGNvbW1pdCBhbmQgZmFpbCBmb3IgdGhlIGJhZCBvbmUuICBPZiBjb3Vyc2UgSSBjYW4g
c3dpdGNoIHRvIHRob3NlIGNvbW1pdHMgYW5kIHJ1biBpdCBtYW51YWxseSwgYnV0IG1pc3Rha2Vz
IGNhbiBoYXBwZW4uICBJdCdzIGZydXN0cmF0aW5nIHRvIHNldCB1cCBhIGJpc2VjdGlvbiBhbmQg
dGhlbiBmaW5kIGF0IHRoZSBlbmQgdGhhdCB0aGUgZmlyc3QgYmFkIGNvbW1pdCBpcyB0aGUgb25l
IGltbWVkaWF0ZWx5IGFmdGVyICdnb29kJywgYmVjYXVzZSB0aGUgY29tbWFuZCBzdHJpbmcganVz
dCBmYWlsZWQgZXZlcnkgdGltZS4gIEFuIG9wdGlvbmFsIHN0YXJ0dXAgY2hlY2sgb2YgdGhlIHR3
byBlbmRwb2ludHMgd291bGQgb25seSBiZSBhIHNtYWxsIHNsb3dkb3duIGluIG1vc3QgY2FzZXMs
IGJ1dCBjb3VsZCBzYXZlIGEgbG90IG9mIHRpbWUuDQoNCiUgZ2l0IGJpc2VjdCBzdGFydA0KJSBn
aXQgYmlzZWN0IGdvb2QgYWJjZGUNCiUgZ2l0IGJpc2VjdCBiYWQgYmNkZWYNCiUgZ2l0IGJpc2Vj
dCBydW4gLS1jaGVjay1lbmRwb2ludHMgbXkgZ25hcmx5IGNvbW1hbmQNCkNoZWNraW5nIGluaXRp
YWwgJ2JhZCcgY29tbWl0IGJjZGVmDQpydW5uaW5nIG15IGduYXJseSBjb21tYW5kDQpjb21tYW5k
IGZhaWxzLCBhcyBleHBlY3RlZA0KQ2hlY2tpbmcgaW5pdGlhbCAnZ29vZCcgY29tbWl0IGFiY2Rl
DQpydW5uaW5nIG15IGduYXJseSBjb21tYW5kDQpFcnJvcjogdGhlIGNvbW1hbmQgZmFpbHMgZm9y
IHRoZSBpbml0aWFsICdnb29kJyBjb21taXQNCg0KSSB0aGluayB0aGF0IGl0IHNob3VsZCBjaGVj
ayB0aGUgJ2JhZCcgY29tbWl0IGZpcnN0LCBvbiB0aGUgYXNzdW1wdGlvbiB0aGF0IGEgZmFpbGlu
ZyBjb21tYW5kIHVzdWFsbHkgZmluaXNoZXMgcXVpY2tlciB0aGFuIGEgc3VjY2Vzc2Z1bCBvbmUu
DQoNCihJbiBteSBjYXNlLCB3aGF0IHdlbnQgd3JvbmcgaXMgdGhhdCBJIGhhZCBwdXQgcXVvdGF0
aW9uIG1hcmtzIGFyb3VuZCAnbXkgZ25hcmx5IGNvbW1hbmQnIHdoZW4gcGFzc2luZyBpdCBvbiB0
aGUgY29tbWFuZCBsaW5lLiAgSSB3YXMgdGhpbmtpbmcgb2YgZ2l0IHJlYmFzZSAtLWV4ZWMsIHdo
aWNoIHJlcXVpcmVzIGEgc2luZ2xlIHF1b3RlZCBhcmd1bWVudCBmb3IgdGhlIGNvbW1hbmQgdG8g
cnVuLCB3aGVyZWFzIGdpdCBiaXNlY3QgcnVuIHRha2VzIGl0IGFzIHNlcGFyYXRlIHdvcmRzLiAg
SSB0aGluayB0aGF0IGFuIG9wdGlvbiB0byByZWNoZWNrIHRoZSB0d28gZW5kcG9pbnRzIGJlZm9y
ZSBzdGFydGluZyB0aGUgYmlzZWN0aW9uIHdvdWxkIGJlIGEgdXNlZnVsIGlkaW90LXByb29maW5n
IGFuZCBtYWtlIGdpdCBiaXNlY3QgYSBuaWNlciB0b29sLiAgSWYgbm90aGluZyBlbHNlLCBpdCdz
IGdvb2QgdG8gYmUgcmVhc3N1cmVkIHRoYXQgdGhlIGNvbW1hbmQgeW91IGdhdmUgd29ya3MsIHNp
bmNlIHdoZW4gZGVidWdnaW5nIGFuIHVuZXhwbGFpbmVkIHByb2JsZW0sIHlvdSBjYW4gc3RhcnQg
dG8gZG91YnQgdGhlc2UgdGhpbmdzLi4uKQ0KDQotLQ0KRWQgQXZpcyA8ZWQuYXZpc0BxbWF3LmNv
bT4NClBsZWFzZSBpZ25vcmUgYW55IGNvbmZpZGVudGlhbGl0eSBzdHVmZiBiZWxvdyB0aGlzIHBv
aW50Lg0KDQpUaGlzIGVtYWlsIGFuZCBhbnkgZmlsZXMgdHJhbnNtaXR0ZWQgd2l0aCBpdCBhcmUg
Q09ORklERU5USUFMIGFuZCBhcmUgaW50ZW5kZWQgc29sZWx5IGZvciB0aGUgdXNlIG9mIHRoZSBp
bmRpdmlkdWFsKHMpIG9yIGVudGl0eSB0byB3aG9tIHRoZXkgYXJlIGFkZHJlc3NlZC4gQW55IHVu
YXV0aG9yaXplZCBjb3B5aW5nLCBkaXNjbG9zdXJlIG9yIGRpc3RyaWJ1dGlvbiBvZiB0aGUgbWF0
ZXJpYWwgd2l0aGluIHRoaXMgZW1haWwgaXMgc3RyaWN0bHkgZm9yYmlkZGVuLiBBbnkgdmlld3Mg
b3Igb3BpbmlvbnMgcHJlc2VudGVkIHdpdGhpbiB0aGlzIGVtYWlsIGFyZSBzb2xlbHkgdGhvc2Ug
b2YgdGhlIGF1dGhvciBhbmQgZG8gbm90IG5lY2Vzc2FyaWx5IHJlcHJlc2VudCB0aG9zZSBvZiBR
TUEgV2FkaHdhbmkgTExQIChRTUFXKSB1bmxlc3Mgb3RoZXJ3aXNlIHNwZWNpZmljYWxseSBzdGF0
ZWQuIEFuIGVsZWN0cm9uaWMgbWVzc2FnZSBpcyBub3QgYmluZGluZyBvbiBpdHMgc2VuZGVyLiBB
bnkgbWVzc2FnZSByZWZlcnJpbmcgdG8gYSBiaW5kaW5nIGFncmVlbWVudCBtdXN0IGJlIGNvbmZp
cm1lZCBpbiB3cml0aW5nIGFuZCBkdWx5IHNpZ25lZC4gSWYgeW91IGhhdmUgcmVjZWl2ZWQgdGhp
cyBlbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFu
ZCBkZWxldGUgdGhlIG9yaWdpbmFsLiBUZWxlcGhvbmUsIGVsZWN0cm9uaWMgYW5kIG90aGVyIGNv
bW11bmljYXRpb25zIGFuZCBjb252ZXJzYXRpb25zIHdpdGggUU1BVyBhbmQvb3IgaXRzIGFzc29j
aWF0ZWQgcGVyc29ucyBtYXkgYmUgcmVjb3JkZWQgYW5kIHJldGFpbmVkLiBRTUFXIGlzIGF1dGhv
cml6ZWQgYW5kIHJlZ3VsYXRlZCBieSB0aGUgRmluYW5jaWFsIENvbmR1Y3QgQXV0aG9yaXR5LiBR
TUFXIChyZWdpc3RlcmVkIGluIEVuZ2xhbmQgTm8uIE9DMzAzMTY4KSBoYXMgaXRzIHJlZ2lzdGVy
ZWQgb2ZmaWNlIGF0IDl0aCBGbG9vciBPcmlvbiBIb3VzZSwgNSBVcHBlciBTdCBNYXJ0aW4ncyBM
YW5lLCBMb25kb24sIFdDMkggOUVBLg0KDQpQbGVhc2Ugbm90ZSB0aGF0IHlvdXIgcGVyc29uYWwg
aW5mb3JtYXRpb24gbWF5IGJlIHN0b3JlZCBhbmQgcHJvY2Vzc2VkIGluIGFueSBjb3VudHJ5IHdo
ZXJlIHdlIGhhdmUgZmFjaWxpdGllcyBvciBpbiB3aGljaCB3ZSBlbmdhZ2Ugc2VydmljZSBwcm92
aWRlcnMuIElmIHlvdSBwcm92aWRlIHBlcnNvbmFsIGluZm9ybWF0aW9uIHRvIHVzIGJ5IGVtYWls
IG9yIG90aGVyd2lzZSwgeW91IGNvbnNlbnQgdG8gdGhlIHRyYW5zZmVyIG9mIHRoYXQgaW5mb3Jt
YXRpb24gdG8gY291bnRyaWVzIG91dHNpZGUgb2YgeW91ciBjb3VudHJ5IG9mIHJlc2lkZW5jZSBh
bmQgdGhlc2UgY291bnRyaWVzIG1heSBoYXZlIGRpZmZlcmVudCBkYXRhIHByb3RlY3Rpb24gcnVs
ZXMgdGhhbiB5b3VyIGNvdW50cnku4oCZDQoNClRvIGxlYXJuIGFib3V0IG91ciBwcml2YWN5IHBv
bGljaWVzLCBwbGVhc2UgdXNlIHRoaXMgbGluazxodHRwczovL3d3dy5wZ2ltLmNvbS9kaXNjbGFp
bWVyL3ByaXZhY3ktY2VudGVyPiB0byByZWFkIHRoZSBQR0lNIFByaXZhY3kgTm90aWNlLg0K
