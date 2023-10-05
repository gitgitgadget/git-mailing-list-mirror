Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A56E9371B
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 20:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjJEUlq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 16:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjJEUlo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 16:41:44 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2106.outbound.protection.outlook.com [40.107.244.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7D395
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 13:41:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4mz870MKekyVangPj0n3wDetbmiHx3b1V3pAo62cGv8xsfj++kO5n8vUgVo0jhPzQ7AA8FhWuvJijILinSggGTjYb4KFtzp3mMZppf2UK8pbGd+h9ghYwOl/g9jHlxZ3U5ndPwdU9r//ktOkTw7HnbnIcJsG+eAbQIh95CPORllLBATFNA/RCY3PQxFVl7EO7ZypORct63VsH8SdWvyGOsZ0YFwVHnRZCgBtI008VoichcoWAFQk/FQBcz1WWF8aGaifMySdiYtArTLI8WtL7DfDKnxLjjk5hq9H+slpS+WOORhAiKvkSsUITS9n0tKBBFSQMmpRhXex/mKymDJhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tm42bnDc/rifuFrI0B7cwKMIRsWg6O5Asgvj2tC1GY8=;
 b=nm1M+CYmefzlCfzLHx2mfVujQOHRAHZaOrwsgQybQCxysro8CSnBbbofAEh2iXMO+32T4qFuWutHHrAOxAAUKg7o2hvAJgMZQIclPJcSR7tsMMoOFTeKyVcr4G5EMzXOVn0dPzx+LkmhTYpYakzoeTTkZ89I+fkv8N3hYRuy4h8p0/qo59+jdTxcu7sBVgf14VbaPcU3lt/NYpMdlSFT9O6lZ90uxN1oTWsnoxJC2VqfkkmRbZ1kbCcJtod8ML5IRtLlPGmXr+53kzwPI6tK84jRtJsMT0ztXK8LxcH8B6vbQZeJdh+/JUXq+KhSs1dYo488zE/62xxCujqjYC4aJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tm42bnDc/rifuFrI0B7cwKMIRsWg6O5Asgvj2tC1GY8=;
 b=ghR/Hhg7hIaCRsKXJI/w+1qVtY2N0vNNE/kx6eQuGjpT+MW4JjOMUBjVV0V0If8YaB49QVmvWEGUX2xOCaYcvMNaosHDttvdqX46Nc9WCE/bb/kOd0KyR/vn+QSmWCjquEPNH/Vs2GN0nVakfb+89yKlxlbPNgMApk0WW+FbbA4=
Received: from SJ1PR21MB3699.namprd21.prod.outlook.com (2603:10b6:a03:451::19)
 by DM4PR21MB3250.namprd21.prod.outlook.com (2603:10b6:8:6a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.11; Thu, 5 Oct
 2023 20:41:39 +0000
Received: from SJ1PR21MB3699.namprd21.prod.outlook.com
 ([fe80::97cd:a6b9:22e1:4313]) by SJ1PR21MB3699.namprd21.prod.outlook.com
 ([fe80::97cd:a6b9:22e1:4313%3]) with mapi id 15.20.6886.005; Thu, 5 Oct 2023
 20:41:39 +0000
From:   "Rolland Swing (Insight Global LLC)" <v-roswing@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Anthony Chuang <anchuang@microsoft.com>
Subject: Microsoft Smart App Control - Git - git-bash.exe File Unsigned
Thread-Topic: Microsoft Smart App Control - Git - git-bash.exe File Unsigned
Thread-Index: Adn3y8YtJwTQp2GGTUOXCwWr6FHBagAAC6RAAAAUg+A=
Importance: high
X-Priority: 1
Date:   Thu, 5 Oct 2023 20:41:39 +0000
Message-ID: <SJ1PR21MB369933C2C879EAD0D5EAFBD1E3CAA@SJ1PR21MB3699.namprd21.prod.outlook.com>
References: <SJ1PR21MB36990080CCBC0BB415261D82E3CAA@SJ1PR21MB3699.namprd21.prod.outlook.com>
 <SJ1PR21MB3699CA030DE035CA42582AF5E3CAA@SJ1PR21MB3699.namprd21.prod.outlook.com>
In-Reply-To: <SJ1PR21MB3699CA030DE035CA42582AF5E3CAA@SJ1PR21MB3699.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR21MB3699:EE_|DM4PR21MB3250:EE_
x-ms-office365-filtering-correlation-id: c884e8a3-dce7-4ad1-471f-08dbc5e379ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bopNAMb9upyvJFOtohEGUO5Ije+q+s9joDqqlrGx9zcIiMhDoXvRWfehKREzK0te6Br5FNUZri8Np6wC5NoI1qpRaxtRuyG9bybP1/eg5DqrwHmyPaLYmNrtu1zzJK9L6LcoAQnMl1sLwB/cM61gmBaJz8TX/p4hLYmiyfEfgeXVMQt2SfwElEto74WkxKHS+3ig7P/kHL4TPdIV+hxFUzZu4IjJJ95EuQIsV+2ZWWFTp9tL1ozunMCP8SZrYt7+NMoTJsLuMcknQGmFl0KX5Hrwb1N9gNpPOycA4w3yESbSVTBsO6mgcBXv8XnNZupSCvFObd2XOKpTIm+b146RdTzooTEtEkn1uQoWP6y9y2Cjyqh/IdiNDM8dqOaAZYNLh9AGwzNM2GBWF2C01nAhnI6iMOFEhspvbqTNANINMpTZ5UQsHz+xBv3j3JXsRDAj3YwfLAZLDodaht1J0q3cLONauQUHJckhITxjksdxB6b+fnx/EIVzgO0JNDSg20G6tVfgeoJum7M9UdXdVqfeZIWAjHcDtYckfdZ8w/HQ7O7VFbWjSQBZJFKSndrZWUDjXOZHJIWYKybrjoPjS5GVc+jG1QoX9I4PFvfaYJ2LUeb31/ozr8s8oHbIxrLBRoEZc+Z6zeP1jauzsGibz3sJx4Imdjl/XT4vhoZTcd1UiryxRVMdYf/J3EpEc+fTm6GpQ+Lt9BJtmfh9CeQhiCFwSbwtF3i5xvIauMpnp5qsaCQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR21MB3699.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39860400002)(346002)(366004)(47530400004)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(5660300002)(8676002)(52536014)(2906002)(8936002)(4326008)(8990500004)(41300700001)(316002)(6916009)(66556008)(66946007)(66446008)(66476007)(64756008)(76116006)(55016003)(26005)(71200400001)(7696005)(107886003)(6506007)(52230400001)(33656002)(2940100002)(9686003)(86362001)(82960400001)(82950400001)(122000001)(38100700002)(83380400001)(10290500003)(478600001)(966005)(38070700005)(460985005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Klj/Zwac2TKRhzkGS5OMOVRZkuF+clOCRDTs/FFyprBv0bLqdmR9AMNL3C?=
 =?iso-8859-1?Q?DlhwMAANI4I8cmQRjMT3agdGcqmrL+MvQuiPnWLpm3P/jspSOeHRq7tACI?=
 =?iso-8859-1?Q?raqCpeq0PDd3TtqZNAVjUqs4fe3kkBM1gDc3iqA8WIS+1Rv0HKm/FloDhN?=
 =?iso-8859-1?Q?Z8xCbbg+l9y9tJxC6CceNM9hdeICrb5D5KJ/K8u8efSBPF5Yny5tCXcEaZ?=
 =?iso-8859-1?Q?NkivmZDq/HFzZh2+Wd4xzGL1dVMUmnOGd1mdtrTlO6xWK+gXQnAcpRajYe?=
 =?iso-8859-1?Q?sT0EHTYP2xWX7WNpNDdjLklE2hW+vfZdbXPA/YpfqbVjc/oRBdYPq4Jm5o?=
 =?iso-8859-1?Q?D2YOl2v3s2yDI84jDAUDcefrBRmwpc9rvklK7RaNEOFD9kWhuZnwMXS6Yf?=
 =?iso-8859-1?Q?ZuuVYNuM4An8wcN1RsPYNGtnc79v5t2gJrst4bVXXbDOlZ+N4Rh7Wy7VdF?=
 =?iso-8859-1?Q?YWn1lCzJRSfVRMVOBgoq88QhVhO0xGf4H3/cxcciFLmgzQxOYTub09l78y?=
 =?iso-8859-1?Q?hz2Zyg5ZNDjUBkk1k/GRuUUiP2j0EDAEE15eM2kPzsm+8yPRrtDkgzoBSx?=
 =?iso-8859-1?Q?LnfFtR6icxdQFhUmKx85342kioZW5/usUbcWdYSAGvZYcTZ4MoLhqXGKwv?=
 =?iso-8859-1?Q?UfoaivJAp66kXELYJHRepKOA9TrzNOY6JO0GB08tSYZN4IEc9v/8rRGTl1?=
 =?iso-8859-1?Q?5+qVcMAOVIsr6FK5TPqxnDcqK0nlmk8CNjDbtKq4zIWizAxB1oyNA9Ga6U?=
 =?iso-8859-1?Q?i2plarVAV0uZhwxvk1r986WW8guNY06P+Qxd7P5aJ32mXNc3HAEzuCh7/q?=
 =?iso-8859-1?Q?WiitwD4vzZ/WfugK7RNG05KyPeeQAgmGKdZiFsTM4yjJ5mzkZlhOM01Ai6?=
 =?iso-8859-1?Q?paX5/TW7oNoxtn7+kol5m6MiU/HqpuyijO4lgqOqeDFeWRbeSalt2vXG1O?=
 =?iso-8859-1?Q?kVEJGN0DbHWCRxYo27/gzeHEN01wzPDA9ICopikDV734rIkp2FJHkOHyLP?=
 =?iso-8859-1?Q?CZq6YrMq94Yp+MrWYHjJv4VFbZA1TCbHkdJJAN0UR2kdhqJ+bzMbPwUvdA?=
 =?iso-8859-1?Q?r9f9nshwxdwROZnFvIuS/3qcfVPrH+Rn9ja19RHllraZvKwX9/xOqTdqTo?=
 =?iso-8859-1?Q?eQegGjyNaxCNsF7bRqAsiTVeXmx+nLLObHSEx85quo8AJZ5lrqxIH/bDY0?=
 =?iso-8859-1?Q?ihSiRTzv0h9/qavw3ztkrb5iXDJb5nzKhPjSIGe2cak5D/biyNmQedhPUc?=
 =?iso-8859-1?Q?g7lS7mCkkKL8pEQ/q7Mn6cnY2/SPFe5ioNdbFTGd+lel6Od5xKTV8KXogn?=
 =?iso-8859-1?Q?jlNDEfqAiI1D6SOA+h1WeXziZVOeJu2SeE910WPW90tOQR0iscmyynYs5E?=
 =?iso-8859-1?Q?Edu1XsxA8Q7aDPiBcfxvowNwiN10l1EXub0NcUL9w2zE3Hl25ZTYJxt+Xi?=
 =?iso-8859-1?Q?ZeGfxamDUGqKcINt3dXv85Myqalu+CjyWGEABxY+TFAljQezoZFeESAsw7?=
 =?iso-8859-1?Q?NRF0yNaxob0s8/LEjpuip8pXcnJFDKdrwGlxyu1YZZTFniiQIEz3w5hke9?=
 =?iso-8859-1?Q?iv7eTcNAE/CsEKn6IiHR3hBXV9Wc?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR21MB3699.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c884e8a3-dce7-4ad1-471f-08dbc5e379ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 20:41:39.2084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wh0Z3RXaBxeCLReHJFFaK5iE2KIaEVFsskTVHYuRhfFS7ebqNLodSP/X7EegyvO9JhpaB7L08VSp9Hw+WE0aIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3250
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Git Team,

We're part of the Microsoft team that owns Smart App Control (https://learn=
.microsoft.com/en-us/windows/apps/develop/smart-app-control/overview), whic=
h requires applications to sign all of their executable files (exe, dll, ms=
i, tmp, and a few other file formats).
=A0
We found during internal testing and/or from user feedback that your app, g=
it-bash.exe, is not correctly signed.=20

Block Event:=A0=A0 FileName: \Device\HarddiskVolume7\Program Files\Git\git-=
bash.exe
=A0 Calling Process: \Device\HarddiskVolume7\Windows\explorer.exe
=A0 Sha256 Hash: 42F2E685686FB6356A195709AF912C7B9D424466BD7C6D69258AADA5E8=
0AC3C2=A0

Signing your app is in your best interest, as it positively identifies you =
as the developer of your application to your customers installing and runni=
ng your apps, and they can rest assured that your app hasn't been tampered =
with. For the purposes of Smart App Control, all app binaries including .ex=
e, .dll, .tmp files, and uninstallers all need to be signed.

For more information on code signing, please refer to: https://learn.micros=
oft.com/en-us/windows/apps/develop/smart-app-control/code-signing-for-smart=
-app-control
=A0
Please confirm if the unsigned file(s) will be signed in this or a future b=
uild, or if there is no intent to rectify the unsigned executable file(s).=
=20

Thanks,

Rolland Swing | Azure E&P Program Manager
Enterprise & Security - Platform=A0Integrity Team
mailto:v-roswing@microsoft.com


