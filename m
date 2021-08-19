Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5079FC432BE
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 21:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 322496109E
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 21:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbhHSV2w (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 17:28:52 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:35234 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230112AbhHSV2v (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 19 Aug 2021 17:28:51 -0400
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17JLErum030748
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 21:28:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pps0720; bh=RSdYNxnuTe3UTqP6ARhFYvp5xNJcLhYiXk/UjLKuYoE=;
 b=H53OwtxVovXb01+QRbpYlQA4mANBkU8190uqJb5qAVW22SV7QY7QBXh+pPHwFOIDa3S6
 hDr3VqjBmehzGd4otFbda+TPp+Pxv/fgKo/AVf6roHvz+s7J0wDVWF/RDs3hPKwx69po
 DnHnm+NTym76tYn/Ls+ifk3xt9FojvCI4alWHLVK9Qmz+TycccdjLqOHzKXUnyogh7RS
 ZW0ErX7LbAGMb98c7kDWzeNgpO2ah2NTvHM28ttK8ahEdXBk/BPTqrPQtvmiQotqPSzi
 znAv39gQovO0A7+Ltczc7lAqLFhh6NGEZ5Fx4wKolpQcZ8vqgvidCss+8RJSif9Tf7nG xw== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 3ahf52rk7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 21:28:14 +0000
Received: from G4W9119.americas.hpqcorp.net (exchangepmrr1.us.hpecorp.net [16.210.20.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3427.houston.hpe.com (Postfix) with ESMTPS id E77835C
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 21:28:13 +0000 (UTC)
Received: from G1W8108.americas.hpqcorp.net (2002:10c1:483c::10c1:483c) by
 G4W9119.americas.hpqcorp.net (2002:10d2:14d6::10d2:14d6) with Microsoft SMTP
 Server (TLS) id 15.0.1497.18; Thu, 19 Aug 2021 21:28:13 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (15.241.52.10) by
 G1W8108.americas.hpqcorp.net (16.193.72.60) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18 via Frontend Transport; Thu, 19 Aug 2021 21:28:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f852WM5VZv3RoP7c4JSYeGCjq4qH9OPumf51DhGX0glKs8ZxfcA/QFcSpSZ3v4sSMm1Yh3BD/cpWRRw/kw459aqMXs8BYPoqhohebicBZ9Mw2D/QPSr+uzo3n8TDgIMh0Xac7iiFHtOEm7AsNczQOwZWj98CdI+BG9UAq9yWcAwv9R+HDNmC6VbMgbYI0nf6z1FMUOzi7gdM/FmKAORaBvZxqhdbxhDYtIHxXSbqG3Z7IGPVHF90DOvZDxFDrcaWl6B39Vd8wpwHMYmLt718CcTRfLTtcgZUvgvwn5nnrHyQ1ApL3cBpmvMC6ayKTgGCxw9OSnSZIRoi8gCabzs3Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrSJvwGUqieiDfdID7DMqe07/hFtHtjncChzg0lckpA=;
 b=SfqOuH4AY4UmGC0Lfmeq1M1ckQ2o9fPVDgidp8NOla4gYHo+wz1sx+zrTNDBpWz+9PZN7yvnjTa0+b3JI8RuJU2aind2q9gLxamqK6auJb/ve6wJzUhHi+yHBPt1BGg6bemdCL4KIeWOsaGNK8uok+x9EhYKbZYsiHpkMXm48H3HFxJ7EXWsl3O4VCfiYKwFjRwd/f8nIOoJSyX7hwqM6/sQWY32UpF6UDVsYeUITYTgvJ3WMOdYGD2i91LaMNihmMBzVXTu+TROdpNDehfkzXJ3JxQCItiuC1F+uzZkru+8RRHumPQkX2M5kBNpEHwIdyDaWzdvjdycGwxhkxvVEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DF4PR8401MB0795.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:760b::23) by DF4PR8401MB0635.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7608::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Thu, 19 Aug
 2021 21:28:11 +0000
Received: from DF4PR8401MB0795.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::3d81:baa0:c2c:9d03]) by DF4PR8401MB0795.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::3d81:baa0:c2c:9d03%8]) with mapi id 15.20.4415.025; Thu, 19 Aug 2021
 21:28:11 +0000
From:   "Lin, Nathan (GSE)" <jih-tsen.nat.lin@hpe.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: General questions - git archive a .j2 file with keyword expansion in
 the header section
Thread-Topic: General questions - git archive a .j2 file with keyword
 expansion in the header section
Thread-Index: AdeVQRms95CkBgscRqmHDgD/eGAMFw==
Date:   Thu, 19 Aug 2021 21:28:11 +0000
Message-ID: <DF4PR8401MB0795EE7D2828A45289295D3892C09@DF4PR8401MB0795.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=hpe.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0051863e-0efb-4a95-f856-08d963583f39
x-ms-traffictypediagnostic: DF4PR8401MB0635:
x-microsoft-antispam-prvs: <DF4PR8401MB0635FB7366F7A49AFF0357F292C09@DF4PR8401MB0635.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /pjR9X4buhGgeoMByHrWNCJT30SKgRRaw0DY8XMd3WGp+YCy8ZXdvrfoMkTBX4OlHDWcYulvP+cWUWyuU6qZERQrhsKI2TNvQm2R44QbSU4nj6DpLTjsSft8tnRNqoyGIx6WyRTZUEwBrrhczJjLCKcb2PY1xM2h1r50Vmrf3/ODMF15ifJkMAT13LZOOrl03BM8ID1IPUiBlsx60M2qsIvHcUarErfTB+Spq/g6qeZqfdp3XmYADsz5qLS/1Fzg2whWHEFQ1a84HV6tgyw+7Vh2aZOoT6TDMIuV5xVy0/IeRbN2ziEKjEmzc/9Y2hPrNvlq3xhXTyjOX0kb0AcKT/RYQRXKT4ihL4fJoX8glps+sXD1Jl8f76Toqa5SSVjas8AdzbxUYHFbwfD45YkcgGMwquhj0lTLIYQTscQyBo+d53+BLvXCgIyG0KRccOE+5G9yEVOMeZPILI9Cn11z28fWVPQQkLM69EeRjqrdSTLCZzEf80ZFbWGWhSi+4AGgeQVwhhwnL8ex6K19nGpCsZUXk0IchW2Jr8u0HsPa7hLWmEuE9JAdjPVU/2IDgfAJrMZg0HJlN3Z/LCMjW/9x4AoquIQ2cJNoR9K0Mq1b2SPQA6dRYnGaX6ULqVkWQJIx/fK/YlpW7mUACZZDPK3Rn5nqWpPShicH8aC/0FhW2MJvYR685cyWflsEs0/Fi5FptOTZMzce3r5eqsX6iyJ2zjDYnzV+Tzmw/o8O885Ix7WvvQfgdPdMtSb6wAUIfu61dJDcNVmSIXgkQgNSXKY09Vmr7bXMmxCcmygp5PXwIotk4FlcispNj0T82FfRtqNd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DF4PR8401MB0795.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(346002)(396003)(366004)(39860400002)(376002)(38100700002)(38070700005)(55016002)(76116006)(6506007)(478600001)(9686003)(64756008)(316002)(86362001)(52536014)(66476007)(186003)(2906002)(122000001)(66556008)(66946007)(6916009)(33656002)(5660300002)(8676002)(66446008)(4744005)(71200400001)(7696005)(8936002)(142923001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OEuLvn6EMi4gzqj0Ho4abyqsO6NyzvvSxPC1D0/Lt/tcjhVKTuLURY98Xt9c?=
 =?us-ascii?Q?fqfCHpA4666u1W6e8rAv4HAPmeuQPTvN25TlGxq1PSNXK5Os4MxPukX1LtHr?=
 =?us-ascii?Q?3k69vXO/pTNXaJqlbST2OB2AHnXiuddKUUiGgi/ZydL2q1mndhDi+rED+aj7?=
 =?us-ascii?Q?pXCdKWA2CQW0/u7w3DPNkM9ybxCr/L8XNxjA0XogFL79heyL+yPU39/DKIiv?=
 =?us-ascii?Q?QIhn4FPLK8yYpW4bcCA3Ho+zCoQwmE43zwOgquNagAdLEMw/FK5njmfua3zn?=
 =?us-ascii?Q?PcC5FpaKFKDNzu431FnF9TyGnUWr7kdZK0pF/xVZGKxz/hY6U3gQgF5Ec26k?=
 =?us-ascii?Q?4q4i+Naw1C2WcnGJrJEcXyIH/ZVJ27X2SelZS1fVyMmbq3Fup6cl+jvEi4FF?=
 =?us-ascii?Q?UtiPee99ulDHEh9Z3IKi5LwBiqAhSIFZBQOTLSEKlrS+SnBygN6NRJPUrEZG?=
 =?us-ascii?Q?mtDivfiM7Aj64IiWaT9T/0OH6q+sfN1lCvod++efN/uaN9mPNSrtRFzoCKMh?=
 =?us-ascii?Q?4qPti1TKkKUp/w30meFnIClyrqqZpYdHgoS9uIUQq9HMvbPoOSBVrLzXAawO?=
 =?us-ascii?Q?8ayzU1fXvdlragZtqfZ5z13XiulNpOxFNPHXHpR+y8KwQjqBN4qTfCQFsLRG?=
 =?us-ascii?Q?IYN/3pniuVRpKxi31tZRt/9MN/44ndH+tpxT/bI5S53QCZoSENycO5F+eGHc?=
 =?us-ascii?Q?/hOVCer5po94KlwOyr1KTTZefn7HgD4DSGq7pIaNrqHKDsYGe+OTDCpva/Xn?=
 =?us-ascii?Q?HjVIHEN26kWb6/yO/wDvePS2bSctycVjgsbVtJ9s2lkJfHATXoHsXb6/srLZ?=
 =?us-ascii?Q?EfXT1JxrG1okp7u45y7d3BDbKhuACVMqmVQZ2JqF11nw5r9NMMG13cZXcRHv?=
 =?us-ascii?Q?4cMmUGJenaGaY+WLXgvqFSwhpgbZy8+z7T2uqfY3xVI7N5J84z2nRzt37Yvj?=
 =?us-ascii?Q?8dWf7y/R2/GAoTPWC5obcjE0BTXdyc9aQpnLVnfQNl+VAzs4/nVwHQ5OoqjW?=
 =?us-ascii?Q?gA/jdFYsqfZ8B6WkbmwAp6CdwYESJ/P1svcIdzz/kSov+3U2dqbymTTCTN2d?=
 =?us-ascii?Q?z5nn6GTc0s4ZmMMwDyygVptWxcCQZmLrErpfaOpgcS2V+fjszRBzR+RPXHyG?=
 =?us-ascii?Q?qc4HJOHaMsJAhrHBAyy8XntNtRHeXd2tKIbOt1qCwROa29PmIT9twoKWmVG0?=
 =?us-ascii?Q?Y1xxfK8bH+uvZ2uauR6/rGfqkzQYIxdrde0JXZEASWH71zUslfhKV6ER5gUi?=
 =?us-ascii?Q?mBL7IWW+T2lK7VuRKmVmrefZHhBeQFhuKOFviIJCZCSWeBim09EUDe4EpkaM?=
 =?us-ascii?Q?XdpPj1PcrTot3RkNTtlMHe/z99utfTVGIA2cs36Cdyv9F8h0hCGqBj9Wjkzx?=
 =?us-ascii?Q?s9EaPeQ=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DF4PR8401MB0795.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0051863e-0efb-4a95-f856-08d963583f39
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2021 21:28:11.6452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cxS/qXU94fNwDYGxJVCvJ5lM2vzURMLm+FhgKrGX+QomDzE+PTHYDojVn9cBBlE2ndSEIpDdvqbarwdP+ReO4mNWDJG2VoJCwIlmYi+umxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DF4PR8401MB0635
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: bPkSBfsGV4Yrth0abDLAwZ-IK526C20Z
X-Proofpoint-GUID: bPkSBfsGV4Yrth0abDLAwZ-IK526C20Z
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-19_07:2021-08-17,2021-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=982 mlxscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108190123
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Devs,

Got a question on using git keyword expansion on a .j2 template file. Keywo=
rd expansion does not seem to work with .j2 file. Please see below a snippe=
t of my attempt to archive test.cfg.j2 containing git keyword expansions in=
 the header. It works if I changes the .j2 file extension to something else=
, say .yaml. I have not been able to find any information about issue. Can =
you please review and advise? Thank you.


[root@da ~]# cat Ansible_Playbooks/Day0/roles/hpe-bm-kickstart/templates/te=
st.cfg.j2=20
###########################################################################=
###
# Author : $Format: %an <%ae>$
# Commit : $Format: %h$
# Date   : $Format: %cs$
#
###########################################################################=
###

[root@da ~]# git archive --format=3Dtgz HEAD --output=3Dtest.tar.gz Ansible=
_Playbooks/Day0/roles/hpe-bm-kickstart/templates/test.cfg.j2
[root@da ~]# tar -xf test.tar.gz  --directory test
[root@da ~]# cat test
test/        test.tar.gz=20=20
[root@da ~]# cat test
test/        test.tar.gz=20=20
[root@da ~]# cat test/Ansible_Playbooks/Day0/roles/hpe-bm-kickstart/templat=
es/test.cfg.j2=20
###########################################################################=
###
# Author : $Format: %an <%ae>$
# Commit : $Format: %h$
# Date   : $Format: %cs$
#
###########################################################################=
###

[root@da ~]#



Regards,
Nathan Lin
Solutions Engineer
Global Sales Engineering (GSE)
https://hpe.com/info/askgse (Internal site)
+1 (281) 204-4077 Office

Houston, TX
hpe.com

