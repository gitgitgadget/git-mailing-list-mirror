Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58DDC7618A
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 18:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjCTSNp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 14:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjCTSNI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 14:13:08 -0400
X-Greylist: delayed 2223 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Mar 2023 11:07:19 PDT
Received: from proofpoint8.lanl.gov (proofpoint8.lanl.gov [IPv6:2620:126:4000:1801::a8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9DF6597
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 11:07:19 -0700 (PDT)
Received: from pps.filterd (proofpoint8.lanl.gov [127.0.0.1])
        by proofpoint8.lanl.gov (8.17.1.19/8.17.1.19) with ESMTP id 32KFpwon023641
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 11:10:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lanl.gov; h=from : to : subject :
 date : message-id : content-type : content-id : content-transfer-encoding
 : mime-version; s=lanl; bh=m+XUnKVtRqAaR2vJB9FuBN6eH2Or3hR7WGSeU02mEzg=;
 b=OuCp4u9ghTiHzpdugVrAw6UdoM+vgKIWlVKhQfrk7A9FIGsIPqppxdni+LyogJwB1+Px
 edmxkrKUx53hN0kb1bBc+s0YznIpMSXXlBMAVBSK9XcUJ2JUz2W7pJP+ibokzAVbIDA7
 WJBghnH8l73wKAf1wu5bJxhq7Z1g0+SgPtbSFlQVo1JcPafJPrBNgYzcKoYedvqjLwRI
 UCSpVTXsf+0HUVWPBAQNHiuifIXHSH7WlD/5okZEG3DZ4P1SFWIJiMQNM9tOQB8WU2lY
 bMWvpOQDNMBGIsBojJFvPe5PlyBWweqpWQizIgK5GtwgFsEPuTY/r9ppFN6JgZpUXJKQ gg== 
Received: from mailrelay1.lanl.gov (mailrelay1.lanl.gov [128.165.4.101])
        by proofpoint8.lanl.gov (PPS) with ESMTP id 3pda31q59s-1
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 11:10:57 -0600
Received: from localhost (localhost [127.0.0.1])
        by mailrelay1.lanl.gov (Postfix) with ESMTP id 43CF8100229B
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 11:10:57 -0600 (MDT)
X-NIE-2-Virus-Scanner: amavisd-new at mailrelay1.lanl.gov
Received: from EXG16-P-MBX05.win.lanl.gov (exg16-p-mbx05.win.lanl.gov [128.165.106.185])
        by mailrelay1.lanl.gov (Postfix) with ESMTP id 302C51002293
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 11:10:57 -0600 (MDT)
Received: from EXG16-P-MBX03.win.lanl.gov (128.165.106.183) by
 EXG16-P-MBX05.win.lanl.gov (128.165.106.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 20 Mar 2023 11:10:57 -0600
Received: from EXG16-P-MBX03.win.lanl.gov ([fe80::9943:1574:6f23:46db]) by
 EXG16-P-MBX03.win.lanl.gov ([fe80::9943:1574:6f23:46db%2]) with mapi id
 15.01.2507.023; Mon, 20 Mar 2023 11:10:57 -0600
From:   "Priedhorsky, Reid" <reidpr@lanl.gov>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: bug? round-trip through fast-import/fast-export loses files
Thread-Topic: bug? round-trip through fast-import/fast-export loses files
Thread-Index: AQHZW07vhV/9lZera0+jmruoknfJng==
Date:   Mon, 20 Mar 2023 17:10:56 +0000
Message-ID: <BBB169A5-0665-47C9-819B-6409A22AB699@lanl.gov>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [128.165.106.174]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0BD098FAC4FA7D41B09F2634D026021D@win.lanl.gov>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: IxPVXMEPt-5bfiPW_urBfSbmU0SyBzZ1
X-Proofpoint-GUID: IxPVXMEPt-5bfiPW_urBfSbmU0SyBzZ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_14,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ICBIZWxsbywNCg0KICBJIGJlbGlldmUgSeKAmXZlIGZvdW5kIGEgYnVnIGluIEdpdC4gSXQgc2Vl
bXMgdGhhdCAoMSkgcm91bmQtdHJpcHBpbmcgdGhyb3VnaA0KICBmYXN0LWV4cG9ydC9mYXN0LWlt
cG9ydCBhIHJlcG9zaXRvcnkgKDIpIHRoYXQgY29udGFpbnMgYSBjb21taXQgdGhhdCBjaGFuZ2Vz
DQogIGEgZmlsZSB0byBhIGRpcmVjdG9yeSAoMykgZGVsZXRlcyB0aGUgY29udGVudHMgb2YgdGhh
dCBkaXJlY3RvcnkgZnJvbSB0aGUNCiAgcmVwb3NpdG9yeS4NCg0KVGhhbmsgeW91IGZvciBmaWxs
aW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQ0KUGxlYXNlIGFuc3dlciB0aGUgZm9sbG93aW5nIHF1
ZXN0aW9ucyB0byBoZWxwIHVzIHVuZGVyc3RhbmQgeW91ciBpc3N1ZS4NCg0KV2hhdCBkaWQgeW91
IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8gcmVwcm9kdWNlIHlvdXIgaXNz
dWUpDQoNCiAgUnVuIHRoaXMgc2hlbGwgc2NyaXB0Og0KDQogIH5+fn4NCiAgIyEvYmluL2Jhc2gN
Cg0KICBzZXQgLWV4DQoNCiAgbWtkaXIgLXAgL3RtcC93ZWlyZGFsDQogIGNkIC90bXAvd2VpcmRh
bA0KICBnaXQgLS12ZXJzaW9uDQoNCiAgIyBpbml0IHJlcG8NCiAgcm0gLVJmIHdkDQogIG1rZGly
IHdkDQogIGNkIHdkDQogIGdpdCBpbml0IC1iIG1haW4NCg0KICAjIGZpcnN0IGNvbW1pdCAtIGZv
byBpcyBhIGZpbGUNCiAgdG91Y2ggZm9vDQogIGdpdCBhZGQgLUENCiAgZ2l0IGNvbW1pdCAtbSAn
ZmlsZScNCg0KICAjIHNlY29uZCBjb21taXQgLSBmb28gaXMgYSBkaXJlY3RvcnkNCiAgcm0gZm9v
DQogIG1rZGlyIGZvbw0KICB0b3VjaCBmb28vYmFyDQogIGdpdCBhZGQgLUENCiAgZ2l0IGNvbW1p
dCAtbSAnZGlyZWN0b3J5Jw0KDQogICMgdGhlIGNvbnRlbnRzIG9mIGZvbyBhcmUgaW4gdGhlIHdv
cmtpbmcgZGlyIGFuZCB0aGUgcmVwbw0KICBnaXQgc3RhdHVzDQogIGxzIC1sUg0KICBnaXQgbHMt
dHJlZSAtLW5hbWUtb25seSAtciBIRUFEDQoNCiAgIyBpbXBvcnQvZXhwb3J0IHJlcG9zaXRvcnkg
KGFkZCAtLWZ1bGwtdHJlZSB0byB3b3JrIGFyb3VuZCBidWcpDQogIGdpdCBmYXN0LWV4cG9ydCAt
LW5vLWRhdGEgLS0gLS1hbGwgPiAuLi9leHBvcnQNCiAgY2F0IC4uL2V4cG9ydA0KICBnaXQgZmFz
dC1pbXBvcnQgLS1mb3JjZSAtLXF1aWV0IDwgLi4vZXhwb3J0DQoNCiAgIyBidWc6IGZvbyBpcyBz
dGlsbCBpbiB0aGUgV0QgYnV0IG5vdCB0aGUgcmVwbzsgc2hvdWxkIHN0aWxsIGJlIGJvdGgNCiAg
Z2l0IHN0YXR1cw0KICBscyAtbFINCiAgZ2l0IGxzLXRyZWUgLS1uYW1lLW9ubHkgLXIgSEVBRA0K
ICAjZ2l0IGZhc3QtZXhwb3J0IC0tbm8tZGF0YSAtLSAtLWFsbCB8IGRpZmYgLXUgLS10ZXh0IC4u
L2V4cG9ydCAtIHx8IHRydWUNCiAgfn5+fg0KDQpXaGF0IGRpZCB5b3UgZXhwZWN0IHRvIGhhcHBl
bj8gKEV4cGVjdGVkIGJlaGF2aW9yKQ0KDQogIFJlcG8gc2hvdWxkIGJlIHVuY2hhbmdlZCwgaS5l
LjoNCg0KICArIGdpdCBzdGF0dXMNCiAgT24gYnJhbmNoIG1haW4NCiAgbm90aGluZyB0byBjb21t
aXQsIHdvcmtpbmcgdHJlZSBjbGVhbg0KDQpXaGF0IGhhcHBlbmVkIGluc3RlYWQ/IChBY3R1YWwg
YmVoYXZpb3IpDQoNCiAgR2l0IHRoaW5rcyBmb28vYmFyIGhhcyBiZWVuIHN0YWdlZDoNCg0KICAr
IGdpdCBzdGF0dXMNCiAgT24gYnJhbmNoIG1haW4NCiAgQ2hhbmdlcyB0byBiZSBjb21taXR0ZWQ6
DQogICAgKHVzZSAiZ2l0IHJlc3RvcmUgLS1zdGFnZWQgPGZpbGU+Li4uIiB0byB1bnN0YWdlKQ0K
ICAgICAgICAgIG5ldyBmaWxlOiAgIGZvby9iYXINCg0KV2hhdCdzIGRpZmZlcmVudCBiZXR3ZWVu
IHdoYXQgeW91IGV4cGVjdGVkIGFuZCB3aGF0IGFjdHVhbGx5IGhhcHBlbmVkPw0KDQogIEZpbGUg
Zm9vL2JhciBpcyBzdGFnZWQgd2hlbiBpdCBzaG91bGQgYmUgdW5jaGFuZ2VkLg0KDQpBbnl0aGlu
ZyBlbHNlIHlvdSB3YW50IHRvIGFkZDoNCg0KICBUaGlzIGFsc28gaGFwcGVucyBpbiAyLjM4LjEg
YnVpbHQgZnJvbSBzb3VyY2UuDQoNCiAgVGhlIGJhZCBiZWhhdmlvciBjYW4gYmUgd29ya2VkIGFy
b3VuZCB3aXRoIOKAnC0tZnVsbC10cmVl4oCdIG9uIGZhc3QtZXhwb3J0LCBidXQNCiAgdGhlIHJl
YWwgcmVwbyB3aGVyZSBJIHdhbnQgdG8gZG8gdGhpcyBpcyBwcmV0dHkgbGFyZ2UsIHNvIEnigJlk
IHByZWZlciBub3QgdG8uDQoNCiAgTm90ZSB0aGUg4oCcZ2l0IGZhc3QtZXhwb3J04oCdIG91dHB1
dDoNCg0KICAgIGNvbW1pdCByZWZzL2hlYWRzL21haW4NCiAgICBtYXJrIDoyDQogICAgYXV0aG9y
IFJlaWQgUHJpZWRob3Jza3kgPHJlaWRwckBsYW5sLmdvdj4gMTY3OTMzMDgwNSAtMDYwMA0KICAg
IGNvbW1pdHRlciBSZWlkIFByaWVkaG9yc2t5IDxyZWlkcHJAbGFubC5nb3Y+IDE2NzkzMzA4MDUg
LTA2MDANCiAgICBkYXRhIDEwDQogICAgZGlyZWN0b3J5DQogICAgZnJvbSA6MQ0KICAgIE0gMTAw
NjQ0IGU2OWRlMjliYjJkMWQ2NDM0YjhiMjlhZTc3NWFkOGMyZTQ4YzUzOTEgZm9vL2Jhcg0KICAg
IEQgZm9vDQoNCiAgSXQgbG9va3MgdG8gbWUgbGlrZSB0aGUg4oCcTSAuLi4gZm9vL2JhcuKAnSBp
cyBiZWluZyBwcm9jZXNzZWQgYmVmb3JlIOKAnEQgZm9v4oCdDQogIHdoZW4gaXQgc2hvdWxkIGhh
cHBlbiBpbiB0aGUgb3Bwb3NpdGUgb3JkZXIuDQoNClBsZWFzZSByZXZpZXcgdGhlIHJlc3Qgb2Yg
dGhlIGJ1ZyByZXBvcnQgYmVsb3cuDQpZb3UgY2FuIGRlbGV0ZSBhbnkgbGluZXMgeW91IGRvbid0
IHdpc2ggdG8gc2hhcmUuDQoNCg0KW1N5c3RlbSBJbmZvXQ0KZ2l0IHZlcnNpb246DQpnaXQgdmVy
c2lvbiAyLjQwLjAuNzEuZzk1MDI2NDYzNmMNCmNwdTogeDg2XzY0DQpidWlsdCBmcm9tIGNvbW1p
dDogOTUwMjY0NjM2YzY4NTkxOTg5NDU2ZTNiYTBhNTQ0MmY5MzE1MmMxYQ0Kc2l6ZW9mLWxvbmc6
IDgNCnNpemVvZi1zaXplX3Q6IDgNCnNoZWxsLXBhdGg6IC9iaW4vc2gNCnVuYW1lOiBMaW51eCA1
LjEwLjAtMjEtYW1kNjQgIzEgU01QIERlYmlhbiA1LjEwLjE2Mi0xICgyMDIzLTAxLTIxKSB4ODZf
NjQNCmNvbXBpbGVyIGluZm86IGdudWM6IDEwLjINCmxpYmMgaW5mbzogZ2xpYmM6IDIuMzENCiRT
SEVMTCAodHlwaWNhbGx5LCBpbnRlcmFjdGl2ZSBzaGVsbCk6IC9iaW4vYmFzaA0KDQoNCltFbmFi
bGVkIEhvb2tzXQ0KDQpUaGFua3MsDQpSZWlkDQoNCuKAlA0KaGUvaGlzDQoNCg==
