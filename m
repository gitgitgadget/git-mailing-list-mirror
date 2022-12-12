Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45112C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 18:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbiLLSPD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 13:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbiLLSOe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 13:14:34 -0500
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C3B16597
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 10:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barclays.com;
        s=barclayscom20180719; t=1670868657; i=@barclays.com;
        bh=01kuxOiYhVvLItiEYL2Na/bSbkDj/ISyeNfo1eYM1+A=;
        h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
         Content-Type:Content-Transfer-Encoding:MIME-Version;
        b=YRyzKXvQPUt1Wuiy4stgV5G19vGxU0zkGzMxdBoz4qrgyQ/uOe4vqivVlU7KaHhDI
         1SAOFSeg3SkC4zX0+tYkOvJd7nRG2pCb4nVdCMFHiqEgWyGKOgMNpyDIzFcwq+rsRp
         XLf0X33Po4AEI0Vf5hPKByNt87t2BNnlSvTCrl8sgIxdzEIQt8OHRQnJ6rDn2MaLjU
         m3kB/t1C4MEyfQbzPtXvib3Gc9V2ZVbpg2Rnfb0GTNHFN367GA8/3MOpzL+x20EAyQ
         IiTourK99yEh1DpQ1bL1WLuVR9DaMuz6BbpqTGWkhrI0SRRyDfR8S7yDd1CT+CAnM5
         Av4xROBkjB00g==
Authentication-Results: mx.messagelabs.com; dkim=fail (bad signature) 
  header.i=@barclays.onmicrosoft.com header.s=selector1-barclays-onmicrosof
  t-com; dkim=fail (bad signature) header.i=@barclays.onmicrosoft.com 
  header.s=selector1-barclays-onmicrosoft-com; dkim=pass (good signature) 
  header.i=@barclays.onmicrosoft.com header.s=selector1-barclays-onmicrosof
  t-com; dkim=fail (bad signature) header.i=@barclays.onmicrosoft.com 
  header.s=selector1-barclays-onmicrosoft-com; dkim=fail (bad signature) 
  header.i=@barclays.onmicrosoft.com header.s=selector1-barclays-onmicrosof
  t-com; dkim=fail (bad signature) header.i=@barclays.onmicrosoft.com 
  header.s=selector1-barclays-onmicrosoft-com; dkim=fail (bad signature) 
  header.i=@barclays.onmicrosoft.com header.s=selector1-barclays-onmicrosof
  t-com; dkim=fail (bad signature) header.i=@barclays.onmicrosoft.com 
  header.s=selector1-barclays-onmicrosoft-com; dmarc=fail (p=reject 
  adkim=r aspf=r) header.from=barclays.com
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSf0wTZxjHee+O9iDcdhQrbzsloYKLcz1+TCL
  TZZrFDDaWYSSMSEzoFc62sT3YXYFi3Mo0G0upgSxj1RpAu4oBhWI1ZR0WFlwwMFSmmFjjxhZg
  EZDsR93KZpX1eqjbf+/zfL55vt/nzYOjMq9EiTMWM8OxtFElScTaSz6oVfezjsrsgTZ5vm2qG
  cn3hx6AnUjhcPs5aWHIm7YbKY83sNpqiyZeb2+/Cmruqi32wUlJI2hV20AiLiP9CJzr8EpsIA
  GH5BbYH/4JE8FdAJtu2YBYfIrA4f4AJqhkZCsCl0KlInAjcOXaMUQEjwAMjh8UACBPo7DlizN
  ALFzxsHepERVUgPQBuNxTKQCMPI/CU7evrDp2IPDvRR8iFtMA3h8MxnJJyEzo9HtiJmvIDDj2
  2R2pDeA4Sirgsa5SoZ1Cvg2n+36QipIi6Pi2aVX+Bmz3CmPwqFsmvLm8WWgT5D54Kbz4zMppj
  wABJJCvwaAtIhWTroXh8XOxOSiZCu/MdiLiN5HQfek6Kr7lcH7mcbwwiCA7MDj8yUAMICSELW
  fCqyvXwYj7u9U/Xg9vdDYD8b0DPpz0SVvBq87/eDhjq22Cnq+zxHY6/Lz5Z6kzljsZjh2fxU4
  CrAfk8QxXx3DqHErLGXR6s4k2GCn6oJqmmFp1PcOb1bkUXc9TDM9TfIOp0lhFsYzZC6KHU8Vn
  jnwFFtwRagQocEQlJ74scFTKntNWVzXoaV5fwdUaGX4ErMNxFSQGDFGWzDE6xrLfYIye3xMM8
  STVGmJrWRQTfA1t4g06EY2DV/ApXyCA4t4h2zeoDGOrWUaZStQfiEpJQaqvZZ8OenLKN8B6ZQ
  oB4uLiZEk1DGcymP/PF0AqDlQphFWYkmRgzU/9FqJRkGiU8vk2IYqZfoaUjYh8VDW0IX33xqE
  GR8URYuKvEv8cUTzq8i4mh9J/te7a6DIVqHtnP+4ulF/RVCfge/Z1R0yeNwdllpVA+q49vt8c
  H57fkW27XX5xtm9tGXEgQ/kyOKV+N/TLvGIl4wSY6tvGpRVp2+zFpObC/sPvo4+KdLmKt9Y9q
  BjTefLvNWeNpniu+mcm7hmw46+n/vP7NF5nt2rmrp10ht7bPLl8aLtLo+o5ehSEv2/qOrTlOn
  uZWirN3qBUnf3T32stLnPmvFgymqXZ+3zizvBMSx7QDk7kNhzp7nJdfjh3ePuJd7Yq0gKTyQX
  Bm3m+vZtKCoM/uqzLH1HT7K0/XujtdGP3e5gcFcbr6ZyXUI6n/wVOQRtRRQQAAA==
X-Env-Sender: Mark.Yagnatinsky@barclays.com
X-Msg-Ref: server-19.tower-537.messagelabs.com!1670868631!13371!12
X-Originating-IP: [157.83.125.117]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 23938 invoked from network); 12 Dec 2022 18:10:56 -0000
Received: from unknown (HELO IMSMGSLB602P.barclays.com) (157.83.125.117)
  by server-19.tower-537.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 12 Dec 2022 18:10:56 -0000
Received: from IMSMGSLCP04P.barclays.com (Unknown_Domain [22.112.132.23])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by IMSMGSLB602P.barclays.com (Symantec Messaging Gateway) with SMTP id CE.C7.15967.0BE67936; Mon, 12 Dec 2022 18:10:56 +0000 (GMT)
X-AuditID: 0a318843-5e729a8000023e5f-57-63976eb079e9
Received: from mukpbcc4meg0007.collab.barclayscorp.com (Unknown_Domain [10.250.250.254])
        by IMSMGSLCP04P.barclays.com (Symantec Messaging Gateway) with SMTP id 78.C4.48573.FAE67936; Mon, 12 Dec 2022 18:10:56 +0000 (GMT)
Received: from gbrpsm020010139.collab.barclayscorp.com (Not Verified[10.32.169.43]) by mukpbcc4meg0007.collab.barclayscorp.com with Barclays Capital Filter ESMTP (using TLS: TLSv1.2, ECDHE-RSA-AES256-GCM-SHA384)
        id <B63976eaf0000>; Mon, 12 Dec 2022 18:10:55 +0000
Received: from gbrpsm020010134.collab.barclayscorp.com (10.109.149.15) by
 gbrpsm020010139.collab.barclayscorp.com (10.109.149.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Mon, 12 Dec 2022 18:10:55 +0000
Received: from xukpbcc4app0192.collab.barclayscorp.com (10.234.4.43) by
 gbrpsm020010134.collab.barclayscorp.com (10.109.149.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20 via Frontend Transport; Mon, 12 Dec 2022 18:10:55 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edge.barclays.com (10.234.4.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Mon, 12 Dec 2022 18:10:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yo3nRb3arqDPSr+BB9o/RKsnRnelSZqzq1xV9OOZPFCV4e4LhFdVU+0jqrfEc+N3Z6kupideVYEXjF3SMD/YyybYJu4XFXUEo5iU/m6a6mzNWoNU1D3YNzD+N6kJLKAWdF4dYp3U5JT7xrULdhh9/efD1ljvw//Vr0eKRzVBwn//713MJ/6pVIqlmy049eZ9k0z5CC+hBqJif/OUe28p3NrxhgDHjg76rCgZ2IbbPYh0v/iAyo/NIh+d7RvspzN4cXP9h+tBNSbsKrwe8gf8+QN7qSdGzQvKSGPvTmTaqw09vvRNMOqwHybN6FuSyrw2nvaNuvungpSnHbujYaqNzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCa2dq4ObpBSjDk9XWv1WIndEddPe8HIRU/o1YcWJJw=;
 b=aIO3GA1vsregl/XjY7GqNRAW1okGvqoIoq7gYiS0Dp6tLwu7uidCCab/83o3tlj197RJJoZRbuKhtvzahSyP4WdG+eIhF1M2WgiuAN1Q5kwZKw8jd/wAJZoaL7jg9kY9drzvfX0qjDeUwTddjvaqurEp4/+ZJNuGckxHAv95VteYZNWZmTlfrCph+8vsTlSho2G5R5nFfeLgjbaMpdiq83lf973ZLM+ZHrycEvjBPk7j8Vo/4jxO/RzxbJYnAtN9FQvliYlSHZKr38mmh5eM2LQJC9YDcIaX4QYa8cYo+KPEDNba7dtU8/esnD6fdz0fmli+NpCa9WmIUyjMw7gvQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=barclays.com; dmarc=pass action=none header.from=barclays.com;
 dkim=pass header.d=barclays.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=barclays.onmicrosoft.com; s=selector1-barclays-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCa2dq4ObpBSjDk9XWv1WIndEddPe8HIRU/o1YcWJJw=;
 b=qwAgM/h7BIhA1wJDG87vHtlvKb4JiJwG/Q6FubqrCamlI/rg7uWGecKceeZ2tsAkEp32DCyYKg1ULIZQyTEmQsSA1ap2U9BJq7tW2C2blxA4i1+srwZIq6TqC97DjNH/EoLX0Ci5hsmuPqRvRB7NKenvezNKaSeLUBirjRdKkXM=
Received: from MN2PR12MB3616.namprd12.prod.outlook.com (2603:10b6:208:cc::25)
 by CY8PR12MB7516.namprd12.prod.outlook.com (2603:10b6:930:94::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 18:10:52 +0000
Received: from MN2PR12MB3616.namprd12.prod.outlook.com
 ([fe80::fd08:824b:d68d:2ad0]) by MN2PR12MB3616.namprd12.prod.outlook.com
 ([fe80::fd08:824b:d68d:2ad0%3]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 18:10:52 +0000
From:   <mark.yagnatinsky@barclays.com>
To:     <konstantin@linuxfoundation.org>
CC:     <git@vger.kernel.org>
Subject: RE: feature request: git clone --branch should accept commit hash
Thread-Topic: feature request: git clone --branch should accept commit hash
Thread-Index: AdkORLZJEPPgK2FDTjiHwr4G4/kKZQABEePwAAC/IoAAAA/fAA==
Date:   Mon, 12 Dec 2022 18:10:52 +0000
Message-ID: <MN2PR12MB361678CE59236032FE6521F0F9E29@MN2PR12MB3616.namprd12.prod.outlook.com>
References: <MN2PR12MB3616CCD1EDC3EB976CE32546F9E29@MN2PR12MB3616.namprd12.prod.outlook.com>
 <MN2PR12MB3616C1F2E97A18547740651DF9E29@MN2PR12MB3616.namprd12.prod.outlook.com>
 <20221212170547.a23nyw6j7sco3n4b@meerkat.local>
In-Reply-To: <20221212170547.a23nyw6j7sco3n4b@meerkat.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_c754cbb2-29ed-4ffe-af90-a08465e0dd2c_Enabled=true;
 MSIP_Label_c754cbb2-29ed-4ffe-af90-a08465e0dd2c_SetDate=2022-12-12T18:10:49Z;
 MSIP_Label_c754cbb2-29ed-4ffe-af90-a08465e0dd2c_Method=Privileged;
 MSIP_Label_c754cbb2-29ed-4ffe-af90-a08465e0dd2c_Name=Unrestricted;
 MSIP_Label_c754cbb2-29ed-4ffe-af90-a08465e0dd2c_SiteId=c4b62f1d-01e0-4107-a0cc-5ac886858b23;
 MSIP_Label_c754cbb2-29ed-4ffe-af90-a08465e0dd2c_ActionId=a95a3816-2122-460d-8afd-5dbb5dc62dc0;
 MSIP_Label_c754cbb2-29ed-4ffe-af90-a08465e0dd2c_ContentBits=0
barclaysdc: Unrestricted
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB3616:EE_|CY8PR12MB7516:EE_
x-ms-office365-filtering-correlation-id: 9775b7b5-5a92-47fa-e031-08dadc6c3480
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NBGpuOyjYm6EqFCzuvlbSYiOE0m8dQ7htGWpEz/OVqBvPEDNVFGKL8lR9B/RyA+wqWw5x+fCMUCn/cw4uAsbcNJl7iIeTQ410TkYcXdvkRtZ1SkHVXUUiv854ouA0kVi499qw8dszeTSCO2L0ghw6VVlj/QWYF7EHCKgzJtV76RyoZTp6e2O2RSwgO0dngu8JGo6E56/Hg4bwcvAu36MrMR3zLDUAsNJPUhKtWJsKGpN73bdQiWBdR/nAY2yM4c6A3vxjijBA8gp45cvNsItoVIoczk2ACfAdx+H/N0dsRAdjFVsq38yUhfRJe1qN5ERWz+1nLvWKGsNkcfD8Pibu2izWbYb3KzvR08j+NHQF/UnNYl57pX8SilnKaGAlAUoYqcEnw7NHHEDfHw89JLDaFe1QnGW3mXZyM3ly0mt7hKPTX8xy66dQ5zFA9ii/r6agwTCyZaiRBSxCKk82pp0Txc6QMCr+dqQtFXQ9OBjGS6i8VD1wXOaxdvWBHqjpHOHhFXGFS8lmmuf0F5eV5YhGcNs9DHy6psGiyKP1cnB0jguicsADLtMmCvqGmimza/VCJDFHQpniW9oC/gQisgX+DKgZ1Jf4Wp02kF3V8Kevo6R5Ksay57yvVjMjMr/i1ifoXgZ00t7nFgV3SAPUU03DcW7aepUo671GDAUS3Frj7p4ZWYhNi4IzaEYmMSiU6wSLaHmnM2FB5wB/qhY5ucSnoHnL3wF5KkwgWAKMGrin5c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3616.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39850400004)(366004)(396003)(346002)(136003)(451199015)(478600001)(38100700002)(82960400001)(55016003)(2906002)(71200400001)(66899015)(83380400001)(966005)(33656002)(6506007)(53546011)(26005)(122000001)(9686003)(7696005)(186003)(52536014)(8936002)(4326008)(41300700001)(64756008)(8676002)(66556008)(5660300002)(66446008)(66476007)(66946007)(6916009)(76116006)(38070700005)(86362001)(316002)(10290500003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2xnVnRrNUpwZG9Ubis2Q0IyUUc4Y1dsZWhUOExTaGNkYlYrUDFwWXZRNW1G?=
 =?utf-8?B?VlFRK21DNFE5d0pMdE9NQmZzeUtmSGI0U3BZRVVObTlibExxb1NxZU50WlhF?=
 =?utf-8?B?NDg3dkNhWERMcWZNZ0wzLzBYUi85VDJnS2dIeUJNMmozNjdURXp2VWhzUUhl?=
 =?utf-8?B?UnBtQkZiU0FKM2lrZUJrYjVpdG53eW9pQ0RBRTJIZHBRREhuc0tXU2dXZGlU?=
 =?utf-8?B?Uko1L0hqQzRUa3JZdHhRMHk2UzR2eVhWU1VPalBpY250aUxVbWhkQThubFRN?=
 =?utf-8?B?YkRyWGFnN3pacEMrcFQwQ1NQM21JZDk0ZzhOWjlMdU9GRjNLNkR2K3QyWGN5?=
 =?utf-8?B?STR5NHBPZFhROFpYQk5EMTJSdmU5cU14NnYwQk1SS3ZHenZYdStEei93Z28w?=
 =?utf-8?B?M0NPV3p6TGUra3N0ZXoxOUI1aHkxSFRpbGdOZUJnR0ZDUHJJTjMzREppbUpx?=
 =?utf-8?B?ZzZrb2FpS2RDdWpwUEE4YlkzakJZVEJ5aGE5MVAwNDN1VjNkbUdKRjJqTjBU?=
 =?utf-8?B?QkF3VEJ5RG4rWVE5amkwZXdBYWlhZnVsWmFuNWEwekJsZEZ6disvd0hPbUts?=
 =?utf-8?B?dzhpbVRnUHpOa0xVWkVQeXhuSndHVHhCRDNDVHlmQ3JQLzYvU3o2UjI4dHpR?=
 =?utf-8?B?ZXFxN1ZpZGVBY0NDZy9KbHFyZk1Nb0RJZ2VkVStoUFAxOXYxeHF0YUtoNlJE?=
 =?utf-8?B?QVRzVmRqeFlNOHlRNEZSd0tva3JNekpxQzFQK2dKa1J1RGJHQnJtYmE4a3hP?=
 =?utf-8?B?anF4WTExNEF1RUcyT1lvMFhRcUdMYzUvQ0U4QkcwRFk4R0JJRXpQaFVDcXFy?=
 =?utf-8?B?YjdVRDdsMXNBeE1RbzBJTEdFS0RzSTZ6cTNnbEo2aDRoRDdTTHJDcHZ6SUFO?=
 =?utf-8?B?MlZpT0NDVFVQM0RPTnY4a2ZvVDZNdjhMU2daSTVGamQ4a2JqbGxEMXhYcDJk?=
 =?utf-8?B?NU9PcDg0ZERTL3dpbkdzc2ptcXZNNGpBd0M4amJvK1pBRENhVTZIcHNnMDMr?=
 =?utf-8?B?Q3ZKaThQNm5ROWN1ZTMyNlo4MHB6VkR2TGdPWmI2UTJhb1NwS1ZHNG1EZzg5?=
 =?utf-8?B?Vllnd1ZBM1pHMHZpQ3VhNkgxeWh4RXN3VHNwTG5IUjlmNmhvdk5DeXBqUGdt?=
 =?utf-8?B?QTluNDdzYkF4NTBjYmhoTWVrUVR4U1NzMVU1WW13dkVObkE1SFhEM2VJaloz?=
 =?utf-8?B?ajQ0V2NXcExzRVJ5SXZEVWhSTVVJc1ZSRjRBVHBIcVBFdG5LWjlOS0J5Ri9a?=
 =?utf-8?B?MkUzZ2lOOGFscWw4Tll2bHNSVnlHWEpFdnpSSDdFRzlPYnBTYlA3RGlyd21D?=
 =?utf-8?B?cloxU2pvQmFhUFZxZThFc2Q0Y3owNThtdzF6em1oNHAyM29BbTJxTkFOMld3?=
 =?utf-8?B?L09BaGFBaHJqSGY0bnVSR24zdmUzLzhBbFJ6YlAxbjU1MWxGaEJYYkRXZklF?=
 =?utf-8?B?VjFUalhqYVhLOTY3S3VXVGNxVERnYTJUR2ZVMDlYR0VwN2RwbE50OGRQbVVk?=
 =?utf-8?B?M1JzcVAwdjJjS2VWVjhBTlJLVnR2aGpNZlJxdWJmRUhPSEI3dnlnbjBrUHZX?=
 =?utf-8?B?dHhianlFWmNiZ2QvUjR0cis5T0NTSVB4YkNMZU9VNytJK3R0bjRXRCswQjJy?=
 =?utf-8?B?UGFTUWdOWXg5YVJVc3dOUzJ2eEpLVS81OXlKZ2F5RjU2NFJuVnpETmxEcGZp?=
 =?utf-8?B?KzgzaDZyOXg3SEoxekdZU3Z4VTE1U0w4WU1Oa0F1dUtNRlNuL3VlK0ZFeUxK?=
 =?utf-8?B?YWQvbzcvTXBYYVBab0VIejJCdm15Zm5iMW1XSXU5WXNGZ2ZObUdvSjgzVmo2?=
 =?utf-8?B?eEtKRVlvVHRmRm9xaTZJdEprRTROY082WEhmRy9DVEU2WnNFU0ExQXVZczE3?=
 =?utf-8?B?SXFCU0lCemxNZmMyeXJTdURyNXFISkk4UG1ldytrZ0l4bkRSMFIrc0F4UTN6?=
 =?utf-8?B?Qjc2YWV1Vk9IZFdHVGp0T01Ga3lEeTUraTZFZ3dQYzB6MVpYSjBSRVNreXJw?=
 =?utf-8?B?MTJHK0EvZk5uODBlUURNa3ZXd3RBYjNBVkl1YU96Rk5QOFNhbGllc3VNS1gw?=
 =?utf-8?B?MFRSQi9URFg2L2NSVkNMaE1DU1lieWlLbW0zM2Z0ZDVsYlpwNU5WalJlOGxv?=
 =?utf-8?B?UXZZbUprRFZtMWdhMnNQVEJGRTQva000L1lkbHVMYUFNclE0UnRNcXlVbndy?=
 =?utf-8?B?Ymc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3616.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9775b7b5-5a92-47fa-e031-08dadc6c3480
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 18:10:52.1161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c4b62f1d-01e0-4107-a0cc-5ac886858b23
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: avDKuzgPi2c9G4vbXVRP2pGV3+GnkWxHdM1D9Nz2SW2kYXaqDkvH5HIf07l3vTMEa+pYpLZNed++h9dVtmpt8BWRL9pa5htjycx8xAX77Nk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7516
X-OriginatorOrg: barclays.com
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsUiVtAirrshb3qywc7P7BZdV7qZLHZ+/sLo
        wOSxf+4ado/Pm+QCmKJEbUpyihWKU0tKMvPSbZV8Q4NDlPTtEkQz9lyezFSwQq+iZ/cFtgbG
        CbpdjJwcEgImEhu+P2ABsYUE9jBJPNjoDRN/9fcTexcjF1D8LqNE16Hr7BBFnUwSn87oQiQm
        M0nsmbeAGcJZziRx/fUmqJYGJomHsx8zgjiMAsuYJXreT2OHclglDi+dCbaRUWAHo8S0l+kg
        NovAVmaJ3kZHiPZFTBI9zdtYIJxHjBIfj71lBaliE1CVmLVzPROILSKgInFy0i2gsRwczAKS
        EjOWhYKEhQW8JO6vu8sOUeItMf1IO1S5k8TcTTfZQMpZgMZc/qENEuYViJHY8/01E8Sqh4wS
        Uy9BgoNTwEbiZtcfdohDxSS+n1oDNodZQFzi1pP5TJBgEpBYsuc8M4QtKvHy8T9WkEG8AktY
        JP7/fwJWxCQgIdG//DszxKByiQ+7e9ghGmQlLs3vZpzAaDkLydxZYO9oSqzfpQ8RVpSY0v2Q
        fRbYrYISJ2c+YVnAyLKKkcfTN9jXPdjHyczAKGATIzB5cBl2OO9gvHjihd4hRiYOxkOMEhzM
        SiK8qhrTkoV4UxIrq1KL8uOLSnNSiw8xmgLDYCKzlGhyPjB95ZXEG5qaGhiYGVgYmpobGCqJ
        88o3LUkQEkhPLEnNTk0tSC2C6WPi4JRqYApcFPP83GmLTjGVt3u5/vPd2p2i8+mkeMHCZL9X
        tVUGjxq4t3knZiS3TpWaFqXG5ODbeT3WzUjjvV7jxo2Hsk2P5Diauk+7H1KlaS9xlkE5wudM
        l3+W7t3zCy+nP1B/adtg2H3Qf+Xk3EOuorvW8jUVi31Y+mD2k8j165X459rduTHdzCC84Guf
        59b6IFFVk5B+4W2Zb+6+FtjhKLlh8+nWiTUGq6c+VDuwUfujXO2GpNgeRj9zn7Dyh61rPp7a
        cjFtnX34cYXAf7a51ve05+usVVhz6Obt2fXKuScE1pXwG9iUc+n9EEyxDPGwkZlzflWaVVTm
        kqa5p147NnnPOtz/+MXlBDfjpEf5e18cVWIpzkg01GIuKk4EAPzhTHanAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsXC9evXP90NedOTDY5vY7boutLNZLHz8xdG
        ByaP/XPXsHt83iQXwBTFZZOSmpNZllqkb5fAlbHn8mSmghV6FT27L7A1ME7Q7WLk5JAQMJF4
        9fcTexcjF4eQwF1Gia5D19lBEkICnUwSn87oQiQmM0nsmbeAGcJZziRx/fUmqJYGJomHsx8z
        gjiMAsuYJXreT2OHclglDi+dyQIyjFFgB6PEtJfpIDaLwFZmid5GR4j2RUwSPc3bWCCcR4wS
        H4+9ZQWpYhNQlZi1cz0TiC0ioCJxctItoLEcHMwCkhIzloWChIUFvCTur7vLDlHiLTH9SDtU
        uZPE3E032UDKWYDGXP6hDRLmFYiR2PP9NRPEqoeMElMvPQA7jlPARuJm1x92iEPFJL6fWgM2
        h1lAXOLWk/lMkGASkFiy5zwzhC0q8fLxP1aQQbwCS1gk/v9/AlbEJCAh0b/8OzPEoHKJD7t7
        2CEaZCUuze9mhLDtJX5f2AYV95W4f30P0wRGs1lI9s0Ce1NTYv0ufYiwosSU7ofss8B+EJQ4
        OfMJywJGllWMPJ6+wb7uwT7OAQYmAZsYgWlCrKBFfAfjyiMv9A4xMnEwHmKU4GBWEuFV1ZiW
        LMSbklhZlVqUH19UmpNafIhRmoNFSZx3ZrNBspBAemJJanZqakFqEUyWiYNTqoGpgkna5M/T
        ZU9PJC9QOpq0aGngXqbz6zNfPW3jXOw3nT1U/8Jsx0kplzYLuv60fXvou+BNoXeZyTPYam6m
        Gk4uFv7jVrPWcPWfEOvHO/98l+rsTcrRz7mx8QT3XPbDQn0FCznMrcMtN6kwl5g9VHmwZmHh
        Vrl3Ntm17y8nzNqcKc3YGix9Mv/3wjMi61ad5F8rnapzZkLpjW8t/mHTRH6JJ9yO9kmXjXV2
        E071U37uoFpb0DT5c7bMp5XCK0+6Mh+bzhYW3/bnaW5P+p/PG24oxr3XOxiiLS3UX1as0D8n
        6KWR8s2DTIrbpWuzHgodLY2wOnli9erquim7clYYcp1ZdWRfnRnrj9vPY2V92x8osRRnJBpq
        MRcVJwIAwb0fH4IDAAA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

U3RpbGwgYW5ub3lpbmcgdGhvdWdoLiAgSWRlYWxseSBkZWZhdWx0IHNob3VsZCBiZSB0byBhbGxv
dyBmZXRjaGluZyBhbnkgY29tbWl0IHJlYWNoYWJsZSBmcm9tIGEgYnJhbmNoIG9yIHRhZy4gIFNl
ZW1zIHRoYXQgY29tbWl0IGdyYXBocyBhbHJlYWR5IG1ha2UgdGhpcyBwcmV0dHkgZmFzdD8NCg0K
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEtvbnN0YW50aW4gUnlhYml0c2V2IDxr
b25zdGFudGluQGxpbnV4Zm91bmRhdGlvbi5vcmc+IA0KU2VudDogTW9uZGF5LCBEZWNlbWJlciAx
MiwgMjAyMiAxMjowNiBQTQ0KVG86IFlhZ25hdGluc2t5LCBNYXJrIDogTWFya2V0cyBQcmUgVHJh
ZGUgPG1hcmsueWFnbmF0aW5za3lAYmFyY2xheXMuY29tPg0KQ2M6IGdpdEB2Z2VyLmtlcm5lbC5v
cmcNClN1YmplY3Q6IFJlOiBmZWF0dXJlIHJlcXVlc3Q6IGdpdCBjbG9uZSAtLWJyYW5jaCBzaG91
bGQgYWNjZXB0IGNvbW1pdCBoYXNoDQoNCg0KQ0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVk
IGZyb20gb3V0c2lkZSBvdXIgb3JnYW5pc2F0aW9uIC0ga29uc3RhbnRpbkBsaW51eGZvdW5kYXRp
b24ub3JnIERvIG5vdCBjbGljayBvbiBsaW5rcywgb3BlbiBhdHRhY2htZW50cywgb3IgcmVzcG9u
ZCB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZCBjYW4gdmFsaWRhdGUgdGhlIGNv
bnRlbnQgaXMgc2FmZS4NCk9uIE1vbiwgRGVjIDEyLCAyMDIyIGF0IDA0OjQ0OjQ5UE0gKzAwMDAs
IG1hcmsueWFnbmF0aW5za3lAYmFyY2xheXMuY29tIHdyb3RlOg0KPiBOZXZlciBtaW5kLCBJIHNl
ZSwgZmVhdHVyZSBleGlzdHMgYnV0IHNlcnZlciBuZWVkcyB0byBhbGxvdyBpdC4gIFNpZ2guDQoN
ClRoZXJlIGFyZSBnb29kIHJlYXNvbnMgZm9yIHJlbW90ZSBzZXJ2ZXJzIHRvIG5vdCBhbGxvdyB0
aGlzIGJ5IGRlZmF1bHQuDQpJbWFnaW5lIHRoZSBmb2xsb3dpbmcgc2NlbmFyaW86DQoNClJlcG8g
MTogb2ZmaWNpYWxyZXBvLmdpdCAtLSBvZmZpY2lhbCBwcm9qZWN0IHJlcG9zaXRvcnkNClJlcG8g
MjogZm9ya2VkcmVwby5naXQgICAtLSBhIHJhbmRvbSBmb3JrIGJ5IHNvbWVvbmUNCg0KRnJlcXVl
bnRseSwgdGhlc2UgcmVwb3NpdG9yaWVzIHdpbGwgdXNlIGEgY29tbW9uIG9iamVjdCBzdG9yYWdl
IGJhY2tlbmQsIHdoaWNoIGFsbG93cyBzYXZpbmcgYSBMT1Qgb2Ygc3BhY2Ugb24gdGhlIHJlbW90
ZSBzZXJ2ZXIuIFNvLCBvbiB0aGUgYmFja2VuZCB0aGVzZSByZXBvc2l0b3JpZXMgd2lsbCBiZSBv
cmdhbml6ZWQgYXM6DQoNClJlcG8gMDogc2hhcmVkcmVwby5naXQNClJlcG8gMTogb2ZmaWNpYWxy
ZXBvLmdpdCAod2l0aCBhbHRlcm5hdGVzIHRvIHNoYXJlZHJlcG8uZ2l0KQ0KUmVwbyAyOiBmb3Jr
ZWRyZXBvLmdpdCAgICh3aXRoIGFsdGVybmF0ZXMgdG8gc2hhcmVkcmVwby5naXQpDQoNClNvLCBp
ZiBhIHJhbmRvbSBkZXZlbG9wZXIgcHVzaGVzIGNvbW1pdCBhYmNkZSBpbnRvIGZvcmtlZHJlcG8u
Z2l0IGFuZCB0aGUgYmFja2VuZCBzZXJ2ZXIgcHVsbHMgdGhhdCBvYmplY3QgaW50byBzaGFyZWRy
ZXBvLmdpdCwgeW91IGFyZSBub3cgYWJsZSB0byAic2VlIiBjb21taXQgYWJjZGUgZnJvbSBvZmZp
Y2lhbHJlcG8uZ2l0LiBJdCdzIGp1c3QgYSAibG9vc2Ugb2JqZWN0IiBhbmQgaWYgeW91IGNsb25l
IG9mZmljaWFscmVwby5naXQsIHRoYXQgb2JqZWN0IHdvbid0IGJlIGluIGl0LCBiZWNhdXNlIGl0
J3Mgbm90IGNvbm5lY3RlZCB0byBhbnkgb2YgdGhlIGhlYWRzIG9yIHRhZ3MuDQoNClRoaXMgc2l0
dWF0aW9uIGlzIGZyZXF1ZW50bHkgYWJ1c2VkIGZvciBzaWxseSByZWFzb25zIGxpa2UgbWFraW5n
IGl0IGFwcGVhciBhcyBpZiBMaW51cyBjb21taXR0ZWQgc29tZXRoaW5nIHRoYXQgaGUgYWN0dWFs
bHkgZGlkbid0Og0KDQpodHRwczovL2NsaWNrdGltZS5zeW1hbnRlYy5jb20vMTVzTHZSZlJSaFJn
SFphcnJEUGozP2g9dzN3NWJGUF80QUk4UUtQUjhxOTQ3QmNWNFZJd1pTanlyRzBmdnl5NzlrZz0m
dT1odHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi9hYzYzMmM1MDRkMGI4ODFk
N2NmYjQ0ZTNmZGRlM2VjMzBlYjU0OGQ5L01ha2VmaWxlJTIzTDYNCg0KRm9yIHRoaXMgcmVhc29u
LCBHaXRodWIgcHJpbnRzIHRoYXQgYmlnIHdhcm5pbmcgYXQgdGhlIHRvcCB0byB0ZWxsIHlvdSB0
aGF0IHdoYXQgeW91IGFyZSB2aWV3aW5nIGlzbid0IGFjdHVhbGx5IHBhcnQgb2YgbGludXguZ2l0
Lg0KDQpIb3dldmVyLCB0aGVyZSdzIG5vIHdheSB0byBwcmludCB0aGlzIHdhcm5pbmcgaWYgeW91
IGlzc3VlICJnaXQgY2xvbmUiLCBzbyBpZiB0aGlzIGZlYXR1cmUgd2VyZSB0byBiZSBhbGxvd2Vk
IGJ5IGRlZmF1bHQsIGl0IHdvdWxkIG1ha2UgaXQgZWFzeSBmb3Igc29tZW9uZSB0byB0cmljayB5
b3UgaW50byBjbG9uaW5nIG1hbGljaW91cyBjb21taXRzIGJ5IG1ha2luZyBpdCBsb29rIGxpa2Ug
eW91J3JlIGNsb25pbmcgYW4gb2ZmaWNpYWwgcmVwb3NpdG9yeS4NCg0KSSBnbyBpbnRvIGl0IGlu
IHNvbWUgZGV0YWlsIGhlcmU6DQpodHRwczovL2NsaWNrdGltZS5zeW1hbnRlYy5jb20vMTVzTTFG
cmh0SzdHaFdRblBtbnNmP2g9OVZMUWNNVmVDOVg0SVMwZ2U3UWE0ZmljRUZ1ZGFuTFZkNE1CQnRD
a1Zlaz0mdT1odHRwczovL3Blb3BsZS5rZXJuZWwub3JnL21vbnNpZXVyaWNvbi9jcm9zcy1mb3Jr
LW9iamVjdC1zaGFyaW5nLWluLWdpdC1pcy1ub3QtYS1idWcNCg0KQmVzdCByZWdhcmRzLA0KS29u
c3RhbnRpbg0KDQpUaGlzIG1lc3NhZ2UgaXMgZm9yIGluZm9ybWF0aW9uIHB1cnBvc2VzIG9ubHku
IEl0IGlzIG5vdCBhIHJlY29tbWVuZGF0aW9uLCBhZHZpY2UsIG9mZmVyIG9yIHNvbGljaXRhdGlv
biB0byBidXkgb3Igc2VsbCBhIHByb2R1Y3Qgb3Igc2VydmljZSwgbm9yIGFuIG9mZmljaWFsIGNv
bmZpcm1hdGlvbiBvZiBhbnkgdHJhbnNhY3Rpb24uIEl0IGlzIGRpcmVjdGVkIGF0IHBlcnNvbnMg
d2hvIGFyZSBwcm9mZXNzaW9uYWxzIGFuZCBpcyBpbnRlbmRlZCBmb3IgdGhlIHJlY2lwaWVudChz
KSBvbmx5LiBJdCBpcyBub3QgZGlyZWN0ZWQgYXQgcmV0YWlsIGN1c3RvbWVycy4gVGhpcyBtZXNz
YWdlIGlzIHN1YmplY3QgdG8gdGhlIHRlcm1zIGF0OiBodHRwczovL3d3dy5jaWIuYmFyY2xheXMv
ZGlzY2xvc3VyZXMvd2ViLWFuZC1lbWFpbC1kaXNjbGFpbWVyLmh0bWwuIA0KDQpGb3IgaW1wb3J0
YW50IGRpc2Nsb3N1cmVzLCBwbGVhc2Ugc2VlOiBodHRwczovL3d3dy5jaWIuYmFyY2xheXMvZGlz
Y2xvc3VyZXMvc2FsZXMtYW5kLXRyYWRpbmctZGlzY2xhaW1lci5odG1sIHJlZ2FyZGluZyBtYXJr
ZXRpbmcgY29tbWVudGFyeSBmcm9tIEJhcmNsYXlzIFNhbGVzIGFuZC9vciBUcmFkaW5nIGRlc2tz
LCB3aG8gYXJlIGFjdGl2ZSBtYXJrZXQgcGFydGljaXBhbnRzOyBodHRwczovL3d3dy5jaWIuYmFy
Y2xheXMvZGlzY2xvc3VyZXMvYmFyY2xheXMtZ2xvYmFsLW1hcmtldHMtZGlzY2xvc3VyZXMuaHRt
bCByZWdhcmRpbmcgb3VyIHN0YW5kYXJkIHRlcm1zIGZvciBCYXJjbGF5cyBDb3Jwb3JhdGUgYW5k
IEludmVzdG1lbnQgQmFuayB3aGVyZSB3ZSB0cmFkZSB3aXRoIHlvdSBpbiBwcmluY2lwYWwtdG8t
cHJpbmNpcGFsIHdob2xlc2FsZSBtYXJrZXRzIHRyYW5zYWN0aW9uczsgYW5kIGluIHJlc3BlY3Qg
dG8gQmFyY2xheXMgUmVzZWFyY2gsIGluY2x1ZGluZyBkaXNjbG9zdXJlcyByZWxhdGluZyB0byBz
cGVjaWZpYyBpc3N1ZXJzLCBzZWU6IGh0dHA6Ly9wdWJsaWNyZXNlYXJjaC5iYXJjbGF5cy5jb20u
DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fIA0KSWYgeW91IGFyZSBpbmNvcnBvcmF0ZWQgb3Ig
b3BlcmF0aW5nIGluIEF1c3RyYWxpYSwgcmVhZCB0aGVzZSBpbXBvcnRhbnQgZGlzY2xvc3VyZXM6
IGh0dHBzOi8vd3d3LmNpYi5iYXJjbGF5cy9kaXNjbG9zdXJlcy9pbXBvcnRhbnQtZGlzY2xvc3Vy
ZXMtYXNpYS1wYWNpZmljLmh0bWwuDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQpGb3IgbW9y
ZSBkZXRhaWxzIGFib3V0IGhvdyB3ZSB1c2UgcGVyc29uYWwgaW5mb3JtYXRpb24sIHNlZSBvdXIg
cHJpdmFjeSBub3RpY2U6IGh0dHBzOi8vd3d3LmNpYi5iYXJjbGF5cy9kaXNjbG9zdXJlcy9wZXJz
b25hbC1pbmZvcm1hdGlvbi11c2UuaHRtbC4gDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo=
