Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CAFC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 22:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84FFB61041
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 22:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240500AbhHaWKm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 18:10:42 -0400
Received: from mx0b-003cac01.pphosted.com ([205.220.173.93]:37718 "EHLO
        mx0b-003cac01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240665AbhHaWKl (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 31 Aug 2021 18:10:41 -0400
Received: from pps.filterd (m0187215.ppops.net [127.0.0.1])
        by mx0b-003cac01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17VLxmpN000805;
        Tue, 31 Aug 2021 15:09:39 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0b-003cac01.pphosted.com with ESMTP id 3ascathg6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Aug 2021 15:09:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjS22G2ADYhQiWz0Q8nUDp7LEm1wiBYt3AiUtfvZ7d2rfnl4A42q19ie2I3qMysHPpgOEAD64g5IR9gB7VldUWKxvHLPouJutSVTHKjbWxikZqt2kcLMSHlseJ43OlxrmDeNPVoIZotIIs6N+Up7CMaO9hOFpVkVI4xGBu83n88IPiiVeD9XmhhDy1IvFrLnSbvBVo399KQEAqrZ1sVG3Ymk8PF1em9c8o52grD2PfXFFxqAEDvNQlD4yggy6M48CoUjmuw5zPOikYUhXgkxMvne1XMOVkhnedNnh5t+eSdGH47Lq96MtNRkTzrnKp0l55KMfLE0HCm/QK/5ZIBESQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flbvXfRHliloH2oWDwS91F5CcRP1r9rwbBb5u5FVFFk=;
 b=Em09NWPGl742lS1GonDPEjzvJxHlP48QV+ITto4w5tDwGuleAzXw6xhHjK3J7UV4sYu0n/SU1WEnegtJQgyVee3/SxGx+EMp4ReqczdsT5FIjdvvMCVw6aDxja1BzlmZTQt2b8uu1ICzFKeZYh/e0VzHC4gH2vFDpnmfht3JZ/RBAJyvxH0s9Wuez6pnhbW5bs6SdKhBGbZHTgEJ++dBgMcsi5qoYdIqK9VuftBE5uLIZ5LECIBiMM3U7V53nCG6DksgGzm+F3d3W1xZP34kQ5ipvGyUPtY4D0lz+RdtgwCGYggp/GpqT7VeMLXMLba9LGoUeZkEN/Bi/TKR5u9+aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=keysight.com; dmarc=pass action=none header.from=keysight.com;
 dkim=pass header.d=keysight.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keysight.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flbvXfRHliloH2oWDwS91F5CcRP1r9rwbBb5u5FVFFk=;
 b=DE1Lo5GI5G/qBSa+rFhgrEN1Gk/5dinqdWnZIzugp+FXmjXOdg0F7FRSWEQcVmJw2WawrsJnjkWt0UOMffls5B0ycwNzuuymxLespeYeIw9k2ySUU5yKe2ar6BLurMg992KqLhvhHIfcbDfY5acOMy7CmchhhFcMZKTt2Tg0/kQ=
Received: from BN6PR17MB3185.namprd17.prod.outlook.com (2603:10b6:405:76::22)
 by BN6PR17MB1185.namprd17.prod.outlook.com (2603:10b6:404:8b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Tue, 31 Aug
 2021 22:09:35 +0000
Received: from BN6PR17MB3185.namprd17.prod.outlook.com
 ([fe80::b009:dfd4:717e:64f5]) by BN6PR17MB3185.namprd17.prod.outlook.com
 ([fe80::b009:dfd4:717e:64f5%5]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 22:09:35 +0000
From:   Caleb Dougherty <caleb_dougherty@keysight.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Git stash certain files
Thread-Topic: Git stash certain files
Thread-Index: AdeeqRPZyQFTIvzTTlaj/uBqkmXQFwABHNowAAGOgoAAAB0skA==
Date:   Tue, 31 Aug 2021 22:09:35 +0000
Message-ID: <BN6PR17MB318540A1376CA1FACDE809DFFECC9@BN6PR17MB3185.namprd17.prod.outlook.com>
References: <BN6PR17MB31854E1EB7F8D358266B2AA8FECC9@BN6PR17MB3185.namprd17.prod.outlook.com>
 <BN6PR17MB3185652B92D61670BC92ABA5FECC9@BN6PR17MB3185.namprd17.prod.outlook.com>
 <058f01d79eb3$c5001310$4f003930$@nexbridge.com>
In-Reply-To: <058f01d79eb3$c5001310$4f003930$@nexbridge.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nexbridge.com; dkim=none (message not signed)
 header.d=none;nexbridge.com; dmarc=none action=none header.from=keysight.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 722c5b88-e615-4d13-4a54-08d96ccc04a5
x-ms-traffictypediagnostic: BN6PR17MB1185:
x-microsoft-antispam-prvs: <BN6PR17MB11853076770F336B37DC8F2FFECC9@BN6PR17MB1185.namprd17.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dcNHZ6HjoWzB2SrTgCn/qxFk2lWz1ZQmsYeTsbI8NJBhHSgPjTtsIi1kMH+1o/DgoN8LOpo3E/E15qB4Bhd5HU3XmCwMKVuFDj1XakItVmeofTryPGId4aMk5HRpGHfA4e2b39KgyX1WgGk7HZP81JHYJrlQQnLvCfL6+Fh5pS5U9xkJ1ZLt5nCzRgoM6wLeI8QPfnFTMC5clJA8yjfb5ztfK2Dr0rteEeRwK/jDI7CV4TV6BH16dK/tH2aThqIjXtZhwgwy5SGpbmSFYVnK5waO6fgXX26u4gkw5wmk0xi9YacS3OeXPBP7HcqAwxy+gxCcmhUEMNGvBn0IUaFeWHSH3TzVEwQ+bt5yTf0suSMbUkNNht1A22MUZsiKyXqCPM+Go6DBfA8p8Q/1V5Kz275ApFdNoUMmVEgm5jvgWxHQOx9F1sD+tqwej1MeuvoY29MKpQBD2V0zx2ghlLLq9FKfMRsivmE88qgRQu/ScmvW9NhKEWvwglFleabzRo9lltW2kznQkDukn+PgaDjKQeKMGT9y3I0VFJgPft2U+rNjmaNZwrRCnL1f6h6xrgJuzLi9RzjiEhSLMxa4ADEHayJwIzWFzaUNp9HsAy0FkxUJxb8Mf4G4LGN2VZJJ7xvHy0FjzTaJktIawSGv8u5wHEjLq0PWkFJcP4hzUsH4weNKgYuZE5QxEmrqRmM1NaWhFiNJRiudxSb2kilX7Qm9Hw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3185.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(26005)(66476007)(53546011)(52536014)(66556008)(64756008)(66446008)(38100700002)(8676002)(6506007)(9686003)(55016002)(76116006)(66946007)(2906002)(122000001)(38070700005)(83380400001)(3480700007)(7696005)(86362001)(8936002)(316002)(110136005)(33656002)(5660300002)(71200400001)(186003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hcsO4ygFmIRoP8xiz8sau1NWT71hYAIR6B2qysRJHaiw4slqSTTTdg0PVO?=
 =?iso-8859-1?Q?UBKiezjYHwTfdOg2uerod2pDSxct0Mish+9wNpTNCZDha5tiqWzhGTgzma?=
 =?iso-8859-1?Q?FI1/XY1hP3IBJE4TWLgy5TkdtfkBpgjSyHLPRHgvqRuHdm5vj6OxaloVwV?=
 =?iso-8859-1?Q?2J3Oal7CRB9iOV9CeBSt3jsDSqC75rOGfnfkIFhHHQIHyB9g267os5K2DA?=
 =?iso-8859-1?Q?6N1FXmBV/wayjfOgcjhcMTHYvOXSAS2oI4gVfdEDBd64alYGqOR7++FFjb?=
 =?iso-8859-1?Q?Or0SRuxRofiLJFjw90m494truv4lQrY9S/Gy3n8tVRc226oYPN9bI7uDkR?=
 =?iso-8859-1?Q?Zb2zK+ddNOiAVSLdSvO9UBwLu1xZg7UntssO8ir4twiWK4RZygtDRfeBYy?=
 =?iso-8859-1?Q?2XgP6ky/WcOwjXzEU1pM5mjiBbRCPDN0Ey2+eGzhAUfHz31vfAFm4yhGQB?=
 =?iso-8859-1?Q?+ZoPwinZMPOuxapERjdSs4XZcSiBMOTQrlprrGd/J//Jh05t+swvJ5IW67?=
 =?iso-8859-1?Q?dRvNS3+HAWFKXB/HFUESxmgepQQsGn9hRsvq9GblLl57/P1AK4GM9IHP/Q?=
 =?iso-8859-1?Q?pD5P2FzucebaryIj6vJqE65/W4acjYX8Td1igTjZvN4dTQ4G1k3kB4cyVx?=
 =?iso-8859-1?Q?nrvbv9eE43ipdBmJcdrV/7dmq+yZHSKp+bMhfPLtdJipqzMiRiPMKhe7nX?=
 =?iso-8859-1?Q?0lTn8xYqz738NiZeUeSXHiy33Ih2vaK5Xby27tJpw5IJBiiet45cGzo/YU?=
 =?iso-8859-1?Q?rvRR8kY1j9zITw6g7gzYrtN4ZCEb3Kb93oK9AxJpJ82gWY7tgyE7rBqTRV?=
 =?iso-8859-1?Q?MjuqIfzbTeluzrVw9iVjTgrurkwxi+BUQ+MGp/jDWv4oeKXg+qUk2mWVEe?=
 =?iso-8859-1?Q?l4WYGOZUHdklKtTsz6AuaVTpU/jtOi6TgmCP/8BBv46T3qgHhOlWFij3QN?=
 =?iso-8859-1?Q?Gfylc8EkvDRHqCnCJITiGwOyjI8UTkoMP3pDLb+jaIP5BQutQf/nAEPyNV?=
 =?iso-8859-1?Q?OjWC5UznFd4EhIf2CJZDflj6e2kLDbkVHaKy0Md8Wflzx5Sz/a28/VjeUP?=
 =?iso-8859-1?Q?Iw1PskUElJMozwb45pX0LuptLoUETgDg3kLHQDjZeEFJd0htaIUFwxnj9h?=
 =?iso-8859-1?Q?hPGJ2VNVplyLFeqKPrXPDM1oI8ybLOKKRBkrvRlFxGvss2rIiqW/MQBfZ9?=
 =?iso-8859-1?Q?PksjYfQf30z4l6IgyKuYob7yPJvfs6p+aydKKqDvzgsaWt/rHT6ATRScv0?=
 =?iso-8859-1?Q?xEuKpIi6HO2CBW9nockGu0yl8vnTUQzzV52Psq/PnE//ftHSBE60ulf0UK?=
 =?iso-8859-1?Q?Fm2wswCxyGjb/jmgBzcKK5vMCWU1fqJPxQ04NqKeH8DQG46JQNISw3336H?=
 =?iso-8859-1?Q?EV+cGee5SA?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: keysight.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3185.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 722c5b88-e615-4d13-4a54-08d96ccc04a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2021 22:09:35.4906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 63545f27-3232-4d74-a44d-cdd457063402
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: msipD5eqVUp93HV4lx3p3NY7mcrF6v/PQt6p84LzU49a/JfJJ0PT6rhsj45sxeKTuGEpgnND5fsrtIyVJ+xRNA8dbAsHoLivOOKaM/dTQ/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR17MB1185
X-Proofpoint-ORIG-GUID: K88x9Wctc1ixKMft_rN04mPro6zSPnZ4
X-Proofpoint-GUID: K88x9Wctc1ixKMft_rN04mPro6zSPnZ4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-31_09,2021-08-31_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 clxscore=1011
 mlxlogscore=996 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108310120
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Randall,

Thanks for the suggestion.  I'm afraid it doesn't help that much because I =
can only use it from the command line.  Usually I stage my files using some=
 UI, like SourceTree.  Otherwise it would be a lot of typing and or copying=
 multiple paths.  Think along the lines of, I modified 10 files, and they a=
re distributed across 5 directories with deep paths.

Regards,
Caleb

-----Original Message-----
From: Randall S. Becker <rsbecker@nexbridge.com>=20
Sent: Tuesday, August 31, 2021 3:02 PM
To: Caleb Dougherty <caleb_dougherty@keysight.com>; git@vger.kernel.org
Subject: RE: Git stash certain files

CAUTION: This message originates from an external sender.

On August 31, 2021 5:18 PM, Caleb Dougherty wrote:
>Let me know if I should post this somewhere else, but having used git=20
>now for a couple years in my work environment, and having
come
>from years of TFS usage, I still find that I want the ability to "shelve" =
certain file changes for later.
>
>My workflow is to create a personal branch and make changes to=20
>different parts of our codebase, and then stage certain files (not
all) that
>are ready, and then commit them.  Sometimes I need to undo certain files i=
n my working directory but keep the changes for later.
>
>Git stash will kind of allow that, but it is messy since it snapshots=20
>all my checked out files and I have to do several commands to
get the
>operation of "just stash these few files."
>
>Here is my "shelve" command.  Stage the files you want to shelve and then:
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 git commit -m '%1'
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 git switch -C shelveset/%use=
rname%/!shelvename!
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 git switch @{-1}
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 git reset --keep HEAD~
>
>Here is my "unshelve" command:
>       set branch=3Dshelveset/%username%/%1
>       git cherry-pick %branch%
>       git reset HEAD~
>       git branch -D %branch%
>
>It would be nice if this were built into the stage command as an option=20
>(to only stash staged files), or perhaps a new
shelve/unshelve set of
>commands could be added.  The additional niceties of shelve/unshelve is=20
>that it is on a branch that can be pushed to a remote (so I
don't
>lose it in a moment of absentmindedness or computer failure) and=20
>potentially unshelved by someone else ("Hey Joe, take a look at my code on=
 shelveset xyz").
>
>P.s. I cannot easily use the usual git workflow where you only do X=20
>feature change on X feature branch.  I work on multiple
features in
>parallel and cannot be switching branches frequently or I will incur=20
>too much overhead (not only running the commands to do the
switch).

Have a look at git stash push -- <pathspec>... I think that might do what y=
ou want.
-Randall

