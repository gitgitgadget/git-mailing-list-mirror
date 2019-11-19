Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17E221F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 13:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbfKSNUG (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 08:20:06 -0500
Received: from alln-iport-3.cisco.com ([173.37.142.90]:5720 "EHLO
        alln-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfKSNUG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 08:20:06 -0500
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Nov 2019 08:20:05 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1918; q=dns/txt; s=iport;
  t=1574169605; x=1575379205;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=ALfJX9ZtrWP2art7ejGueuQPkoQ70DVwJpwGBsJDkxs=;
  b=AxlH8YGTJAEU2VjvNymAatPXqMb66mvhE8jYgSL0JkU12VIJubiFA4rM
   cBZmsyjs74+ggJyDqrmlSRgizfhheneZalt9G07G/iUrCc5bCtDmIzkap
   QMAtqtwRFc5bqdt+cbv74thH6rUZaaQ7iBjvzid14SmscehB3dYK7PB0h
   U=;
X-IPAS-Result: =?us-ascii?q?A0DoDwCH6dNd/5BdJa1lgkSBS1AFgUQgBAsqh3ADinVOm?=
 =?us-ascii?q?hCBLhSBEANUCQEBAQwBAS0CAQGEQAKCJCQ0CQ4CAwEBAQMCAwIBAQQBAQECA?=
 =?us-ascii?q?QUEbYU3AQuFahUZAQE4EQEcZBQTBBMIDA6FRwMuAaVUAoE4iGCBdDOCfgEBB?=
 =?us-ascii?q?YUEGIIXCYE2jBUYgUA/gVeCHoR5OoNAgiyWXpdPCoIrA5VnmhGOSJoIAgQCB?=
 =?us-ascii?q?AUCDgEBBYFSOYFYcBU7gmxQERSRJheDUIpTdIEojg4BAQ?=
IronPort-PHdr: =?us-ascii?q?9a23=3Aiw4boRUBilNjPNCAou9rwvjrxTPV8LGuZFwc94?=
 =?us-ascii?q?YnhrRSc6+q45XlOgnF6O5wiEPSA9yJ8OpK3uzRta2oGXcN55qMqjgjSNRNTF?=
 =?us-ascii?q?dE7KdehAk8GIiAAEz/IuTtankiFcFLTltk8lmwMFNeH4D1YFiB6nA=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.69,218,1571702400"; 
   d="scan'208";a="383598982"
Received: from rcdn-core-8.cisco.com ([173.37.93.144])
  by alln-iport-3.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 19 Nov 2019 13:12:58 +0000
Received: from XCH-RCD-017.cisco.com (xch-rcd-017.cisco.com [173.37.102.27])
        by rcdn-core-8.cisco.com (8.15.2/8.15.2) with ESMTPS id xAJDCwQ5032072
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL)
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 13:12:58 GMT
Received: from xhs-aln-003.cisco.com (173.37.135.120) by XCH-RCD-017.cisco.com
 (173.37.102.27) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 Nov
 2019 07:12:58 -0600
Received: from xhs-rtp-003.cisco.com (64.101.210.230) by xhs-aln-003.cisco.com
 (173.37.135.120) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 Nov
 2019 07:12:57 -0600
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (64.101.32.56) by
 xhs-rtp-003.cisco.com (64.101.210.230) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 19 Nov 2019 08:12:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMcpgZY1je6hGvUE+iIAu2kCCH/omEcSdymXYp8gmLcZKbdhMceONnzCOqwbJS5ubyB199tA3R4Vrc9ITOg4opHPxd24py3xoIBjqV2WENFZVaZIqVlHBuio8PNdccAkVv7RzN21OhrXKXQrILqWY0iqk8of2XEM6Abcw1IrCxgTrpeY9ZVz2uOx2+rSR6RwPwSkQSRuYimB2AgoYtVQlauG4/di7aZRymwk0evbId3OhaGoXlyCQaA0NBChF8WllCy6gDchoZLUxK6vueaDA6vGKXNOyHiRxvsUBjUHtcsTqvDEzIci+0RpAxXPOs6z0lE/LI6SdD5a4UUI7MOAGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFT4hl2YI6VM1gDR47206kwu+od8tfKYvh57f4myxSI=;
 b=SPgBBOsVtiP7iycjqAyHBPbFUqT2UQtKoIatkSGSzDbFpFqpl8bFba+S43RCxEWOdJ5f0yBJqCgeyHTGcj5f798YLeq7+4+pBlqZXHZBGG+7g9+gipTwRB/cRLSJDsf7Gg2kmqkW+/mJvvKMyNww8BzJHlCvx8ZJ4iTLQTqBx84KZyVTtUXrCMhaE84XAdB8B3drl8hBy1ZLm/caKoGFNIJeXFDcpKHv8juLtFl9e/ZFEBKL3mG02aZ3hwHVAejzSPGxF2lsjr4uiJoVlhNZlmuS1sggqSjBMnqP/Wk53g12gVKK1QHoZ7OqXhUjEyAJF43b+MgxKCWVY4r3wbtyIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFT4hl2YI6VM1gDR47206kwu+od8tfKYvh57f4myxSI=;
 b=Hq4UM03ObcVaWTNRK1HPU8Lg2DOR1+250mv4fHlHaaWxzU+G0GA0GrTXTVMcjD6GFnHEM/VVNXDKOi2QGuGa61boojReGfyp5Tw9zUI6sIJUkeIWm4LUjC5i9LlN1FshA4E5CMDqLcJCryaITpEj+qqyPYnNPDbb0hoH+cJdTYA=
Received: from CH2PR11MB4294.namprd11.prod.outlook.com (10.141.118.210) by
 CH2PR11MB4454.namprd11.prod.outlook.com (10.186.148.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Tue, 19 Nov 2019 13:12:51 +0000
Received: from CH2PR11MB4294.namprd11.prod.outlook.com
 ([fe80::759a:b24d:909d:853]) by CH2PR11MB4294.namprd11.prod.outlook.com
 ([fe80::759a:b24d:909d:853%7]) with mapi id 15.20.2451.029; Tue, 19 Nov 2019
 13:12:51 +0000
From:   "Patrick Marlier (pamarlie)" <pamarlie@cisco.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Push a ref to a remote with many refs
Thread-Topic: Push a ref to a remote with many refs
Thread-Index: AQHVntgNsCy38IgfMk2h9wErEHyX6A==
Date:   Tue, 19 Nov 2019 13:12:51 +0000
Message-ID: <CH2PR11MB429411CA1288526D21C7AF26CF4C0@CH2PR11MB4294.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pamarlie@cisco.com; 
x-originating-ip: [2001:420:c0c0:1011::98]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29cb20b5-b9f4-4241-8f28-08d76cf22ec5
x-ms-traffictypediagnostic: CH2PR11MB4454:
x-microsoft-antispam-prvs: <CH2PR11MB44541D14C1D1E71D19658F4FCF4C0@CH2PR11MB4454.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(199004)(189003)(5660300002)(14454004)(2906002)(74316002)(478600001)(33656002)(99286004)(486006)(91956017)(5640700003)(76116006)(316002)(6436002)(413944005)(6916009)(476003)(9686003)(55016002)(6506007)(8936002)(2351001)(256004)(102836004)(71190400001)(71200400001)(25786009)(6116002)(7696005)(66446008)(305945005)(64756008)(66556008)(8676002)(52536014)(81156014)(81166006)(1730700003)(2501003)(7736002)(186003)(66476007)(66946007)(46003)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR11MB4454;H:CH2PR11MB4294.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cisco.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6MEVY3Gl87svV5Dpp58YjieS4cNDTGBjWN9DkEmzEcxJkqNVpNe0zuOeIrGmzuYzxiIlh7KJJLBE4qe9SeT1E5VE9X81WjhFC96XKpL0kECgqafcqJNoOhwjDWcr1Wh0vEkMDkUQPdLJHTUDqC5MWImEeqeXyGVqM9d4DmNEabMyvkt9RWrf3JkEFk4GCW652RziM5BQ2m+eHCltCymwkQqmqQMe7CBnpdV1NKnprz2aA2NcdsZxacmgDa4QbwPB4qmMNObqhfKUt34aysKfxcnjetLi6TdX7wZJJeVEIE+TlB5TbEtRY9aNDzeKe9jVnTx1bQzDnFzp36XDZMR4/bwRgAiQCi1Y4npBULd1ZrfczsQh6GccmbgTXhUQjDHkKMd0g3yuss37s5qo1qDx3ES4oddY7CrePTIxnjqV3yvuo8Vogav5W9hfkE7uIOI4
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 29cb20b5-b9f4-4241-8f28-08d76cf22ec5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 13:12:51.6280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3s85hvDSBiSr6niW6qNJWL0Hzgnl7NmdHGl+mZO4EqN4ktdbgzwA3V8xygLSN7r7holRR06Z4bhDp+6UoYXomA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4454
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.102.27, xch-rcd-017.cisco.com
X-Outbound-Node: rcdn-core-8.cisco.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear git community,=0A=
=0A=
I am hitting a performance issue with "git push <remote> <refspec>".=0A=
The local repository has only few refs and the remote repository has a lot =
of refs (1000+) with objects unknown to the local repository.=0A=
=0A=
"git push" of only one refspec takes minutes to complete. A quick analysis =
shows that a lot of time is spent in the client side.=0A=
A deeper analysis shows that the client receives the entire list of refs on=
 the remote, then the client is checking in its local repository if the obj=
ects exist for all remote refs.=0A=
Since the local repository has a only few refs, most of the objects are unk=
nown.=0A=
This issue is particularly amplified because the local repository is using =
many alternates. Indeed for each unknown object, git will try to find in al=
l alternates too.=0A=
=0A=
To workaround this issue, I ended up skipping the refs that are not part of=
 the push. See patch at the end of the message.=0A=
Is this safe to do? Is there a better way to do this?=0A=
=0A=
Thanks.=0A=
Have a nice day,=0A=
=0A=
Author: Patrick Marlier <pamarlie@cisco.com>=0A=
Date:   Tue Aug 6 21:40:48 2019 +0200=0A=
=0A=
    send-pack skip if not part of refspec=0A=
=0A=
diff --git a/send-pack.c b/send-pack.c=0A=
index 34c77cbb1a..0fe899f753 100644=0A=
--- a/send-pack.c=0A=
+++ b/send-pack.c=0A=
@@ -94,7 +94,7 @@ static int pack_objects(int fd, struct ref *refs, struct =
oid_array *extra, struc=0A=
                feed_object(&extra->oid[i], po_in, 1);=0A=
 =0A=
        while (refs) {=0A=
-               if (!is_null_oid(&refs->old_oid))=0A=
+               if (!is_null_oid(&refs->old_oid) && !is_null_oid(&refs->new=
_oid))=0A=
                        feed_object(&refs->old_oid, po_in, 1);=0A=
                if (!is_null_oid(&refs->new_oid))=0A=
                        feed_object(&refs->new_oid, po_in, 0);=0A=
