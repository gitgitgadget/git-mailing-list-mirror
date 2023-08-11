Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCFDC001B0
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 11:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbjHKLqq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 07:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjHKLqp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 07:46:45 -0400
X-Greylist: delayed 304 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Aug 2023 04:46:44 PDT
Received: from smarthost1.atos.net (smtppost.atos.net [193.56.114.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BDCFB
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 04:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
  t=1691754404; x=1723290404;
  h=to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:from;
  bh=sK5uoDyM/cTFX3uYGM/ziDNthIK0jp8g3gP8B6K0+NM=;
  b=frOUXSkMfl2P2/5Q1czt5NI1gdsE2knXWWZMS7tkA/iHx0dUKnYNnE4G
   JT05UfafJDgPH8UnLNcdxBvK39KGhKEr2haxA4ys0BROWneYx/Xw3wkW+
   RNITbWC8hbBPYPxzGFRMQj1M16gRSOi7B28noxXCAM+vsKXMRI2MkasUt
   YbBEiYsU1hOskEmBseCOKRc/TFKMhEQQ2vdY9Cioxq2PtxVmcO/e5vhkb
   B2x9C1FPa3bv4jDsNkezzDSFVHsJSF9uXqfOvPEzeIhh5kX6l9FqI2WCz
   4CD10WhwbskHDXLzT/50xELFBdEVGpo1n85A+7a8A0Il/GoIuPXPV23mC
   A==;
From:   Richard Kerry <richard.kerry@eviden.com>
X-IronPort-AV: E=Sophos;i="6.01,165,1684792800"; 
   d="scan'208";a="414549444"
X-MGA-submission: =?us-ascii?q?MDEqnwwiw4okc84agQzDibPYZT7yt6wSr4ZAh0?=
 =?us-ascii?q?QpQVDs7LHmPHTm4TGx9rCAtiP8S6A3MAnRkECnkOvJKmEg6swN8KRPtm?=
 =?us-ascii?q?P2yX08SvHaOnKzRut71q3wEu5obUt/6nurrBfWmLotL54U0f45w7+vs/?=
 =?us-ascii?q?rH?=
Received: from mail.sis.atos.net (HELO GITEXCPRDMB12.ww931.my-it-solutions.net) ([10.89.28.142])
  by smarthost1.atos.net with ESMTP/TLS/AES256-GCM-SHA384; 11 Aug 2023 13:41:38 +0200
Received: from GITEXCPRDMB13.ww931.my-it-solutions.net (10.89.28.143) by
 GITEXCPRDMB12.ww931.my-it-solutions.net (10.89.28.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 11 Aug 2023 13:41:38 +0200
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (172.16.214.168)
 by GITEXCPRDMB13.ww931.my-it-solutions.net (10.89.28.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 11 Aug 2023 13:41:38 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdqaCjYidrVMnN04zhfxnbrfkChD+M7jsZ2Cl52PxtWiOz8scqsPOzEiCt2YQvZlLhsWz0o5WQavMii+r0MHgWi/ChMYR8Cg63blxZ2eCq/Uc7wJK4i4zefcnwo9GJajT2oEKscd2D8hvcfI146CR2JZ+4LXucvuLnMMWYAnXRfejcAqWSfRe9XwYGbg23GMi+mQqbl3xINbgiCz/huapZhpFB5rmgsH4tWXKNAbvK8zIBKUvrN4opXas58uRqLxfpbYXxo2bcXCcIW7o8PsUquQQa8W1KXQLdH9zIqWZMK0Zl5v+0C7VS9vl1oeuOCAP3hDZO3SSNKe3Kcy2K9pyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+qZS6wf5jY/j18/SFb8QhkVik7qeUP0+fXtrEBZNto=;
 b=M0kXY5R1Z/O0aNDj7MnOGYOQBaPttTsVdGlj3vZP2vVECBX9QCraWlI4lOY4XL9w1cNmsSxk6xc3RwIgZwQ9uRHevMQCmgrS8zNOgJPhKcRr939OVkWdoCzEJsDSE5DmAOl8+MkBLG5wPSb0dtWjuT3fZIyhLNLj7B+Q95LUaxSzxvVe+pMSKMlxrFbRT5pD7Duq1mO8yAAdR0R2bDdgYb1r2gJPctJxmjGs/an7q8yg97o7t2ykB9oIwVJ/i1fDo+0tr8QRHJbOKqzgM+Sq9DD8O/fjpK8HasgBKSdDXtG3he7fWEQyjAak4tfRPpHF8IddjWK/SyVf7UylWSckcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.net; dmarc=pass action=none header.from=atos.net;
 dkim=pass header.d=atos.net; arc=none
Received: from AS8PR02MB7302.eurprd02.prod.outlook.com (2603:10a6:20b:3f8::19)
 by DU0PR02MB10042.eurprd02.prod.outlook.com (2603:10a6:10:421::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.8; Fri, 11 Aug
 2023 11:41:36 +0000
Received: from AS8PR02MB7302.eurprd02.prod.outlook.com
 ([fe80::733d:acbc:a6bd:6023]) by AS8PR02MB7302.eurprd02.prod.outlook.com
 ([fe80::733d:acbc:a6bd:6023%7]) with mapi id 15.20.6699.008; Fri, 11 Aug 2023
 11:41:36 +0000
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [PATCH v3] rebase: clarify conditionals in todo_list_to_strbuf()
Thread-Topic: [PATCH v3] rebase: clarify conditionals in todo_list_to_strbuf()
Thread-Index: AQHZyVH6ojUQu7QyKU2SCiagEaN/76/fSPZqgALdOoCAADm5nIABFEQAgABB/ByAATWzAIAADvng
Date:   Fri, 11 Aug 2023 11:41:36 +0000
Message-ID: <AS8PR02MB730225B5F3D9370326AAB3C99C10A@AS8PR02MB7302.eurprd02.prod.outlook.com>
References: <20230428125601.1719750-1-oswald.buddenhagen@gmx.de>
 <20230807170935.2336745-1-oswald.buddenhagen@gmx.de>
 <xmqqv8dqd2bh.fsf@gitster.g> <ZNO7IVphPf8KOC3Q@ugly>
 <xmqqbkfgm2di.fsf@gitster.g> <ZNTTTAtNE2/DY9vT@ugly>
 <xmqqleeihok5.fsf@gitster.g> <ZNYOco835hbiDZAC@ugly>
In-Reply-To: <ZNYOco835hbiDZAC@ugly>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ActionId=a3ddcc69-b0f4-4e99-97f1-9a7b792aeda7;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ContentBits=0;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Enabled=true;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Method=Standard;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Name=All
 Employees_2;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SetDate=2023-08-11T11:26:57Z;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR02MB7302:EE_|DU0PR02MB10042:EE_
x-ms-office365-filtering-correlation-id: 4af22b78-c516-475a-3a1e-08db9a5feb8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HK2zKBpUbO9cps2l/DXSY1gf75DNJNyEJDhQ4OjxSGlh0iqYs7yn3iwU6E4YRgnnzAABcLHRFp5wVmSDCGmKvZPRXIMi2T3WD1XaafjmHfgNBse75cvKFkUGwnfRd5QRzMak9LatkmvbHTdJ+s4N7x2LWY7OPnW4RWmK3P7UGsZPm8zbpLLOnXQr7y5Ii0BQiH9MrFTLAk9BF20aYXdCFUpIl06QZhv2P4UgWOQW+ghE9tFfOhWh7Hx1XojXvWRDcvdSdwOWgbPA5424B04jH6YbpZ9Js25fNsuZ34eWBuu6lyi2SkRodEOElnf5BxJhN4PXGgR18kQgh4zNhSElUv2k8j3j6UaktvEHE8yhZSbvoKJ0NGjvSXc9yTgBF+vWAZT5y50kEN4HPsRATjLWy5JFBykRmioIwtPomiWgrBPoI4IDB5K0Kfe5kra8nxA7BSQMRPqBVpDqFENWp/mMEFRTI0S038A+BagbRSCKBxjlzXvE/0MGJCiYzNGL2a1/spRLujd4v/I2AziaMXJXeQOkSQ5OlHMyftAQRRVlEphli8rJmdqrd0IFeHqHB4JpwOvogR15TMsVFCSNSyWpfHWkRc8PpnFbyVVHe5b0/3KEhma8PUf3H14hag2qI2iO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB7302.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(396003)(346002)(39860400002)(186006)(1800799006)(451199021)(44832011)(38070700005)(71200400001)(9686003)(38100700002)(8936002)(8676002)(52536014)(86362001)(83380400001)(5660300002)(2906002)(33656002)(64756008)(41300700001)(316002)(76116006)(66946007)(55016003)(6916009)(66556008)(66476007)(66446008)(122000001)(7696005)(478600001)(26005)(6506007)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VINors8/q3jK/7d4FSzDqN/nJKM6nrTIlWOOshen0f/yjaSjFmgXwHosHs0k?=
 =?us-ascii?Q?J/Kvylzu5nn13t/wGp26foJhAuJcB/DJY0XASv1zSGC0fqZJwVIKeihImXBM?=
 =?us-ascii?Q?oZ629ldHADvundUkQui5JrUyrS2y4Q2+tAqh5BP1fhlFUyAuD/MrfDTU4oaJ?=
 =?us-ascii?Q?wC2iIZMo55nZZuUrWa2Lk8e3XF5TNPuQqwIc+iZ57qZzSS3YBPD8AWRjZaJ5?=
 =?us-ascii?Q?KGJ9NhmsQFq7dcb9foosBM73HdpojH8Ux7+niSjFEVmcU4j7dV35GSe0Dkxl?=
 =?us-ascii?Q?uo6u/Y8dPCFPqu2raNNeQUXXqTF/iOYiS2FJPhp51mj5xM09qf0fyhiu3mLz?=
 =?us-ascii?Q?tkCCX8HnsrCOi+llEqmqzh8vO0JSrti0U26rk+4E2rs96+EyCzOPGEQLi1fQ?=
 =?us-ascii?Q?FDhhSuEdFOFoys+p4VDi87LFt+fVs0gwpBRC5bvNXlyTFxHHa0tEzVo/3BV1?=
 =?us-ascii?Q?dXJGo+vnnjP4SqUaLmUAeH1I3K70BUJdTSkYtE2lyEBhjFz+f6LSce2qvlDp?=
 =?us-ascii?Q?xe97/rQW5r05XnzllneHOIEqYB3mdKid9C+NK3fr1TWvmKhklGGCFpJ5dlUk?=
 =?us-ascii?Q?bG5T65P8340yfZYIXSMLRkwH2g+AFc6LvR/9MjTtx6YLgs5aGjjh24wNzwMR?=
 =?us-ascii?Q?f4HbHgm3iswmOB3deCpRU54nJaDFpDBUCfAfQzlJw95BTy1/xlmpXp/282d5?=
 =?us-ascii?Q?GO4SXA1Tb8/bfhXzuz2UHR75dBCnMdRvk1zJeKU7AzqYH5zUKAFPTmjai6AQ?=
 =?us-ascii?Q?nOpUOP+eH4pK4tzdEo11pQ9wQ9/RGvy78GiFoYvk3Is4leAKeO/FwVHqhLd5?=
 =?us-ascii?Q?nztoOKHXdMjnhIyT+4dBGFgGRR2gKi3b3f+3058boYq4ua6lsCOBnn7/3AZg?=
 =?us-ascii?Q?HxfVd8OnKpPOdl5ALWsL0dlvupHOwhPKKBELo1K7AM/DgE4e+Ji7bxZ+o0JU?=
 =?us-ascii?Q?Kb+jub3z7Wt1mXLrIWktcg4zzxEXFyBA/0v0vpvBE8GFWvV4FkCQb5bS4nf5?=
 =?us-ascii?Q?yxGnd9lpDcIKCKqVwev51RSrd3cTSuHHrsKTIpk7ZB6H526kqdk1XdEjiwsT?=
 =?us-ascii?Q?NuQXWrCZRSeErlU0xgUIfQrLEZY8IDD1lWIYptPFkCWPKijfy2aDyiA9TPIa?=
 =?us-ascii?Q?lsCqJQCx45xiWHWh2KtjVF2nXf/6Tf8dwu56HDXlRSJVpi8HBmKZlv9uREIn?=
 =?us-ascii?Q?P2akzv0TVV8iBD1wDekJcxyU/t13Za/Z8RVm4+Hu0fi6DvHx+nKnaKAzsOrc?=
 =?us-ascii?Q?z7d0LaxwmXSBG/LZE+fY4t+nUnbTWSPZ9gj8YRguD8KO8l3MKO3WQr+26kd4?=
 =?us-ascii?Q?hERfrrmhaK9nzCk+rU8afXnKLJomA4QI4m74sIFwaN23r2uw755yVliBiwPx?=
 =?us-ascii?Q?l8LS6yTp696tiFdVm3F1dF0xZNX1PWb4IELANIyNAyLgVBQjo30w3Q/UEtjq?=
 =?us-ascii?Q?KzLyJX3XG1azCMLEZqaMuXboGcwlD+wfGQ6yvdR0IcwYPahkvaswmNd2ZzlS?=
 =?us-ascii?Q?YcN/T4cacB5lXS8PlkIdGIVRZ6XEN8o2XvmIx4eJhy0i96lGXMEwv+pKM3fR?=
 =?us-ascii?Q?t9h+K718o4OYYe6gSf2DDF5UL9Ay4wRtlrOyWOac?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2Qlu7cAnAj/JT5mPrZNZ3tBtnClwtAuuZLLBttkwY7EdzTnvrBDtwW7MYWqFHWkU+5cdpnvucWkxf+9maiQBARcqfgtuEcAsFPW8H7LRvVCFzLoFEvwUwdP0nRpzS4Z5a0gCqg2Zs2CQA6z/VQhTAmXqDUmtRw9qzmC/7XzuHEzBzUSmcig52h9h43wmrXEqNxqO3RuqMUfcwGlIx5CC4JVX9oArTP8PL2DKLaZQLtWb07wyXYjTMoPCAF1oAdRKDyz3/2yCInftcl7ZH6wZpAZoAF9mJVMddXjXYveB/2q6xwzaL5RyXWKsVrrehbFohLS46XCbrNfzEY6pEh6YaLl9/AUY3C3BJ5AYoidTGU2+uNE1GwTLLISImupOJtx+tlunxR0IsL+DjWpFT40iPri2xaaBJokWrj2e84i6xIT+h3HEUpETVV0JCJSXr7K+AhkQKFc+IF2vnzax+Cm9fV9jVyU8TX9PkdkrbRMCzvONJxt8VaQP3xsT6geTZ5m+wFBBTy0u1wQ3kywkFAvofrJp9ENtB77LWYsPtzH4KGc2E0q8EMT0q8bYmosJ5zbLEJNH6u8M/tgw155Iz08u0ShkvPj1OUVSxMfxnbudSb8K8tf4VdHqQNFWKbuLAGUsrA85gQ4UdP+2pNMWCNnrsWNJDUusx68EZiUNSkwX7sej8Pg/lfDXMPAuUB8kO0Pqo+AMKUCLDFTQSZBi6YpbeHuaV3hQEZUmsMTMTu3R2kZi1p8MzVU/uJVckT+r2OprxkV6+XrNBtmHLvf9jh11IVDSqDnYnZWBamlR/minTC2hiyr4NMIB3SCAC/SwEJ1DZtg1ivbBoQFb8IHhaUGlYA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7302.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af22b78-c516-475a-3a1e-08db9a5feb8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 11:41:36.7153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uGd1E1Unu8on6G3NAxPF2WPBZFBJ1T8j+xG2d2mLayRh5XDdz5Gn0bMlOUgJ+XM7dgzcbrE95SnYYFDfrhDrLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB10042
X-OriginatorOrg: atos.net
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>=20
> On Thu, Aug 10, 2023 at 09:03:54AM -0700, Junio C Hamano wrote:
> >Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
> >
> >> On Wed, Aug 09, 2023 at 12:39:37PM -0700, Junio C Hamano wrote:
> >>>Thanks.  Then this patch is still a strict "Meh" to me.
> >>>
> >> i can't really think of a reason why you reject such a no-brainer
> >> other than that you consider it churn. in that case i need to tell
> >> you that you have unreasonable standards, which actively contribute
> >> to the code remaining a mess.
> >
> >An ad-hominem remark is a signal that it is good time to disengage.
> >
> i'm pointing out what i consider a systematic mistake. there is no way of
> doing that in a way that isn't somewhat personal.
>=20
> the thing is that after _such_ an experience, no sane person would ever
> invest into something that falls under pure code maintenance in this proj=
ect
> again. is that really what you want?
>=20
> >There are certain style differences that may be acceptable if it were
> >written from the get-go,
> >
> it's not just a style difference. it clarifies the code semantically, and
> potentially shrinks the executable a bit.
>=20
> >but it is not worth the patch churn to switch once it is in the tree.
> >
> what is the problem _exactly_?
>=20
> the time it takes to discuss such patches? the solution would be not bike=
-
> shedding them to death.
>=20
> process overhead in applying them? then it's time to amend the process
> and/or tooling to accomodate trivial changes better.
>=20
> minimizing history size and preserving git blame? then rethink your prior=
ities.
> i'm rather OCD about this myself and would usually reject random style
> cleanups, but the actual experience is that a few "noise"
> commits don't really get into the way of doing archeology - searching in
> variations of `git log -p` and using "blame parent revision" in interacti=
ve tools
> are usually required anyway. saving a few seconds in this process really =
isn't
> worth keeping the current code messier than necessary.
>=20
> anything else?
>=20
> regards

I wouldn't get too exercised about this - the last person who did got barre=
d from the list.
The Git project's senior management are extremely strongly attached to not =
breaking Hyrum's Law.
However obscure, or wrong, an interface is, someone will be relying on it i=
f there is a sufficiently large user-base.  Which there will be for Git, wh=
ich must have millions of users (given GitHub has claimed a hundred million=
 users).=20

It is perhaps faintly possible that you could get agreement for a change wi=
th the next major version number.  Or maybe an announcement that something =
would be deprecated and maybe the major version after that would change.
Or maybe start producing a separate release series which can change this ar=
ea but is distinctly separate from the glacially changing main line of rele=
ases.

Regards,
Richard.

