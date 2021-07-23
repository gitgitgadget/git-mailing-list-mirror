Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF79EC4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 18:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B280260ED7
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 18:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhGWRdD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 13:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhGWRdD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 13:33:03 -0400
X-Greylist: delayed 1155 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 23 Jul 2021 11:13:36 PDT
Received: from mx0b-00206401.pphosted.com (mx0b-00206401.pphosted.com [IPv6:2620:100:9005:15::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDDFC061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 11:13:36 -0700 (PDT)
Received: from pps.filterd (m0207805.ppops.net [127.0.0.1])
        by mx0b-00206401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 16NG3QFr025944
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 10:54:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com; h=from : to :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=default;
 bh=jWXaETei59XJwve82U51+0KGKPsf0VWSpYUmlI4cvRU=;
 b=ZinKck/eCaSEA66dRaCDvISEN7Xtbp9UAvGqyMoXTiQ00Zcaa8IORbAeQ4vUHCdequAK
 lRU6vAvjL8WYuo3j1agpJ6MMrImvb7BPvDRdvvI5X+cz6Ow6XHiMBg0YlcWmUg4mYxQz
 3m8oFmQlIT9sVeNqK2Bdm+l3kVbxKe3xPzDsGJgNo2WnsYTVyIzI0ALsuR1QZYVm6GCB
 4vXctPYZO8vIONHnwGpZYCTkgvHMTJvqxKtZ/h/Eazpq0AJ+JyH73wgCw8znHDxH0TOQ
 wLS2Aqyv9TGVPdZAle5zbtNUUG2LARNyB82KBY3eM4EszSSDHW2fkrXZtbwcgT1qJXhr 0Q== 
Received: from 04wpexch01.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
        by mx0b-00206401.pphosted.com with ESMTP id 39yjurhr04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 10:54:19 -0700
Received: from 04wpexch02.crowdstrike.sys (10.100.11.92) by
 04wpexch01.crowdstrike.sys (10.100.11.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.858.15; Fri, 23 Jul 2021 10:54:13 -0700
Received: from 04wpexch02.crowdstrike.sys ([fe80::6de5:c8bb:501a:3034]) by
 04wpexch02.crowdstrike.sys ([fe80::6de5:c8bb:501a:3034%5]) with mapi id
 15.02.0858.015; Fri, 23 Jul 2021 10:54:13 -0700
From:   Daniel Martin <daniel.martin@crowdstrike.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Bug: the output of "git remote" can be confused by global config
 settings
Thread-Topic: the output of "git remote" can be confused by global config
 settings
Thread-Index: AQHXf+u+c9Vs/djWYU2RJjP2QY0KLA==
Date:   Fri, 23 Jul 2021 17:54:12 +0000
Message-ID: <346508F7-BA3D-463D-8924-5C98D5142768@contoso.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.100.11.84]
x-disclaimer: USA
Content-Type: text/plain; charset="utf-8"
Content-ID: <91A06EEE37CE6649866EEA7EBCBE1E22@crowdstrike.sys>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-07-23_09,2021-07-23_01,2020-04-07_01
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQ0KUGxlYXNlIGFuc3dl
ciB0aGUgZm9sbG93aW5nIHF1ZXN0aW9ucyB0byBoZWxwIHVzIHVuZGVyc3RhbmQgeW91ciBpc3N1
ZS4NCg0KV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8g
cmVwcm9kdWNlIHlvdXIgaXNzdWUpDQoNCmdpdCBjb25maWcgLS1nbG9iYWwgcmVtb3RlLm9yaWdp
bi50YWdvcHQgLS1ub3RhZ3MNCiMgbXVjaCBsYXRlcg0KbWtkaXIgL3RtcC90ZXN0X2RpciAmJiBj
ZCAvdG1wL3Rlc3RfZGlyDQpnaXQgaW5pdCAuDQpnaXQgcmVtb3RlDQpnaXQgcmVtb3RlIHJlbW92
ZSBvcmlnaW4NCmdpdCByZW1vdGUgLXYNCg0KV2hhdCBkaWQgeW91IGV4cGVjdCB0byBoYXBwZW4/
IChFeHBlY3RlZCBiZWhhdmlvcikNCkkgZXhwZWN0ZWQgImdpdCByZW1vdGUiIHRvIHJlcG9ydCBv
bmx5IG9uIHRoZSByZW1vdGVzIHRoYXQgZXhpc3RlZCBpbiB0aGF0IG5ld2x5IGNyZWF0ZWQgcmVw
b3NpdG9yeS4NCg0KSSBleHBlY3RlZCAiZ2l0IHJlbW90ZSByZW1vdmUgb3JpZ2luIiB0byBzdWNj
ZWVkIHNpbmNlICJnaXQgcmVtb3RlIiBsaWVkIGFuZCB0b2xkIG1lIHRoYXQgdGhlIG5ld2x5DQpj
cmVhdGVkIHJlcG8gaGFkIGEgcmVtb3RlIGluc2lkZSBpdCBjYWxsZWQgIm9yaWdpbiIuDQoNCldo
YXQgaGFwcGVuZWQgaW5zdGVhZD8gKEFjdHVhbCBiZWhhdmlvcikNCg0KVGhlIGdsb2JhbCByZW1v
dGUub3JpZ2luLnRhZ29wdCBjb25maWcgc2V0dGluZyBjb252aW5jZWQgImdpdCByZW1vdGUiIHRo
YXQgdGhlcmUgd2FzIGFsd2F5cyBhDQpyZW1vdGUgY2FsbGVkICJvcmlnaW4iIHByZXNlbnQsIGV2
ZW4gaW4gYSBicmFuZCBuZXcgcmVwb3NpdG9yeS4NCg0KImdpdCByZW1vdmUiIGNvdWxkIHRlbGwg
dGhhdCB0aGVyZSB3YXMgbm8gcmVtb3RlIGNhbGxlZCAib3JpZ2luIjoNCg0KdGVzdF9kaXIkIGdp
dCByZW1vdGUNCm9yaWdpbg0KdGVzdF9kaXIkIGdpdCByZW1vdGUgcmVtb3ZlIG9yaWdpbg0KZXJy
b3I6IE5vIHN1Y2ggcmVtb3RlOiAnb3JpZ2luJw0KdGVzdF9kaXIkIGdpdCByZW1vdGUgLXYNCm9y
aWdpbgkNCg0KV2hhdCdzIGRpZmZlcmVudCBiZXR3ZWVuIHdoYXQgeW91IGV4cGVjdGVkIGFuZCB3
aGF0IGFjdHVhbGx5IGhhcHBlbmVkPw0KDQpUaGUgZ2xvYmFsIGNvbmZpZyBzZXR0aW5nIHNob3Vs
ZCBub3QgYXJ0aWZpY2lhbGx5IGNyZWF0ZSBhIHJlbW90ZSBmcm9tIHRoZSBwb2ludCBvZg0Kdmll
dyBvZiAiZ2l0IHJlbW90ZSIsIHdoaWNoIHNob3VsZCBsb29rIG9ubHkgYXQgdGhlIGN1cnJlbnQg
cmVwbydzIGNvbmZpZ3VyYXRpb24gYW5kIG5vdCBhdA0KdGhlIGdsb2JhbCBvciBzeXN0ZW0gY29u
ZmlndXJhdGlvbi4NCg0KQW55dGhpbmcgZWxzZSB5b3Ugd2FudCB0byBhZGQ6DQoNCg0KDQpbU3lz
dGVtIEluZm9dDQpnaXQgdmVyc2lvbjoNCmdpdCB2ZXJzaW9uIDIuMzIuMA0KY3B1OiB4ODZfNjQN
Cm5vIGNvbW1pdCBhc3NvY2lhdGVkIHdpdGggdGhpcyBidWlsZA0Kc2l6ZW9mLWxvbmc6IDgNCnNp
emVvZi1zaXplX3Q6IDgNCnNoZWxsLXBhdGg6IC9iaW4vc2gNCnVuYW1lOiBEYXJ3aW4gMTkuNi4w
IERhcndpbiBLZXJuZWwgVmVyc2lvbiAxOS42LjA6IFR1ZSBKdW4gMjIgMTk6NDk6NTUgUERUIDIw
MjE7IHJvb3Q6eG51LTYxNTMuMTQxLjM1fjEvUkVMRUFTRV9YODZfNjQgeDg2XzY0DQpjb21waWxl
ciBpbmZvOiBjbGFuZzogMTIuMC4wIChjbGFuZy0xMjAwLjAuMzIuMjkpDQpsaWJjIGluZm86IG5v
IGxpYmMgaW5mb3JtYXRpb24gYXZhaWxhYmxlDQokU0hFTEwgKHR5cGljYWxseSwgaW50ZXJhY3Rp
dmUgc2hlbGwpOiAvYmluL2Jhc2gNCg0KDQpbRW5hYmxlZCBIb29rc10NCg0K
