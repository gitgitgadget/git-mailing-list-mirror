Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423C2C433F5
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 06:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347209AbiBHGX7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 01:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237776AbiBHGX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 01:23:58 -0500
Received: from mx0f-00379502.gpphosted.com (mx0f-00379502.gpphosted.com [67.231.155.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BA3C0401DC
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 22:23:56 -0800 (PST)
Received: from pps.filterd (m0218362.ppops.net [127.0.0.1])
        by mx0f-00379502.gpphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2186Lamw022217;
        Mon, 7 Feb 2022 22:23:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=llnl.gov; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=02022021-podllnl;
 bh=j0rK4wnuOGK9bCw8WNI4KMQ3gLQQD0vAmjpnSNjT2Tc=;
 b=GEyDrVuciPHppx8gmmDBsWxhljrgK4J6PMI56xWDCtddv+X28beqZOLzAHAh8q6ScBi5
 pn/RDwsMkf41kGjrThenVUZU11m0ieSVAUdPezUd2cz8z+WKWwUzqgh0x/rzQDP573as
 s6qsDBNsLYFYAcQ+27KiPZMB9wDF6ZhA6S80pAD3xul5T3i9YdG9jEjWfNxXnIdfyPps
 vrsvzQ2Q8BG/q6e80pj8/VC7HMORQr8ue03WyS/JR/wi3WTFpW18d+9RxxuaLXAZ4Mbg
 uw1gupF9Pv0nY6PatAsAuSM5LSe9HssKSlgJhKp+axl13pRn6bPMigGrWDYF08a9AbSv Jg== 
Received: from gcc02-bl0-obe.outbound.protection.outlook.com (mail-bl2gcc02lp2105.outbound.protection.outlook.com [104.47.64.105])
        by mx0f-00379502.gpphosted.com with ESMTP id 3e39e9sn06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 22:23:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egeX8rLB5D9hOrrMivdxQwIsb8ZcMd8h3Cq3+L3wx3ZdH37izaZkROSaxjd/RD6wWwBD3Ojj3UquZszEtg4giqsDnAjQuf8vO+D//BRKDVXsM2gBtlib8ytHzaK6LEKRxObsYnx2ML/CTfabHwuIEluopSIzjLEhJebqfPyZ6V8CUZQ1SHx6eZga2sNdLZUrni1edtBAd1l0unK73bSiuq3oyTrnYt0JgH6+bV+MddJqKu/EjqE+p/asv2XCoEHCEZjCMugIQcpclYvxqucw6sJjYQCNuMsXH96Xbg7iWH8fzPSi1bruas5Qu/+F9AV3kTsR12UC3/A4aIi4ZYNCdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0rK4wnuOGK9bCw8WNI4KMQ3gLQQD0vAmjpnSNjT2Tc=;
 b=NEuXg2NR4lVtAtMvHlwJK5k6GSK+Czc1l/3oPXidQ9dikTEP0ISs4w0cHEnpC/okGZFbii51LOFmC+NzIhCR5Z/qRU4cKVUQ+/TYLN98W/wSQhv2kBB7rk9kQ1U1ozYg3IVrHkX+TnbiqoD9nMj2y552FJcAw6igGJ83qyFFhlzI66vrEE9oxw2YbL5RwDQR0RLGRS5gko6MxK6vem583qte4X8U6J2As2aYmjnhAAuWPlLAeAjrxF2CsEzDaRqcZQGmUFNPnUTFCYudG6N2e9PId2whsGt6z2OQ9fviBLFV/VeE26uO3v5qpDqwKmlTZE8UII/vl3V37tNw7ufusg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=doellnl.onmicrosoft.com; s=selector1-doellnl-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0rK4wnuOGK9bCw8WNI4KMQ3gLQQD0vAmjpnSNjT2Tc=;
 b=NLnxAnWhizmqdA6FwCsXnnAhfOfAqPcc01H8CnNTZXOoL3cdB2Du1jnoCEILXmNGDXNu+coMIvWtZgjVMP68wOW9UNW5NBPLWHhTQK4GjGrcc2bO7l0t6k1y8MaduyJGH1z/JBnXn2vaDYswsG1kdkaDBIdBvQhyqQxQHUw3hJ0=
Received: from BY5PR09MB5972.namprd09.prod.outlook.com (2603:10b6:a03:242::12)
 by BY5PR09MB5060.namprd09.prod.outlook.com (2603:10b6:a03:252::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 06:23:43 +0000
Received: from BY5PR09MB5972.namprd09.prod.outlook.com
 ([fe80::1152:ffb:b909:9231]) by BY5PR09MB5972.namprd09.prod.outlook.com
 ([fe80::1152:ffb:b909:9231%2]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 06:23:43 +0000
From:   "Gamblin, Todd" <gamblin2@llnl.gov>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
CC:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Commit SHA1 == SHA1 checksum?
Thread-Topic: Commit SHA1 == SHA1 checksum?
Thread-Index: AQHYGi5p7M1/4kXYKkqhLSADSBwD+KyFqvkAgAClySOAAJl4gIAACmf7gAElYQCAAHxxnYAACkGAgAAPT4CAAATVAIAAf6AA
Date:   Tue, 8 Feb 2022 06:23:43 +0000
Message-ID: <BE3E3354-F2F4-47D7-8DA7-27ABCD3A5E90@llnl.gov>
References: <ED97E252-CABA-41BB-B18C-819A5EF305E3@llnl.gov>
 <121ce485-bea8-3168-aa35-d11eb13022da@iee.email> <xmqq1r0gjo6h.fsf@gitster.g>
 <eca83634-ee91-89bd-567e-6b0807b5ff79@iee.email> <xmqqee4fix0l.fsf@gitster.g>
 <20220207133244.kpyczjsxriepjtdt@meerkat.local> <xmqqczjyiecs.fsf@gitster.g>
 <20220207213449.ljqjhdx4f45a3lx5@meerkat.local>
 <8A241137-C8D6-40A6-ABB8-5624B9E617A9@llnl.gov>
 <20220207224654.aju3rmxcrhapi4d2@meerkat.local>
In-Reply-To: <20220207224654.aju3rmxcrhapi4d2@meerkat.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68e20140-3857-47de-d86e-08d9eacb8e0d
x-ms-traffictypediagnostic: BY5PR09MB5060:EE_
x-microsoft-antispam-prvs: <BY5PR09MB506060AA9303C0619538D5FBF82D9@BY5PR09MB5060.namprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AiNrTJYh8jFRD28kQ/hxekjagxVlg8/GdnO2E2ufNbHtnUVWzFBhfnSYP/A5684itj29727+snBIf6ZQickNuxvvJv8O/re89fGTvoveyA/dYhf+uFI2XvtHGZ+cKrd0ESqCsXPFOo2C2I6rHDTs0ApYlaTTFZdrZdzGOctOrayGZD3TExJXCBsa8ogYWd/WOBbmcVAyqrZsV4YX3EA60r9aI8D9hDSBgz6qYQcvlSZgC4FXFd9v/5uI0V8MaJahBs3LFxo75FbJQtEWuk1PceKQORtYhs5NYsWB3mhzBIYr2k5Px29R3SCy7f0wx4K31ULcsTNaAHHsag2xI8uWlV8lTyH7rEFWAM/g6ksHwxRs+FTj29htZcrSjRFmu7z3R+TR79zLV8bMNTECSYCimm1BqVQlkuX3EdhHZ+6mj2H44NOEAHMG+6Qdhb4B6t+SvSZd6DO+UV/nXvAXmDeBXM/Q6LQczHY6Okv0L2QgyR5ujsHyrMKfO3rjDs5lCmGWKHjpK+sCcq1w4zRNYLBGH/jQhcFaKLTPo8b1MjX3YWX62hD2yNQbzB1xxNtCdudrfPee0Q13nV3DtlxBS9swdgBEFKhk+V0Zr3jcVO0Ek1AQCjUSfFomKxmoeKRjT1mkJYuo5FpoymaSuuha+ZVMzVsQkXJKCFXtApkqrp2sdj+L33aXHHjV8fnawI6W399Xa7XVAjXB6V64KqCY93vVMk5Z8x6sJ9o6ML3NdloCXBptEz9UATwEd/TCdasCa6aX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR09MB5972.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(5660300002)(6486002)(2616005)(76116006)(66946007)(38070700005)(64756008)(66556008)(53546011)(66446008)(66476007)(8936002)(4326008)(2906002)(26005)(186003)(6506007)(8676002)(316002)(36756003)(71200400001)(33656002)(122000001)(38100700002)(6916009)(6512007)(82960400001)(86362001)(54906003)(83380400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QW5XbnZsUDl0RU1LZWxvdVYyMWlMTDEyRDNqUUdQZ0hmRjFJZ3lRbTJ0TVQ0?=
 =?utf-8?B?OEVGbEdHWWEweERmZlp4RHpXTm96azhNc0F5RVU5K0doRzR6eHR1RUoxU05W?=
 =?utf-8?B?dUZYUXIrSXdyN1BaWThjNFUwL3BQSFlyTDJKdmYxREpQSmtMMHFPRlBnWktS?=
 =?utf-8?B?SXhZUFREQWtWQTZPaWlWRG81SU9SQm5Ga1EyMGJzZnd3dExQaGErS29CbU5N?=
 =?utf-8?B?NWEwQkZxVU1oeUViYlpieitlMjFpU04ySCtscEdhMktITTJzcms2YjNVZ1pq?=
 =?utf-8?B?MWRvOUs5Uzg4cmt1OHhvMUFRNmM1Qzg1L1BVeFlLbjVYbURqdDJBM2gwTjg0?=
 =?utf-8?B?ZFNla3JxWXpEVnRsSlBWVXpqbDlYNG0wUnBrU1Q2cm53RjZuKytIVUlqdWJi?=
 =?utf-8?B?SWs0R2ZFdTY4MVFYL2oxRE9US2R6ek16dU9YSnB0VGpGQ29rTFp6eTROR3F1?=
 =?utf-8?B?S3F5TVgzaFl2cXpSZFB0ZVBiQmtIZXJMQ1VxOS8rM3Z1cFdtUkMxZ2wxbmk0?=
 =?utf-8?B?U2ltbUF0RGN6eDdpOXJzUFlXWFNVN1RIbENFNmxFNmI2bnBKUzQ5bk4zZVNz?=
 =?utf-8?B?R2JlZGNQU3VVT0VHZ0RBMUdvWTl0NXNnQXhZdStESHhVSHg2ZHMrWko4M3M1?=
 =?utf-8?B?TnJqNFd4MTlkQnp2bTRTd3JkUG9jVVZQRlAvTTZJTmtQNTVla2w0dTlXbUty?=
 =?utf-8?B?MC9sejYvQ0JsOTV5cTdzL1VHeTlDY1VmSit5YlJpOEs3Zlk4VEhJcnNSQzlM?=
 =?utf-8?B?RCtpZEZKQ2FCQlRkZEJ5NjdiVjZTNi9QWkx6MlFIenF2Zm1qOEZZUkRkNjV3?=
 =?utf-8?B?a1NtZGp6Rm15QXJYUFB1SGROcGFBSWdZSFNKY3RqN0pPSkI4ZjZKQ1Q1V3lC?=
 =?utf-8?B?MzlMZ0d3Tk0zeWFaSjFJclQvbkhVSXZZSWZYRi8zT3dqL1puYkt3ZVRCWDkw?=
 =?utf-8?B?RTVpSDl2eS9Qb1BIS2JlbWp4aG00cVBJdFpseVpObTFJaXh5ZFAvS2s0Y3pR?=
 =?utf-8?B?dlowc2w5MTk5NzVPdXBXSWJXaS9obURDNW1mTXFaZ3ArVFZOZ1hVQ1lxSGpa?=
 =?utf-8?B?SmtuaGZnby9wdFBrTGN3eWRuVWNqN3FDQTM3blFrVXhCRkkwN1JLM3lxdzUv?=
 =?utf-8?B?azFLcEMveHEvbkF5b2VOWUl1ekNocWdab0REZ3lvajVDY0kyRVREWm1xVHFI?=
 =?utf-8?B?aE9Vd3VoY3BBcFBKR2Y2UktjdW5jZS9OT3JmT1ExZEJPZ1NvOVhsMVpTWC9H?=
 =?utf-8?B?VWtFa1dRUEsraVJsZGNFMGg0QldwTTFRMFVNOUxvUkNtdXBUQ2tLall5Qk5s?=
 =?utf-8?B?Z2grbHAvVTRoWWZUUFdDTmxneGVrUWlYVlZVZHZZQUVRaHl1ek82SDFpcDlz?=
 =?utf-8?B?ekZya1lndHpieU1lQ2NLZWlhMjZVVU9uSFEwOCtCTXA5WGtvY3dqM0RQTTM5?=
 =?utf-8?B?MEQveDAvVlE2K1JFSjBDTzQ5TExHVEQ0TTJ1ZCtvemcxSWpZaVlIMFZnbFZr?=
 =?utf-8?B?a3kzQU44c2ZyVVEwN1hLRWZ6elNDUm5qS2syakJXclJUT0ZCTUIxMHZ0QXVl?=
 =?utf-8?B?SGFuRmlRWnVjZGNJQjk1dzZBalgrb1gxV1U1UDAxQW0zem5hQlFIN2pvNERh?=
 =?utf-8?B?blYyWXM1VmYwRE4wV25Fc0xjTnNRK1VzSkxOSDIwMkYxUk9DejhiVUtpRDdT?=
 =?utf-8?B?K1liczhCdnpNeVhpQ2xWbkViMythQTlOTE9iSE5PclVrSyt6RWFSY1VJK0py?=
 =?utf-8?B?Qk9kYTRUSUN1ZWY2UW9PS1JkdHU3QS9FUk1GQ203eDU1RVpVME53blV6cTF6?=
 =?utf-8?B?OUw5cTdPNmNtZ1VObVFjUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CA8C6B8F13F0A48AB663E3E752658E3@namprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: llnl.gov
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR09MB5972.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e20140-3857-47de-d86e-08d9eacb8e0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 06:23:43.1387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a722dec9-ae4e-4ae3-9d75-fd66e2680a63
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR09MB5060
X-Proofpoint-ORIG-GUID: CeQAHAXMq1S9B5uJgXBfWyHJeDoAYev1
X-Proofpoint-GUID: CeQAHAXMq1S9B5uJgXBfWyHJeDoAYev1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.816
 definitions=2022-02-08_02:2022-02-07,2022-02-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 adultscore=0 impostorscore=0
 spamscore=0 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=316 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202080031
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCj4gT24gRmViIDcsIDIwMjIsIGF0IDI6NDYgUE0sIEtvbnN0YW50aW4gUnlhYml0c2V2IDxr
b25zdGFudGluQGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiANCj4gT24gTW9uLCBGZWIg
MDcsIDIwMjIgYXQgMTA6Mjk6MzdQTSArMDAwMCwgR2FtYmxpbiwgVG9kZCB3cm90ZToNCj4+PiAy
LiBwYWNrYWdlcnMgd291bGQgYmUgYWJsZSB0byBwZXJmb3JtIGNyeXB0b2dyYXBoaWMgdmVyaWZp
Y2F0aW9uIHdpdGhvdXQNCj4+PiAgbmVlZGluZyB0byB0cmFjayBhbnkgZXh0cmEgc291cmNlcyBs
aWtlIGNvcnJlc3BvbmRpbmcgLnNpZyBmaWxlczsgdGhleQ0KPj4+ICB3b3VsZCBqdXN0IG5lZWQg
dG8gYWRkIGEgYnVpbGQtdGltZSBkZXBlbmRlbmN5IG9uIGdpdCAocGx1cyB3aGF0ZXZlciBpdA0K
Pj4+ICBjYWxscyBmb3IgY3J5cHRvZ3JhcGhpYyB2ZXJpZmljYXRpb24sIHN1Y2ggYXMgZ251cGcg
b3Igb3BlbnNzaCkNCj4+IA0KPj4gVGhpcyBpcyBhIGNvb2wgaWRlYSwgYnV0IHRhci9nemlwL2V0
Yy4gYXJlIHZ1bG5lcmFibGUgdG8gaW5wdXQgYXR0YWNrcyAob3INCj4+IGF0IGxlYXN0IHRoZXJl
IGhhdmUgYmVlbiBDVkVzIGluIHRoZSBwYXN0KSwgc28gdGhpcyBkb2VzIG5vdCBlbGltaW5hdGUg
dGhlDQo+PiBuZWVkIHRvIHZlcmlmeSBhIGRvd25sb2FkZWQgLnRhciBvciAudGFyLmd6IGZpbGUg
aW5kZXBlbmRlbnRseS4gIFlvdSBjYW4NCj4+IHZlcmlmeSB0aGUgY29udGVudHMgb2YgdGhlIHRh
ciwgYnV0IHRvIGRvIHRoYXQgeW91IGhhdmUgdG8gZXhwYW5kIGl0LCBhbmQgdG8NCj4+IGRvIHRo
YXQgeW914oCZcmUgc3RpbGwgcGFzc2luZyB1bnRydXN0ZWQgaW5wdXQgdG8gdGFyLg0KPiANCj4g
VGhhdCdzIG5vdCByZWFsbHkgZGlmZmVyZW50IGZyb20gd2hhdCBnaXQgZG9lcyB3aGVuIGl0IGNs
b25lcyBhIHJlbW90ZQ0KPiByZXBvc2l0b3J5IHRvIHJ1biAiZ2l0IHZlcmlmeS10YWciLiBJdCBz
dGlsbCBhY2NlcHRzIHVudHJ1c3RlZCBpbnB1dCBmcm9tIHRoZQ0KPiByZW1vdGUgc2VydmVyLCBw
ZXJmb3JtcyBhIGxvdCBvZiBjb21wcmVzc2lvbi9kZWNvbXByZXNzaW9uIG9wZXJhdGlvbnMsIGV0
Yywgc28NCj4gdGhpcyBpcyBub3QgaW50cm9kdWNpbmcgYW55dGhpbmcgdGhhdCBnaXQgaXNuJ3Qg
YWxyZWFkeSByZXF1aXJlZCB0byBkby4NCj4gDQo+IEkga25vdyB0aGVyZSdzIGEgbG90IHRvIGJl
IHNhaWQgYWJvdXQgdGhlIHNpbXBsaWNpdHkgb2YganVzdCBjb21wdXRpbmcgYQ0KPiBzaWduYXR1
cmUgb3ZlciBmaWxlIGJ5dGVzLCBidXQgdGhlcmUgYXJlIGZlYXR1cmVzIHlvdSBlbmQgdXAgc2Fj
cmlmaWNpbmcsIHN1Y2gNCj4gYXMgYWJpbGl0eSB0byBwcm92aWRlIGEgc2luZ2xlIHNpZ25hdHVy
ZSBmb3IgbXVsdGlwbGUgY29tcHJlc3Npb24gdHlwZXMsDQo+IGFkZGluZyBhIGJldHRlciBjb21w
cmVzc2lvbiBhbGdvcml0aG0gaW4gdGhlIGZ1dHVyZSwgb3Igc2ltcGx5IHJlY29tcHJlc3NpbmcN
Cj4gd2l0aCBiZXR0ZXIgZmxhZ3MgaW4gYSBsb25nIGJhY2tncm91bmQgcHJvY2Vzcy4NCj4gDQo+
IE15IGdvYWwgaXMgdG8gaW1wcm92ZSB0aGUgY3VycmVudCBzaXR1YXRpb24gd2hlcmUgd2UncmUg
YWN0dWFsbHkgZG9pbmcgcHJldHR5DQo+IGdvb2QgZm9yIHNpZ25lZCBpbi1naXQgb2JqZWN0cywg
YnV0IG5vbmUgb2YgdGhhdCBpcyBjYXJyaWVkIG92ZXIgdG8gcGFja2FnaW5nDQo+IHN5c3RlbXMu
IFRoZSBvbmx5IGVmZm9ydCBJIGtub3cgaW4gdGhhdCBhcmVhIGlzIHNpZ3N0b3JlLCBidXQgaXQg
cmVxdWlyZXMNCj4gcXVpdGUgYSBiaXQgb2Ygd29yayB0byBwcm9wZXJseSB1c2Ugb24gdGhlIHBh
cnQgb2YgdGhlIHByb2plY3QgbWFpbnRhaW5lciwNCj4gd2hlcmVhcyBpdCB3b3VsZCBiZSBncmVh
dCB0byBiZSBhYmxlIHRvIHNheSAianVzdCBkbyBnaXQgdGFnIC1zIGFuZCB0aGUNCj4gcGFja2Fn
aW5nIHN5c3RlbXMgd2lsbCBiZSBhYmxlIHRvIHVzZSB0aGF0LuKAnQ0KDQpJIGFncmVlIHRoaXMg
d291bGQgYmUgcmVhbGx5IG5pY2UuICBJZiB0aGUgdGFyYmFsbCAob3Igd2hhdGV2ZXIpIGNyZWF0
ZWQgY291bGQgYWxzbyBiZSBzaWduZWQsIHNvIHRoYXQgaXQgY291bGQgYmUgdHJ1c3RlZCByZWdh
cmRsZXNzIG9mIHRoZSBwYXJ0aWN1bGFyIHNlcnZlciB5b3UgZmV0Y2ggaXQgZnJvbSwgaXQgbWln
aHQgd29yayBhcyBhIG5pY2UgcGFja2FnaW5nIGZvcm1hdC4gIE1heWJlIHlvdSBjb3VsZCBoYXZl
IGEgc2lnbmVkIGhlYWRlciB3aXRoIHRoZSBoYXNoIG9mIHRoZSB0YXJiYWxsIHRoYXTigJlzIHBy
b2R1Y2VkPyAgWW91IHdvdWxkbuKAmXQgcmVhbGx5IG5lZWQgYSBzaWduZWQgdGFnIGluIHRoYXQg
Y2FzZS4NCg0KT3VyIHVzZSBmb3IgdGhpcyB3b3VsZCBiZSB0byBob3N0IHRoZXNlIHNpZ25lZCBn
aXQgYXJjaGl2ZXMgKC5nYXIgZmlsZXM/KSBvbiBtaXJyb3JzIOKAlCB3aGljaCB3ZSBtYXkgb3Ig
bWF5IG5vdCB0cnVzdC4gIElmIEkgY2FuIGdldCBhcm91bmQgdGhlIGhvc3RpbGUgdGFyYmFsbCBp
c3N1ZSBJ4oCZZCBiZSBzdXBlciBleGNpdGVkIGFib3V0IHRoZSBpZGVhLg0KDQotVG9kZA0KDQoN
Cg==
