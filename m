Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C63C43217
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 12:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiKXMwc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 07:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiKXMwa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 07:52:30 -0500
X-Greylist: delayed 310 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Nov 2022 04:52:25 PST
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B613B8E081
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 04:52:25 -0800 (PST)
Received: from 20.79.236.226_.trendmicro.com (unknown [172.21.19.34])
        by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id E6FE01007454D
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 12:47:15 +0000 (UTC)
Received: from 20.79.236.226_.trendmicro.com (unknown [172.21.205.29])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 4B3B710000F43
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 12:47:14 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1669294033.462000
X-TM-MAIL-UUID: e21e7d2b-70e4-46c4-905e-af9e3d749797
Received: from FRA211050418045.tilonpwtvohulfj4uhoq5j3qhg.frax.internal.cloudapp.net (unknown [20.79.236.226])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 70E4F10000E3B
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 12:47:13 +0000 (UTC)
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01lp2170.outbound.protection.outlook.com [104.47.11.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by FRA211050418045.tilonpwtvohulfj4uhoq5j3qhg.frax.internal.cloudapp.net (Postfix) with ESMTPS
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 13:47:12 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBiAuCkbWTjJFGK/4hATUWPtpb2xFZh8LsMgsF3uUl1teZISZQSHI9UPIFPlc38Y/gNjNoM744Y7un3Ezw68AvE7Q0itS8+v0TKz4xhG3DiynK4sNl/jxWMa/dy9LJU4kVyiaWaYCBi24Sdf9A6jf0mKjlGoGDpmK50ohjYKtMQC2ApIilGiA/XNuhEcOVKZJAFtCfVEK6yUz1D40lUKpEzyZoHTzGBu5Jsyo6J857q8OXcDtiZAqHKweDxL7YwBHcCVKrGRw6o6z/2TG+WBG40pRJdsN8ku9FDw4s4qsAy5ATLDWRORW+cMMnpEPUhpndUmgN1W6L0nfmPc+kAxSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSnxly1zHHwJHDDkWlTYLB+PS08UWkQxjhv/A2AiqSo=;
 b=bHGUqgeFaMqk7OAe3dwoHFkJHlfRXJ9p5bWwqGkd7YcfPlDjshdKzB7YxhiIcs09QL/gwVwTqAtoSnrBUEnHCf88sH0WyWaYlVzIDSATCDgEsxWv2qtoOMo5uVI+RCfVXP1Yi98NTkIEK8+QTOhbNMxS1oyfDA9iqE+B/YJT8Kj86qJfqyBAX0nIe7u9VmaaY3qED6CyJYd+VDsnbVNYxdQSQFm6X+SDEK26ARHwF/UagYRpw4MjUOQVN78k42SYWIKyJB5555YiUVsJQkYUi+MRmP2Yn3ZxpyLS+5Xkl38VjCQMHSd7ljyPJjONy8G/HGj5oAY6Wrei5kMTlHOoQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=samsongroup.com; dmarc=pass action=none
 header.from=samsongroup.com; dkim=pass header.d=samsongroup.com; arc=none
Received: from FR3P281MB2141.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:35::13)
 by FRYP281MB3052.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:71::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 12:47:11 +0000
Received: from FR3P281MB2141.DEUP281.PROD.OUTLOOK.COM
 ([fe80::aa92:8bfa:6ab7:c18a]) by FR3P281MB2141.DEUP281.PROD.OUTLOOK.COM
 ([fe80::aa92:8bfa:6ab7:c18a%4]) with mapi id 15.20.5857.019; Thu, 24 Nov 2022
 12:47:11 +0000
From:   "Fink, Mike" <Mike.Fink@samsongroup.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Stein, Christoph" <Christoph.Stein@samsongroup.com>,
        "Scholz, Marco" <Marco.Scholz@samsongroup.com>,
        "Walch, Emmanuel" <Emmanuel.Walch@samsongroup.com>
Subject: git pull --verbose with submodules ends in error message
Thread-Topic: git pull --verbose with submodules ends in error message
Thread-Index: Adj//+7F3Kow8RMmRRiG7ZSlox8DXQ==
Date:   Thu, 24 Nov 2022 12:47:11 +0000
Message-ID: <FR3P281MB21416B718C4C052A28C319B1E90F9@FR3P281MB2141.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=samsongroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB2141:EE_|FRYP281MB3052:EE_
x-ms-office365-filtering-correlation-id: 453e95c5-f3fd-47c9-55a0-08dace1a019c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Nu/IIO/WEdLJJ6lM+u4VXH1lRTiQgQWXXMg5ZbEV1pYBGXY9uwLW6jCW6zKBVX4IfzYqhZQq8vgEBBzGq0QL883KsrnM9WbbvWhQyJSr0m3qOJ1j3XVb8idFmZrOsPEcnptwJtj46O9eK4+ANAjfDkAyLAz02WREY2lJpbWJW9LoHYFyggvyc1pwgpG3GwkC90UzV2N6EgAdVSHgSMKcWYE+Z5kLK7YYwTJnL7QCFNASvqGPJQb2rnupvybt8qi50TLfH9n9yYF+j5hVM/3N05+sLTDYXw0T8z6gKkfZk88nTrvRRfzvr3jOxB4W9dFlezweauUMsr8wRrCk/n0BQVKekge/R5ejvOHrb2HtImULMNwIWvGHXBVXjEPevUuTWSM5LbbBYUbKNt6R3SHTkQjuW9mksxHFD4+rblRvbwCWMdGmZ0u0dMKxB7AOx1LrUA6wMAu1RxJx7nVRwp/G15hIqMdzpjvB/KL196roizHNaru4NhjRafQBhuMezLTBkn1LSJlJ6VJh5fB+5pnCF1oti8U+yHL/mAayXe7E5yJiD76KYyNJYK+NEK6zU/K8bUhyBkyKwIEjBB6x7WnDrcWgEvBrMfHIo8g4v/wRd+okD1rvKCnLhIB7Mj9aJ5GcsBl8sJQ+mk/dmOhfaaw02ZS3XINU26rgLYSFbkpQe5/AYDbyf3ovnQ18S6VZHIO+TC8u9oQaEoz9WiXeBfHZDhlvk2flyE78MXqjs3TC1ffAjxmdqsIii1mpdfczIqfU68IcVSuQmAWv0rWBMShNlXYBFpscyjWfJlUAQ96xY4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB2141.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(396003)(346002)(136003)(366004)(451199015)(966005)(478600001)(122000001)(38100700002)(26005)(38070700005)(83380400001)(71200400001)(15974865002)(9686003)(107886003)(2906002)(15650500001)(66574015)(7696005)(6506007)(8936002)(52536014)(54906003)(186003)(6916009)(316002)(86362001)(66446008)(66946007)(8676002)(4326008)(64756008)(76116006)(5660300002)(41300700001)(33656002)(66556008)(55016003)(66476007)(460985005)(18886075002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?elriLw8piwI8uqN3HEWCYNV9pkXxuv6/2n3c0teD3ArnQ34hP+RsQ2jL7b?=
 =?iso-8859-1?Q?8o9LXS6TX/3MnhbMtdjxGxFXoNMwyf75igofvZfl0QLZ4d7f7ZliN8E0Wm?=
 =?iso-8859-1?Q?T1H7t3q3lqB7gQzTPLco1V9wZYW35qXgIp35QiEMQ2A0Mo+ShPmhlZCbMf?=
 =?iso-8859-1?Q?oqw5s+iHSzCTvPkXRjEM4S//ePIObV0blRFCCHO/XbI5es5DB/vp8GGAr5?=
 =?iso-8859-1?Q?nL6o2zvSDB+w3E33lpdlo2M5oh2bPR8kvw7f+4eGiDVl9cg3NpAHMhyQpc?=
 =?iso-8859-1?Q?jq2UTlABOXNYJLWIskgB/hjrCoZTL5u0vxrbl4BWWUpCH0Rjd/BhjD1Imb?=
 =?iso-8859-1?Q?8hi9xDyRblR+wn078fycsCUiEQykPXI9c7VrG24mKh7N0rG5QuxoKcjMjt?=
 =?iso-8859-1?Q?kdLLpNevhWiFocnbTchh13oRsi/XB5sQ1K635Cqy2w3i0nZbO/HFHuCqTw?=
 =?iso-8859-1?Q?mxcu0mpnSoRhG1f95Ff8/4IFbKPEjZRfENBDZmbVIkPrDwYREBWaNJirPF?=
 =?iso-8859-1?Q?x/VR5g/cs9bCkn5GpwDmJvFZpyZ6i7Ypfmcuv2LMxjIvsmg3s6H7ZWsEC2?=
 =?iso-8859-1?Q?BtZWKDbxoWSJXhjwhBKYkrHldTlyNlEapwAMRr6dmENfADfmlnE0mLOIMO?=
 =?iso-8859-1?Q?FcgT5OWxkpL1e1eBykzMq5rOHBoAW/bFovoEmo5o+6rIizn5VI+2GhUbbm?=
 =?iso-8859-1?Q?djFmfp9H8tTuEJAhoKNo8KwOvdYmAaCpCQZWHNtbqndcfzuMNk+YIOz/Y/?=
 =?iso-8859-1?Q?fCChxBp6PRZJR5fc2skDTlOmnWaS9RxlJCn9Wpcie54fnzmloVnF6ERrsv?=
 =?iso-8859-1?Q?6bPVeO45/La26UiJU7T4HNGtGUjwQ5QSJ60q7DXAseO8ZvPpVVYK/3qqzR?=
 =?iso-8859-1?Q?uFbhxvE04zfK4y8SXyRSMOuQXRaSx8QdWAfDk81/D7xTBHf9fJyfDWegmg?=
 =?iso-8859-1?Q?Cb+4bgULuf4RnNzCYiaUQ19zsOOiQK93rDELpLAGAQvhYrX51oGRFIRz9l?=
 =?iso-8859-1?Q?5kp6PC6sufnQHTBORMrizLosf0tG7faQDVD9t8KxNkB47ZNyXc+ZO09muD?=
 =?iso-8859-1?Q?m4NBbg27YPIU7CXd0pXuBBLZ/RzeEQUSZpFEkpRvNWcissxyuSGj7Ie9/r?=
 =?iso-8859-1?Q?EZ287541aGD2nFnHTXrVIur/dAmrtOMqVt5kndYEO9Jv3TyJGfZXz6orIG?=
 =?iso-8859-1?Q?zvC2xKxDw5aLSY/RylJwirOUL4UobdQSu/OI0YXoQY58gDPp5BR5tnMLGo?=
 =?iso-8859-1?Q?2BBSM7EpLlvjelxXHwsk8nGb7aNSbeTGFmHT5X9KfFWDztEXE+RyysL+p5?=
 =?iso-8859-1?Q?315J6rqCQqpYfpvfJvhq2ZQHo5PfsPLmCZuV88pf4bA/9yP7EQyIBXceOc?=
 =?iso-8859-1?Q?PMrhvy4KkJgCjodCA1OUMkRxtri+En80vhUOa5WtR3wcm2E3eSNjBCMocO?=
 =?iso-8859-1?Q?t86odWABKzpbxBTn7Dw11HSLiX0BULy6Hj9nsWv3qHEcgoh2wIlCV0U2cx?=
 =?iso-8859-1?Q?BLbdb7DpEZb0stTmxyTb7ygNYqAsoiKTVj4NeFP82acRl1672FgJ0hU7CV?=
 =?iso-8859-1?Q?YM2Ho/iIPHGXJO4TMKFfO4fd2nivgB1kZjdRlRmZTtaSooiERvW764uSmn?=
 =?iso-8859-1?Q?1zk/TATP/hl9sU5Bg+uvthUCxBAdkeS9tD?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SJVK9soaZuEE1N0NqTGYGG9K4O0nAIV5SeRT0NNxk/IUL/uOUawhpWakRsVnI73YX5XPMcfX0BOfAg8hThnVlsdO8nGf+BLb9/EPQi/yJa2+E2O5/46k4Mr8p6cVnGV/+3YISjdbkl+Y9v4/burTPGkcjZoa1SY4BTBabIfirLDyyXvmmBkn7hgaqqHxvCPTKONdebWUx4lqmYN7+JaWPMtDo9zgOv8nXrK3Cf+PmN7tRg2bdzRjOGeQyuNwY4fLw9H+mTY2AZ1iJGWgq65y1WyobBtYle9pDLuf0tQ5sMtsTPk/CpFDJDZtTa3y6sl2WaPrRlej7rga9iYVuQkkqAj05W3AQgjq+ds5BgOHJU5k4hnY5XAQglWGOagrbUiofweejv5N/MYFFDdWLg1J/QnNDL7XeCwpuGdV0L0Wj8ttD1R8eH9aSpXqvWXmLY7ijsUEd85dGrxj7GSqR5YD8ReKBsQC54C4lI15cunrfHc7hJFRZRk2ZbcHK9FENe2DTD/My28w+28sJMFtzIeDmRmc/bZaGvcx0qTjdxRPSh/iPvvxFhbgrmMPkcxQ+8wviZD2jCwkgbbkh3DjIXQbPWG8hLIphymX/S/aFcBxcLvbV/81m1qRWnddAdMEE7iJnFEtZq5p89PyetKdYdFbb6tS7VHtIbilbEGQYHPF8f5bNZ6G6bqN962ITRmjevUDd8/4mYgY48w1zMPliuzhmFZYhKpLqMT9fjhOL7m+7T0eYbjF+rI3ndFOz2oV2WiUFD2touF1NBOAK/Z0zKMgdg==
X-OriginatorOrg: samsongroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB2141.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 453e95c5-f3fd-47c9-55a0-08dace1a019c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 12:47:11.7372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 690ef218-bdbc-459f-ba65-a6938b9e1c86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v46ML+pcBKzambYgbJhVOF71/mwusAk5ZuHyAAKMWe5hp5L0M4E6s/DFmS/f7fYjC5YDOrq6kZ+6FPdw4FY0b99Cf3jdBYv5fY5jg/bhIOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB3052
X-SM-outgoing: yes
X-SM-smarthost: [samsongroup.relay.tmes.trendmicro.eu]
X-TM-AS-ERS: 20.79.236.226-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.0.1006-27282.007
X-TMASE-Result: 10--6.405400-4.000000
X-TMASE-MatchedRID: wnI36zKx6wzkIEkKgFB9SKPSFj9Wm4u+F430d3dMHkb+Aw16GgqpO8Ey
        t0nnqvegQxTNQIR96f7KlhZQkEujyVK4l8RZlJB8h5kaQXRvR9dMkOX0UoduuVQuGn5b9r2ZhjI
        SH0pZGrqP9u+1+GFcS+TUxHMV1RPc8HeApND/2sRqD/+OJa6Hg6T3I7Lb+ZViEd+K6O5Nt52bOm
        I3fovFh6Po4a2rEvc1iBv1PBSeDPkNGNADqePp0xHJWwDGGGOsqGNyQsVpi8yGfBP9CUd4GTAbT
        +LEH2uzhI7uvji8niukh51KSUs/hUyczASEQ0I0ngIgpj8eDcCLbopAC1KZxt/C2riNn8beKrau
        Xd3MZDWFoTFugdlTgJeE97+82U4Rtk/3MX/CtPU6mU7dVftJsXdGSBVcpNPf
X-TMASE-XGENCLOUD: 938ea91d-5965-4a12-8c59-b70d1eb2edb2-0-0-200-0
X-TM-Deliver-Signature: 1E784E5D23C788CA1FCE27903B23C544
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=samsongroup.com;
        s=TM-DKIM-202204121487; t=1669294034;
        bh=2nu1+H59OOtZV0jf8EhuK8S+PTL24iLY7MA4WyjiE/Y=; l=2302;
        h=From:To:Date;
        b=ccv+wAI8XhNcXoRT5T7bqyTR7Qju09vGx35+9rpe18KBHxWCMX73RNMQnFZ10L2Kd
         71OfvdEIhgGEk3gWtvN7h/Ho1CdKVkvMLQ5QuKbi/Cxsb1wGUpAwlwdUYFsS+tUZDC
         5hulcGiffT2abiEuD78BGxD7wdRkjxbRQvBZwFMeHMSucAoD5pvnHHcEGw/QUHcf+9
         YFnkftABZMbalErW6e1nibyvoHSxmTI+gYSZbdlXODd3Ca4fC+tkQLFbOakP/wiJjG
         FLCHMNWBxIo0r6ROeJ5ef2DB7AtvuPZXhEjEM3USog053aGZEej0m5xfxVW7ivnHKc
         +rEPtYFhVmt4Q==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Sir or Madam,=20


Bug Description
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

when doing a git pull on a repository with submodules, the --verbose option=
 causes an error message like:=20
usage: git submodule [--quiet] [--cached]
   or: git submodule [--quiet] add [-b <branch>] [-f|--force] [--name <name=
>] [--reference <repository>] [--] <repository> [<path>]
... and so on.
Exit code is 1

This happens, when recursing the submodules. Either add to .gitconfig:
[submodule]
	recurse =3D true
or use --recurse-submodules for the git pull command.

Version 2.37.3-64-bit is OK.
Version 2.38.1-64-bit is shows the error.
Reproducible on Windows and Linux


How to Reproduce
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
# steps to reproduce:=20
# run the following commands in a debian:sid container,=20
# e.g. "docker container run -it debian:sid".

# Any other environment with git 2.38.1 should be fine, too.=20
# Git for windows 2.38.1 also shows the same behaviour.

# install git 2.38.1 (at the time of writing) and clone a public repo with =
submodules
$ apt update && apt install git
$ git clone --recurse-submodules https://gitlab.com/tortoisegit/tortoisegit=
.git
$ cd tortoisegit

# this one succeeds
$ git pull --recurse-submodules

# this one fails after fetching the submodules, showing=20
# the "git submodule" help text as if we had made a "git submodule"=20
# call with insufficient/wrong arguments.
$ git pull --recurse-submodules --verbose


Workaround
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1) Do not use --verbose when pulling a repository with submodules.
   Unfortunately this workaround does not apply to our workflow,=20
   since we happily use TortoiseGit as our graphical Git client on windows.=
=20
   TortoiseGit automatically uses the option -v (--verbose).
   $ git.exe pull --progress -v --no-rebase "origin"
2) Use Version 2.37.3-64-bit.=20


Questions
=3D=3D=3D=3D=3D=3D=3D=3D=3D
Any questions regarding this bug description? Happy to help.


Kind regards, Mike.

--

Mike Fink
Softwareentwickler
E44

SAMSON=A0AKTIENGESELLSCHAFT
Weism=FCllerstra=DFe=A03 =B7 60314=A0Frankfurt=A0am Main

Telefon: +49 69 4009-1682
E-Mail: Mike.Fink@samsongroup.com =B7 Internet:=A0www.samsongroup.com


