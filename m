Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AF1C433DF
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 07:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F9CB2068E
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 07:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=qmaw.com header.i=@qmaw.com header.b="n0fBiPw+";
	dkim=pass (1024-bit key) header.d=prudentialus.onmicrosoft.com header.i=@prudentialus.onmicrosoft.com header.b="7UA6/IWH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgFOHgt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:36:49 -0400
Received: from mailgate7.prudential.com ([161.151.153.52]:58465 "EHLO
        Mailgate7.prudential.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgFOHgs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 03:36:48 -0400
IronPort-SDR: /jlqm+iKy+LEIm/Hb+kFYLVFd0b9oKZ5shBo7TuBfc0BmjXHvW5PjBaeQsGpqkvNkKyMeAyYqc
 ekb/IBId8y7g==
Received: from p2erscba1085.prudential.com (HELO ironportpaprod7.prudential.com) ([161.151.153.21])
  by ironportpaprod7.prudential.com with ESMTP; 15 Jun 2020 03:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qmaw.com; i=@qmaw.com; q=dns/txt; s=20190808;
  t=1592206606; x=1655278606;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=OStxfi0XEBD4zVbAqc5VniLAaQG/dFhmykuPyVqvMyg=;
  b=n0fBiPw+tDwesBmirIrKuhkjB13YRc4fh/8++hw4cWfMEQ3hh6POO7Wl
   /nU85N2U87+l9oWL8/Eq+US77z1UigNprL4g2Pyo8qYVo4pNmHPmFXljR
   IkHWPs6TYXskc4vSxPRCnetjzV1dKFIg8VqSL0ap8Bt21PDdwvbVjypcu
   NuQnYo56IfAsjmpsHJ6CMaNEc5STmxOTf7pRsGz1GHxw5/93gaUiDsGda
   QeOE0C9G26z8yFyzqaMjy2VB8DOQqUJzvO/4Ju9xgIaVIK1LnURE4Rjgj
   gjpKTCQV+kWHjGuCnNAxo1I2jNuN7dEa0lM3q6oQL5QdHwfEjz7+NMMi4
   w==;
IronPort-SDR: bsxI3bGx/46svZPOa5+YeVCffo9uF2CuRg/BVbcx6r5LsCECnYcAMXk5nfjz0D7rJnMb+qVHoX
 PP4ik1wYfF9Q==
Received: from NAM04-SN1-obe.outbound.protection.outlook.com ([48.96.18.119])
          by njros1ngw23.prudential.com (IBM Domino Release 9.0.1FP8 HF450)
          with ESMTP id 2020061503364608-2377092 ;
          Mon, 15 Jun 2020 03:36:46 -0400 
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZoLyh9E0OEsT6ZHt5tNnod/Uwl2LSWDeSfWmbMNXwPNbQS5/ex4BgKenrgnCQg3tE/Y3UncH8TJh622mNmQbaOH8NqRvbs31P7Jn7HadHtJptJoBMqpHrUTJ6Gl6t/9hgt89IUDKw6LWg0gRfP3Z4ZvfaMCITDU9imfvNd7QOIYUNrhvjMiCftTjthJnYkdSbJmeiP/G0V43mMLDc35lJckqSa+fpTeTiirWNYlIH07t9i3AksUgCl4tootvY9DPO4/rI9xyiGvEebZI2k31cRwksCaRmT7ho3d8WfxASx9nrpChPv+eywxSRdmVCZylbDhvfbOEqyERiggafQ0iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xu06vnWq3JNgh+9wqLwsXPw7uvpJB2PILQ8TeuraNM8=;
 b=MT7xkZN6yFRQOvtAn71zhzGbX2mVfvPiJt/FbSkfe/IhnuJJr3gwFNv4mbAjwoZ0yh0iL25M7l84l/8mm5aP0LU7vgmqobtj+t1tVUnmaxDoJ3//bXdORa+k2aWNk8wj1kSyc++eQxNJop7xtzSnckirALapai0J5LVd4qi66P3LYTp0HvYnK9XZLY+7f/iZP67cEVAmckN9Mk5X7vBR4bYNMo9z2dmJ3W+rBpLpLEN4gD8rV0sHdjttD5WJci31sRjPmvfZBon01j8gFV9pNVcFZCEcQERMfMsJi/z0Ql+/qCYEL3KqDzQsnExQJIfzt9+uXVKwYlmAKmKorY3pfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qmaw.com; dmarc=pass action=none header.from=qmaw.com;
 dkim=pass header.d=qmaw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prudentialus.onmicrosoft.com; s=selector1-prudentialus-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xu06vnWq3JNgh+9wqLwsXPw7uvpJB2PILQ8TeuraNM8=;
 b=7UA6/IWHvIQVDSHNcWcRIqxXfzrB4eD6R/6DN7svHJunilg/YmYQDUF6zhoLRVSjXJX5Uyq3uX5xqwiYQGDt5sbjCxWT68QkgvCY9DqrlKNn8mcPo/45sBJ1u18Y/T/KzGaivhuhiie8r6cAeSQSe+hIVsiKFnU81ZxpWGEUptY=
Received: from BL0PR11MB3460.namprd11.prod.outlook.com (2603:10b6:208:6e::21)
 by BL0PR11MB3427.namprd11.prod.outlook.com (2603:10b6:208:7b::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Mon, 15 Jun
 2020 07:36:45 +0000
Received: from BL0PR11MB3460.namprd11.prod.outlook.com
 ([fe80::3c77:95c5:a97f:d659]) by BL0PR11MB3460.namprd11.prod.outlook.com
 ([fe80::3c77:95c5:a97f:d659%5]) with mapi id 15.20.3088.029; Mon, 15 Jun 2020
 07:36:45 +0000
From:   Ed Avis <ed.avis@qmaw.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git log --name-only improvement: show old file name in rename
Thread-Topic: git log --name-only improvement: show old file name in rename
Thread-Index: AQHWP+H0kjTryd4RS0S7/Rafrnu33qjUHQ/xgADr9YCAAC3qSYAEGFfX
Date:   Mon, 15 Jun 2020 07:36:44 +0000
Message-ID: <BL0PR11MB34608AE271344D508676D17A9D9C0@BL0PR11MB3460.namprd11.prod.outlook.com>
References: <BL0PR11MB3460BEB60550854661B5178B9D800@BL0PR11MB3460.namprd11.prod.outlook.com>
        <xmqqsgf1i46l.fsf@gitster.c.googlers.com>
        <25ca66fb-82bc-7278-90e9-5e1999593068@iee.email>,<xmqqh7vg2p4p.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqh7vg2p4p.fsf@gitster.c.googlers.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pobox.com; dkim=none (message not signed)
 header.d=none;pobox.com; dmarc=none action=none header.from=qmaw.com;
x-originating-ip: [82.69.86.123]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 266edd05-9d7e-4188-b135-08d810fedac5
x-ms-traffictypediagnostic: BL0PR11MB3427:
x-microsoft-antispam-prvs: <BL0PR11MB342726E2BAA0D40B843A7D099D9C0@BL0PR11MB3427.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04359FAD81
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zm8g3T7VrkxlWglShXTyHXByimNcPqbJQRjI70oXS6PmBeNMERKDuGlYs8h2VgH+U6Iu156RtIYi2CBXyH/fMh17tZXFRjVsxeFn1EoOOtJ2VjsYXSYd/HHsLk5RvxKeosrw60of0FUSPrFUsmuyp42xNExetBD34nQxon8hb+4sHfRPENVeo4lZgpsSz+27BznJ443SOqnDyxAjVWQ/xK32MvfL0ciIbDTKXyS4VJAJ7bhSXGW50Qv9COX/IcTCvv8wi1AlQ0jvOmlIXDey+TQLAej2B6E4rs4OMRhTT2tsPVzwKuvr2+SbfxheBx9ASSnyssj2lhkq3LpKX3T92A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3460.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(86362001)(66946007)(44832011)(26005)(6506007)(52536014)(33656002)(8676002)(8936002)(4326008)(7696005)(5660300002)(186003)(64756008)(66476007)(66556008)(66446008)(76116006)(478600001)(110136005)(55016002)(71200400001)(316002)(2906002)(9686003)(91956017)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: D6NJCX/g4qrRjZWp/jJ2ixUmjG6aby4zAYa5rU1uevG5ZzvXc2ZyEm2I5Mu1XsYcEEpM1dfeU8uNl5yyvTPfXKWR0KXBBZCIYnxmyJLxeHJfZxvEw5oVoFwq5sSKBDMeslf/fHUne5Mar6FNTJMfRMJvfpWJ4Xd5HXnMhiU13SYgix9uKrUVArJFTO9nKWBMkC1+LzRyoKG/TklIrII5UzcMAYl855wEcdL87W+INQdJOc8grde0+koyNejMSNEbnFXDTvTPdKU/2wA3Rh0h2HBHfNmWwWG9ddfpl99HlGWTa4ybZL03sffFNReekLLMecQhySms+kKmZGn6pVD/3STGU4k02zBM0vpqK0KrYPmvQyP8cAV817f/Otdw/tYk5KcEHgQZ6qja7nwieTGbmuYC9M9VgekD47GPJSMcR2Qz8zxjoFYINXoUMb/r1ZIgBdlcznvHkqZJyFZ4mjyrjiUUCcAKLi+yjk3Xz0CpL7s=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: qmaw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 266edd05-9d7e-4188-b135-08d810fedac5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2020 07:36:44.9742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d8fde2f5-9392-4260-8a03-0ad01f4746e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JhF20mZXAkUND8KT24CQAGMI7LNYAoZTmdjAFfBuUBVoTTvxFj6SvQnaujOKCPX+7ps9QJc3PXN73L7aD6OH8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3427
X-MIMETrack: Itemize by SMTP Server on NJROS1NGW23/SERVER/Prudential(Release 9.0.1FP8
 HF450|June 28, 2017) at 06/15/2020 03:36:46 AM,
        Serialize by Router on NJROS1NGW23/SERVER/Prudential(Release 9.0.1FP8 HF450|June
 28, 2017) at 06/15/2020 03:36:46 AM,
        Serialize complete at 06/15/2020 03:36:46 AM
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Content-Language: en-GB
X-CFilter-Loop: Reflected
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks all for your replies to this.=A0 I hoped that --name-only could show=
 when=0A=
a filename was removed, as well as when it was added.=A0 If you delete a =
=0A=
file in one commit then add it with a new name in the next, both =0A=
filenames appear in the log.=A0 If these happen in a single commit, only =
=0A=
one does.=A0 And in fact it's not predictable whether you will get one =0A=
filename or two: it depends on rename detection.=A0 Sometimes if a file is=
=0A=
changed and moved to a new name, git log --name-only will show only the=0A=
new name in the log, but at other times, if git doesn't detect it as a =0A=
rename, both filenames appear.=A0 This feels more like an implementation =
=0A=
detail than a deliberate choice.=0A=
=0A=
I accept that scripts may rely on the current behaviour, though I would =0A=
be surprised to find a script that depended on *not* seeing the old =0A=
filename printed.=0A=
=0A=
Anyway, if it shouldn't change, or if it cannot change because of backwards=
 compatibility, the manual page could be improved:=0A=
=0A=
=A0=A0=A0 =A0 =A0 =A0 =A0--name-only=0A=
=A0 =A0 =A0 =A0 =A0 =A0Show only names of changed or added files.=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 If a file is removed, its name is also print=
ed, unless this is detected=0A=
           as a rename, in which case only the new name is printed.=0A=
=0A=
That would be enough to direct users towards something more suitable like -=
-compact-summary.=0A=
