Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78614C433EF
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 22:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241765AbiFMWkO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 18:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244974AbiFMWkI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 18:40:08 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2099.outbound.protection.outlook.com [40.92.52.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FC22DD58
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 15:40:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flyDsg+kvGhsLmQIvH8hGIv3naKl1kKS7R6nDpw9At8HirX6fTIOozc65r95sqcaORcoBbDWB8UGLpzrLNBGF5zNXCf4SUCQffJdcwsKn1QmRyz/aMNavslFwZhCVQPyAYKoIdFoIcL683HHykYDI2rtq3SAeH3tuWVQVydxB0n1kIYrWycw+aBRW6VSsQoAniZycx2nXrGa1tYfJy2tkYoE9RE6CzSdArudbMbsmu7Y/He6EMPnm6WY2A25B4jxSqf9z5dVA9E0pXz7An5bukdewy7X6JpvJB7c1GHc72eTQNvbtVJ4rP94VWw9LZJCCjKj/hW+JXsyrR4W4voosA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCt6BOFNH4TbsSpnSJ349LZeE4UJYCwovVRheQghYec=;
 b=akood6L7i98mAxcX8o/z9Mc9eb+dugFNRYA9sA8Bavv9y4rvPCN2C96M01mHJzTjl9f9j+hKxRxvMUrYZ1m5Qsbyboj4ENkDzX2CvoIKUMbtySFFXrTVZ+0KQlQkHj1H6PZ2GG6ctX7kO/X6yWJkEiGy5iJZ/Fp63eWPuo3X08nQro2FOazmezjIuerk25tIkihHFAdBYVneez/hPeGq4+Uuc6khvnxn8GrJmE7rXXtkV/ckA/E4j7dFylUZoebK/RkJM+F7Ogc4HixtwEhX/mzEsMPpCWx05yxjX7qoerW7eFmJW5pmAreEGCFbEe1miqcXMOoSwmmKIJ5CQLvxHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCt6BOFNH4TbsSpnSJ349LZeE4UJYCwovVRheQghYec=;
 b=t7fOHW9nzOJj/LqjlsFynI7aPo9cTPb1Cu70E9R/DzSzIMwklgY5JrFDW4vSvCBbBFWWIhjBTyiiPmKoGHUr27nbdBfIILGA+wTRhgKbmaXR81JJByGgrmPQ233FHVTwYKYn0+ULrBjxRO/6mcVO/MaZ+44p0dRJlzyr2zFO+JHZEKWLLZa9Z1uutJPWKl1Y11vXADYuNGtadRBeEZxuC5Y/skABvuZsMyWWuEnqMHwAFfcU/Sgk9kDl45/j3cdEtWYJqHWPt9LKWlyUYXe9i68cgnNm2cYwUq2RdgcgdL7jAGwbCjN4xtopyeSVcjaeC17RKPhPbJmNyBMsYVw+gQ==
Received: from TY0PR04MB5604.apcprd04.prod.outlook.com (2603:1096:400:14d::9)
 by SG2PR04MB2924.apcprd04.prod.outlook.com (2603:1096:4:22::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Mon, 13 Jun
 2022 22:40:02 +0000
Received: from TY0PR04MB5604.apcprd04.prod.outlook.com
 ([fe80::427:299b:b31c:c09e]) by TY0PR04MB5604.apcprd04.prod.outlook.com
 ([fe80::427:299b:b31c:c09e%9]) with mapi id 15.20.5332.021; Mon, 13 Jun 2022
 22:40:02 +0000
From:   =?utf-8?B?4Lio4Lij4Lix4LiT4Lii4LmMIOC4quC4uOC4meC4l+C4o+C4m+C4oOC4sg==?=
         =?utf-8?B?4Lij4Lix4LiB4Lip4LmM?= <sarun515m@outlook.com>
To:     =?utf-8?B?ZGV2cHJvZ3JhbXNAYXBwbGUuY29tICjguKjguKPguLHguJPguKLguYwg4Liq?=
         =?utf-8?B?4Li44LiZ4LiX4Lij4Lib4Lig4Liy4Lij4Lix4LiB4Lip4LmMICYgQk0pIElD?=
         =?utf-8?Q?loud?= <mail-noreply@google.com>,
        GitHub <support@githubsupport.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Sarun515m@outlook.com
Thread-Topic: Sarun515m@outlook.com
Thread-Index: AQHYf3aExfNH3/4NHkmnNJoOU873ug==
Date:   Mon, 13 Jun 2022 22:40:01 +0000
Message-ID: <TY0PR04MB5604E52DCC1BD9EDE31988E3FBAB9@TY0PR04MB5604.apcprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-tmn:  [HdFU1INZZkcFDjCeudBXDthhW0zINQxTHhPHOxhPqRM=]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 752daeb5-46a9-4a09-3536-08da4d8da769
x-ms-traffictypediagnostic: SG2PR04MB2924:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IeonfgNGybqPceU00+th6voJNCAr9+u7OFEHye3/BHJekf0vD4UcnaERHaXTPqAOIGl6vQEgrh9H6OGadZC7Zi3vH2vu1AUZCEhjuoh/3ah5QU1w14jm+85uB1nbJecoLSAgUDyUqeTQ2mfoOznh01qQ/+CPfs/hmau6D31KUyTW8bRhwLRRaOrm8JZHMyShNq5xKJKLqvwUIv3quPUsaE/i4jtqkZZ146bAmfSv6j1E7KffgPu2wLixB8E/I31VbkkYAwh2iICT1VdBHtY4YBufbPCfIdVZF1/XV4jPd/COtbCzifEw1wxKO4TISGMlOpnmLXjC8yTitXHfTwaf/V6F8FCQUudfKSSRl8it9/1hmNR8fhSFGSggmIiHItuv2lDyg1crpvmxj06siLzrJj45taxCv2BDFo3OgV1XM0DfhM9lq9TEIhpbxo8bLTPd4jhUT9K//PIJbPt5mtHE3AH1zLdd46HWCAY+degS6TXZJe+UZr7Z6gNwCo024FSxHQH+e7i7uV7f22erHc4YHgMqOv9brpmtCN43GSbZINlpYH7SgezdiKrEA749VQ7fZkph1OjREFlsZ40ViaUe+g==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czY5NGoxekdXUWNKeWZZd3hHa0tkaCtVZHJjc08yMGNpdkFRSHZnVjVFcFB5?=
 =?utf-8?B?eHVPSUZ1VFR5dUlyT0JBWnFZRXh1bFVRbFhqaGRvUWs3aTg1aEFYT1RDV1d3?=
 =?utf-8?B?REwxb0lqdWdTbVZJNlJkQlhCQU1USERJRFdTNFEwOHBsbUI0ZkNSMHA0TitP?=
 =?utf-8?B?ZjZhT1hQOGcreFdLdXVqVzJyWGNpSENyZnNjMS9zY0plU2VSS2JwOUJZb0lU?=
 =?utf-8?B?d3BZckhxd1JCSTlJT1oxSDQ4TnNJNjJUbUZvYTE0N0JROC9LK2ZGNHhPUUZ3?=
 =?utf-8?B?emUyTllmVGx0UmdBVkhPVkZnTGk0em9JbVJiY0FqeHh4R051ZFE0WExNeFFr?=
 =?utf-8?B?dWk0Z0JPSER2RnhubFR1dHkwTHhDOHNLTVFTRTJwWHVRcS9JbTB5UyszdVJB?=
 =?utf-8?B?SlFMQjhaaU0wSHA0d2NSWjNCZXJOT21VRE1ERzQzTlNWblNaWFgvY1lUcjlw?=
 =?utf-8?B?bzRJNGh4V09qOWZMVjlha1owK3lES3JHcHRLaDVweDhrWW1oS3kvR0l6MTl0?=
 =?utf-8?B?Ym5MOEtCanJuemJBUUQzMFJpQ1pma2ZqNEYrRC80aWdTNVpRclBUUm9jWnNW?=
 =?utf-8?B?KzJNdDUveTF3S3dHQ05JNnNnZW1QWjNOdFl5RDd0WkpVQmNTNEpiZlRWc3VS?=
 =?utf-8?B?TFo0NDdvbEl1S2pMcDhsVTZGbGNQZjlhc2RUdVB3dlZocjdVZWRydE83TUoy?=
 =?utf-8?B?Z0grR0RvSmg2dEMreHZDNnZ4cC9OcTVQbEhlQjJkTnVvTHVFZVRzb0IxNC95?=
 =?utf-8?B?c1JTYldma0tyT1NUUGFsN2FnU0ViNGFTUGhtMm5HMnFaWjJjdCttSGVBaCtG?=
 =?utf-8?B?dUpVRVdmREp1elBGUmdOOVZTbnl0L3Ywb2V0QTZoUm1sdlJXbmNhUkVVcEw3?=
 =?utf-8?B?c1lHWkZjbXpaMkJmbnltaVpMWDVVbE1UZ014dEx5Wm5XNmJwM0FGVEJxeGdW?=
 =?utf-8?B?TzRUS20vMXJJcmczb2V5eWE4citMS0lXUzBVc1dsaTlTVEtLTXIvK3VSZFdz?=
 =?utf-8?B?OTlaRkhQMGNNM3k4SUcveVNaKzZGNmEyL29sM0MvYzd5RVpOa3JGdithN2s4?=
 =?utf-8?B?d05YTGZzY1hqUVAxU0FzZ0hGWk5XcVByVFd2bUlmeVF2OWZERTl2UmRHaWtS?=
 =?utf-8?B?bDFCcDFETmMvVzFhaFJWVXlHd0NLQTBLSUdmbTVTTmVmbE52akhnVDJFQW5w?=
 =?utf-8?B?c3k5WGVsZ1VSbXZqY2VUSG9YMHJQNUlmdUswTlBNZTYxWFBjWFcwcjlnRW4r?=
 =?utf-8?B?RjQwSmNtcXN3Q2JkNE1NajgrTSs3K2FEZFBUa0gxcWhmWHFmOStsYU9FWUo3?=
 =?utf-8?B?UnVqUG9hZ2R6NnBkS2hwcFQ1c09Rb1NrcEFkN1BFdm4rSVMxcFBLeEk1TmVP?=
 =?utf-8?B?aDAvUjByUXRsOW1vMHhqNDRxd3JwK0pmQ0pwalRsL2lYRURxUGcrc0RuZWt1?=
 =?utf-8?B?ZnFORG5yUHltVUR0bDdEaWdPd24xS1JqRnZpUVdzV3B1bGEwQmR1OWtQZ1dk?=
 =?utf-8?B?aEovcUZNNWluRUdhYVRUTmJVOGMxZUI5ZUxDT0dMYmNjQkdqYkFHVmpYY1lq?=
 =?utf-8?B?Q296WDQ4SU9rSHpMMkNrRG5wZ1hYbGhBd2ltUkpVTVNSQkdhTHNjK1J1aEta?=
 =?utf-8?B?MFI1V2dPb0ZJaTBaYVRSZHZnazczM3NKYkZEb24yamwzbjVZMEdVMm5kUDlR?=
 =?utf-8?B?M0JXOE5wQzBFQk8yMDZSVUZmcmxqVGxOY1JrYU1MVVZLU0ZOWHErRm9lWDFF?=
 =?utf-8?B?dUZIbnk1dUh3T1p6cGxpNXhrVUFZdEZLOVBKd054RVEvTDd6RmlKdnVhTnpq?=
 =?utf-8?B?bFZrazF3UDJzd3QzUHhpcnZlV3k4ajBqTS92SUJiaEFoY1BVVU93d0U0Nm1K?=
 =?utf-8?B?QnJhZnY3RHArd1p1cTAyU3ZWSEROSHVyMnA1MEJESjNkL2dxMjh4WVA3R2Ex?=
 =?utf-8?Q?oRwofWShR+k=3D?=
Content-Type: multipart/alternative;
        boundary="_002_TY0PR04MB5604E52DCC1BD9EDE31988E3FBAB9TY0PR04MB5604apcp_"
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR04MB5604.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 752daeb5-46a9-4a09-3536-08da4d8da769
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 22:40:02.0139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB2924
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--_002_TY0PR04MB5604E52DCC1BD9EDE31988E3FBAB9TY0PR04MB5604apcp_
Content-Type: text/plain; charset="utf-8"
Content-ID:
 <DB243AFF0D00014A843CA6547CFB2BFA@sct-15-20-4755-11-msonline-outlook-6ea25.templateTenant>
Content-Transfer-Encoding: base64

4LmA4Lih4Li34LmI4LitOiDigIsxNCDguKHguLQu4LiiLiAyMDIyICjigIvguJfguLHguYnguIfi
gIvguKvguKHguJQsIOKAi+C5gOC4geC4tOC4lOKAi+C4i+C5ieC4sykK4Liq4LiW4Liy4LiZ4oCL
4LiX4Li14LmIOiDigIs0MzAg4LiWLiDguK3guYjguK3guJnguJnguLjguIog4LmB4LiC4Lin4LiH
IOC4quC4p+C4meC4q+C4peC4p+C4hyDguYHguILguKfguIfguKrguKfguJnguKvguKXguKfguIcg
4LiB4Lij4Li44LiH4LmA4LiX4Lie4Lih4Lir4Liy4LiZ4LiE4LijIDEwMjUwIOC4m+C4o+C4sOC5
gOC4l+C4qOC5hOC4l+C4ogotLQpMaW5nIE1haWw=

--_002_TY0PR04MB5604E52DCC1BD9EDE31988E3FBAB9TY0PR04MB5604apcp_
BEGIN: VCALENDAR
METHOD: REQUEST
PRODID: AndroidEmail
VERSION: 2.0
BEGIN: VTIMEZONE
TZID: Asia/Bangkok
X-LIC-LOCATION: เวลาอินโดจีน
BEGIN: STANDARD
TZOFFSETFROM: +0700
TZOFFSETTO: +0700
DTSTART: 19700101T000000Z
END: STANDARD
END: VTIMEZONE
BEGIN: VEVENT
UID: 3fb72000-b0b7-4d6a-8aab-c470f8d4491f
DTSTAMP: 20220613T223947Z
DTSTART: 20220614T000000
DTEND: 20221215T000000
LOCATION: 430 ถ. อ่อนนุช แขวง สวนหลวง
	 แขวงสวนหลวง กรุงเทพมหานค
	ร 10250 ประเทศไทย
SUMMARY: Sarun515m@outlook.com
DESCRIPTION: เมื่อ: ​14 มิ.ย. 2022 (​ทั้ง​ห
	มด\, ​เกิด​ซ้ำ)\nสถาน​ที่: ​430
	 ถ. อ่อนนุช แขวง สวนหลวง แขว
	งสวนหลวง กรุงเทพมหานคร 10250 
	ประเทศไทย\n--\nLing Mail
X-MICROSOFT-CDO-ALLDAYEVENT: TRUE
RRULE: FREQ=WEEKLY;WKST=MO
STATUS: TENTATIVE
STATUS: TENTATIVE
STATUS: TENTATIVE
CLASS: PUBLIC
ORGANIZER;CN="": MAILTO:sarun515m@outlook.com
TRANSP: OPAQUE
X-MICROSOFT-CDO-BUSYSTATUS: BUSY
PRIORITY: 5
SEQUENCE: 0
BEGIN: VALARM
ACTION: DISPLAY
DESCRIPTION: REMINDER
TRIGGER: -PT900M
END: VALARM
END: VEVENT
END: VCALENDAR


--_002_TY0PR04MB5604E52DCC1BD9EDE31988E3FBAB9TY0PR04MB5604apcp_--
