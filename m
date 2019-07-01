Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FD4E1F461
	for <e@80x24.org>; Mon,  1 Jul 2019 21:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfGAVE2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 17:04:28 -0400
Received: from mail-eopbgr650093.outbound.protection.outlook.com ([40.107.65.93]:10400
        "EHLO NAM06-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726509AbfGAVE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 17:04:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYFtNHJuM3A7g5SlHNCGHuRNoKBsJxOx1gwc803IWGBq+hWVMb8hYjcxw17SM0IqdjsxCKk1pJQhKiIi/ZlEMymqHGrNmRPpMn29bJ2hmbGgOzVLA5wekw0MliTguqLFjT9fnPZS1lAR75zx0Q0/boekIa/iWPcCojlfJkxufLz07zhD4wEhxnmPTCzNL47eCfVljm0rGU+1too198UKMnojRkJkiBHSn2LV6vXclI9PJqkbiTpsDKCZjvKmCpr+/o5tPpScla+1zo4/yXSPFy5DhFZal3t3NBlmTfshbl8K1+ESNu6VXMk/lkq8784wAscgjrbU+DQmWfXpXc1t8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/D1rAAUea4oaT6GcbVzHpJLWdnC2OQwOsca2KH4g2+o=;
 b=huk4XuxK8nFp3jwkcA3LJ5JiJdEF/DsbRRwx+191v2Y+U18RZckzuALc6TiYGQXPSTMZOqYUk8D8TlmStPYkAy7xmIr1UDMADTC2vZxwILGxN3UfrCcAVXC14PF4Vcx8H0CrVxBfKTLPGrg0ZXxgdccszR2GrH5VultTJ/CzYTFG87Mc/YpME2iJ79jBCaa88/AYCOTSfU2VKeIitECfoHx+hDp493yfYt67OZOuBpeLHd+3MrSHHE8V2XrmgAptZMp8hJOHMK9LYwOigRSQIDHrgGdzNbZe6in/VLmmGSQ2Zo8uLe6cXzBoR/hPUhKn7H3nt7mHVj0F8eLqrDGyDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microsoft.com;dmarc=pass action=none
 header.from=microsoft.com;dkim=pass header.d=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/D1rAAUea4oaT6GcbVzHpJLWdnC2OQwOsca2KH4g2+o=;
 b=G8A4tqxUr7n5PriD4wLWZk7Tn5WRonkNf5atjwdbnAhpQo6+nov3qbg17bh503ep8cxPpIkMy8PBqsbKLRUJqjG1euOLZ1CoRHjAVAcdhkjqfGZR9Txw8ksluMLFUQ1Rvz4kJD8aEMGjVFRtN0LMPFFyJTv/at435rZWiP7/Hh0=
Received: from DM5PR00MB0408.namprd00.prod.outlook.com (52.132.129.32) by
 DM5PR00MB0342.namprd00.prod.outlook.com (52.132.128.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2083.0; Mon, 1 Jul 2019 21:04:23 +0000
Received: from DM5PR00MB0408.namprd00.prod.outlook.com
 ([fe80::9923:ae05:ac1a:e3e0]) by DM5PR00MB0408.namprd00.prod.outlook.com
 ([fe80::9923:ae05:ac1a:e3e0%5]) with mapi id 15.20.2080.000; Mon, 1 Jul 2019
 21:04:23 +0000
From:   Eric Kulcyk <Eric.kulcyk@microsoft.com>
To:     =?iso-8859-1?Q?Eckhard_Maa=DF?= <eckhard.s.maass@googlemail.com>,
        Bryan Turner <bturner@atlassian.com>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Tracking parent branches in Git
Thread-Topic: Tracking parent branches in Git
Thread-Index: AQHVMD3i8/gIlx7oOE2G2ApKMwWLhKa2J7lzgAADpACAAA6JgIAAATQKgAAESgE=
Date:   Mon, 1 Jul 2019 21:04:23 +0000
Message-ID: <DM5PR00MB04088CD7E4C7E2B4BC1E7140F1F90@DM5PR00MB0408.namprd00.prod.outlook.com>
References: <DM5PR00MB040845755401A07E5C90251CF1F90@DM5PR00MB0408.namprd00.prod.outlook.com>
 <xmqqpnmt5z19.fsf@gitster-ct.c.googlers.com>
 <CAGyf7-EBs_cRB5R7RyQhX0ZDNqLZWVJEYEtqkGRGJykRqKKTvA@mail.gmail.com>,<20190701204017.GA7537@esm>,<DM5PR00MB040870EB598E4E7B0CC1765DF1F90@DM5PR00MB0408.namprd00.prod.outlook.com>
In-Reply-To: <DM5PR00MB040870EB598E4E7B0CC1765DF1F90@DM5PR00MB0408.namprd00.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-07-01T21:04:22.790Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Eric.kulcyk@microsoft.com; 
x-originating-ip: [2001:4898:80e8:b:e561:6c02:9616:a3c8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7bc433c-712d-4033-849e-08d6fe67b17c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR00MB0342;
x-ms-traffictypediagnostic: DM5PR00MB0342:
x-ms-exchange-purlcount: 2
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR00MB03427B861A1E0A75C27DE447F1F90@DM5PR00MB0342.namprd00.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(51914003)(199004)(189003)(43544003)(52536014)(6436002)(5660300002)(68736007)(14454004)(186003)(10290500003)(966005)(14444005)(66446008)(4326008)(229853002)(25786009)(478600001)(2940100002)(76176011)(316002)(110136005)(54906003)(22452003)(7696005)(99286004)(71190400001)(71200400001)(53546011)(7736002)(446003)(486006)(11346002)(2906002)(8936002)(81166006)(81156014)(8676002)(6116002)(74316002)(305945005)(10090500001)(66556008)(64756008)(73956011)(33656002)(66476007)(76116006)(66946007)(55016002)(6306002)(256004)(72206003)(6506007)(9686003)(102836004)(476003)(8990500004)(53936002)(6246003)(86362001)(46003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR00MB0342;H:DM5PR00MB0408.namprd00.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fxxI10GPT5j9BVbyoVwwzAvofsWsCDC1wL84HPHmuWbMNIsCXTK/0HdCJ7/LFtMBvh6BQpHgA2r4bnSDmtWZjCrZdWOnFdiWOO2lcGSSPBN7hjj9npQ/WdBG+g11opZSBpOex8owVDOyz0nkWAMycsaJBf1VyeXKqF6IZuQgBJF4XthJiD6kX6fsdFW/o1DXh71OiGjX2Xzb553fTYmD2jJd1cIDSZ0T5vmkxx1yQfq/08UWodSAaAf8VR2wZOcDwbJ+G4idQD/08Wnx4a6NikWc6kePnhIED91f/rmpfCAx1wCIPb2yEjkZB4kKwFa9QtUW0oJ1YX0Uhb5Agi04grZ7gptf+U4CEtJhG6y+PUbkL17WtaCfgAX0FlV7Ko/CtxEl36JU5hwet8Tm2zOr20C362idb5PX6JRoNIMXugo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7bc433c-712d-4033-849e-08d6fe67b17c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 21:04:23.1458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: erickul@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR00MB0342
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=0A=
> > You can right now give meta data of your choice with --push-option to=
=0A=
> > the push command. The Gerrit system makes use of that already. However,=
=0A=
> > this would not be intrinsic to Git, but the serve needs to react on=0A=
> > those options. And it should be in good company with suitable client=0A=
> > tools.=0A=
=0A=
> @Eckhard, is that documented somewhere?  I don't see it on =0A=
> https://git-scm.com/docs/git-push/1.6.4.1=0A=
=0A=
Interestingly a Google search for git --push-option turns up old documentat=
ion first,=0A=
I found the newer docs.  Don't you still need a way to store this data loca=
lly?=0A=
For instance, a wrapper around git checkout could record the branch.=0A=
However, you would be unable to use vanilla git check out if you want to do=
 rely upon the data.=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
From: Eric Kulcyk=0A=
=0A=
Sent: Monday, July 1, 2019 1:58 PM=0A=
=0A=
To: Eckhard Maa=DF; Bryan Turner=0A=
=0A=
Cc: gitster@pobox.com; git@vger.kernel.org=0A=
=0A=
Subject: Re: Tracking parent branches in Git=0A=
=0A=
=A0=0A=
=0A=
=0A=
> > [Overly long lines are not appreciated around here.]=0A=
=0A=
=0A=
=0A=
Thanks for the feedback, is there an email client or tool=0A=
=0A=
that can format the lines correctly?=0A=
=0A=
> >=0A=
=0A=
> > > We would like to track parent branches so that creating pull=0A=
=0A=
> > > requests can automatically determine the correct branch to merge=0A=
=0A=
> > > against.=A0 I understand that this would require tracking more=0A=
=0A=
> > > information than is currently available right now in git.=A0 Also, it=
=0A=
=0A=
> > > seems that if some cases, it is not possible to determine a parent=0A=
=0A=
> > > branch, in which case it would just be empty/null.=0A=
=0A=
> >=0A=
=0A=
> > Do you mean by "parent branch" what people usually call "upstream=0A=
=0A=
> > branch" (i.e. when that branch on the other side gains more commits=0A=
=0A=
> > independent from what you have been working on, then you would want to=
=0A=
=0A=
> > rebase your work on top of the updated state of that branch on the=0A=
=0A=
> > other side) around here?=0A=
=0A=
>=0A=
=0A=
> I suspect the question is in regards to "What branch did I create my loca=
l branch from?", especially given the pull request reference.=0A=
=0A=
=0A=
=0A=
Yes, this is what I meant.=0A=
=0A=
>=0A=
=0A=
> In other words, when I locally do:=0A=
=0A=
> git checkout --no-track -b bturner-some-bugfix origin/release/5.16=0A=
=0A=
>=0A=
=0A=
> release/5.16 is the "parent branch" of my bugfix branch and, when I push =
my branch and try to open a pull request, release/5.16 is a _likely_ target=
 for where I'd want to merge it. There may be a remote in the name, a la "o=
rigin" in my example, or it might=0A=
 be created on top of some other local branch. It's a common feature reques=
t for Bitbucket Server[1], for example, to automatically select the "right"=
=0A=
=0A=
> target branch for a new pull request based on the ancestry of the branch =
in question--except branches have no ancestry. (This sort of metadata could=
 potentially offer some benefits for building commit graphs (referring to U=
I treatments for visualizing the=0A=
 DAG, rather than Git's "commit-graph" functionality), depending on how it =
was implemented, since it would make branch points more stable.)=0A=
=0A=
>=0A=
=0A=
> > Since branches are ephemeral names and have no intrinsic metadata of=0A=
=0A=
> > their own (unlike, say, annotated tags or commits), I suspect=0A=
=0A=
> > implementing something like this may be more complicated than it might=
=0A=
=0A=
> > initially appear, especially if said metadata needs to be communicated=
=0A=
=0A=
> > to remote repositories (which implies it might require changes to the=
=0A=
=0A=
> > wire protocol as well).=0A=
=0A=
>=0A=
=0A=
> You can right now give meta data of your choice with --push-option to=0A=
=0A=
> the push command. The Gerrit system makes use of that already. However,=
=0A=
=0A=
> this would not be intrinsic to Git, but the serve needs to react on=0A=
=0A=
> those options. And it should be in good company with suitable client=0A=
=0A=
> tools.=0A=
=0A=
=0A=
=0A=
@Eckhard, is that documented somewhere?=A0 I don't see it on=0A=
=0A=
https://git-scm.com/docs/git-push/1.6.4.1=0A=
=0A=
=0A=
=0A=
>=0A=
=0A=
> Take care,=0A=
=0A=
> Eckhard=0A=
=0A=
>=0A=
=0A=
> Best regards,=0A=
=0A=
> Bryan Turner=0A=
=0A=
>=0A=
=0A=
> [1] =0A=
https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fjira.at=
lassian.com%2Fbrowse%2FBSERV-7116&amp;data=3D02%7C01%7CEric.kulcyk%40micros=
oft.com%7Ca780a740f5894ba5ce6508d6fe607317%7C72f988bf86f141af91ab2d7cd011db=
47%7C1%7C0%7C636976088301830933&amp;sdata=3D1KrFM%2BLcKoa3FCc1F86jIVZBrIUGi=
%2B6ad7CuA8ekAUY%3D&amp;reserved=3D0=0A=
=0A=
>=0A=
=0A=
> >=0A=
=0A=
> > Perhaps "git help glossary", look=0A=
=0A=
> > for "upstream branch" and start from there?=A0 The entry mentions the=
=0A=
=0A=
> > configuration variables used to keep track of that information, which=
=0A=
=0A=
> > are described in "git help config", I think.=0A=
=0A=
> >=0A=
=0A=
> > > If I made a change to track the parent branch for each branch, would=
=0A=
=0A=
> > > this feature be accepted/welcomed as part of git, even if it off by=
=0A=
=0A=
> > > default?=0A=
=0A=
> >=0A=
=0A=
> > Regardless of what is being proposed, this is often not a very useful=
=0A=
=0A=
> > question.=A0 Something worth doing for yourself is worth doing whether=
=0A=
=0A=
> > others also find it useful ;-)=A0 And others usually do not have enough=
=0A=
=0A=
> > information to judge if such a change is welcome until seeing it in a=
=0A=
=0A=
> > bit more concrete form.=0A=
=0A=
=0A=
=0A=
I wanted to get a some thoughts before I worked out the details.=0A=
=0A=
The feature is of little use if no one is using the version of git with it=
=0A=
=0A=
since most everyone uses standard distros of git.=0A=
=0A=
>=0A=
=0A=
> Was there not, at some point in recent history (2019), a discussion about=
 storing extra arbitrary data associated with a branch or other objects? My=
 thought for satisfying what Eric was originally proposing is to store the =
root commit associated with the=0A=
 original branch HEAD when checkout -b/branch was done to create the branch=
. Presumably another datum could store the branch that the branch HEAD was =
on, but that may not be unique - which is a root part of the problem with t=
his request, although it might be=0A=
 something that the user could select/specify - not sure how - at branch cr=
eation.=0A=
=0A=
>=0A=
=0A=
> But aside from that both of the above are transient relative to the new b=
ranch and by the time you wanted to create a Pull Request, the information =
you originally wanted could irrelevant - at least to git. If I was the prod=
uct manager on this, I would suggest=0A=
 going to GitLab, GitHub, or BitBucket and asking for some augmented capabi=
lity of branch creation, that stores the data for future Pull Request manag=
ement - instead of doing this in core git because of the transient nature o=
f the relationship between a branch=0A=
 and a commit.=0A=
=0A=
=0A=
=0A=
Multiple branches can have the same commit, but only one branch can=0A=
=0A=
be checked out at once, right?=A0 Then the parent branch would be the=0A=
=0A=
branch you were on when you ran checkout -b.=A0 That branch might change=0A=
=0A=
and no longer be of use, but it seems like in practice that is not the case=
.=0A=
=0A=
New features are usually created off of a local branch and then PR'd=0A=
=0A=
back to the upstream version of that branch.=0A=
=0A=
=0A=
=0A=
Thanks!=0A=
=0A=
Eric=0A=
=0A=
=0A=
=0A=
________________________________________=0A=
=0A=
From: Eckhard Maa=DF <eckhard.s.maass@googlemail.com>=0A=
=0A=
Sent: Monday, July 1, 2019 1:40 PM=0A=
=0A=
To: Bryan Turner=0A=
=0A=
Cc: gitster@pobox.com; Eric Kulcyk; git@vger.kernel.org=0A=
=0A=
Subject: Re: Tracking parent branches in Git=0A=
=0A=
=0A=
=0A=
On Mon, Jul 01, 2019 at 12:48:16PM -0700, Bryan Turner wrote:=0A=
=0A=
> Since branches are ephemeral names and have no intrinsic metadata of=0A=
=0A=
> their own (unlike, say, annotated tags or commits), I suspect=0A=
=0A=
> implementing something like this may be more complicated than it might=0A=
=0A=
> initially appear, especially if said metadata needs to be communicated=0A=
=0A=
> to remote repositories (which implies it might require changes to the=0A=
=0A=
> wire protocol as well).=0A=
=0A=
=0A=
=0A=
You can right now give meta data of your choice with --push-option to=0A=
=0A=
the push command. The Gerrit system makes use of that already. However,=0A=
=0A=
this would not be intrinsic to Git, but the serve needs to react on=0A=
=0A=
those options. And it should be in good company with suitable client=0A=
=0A=
tools.=0A=
=0A=
=0A=
=0A=
Take care,=0A=
=0A=
Eckhard=0A=
=0A=
