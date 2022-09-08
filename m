Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA761ECAAD5
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 10:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiIHKkT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 06:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiIHKj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 06:39:57 -0400
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 44CB01CF
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 03:39:43 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,299,1654531200"; 
   d="scan'208";a="44069889"
Received: from hk-mbx11.mioffice.cn (HELO xiaomi.com) ([10.56.21.121])
  by outboundhk.mxmail.xiaomi.com with ESMTP; 08 Sep 2022 18:39:09 +0800
Received: from yz-mbx11.mioffice.cn (10.237.88.131) by HK-MBX11.mioffice.cn
 (10.56.21.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 8 Sep 2022
 18:39:09 +0800
Received: from BJ-MBX01.mioffice.cn (10.237.8.121) by yz-mbx11.mioffice.cn
 (10.237.88.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 8 Sep 2022
 18:39:08 +0800
Received: from BJ-MBX01.mioffice.cn ([fe80::1839:49c8:1d62:7218]) by
 BJ-MBX01.mioffice.cn ([fe80::1839:49c8:1d62:7218%9]) with mapi id
 15.02.0986.029; Thu, 8 Sep 2022 18:39:08 +0800
From:   =?gb2312?B?s8zR8w==?= <chengyang@xiaomi.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
CC:     Derrick Stolee <derrickstolee@github.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?gb2312?B?us66xg==?= <hehao@xiaomi.com>,
        =?gb2312?B?WGluNyBNYSDC7fbO?= <maxin7@xiaomi.com>,
        =?gb2312?B?yq+37rH4?= <shifengbing@xiaomi.com>,
        =?gb2312?B?t7K+/LvU?= <fanjunhui@xiaomi.com>,
        =?gb2312?B?zfW6urv5?= <wanghanji@xiaomi.com>
Subject: RE: [External Mail]Re: [PATCH 3/3] parse_object(): check commit-graph
 when skip_hash set
Thread-Topic: [External Mail]Re: [PATCH 3/3] parse_object(): check
 commit-graph when skip_hash set
Thread-Index: AQHYwvBwu0A4XHFy4ESZYWhyRLfYfa3VV+/w
Date:   Thu, 8 Sep 2022 10:39:08 +0000
Message-ID: <a87e9eaccf7849fc9eeb10ce7d373db0@xiaomi.com>
References: <YxfQi4qg8uJHs7Gp@coredump.intra.peff.net>
        <YxfScUATMQw9cB6m@coredump.intra.peff.net> <xmqqv8pzt20d.fsf@gitster.g>
In-Reply-To: <xmqqv8pzt20d.fsf@gitster.g>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.237.8.11]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBJZiB0aGUgY2FsbGVyIHRvbGQgdXMgdGhhdCB0aGV5IGRvbid0IGNhcmUgYWJvdXQgdXMgY2hl
Y2tpbmcgdGhlDQo+IG9iamVjdCBoYXNoLCB0aGVuIHdlJ3JlIGZyZWUgdG8gaW1wbGVtZW50IGFu
eSBvcHRpbWl6YXRpb25zIHRoYXQgZ2V0DQo+IHVzIHRoZSBwYXJzZWQgdmFsdWUgbW9yZSBxdWlj
a2x5LiBBbiBvYnZpb3VzIG9uZSBpcyB0byBjaGVjayB0aGUNCj4gY29tbWl0IGdyYXBoIGJlZm9y
ZSBsb2FkaW5nIGFuIG9iamVjdCBmcm9tIGRpc2suIEFuZCBpbiBmYWN0LCBib3RoIG9mDQo+IHRo
ZSBjYWxsZXJzIHdobyBwYXNzIGluIHRoaXMgZmxhZyBhcmUgYWxyZWFkeSBkb2luZyBzbyBiZWZv
cmUgdGhleSBjYWxsDQo+IHBhcnNlX29iamVjdCgpIQ0KDQo+IFNvIHdlIGNhbiBzaW1wbGlmeSB0
aG9zZSBjYWxsZXJzLCBhcyB3ZWxsIGFzIGFueSBwb3NzaWJsZSBmdXR1cmUgb25lcywNCj4gYnkg
bW92aW5nIHRoZSBsb2dpYyBpbnRvIHBhcnNlX29iamVjdCgpLg0KDQpJIG5lZWQgdG8gbWVudGlv
biB0aGF0IHRoZXJlIGlzIHNlcmlvdXMgaXNzdWUgd2l0aCBjb21taXQtZ3JhcGggdG9nZXRoZXIg
d2l0aCBwYXJ0aWFsLWNsb25lDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9naXQvMjAyMjA3MDkw
MDUyMjcuODI0MjMtMS1oYW54aW4uaHhAYnl0ZWRhbmNlLmNvbS8NCg0KU28gYWN0dWFsbHkgSSB0
b2xkIG15IHVzZXJzIHRvIGRpc2FibGUgY29tbWl0LWdyYXBoIG1hbnVhbGx5DQojLyoqKioqKrG+
08q8/rywxuS4vbz+uqzT0NChw9e5q8u+tcSxo8Pc0MXPoqOsvfbP3tPat6LLzbj4yc/D5rXY1rfW
0MHQs/a1xLj2yMu78si61+mho7371rnIzrrOxuTL+8jL0tTIzrrO0M7Kvcq508OjqLD8wKi1q7K7
z97T2sirsr+78rK/t9a12NC5wrahori01sahorvyyaK3oqOpsb7Tyrz+1tC1xNDFz6Kho8jnufvE
+rTtytXBy7G+08q8/qOsx+vE+sGivLS157uwu/LTyrz+zajWqreivP7Iy7Kiyb6z/bG+08q8/qOh
IFRoaXMgZS1tYWlsIGFuZCBpdHMgYXR0YWNobWVudHMgY29udGFpbiBjb25maWRlbnRpYWwgaW5m
b3JtYXRpb24gZnJvbSBYSUFPTUksIHdoaWNoIGlzIGludGVuZGVkIG9ubHkgZm9yIHRoZSBwZXJz
b24gb3IgZW50aXR5IHdob3NlIGFkZHJlc3MgaXMgbGlzdGVkIGFib3ZlLiBBbnkgdXNlIG9mIHRo
ZSBpbmZvcm1hdGlvbiBjb250YWluZWQgaGVyZWluIGluIGFueSB3YXkgKGluY2x1ZGluZywgYnV0
IG5vdCBsaW1pdGVkIHRvLCB0b3RhbCBvciBwYXJ0aWFsIGRpc2Nsb3N1cmUsIHJlcHJvZHVjdGlv
biwgb3IgZGlzc2VtaW5hdGlvbikgYnkgcGVyc29ucyBvdGhlciB0aGFuIHRoZSBpbnRlbmRlZCBy
ZWNpcGllbnQocykgaXMgcHJvaGliaXRlZC4gSWYgeW91IHJlY2VpdmUgdGhpcyBlLW1haWwgaW4g
ZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBieSBwaG9uZSBvciBlbWFpbCBpbW1lZGlh
dGVseSBhbmQgZGVsZXRlIGl0ISoqKioqKi8jDQo=
