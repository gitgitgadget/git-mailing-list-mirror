Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 773651F856
	for <e@80x24.org>; Thu,  8 Sep 2016 21:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933196AbcIHVld (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 17:41:33 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:59699 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751468AbcIHVlc (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 8 Sep 2016 17:41:32 -0400
Received: from sc9-mailhost1.vmware.com (10.113.161.71) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 8 Sep 2016 14:41:25 -0700
Received: from EX13-CAS-006.vmware.com (smtp-inbound.vmware.com [10.113.191.56])
        by sc9-mailhost1.vmware.com (Postfix) with ESMTP id 746CD184D4
        for <git@vger.kernel.org>; Thu,  8 Sep 2016 14:41:31 -0700 (PDT)
Received: from EX13-MBX-039.vmware.com (10.113.191.190) by
 EX13-MBX-012.vmware.com (10.113.191.32) with Microsoft SMTP Server (TLS) id
 15.0.1156.6; Thu, 8 Sep 2016 14:41:31 -0700
Received: from EX13-CAS-005.vmware.com (10.113.191.55) by
 EX13-MBX-039.vmware.com (10.113.191.190) with Microsoft SMTP Server (TLS) id
 15.0.1156.6; Thu, 8 Sep 2016 14:41:31 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.113.170.11)
 by EX13-CAS-005.vmware.com (10.113.191.55) with Microsoft SMTP Server (TLS)
 id 15.0.1156.6 via Frontend Transport; Thu, 8 Sep 2016 14:41:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=onevmw.onmicrosoft.com; s=selector1-vmware-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=TnlJLabg77o/9DDRHgWQN0lBymcI1laDsQUQaOzckRE=;
 b=Eo8oJdDYnL6mxZS77vYL0l7p+EldSUednQr9mflUa7FdK0QLxAvwZQ4KxGfai3s+6v+h2/dJKPSFPdVYCz0U01NozbwbGWELCzbaVM5U/h6ODLeMoTpoRlvF0iZfUxPoBYAmHNIFWo/SiPdJ1gaq/8Fh9URrI/ubqbqt2ULpqXE=
Received: from BY1PR0501MB1271.namprd05.prod.outlook.com (10.160.200.145) by
 BY1PR0501MB1271.namprd05.prod.outlook.com (10.160.200.145) with Microsoft
 SMTP Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384)
 id 15.1.609.3; Thu, 8 Sep 2016 21:41:25 +0000
Received: from BY1PR0501MB1271.namprd05.prod.outlook.com ([10.160.200.145]) by
 BY1PR0501MB1271.namprd05.prod.outlook.com ([10.160.200.145]) with mapi id
 15.01.0609.006; Thu, 8 Sep 2016 21:41:25 +0000
From:   James Farwell <jfarwell@vmware.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Bug: git-p4 can generate duplicate commits when syncing changes that
 span multiple depot paths
Thread-Topic: git-p4 can generate duplicate commits when syncing changes that
 span multiple depot paths
Thread-Index: AQHSChlQs/xlOzS+F0ehYjLTGgsW7A==
Date:   Thu, 8 Sep 2016 21:41:25 +0000
Message-ID: <BY1PR0501MB12719CA4CB88596EE88F1504A2FB0@BY1PR0501MB1271.namprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jfarwell@vmware.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [132.245.40.5]
x-ms-office365-filtering-correlation-id: 28d50d0e-cae8-4e27-1206-08d3d830e210
x-microsoft-exchange-diagnostics: 1;BY1PR0501MB1271;20:mfbekLrDnNTBvSx2sXYw3wxMzcky8EatlnvoHmTtUngLW4pFHbQvQc99VNhqLhJkXHZtHugL6z5u5ymIReosw+XaSK8/+LQFyRBpGtOzffcoiPMd4nYIIRKZroHKw+Hd/4dZKYXkWEKh+o9AQawX7GhXWl/dKpE5OzYbYh1XkSg=
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BY1PR0501MB1271;
x-microsoft-antispam-prvs: <BY1PR0501MB127123FF8E64A50849FFC930A2FB0@BY1PR0501MB1271.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(131327999870524);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046);SRVR:BY1PR0501MB1271;BCL:0;PCL:0;RULEID:;SRVR:BY1PR0501MB1271;
x-forefront-prvs: 00594E8DBA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6009001)(7916002)(189002)(199003)(76576001)(66066001)(3846002)(305945005)(7736002)(229853001)(9686002)(81156014)(50986999)(74316002)(107886002)(2351001)(1730700003)(5002640100001)(6116002)(77096005)(92566002)(102836003)(11100500001)(106356001)(189998001)(8936002)(54356999)(101416001)(87936001)(97736004)(106116001)(110136002)(586003)(10400500002)(68736007)(105586002)(2501003)(86362001)(122556002)(8676002)(81166006)(2900100001)(33656002)(7846002)(450100001)(99286002)(5660300001)(2906002)(3280700002)(3660700001)(7696004);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR0501MB1271;H:BY1PR0501MB1271.namprd05.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (EX13-EDG-OU-002.vmware.com: jfarwell@vmware.com does not
 designate permitted sender hosts)
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2016 21:41:25.0124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR0501MB1271
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reproduction Steps:

1. Have a git repo cloned from a perforce repo using multiple depot paths (=
e.g. //depot/foo and //depot/bar).
2. Submit a single=A0change to the perforce repo that makes changes in both=
 //depot/foo and //depot/bar.
3. Run "git p4 sync" to sync the change from #2.


Expected Behavior:

Change should be synced as a single commit to the git repo.


Actual Behavior:

Change is synced as multiple commits, one for each depot path that was affe=
cted.


Best Guess:

I believe this is happening because the command=A0syntax "p4 changes //depo=
t/foo/...@123,456 //depot/bar/...@123,456", which git-p4 uses to get the li=
st of changes to sync, will return the same change number multiple times if=
 the change was present=A0in multiple depot paths. This is expected behavio=
r as per the p4 changes documentation: "If p4 changes is called with multip=
le file arguments, the sets of changelists that affect each argument are ev=
aluated individually. The final output is neither combined nor sorted; the =
effect is the same as calling p4 changes multiple times, once for each file=
 argument." git-p4 is handling the sorting itself, but it is not handling t=
he combining.

I would imagine this is fixable in the=A0p4ChangesForPaths() method by drop=
ping non-unique elements of the list before or after sorting. Rudimentary t=
esting in the python interpreter would suggest that something like "changes=
 =3D sorted(set(changes))" should do the trick, but I am no python expert s=
o there may be a better way.


Thanks!
- James
