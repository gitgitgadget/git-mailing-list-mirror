Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0595C433EF
	for <git@archiver.kernel.org>; Thu, 12 May 2022 15:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356014AbiELPgc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 11:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356013AbiELPgb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 11:36:31 -0400
Received: from mx0b-00151a02.pphosted.com (mx0b-00151a02.pphosted.com [67.231.156.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BCA250E9D
        for <git@vger.kernel.org>; Thu, 12 May 2022 08:36:28 -0700 (PDT)
Received: from pps.filterd (m0046990.ppops.net [127.0.0.1])
        by mx0b-.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CEt2eC005970
        for <git@vger.kernel.org>; Thu, 12 May 2022 08:36:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=esri.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pps62018; bh=h0U3pRuc7hCMBkETvZymUrdafbBZwc0yw9DbyAVtcnY=;
 b=dLzBR5vSp0//DvPb3ibyNOlpLhTxo4IsMDca+3sFlT/YMfQ53o5pkIqb5QTgEnq8hcVB
 /lfuqR7/B1Yb1hCsYkmHGezNFxzekUJSUVN48Bvq+5AgicoVXHRJoS5Zmp8tH0jNZUi3
 1rsiQtH6JSAi1c3E9U+M6B+TbH++f2JYsPPTKThNvHys5M+2c8bj1+aiBXT7wkyyvsA7
 MDwVr8A/Bb95Z5iivJlxnMMwKarUKmNpcbvJNlvDCpbbBaJid9jjiGiiM1S78eIETO1Z
 J7mYeGIekq0txua/xpn5JMce0nrcCyPf7137SxqMeE66nEY9zj9HypwIu2tu7b419XFv KQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by mx0b-.pphosted.com (PPS) with ESMTPS id 3g0emp4yfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Thu, 12 May 2022 08:36:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAGkn6DvvpM47ncrrV0pDde+FfuTEsCfim4Yudq3D9gUXNokF65ZrGnirzz3uCYDOMe1aTF9w5EnHgoK3mpeYvs1Gki87AsqHUYureK4oaxeiIcMWBLw47/4/sRkK4JCiulIPVks/w5tzCTFsn7GkChkoTF1AN8HlA5DaX3MNrfVvYSYs2K2mHxUB9hyz3LcpWSqDw7EIkIZVOHxMVShxWfNShAEgP4Yhb44apGLhTlcy3mEKamjEDY7fwz9Ph9B6Q2MuFqxER0u9EQECDmMu4jSba+dOEM+CKeSkwdtjiQQ5DmkQxYXfwds53GfabcnthAtNeun/7dbDUlFKTb/jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0U3pRuc7hCMBkETvZymUrdafbBZwc0yw9DbyAVtcnY=;
 b=I5S+vm2ubDGXaIwKGz+NHDrxfttx3c48+Iwx0G4Boa12dXBUUOs8dS9m9SpoaMWP2V1IxAUbi75SBVnoq3XEzuIwi7nrY4loqLRx+YnDM+qWD/WQuR28w9SC6E08NQOgnvZYbcec4iqAf89mR8T5+7ya5uhM3nqskVR5JbXz/D6osfOvclISjEg6x9P/OZia9w/BZ23T1zrfFtYX9tzIPj4hPXJjiwRZkCNnvbOgZd0uUFizVd2hL/YkblnzV8xjZEfy9aOKSSzXDSXREX6BOYcUg1XbKHqkdGi5jtmJpec0dmGJOZYlD4fFvTnior28NIR2jH5mWBPQxUamxy0SYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=esri.com; dmarc=pass action=none header.from=esri.com;
 dkim=pass header.d=esri.com; arc=none
Received: from SA1PR05MB8454.namprd05.prod.outlook.com (2603:10b6:806:1d9::13)
 by SN6PR05MB4045.namprd05.prod.outlook.com (2603:10b6:805:26::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.12; Thu, 12 May
 2022 15:36:25 +0000
Received: from SA1PR05MB8454.namprd05.prod.outlook.com
 ([fe80::9d00:f7dc:c7c1:4261]) by SA1PR05MB8454.namprd05.prod.outlook.com
 ([fe80::9d00:f7dc:c7c1:4261%5]) with mapi id 15.20.5273.005; Thu, 12 May 2022
 15:36:25 +0000
From:   Robert Brown <RBrown@esri.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Git issue clone issue with .gdb , .loz, & .las files 
Thread-Topic: Git issue clone issue with .gdb , .loz, & .las files 
Thread-Index: AdhmD1M8n9AP1JwnTiay++y9Ag+RWQ==
Date:   Thu, 12 May 2022 15:36:25 +0000
Message-ID: <SA1PR05MB8454906260C1851A39813916ACCB9@SA1PR05MB8454.namprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 078fade5-c92b-42ad-7c45-08da342d2ced
x-ms-traffictypediagnostic: SN6PR05MB4045:EE_
x-microsoft-antispam-prvs: <SN6PR05MB4045D14E8E4BE341705DDDD0ACCB9@SN6PR05MB4045.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 537E6IeSB1IE3Nh7XKTD2770QSe0p3MfTdz/CHyi3CtysFJ2t68W6aK/ODZWsQQ6iEPCkMr6M1XS67JD4hFwLvWDBA4ANtY8YwU8eAZBx+iWOdq3wBySwoELJ+h1n5aw8+sD7LcWbtg9h7XTRtGmlkA6kOBej8oR/PbNI5SYMJmmDWDU7sgL8VG+rMXx04TMaLHYnKlAoGacRdtOMlTJLtlrLlHAXn4orp5rhp2sJnm51uL+xExY0m0ZcAa/wCRAiOocD+8oTOGYQaCFWj5Shv75fhtuHNhPiuTui4MJCfB28kSTZWb7NpAIhJQIGytI37vW93EOKfy/s9tgKoqecDKl+bIzrmCETSONF8iRPgZGSHGgcBXlqWFdqfCvsYqEu4Os7WSZreCbDXe146aYhXG7eKhE0VWipnf5MpG5KCt93nTU+OuGejRzwVDwgO8e70zXsBI/+vj6CI0B5fAFf47nN05yr1Sit2iByxQ0IYP2haJdLMBiTN1wj+pXwYLv6HbgGcaRkrk2fxgNA7Ml096nFvBF1/hfNdObaNUJqFn4lcy8jsDkeSY5CZ8yVIe6wn9atY49mXNW1B+6m0Pmd+NRtVQUOsPZNcmnGH10ElAlLvZF7BhmHyoUZWAMGdGS5MAaNBNBPF2usqSxim+a+nidGM3XY3faJvY0Ter9+p8G4TVPfH1XDEyQ8AIMJnyGpxwh1LJjI09qTO09Jy4Y/mq/e+qfUF2uH2aH1cT2P2u1YMxsoHjq2ZUPK352rp1TaRKnQvvjoe0gyfp/zYjcxTqXpTwQQb4NwXl2Fm6yr7FRhy2chI3hGWgs+CCq4psbX6R38BzKUGPw1FQUrOX+SCnx/TVbjdHBjEt9sw0hGoo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR05MB8454.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(966005)(38100700002)(186003)(9686003)(8936002)(86362001)(38070700005)(6916009)(83380400001)(71200400001)(508600001)(7696005)(6506007)(26005)(4743002)(316002)(122000001)(55016003)(2906002)(66556008)(66446008)(66946007)(8676002)(40140700001)(66476007)(64756008)(76116006)(33656002)(52536014)(5660300002)(142923001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kDzWAMsGPOOfMT0LYOmudnrAr+A8RQLQTqQMx7YpPcyAu4vL0M2buMzdAq?=
 =?iso-8859-1?Q?wTRmgdtDPrdgjs2jGtYAzgePt3J+g/NprnNa3uASXiT6wICH/Zlwuh0NE/?=
 =?iso-8859-1?Q?NAxD+t2N00g0m//+1L2X1lDjUrXtzFDvQI2W3MsMy27TiN6M1yP7/AWqUa?=
 =?iso-8859-1?Q?SMQMft1uVw4EI6gRNx3cDtHFjbh6QXngw0lq2yPYaC9GfGCGnc2jS0Mphi?=
 =?iso-8859-1?Q?ANW6pmjQ42aUu9srsdolYA81M5+ydnbekbgrvtD7apQ8vyOSpNkSbepK6C?=
 =?iso-8859-1?Q?KG5DxcSACheB76Nphxv9kC34c5NbCGQqSE71p4ESG3Z04AbVpQ2GvJnOAX?=
 =?iso-8859-1?Q?RyNyEyek9EV0xSL26Q46LIQj6cb6MaYyXol/2KDy4xnG9M0kzSymKaoEik?=
 =?iso-8859-1?Q?PcLIe5bY4WVLA65v/h/BRNfHJf8sZ/XwHgEmpwAnMchcEBGVlLlXIGxCNo?=
 =?iso-8859-1?Q?kOoyZPipCwNSZbR2eZOdne/ApDni3FVsohJF4U4kQk8GJyMg0Z/2FENhPM?=
 =?iso-8859-1?Q?wBywfR1RqrzxXClhkj+5hooUrM40kLoxt1W3wqpeJej3kiv7NP1cmP09e1?=
 =?iso-8859-1?Q?Y/78ZcVerzHzh+aEgtv1w/3A17yA6luSLSGtc4WfoVYOWkKg7roht+/V4a?=
 =?iso-8859-1?Q?RoA8Ic/HjisaGPfLhVXp8oz61EqCFAq7Cyhd5AeB9kVHtJWGV7TX0ZVPJe?=
 =?iso-8859-1?Q?7Fux4rX0w0DwPud92K5Xd/UA2m04E5mShluvGueXdY+cyxkAt567gREcl7?=
 =?iso-8859-1?Q?1d8BcUipwnxfEeCaK9WzNCoM25iUSjKE/vl3K1XCmhzyURk9yCT1enj1Pj?=
 =?iso-8859-1?Q?r4pewzTVwKxQby9oGB+DKHLrF96kwBMD4auj0PAcKFGVQ2HWQLEf0W7Pwf?=
 =?iso-8859-1?Q?IELU6NGCi5OejZq9/q3+U9e3ODlv+lF1HeXMDO9+psz495WeQbfRW2E52V?=
 =?iso-8859-1?Q?jjb8iS/iE6aO6qpKyuwXjxiESyoaCIK+aOGlGoI6W/5IWGd0JYbakhx2vX?=
 =?iso-8859-1?Q?v5v9rLfeFm0EtKWmokBuDM8A3T4wlN3zK+RYfaueg+cbMDgl/3L3VHNKh8?=
 =?iso-8859-1?Q?wp/5FljWRdajhQZ0eIplvVZfTDSTs1Gcneax8/Tyvfq49Yyvlkk17BUZIY?=
 =?iso-8859-1?Q?HsjrvxnaiKqUgAqKEbNILoK1pvUPEPH9s2m+4lX+JGHG7s9BuxR30ATZrD?=
 =?iso-8859-1?Q?9tdbJtKfwBCpKf7+vjwKXxk9ivtrCL7bkib2SMO/faQuKo1AHbmgU3bQ1F?=
 =?iso-8859-1?Q?09qpSh09WvZEDvc0SIZecQpjP7e5PjUzL08EcrTn3zCMr5T8k85a69Lls8?=
 =?iso-8859-1?Q?MNkfoPU5zYQ1mrQC3rYGH8lsypZtUz6wErVQuS/NRShuWyPDcCHgv5bJNo?=
 =?iso-8859-1?Q?hspth3K78B7Ru6SePTy0QIOIOuuiTYrlNxnDtrkqm6MeYIBK8ooN81undm?=
 =?iso-8859-1?Q?mOtWkVO6VHuGLku2MfKAnfT95BYIWbidDv7QiXaywuHy19SOhciT7zYQXo?=
 =?iso-8859-1?Q?xj561yuSQ8+vnydiSo1nWbcxDntIyQIIinCrtCgjeS23WjgatkhQVIBHD/?=
 =?iso-8859-1?Q?1cB1B3BgliRjtfY/AqKo38lEGwLbRNAJlCV6Xk7gfaXJuUjTv/iyjLnFIT?=
 =?iso-8859-1?Q?7QEDZHvYVrLfVGB/dDYwQUy/r9xxffAsmuoPc3KFil5a3vDIc8DD0Y7iEo?=
 =?iso-8859-1?Q?ZjnuLdT4UgRISUdHh83Ma+CrmEVf+LeFZYm1slBagAU1PRmS3GVvneuye+?=
 =?iso-8859-1?Q?Sqy8Z9Gxs8bTA2CDZJbg7QqU5sFDLm7E/HA8ms+cXeekRu?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: esri.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR05MB8454.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 078fade5-c92b-42ad-7c45-08da342d2ced
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2022 15:36:25.7968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: aee6e3c9-711e-4c7c-bd27-04f2307db20d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ymHOwjCZoqu0phvgDX0balSa05K7VfMUoZeKenOKYZ8y87K1nDh2R+WplfsCri1/V/Qnz2A6TqfHuOaHqSymSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB4045
X-Proofpoint-ORIG-GUID: etC2y3_hkKHL4tNj14xDWqiGcOoh_r9K
X-Proofpoint-GUID: etC2y3_hkKHL4tNj14xDWqiGcOoh_r9K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_12,2022-05-12_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 mlxlogscore=608
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120075
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi team,

I started a thread in GitHub, but they pointed me to you. We're having a bi=
nary comparison problems when cloning a repo in Git on Windows (git version=
 2.36.1.windows.1), LFS is installed but is not tracking files.=20

So far we have noticed =A0.gdb, .las, and .loz files are not even close to =
the same size and don't open after cloning the repo. Everything else seems =
to clone fine at the moment, confidence to moving to Git is a problem becau=
se of this on the team. I'm looking to figure out a way to make sure we are=
 getting binary matched clones when doing so. We sure would appreciate any =
help you can give us. =A0

We are currently testing locally, the repo and the clone exist on the same =
physical PC
Windows 20H2 (OS Build 19042.1645)
git version 2.36.1.windows.1 (64bit)
git-lfs/3.1.4 (GitHub; windows amd64; go 1.17.8)

Original GitHub Thread
https://github.com/git-lfs/git-lfs/discussions/5005

Robert Brown | Sr. Performance Engineer
Esri | 380 New York Street | Redlands, CA 92373 | USA
T (909) 793-2853 x6618 | mailto:rbrown@esri.com | http://www.esri.com/=20

THE SCIENCE OF WHERE =AE

