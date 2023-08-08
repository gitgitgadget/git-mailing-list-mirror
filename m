Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0764EC001DB
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 16:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbjHHQft (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 12:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbjHHQel (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 12:34:41 -0400
Received: from mail10677.corpmailsvcs.com (ovarp0677.corpmailsvcs.com [149.111.205.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB4390B9
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 08:52:34 -0700 (PDT)
Received: from unknown (HELO mail420.corpmailsvcs.com) ([10.98.14.134])
  by mail20677.corpmailsvcs.com with ESMTP; 08 Aug 2023 08:07:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=wellmed.net; i=@wellmed.net; q=dns/txt;
  s=dk.sep2016.2048; t=1691500054;
  h=from:to:subject:date:message-id:references:in-reply-to:
   mime-version:content-transfer-encoding;
  bh=U+SP8QD8usvggvpy48VllZ0oF3af0qT9focEI22WScg=;
  b=Uw3su4TJOcheXo/2tV5ASg8USI9JdqIEOCJobHq8IdZu4DQ5uRVhHzKS
   ANps4xUZqZSegVpVMe8H4/mv2xUEoLenPspk7G8Qj8aJtGahehA01gycn
   9nd1oRy6WGL5Ds/59PIQmH+zq8DXgG1MhGWN3DRo0UNaXDsTLvby8gz+4
   R4jur1HAQwjo8LhBpTmGj/uvAfivVRkLAzh6APROVXpsanwc2U/ZdgtTZ
   Yz6df2NvFftuPwfHIys3LaGwUF+AjNXy8jol/YmC9IPnqOwhPlZXXVE8c
   lf5WWIrwY2V1YiCGaCp09lK8xFDjoLx3MD3z+HahNwvwEVINsoqnlah6M
   A==;
X-REMOTEHOST: mail-dm6nam12lp2173.outbound.protection.outlook.com
X-REMOTEIP: 104.47.59.173
X-IronPort-AV: E=Sophos;i="6.01,156,1684818000"; 
   d="scan'208";a="704048042"
X-CONF-FOOTER: True
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by mail420.corpmailsvcs.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 08:07:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUJiMhq0Jxjp+zyO4LiFx5Y5eFMz89FwupYiiaY2HLDJxjPMpBDKVO30YTReYwoGgi22fTfFWkIkWloYxGm/Lx1FbknNs+kzjb3cMujn3xrgsBRWEN5xg06mgF71jCZga/Bc+ITAUHSb3tNELP19JCW2raTTHMcBtk1E11RWNAFZnLIF/eUPdkTYgXX3WKGxtxQleM53UgXzajkOK04dvxkRJvMvfX0ukIke+9+oc/IXZ5U5IMTMsE6qkHyp3yQF6ElPauc6lezBD3g2/mA89Ey1udr0lkhfW6Ai9V8sBTMeJbVfxWi6poNT2DC2ZvWHXV6C0XWPcmN5OXZbBtIGKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qX25mZOGzBKWaDluzP8y2mLu8Titvv3nTAtpYeapebI=;
 b=AobIkewf+ahr/g639tlIHnYSojVMvNUqHMCT+4JoXyMai521XlXeFPfDn/aVwI+BNvVW9UblS/aUkf32e7GH+FEd6huhKaqhO+AeokyQDQKw4nF7vvVClO9saXDRoThSXLgV812BP7p6spED97X1Y2Npx8F5YxHAAO32HTXhn5aSiGZugBzpX5T0IdsW9IX/27Kihpwsb+pKp5+anh8nDhx9d91cXmK2EiOIPfuBi+Z6ITYX0in0O7skPcMcVj2gXumGbkC5r1ZCi4oqCG2PgEnBYLrvuOY6LEnEsnocVRnCDGRyT0cB7DjRaGyMbyU9RMczgSNcRz1CrmSNBW2apA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wellmed.net; dmarc=pass action=none header.from=wellmed.net;
 dkim=pass header.d=wellmed.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=optumcare.onmicrosoft.com; s=selector2-optumcare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qX25mZOGzBKWaDluzP8y2mLu8Titvv3nTAtpYeapebI=;
 b=F9sukQUvYZa4lh93/iroqvFfmGiqDYMlJFcbKuZ1k00C2poyfFnZj5DKCEGgsyvYwku0urOoXDPQyhM0xvmVf0PrU/ljIkUM7r5/Luzggg8/+mfvYDMcIbZF0avAjhaulahcih1yS47DHGH3v9P0FszPy2J0cBWFqqECkfaPb4c=
Received: from MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24)
 by PH7PR12MB5593.namprd12.prod.outlook.com (2603:10b6:510:133::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Tue, 8 Aug
 2023 13:07:32 +0000
Received: from MW2PR12MB2555.namprd12.prod.outlook.com
 ([fe80::8baa:c5b7:42b2:9dae]) by MW2PR12MB2555.namprd12.prod.outlook.com
 ([fe80::8baa:c5b7:42b2:9dae%5]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 13:07:32 +0000
From:   Paul Watson <pwatson2@wellmed.net>
To:     "rsbecker@nexbridge.com" <rsbecker@nexbridge.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [EXTERNAL] RE: git bug report
Thread-Topic: [EXTERNAL] RE: git bug report
Thread-Index: AdnG8xecm6DeBHiFQeKkAf96rNThYwABgX+AAACQyhAAAPe1gACRr+TwACy6+TA=
Date:   Tue, 8 Aug 2023 13:07:32 +0000
Message-ID:  <MW2PR12MB2555240C4E2A9EB6332A8CAD870DA@MW2PR12MB2555.namprd12.prod.outlook.com>
References:  <MW2PR12MB25558D1886C4AA2A95A5FC618709A@MW2PR12MB2555.namprd12.prod.outlook.com>
 <015101d9c6f9$218ceb20$64a6c160$@nexbridge.com>
  <MW2PR12MB2555BB4CEE6BA6B38F4381428709A@MW2PR12MB2555.namprd12.prod.outlook.com>
 <015901d9c6ff$43606050$ca2120f0$@nexbridge.com>
 <MW2PR12MB25557AAF161A92E862AE5EE2870CA@MW2PR12MB2555.namprd12.prod.outlook.com>
In-Reply-To:  <MW2PR12MB25557AAF161A92E862AE5EE2870CA@MW2PR12MB2555.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wellmed.net;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB2555:EE_|PH7PR12MB5593:EE_
x-ms-office365-filtering-correlation-id: a544b184-313f-4810-f957-08db98106d24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  1kkD+T0OJIRkLSxU/1ySSkwfrvBQmw4dhD+8DfXAwxX846KhYvLDruViYSYlQDkh3bXxYv0CQmeV4mctPdTe3xEAb/aPbuY1hLO1VLkDqZvpM0eozWpQFkhc49Dtb9AmcdlDkqeDk0AAofcUxBTNHe6vAiuVlqU10cGj2UujLiwGgJ/8cXOTNyT2NHdjRO5AuRMg4kO6GjGwXcZy8dakOuzlkQfKQqsd98YoFdxNPvixjHzRSEOSVeW9hp7iv6Wt/RUl3Wj5+IQouP88Mzrs5csgLEiNrRnwssWJkS1BhRGaHhEUNAnh8JR5kZcU+TD66MsCPfeusM72lQSFzteoZRq9VeestEgmA3OkCK4ceZCiqaSKxv6GGoUXo/3Vkmi5LmxChxtubFsTAzvqc0WzevypniT3pMK6kuL7J005SilD95xUzPu8r1gWtqZRzeDJiMoZOCE8A5kAhV9c3VzfS4Kmf+AZsZaWO+hUJnTNPyqEFtl430kfRgyNlQQDLdbZmDcbL4NfeIs1KH3PFW19l0nT9rtwic6kJjZmxiNxyuVflP0BVI/xEX+o2+cXL87sXWK3qqkbnnajFD6+VPUE1AZBRjlIFrqByL99BPIamRgx832YHf9F27F9hpJcCTgy
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2555.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(186006)(451199021)(1800799003)(8676002)(26005)(6506007)(316002)(66556008)(64756008)(4744005)(66446008)(2906002)(66476007)(5660300002)(66946007)(76116006)(8936002)(9686003)(52536014)(7696005)(71200400001)(41300700001)(478600001)(110136005)(122000001)(55016003)(38100700002)(82960400001)(33656002)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?QjNoUExSRUd2TlR1U3NWcVN5dEdBbHFCM3FqM0I2ZDR6WUVFcmN1RzJWa2JN?=
 =?utf-8?B?TTJQOHN4OEE4NzRDWENKckRNaVZMcVZaYlVzaHdxSko2amZxajRQYVFCTGQx?=
 =?utf-8?B?MndGWnNUbkpudkxjWThVanlTM1BjSkpuQ1FUL0NYS21rSStYZVlkOG9qekxx?=
 =?utf-8?B?ZW44Q1Vpdnl1Qk1ydGZ5dTNhTTQ3MmNIc082V1hVWEZQdE4ySVdKZHpIRHNi?=
 =?utf-8?B?V1RFdEVGZlE0eHdCaU1vVEFaaDZLVEljUDd2cmQrUGFWclozd3pncmtibmtt?=
 =?utf-8?B?RFo2YTRnNk9Cdk1nM0NkaCtqSmNwNzM0NGNuemVKeGRDQVBlczVERGttc0Vu?=
 =?utf-8?B?QUVTK1FyWGM4VGJwU2FQR2FhdkJlbjREQjJUejZUNUpKekh2SDlhRmp2blJO?=
 =?utf-8?B?cmNaUWNtUmVBbmVtMzhaTEExeE9ENHloam9hQnNVNnVCUjNkai8xR0JzMUh4?=
 =?utf-8?B?OWhyazZQWHR3T2szbmFHRHRGeUhOWklQa01lTmw0cjAzb1NaR2VkczdzdGZI?=
 =?utf-8?B?SGY0ajNNcHFtT0RhaXNWNThpVk9tSHpTY1Y4S1hQT2JhdnlLOWJkd3Rrdml5?=
 =?utf-8?B?amFVQXg2L01tV1BOMGlrMS9qY2Jzb3IrZ3ZDdm1RcmV3cTE3Vm1veStxQjhQ?=
 =?utf-8?B?Y0RKbFFsNWloaG1ONVZwejJDNDYyK21mdnJyL0xUSnloY1hyRytlR1pHYkMy?=
 =?utf-8?B?VzdIdDFaVnFqdkpRTFRZRXJUKzZjSndwdWJMVHk5QXhjTXo2aGx0YWlRZDdX?=
 =?utf-8?B?SWpGenNGcmdRTXpnZmxKYU1pcFM1WUl4bWpZcXVKNDkxYW83ZEQrc2ZTeHJq?=
 =?utf-8?B?VDV0QlNWaFRMbDVnWVJ5RTdtbmZPKzNYQ0FtTFNxeHdiV0wyYWpXSzA4UXlQ?=
 =?utf-8?B?QndyZWRoakJucng0KzdoODlDRUs4YjhWWTJaa2hDTG4zVjYyRnlVN1l5RENQ?=
 =?utf-8?B?WG5KeVpCV0FIeG92U1hzZHFWQW1jM3V0ZlZERTdEbXVnV0VINkZBS0xhMUt0?=
 =?utf-8?B?b0dGQnlNbkRwdm9QcDdhd2tjbzNtZ01TMVRKVHBpd292K05rQkVjTGdMYXNw?=
 =?utf-8?B?OW1rR3BFdFE1R0IyNDFCTW5NdVhZazRTTnVXRnJRL0hNWVN6MEFOUjFRbnJu?=
 =?utf-8?B?a2plTzFDcjc3enpoK29weE1oRUJiaHdjQ0xzT1NaSXVSMFBTS1o4MmRpTWNz?=
 =?utf-8?B?YU1CNnptYzVmTnpGNFB2N05nRzBtNmpRcWVwcGk2MkMrVjE1OGQrcmdINWZw?=
 =?utf-8?B?SGl0RVhDblVOdmJBckIwU0o1MzVxOUZpRmNyeWIzdWh1WVhoWW1qd2xzWUVN?=
 =?utf-8?B?NXd6WVlYQ2N1bDdhcFlRcW54TjR4NVV6bnBITlFXSWdwckN6UTBGSjV4bTNr?=
 =?utf-8?B?QlBYMG83cmo2aFBNRDlCamFwVU43QlZ0Tmtzb3Qxek51YXQ0ZVk3NDBrUW1z?=
 =?utf-8?B?TkwxODBPWUlSdFUzY29LVWZRNzNncXRGZXJBSUZ2OURVaDRGTGEzVkx3OXBk?=
 =?utf-8?B?ZVlnRjJiUWE5OGRyVzlUZ3pRbGZmSHY1ZE9tNy9PdlBXejRsdXhYNXNUNU83?=
 =?utf-8?B?R3hNNEhJMW10T0IyY1lidytlMWpnMkhTVXprcUZiUERhRThJKzNKZ2pLdS9T?=
 =?utf-8?B?c0tkbG9nUnVpOGtodkx0K240MnhQSEhvWXM4ZkloRW5ZY216YXQrR1ZqUXR3?=
 =?utf-8?B?S093MHhIQm1mNnd6Smg4N1hOazgzSExOZVhlV09CRjlESzVnZmVQc0JzWEhN?=
 =?utf-8?B?dUFTSWxsKy82c2ZUakNkejY1cldGRzQ1UlU0cm83dmIwYlJwY1lva3R0OWl6?=
 =?utf-8?B?T1Jad3hHcUtYelNtdVBLWFNRTGY5Nks2VWlFZnhyMnQ5RVdHeXBtQlIyeVp4?=
 =?utf-8?B?V1Z6M1dOTUVjMUFDV3AyQWE1SmZnKzBDOUtBWjFnL3gwRlV1cWhoUlYrYU1y?=
 =?utf-8?B?N3JCK3NUK0ZGbnR6RmdVUW1VQUJOQXdWWjVRY1lNMFdZdnFId28ra0xHYzZF?=
 =?utf-8?B?SVE0REMvaUpQaGV0bmRNYStqOHNEVkhVZnVZZDc4bDAxQjhxTW5NcmZUL0hF?=
 =?utf-8?B?eXhacjNTMndBckpDU2xhU1dVMEhicXdFUm5FblNnbUFNZzJ5T1lBdngrcVhp?=
 =?utf-8?Q?7BpVQJtab4C5JCztsWvtHwmTK?=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:       7HLm+PvShr2Q1enfq5hzOmtvqaLwddeY3bQT2Nt7c9pRmDcfYJVC1XAKOo+KFj1TguprjOUFNmjD01U6RZBPhs4wZz7Bc2DvZ3+GvHVFc4m2kwZ7C46c29EcsyYQ/yk3skah+s8hWr9unZdF/jH3VCDpP6f2kT1OzHPYZDY2/aeRHetsTcFT6oTxIKvcva5/9sc0vPhYJy+LKjEnVrVeeBSzLu2Q9UiQufiAvJWFYjVxtJjERKi7LH0hPdthTIDOFN4V69agPfIvJv80XY2iR5YJLOc0eF77Vx9IujMpQhzFWSN0vvHztbsVmMPH8ADMnncyejUNg67H/AOAbvrtdlfK1dRAAjt2mqJXOooz3EsSbW3PoKtDrp/zdyO7UCTiZ5p1asc5oQUnSKqMEgpydBU+FRbwWxy+WV7mQECuOlcqL3xaI3lS95oHkMREEaABrlvY8OpFrNOn/ek2UKfv0I4KQZCw0sGIsQBiLukRsGN5TRJHhmbq6XK88RVP+O/QwrD1A9NeTg7m0qPffVUxngJPFTOdhBpS+osAsH7n8q/sK1CEwn3q2SWHQrnhbmMCxlHsBg5NZatHieC3maQZ2pndUyX3ONUNkMYUffbcUY0V4JzsN8a7slMBAvSWEbKGejq07lPo9LwJpu+5RhWw+EvVhWX9cO1PS9QIghXx+5/iC8i5OX9HylJQytdUnHO/aEGIXKbTWNPbPrfsMLlCXKb/4szQ0xUoHIvfd2cnFWcrhVV+yaaWplOaTSaZinZ4tDWaagGvVH6ZI6ktmCZShQ==
X-OriginatorOrg: WellMed.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a544b184-313f-4810-f957-08db98106d24
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 13:07:32.0496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 85f46a4d-265f-41b9-aaef-c494b7617e7f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ohE/DsnpeE9XW/Ez6ujUta5+oxTP9RmrCUk5/XVHvDuQ88Xlg3GAYfVaiw/dVmVbRzkN+fJ0USbrZ8UmXt2cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5593
Content-Transfer-Encoding: base64
X-IP-VFilter-R: R
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PkZyb206IHJzYmVja2VyQG5leGJyaWRnZS5jb20gPHJzYmVja2VyQG5leGJyaWRnZS5jb20+DQo+
DQo+PiBJIGFtIG5vdCBjb252aW5jZWQgdGhpcyBpcyBhIGRlZmVjdC4gVGhlIHJlc3VsdCBvZiAt
LXNob3J0c3RhdCBpcyB0byANCj4+IHJlcG9ydCB0aGF0IHRoZXJlIGFyZSBkaWZmZXJlbmNlcywg
c28gaXQgaXMgcG9zc2libGUgdGhhdCAwIGlzIGNvcnJlY3QgDQo+PiBoZXJlLiBPdGhlcnMgbWln
aHQgaGF2ZSBhIGRpZmZlcmVudCBvcGluaW9uLiBJIGNhbiByZWNyZWF0ZSB3aXRob3V0IA0KPj4g
aW5jbHVkaW5nIGFueSBvdGhlciBvcHRpb25zLg0KPg0KPiBUaGUgY29kZSBoYXMgYWxyZWFkeSBk
b25lIHRoZSB3b3JrIHRvIGlkZW50aWZ5IGlmIHRoZXJlIGFyZSBkaWZmZXJlbmNlcy4gPiBXaHkg
d291bGQgaXQgbm90IHJldHVybiBhIG1lYW5pbmdmdWwgZXhpdCBjb2RlPw0KDQpBbHNvLCBzaW5j
ZSB0aGUgLS1leGl0LWNvZGUgc3dpdGNoIGhhcyBiZWVuIHNwZWNpZmllZCwgaXQgc2hvdWxkIHNl
dCB0aGUgZXhpdCBjb2RlIGFjY29yZGluZ2x5Lg0KVGhpcyBlLW1haWwsIGluY2x1ZGluZyBhdHRh
Y2htZW50cywgbWF5IGluY2x1ZGUgY29uZmlkZW50aWFsIGFuZC9vcg0KcHJvcHJpZXRhcnkgaW5m
b3JtYXRpb24sIGFuZCBtYXkgYmUgdXNlZCBvbmx5IGJ5IHRoZSBwZXJzb24gb3IgZW50aXR5DQp0
byB3aGljaCBpdCBpcyBhZGRyZXNzZWQuIElmIHRoZSByZWFkZXIgb2YgdGhpcyBlLW1haWwgaXMg
bm90IHRoZSBpbnRlbmRlZA0KcmVjaXBpZW50IG9yIGludGVuZGVkIHJlY2lwaWVudOKAmXMgYXV0
aG9yaXplZCBhZ2VudCwgdGhlIHJlYWRlciBpcyBoZXJlYnkNCm5vdGlmaWVkIHRoYXQgYW55IGRp
c3NlbWluYXRpb24sIGRpc3RyaWJ1dGlvbiBvciBjb3B5aW5nIG9mIHRoaXMgZS1tYWlsIGlzDQpw
cm9oaWJpdGVkLiBJZiB5b3UgaGF2ZSByZWNlaXZlZCB0aGlzIGUtbWFpbCBpbiBlcnJvciwgcGxl
YXNlIG5vdGlmeSB0aGUNCnNlbmRlciBieSByZXBseWluZyB0byB0aGlzIG1lc3NhZ2UgYW5kIGRl
bGV0ZSB0aGlzIGUtbWFpbCBpbW1lZGlhdGVseS4K

