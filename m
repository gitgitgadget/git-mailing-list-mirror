Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C955C433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 20:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiB1UVA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 15:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiB1UU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 15:20:56 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE95854186
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 12:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646079616; x=1677615616;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3uBChjW+v/6hFMvEkqKd4s/X2WuQbb3KuNrUEOdrxwQ=;
  b=L79M/Y3aqc4mp+FL5e3He6HxDR4VrvNaA6KfZrik7ppHakgDexMpZDpL
   0m4r3bb9xg3WD5AkXwNi+8zC+eMVHBnZJHhfXsom/DSiQ0uCxjDN20PuH
   O+6hPqORt3mzfDvlXrIs8wr6UK/JveLg8NWMWwCaWCH5GK2pBkrx3hCE8
   +WMd7NOpu8NlIWaGcrLEKsRHZYts7H9yt1z16SCqoc04DaSOe1dP18EmY
   fIaCyCTVCDQiEkK2w1TB3h1drvnNxnwnSQGSbZUaawcX5DG0Qe+Y/Dh3Z
   5J/qvwG7SHM7WleC3TvBaUILIwCaY1wfwPe9V+t73edtO4IxVgaSRaVwC
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="252905748"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="252905748"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 12:20:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="685466769"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2022 12:20:15 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 12:20:15 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Mon, 28 Feb 2022 12:20:15 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 28 Feb 2022 12:20:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWgi0CoiC6KFLkb2N9FJZ5b9Xx8E0ItBFM6ea6BFdfE8o2tCBkJ8TMk5+zM492F8bxxqRsyHQUaCkIMbU9s7Q9jgERIC/qw/2QnzOrANtFNfEo4+xAf+rN0PVcfFdTqouRdTlGN9KsRdoHo2JoXhWr+DiWQXfaeeAt0D5zunEA/MWd9UagFdPPYZBKlYdPo0CY0oYy41YhHmQtC9d47+yDWCme+6pELAFr832/0mzMQk3DjDtFyLfs2Q1EREROANE78Ku5jdNbpStPgspEeFNF4q+LDGC5luZAQt4UfX21mXEd+t6gPz33alJq/HyOAgkTIy1DXjNSD+KY2p71gsEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3uBChjW+v/6hFMvEkqKd4s/X2WuQbb3KuNrUEOdrxwQ=;
 b=enSAWa16Ub+F2oMtpGILmucbabKxlrmHaUDurfQNlsqyodhw/0YUSrzGxoH7gXXbPurFzk1Xwc8FhBRkwYYWhUJ0o1sBlWx165At5Z/HIAwvCrHXWBvsf8PevMYmwVXHT0ODwJ7LbsLYodGBIImhvYnu1VuO+ytO09Y+y8ChOmuYgIHOqBBTERvmDaln3wYFu7MBeaT4uQsTR0oG1ChzNYCw0/iHhwosSBDY0zapjtDkPm2YvNxoKXe/xnQMrYCVBlEilR1BLYPfWGPIfJwUQ4S+MjRTGQyP7+uHx7/syhfFYUdijhJG4Inj7DFwU6sf7Ud6+zKy3iDlH3j9xv6Kxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB5661.namprd11.prod.outlook.com (2603:10b6:a03:3b9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Mon, 28 Feb
 2022 20:20:12 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::bd9e:6244:4757:615a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::bd9e:6244:4757:615a%8]) with mapi id 15.20.5017.027; Mon, 28 Feb 2022
 20:20:12 +0000
From:   "Keller, Jacob E" <jacob.e.keller@intel.com>
To:     Derrick Stolee <derrickstolee@github.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] name-rev: use generation numbers if available
Thread-Topic: [PATCH] name-rev: use generation numbers if available
Thread-Index: AQHYLNaLAupeX18OMUy98LsJRMPl56ypX1GAgAAIK4A=
Date:   Mon, 28 Feb 2022 20:20:12 +0000
Message-ID: <15ce47f3-a726-75d1-3d3d-869331b24230@intel.com>
References: <20220228190738.2112503-1-jacob.e.keller@intel.com>
 <e4096124-e566-0842-f17c-366645c3e37c@github.com>
In-Reply-To: <e4096124-e566-0842-f17c-366645c3e37c@github.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3e6fd92-aece-406d-2bad-08d9faf7b967
x-ms-traffictypediagnostic: SJ0PR11MB5661:EE_
x-microsoft-antispam-prvs: <SJ0PR11MB56619ECFC7099C82E20C6109D6019@SJ0PR11MB5661.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H34I1JHe4Z+IVgnVQhgj0ArNd6/s3BANAgjE1L5dhltRA0xI9KqhCkEvo9u1qOYZcLU9AYc4eVfn//w95FNZoTKAWKN0a3fjeR7+dgiK/JiwdhjYP+89qXo+1blQ3MOfyAT83yQJhnWczE3HMtR+Mtmn/EKW4Gr+5Eoie1c7owXHITF86OKo/uHv76oN75G6BWUJ3Imv+FO24xLLpckXsgbmRl5P6+K8qi6CKWlHj3DfJiyj8YsabdhrrCi/7MmBdnjIC4YmokC04dri1Xa1AB4bTq6sg4RTdidTjPOB/7MjmUNdh57nz3o3sdrxsms47KiHBHxRb/XL3JiU+qW2ksVqEWlYMY3xc9S7LOmWmTwAKLasLmq3xYgV2hK3dZi1s9P8HZaslmhSMI6Cl9573jSTVaWrdsCCfcxQcuJVPxUnnz9oIlpA6d2bX/zrgz63G7C2obBXr6Xkaq1YVBdXm5XSbjcA6T8Yk9x6ChbmGbOxRjmC361MuA2uVvwO+l2hTriZ3O9dzGeDr/E5BGjBoZzMhF3gVUtMFGHMISim/MGBacni/0XXjhKH6NdoTKcWbNILg+74VHciUkEe+YKs5qXlCFGlhSkKqE/cc1N4913LCMDCxvApXJmTWUst23/P5lVQcsfqnAWc7fygPVmEoBkCZ9Rije9tESZxNYe32G8g0MARRtr2F1uWynQyQxAw6UFnRyUk5VITOFEBROkAmrleZiWvFWDO45R4AiPUBs9OtF3R0EG5hYu781sSHiRDkHCi7C5izianq6PvYeLh453vqDKlJmr5B5+zsEE2MUQ6amDNvhqaYdPnufdQO1v7Nk68rW7J+YtfTrs+v3h6xwqD8UVLm4PIDS4i8eqdoh0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(66556008)(76116006)(8936002)(8676002)(64756008)(4326008)(5660300002)(66446008)(66946007)(66476007)(6486002)(316002)(2906002)(36756003)(508600001)(54906003)(110136005)(966005)(6506007)(53546011)(2616005)(26005)(83380400001)(31696002)(86362001)(6512007)(38100700002)(186003)(82960400001)(122000001)(38070700005)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWpJNVVRbHF3Z0xDSlVTa1JPa2dFdGN5ZHdZMkFmRkhTcTc3c2U1bkZub1VZ?=
 =?utf-8?B?RXVhTDNhU3lnZ0VmUit5bHljZzBmUHZjeis0U3hHY1NEMTNRSzJtQW1xVzJ6?=
 =?utf-8?B?Q0hLNzBlUGJUa3lNa2xoTTY2MWlvK1Nhb0M2akUydzhCWkFYTmYvNkJqcjNT?=
 =?utf-8?B?TTdpVnV5VXNNTkl5QUJPMXlYeEdleUM2elZ5N2laaUdKc2pWMjZqejBySitP?=
 =?utf-8?B?QUt0VlM1UWw0OGdQSUNFdTVWYzJvL1dsSmVoMU5jZksrbExjejFoMWE2WG5y?=
 =?utf-8?B?aHFzSFdDRW5hVnFnZ1ZXRWZ4eHB6bURHNlZ2WDJPaFRqYnk2dW9VV2cvajk2?=
 =?utf-8?B?RTdaS055K1BpcytvRk5UbVhlWmN1MjkrYnFFd21tbDRqVi9xbmVBQlRTWHk5?=
 =?utf-8?B?QXBoMUlYQmQwdXZEaWNTbmNIc29QekdReFYwcHhhMDZyL3dXeS9WaTdRblJU?=
 =?utf-8?B?VEdQL2srVUtwbk1JTkRja2o3ZkdZdHFVOEJoMEU4ZzlWeS85K1d1VE9KRHE5?=
 =?utf-8?B?clFsTzlIdGNtV3Y4VHNEWXFwU3ozT3NKRFdFMkRtbXhSNnVqcXFvSyszU3Qz?=
 =?utf-8?B?S3JqbEtOUGVNQ0ZESW1LVjM1QlNnRDdCZGdjd3VxV25nRGZRZm43dUxzdEd6?=
 =?utf-8?B?STgwQkRUN0poV1NqNzB3Tm0wWWRzeFlDUDBlN3QxMWlsZnE3MDRNS1R5alJD?=
 =?utf-8?B?NWtSMXNNOFhRSXJYRmNsS3hibXY0cXkvYlovajBiaVBoUTVsNVB5QzBBRHVv?=
 =?utf-8?B?QnJJNHNSR0lGZ3E3YVd6bVpOTUh4NnVjbDBHVWlGeEx1dkNJbzdEMlc3TjJG?=
 =?utf-8?B?SGd5NnVuN0NTTDhJenlheTNLY1VqdVFCR0d0QjdZUVBKVlpPbkZNR1hBTHV3?=
 =?utf-8?B?U2ViNUU0Q3E0clJ0OEE2MU1jNVlLOGhaeG5YZHJ0TEp4a1paZ1JBQVY3bmo5?=
 =?utf-8?B?OHFLMXlNVUFpZXZIWnhkd0k4SWwwcDR5VjVPZEpRRzlFV2t4dVhZNnk3OUtE?=
 =?utf-8?B?VHJJNjFiZjFQTEY2NktGQlRCVTFxSU9XQWJNek5GOEdTT0YxelV0Q2wybXJi?=
 =?utf-8?B?Vmh4RGNqRW5UNjgxWm1IWWhGY2lGZkZNZTQ3Y2wxWGY2TkFyaG41UXROOEFN?=
 =?utf-8?B?Ukg3ek1UN0ZuZmIrSjZJOEo2R0hmbHFUbWhiOG0ybEtJWnErZDN5RzhKa2k3?=
 =?utf-8?B?VWpmc3VVU1pMRUxlSUxwVXBJcVdCMmRyY0VFQ0g1eFdaNERjZ1EwNDVDRFdR?=
 =?utf-8?B?NmRiL0RRdGNGZ3o5NzcvU3dFMnJoYnZveGpNZ2NpTUlLL3ZpVmROZmxMOHdJ?=
 =?utf-8?B?bDdNYWVhajhOMFZvWi9ZeXFqRDVwSUJqMTVteDZ4RWlPWnR6QmdhSUEwWlUv?=
 =?utf-8?B?YXdPUmhsVk9jek53RktoRy9kaTI2dlFNUjJVekUxcml6dUNGRjl1SjBGTmJn?=
 =?utf-8?B?WEQxR3BHL2FNRnYzL1AzN0wyUTBBMU9qZ3JjRjdpdDAveFJ1SFQvK3NXejFC?=
 =?utf-8?B?RiszZXZrL29LVlRSbDhtUlJNS1d5NEp1UzM5eDZMeTdNZUhzRmJybmQyR3Jk?=
 =?utf-8?B?YXZqUWdDbHVWYm1Ja1pWamoybkVvYUlTY3pHT0RDWHpDUEZNZkQ1UEs0V3Q1?=
 =?utf-8?B?UWtYQ1Fpd3FzaTlmSjFhOGhTbWsyVzkwYXRTRk1FQmt6QXQxM21YbloyMGxw?=
 =?utf-8?B?K1ZJcmRPWDVaK2xreTRmSS9SWk90ZlZVM0lIdWg5aVN6d2tkdFVQRkNoWUxv?=
 =?utf-8?B?bFltNXR1ZFpGbjY3Y2RkWTRKbHRVK09ta3FVVko0THloRlROQ0wxSUxYRDNH?=
 =?utf-8?B?TmlXdTF6aEN6ejBsRk9Vb1VKSGd3N3cyL2Mwc0UzdldsQ0d2S2tCTGpOYVha?=
 =?utf-8?B?VnJZc3A2TmhVcmQ0NlozdCtCc3Z4OHpSYS9qbFhMdXZscXdzaE9PaURDdndV?=
 =?utf-8?B?VGhSR3hXNFFDbGxvd2Z3OHN3bjN0cTdyU1ZwK0UvUGZuOHhCWW5KbnphZ1Bj?=
 =?utf-8?B?SlVrdGFjYVBjOERaclc2dUFDdmxEL3dUSVRCTy9TOEQ0VWRwUFNsMHprdy9L?=
 =?utf-8?B?OEFCL3BaSkYwMk9MWnlVMGtaWGtTdU5LQ1VLVEpYMDRNMEJtQ2doR0JYbWxX?=
 =?utf-8?B?dDVJZVVCVjBURDR2QnR4c3IwbGFUc0krSDhjTDE3ZE55VHhSd2pncExLSVBr?=
 =?utf-8?Q?gwEQInLvNjFLoUO2BuXPnd2jAGZxk4+CGF5ZkwrJh0VF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7EE8A9AE9371F4EA40F6904CF42678C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e6fd92-aece-406d-2bad-08d9faf7b967
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 20:20:12.3423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: znr31jaustEYtLCuXNIw7d1s23VP3Uyo10UjPlzj5EenfdBUZLK/qsA18MKy0Zi6b5N3AFpqCU0TLaWHSUzWgUCWQEdPDFefSPr7N64Jubo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5661
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

T24gMi8yOC8yMDIyIDExOjUwIEFNLCBEZXJyaWNrIFN0b2xlZSB3cm90ZToNCj4gT24gMi8yOC8y
MDIyIDI6MDcgUE0sIEphY29iIEtlbGxlciB3cm90ZToNCj4+IEZyb206IEphY29iIEtlbGxlciA8
amFjb2Iua2VsbGVyQGdtYWlsLmNvbT4NCj4+DQo+PiBJZiBhIGNvbW1pdCBpbiBhIHNlcXVlbmNl
IG9mIGxpbmVhciBoaXN0b3J5IGhhcyBhIG5vbi1tb25vdG9uaWNhbGx5DQo+PiBpbmNyZWFzaW5n
IGNvbW1pdCB0aW1lc3RhbXAsIGdpdCBuYW1lLXJldiBtaWdodCBub3QgcHJvcGVybHkgbmFtZSB0
aGUNCj4+IGNvbW1pdC4NCj4+DQo+PiBUaGlzIG9jY3VycyBiZWNhdXNlIG5hbWUtcmV2IHVzZXMg
YSBoZXVyaXN0aWMgb2YgdGhlIGNvbW1pdCBkYXRlIHRvDQo+PiBhdm9pZCBzZWFyY2hpbmcgZG93
biB0YWdzIHdoaWNoIGxlYWQgdG8gY29tbWl0cyB0aGF0IGFyZSBvbGRlciB0aGFuIHRoZQ0KPj4g
bmFtZWQgY29tbWl0LiBUaGlzIGlzIGludGVuZGVkIHRvIGF2b2lkIHdvcmsgb24gbGFyZ2VyIHJl
cG9zaXRvcmllcy4NCj4+DQo+PiBUaGlzIGhldXJpc3RpYyBpbXBhY3RzIGdpdCBuYW1lLXJldiwg
YW5kIGJ5IGV4dGVuc2lvbiBnaXQgZGVzY3JpYmUNCj4+IC0tY29udGFpbnMgd2hpY2ggaXMgYnVp
bHQgb24gdG9wIG9mIG5hbWUtcmV2Lg0KPj4NCj4+IEZ1cnRoZXIgbW9yZSwgaWYgLS1hbm5vdGF0
ZS1zdGRpbiBpcyB1c2VkLCB0aGUgaGV1cmlzdGljIGlzIG5vdCBlbmFibGVkDQo+PiBiZWNhdXNl
IHRoZSBmdWxsIGhpc3RvcnkgaGFzIHRvIGJlIGFuYWx5emVkIGFueXdheXMuIFRoaXMgcmVzdWx0
cyBpbg0KPj4gc29tZSBjb25mdXNpb24gaWYgYSB1c2VyIHNlZXMgdGhhdCAtLWFubm90YXRlLXN0
ZGluIHdvcmtzIGJ1dCBhIG5vcm1hbA0KPj4gbmFtZS1yZXYgZG9lcyBub3QuDQo+Pg0KPj4gSWYg
dGhlIHJlcG9zaXRvcnkgaGFzIGEgY29tbWl0IGdyYXBoLCB3ZSBjYW4gdXNlIHRoZSBnZW5lcmF0
aW9uIG51bWJlcnMNCj4+IGluc3RlYWQgb2YgdXNpbmcgdGhlIGNvbW1pdCBkYXRlcy4gVGhpcyBp
cyBlc3NlbnRpYWxseSB0aGUgc2FtZSBjaGVjaw0KPj4gZXhjZXB0IHRoYXQgZ2VuZXJhdGlvbiBu
dW1iZXJzIG1ha2UgaXQgZXhhY3QsIHdoZXJlIHRoZSBjb21taXQgZGF0ZQ0KPj4gaGV1cmlzdGlj
IGNvdWxkIGJlIGluY29ycmVjdCBkdWUgdG8gY2xvY2sgZXJyb3JzLg0KPj4NCj4+IEFkZCBhIHRl
c3QgY2FzZSB3aGljaCBjb3ZlcnMgdGhpcyBiZWhhdmlvciBhbmQgc2hvd3MgaG93IHRoZSBjb21t
aXQNCj4+IGdyYXBoIG1ha2VzIHRoZSBuYW1lLXJldiBwcm9jZXNzIHdvcmsuDQo+Pg0KPj4gU2ln
bmVkLW9mZi1ieTogSmFjb2IgS2VsbGVyIDxqYWNvYi5rZWxsZXJAZ21haWwuY29tPg0KPj4gLS0t
DQo+PiBUaGUgaW5pdGlhbCBpbXBsZW1lbnRhdGlvbiBvZiB0aGlzIGNhbWUgZnJvbSBbMV0uIFNo
b3VsZCB0aGlzIGhhdmUgU3RvbGVlJ3MNCj4+IHNpZ24tb2ZmPw0KPj4NCj4+IFsxXTogaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvZ2l0LzQyZDJhOWZlLWEzZjItZjg0MS1kY2QxLTI3YTA0NDA1MjFi
NkBnaXRodWIuY29tLw0KPiANCj4gSSB0aGluayB5b3VyIGltcGxlbWVudGF0aW9uIGlzIHN1ZmZp
Y2llbnRseSBkaWZmZXJlbnQgKGFuZCBiZXR0ZXIpDQo+IHRoYXQgeW91IGRvbid0IG5lZWQgbXkg
Y28tYXV0aG9yc2hpcCBfb3JfIHNpZ24tb2ZmLg0KPiANCg0KQWxyaWdodC4NCg0KPj4gK3N0YXRp
YyB2b2lkIHNldF9jb21taXRfY3V0b2ZmKHN0cnVjdCBjb21taXQgKmNvbW1pdCkNCj4+ICt7DQo+
PiArCXRpbWVzdGFtcF90IGdlbmVyYXRpb247DQo+PiArDQo+PiArCWlmIChjdXRvZmYgPiBjb21t
aXQtPmRhdGUpDQo+PiArCQljdXRvZmYgPSBjb21taXQtPmRhdGU7DQo+PiArDQo+PiArCWdlbmVy
YXRpb24gPSBjb21taXRfZ3JhcGhfZ2VuZXJhdGlvbihjb21taXQpOw0KPj4gKwlpZiAoZ2VuZXJh
dGlvbl9jdXRvZmYgPiBnZW5lcmF0aW9uKQ0KPj4gKwkJZ2VuZXJhdGlvbl9jdXRvZmYgPSBnZW5l
cmF0aW9uOw0KPj4gK30NCj4gDQo+IEkgYXBwcmVjaWF0ZSB0aGF0IHlvdSBzcGxpdCB0aGlzIG91
dCBpbnRvIGl0cyBvd24gbWV0aG9kIHRvIGlzb2xhdGUNCj4gdGhlIGxvZ2ljLg0KDQpZZWEgSSBu
b3RpY2VkIHRoZSBjdXR0b2ZmIGNoZWNrIGluIGEgZmV3IHBsYWNlcyBhbmQgaXQgd2FzIGdldHRp
bmcNCmNvbmZ1c2luZyB0byBzZWUgdGhlIG11bHRpcGxlIGxpbmUgY2hlY2suIEl0IGFsc28gbWFk
ZSBpdCBlYXNpZXIgdG8NCmZvcm1hdCB0aGlzIHdob2xlIGZ1bmN0aW9uIG5pY2VseS4gT25jZSBJ
IGRpZCB0aGF0LCBJIHRob3VnaHQgaXQgbWFkZQ0KbW9yZSBzZW5zZSB0byBzcGxpdCBhcyBtdWNo
IG9mIHRoZSBhY2Nlc3NlcyB0byB0aGUgZ2xvYmFscyBpbnRvIHNlcGFyYXRlDQpmdW5jdGlvbnMg
YXMgcG9zc2libGUuDQoNCj4gDQo+PiArLyogQ2hlY2sgaWYgYSBjb21taXQgaXMgYmVmb3JlIHRo
ZSBjdXRvZmYuIFByaW9yaXRpemUgZ2VuZXJhdGlvbiBudW1iZXJzDQo+PiArICogZmlyc3QsIGJ1
dCB1c2UgdGhlIGNvbW1pdCB0aW1lc3RhbXAgaWYgd2UgbGFjayBnZW5lcmF0aW9uIGRhdGEuDQo+
PiArICovDQo+PiArc3RhdGljIGludCBjb21taXRfaXNfYmVmb3JlX2N1dG9mZihzdHJ1Y3QgY29t
bWl0ICpjb21taXQpDQo+PiArew0KPj4gKwlpZiAoZ2VuZXJhdGlvbl9jdXRvZmYgPCBHRU5FUkFU
SU9OX05VTUJFUl9JTkZJTklUWSkNCj4+ICsJCXJldHVybiBjb21taXRfZ3JhcGhfZ2VuZXJhdGlv
bihjb21taXQpIDwgZ2VuZXJhdGlvbl9jdXRvZmY7DQo+PiArDQo+PiArCXJldHVybiBjb21taXQt
PmRhdGUgPCBjdXRvZmY7DQo+PiArfQ0KPiANCj4gVGhlcmUgYXJlIHR3byBzdWJ0bGUgdGhpbmdz
IGdvaW5nIG9uIGhlcmUgd2hlbiBnZW5lcmF0aW9uX2N1dG9mZiBpcw0KPiB6ZXJvOg0KPiANCj4g
MS4gSW4gYSBjb21taXQtZ3JhcGggd2l0aCB0b3BvbG9naWNhbCBsZXZlbHMgX29yXyBnZW5lcmF0
aW9uIG51bWJlcnMgdjIsDQo+ICAgIGNvbW1pdF9ncmFwaF9nZW5lcmF0aW9uKGNvbW1pdCkgd2ls
bCBhbHdheXMgYmUgcG9zaXRpdmUsIHNvIHdlIGRvbid0DQo+ICAgIG5lZWQgdG8gZG8gdGhlIGxv
b2t1cC4NCg0KSS5lLiBvbmNlIHdlIGhhdmUgYSBnZW5lcmF0aW9uX2N1dG9mZiBvZiAwIHdlIGNh
biBqdXN0IGNvbXBsZXRlbHkgYnlwYXNzDQp0aGUgbG9va3VwLCBzYXZpbmcgc29tZSB0aW1lLg0K
DQpJIHRoaW5rIHdlIGNhbiBkbyAicmV0dXJuIGdlbmVyYXRpb25fY3V0b2ZmICYmDQpjb21taXRf
Z3JhcGhfZ2VuZXJhdGlvbihjb21taXQpIDwgZ2VuZXJhdGlvbl9jdXRvZmYiDQoNCj4gDQo+IDIu
IElmIHRoZSBjb21taXQtZ3JhcGggd2FzIHdyaXR0ZW4gYnkgYW4gb2xkZXIgR2l0IHZlcnNpb24g
YmVmb3JlDQo+ICAgIHRvcG9sb2dpY2FsIGxldmVscyB3ZXJlIGltcGxlbWVudGVkLCB0aGVuIHRo
ZSBnZW5lcmF0aW9uIG9mIGNvbW1pdHMNCj4gICAgaW4gdGhlIGNvbW1pdC1ncmFwaCBhcmUgYWxs
IHplcm8oISkuIFRoaXMgbWVhbnMgdGhhdCB0aGUgbG9naWMgaGVyZQ0KPiAgICB3b3VsZCBiZSBp
bmNvcnJlY3QgZm9yIHRoZSAiYWxsIiBjYXNlLg0KPiANCj4gVGhlIGZpeCBmb3IgYm90aCBjYXNl
cyBpcyB0byByZXR1cm4gMSBpZiBnZW5lcmF0aW9uX2N1dG9mZiBpcyB6ZXJvOg0KPiANCg0KSSB0
aGluayB5b3UgbWVhbiByZXR1cm4gMD8gQmVjYXVzZSB0aGlzIHJldHVybnMgdHJ1ZSBpZiB0aGUg
Y29tbWl0IGlzDQpiZWZvcmUgdGhlIGN1dG9mZiwgYnV0IGZhbHNlIGlmIGl0cyBub3QuIChpLmUu
IGlmIGl0cyB0cnVlLCB3ZSBzaG91bGQNCnN0b3Agc2VhcmNoaW5nIHRoaXMgY29tbWl0LCBidXQg
aWYgaXRzIGZhbHNlIHdlIHNob3VsZCBjb250aW51ZSBzZWFyY2hpbmc/DQoNCg0KDQo+IAlpZiAo
IWdlbmVyYXRvbl9jdXRvZmYpDQo+IAkJcmV0dXJuIDE7DQo+PiAtCWlmIChzdGFydF9jb21taXQt
PmRhdGUgPCBjdXRvZmYpDQo+PiArCWlmIChjb21taXRfaXNfYmVmb3JlX2N1dG9mZihzdGFydF9j
b21taXQpKQ0KPiANCj4+IC0JCQlpZiAocGFyZW50LT5kYXRlIDwgY3V0b2ZmKQ0KPj4gKwkJCWlm
IChjb21taXRfaXNfYmVmb3JlX2N1dG9mZihwYXJlbnQpKQ0KPiANCj4gTmljZSByZXBsYWNlbWVu
dHMuDQo+IA0KPj4gLQlpZiAoYWxsIHx8IGFubm90YXRlX3N0ZGluKQ0KPj4gKwlpZiAoYWxsIHx8
IGFubm90YXRlX3N0ZGluKSB7DQo+PiArCQlnZW5lcmF0aW9uX2N1dG9mZiA9IDA7DQo+PiAgCQlj
dXRvZmYgPSAwOw0KPj4gKwl9DQo+IA0KPiBHb29kLg0KPiANCj4+IC0JCWlmIChjb21taXQpIHsN
Cj4+IC0JCQlpZiAoY3V0b2ZmID4gY29tbWl0LT5kYXRlKQ0KPj4gLQkJCQljdXRvZmYgPSBjb21t
aXQtPmRhdGU7DQo+PiAtCQl9DQo+PiArCQlpZiAoY29tbWl0KQ0KPj4gKwkJCXNldF9jb21taXRf
Y3V0b2ZmKGNvbW1pdCk7DQo+IA0KPiBBbm90aGVyIG5pY2UgcmVwbGFjZW1lbnQuDQo+IA0KPj4g
KyMgQS1CLUMtRC1FLW1haW4NCj4+ICsjDQo+PiArIyBXaGVyZSBDIGhhcyBhIG5vbi1tb25vdG9u
aWNhbGx5IGluY3JlYXNpbmcgY29tbWl0IHRpbWVzdGFtcCB3LnIudC4gb3RoZXINCj4+ICsjIGNv
bW1pdHMNCj4+ICt0ZXN0X2V4cGVjdF9zdWNjZXNzICdub24tbW9ub3RvbmljIGNvbW1pdCBkYXRl
cyBzZXR1cCcgJw0KPj4gKwlVTklYX0VQT0NIX1pFUk89IkAwICswMDAwIiAmJg0KPj4gKwlnaXQg
aW5pdCBub24tbW9ub3RvbmljICYmDQo+PiArCXRlc3RfY29tbWl0IC1DIG5vbi1tb25vdG9uaWMg
QSAmJg0KPj4gKwl0ZXN0X2NvbW1pdCAtQyBub24tbW9ub3RvbmljIC0tbm8tdGFnIEIgJiYNCj4+
ICsJdGVzdF9jb21taXQgLUMgbm9uLW1vbm90b25pYyAtLW5vLXRhZyAtLWRhdGUgIiRVTklYX0VQ
T0NIX1pFUk8iIEMgJiYNCj4+ICsJdGVzdF9jb21taXQgLUMgbm9uLW1vbm90b25pYyBEICYmDQo+
PiArCXRlc3RfY29tbWl0IC1DIG5vbi1tb25vdG9uaWMgRQ0KPj4gKycNCj4+ICsNCj4+ICt0ZXN0
X2V4cGVjdF9zdWNjZXNzICduYW1lLXJldiB3aXRoIGNvbW1pdEdyYXBoIGhhbmRsZXMgbm9uLW1v
bm90b25pYyB0aW1lc3RhbXBzJyAnDQo+PiArCXRlc3RfY29uZmlnIC1DIG5vbi1tb25vdG9uaWMg
Y29yZS5jb21taXRHcmFwaCB0cnVlICYmDQo+PiArCSgNCj4+ICsJCWNkIG5vbi1tb25vdG9uaWMg
JiYNCj4+ICsNCj4+ICsJCSMgRW5zdXJlIGNvbW1pdCBncmFwaCBpcyB1cCB0byBkYXRlDQo+PiAr
CQlnaXQgLWMgZ2Mud3JpdGVDb21taXRHcmFwaD10cnVlIGdjICYmDQo+IA0KPiAiZ2l0IGNvbW1p
dC1ncmFwaCB3cml0ZSAtLXJlYWNoYWJsZSIgd291bGQgc3VmZmljZSBoZXJlLg0KPiANCj4gDQoN
CkFoLiBJIHdhcyBsb29raW5nIGZvciBzb21ldGhpbmcgbGlrZSB0aGF0IGJ1dCBjb3VsZG4ndCBm
aW5kIGl0LiBJIHNhdw0KdGhpcyBpbiBhbm90aGVyIHRlc3Qgd2hpY2ggaXMgd2hhdCBpIHNldHRs
ZWQgb24uIFdpbGwgZml4Lg0KDQo+PiArDQo+PiArCQllY2hvICJtYWlufjMgdGFncy9EfjIiID5l
eHBlY3QgJiYNCj4+ICsJCWdpdCBuYW1lLXJldiAtLXRhZ3MgbWFpbn4zID5hY3R1YWwgJiYNCj4+
ICsNCj4+ICsJCXRlc3RfY21wIGV4cGVjdCBhY3R1YWwNCj4+ICsJKQ0KPj4gKycNCj4+ICsNCj4+
ICt0ZXN0X2V4cGVjdF9zdWNjZXNzICduYW1lLXJldiAtLWFsbCB3b3JrcyB3aXRoIG5vbi1tb25v
dG9uaWMnICcNCj4gDQo+IFRoaXMgaXMgd29ya2luZyBiZWNhdXNlIG9mIHRoZSBjb21taXQtZ3Jh
cGgsIHJpZ2h0PyBXZSBzdGlsbCBoYXZlDQo+IGl0IGZyb20gdGhlIHByZXZpb3VzIHRlc3QsIHNv
IHdlIGFyZW4ndCB0ZXN0aW5nIHRoYXQgdGhpcyB3b3Jrcw0KPiB3aGVuIHdlIG9ubHkgaGF2ZSB0
aGUgY29tbWl0IGRhdGUgYXMgYSBjdXRvZmYuDQo+IA0KDQpJIGNhbiBlaXRoZXIgZXh0ZW5kIHRo
aXMgdGVzdCBvciBhZGQgYSBzZXBhcmF0ZSB0ZXN0IHdoaWNoIGNvdmVycyB0aGlzLg0KVGhlIHRl
c3QgZmFpbGVkIGJlZm9yZSBJIGFkZGVkIHRoZSBjb21taXQgZ3JhcGggbGluZS4NCg0KPj4gKwko
DQo+PiArCQljZCBub24tbW9ub3RvbmljICYmDQo+PiArDQo+PiArCQljYXQgPmV4cGVjdCA8PC1c
RU9GICYmDQo+PiArCQlFDQo+PiArCQlEDQo+PiArCQlEfjENCj4+ICsJCUR+Mg0KPj4gKwkJQQ0K
Pj4gKwkJRU9GDQo+PiArDQo+PiArCQlnaXQgbG9nIC0tcHJldHR5PSVIID5yZXZzICYmDQo+PiAr
CQlnaXQgbmFtZS1yZXYgLS10YWdzIC0tYW5ub3RhdGUtc3RkaW4gLS1uYW1lLW9ubHkgPHJldnMg
PmFjdHVhbCAmJg0KPj4gKw0KPj4gKwkJdGVzdF9jbXAgZXhwZWN0IGFjdHVhbA0KPj4gKwkpDQo+
IA0KPiBEbyB5b3Ugd2FudCB0byBpbmNsdWRlIGEgdGVzdCBzaG93aW5nIHRoZSAiZXhwZWN0ZWQi
IGJlaGF2aW9yDQo+IHdoZW4gdGhlcmUgaXNuJ3QgYSBjb21taXQtZ3JhcGggZmlsZT8gWW91IG1p
Z2h0IG5lZWQgdG8gZGVsZXRlDQo+IGFuIGV4aXN0aW5nIGNvbW1pdC1ncmFwaCAoaXQgd2lsbCBl
eGlzdCBpbiB0aGUgY2FzZSBvZg0KPiBHSVRfVEVTVF9DT01NSVRfR1JBUEg9MSkuDQo+IA0KDQpU
aGlzIHRlc3QgYWN0dWFsbHkgaXMgaW50ZW5kZWQgdG8gc2hvdyB0aGF0IGl0IHdvcmtzIHJlZ2Fy
ZGxlc3Mgb2YNCndoZXRoZXIgd2UgaGF2ZSBhIGNvbW1pdCBncmFwaC4gKEJlY2F1c2UgaW4gLS1h
bm5vdGF0ZS1zdGRpbiBtb2RlIHdlDQpkaXNhYmxlIHRoZSBoZXVyaXN0aWMgc2luY2Ugd2UgZG9u
J3Qga25vdyB3aGF0IGNvbW1pdHMgd2UnbGwgc2VlIGluIGFkdmFuY2UpDQoNCklzIHRoZXJlIGEg
Z29vZCB3YXkgdG8gZGVsZXRlIHRoZSBncmFwaCBmaWxlPw0KDQo+IEkgYWxzbyBzZWUgdGhhdCB5
b3UgaW50ZW5kZWQgdG8gdGVzdCB0aGUgIi0tYWxsIiBvcHRpb24sIHdoaWNoDQo+IGlzIG5vdCBp
bmNsdWRlZCBpbiB5b3VyIHRlc3QuIFRoYXQncyBwcm9iYWJseSB0aGUgcmVhbCBrZXkgdG8NCj4g
Z2V0dGluZyB0aGlzIHRlc3QgdG8gd29yayBjb3JyZWN0bHkuIERlbGV0aW5nIHRoZSBncmFwaCB3
aWxsDQo+IHByb2JhYmx5IGNhdXNlIGEgZmFpbHVyZSBvbiB0aGlzIHRlc3QgdW5sZXNzICItLWFs
bCIgaXMgYWRkZWQuDQo+IA0KDQpBY3R1YWxseSBib3RoIC0tYWxsIGFuZCAtLWFubm90YXRlLXN0
ZGluIGRpc2FibGUgdGhlIGhldXJpc3RpYy4gSG93ZXZlciwNCkkgdGhpbmsgYWRkaW5nIGEgdGVz
dCBmb3IgYm90aCBtYWtlcyBzZW5zZS4NCg0KPiBUaGFua3MsDQo+IC1TdG9sZWUNCj4gDQoNCg==
