Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6058AC433DF
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 14:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2672E206BE
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 14:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dlh.de header.i=@dlh.de header.b="Rr/a+w5F";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lufthansagroup.onmicrosoft.com header.i=@lufthansagroup.onmicrosoft.com header.b="MXZVwMDS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389081AbgF3Ooh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 10:44:37 -0400
Received: from mx1.lhsystems.com ([80.77.214.51]:26866 "EHLO mx1.lhsystems.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726699AbgF3Oof (ORCPT <rfc822;GIT@vger.kernel.org>);
        Tue, 30 Jun 2020 10:44:35 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Jun 2020 10:44:33 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dlh.de; i=@dlh.de; q=dns/txt;
  s=ibmqlh-201908-6Ebhe7LLpR; t=1593528273; x=1625064273;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=ixkVj+q3UnKhXKXpfIWGOOQDk+QiJBvvV4x2sxFJNHs=;
  b=Rr/a+w5FaN70XybRnliVA0gLZlOgi6FqWM+FHzWavuhBDDUXQLAXDZE7
   nm/TwSRZUa8swHsLxG/jlwJ8nro889QjcvLr9HhkxLC6McBcxzPlezRcX
   v6VMNualaq17XzOM8T/jyHkNKVkBqWui+vkyqUDfGpYZr3sL28dxEkIde
   c=;
IronPort-SDR: DYGZXrEmMfW59Z+8hNs5CJtAm8WsI3iNffnVM0gcxnWIGBvXDOg9+ZztmEmXB+1Z4N1qsfSrRD
 LlJIncU5Q1uw==
X-IronPort-Anti-NAV: true
X-TimeStamp-GMT1: 30 Jun 2020 14:37:22 -0000
Received: from unknown (HELO smailin.ads.dlh.de) ([57.56.251.78])
  by mx1.lhsystems.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 30 Jun 2020 16:37:22 +0200
Received: from SW-FRAADS-EDG04.cns.fra.dlh.de (57.20.0.13) by
 SW-FRAADS-HUB31.ads.dlh.de (57.56.251.78) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Tue, 30 Jun 2020 16:37:21 +0200
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (104.47.12.56) by
 mxO365.app.lufthansa.com (80.77.212.237) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Tue, 30 Jun 2020 16:37:00 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFcSYKRTjt7PQa+5sZvyISN/Tf+qnxUt4gZFlkrSMgoq5VOqfp7u1tbHK9v/CTrXW9FAzLBKLjuO06OEbeOSYCu+LzJ2rZJllHj84eftsbTguwRaO6FcP2M5eQ1pQckd1DS84wy9Wfxxn5aMGE74m7Sw9ubGkCD9E3iHcXCWLnFSqUCY2dWvFPT0FQCnBBo6+VhyNf+sxcni6Q71RhbO+5DAqKzmSb3wKtncnFfT4GfhrY4NF3/zs6R2dA+zEXTZXQ0RiFvMR9mojnW7ycqjTsSxRccrfa+S6/Ce2VUsXn/07VfAvIECS5VBBqOSBzxQcQbqChA8jijALPaqiegPlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fINoHSK0jJlDex04yRR/ZnTwHu0jvokgVYmgJ3UPPKU=;
 b=leBSmxEA+j+O1TBXImIYUs9VDabqQ1fR0W+ZfMePPSl7D5ADuDb9scprs69YExhjac2SxSkXmBEK0pFPKxFyODzHdZL6piO8JBm/JNaa1sK1o2jxC09U09bp8f40P/tN1xciKPq+MmLqhEoXnQgn/vM5oXUquvU9KSzpemps9pKvwom2T5jPaO87f2ccnOs9a6L8SJ785UnKMlvjc3/1E8rz1nqdowsxmVIaEy3uyToQD6pMzuLHvgbv6WWO6nI/rhu5VjTZbM9hJOPwcScBQITH07pf39g1CGsvFspYejA7f5rZDpSGnuIjN1gEkoRifBB06u9Cu/AhvieV6a2L7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lhind.dlh.de; dmarc=pass action=none header.from=lhind.dlh.de;
 dkim=pass header.d=lhind.dlh.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lufthansagroup.onmicrosoft.com; s=selector1-lufthansagroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fINoHSK0jJlDex04yRR/ZnTwHu0jvokgVYmgJ3UPPKU=;
 b=MXZVwMDS81P+D0eekuTFm1IPSrOWfCz2coMnPtqhAY7toWVQGXmf5YGlLGqBbLUDPEFEUOP2RbyFeIYYn6uAM5WpqiyXcI0jI/pZnnSHw/wbLEyE6blCyipSNjuE2+BpYhDm49KWaKGXYntRH/FFlh4BcdcHZnBynNGnyh/7iWk=
Received: from DB7PR09MB2252.eurprd09.prod.outlook.com (2603:10a6:10:47::33)
 by DB7PR09MB2619.eurprd09.prod.outlook.com (2603:10a6:10:4c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Tue, 30 Jun
 2020 14:37:00 +0000
Received: from DB7PR09MB2252.eurprd09.prod.outlook.com
 ([fe80::f4f1:d84a:a7a:1c15]) by DB7PR09MB2252.eurprd09.prod.outlook.com
 ([fe80::f4f1:d84a:a7a:1c15%7]) with mapi id 15.20.3131.026; Tue, 30 Jun 2020
 14:37:00 +0000
From:   "WARRELMANN, RASMUS" <rasmus.warrelmann@lhind.dlh.de>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [bug-report] Segmentation fault on git subtree push
Thread-Topic: [bug-report] Segmentation fault on git subtree push
Thread-Index: AdZO6+ZgoURPt+3ZSWm8h/zihrRcsQ==
Date:   Tue, 30 Jun 2020 14:36:59 +0000
Message-ID: <DB7PR09MB225265C74CACD564A82641ABCA6F0@DB7PR09MB2252.eurprd09.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=lhind.dlh.de;
x-originating-ip: [31.16.101.111]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47fb7059-aa0d-49b8-9926-08d81d030c44
x-ms-traffictypediagnostic: DB7PR09MB2619:
x-microsoft-antispam-prvs: <DB7PR09MB2619F87066214E762C7D2E8CCA6F0@DB7PR09MB2619.eurprd09.prod.outlook.com>
x-eop:  bypass_spam_filtering
x-ms-oob-tlc-oobclassifiers: OLM:1107;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XHMCGLY8kFOXCMHoD88B44liKzf32T4t7kJk1PhwPDTUIVNcMztHVdMtZL5rG4GQUsGA2mc2YlxBnji2goaMjmg+0uLBh04nCEXBMZ1fu0stl7RLzFp2GhS2kNZR/cBll2R+onB8QHhRWpIgBMNdOpiwfHtBT21GYK3ff7E85H6aBXPmtEjMuak1HuCg9eI5RMi3Cuie6UBVmls9rXlhC4jBHgEO/Nof9bMqExJJ2wBEvh9sFIEEaDMMWoXwQulkIKytdZzaK+9w61o5EE1QJrHEK619D71e58myt6FwAbKs6h2AITR4h80qOjNvh4fYPoSGPrBLblBX+7jtwIxrO1QbhqQIFRvFge8jIzokA9GQWhqCr2KWdIuoYvJVmCzPXjxudjnUr5IBIQ6Iyf4bqg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR09MB2252.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(76116006)(66946007)(66476007)(66556008)(64756008)(66446008)(52536014)(2906002)(83380400001)(478600001)(316002)(71200400001)(86362001)(6916009)(33656002)(5660300002)(8936002)(9686003)(8676002)(6506007)(7696005)(4744005)(55016002)(186003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: qlyqN0DYodeLwi6igw8tXpPAAsxOGEV/P8jqjWL1NE6i+G1QSeMifjdWDq5bH2yVR4hOr2+2KnJz3GozHLAswW7vgne2KQSHHG3p5Y5wjVpIcoI833Qsf2mTrmuXL2EoIonr9wKIDkWYMvzzohcO4SHZ2ZQDFejh/AFnLyf1iD7mPtPnfHgJs9oToUBjDdzvArumTM1fx+N6CtsOzH8JC6cbyDzEjGNK8dLgK3+Tdp05S7nbXdNbiFa0gctoiv/1th1sTEp7NaigYXIBGkmeqFqbD1sWGhx/FvULrnVwXDothbsJQMeD5BkmeEHB7h16edr3d3EpKxNa7aZH3pE5zDSDGmYzRlb0bsvIHGwiKV71MwQw/+/1iY1Sr2rSCvjMdL9dw17hVljUSs3Bfkge0N/VJLmQqG7CQpkfqJMpWycaBdwwVsmuG3roGg4VSZcCjs2KnTBktjJi/bXEFgwZtxguY7yNhFVQGdcK6DDqrWM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR09MB2252.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47fb7059-aa0d-49b8-9926-08d81d030c44
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 14:37:00.0495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72e15514-5be9-46a8-8b0b-af9b1b77b3b8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RnqHSsX3xH62Lqf1U8sNTQCG1cbBg1WT4TX7quKvd+OOJLYXZ0w3BTwoiuxvZnyp/es7xR1Z/XSbHqejea24DY8/dQm1/gkrA4Y+4Q1VJEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR09MB2619
X-OriginatorOrg: lhind.dlh.de
X-EXCLAIMER-MD-CONFIG: 5a548768-c397-4167-aef4-f33627bbf3ec
X-TM-AS-Product-Ver: SMEX-11.0.0.4255-8.200.1013-25512.007
X-TM-AS-Result: No--3.616900-8.000000-31
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=EF=BB=BFHello,

I get a segmentation error when p-repo using git subtree push. I have the c=
urrent version of git (2.27.0.windows.1) installed.
The issue seems to be related to (https://stackoverflow.com/questions/57033=
081/git-subtree-push-fail-applications-xcode-app-contents-developer-usr-lib=
exec-gi/61380907#61380907). The answer from Jakub Zloczewski of April 23 su=
ggesting to downgrade to git version 2.19.2 worked for me, but I don't like=
 to use an outdated version of git.

The error message is:
C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 757:  1044 =
Done                    eval "$grl"
      1045 Segmentation fault      (core dumped) | while read rev parents; =
do
    process_split_commit "$rev" "$parents" 0;
done

Do you need more information on the issue?

Thanks for your help.

Best reguards,
Rasmus Warrelmann



Sitz der Gesellschaft / Corporate Headquarters: Lufthansa Industry Solution=
s AS GmbH, Norderstedt, Registereintragung / Registration: Amtsgericht Kiel=
 3688 NO
Geschaeftsfuehrung / Management Board: Bernd Appel



