Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F032C433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 23:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244831AbiBOXjJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 18:39:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244832AbiBOXjI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 18:39:08 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700EA9A4FF
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 15:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644968337; x=1676504337;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MC9jITBtofj21hzd1Nt8djs5fDyQgkEYqrv+4hI0hcY=;
  b=i91ANBq2rNKkgDRyinUlvJV7sX17+1Z8hAhwMuAoWX8qZ1yyAhZPToEQ
   /lWmUGwYhcwBAU7EYK8BI69tQ2LHNtnLXinHEbpyYlLpPXGroFUG9jRFG
   /f39Td0Nku6MXpsXRTaKmVXHG5CnZhuh7DBM9sG3wjbD226md2WINA/YN
   lfacgYXCyKSJElLHfwOcY7auerJpf14tJrUO3QYSw/JG9TBvcTWLnpNPs
   A/iuqv6K7EUXQONYFvzo9uKOrpQ6vfBGjWtJ04jyPYAbTBdG7MvI+2yCj
   qi/02Zq1JXZh/uRV0cmSV5ALoeGgqtk6ScCzHEUkYgEd5KqyNp7mZuRx4
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="311223401"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="311223401"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 15:38:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="604079793"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 15 Feb 2022 15:38:55 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 15 Feb 2022 15:38:54 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 15 Feb 2022 15:38:54 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 15 Feb 2022 15:38:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CViAvawe9QfmlFDYC2wlwJe29lNALYaFRq7fPtQFpMGPqiM7p5wzWQ9miVNNcGA6lrjCfrKArmCmJ6OtXGic9UA6+w6p1waupLTKIs8V2qBM+pUWC3VIvnXxugClmFAVkdvu5LNl5Tikw85BbQCmbG344j8p5MqkAraN9y8NcRocKKhpPyCGfHHNSvlNTVdeL4xekydUxtrlUCA3RSkcnyzrFiiCA0L2doPBU6gtx51jth8u2yZ/Ikx1JCAlRHHWKXlFMgsQin66bOE9/jA8xGj5YO5Y550vpQPCbZRFpb3E+qKggbbjQjYsf0/7IyhOnYseHG9n1jvx4WkmM9Ud5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MC9jITBtofj21hzd1Nt8djs5fDyQgkEYqrv+4hI0hcY=;
 b=a48Kbb8eQeO8T0JVcp2nmIGZ+I4/wb2lTiz2SwDnMed3ZIBf7kWjP4Ju22QRi1q1iDrDmnxrLpDRHllRQ5Jyo22oqfwK5825wsDbR9aVd7jUpUl+TsJ4mypbmEkl8QonZbvQqAMTPI2993V3yuR15njmPojXg+QZrB11V8L0+IwQIFM0JAc/ToVeuyi8cU67RpudKBhay+lagINefFc3KiOId6/Iw+7YWyD1Qx2mMHl/WrCm6gm4YoKYNngbddTb+nH8dQ2uxM13KRMR/jRJFQiqWJ5AQd4h4HNPbM6YE9bX8oZLAHqRrswL2aZ2Cs79RfEbWBcjb2f2PxX3yqdnGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BN8PR11MB3732.namprd11.prod.outlook.com (2603:10b6:408:83::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 23:38:41 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::bd9e:6244:4757:615a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::bd9e:6244:4757:615a%9]) with mapi id 15.20.4995.015; Tue, 15 Feb 2022
 23:38:41 +0000
From:   "Keller, Jacob E" <jacob.e.keller@intel.com>
To:     Derrick Stolee <derrickstolee@github.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
CC:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] name-rev: test showing failure with non-monotonic commit
 dates
Thread-Topic: [PATCH] name-rev: test showing failure with non-monotonic commit
 dates
Thread-Index: AQHYIeZRsk1qBkD/FUyMjBUmt6bxlayTlhdxgAAEmICAARe/AIAAlBUA
Date:   Tue, 15 Feb 2022 23:38:41 +0000
Message-ID: <92fe3661-8025-18a7-a9a3-0fce88da522c@intel.com>
References: <20220214210136.1532574-1-jacob.e.keller@intel.com>
 <xmqqr18515jr.fsf@gitster.g>
 <CA+P7+xrN0zPWfxO1roWzR+MBHntTv8jr9OGdNcN9RPA=ebK24A@mail.gmail.com>
 <42d2a9fe-a3f2-f841-dcd1-27a0440521b6@github.com>
In-Reply-To: <42d2a9fe-a3f2-f841-dcd1-27a0440521b6@github.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 147cee7a-f3c8-4fdb-99fe-08d9f0dc4c9a
x-ms-traffictypediagnostic: BN8PR11MB3732:EE_
x-microsoft-antispam-prvs: <BN8PR11MB3732395FE81CC5062E3E34F6D6349@BN8PR11MB3732.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eZYJqOz22tdydH7HTJvEPysMv6ABENyQPZ1VNFzOwT+tFWQhQPJgqET96xjji/2Wmqjvy+bNFCRa9J5/5lWGKYytyOL4t0E9Fe0LWgOsUIouJyxeH6iyojrLT96b6OyIPdUotFyxzje8xLFy4TP6z4PMjPwB6mCJooMP/DhH4O47VSt7184uXk8ul/yjy+pBLYtHwRVNnjYkwWy3htzxp31tDHVWnFevowYTS0mAVyxC0QiJQqFah6PKyQ8k6a7u6GHt7ecpw9RkjzdhtdaIsExuzsUUGEvHHdUs8a7NREbM5uESlGGvC8SUa2aFy7QJNot0l3PTJaWpgkzs1Nx7wb/MLIhocEN//s1hFmAOko2G4XzISAeCBUGtEc/CHBVL8ydkbwdvhwD4b9stS4OW101IBo745pGGh+MmJxxh1DszVexDEXPJ3bBvNF56HYGtgXUrBJgqhIXPogstX4yUx/G9G5cX+jynLUxiQzDkFXMXYYnNc6MfieCnKvzYenONztauhiqFoXmy/u9A0ZrqzhMx7+MN7PG5WkzdVDXigrD6vW931mm0QjyoBnQJXz8DOLxkQMwXTviOtTYK4VnoaS7muGBbLItxgKeH8IlpuzyM4VHgGoOILSR3agPiwoxFSuQfZfho6FXQcWJLy6VB9xKAvrBpbfUs8O+FbOhWqEBkEviO/zro5+n0lLe6BPpeSLQ42PVugp6TDzSihirLq5aXhr2QdOobhfvnke/v/lGMrXu9/005pO+H272zaOSQfjJXe49x5n4k8ulR41FXoA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6506007)(186003)(6512007)(2616005)(508600001)(76116006)(122000001)(5660300002)(54906003)(110136005)(66946007)(38100700002)(71200400001)(6486002)(31686004)(53546011)(2906002)(66476007)(36756003)(38070700005)(316002)(31696002)(64756008)(8936002)(4326008)(86362001)(66556008)(8676002)(83380400001)(82960400001)(66446008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUNtdjBHL3FTN08zM1ZUYWp6dEJMd2sxOXcxTXcxRW8vcVhidTRTZ3gxUG5u?=
 =?utf-8?B?REFwZTdGa0ZkK1YzUW8rZVZEaHFhajhqWjd2RmJCNlVHMUhRMVR1SEoyMElI?=
 =?utf-8?B?S2V2TzBaT1MrZjFoMm91RTVDTWZWT0xGVHRyKzA0aEM0bzhzbm16LzlwSjZE?=
 =?utf-8?B?ZXNnOFFyV05lQmd2eDBBZGN4eWxUaXdIdmRSYm5DZ1F1SEpYMFI0QUZCYnZx?=
 =?utf-8?B?amxRZUlmaGZvTzcrYTdROWZDeEp3R0xVR3o0aWpMclNwK3psV3V5eFdvNEdY?=
 =?utf-8?B?K29PNHJ1K2NCbmVUcHZiQ1lXVHFQekdSMXF0b0EwR2RBRjZpdXF3ajk2UTJ3?=
 =?utf-8?B?Nm0zWjJ4S1FJRTlKTjFXWE1uRzBveFg5dTJKSG15WDJ3enpLd2FWZ2pob3I1?=
 =?utf-8?B?c2F5Ni9qdklLdkFES25ucG5kbXdEeXhiNEJRc0grZ2FaaDhCVmlyUjZkV1dD?=
 =?utf-8?B?YmowTmVlSGlycFdBTG83d09VdEZHMmZhN2ZpdXF3SHB4clQxL0piS21URjBS?=
 =?utf-8?B?MnZlZnVYQ1dOeUZ1V2k1cCtEYmZMb3RuTHJOaWxSbGpYRjhoOWV3azd3R25r?=
 =?utf-8?B?djVuZHJpL0Y4ZmRudUFyVG4rOVZFTnZLQWRzT3JOZTFSckJ6TmtHdnF3bzY3?=
 =?utf-8?B?V2pjZjIrZU4rYnY4ekVVc2F1cHVDY0tteWd1d1QzY0VMQytjQWJkeEg0T1JN?=
 =?utf-8?B?ZHl4U0xqZTl5ODFKaWU1b2g3N09qTURnSzM2aUhxeW0wZmFMT2JwaVVVcWJr?=
 =?utf-8?B?bjRoOE15QUNhNUxBSHVJajNxTUV0aVJIaVRWLy91OFdyNXVTRnlYVGx3cFhB?=
 =?utf-8?B?REx6NysrWEpVMTBDUS9EVUQxRTAxV2xjczFmeXhsRkFJcmxrYVg0QWFnc2Fr?=
 =?utf-8?B?MmRCeDhENVJ5Ynl3d1lyc2J6UXByZVRUTVAzN3lKbk5YNVhiZlhsSFlNMGtz?=
 =?utf-8?B?cjd2U21DbUp2NU4wd1k2U0pxa3BHR1FvWkpCVVpEK1IvTFRqdDFHN0hFb3Y4?=
 =?utf-8?B?U2ZpMjcwUGk0U0M4c3NtbGl2QUdzUUJsRGFrUWlSbFhlTURpcnR4VHdCU1RT?=
 =?utf-8?B?V3N2VWFiU3pyTnJLYzcvL3FZcXhaTTlwZ1BORHNNZ05CZC9UOW9wZ09VSVE0?=
 =?utf-8?B?cnlnS1NJNkdiNU5XdTRFcmlIaDNzNGFWRVRBc0k1MmVMVkFXNzNZNEVReFBP?=
 =?utf-8?B?Tlh4YTVMRHNZRWo2NlZWWkE5TzJFbzlTaWlYYUdPdmhqQm9hblp1Q1A3cElY?=
 =?utf-8?B?TnRJcjR1N0ZTZ1o1MjMyWFMzcUlIbHMxa3RxK3p4Tk5pWElGSE9FSUFoYTly?=
 =?utf-8?B?TzgxRGtQZkFOM0VEOTdOdXJWWFpub2d6K1B3bDNudStGZjBBNWJESTVhYXFN?=
 =?utf-8?B?VCs3VlVQSVIrbTVlMzI0MTBZdjU5WVQxR2czODNRMGVpcldUNDh3Skh0aXVP?=
 =?utf-8?B?ZDJZbHRWUnRKRDVCNTBHNlhoblBVM1V4ckxCVUpqcUN3OHp2MkVVckZ4MXln?=
 =?utf-8?B?bm1ObUs5UVFJak1ldkhoZXBBZkZsRnE4am5DNnpTSVk3QlpLN3Q1WWQyRzM4?=
 =?utf-8?B?aHBqcEJoMkJDU2pBRnhLRFBVRlE2M3JwUXhTTlFoU05ZcVhnU2JwQTdVTzR4?=
 =?utf-8?B?THovS1ZVTEg0V0R1aFp5OGdaR2ZzOHdoMk5tR3JnWFEwMEM0RGNsQi9LVXhY?=
 =?utf-8?B?TkdZUzJxWDk0MVNBcTNtdGhQRk14R0dzZHFnaDZZeVZxbGZRK1MvTEljYUJ2?=
 =?utf-8?B?bjVucmxDelk4WTdHazJGRlZTOHpFZTQ1RmFuTGtiRXNKOW1nRk96WWNUNFdB?=
 =?utf-8?B?eHl1MzAzUGZuU2I4V2tUbTVwaEZ4ZjV4UW1ya1d2ZFdyRFVJV2VGUmhoS1Qr?=
 =?utf-8?B?bUpQVXlHdGppaXpsM0hjMzhaYS9IYTg5dmJLL2pKdDV0Ym9OQk55M1NVd21Z?=
 =?utf-8?B?TFN5b1dsZ09Tbk9hRWlZbVlCdHJSc04zSHJUbmtNbUVLYzBkUEk1VUtwSnhS?=
 =?utf-8?B?eDFBaEZBcjFVY1NybkY0b0hqMEIwbjNnSUZJQXNWVElTZ1psTmtJZkdCMXVQ?=
 =?utf-8?B?ak9IQWIwMnlVOVY4dit4SXpCM3d5Zm1xV3o4U0NIRmt0bzJ3eHlJVEt3Nklj?=
 =?utf-8?B?VHEydlA0ZzZZbHJ2akd3eCtxWGtoZ1BTSE1xSlJJcTNLT2tVbE9YS2NKTlk1?=
 =?utf-8?B?VUhYZDRjaWtBTmRpdlNvRTJveUQyYmtXNkhtKzMycTVjQW9ZZUxtQjFKSSsy?=
 =?utf-8?B?RUJtYjA3UlErcWxxMnFkNTVieGNnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD792703D49BA74AA76BE2837D2C9E14@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 147cee7a-f3c8-4fdb-99fe-08d9f0dc4c9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 23:38:41.7682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +GQMBMu35iD16NdfTTbEveLb+cz0FB+H4nATRpjYoaufWjxRnOdFN/cEqUnkB0eJm1IHfNBWpAyzbKuXZ4wNlZW19DraDym9Puy9vKcJpi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3732
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

T24gMi8xNS8yMDIyIDY6NDggQU0sIERlcnJpY2sgU3RvbGVlIHdyb3RlOg0KPiBPbiAyLzE0LzIw
MjIgNTowNyBQTSwgSmFjb2IgS2VsbGVyIHdyb3RlOg0KPj4gT24gTW9uLCBGZWIgMTQsIDIwMjIg
YXQgMTo1MCBQTSBKdW5pbyBDIEhhbWFubyA8Z2l0c3RlckBwb2JveC5jb20+IHdyb3RlOg0KPj4+
DQo+Pj4gSmFjb2IgS2VsbGVyIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+IHdyaXRlczoNCj4+
Pg0KPj4+PiBGcm9tOiBKYWNvYiBLZWxsZXIgPGphY29iLmtlbGxlckBnbWFpbC5jb20+DQo+Pj4+
DQo+Pj4+IElmIGEgY29tbWl0IGluIGEgc2VxdWVuY2Ugb2YgbGluZWFyIGhpc3RvcnkgaGFzIGEg
bm9uLW1vbm90b25pY2FsbHkNCj4+Pj4gaW5jcmVhc2luZyBjb21taXQgdGltZXN0YW1wLCBnaXQg
bmFtZS1yZXYgd2lsbCBub3QgcHJvcGVybHkgbmFtZSB0aGUNCj4+Pj4gY29tbWl0Lg0KPj4+Pg0K
Pj4+PiBIb3dldmVyLCBpZiB5b3UgdXNlIC0tYW5ub3RhdGUtc3RkaW4gdGhlbiB0aGUgY29tbWl0
IGRvZXMgYWN0dWFsbHkgZ2V0DQo+Pj4+IHBpY2tlZCB1cCBhbmQgbmFtZWQgcHJvcGVybHkuDQo+
Pj4NCj4+PiBJSVJDLCB0aGlzIGlzIHRvIGJlIGV4cGVjdGVkLg0KPj4+DQo+Pg0KPj4gUmlnaHQu
IEkgZmlndXJlZCB0aGlzIGlzIHNvbWVob3cgZXhwZWN0ZWQgYmVoYXZpb3IuLi4NCj4+DQo+Pj4g
V2hlbiBwcmVwYXJpbmcgdG8gYW5zd2VyIC0tYW5ub3RhdGUtc3RkaW4gcmVxdWVzdCwgdGhlIGNv
bW1hbmQgaGFzDQo+Pj4gdG8gZGlnIGRvd24gdG8gdGhlIHJvb3Qgb2YgdGhlIGhpc3RvcnksIHdo
aWNoIHdvdWxkIGJlIHRvbyBleHBlbnNpdmUNCj4+PiBpbiBzb21lIHJlcG9zaXRvcmllcyBhbmQg
d2FudHMgdG8gc3RvcCB0cmF2ZXJzYWwgZWFybHkgd2hlbiBpdCBrbm93cw0KPj4+IHBhcnRpY3Vs
YXIgY29tbWl0cyBpdCBuZWVkcyB0byBkZXNjcmliZS4NCj4+Pg0KPj4NCj4+IEFuZCB0aGlzIG1l
dGhvZCBvZiBjdXR0aW5nIHRoZSBzZWFyY2ggcmVsaWVzIG9uIG1vbm90b25pYyBjb21taXQgdGlt
ZXMgcmlnaHQ/DQo+Pg0KPj4gSXMgdGhlcmUgYW55IG90aGVyIG1ldGhvZCB3ZSBjb3VsZCB1c2Ug
KGNvbW1pdCBncmFwaD8pIG9yIHBlcmhhcHMgdG8NCj4+IGFkZCBhbiBvcHRpb24gc28gdGhhdCB5
b3UgY291bGQgZ28gImdpdCBuYW1lLXJldiAtLW5vLWN1dG9mZiA8Y29tbWlkDQo+PiBpZD4iPyBU
aGF0IHdvdWxkIHBvdGVudGlhbGx5IGFsbG93IHdvcmtpbmcgYXJvdW5kIHRoaXMgcGFydGljdWxh
cg0KPj4gcHJvYmxlbSBvbiByZXBvc2l0b3JpZXMgd2hlcmUgaXRzIGtub3duIHRvIGJlIHByb2Js
ZW1hdGljLg0KPiANCj4gSSBpbml0aWFsbHkgdGhvdWdodCB0aGF0IGdlbmVyYXRpb24gbnVtYmVy
cyBjb3VsZCBoZWxwLiBUaGUgdXN1YWwgd2F5DQo+IGlzIHRvIHVzZSBhIHByaW9yaXR5IHF1ZXVl
IHRoYXQgZXhwbG9yZXMgYnkgZ2VuZXJhdGlvbiwgbm90IGNvbW1pdA0KPiBkYXRlLiBUaGlzIGFw
cHJvYWNoIHdhcyBpbW1lZGlhdGVseSBzdGlmbGVkIGJ5IHRoZXNlIGxpbmVzOg0KPiANCj4gCW1l
bXNldCgmcXVldWUsIDAsIHNpemVvZihxdWV1ZSkpOyAvKiBVc2UgdGhlIHByaW9fcXVldWUgYXMg
TElGTyAqLw0KPiAJcHJpb19xdWV1ZV9wdXQoJnF1ZXVlLCBzdGFydF9jb21taXQpOw0KPiANCj4g
U28gdGhlIHF1ZXVlIGlzIHJlYWxseSBhIHN0YWNrLg0KPiANCg0KUmlnaHQuIEEgY2xvc2VyIGxv
b2sgYXQgdGhlIG5hbWUtcmV2IGFsZ29yaXRobSBzZWVtcyB0byBiZSB0aGF0IGl0DQpzdGFydHMg
bG9va2luZyBhdCBlYWNoIHRhZyBhbmQgc2Nhbm5pbmcgZG93biBoaXN0b3J5IHRvIHNlZSBpZiBp
dCBjYW4NCmZpbmQgdGhlIGdpdmVuIGNvbW1pdC4gSXQgdXNlcyB0aGUgY29tbWl0IHRpbWVzdGFt
cCBhcyBhIGhldXJpc3RpYyB0bw0KZGVjaWRlIHdoZXRoZXIgb3Igbm90IHRvIHN0b3AgbG9va2lu
Zy4gVGhpcyBjYW4gc3BlZWQgdXAgdGhlIHNlYXJjaA0KYmVjYXVzZSBpdCBwcmV2ZW50cyBzY2Fu
bmluZyB0aGUgZW50aXJlIGhpc3RvcnkuLiBidXQgaXQgYnJlYWtzIHdoZW4NCnRoYXQgaGV1cmlz
dGljIGlzIG5vIGxvbmdlciB0cnVlIHN1Y2ggYXMgaW4gdGhlIHBhcnRpY3VsYXIgc2V0dXAgbGlr
ZQ0KbWluZSB3aXRoIGEgZnVua3kgdGltZXN0YW1wLg0KDQoNCj4+IEFsdGVybmF0aXZlbHkgaXMg
dGhlcmUgc29tZSBvdGhlciB3YXkgdG8gYXBwbHkgdGhlIGN1dG9mZiBoZXVyaXN0aWMNCj4+IG9u
bHkgaW4gc29tZSBjYXNlcz8gSSBnZXQgdGhlIHNlbnNlIHRoaXMgaXMgaW50ZW5kZWQgdG8gYWxs
b3cgY3V0dGluZw0KPj4gb2ZmIG1lcmdlZCBicmFuY2hlcz8gaS5lLiBub3QgYXBwbHlpbmcgaXQg
d2hlbiBoaXN0b3J5IGlzIGxpbmVhcj8gSSdkDQo+PiBoYXZlIHRvIHN0dWR5IGl0IGZ1cnRoZXIg
YnV0IHRoZSBleGlzdGluZyBhbGdvcml0aG0gc2VlbXMgdG8gYnJlYWsNCj4+IGJlY2F1c2UgYXMg
aXQgZ29lcyB1cCB0aGUgaGlzdG9yeSBpdCBoYXMgZm91bmQgYW4gIm9sZGVyIiBjb21taXQsIHNv
DQo+PiBpdCBzdG9wcyB0cnlpbmcgdG8gYmxhbWUgdGhhdCBsaW5lLi4uPw0KPiANCj4gSXQgaXMg
c3RpbGwgcG9zc2libGUgdGhhdCB0aGUgY3V0b2ZmIGNvdWxkIGJlIGFsdGVyZWQgdG8gdXNlIGdl
bmVyYXRpb24NCj4gbnVtYmVycyBpbnN0ZWFkIG9mIGNvbW1pdCBkYXRlcywgYnV0IEkgaGF2ZW4n
dCBsb29rZWQgY2xvc2VseSBlbm91Z2ggdG8NCj4gYmUgc3VyZS4NCj4gDQoNClJpZ2h0LiBVc2lu
ZyBnZW5lcmF0aW9uIG51bWJlciB3b3VsZCB3b3JrIGZvciB0aGlzIEkgdGhpbmsuLiBUaGUgcmVh
bA0KcXVlc3Rpb24gYmVpbmcgaWYgaXQgc2F0aXNmaWVzIHRoZSBvdGhlciByZXF1aXJlbWVudHMu
DQoNCkkgdGhpbmsgaXQgZG9lcywgYnV0IEknbSBub3QgMTAwJSBzdXJlIHlldC4NCg0KPiBIZXJl
IGlzIGEgdmVyeSBiYXNpYyBhdHRlbXB0LiBXaXRoIEdJVF9URVNUX0NPTU1JVF9HUkFQSD0xLCB5
b3VyDQo+IHRlc3RfZXhwZWN0X2ZhaWx1cmUgdHVybnMgaW50byBhIHN1Y2Nlc3MuDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvYnVpbHRpbi9uYW1lLXJldi5jIGIvYnVpbHRpbi9uYW1lLXJldi5jDQo+IGlu
ZGV4IDEzOGUzYzMwYTJiLi5mN2FkMWRkOGI0ZCAxMDA2NDQNCj4gLS0tIGEvYnVpbHRpbi9uYW1l
LXJldi5jDQo+ICsrKyBiL2J1aWx0aW4vbmFtZS1yZXYuYw0KPiBAQCAtOSw2ICs5LDcgQEANCj4g
ICNpbmNsdWRlICJwcmlvLXF1ZXVlLmgiDQo+ICAjaW5jbHVkZSAiaGFzaC1sb29rdXAuaCINCj4g
ICNpbmNsdWRlICJjb21taXQtc2xhYi5oIg0KPiArI2luY2x1ZGUgImNvbW1pdC1ncmFwaC5oIg0K
PiAgDQo+ICAvKg0KPiAgICogT25lIGRheS4gIFNlZSB0aGUgJ25hbWUgYSByZXYgc2hvcnRseSBh
ZnRlciBlcG9jaCcgdGVzdCBpbiB0NjEyMCB3aGVuDQo+IEBAIC0yNyw2ICsyOCw3IEBAIHN0cnVj
dCByZXZfbmFtZSB7DQo+ICBkZWZpbmVfY29tbWl0X3NsYWIoY29tbWl0X3Jldl9uYW1lLCBzdHJ1
Y3QgcmV2X25hbWUpOw0KPiAgDQo+ICBzdGF0aWMgdGltZXN0YW1wX3QgY3V0b2ZmID0gVElNRV9N
QVg7DQo+ICtzdGF0aWMgdGltZXN0YW1wX3QgZ2VuZXJhdGlvbl9jdXRvZmYgPSAwOw0KPiAgc3Rh
dGljIHN0cnVjdCBjb21taXRfcmV2X25hbWUgcmV2X25hbWVzOw0KPiAgDQo+ICAvKiBIb3cgbWFu
eSBnZW5lcmF0aW9ucyBhcmUgbWF4aW1hbGx5IHByZWZlcnJlZCBvdmVyIF9vbmVfIG1lcmdlIHRy
YXZlcnNhbD8gKi8NCj4gQEAgLTE1MSw3ICsxNTMsMTAgQEAgc3RhdGljIHZvaWQgbmFtZV9yZXYo
c3RydWN0IGNvbW1pdCAqc3RhcnRfY29tbWl0LA0KPiAgCXN0cnVjdCByZXZfbmFtZSAqc3RhcnRf
bmFtZTsNCj4gIA0KPiAgCXBhcnNlX2NvbW1pdChzdGFydF9jb21taXQpOw0KPiAtCWlmIChzdGFy
dF9jb21taXQtPmRhdGUgPCBjdXRvZmYpDQo+ICsJaWYgKGdlbmVyYXRpb25fY3V0b2ZmICYmIGdl
bmVyYXRpb25fY3V0b2ZmIDwgR0VORVJBVElPTl9OVU1CRVJfSU5GSU5JVFkpIHsNCj4gKwkJaWYg
KGNvbW1pdF9ncmFwaF9nZW5lcmF0aW9uKHN0YXJ0X2NvbW1pdCkgPCBnZW5lcmF0aW9uX2N1dG9m
ZikNCj4gKwkJCXJldHVybjsNCj4gKwl9IGVsc2UgaWYgKHN0YXJ0X2NvbW1pdC0+ZGF0ZSA8IGN1
dG9mZikNCj4gIAkJcmV0dXJuOw0KPiAgDQo+ICAJc3RhcnRfbmFtZSA9IGNyZWF0ZV9vcl91cGRh
dGVfbmFtZShzdGFydF9jb21taXQsIHRhZ2dlcmRhdGUsIDAsIDAsDQo+IEBAIC01OTksNiArNjA0
LDggQEAgaW50IGNtZF9uYW1lX3JldihpbnQgYXJnYywgY29uc3QgY2hhciAqKmFyZ3YsIGNvbnN0
IGNoYXIgKnByZWZpeCkNCj4gIAkJaWYgKGNvbW1pdCkgew0KPiAgCQkJaWYgKGN1dG9mZiA+IGNv
bW1pdC0+ZGF0ZSkNCj4gIAkJCQljdXRvZmYgPSBjb21taXQtPmRhdGU7DQo+ICsJCQlpZiAoZ2Vu
ZXJhdGlvbl9jdXRvZmYgPiBjb21taXRfZ3JhcGhfZ2VuZXJhdGlvbihjb21taXQpKQ0KPiArCQkJ
CWdlbmVyYXRpb25fY3V0b2ZmID0gY29tbWl0X2dyYXBoX2dlbmVyYXRpb24oY29tbWl0KTsNCj4g
IAkJfQ0KPiAgDQo+ICAJCWlmIChwZWVsX3RhZykgew0KPiANCj4gVGhhbmtzLA0KPiAtU3RvbGVl
DQoNCg==
