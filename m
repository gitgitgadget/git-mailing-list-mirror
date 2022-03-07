Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC36C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 22:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343702AbiCGWcD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 17:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236396AbiCGWb7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 17:31:59 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A50B65815
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 14:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646692264; x=1678228264;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eoqvzbYNpyih6bWP4hwjzzc0GK5G7GjAmsx5beERhEg=;
  b=TQTkvarbwp+vk2TDWMiaDEV4qO4v79rhATwCBxiFMF0Okw0ssHtenyuL
   /xFUZ2ZJcU85thhIQVaiQLoAlb++4HugTOKu3GRr2zJB3IzWpTT4wYfJ/
   QGQ/ZYr6Xl73BriwvkDXsBClOsJ7BdRYvdI2sDDI5WyabCuKxFmNAHtXZ
   Ooj4bqzuXINXTuTmmZwz0RzbssX+Dj5CXlzwRCJu6mMcA/XBFCBDBdqDr
   8/MDCMRCxu4LIB9lsyYplEzh1WsrQrWLQ2T8PLl0Hr3coVHc3hldi7qlD
   aM+YTc/PhGLx4OxezpuVz1uh23JBo2+1YnYviGOS9vRdmGrp1+XtryiUc
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="254252531"
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="254252531"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 14:31:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="537301744"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga007.jf.intel.com with ESMTP; 07 Mar 2022 14:31:03 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Mar 2022 14:30:59 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Mon, 7 Mar 2022 14:30:59 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Mon, 7 Mar 2022 14:30:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBjpYdykbZO+8ueLmhyMlZPCb1pzaR83jMzc+d1jF+6+QvgSXe5+H75TPFXUiYiPWbhhMutIeSk9izJ70uWT5xcYknEcCckITAUvV/X5FegAt6kV3MQnTO1U+QeyQez3lFhV7B5/GwrERJH4gXYldKLz/P1ZpGVNpuSTwBl6MgT0Neobhdy113miRf0Po67vKGa5LEfiezZeB6It6bx40C81IDqsj061IHcBtdjG8W2/sQVyXw7l983zjTXn7RgjFdfeSSR+6uj4iPcs1KTYSKCTAhvP1eeXsE3LnYUALsAc8c8jhk1dSK3GclMiZz9AdsJavKERQz7TnRzTHYYc9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eoqvzbYNpyih6bWP4hwjzzc0GK5G7GjAmsx5beERhEg=;
 b=ees/nhnbQU64NpDOglX/UscivWEw3CF581wcn/TvKYdW59wHNyBbS2SCXQ5YqyI374GZ0GnHSmRpYMRSk+tdUwdZjFnkIT2nTegdHe/pKHsE4gGWaE5+x+yaN34uzwZhvxTV0voPOuRXt6uD90k6jP93F8GkCe9rJAQNUGEQLnKRgqRuaD7UYflCl889CoXH711i0Mk8K/e1HwDj7t5vopCb6Xucj1HJA2WgtzvGXfnImDxBnguYP2DR/YCP5xnFkxRwaL3sBXhALUn1BpMErQzUna/gstBwRuiV8M/D3T8YaCcq2kMzb8Mi729GBS8xFQoWhyMzcf3k1gt7WTZ37Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BYAPR11MB2679.namprd11.prod.outlook.com (2603:10b6:a02:c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Mon, 7 Mar
 2022 22:30:55 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::bd9e:6244:4757:615a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::bd9e:6244:4757:615a%9]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 22:30:55 +0000
From:   "Keller, Jacob E" <jacob.e.keller@intel.com>
To:     Derrick Stolee <derrickstolee@github.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
CC:     Git mailing list <git@vger.kernel.org>
Subject: RE: [PATCH] name-rev: use generation numbers if available
Thread-Topic: [PATCH] name-rev: use generation numbers if available
Thread-Index: AQHYLO0/kx7y23fqQU2fGaub7n7TLayp0IwVgABL24CAAAc+aoAAfzoAgABO6ICAAAE/AIAAB3t0gAAjEQCAAb+bDYAHizmAgAABAwCAACJfEA==
Date:   Mon, 7 Mar 2022 22:30:55 +0000
Message-ID: <CO1PR11MB508949A91933E83A6BE1194FD6089@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20220228215025.325904-1-jacob.e.keller@intel.com>
 <20220228215025.325904-3-jacob.e.keller@intel.com>
 <xmqqpmn6wg98.fsf@gitster.g>
 <CA+P7+xoECs-rXb4vpRrw40Q-oRvfu97kMig9zu0rEE6KagAyiw@mail.gmail.com>
 <xmqqfso2t9cu.fsf@gitster.g>
 <6b00c67b-01c9-bf22-a8e6-904f47fa7acf@github.com>
 <f5ca62f4-eb3d-eeb7-e7c8-7fb800f3d6cd@intel.com>
 <3c3e6063-7eb4-7ff4-3a1b-a07db1fe969f@github.com>
 <xmqqfso1pgmv.fsf@gitster.g>
 <CO1PR11MB5089DC997DB42023324F1BF0D6029@CO1PR11MB5089.namprd11.prod.outlook.com>
 <xmqqilsvet82.fsf@gitster.g>
 <CA+P7+xo=UwUQ422o36_8XGNWoYjROGi5wBT4=jy4ThJBs_z=Xw@mail.gmail.com>
 <39f08f98-be0f-bba7-c41a-1c9eb6182a67@github.com>
In-Reply-To: <39f08f98-be0f-bba7-c41a-1c9eb6182a67@github.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7bcb7c1-0d8d-43be-b5a2-08da008a2520
x-ms-traffictypediagnostic: BYAPR11MB2679:EE_
x-microsoft-antispam-prvs: <BYAPR11MB26799B3651B675121212FB1DD6089@BYAPR11MB2679.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1AZOFbF3LsN3BZ76BO8RFHpZUtuQpGlKJz2KEV03DWTxAuoTQG8MyCJOiQR1rsUHlvp7JmvZH51coZ87Qn0FusR9wzt7vAuQ3lGdD/7Mpxyp2HKNfE4VNU/LZpvqQQllXpsWbyo0dHKAhp8ZZd9C7LItaFpJZqwNUqVhYzyJ4KgE10oLRuGtOyjwydBOmheRg9TqWycLcaUEP6rc536cgnkkAstqw1qugtb1/h97HyCsplaGLoipx9ruH0T0TxWcv66/+NM2IDbY+xYbv2WVDWQKAEGXegUqrNibQGYpzpNNvxWSVRyH39rO4h3yFoA5x1vdSroD1vvdWz/VIM9GApgthPm5a11FXU5PYP1xEDmwGdPKvgWttdYl/vPr0CPBeYGCCBgTk6BL8At/K2mIV/yVYp0vfgtN87K46QL1uVmczKdVjakcxR1nx9wlNKkbU2uIrRj1KN+zuSe0aQ6nMA69KXzPLOEojnRsW8ZQ1SktR57zWsZHO50WNylqguyQP4v8sPlxJYCDSyGX8J6k0jrbAhiVnolg0cf/cxeyfOwIRKhsvMDZysDllUWkZtO2NC3HeaULzGyXZImaDdIKhxQkqcVIFQrXyYKouQJlmY8eJJN20Okk8SB3G/69auedKB77/+Nc9PHCHwG3klqw1BO/JxnNgZEEdUlAcRD92FtULPYRd5CbW7sTFkbYsReI2oEqyTTSf94TFC0pytR63iJi1H1DyQ96oQdTGA8hbGTeH9cVXReiBBhvOVuhj2peAXAY/HOwmCJ2COdFipThJD9Ab5g3dqEOyZJc2+iYugo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(4326008)(52536014)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(33656002)(186003)(2906002)(316002)(8936002)(110136005)(38100700002)(122000001)(38070700005)(86362001)(966005)(508600001)(55016003)(82960400001)(71200400001)(53546011)(9686003)(6506007)(7696005)(83380400001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZCtGREs5QWFWdDRmTk1yQmlZWUFuKzFhcTFtR3dLQU1NUkkwSDFTTi9CbU9B?=
 =?utf-8?B?YjE3UWRHRTMyenN1QmJWMzNmU3ZseUxZcHFyMGNick5zZ3JzeDZBU2FOV3Np?=
 =?utf-8?B?b2VjV0JCeVNBek4vWmFqcjdzdk9YZkdBdGUwTmltZDcyWXE1aTA3WFhaWExB?=
 =?utf-8?B?QUh4VjhZNlRtY3Z0KzZWU1dGbXNIUGUzdkk4Q1BzSkhZS29rOVUvVU5uakdu?=
 =?utf-8?B?dlpzNnAzdTRPSlhRU3AzNFpFOHdUOTVicThhOERHN1k5SmFHZjJXWkJ3TUN6?=
 =?utf-8?B?QzRSWFVUUUNiT1JkRDdBcFYrNjNKeTNNZTJFeG50WHVkOVJlMGY5V1ZJQU9T?=
 =?utf-8?B?bTl2ZkttbHhuTXlRaDRJN0hidDF6S2dmQnZJclFNSnlhaElyWG5NazJsbCth?=
 =?utf-8?B?V3h5cHJBanI5UVJZbk52czc0ZUlEV042a3YvZ3lDWkZsVUJ3RFFuTzFHeXdu?=
 =?utf-8?B?dXV1THdFM0VmSnAzZlkrNXpINktRcWpFSlNGYkNjMXQvZTM1MWNWMDVsRHdh?=
 =?utf-8?B?Lzc2THowTllDYWlhTUFlbHhaSEhKdnZnY3lwUmY2SFBYNE5Lc3hVOUtEOCtZ?=
 =?utf-8?B?VGlDUS9mQmt4M09hTEJ1VjVXMm03ME5qeFh5cjN6Q01JeWdkVkV1enJwaXlt?=
 =?utf-8?B?ZDBnQmx0UGZ0dEVKODY3Wlh3SDl2eHFIL2dEUkhxbjZJVmxWZGFwWER6bk14?=
 =?utf-8?B?dVpHL2hHM1N3NTFRZzNVSUp5bDNhMFQwNi9URlR0OU41b0tZYkxGOEtFcXZa?=
 =?utf-8?B?VWpnTUNWREQxZ3FVUTAzRnlBaWRhUlg4MlBNQlVuRFRlR1k2cjVGdkZOOGJR?=
 =?utf-8?B?SncxQi9PcW1UbFl5M0U4a1hldFVLcURPLzUxTWZLc3NtamRINDhOMmwrVmQr?=
 =?utf-8?B?UENoUkdIRDNLNDRNS3ZlQ0x3aUZiTUpRYWM5d3BacmNSc0tyUmxRdFlrd3Ji?=
 =?utf-8?B?RXpBMUZoeEk5R05GdTJoQ0p5N1NxamM1WGZ3MGxYTEdaTUwyVWtERlVTVWR2?=
 =?utf-8?B?eGU4cmFjTzA1VXNqME9xU2tMMnZQY09sU04vVStkUDMrenVEbTk4M3A4TGFk?=
 =?utf-8?B?MDhEb2VGVytFR0pYOHpESWQyYU92eVA4c1JkZXJGWitCWmJUKzlsTi9UdmNv?=
 =?utf-8?B?MFo4ZlZOdnhHZUIzRnQyK2thdGdST0Q0c0dJNHJuM1JlZVZJK04ya2UraFlm?=
 =?utf-8?B?R1hMNmJYYlNDQWZRZHRSdVY5Uy91OEE0Yk9ZYTczQ2FyQ3RLWTZaTWwwS2hB?=
 =?utf-8?B?THhrWmtId2I5RkNTZnRPR3c3U00yUEZVREJHb3N2WVc0bnZYNlZuRDZBMUNp?=
 =?utf-8?B?SWxIWS9id1JnS0VIKzM4cFllQWFOYzhRdVB5enJ5bis3MmI0clhqaWNHbTVU?=
 =?utf-8?B?alRkVjNYZVRqV0R4cnFINGFSdmtmMUtDT0gyWjlxWE01b3p6cDdob1BXY0Vl?=
 =?utf-8?B?SEsybUI3M1VyZGNubTJGK2FKMFhDOWsvdWRzbXZXc0FkaDBNTTFsVVhlZG9n?=
 =?utf-8?B?VXBmY09RWkZmdFhSNm9kU08wYUpJTG1BUWZXcGRGemd4UFZxa2VwTHhyWVVN?=
 =?utf-8?B?MTloejJUejB2cGovMzNrWnA1ZmdhOFh3UFhRNkJYa21oZGh2UENTTkdMbHRO?=
 =?utf-8?B?MHBydHZ3Q0VUNUN5WCtBVC81VnlnQzVkNjlsb296Y1REMjdaVVdEU1JEb3A0?=
 =?utf-8?B?Rlp2M082dDJPaVBlU0tNcUlvQ3lVZGREcWJVSXJyWnErTlJ6TlI0V0lCQmdK?=
 =?utf-8?B?TVdWejh0QTkvcjlpeWVDNitpQUtCK3RZQlJlOEdYMGVaLzAxMWdoYlkzd1Nx?=
 =?utf-8?B?NlA1eGppQVl1WmVLR3BhdHA1dE1zTzZQNUNZUStCdWFsTEx5SVl6bGlPSjhi?=
 =?utf-8?B?aGFKcmcxb2xoWWFQRThCVTM5elRoQWNSSHhnS0lBMGNnc0Z6TzZSTmk4OWFm?=
 =?utf-8?B?aTF5b2JvWXhpTzFTeWtZcnpTQmE5L2tFdFlhSFlRaXE5ZnoyVG9DUG5UUXFr?=
 =?utf-8?B?ekpPUnJ4cU9zYlJ1ZVR1ZzBqUjYyTmdkWlYyZUs5aGVKcC93WURhVmgwQms1?=
 =?utf-8?B?TEZNQzRoVDdsaDh2b0EwcXNXT0dJdU9hMloxN3Vlc3JPT3NrZnBWaXFTU0RN?=
 =?utf-8?B?V0NiOElxSjgzbVdFR1JXS3ZvbC9xU09PdDhnZDkweHB4UmprNVJNQnBrRE5I?=
 =?utf-8?B?NXNRb3RHL2RTZFp0RlFnWWRoWDRBUUNWSkp3czVFcWRKckFRMFA0UlZEVTJB?=
 =?utf-8?B?R0tpeE93K0hjN1JmR2YydUNBTW5RPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7bcb7c1-0d8d-43be-b5a2-08da008a2520
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 22:30:55.3484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ykKLDLmyyuzXfZvRQQifNbr2XcD/juD9oxwtCxs0GB86L8JCwrzFeUQzg0O+H5AA9NZFah/saoL6yqcWUCzobSt813c9jRK/BQXqrOpCP50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2679
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGVycmljayBTdG9sZWUg
PGRlcnJpY2tzdG9sZWVAZ2l0aHViLmNvbT4NCj4gU2VudDogTW9uZGF5LCBNYXJjaCAwNywgMjAy
MiAxMjoyNyBQTQ0KPiBUbzogSmFjb2IgS2VsbGVyIDxqYWNvYi5rZWxsZXJAZ21haWwuY29tPjsg
SnVuaW8gQyBIYW1hbm8NCj4gPGdpdHN0ZXJAcG9ib3guY29tPg0KPiBDYzogS2VsbGVyLCBKYWNv
YiBFIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+OyBHaXQgbWFpbGluZyBsaXN0DQo+IDxnaXRA
dmdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBuYW1lLXJldjogdXNlIGdl
bmVyYXRpb24gbnVtYmVycyBpZiBhdmFpbGFibGUNCj4gDQo+IE9uIDMvNy8yMDIyIDM6MjIgUE0s
IEphY29iIEtlbGxlciB3cm90ZToNCj4gPiBPbiBXZWQsIE1hciAyLCAyMDIyIGF0IDU6MTAgUE0g
SnVuaW8gQyBIYW1hbm8gPGdpdHN0ZXJAcG9ib3guY29tPiB3cm90ZToNCj4gPj4NCj4gPj4gIktl
bGxlciwgSmFjb2IgRSIgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT4gd3JpdGVzOg0KPiA+Pg0K
PiA+Pj4gTGV0J3MgY2xhcmlmeS4gVGhlcmUgYXJlIHR3byB2ZXJzaW9ucyBvZiB0aGUgdGVzdCBp
biB0aGlzIHZlcnNpb246DQo+ID4+Pg0KPiA+Pj4gMSkgdGVzdCB3aGljaCBlbmFibGVzIGNvbW1p
dCBncmFwaCBhbmQgdGVzdHMgdGhhdCBpdCBkb2VzIHRoZSByaWdodCBiZWhhdmlvci4NCj4gPj4+
DQo+ID4+PiAyKSB0ZXN0IHdoaWNoIHJlbW92ZXMgY29tbWl0IGdyYXBoIGFuZCB0ZXN0cyB0aGF0
IGl0IGJlaGF2ZXMgdGhlIG9sZCB3YXkuDQo+ID4+Pg0KPiA+Pj4NCj4gPj4+IHRlc3QgKDEpIGNo
ZWNrcyB0aGUgZmxvdyB3aXRoIHRoZSBjb21taXQgZ3JhcGggZW5hYmxlZCwgYW5kIHZlcmlmaWVz
IHRoYXQgd2l0aA0KPiBhIGNvbW1pdCBncmFwaCB0aGUgbmV3IGJlaGF2aW9yIGlzIHVzZWQuIFRo
aXMgdGVzdCB3aWxsIGZhaWwgaWYgeW91IHJldmVydCB0aGUNCj4gbmFtZS1yZXYgY29tbWl0LWdy
YXBoIHN1cHBvcnQuDQo+ID4+Pg0KPiA+Pj4gdGVzdCAoMikgYWx3YXlzIHBlcmZvcm1zIHRoZSB3
YXkgd2UgZG9uJ3QgbGlrZS4gKHNpbmNlIHdlIGRpc2FibGUgdGhlIGNvbW1pdA0KPiBncmFwaCBh
bmQgdGhlIG5ldyBmbG93IGRvZXNuJ3Qga2ljayBpbikgVGhpcyBpcyB0aGUgdGVzdCBJIHRoaW5r
IEkgd2lsbCBlbGltaW5hdGUgaW4NCj4gdGhlIG5leHQgcmV2aXNpb24uDQo+ID4+Pg0KPiA+Pj4N
Cj4gPj4+IEkgd2lsbCByZW1vdmUgdGhlIDJuZCB0ZXN0LCBzaW5jZSB0aGUgZmlyc3QgdGVzdCBj
b3ZlcnMgdGhlIGNoYW5nZQ0KPiA+Pj4gaW4gYmVoYXZpb3IganVzdCBmaW5lLCBhbmQgSSB0aGlu
ayBJIGFncmVlIHdlIGRvbid0IG5lZWQgdG8gc2V0DQo+ID4+PiBpbi1zdG9uZSB0aGUgaW1wbGVt
ZW50YXRpb24gd2l0aG91dCBjb21taXQgZ3JhcGguDQo+ID4+Pg0KPiA+Pj4gSSB3aWxsIGFsc28g
bG9vayBhdCBhZGRpbmcgYSB0ZXN0IHdoaWNoIHBlcmZvcm1zIGEgY291bnQgb2Ygd2hpY2gNCj4g
Pj4+IHJldmlzaW9ucyBnZXQgaW5zcGVjdGVkIGFuZCBtYWtlcyBzdXJlIHRoYXQgd2UgYWN0dWFs
bHkgYXJlIGRvaW5nDQo+ID4+PiB0aGUgb3B0aW1pemF0aW9uLg0KPiA+Pg0KPiA+PiBTb3VuZHMg
bGlrZSBhIHNlbnNpYmxlIHRoaW5nIHRvIGRvLg0KPiA+Pg0KPiA+PiBJbiBhbnkgY2FzZSwgaW4g
dGhlIGN1cnJlbnQgcGF0Y2gsICMyIGlzIG5vdCB3b3JraW5nIGluDQo+ID4+IGxpbnV4LVRFU1Qt
dmFycyBqb2IgYXQgQ0kuICBZb3UgY2FuIHZpc2l0IHRoaXMgVVJMDQo+ID4+DQo+ID4+DQo+IGh0
dHBzOi8vZ2l0aHViLmNvbS9naXQvZ2l0L3J1bnMvNTQwMDA0ODczMj9jaGVja19zdWl0ZV9mb2N1
cz10cnVlI3N0ZXA6NDo2ODANCj4gNjINCj4gPj4NCj4gPj4gd2hpbGUgbG9nZ2VkIGludG8geW91
ciBHaXRIdWIgYWNjb3VudCBmb3IgZGV0YWlscy4NCj4gPg0KPiA+IExvb2tzIGxpa2UgdGhpcyBq
b2Igc2V0cyBhbGwgdGhlIFRFU1QgdmFyaWFibGVzIGluY2x1ZGluZw0KPiA+IEdJVF9URVNUX0NP
TU1JVF9HUkFQSD0xPyBUaGUgbmVnYXRpdmUgdGVzdCBwYXNzZXMgYmVjYXVzZSB0aGUgY29tbWl0
DQo+ID4gZ3JhcGggaXMgZW5mb3JjZWQgb24gYW5kIHdlIHRoZW4gc3VjY2VlZCBldmVuIHRob3Vn
aCB3ZSB3ZXJlIHRyeWluZyB0bw0KPiA+IHRlc3QgdGhlIG5lZ2F0aXZlIGNhc2UuDQo+ID4NCj4g
PiBJJ20gZ29pbmcgdG8gcmVtb3ZlIHRoYXQgdGVzdCBpbiB2MyBhbnl3YXlzLCBzbyBJIGRvbid0
IHRoaW5rIGl0IGlzIGENCj4gPiBiaWcgZGVhbC4gSG93ZXZlciwgSSB3b25kZXIgaXMgdGhlcmUg
c29tZSB3YXkgdG8gbWFyayBhIHRlc3QgYXMNCj4gPiBleHBsaWNpdGVseSAiZG9uJ3QgcnVuIGlm
IEdJVF9URVNUX0NPTU1JVF9HUkFQSCBpcyBzZXQiPw0KPiANCj4gVHlwaWNhbGx5LCB3ZSB0cnkg
dG8ga2VlcCB0aGVtIGNvbXBhdGlibGUgaW4gYm90aCBjYXNlcy4gSG93ZXZlciwNCj4geW91IGNh
biBzZXQgR0lUX1RFU1RfQ09NTUlUX0dSQVBIPTAgZm9yIHRoZSB0ZXN0LCBpZiB5b3Ugd2FudC4g
QmUNCj4gY2FyZWZ1bCB0byBvbmx5IGNoYW5nZSBpdCBsb2NhbGx5IHRvIHRoZSBzaW5nbGUgdGVz
dCwgbm90ICJnbG9iYWxseSINCj4gdG8gdGhlIGZ1bGwgdGVzdCBzY3JpcHQuDQo+IA0KPiBUaGFu
a3MsDQo+IC1TdG9sZWUNCg0KT2suIFRoZSBwcm9ibGVtIGlzIHRoYXQgc3BlY2lmaWMgdGVzdCBk
b2VzIG5vdCBiZWhhdmUgdGhlIHNhbWUuIEluIGZhY3QgaXQgKmNhbm5vdCogYmVoYXZlIHRoZSBz
YW1lIGJlY2F1c2Ugd2UncmUgdHJ5aW5nIHRvIHRlc3QgdGhlIG5vbi1jb21taXQtZ3JhcGggZmxv
dyB0aGVyZS4gU2luY2UgaSdtIGRyb3BwaW5nIGl0IGluIHYzIEkgd29uJ3Qgd29ycnkgdG9vIG11
Y2ggYWJvdXQgaXQuDQoNClRoYW5rcywNCkpha2UNCg==
