Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20983C7EE23
	for <git@archiver.kernel.org>; Tue, 30 May 2023 19:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbjE3T0Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 May 2023 15:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjE3T0W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2023 15:26:22 -0400
Received: from esa.hc5997-4.iphmx.com (esa.hc5997-4.iphmx.com [216.71.143.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACFCC9
        for <git@vger.kernel.org>; Tue, 30 May 2023 12:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dxc.com; i=@dxc.com; q=dns/txt; s=dxcCES2selector1;
  t=1685474781; x=1717010781;
  h=to:subject:date:message-id:content-transfer-encoding:
   mime-version:from;
  bh=JIFApMsP5ivxoDQY0fXlT1uoeww902fs02HoWnfu1aY=;
  b=k3DWmmToESc/PyV0NEHI6JiXW8pmXz2BMU3DOguFjwmoTGdwTNLy6LtI
   dU/DOqArHxlWlqDZ2Q9+zo0kewaTCToe0Cat4fnIvmglTimzUWoT2LClu
   POPCAWfxQVPcc/K0tbpPTeiacPdRyOUH3Ru2OgchqsTbUC04RMyZKyqii
   tCyY9nhO5IX6ry0XACp8UqJ6cREV9JG6k7tXF/lfeeQffbTcBz4vKY2ku
   5iAoZWogqr34o0AV9rvB2FYOpACzt7Vb4agRwp2ymvlloVY/JeQhr6lXX
   I2RPutknchnCxUoK8uVMhx7r7eIKIxnOTlhm3AG0HHdKM/GyniVEDd9iG
   g==;
From:   "Mor, Gil (DXC Luxoft)" <gil.mor@dxc.com>
X-IronPort-RemoteIP: 104.47.58.168
X-IronPort-MID: 70540488
X-IronPort-Reputation: None
X-IronPort-Listener: MailFlow-Ext
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
DXC_Approved_Domains: True
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hc5997-4.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 15:26:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCdnx9dO0hnD+CsnrHCwsT1ZxY3kNogUCPY4wV1h8TJwoXp0m0TeMj2Q05XMLtqgxXzAWe4YlOpWBig/TCo/pTtQE5XzBFtxE8AUW7twHLDVRsomtxNJpHaCZrJqi2bMKXB3jXmFgxaGG7c0Bc0o5YYtFu2m31k9mEZO0O4Ps90mdyDkDu6UaOx6W0Vy1d+lZLOD71cy5tgM8j1uLXaH+f9Q2pXRB3JJo87S9vqPQYpUaN9fdykK4wbU/vwJE6Pad8483YEtqtkXufFCBLpaVO/USqA6P6oU/vsOdG/Zw5tQJKUJr8/jLN+ceqxL9GvorpRJLfXbIDl2HFH3Jh6BWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIFApMsP5ivxoDQY0fXlT1uoeww902fs02HoWnfu1aY=;
 b=KbComXCUCxq7JZ55JxqP3rxHkV2OszXjQ1MxDU98JdgtF675Acrhp0/gYAwIL5U2zG/37OkeVVQSgTTMyqTvsAvPigUgh10jKGOgD3/6k41evAczBbHOpFhDjLyy0nKsOwoFKi3mOwo5hhpJSlMnDANGDrVveLC9W5rhA2kfA65vhD3NazcMdfRBalM8mvNPlma93ee/u3/P6TzO3glxRl2y2vp1zBVj6EeSuQU882p5g81Ev3EHvZtfKNNVIb2Dl+7Y++qqoL5fpdDKKTFJO04BEWreNLZ3Z67WYa6UvHVnqFIYIELCIdUYvk8L0btPsIoPTR84xC6mg6dMaIeNAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dxc.com; dmarc=pass action=none header.from=dxc.com; dkim=pass
 header.d=dxc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CSCPortal.onmicrosoft.com; s=selector2-CSCPortal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIFApMsP5ivxoDQY0fXlT1uoeww902fs02HoWnfu1aY=;
 b=tdr7QMwwGwmm1fEDzOQtScD0YsFXJmuWm6DOqSU7jrLHSNJiyf/wO+2HstIKYBeNQDbWu5SHY2WRKRX+w6lXaJNZ0bCUp+IrNn83/wLPa0qMVGw0J72xtO529gKtMwfzG9N5CxY/IUdRUO+yj9I1iAa9pNPWgibGEP0U8g48aC0=
Received: from DS7PR01MB7589.prod.exchangelabs.com (2603:10b6:8:70::14) by
 BL1PR01MB7769.prod.exchangelabs.com (2603:10b6:208:398::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.23; Tue, 30 May 2023 19:26:19 +0000
Received: from DS7PR01MB7589.prod.exchangelabs.com
 ([fe80::b75b:fc3c:3748:d4b2]) by DS7PR01MB7589.prod.exchangelabs.com
 ([fe80::b75b:fc3c:3748:d4b2%4]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 19:26:19 +0000
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Git monorepo - recommendation regarding usage of sparse-checkout
Thread-Topic: Git monorepo - recommendation regarding usage of sparse-checkout
Thread-Index: AQHZkyxsX80i1C2EuUa1eXlxAtDjVg==
Date:   Tue, 30 May 2023 19:26:18 +0000
Message-ID: <DS7PR01MB758914BD44E20CF8185B7C5BF64B9@DS7PR01MB7589.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dxc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR01MB7589:EE_|BL1PR01MB7769:EE_
x-ms-office365-filtering-correlation-id: c1e5af4e-da9c-4d43-fae4-08db6143be6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GcfMw7UWpo9BxaodTP0OsBypcjYG0azwaJ+lTs1EdkasCXXT3zq6LVuRcAMnN38x59o4Zp0LEQ6Xssotq4v2MqryiVoJ1RilNg9YZL5MiR0XSuzfcLfXls7cZyKf2FveGEY1puUQAdTcYKxSYP51M9hf6KWe+Q/K3RYk0gHhbsD4pK3dbQdH8jldrZzc55ZKDITcxxlPaCXnf+lOe7amPu1DhHcD1iMtxVsVDdHhT2qIMbL/3Qv1U/VL3/7viW6JBRZtja71Es+WkrvPcteVlH1hyMU8MDpxLCarbQLOxqVgFBgiDRSGbOIzCodDJFlPXg2j4HAlqMWx+ZO6lyMuMzVjg+3w9IK0aXxsxItPIf2thk7eTC8bPvGly0SWFIGXUhsWvJ9poXim6wF/fbOAHpTG2xwZu65A5ayNjN1tKS8jJ3w7u0pJWMekfMpaGaZBjvuCEpDxvpIqjQffuOBHX11TQNGPK15PN48S//ZuGT3MKhOGYILDT+jEoUSNZbhzT/aGE05ikKByHkId0G3qHYOjytZ/bPl7RGvVrEWa/f87u+vZUxFfhSjSAxE5lYP6wtLVefg6+nPibf9jeaBMaqkvFPTJQTAXc28aNZsl9kM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR01MB7589.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(451199021)(7696005)(41300700001)(86362001)(38070700005)(966005)(55016003)(6916009)(316002)(71200400001)(33656002)(66446008)(66556008)(66476007)(64756008)(91956017)(76116006)(66946007)(52536014)(5660300002)(186003)(2906002)(9686003)(6506007)(478600001)(8676002)(8936002)(82960400001)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Fbq7vl+C+s6ZUY6HNHpFDi2valmOjQXG7vLcC4L0/ISMS3CTxW2XSN7C4T?=
 =?iso-8859-1?Q?0knGVMobR09Szq+nEJz5gd3+LWKZ/L4g8AR8lAWotcz5aAUAZ7sZCP3Sam?=
 =?iso-8859-1?Q?FPIrV45wzK3GUWXYF+5buETIsle2tZ+YxIWV/tgtxQ9RFifQKFHpnQm77E?=
 =?iso-8859-1?Q?30k1c+HqmpvfN+hxUvpYZRzeQEO7PtnqlXpn+EizdxWvz6ZMWMl3koCznw?=
 =?iso-8859-1?Q?YPMw4ZFe32ERfQXwjvMAFYWwtYewQXqBBOMX/9KQWm1ZBYlPH3DRTz5nbt?=
 =?iso-8859-1?Q?UJDTSEjjOSd/dfU+dNUA7Jef2VNQJm5zpf5d7/pg+XW7URZ65nnxmABuYn?=
 =?iso-8859-1?Q?1pP/E3dDK8SVkwzJZVdXW3Iy53y0NqhSYwMxmiU234fAqWV/U0wA7h6WVq?=
 =?iso-8859-1?Q?mdmMbNrj25c9dwJL4ntvI5H15GRcc4CJj2HHFRI/He110/yXlM/EVTw/gN?=
 =?iso-8859-1?Q?npDHmnkDZN9dQ5sFD+FO2+IngPesk04qCpCqdovg0/hbHi852i0+BZ1uPQ?=
 =?iso-8859-1?Q?kYtYq9268VHmGoI0myF+6GJHgwhUY02OAfZXJW7ttKuK8CMXnqf5zIAuZB?=
 =?iso-8859-1?Q?71qCRmHhk9TUWbgRA6KVfXAutg5KrbYKJA7JRELtuqy0IPqi+QwAy0XbI1?=
 =?iso-8859-1?Q?DemttTh/QADh7hvymrXjUyHS0tAMhaO0BU92DA6RC4Fu7QxrogqRvpnMEo?=
 =?iso-8859-1?Q?5Lc/WSUKLLynSAkUyfQHyae8hfZomXGSSwbOrw+A1IdN2C33WILcgC+3Hu?=
 =?iso-8859-1?Q?2EJBTozJfKJs2Ni+MBiTrBY8GeOyz7ciLRo16GNIVDwt2vtcbnyBh/atuL?=
 =?iso-8859-1?Q?iazn5shByGK0ea76kaVGMr1Er1OfE0k2Qd/Vltr0w2H/lHDXUW4dQlXjdk?=
 =?iso-8859-1?Q?ZHf+AG869IxEGrH35Rzw0QWy5P05L6dwtvjrWQChpyNXpAa/2uYDYUdEGD?=
 =?iso-8859-1?Q?xcrLqFlyPjETQsCa1ZZMmpZmOM67Oh4Sumv4Nov0FHkpYxKsbqskKYfFRo?=
 =?iso-8859-1?Q?9sCzZLS0tHqEPA6ZbUmgNrQUbJ0Rhg2vPIVu3pwFyInpP0IUFlj9I2N8Tr?=
 =?iso-8859-1?Q?XZjR8tqSBxEXpDwK99cJSBPf+ybu2bSDh4Z2BqtAKwdjdyVLhsqfghqqHy?=
 =?iso-8859-1?Q?43mT5iqABpdtx1FrcdW22BiTjpM4XUqmanpeVJ9KzdTiTArr71Wu4jFAOZ?=
 =?iso-8859-1?Q?ozK3X0B04mXBflx0nNM1jaloZVxnCWSkRaRTcAJMlQZW5XJOFPMxnl75Pw?=
 =?iso-8859-1?Q?nHZFvXRTQnTNmSm2dEIUTjjjhq65NnBlcifN6MLa8qfO5S5sCaQZVvLIJC?=
 =?iso-8859-1?Q?jG5t7NW33x/+Cjnc05Wp32ZLgqdolU81uzxriNvvlLuzvC7krrosC7RGsT?=
 =?iso-8859-1?Q?OnUbHRW/TNLNLBZDisnBWXhQhitRjctGZl7rQm+AAxxGQn4fVoHO0YTzeA?=
 =?iso-8859-1?Q?4JYysNVDX2hm503g907bXYvFGEsr4x8Nq/CW6IBaBgZ5IP3aj0ih3KnDfP?=
 =?iso-8859-1?Q?UBAIoZ9JGgR7O9Ny9qplU2jd7YvBV4sGc0ibVKrDlDWPbkz2io2h2TY55y?=
 =?iso-8859-1?Q?p8wB/hUA/Xd3mS7I39Hz2ie15nn1zBetaz5JV+7yWQKAnS+2q8p6wKFhaD?=
 =?iso-8859-1?Q?+jtRT4SZav9QlEpT/F5enK0AfcnIT7WzQX7gurs1scFQE67WWBscJLF/GR?=
 =?iso-8859-1?Q?q8nHsuyHoxhUv/YpiEY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: dxc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR01MB7589.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e5af4e-da9c-4d43-fae4-08db6143be6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2023 19:26:18.8058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 93f33571-550f-43cf-b09f-cd331338d086
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GA5tsMr4fc6kpTatHKNjR864tDL/R+LFOmoIPEcezWZnqSAnfAwKl9h1x31Bfuhh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR01MB7769
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, we are experimenting with migrating a large-ish code base from SVN t=
o a Git Monorepo and it would help us if we can get some input regarding th=
e usage of sparse-checkout.

From our timing experiments sparse-checkout is the only method so far that =
reduces our times to good results.

The only issue might be the Disclaimer that the sparse-checkout feature is =
experimental, and that the behavior will change.

We have tried Full, Shallow, Blobless, Treeless clones in all combinations =
and it takes 25-40 minutes for each operation (checkout and branch switchin=
g).
Sparse checkouts reduce these times to a few minutes to checkout and a few =
seconds to switch branches for each sub-project/sparse set.
Our code base doesn't have binary blobs - only text.

Out of the high level use cases we would say B ("Users want a sparse workin=
g tree but are working in a larger whole") fits us.
https://git-scm.com/docs/sparse-checkout#_purpose_of_sparse_checkouts

The command is already featured in GitHub and GitLab articles about reducin=
g Monorepos size but we are still not sure how un/stable the feature is or =
how commonly used the feature is already.

So, we thought we'll write an email to see if we can get a bit more nuanced=
 answer about the safety of real-world usage so that we can make an informe=
d decision whether or not to start using sparse-checkout, despite it being =
experimental.

We are not looking for 100% assurance, we know the responsibility is eventu=
ally totally ours and there are no guarantees, but it seems like a game cha=
nger so we are just looking for a bit more information so that we can make =
a decision.

Best Regards,

Gil Mor
SW Developer
Cross Industry Solutions

Luxoft
A DXC Company



