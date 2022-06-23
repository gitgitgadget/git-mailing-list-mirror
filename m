Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B32C433EF
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 19:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiFWTRJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiFWTQs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 15:16:48 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021014.outbound.protection.outlook.com [52.101.62.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA36469279
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 11:21:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kB3XhtQX/DJBoVZAy7G04QbDsLNILwsYaA6X2XVVlLBSl9Sv2NmN8cOsb1iyb6rEd6OgYNXFDS9W8l90hgVqnC3q9Nh4tkjZbgBuitcG81YvlaygBwfoUvWYuo+tuWAtf3zCZk+A4VrC/OgcrfXiYdBM6xhd/1VtpbfyxMU6s+Fb0i97wnPPLKT5wkogad04XJ9PoQtWrQm7mqm/iKzQ/UWFHVq+Qlum/UAX5CVRPcSm27WAXDZtuKGJz8dP40v+ZzWcr7LeJHDgpc/JVWLeBGZhHMr7L7y3onkOldP+ReWKG7CHNuGskGpO5dfqMXDvFDazQbhC+wZlP2HL97DXCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aelzAyU+wJSH5XrUDGPu7d6Y62wqWpeBQj3LKrNftmo=;
 b=bDZrtzlQswsASInrYFIFutc2EexQMFtG4jAjcVv9XbsgF6yyZ3LX9cTTqbz6IACQ5z60o5PNx+MYvlArCVaJwI60gRrhaG9/AyP2muXe8OaZ0AGIdjr7A7bf5ykvx3/mvslFfbWoMMEp4hzEjEB/AA5VXDDgO+waEUZJK6Lr8SWITXp7y9pUASk6cz+k/QRdXyev81peGe+OjlOaTbpAKFAy3vQvqDNZPFgftJ/cvzMo0X7MYd+cBQGV+03iSLAIvdnbxEvzM/GZ1uWei/oPqL43pe5NomIjFEoUe3AV9GK+h3byq8Hvm6IFXDKgPjRE7IuMAYWTIoMDblxoC1FzCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aelzAyU+wJSH5XrUDGPu7d6Y62wqWpeBQj3LKrNftmo=;
 b=S2fglWbj+mw4seD7nkXs1I9mA9w4gvcgCCqDxjlTGQ7xYiQwqupu/1y74bMdVr8GLHhWYo/c5wMgU6e4IUYnGO+7iKToF+dSixvQFAYzxL6/N7cgeztM0vvom8x5m1s2guxmpJOuApcEItfKUHiXN6OxP3rib0e6MaHr3gq9vb0=
Received: from DM5PR21MB1542.namprd21.prod.outlook.com (2603:10b6:4:81::34) by
 DM4PR21MB3273.namprd21.prod.outlook.com (2603:10b6:8:69::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.11; Thu, 23 Jun 2022 18:21:12 +0000
Received: from DM5PR21MB1542.namprd21.prod.outlook.com
 ([fe80::e890:5b58:4827:9961]) by DM5PR21MB1542.namprd21.prod.outlook.com
 ([fe80::e890:5b58:4827:9961%4]) with mapi id 15.20.5395.003; Thu, 23 Jun 2022
 18:21:12 +0000
From:   "Neeraj Singh (WINDOWS-SFS)" <neerajsi@microsoft.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Junio C Hamano <gitster@pobox.com>
Subject: RE: [EXTERNAL] [PATCH] trace2: don't include "fsync" events in all
 trace2 logs
Thread-Topic: [EXTERNAL] [PATCH] trace2: don't include "fsync" events in all
 trace2 logs
Thread-Index: AQHYhxkrtSiZTC1HLUeoB30bYl5QK61dTZBQ
Date:   Thu, 23 Jun 2022 18:21:12 +0000
Message-ID: <DM5PR21MB15422C4A9D82BEF301262F10CCB59@DM5PR21MB1542.namprd21.prod.outlook.com>
References: <patch-1.1-df87e515efd-20220623T154943Z-avarab@gmail.com>
In-Reply-To: <patch-1.1-df87e515efd-20220623T154943Z-avarab@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5144db98-b7a7-478d-82f6-2de03449fb94;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-06-23T18:20:13Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70dc3df9-6268-430c-f86a-08da55452765
x-ms-traffictypediagnostic: DM4PR21MB3273:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l/PZJCB5/iZ53n68GtYmIQ9NHSJ5DNHXsaIPprIhQnBDCQDU+y6gRMjWBCeZzKHbUXkQSXIhLWRSIWu7uddlFsjeYgbZrtIkSvz5hbUm6N5o5nnBOPZq2Vzdqi+Q/mICADGQM+c/b8vrU7x1+JDQV4eZx84sZdz0sNkQkLKNjAhGMOJL5ChqEtGv/Z7Ym2wIG43qlHV64w6XsTdtUUPiAHt+ncSKXPIZxVd4MSdAMFSm6OUHS4JmrOkNXlsalEXXjNN6WMzEPUe43YEHazxTR7MiwU0WiTYBpqdvcm1p3LIxM0+N9gWujmF3lnjyAhIGyeDLHPpyXgQnzslVNiQBaXmQIBRU6PceVcqc8L8MjOFv005WQkH26V3TvztejRGYUNTxtuu7aNhkQoQTHhfrtggXbx64Py1knornARrXxjSCCEysa8hfOClqZIboXqQUecuBQBjUUstRD9V1+5kNkHSTkbeZDFYlp/TZW57F0ZA0/P4fM7J8yQdf8ycl/SZUKtJ5jcnpOyJys97Cf2rQp4HGIccJuVmjgkDhGKbinn1wkZ/DhuMNalGpxUG4cW1hHYa9x3HIzJV7LeznrkMYt6Fu1VcinaZ59uoaNOYKBljci5JfEFnyWM4BfzgOSVlFf4hRToPRxLzhNmoUszkF1GQctAdpxoYIbuuPP5bGp2YqjPR0UUF/ACPXYbyrVS+QrDO2i/RwvDQP18AOiyPbPFyiGctCLfr2tCWFmXRLaX7SZ1kOxe9kzlJKLGRD+O31cctLlOzQ79fiXD7uaDplijpZYRcBWMPhvdkH3yQn5c0ibv3mk/qSbeprC/2jyOeVG4BBOaiQhQho0uxH5w802A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR21MB1542.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199009)(82960400001)(186003)(55016003)(38100700002)(82950400001)(33656002)(122000001)(4270600006)(86362001)(8936002)(7696005)(6506007)(38070700005)(64756008)(316002)(66476007)(66946007)(76116006)(8676002)(19618925003)(66556008)(2906002)(4326008)(5660300002)(9686003)(478600001)(10290500003)(41300700001)(8990500004)(52536014)(558084003)(110136005)(66446008)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3RUNmKk5wZBKmUc6GtlkLUjNDv08PQ/JW0/ODTIGh5ESCHuC+paADIY1fa?=
 =?iso-8859-1?Q?jv8ZUvIUiVoKziktCt2/bgsmwMn3KdtJa0qALKFwwBa+RpFS7DIf0q1JXg?=
 =?iso-8859-1?Q?7rUsBdsXrYdio8VlMeSdZsR1Bz2tSeZXmLRtmZ8T+9p+h8gt73U9t4q3fY?=
 =?iso-8859-1?Q?6OowLnNw4SC7+zWn5xqIxEpkl9BIvib17MSo/Fe3xCPVOywZ+xzDObwsi/?=
 =?iso-8859-1?Q?X8cJK6CL+H3L9JIoEN1rQh+MmhAZMz1c3MdzcPyFZKTXxHbk+LpMKokjq/?=
 =?iso-8859-1?Q?bgUObyNbpMbuqXfqKMkrHhn3xxD4R9EhZweuVfgwdb4xN+vojq25u5wPaI?=
 =?iso-8859-1?Q?qz1FoM6zl6Gog9X7zuI73IOZIyYdlab0A8ahSg+xvKf87/qUbjWs30hnHv?=
 =?iso-8859-1?Q?fAxX7Mnwkcx01rJsUmlQIcPsQe4JUZ9vYdjbCbZMJ7/radCjIvzbAVCGY1?=
 =?iso-8859-1?Q?wVstfMdsTpQ7ENIXO5CqUtPHaE2vlM1DkJc6n64UOPuJm3yrfuwnWMfLKR?=
 =?iso-8859-1?Q?WdyIhAIJtetFiIirZFgHkDWMyBvBQxGITRaBvC2fJwl+24pToHu1amborm?=
 =?iso-8859-1?Q?Y8NE6/ZZeTbJcNxBhimW2WlZvJM6jv+BJ2x28V3ZNI7LvFSID5yabFtBa+?=
 =?iso-8859-1?Q?oDYw9zI7mWRHY0MRrDp0sMpOFH7WzeATFdzQecCJpb7U9XYzMVdC7/H9RE?=
 =?iso-8859-1?Q?BWrcz7mHcoHuGU3LZbwt+iCY0aqVNO+52Dqky3bNprui78LApjw1br5uXs?=
 =?iso-8859-1?Q?EtZBW89Hece0ArM1dmlL9J8N/Kdd1ZIR5EXGxHlXQ6gzxYDi1Euh9ICqlw?=
 =?iso-8859-1?Q?7jwpy0SDM9nryXc1oKlGBmfHQABUepSMxffThunGQ9kFT9v4VTE2wCeSH4?=
 =?iso-8859-1?Q?8bcijv6s4fRxo5fjZ9JoyoUMH/9OFUTQcKDWcos8fXYARIgOe1pjb7iqqV?=
 =?iso-8859-1?Q?v6nmKMrfX5PxhyQYCjXJShmOyRm8r0ZTv2353FTCnWzx06xWaLX23uLjyV?=
 =?iso-8859-1?Q?guPsIIOAXvwZ07S/3dIuplqxXJsBkm+ZYXv++p8hJQTg9AV6GcCViry3/w?=
 =?iso-8859-1?Q?b9LHxgfnTFYF84Vy06BFFcMGG4fdSOFvueQss+jx8U+gMZOF3EOvYV2lan?=
 =?iso-8859-1?Q?U1rs03ode8q9nTFEBmGNIKIKqyjMOW+cGUC57c3x8BxLOkWPaJuUoRoXA8?=
 =?iso-8859-1?Q?3YG0w3Z0DQbe1ia5tNxUA8UjieLj1izT/GRNZXKNtVGIQkk36tIG6In/ZH?=
 =?iso-8859-1?Q?VqSD17V6BYlK1tBxpRnM817eXxv+ut8GydGYCCAkw9LclEK6JdB0pVf4EA?=
 =?iso-8859-1?Q?lpX5aJPi19pOdmrtKUURW2Qnzhcw0eXtp2pYuAakpyZXh1PbkcK7IuA41X?=
 =?iso-8859-1?Q?gSbufZzY0qR08uJMMgmJsK/D/x7heXoAridXVEzdVYrXJFChrQ8hwnGlIi?=
 =?iso-8859-1?Q?thUmaLJN1MxPJsLdKad3SbMALipxeyRKxPT0OTbUZpx3DfywtVvlubeTVU?=
 =?iso-8859-1?Q?GLC5zcRCS/9SEjgQRLnCY9RuXnAwHc/RanGg/Pm9QyJZp8e7gMMyBaTza9?=
 =?iso-8859-1?Q?eHVTgWXKKLULPt7Xz2FiD2y5HQPobwdOjzzkrt1+GCmaAhXsjRSsgy2vMJ?=
 =?iso-8859-1?Q?dOGqdPTH99damVIBpgJxLcF1OQLkbqtsxxaxfRYV5SE203FAJRRgX+Rltl?=
 =?iso-8859-1?Q?gGl9QMS2WGmoDGIbCFaF4S2JoDdbEEK70G94JLVey8rEIKOPEQwf1i31Xh?=
 =?iso-8859-1?Q?Potg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR21MB1542.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70dc3df9-6268-430c-f86a-08da55452765
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2022 18:21:12.8288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E5pQVMib7VBQDdiXvnwSMRcAliM7t3RVSz2UTt9kvFuFtMn0oNAx0LVV66W9/QPyIzE58Paw/krBUsjPmRVEOCN3abwHrmld5AXDYIYGk/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3273
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch looks good to me.=20

Thanks,
Neeraj
