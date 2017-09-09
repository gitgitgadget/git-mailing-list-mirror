Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E466E1FAD6
	for <e@80x24.org>; Sat,  9 Sep 2017 04:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751279AbdIIEyf (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Sep 2017 00:54:35 -0400
Received: from mail-bn3nam01on0133.outbound.protection.outlook.com ([104.47.33.133]:3578
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751154AbdIIEye (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Sep 2017 00:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=z2ohDqp8RZzu1WO8u8d+ydq9K8mFUZRgwrveQkV1YuM=;
 b=dkStAAyne1XP+2tu9aVYn+b2c1hadKNVsJ1U3e9IJsGb6ovDu0rws3ewfHZ6vKCH2ptYdLPn+cLesJB+5rhZv9WmpwdjfibI3dRCGpZ0Ldj2sepcNpgxaOfgITjxu5G2oAZeADjqpPaXUeB4hWQT5pNURFpapT1ELBWsvAkh7QQ=
Received: from SN1PR21MB0014.namprd21.prod.outlook.com (10.161.254.12) by
 SN1PR21MB0064.namprd21.prod.outlook.com (10.161.254.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.56.7; Sat, 9 Sep 2017 04:54:31 +0000
Received: from SN1PR21MB0014.namprd21.prod.outlook.com ([10.161.254.12]) by
 SN1PR21MB0014.namprd21.prod.outlook.com ([10.161.254.12]) with mapi id
 15.20.0056.003; Sat, 9 Sep 2017 04:54:31 +0000
From:   Kevin Willford <kewillf@microsoft.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "pclouds@gmail.com" <pclouds@gmail.com>
Subject: RE: [PATCH 1/1] reset: fix reset when using the sparse-checkout
 feature.
Thread-Topic: [PATCH 1/1] reset: fix reset when using the sparse-checkout
 feature.
Thread-Index: AQHTKMyCASx4J5FrG0SFSfVy0yz4a6KrWy30gAAJb7CAAH5jR4AAB2mQ
Date:   Sat, 9 Sep 2017 04:54:31 +0000
Message-ID: <SN1PR21MB00140C84DC02F3491F4E8469B76A0@SN1PR21MB0014.namprd21.prod.outlook.com>
References: <20170908180050.25188-1-kewillf@microsoft.com>
        <20170908180050.25188-2-kewillf@microsoft.com>
        <xmqqvaktxawk.fsf@gitster.mtv.corp.google.com>
        <SN1PR21MB0014638E5D9CBFD0D9D85F10B7950@SN1PR21MB0014.namprd21.prod.outlook.com>
 <xmqqr2vgy2yt.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqr2vgy2yt.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Ref=https://api.informationprotection.azure.com/api/72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=kewillf@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2017-09-08T22:54:29.6770192-06:00;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [174.126.250.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR21MB0064;6:wYjeG9jb8cvdAAEUatdMgTh3M/zp9csMmTgkoi9C4TnY+TqoD4wnL8S2jnH8rkrdl1Ex/0U/W+V+obpWoNVqVXjt4bUzCmZltS+Cf7igdVM+H9xYiJ/v8q6PekXdRwOzyZQ9kD2uqwcWbS1KJfF1o2qA271kw7MlMsgKIeIbhmgR9ZZglAm0zxsv63kCdWs/4VTU79incxYZiPd1sNyolDmD6+y+UV3Rid3yQhR04EUm2trSxp12CsV1CnOiDdvPJ10aYU/7862Jd8Sja6g0D4E2A3sr6mv/PYZ8Xa8eh3FhccoYi5KiFkjPGkQUp2zQAY5vovhNY3ZUIwYM93kv7Q==;5:RPr1pddY/7btfBJJi5uyzRrc3kUbJHW3MfKBciWThcdza+MqDxApcZaC0NUjIwWwdtzI0aHXKgwAlaEmfFnm3jemb+7pH52ElJWdT65Rwb0OiYTUPM9IR8tGaiRA0FArC30g6Iu8e8YQGuXDmDiu4Q==;24:oWn8oLrogS5wR8gi0ko6BBagsvUdrkSwyS/oQpZu4ALGSG4IUea0soVXwv+iFLDvT7Js3syep1tD9Vd32fvE/p8C65aQGUrSM+VUYhycsy4=;7:WFTNKsgKNYFF7hQLb9UfvHXyDYAQtMnXZ/+wTZcclRzbRmm0uIPrq/Zd1JKQd1xUsN5E2qzPefZIHnpvgzU5bWuI5W2wtpmffvd1ca9uG9221D8VtQvBxLHEgvOYh+bGxTOFxNzgFiWptIU9p2hK1hAEkz6QAl8D36GN7qbjuQJr+WgicQjBjMJUx44MHamQqBCxIy72Qk8Et2N/lqnN1zLTo/MNABfcRFHm6lIFqK0=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 5f7afa1c-6cc0-4297-35a2-08d4f73edbe5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(48565401081)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:SN1PR21MB0064;
x-ms-traffictypediagnostic: SN1PR21MB0064:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kewillf@microsoft.com; 
x-exchange-antispam-report-test: UriScan:(20558992708506)(89211679590171)(100324003535756);
x-microsoft-antispam-prvs: <SN1PR21MB00644D1838F269B4C9AA0639B76A0@SN1PR21MB0064.namprd21.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(100000703101)(100105400095)(6055026)(61426038)(61427038)(6041248)(20161123560025)(20161123564025)(20161123558100)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN1PR21MB0064;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN1PR21MB0064;
x-forefront-prvs: 0425A67DEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(6009001)(39860400002)(47760400005)(377454003)(199003)(189002)(51444003)(2906002)(4326008)(22452003)(39060400002)(2900100001)(66066001)(74316002)(97736004)(8936002)(33656002)(25786009)(3660700001)(7736002)(68736007)(93886005)(86362001)(3280700002)(305945005)(6246003)(106356001)(105586002)(110136004)(102836003)(6916009)(2950100002)(6116002)(3846002)(7696004)(101416001)(5660300001)(99286003)(10090500001)(55016002)(86612001)(189998001)(8990500004)(8656003)(9686003)(53936002)(54906002)(10290500003)(229853002)(8676002)(14454004)(81166006)(478600001)(6506006)(81156014)(6436002)(77096006)(76176999)(50986999)(54356999)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR21MB0064;H:SN1PR21MB0014.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2017 04:54:31.3784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR21MB0064
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Friday, September 8, 2017 9:18 PM
>=20
> Kevin Willford <kewillf@microsoft.com> writes:
>=20
> > 1. reset mixed when there were files that were added
> >
> > In this case the index will no longer have the entry at all because
> > the reset is making the index look like before the file was added
> > which didn't have it. When not using the sparse-checkout this is fine
> > because the file is in the working directory and the reset didn't touch
> > it.  But using the sparse-checkout on that file and if the file was not
> > in the working directory, the index gets reset and the entry for that
> > file is gone and if we don't put the index version of the file before t=
he
> > reset into the working directory, then we have lost the content for
> > that file
>=20
> I do not quite understand this argument.  If you do
>=20
> 	edit $path
> 	git add $path
> 	rm $path
> 	git reset
>=20
> for a $path that is not involved in the sparse thing, the version
> that was previously indexed will be lost, but that is fine---the
> user said that version is expendable by saying "reset".
>=20
> How would that be different when the $path were not to be
> materialized in the working tree due to sparseness?  Where did that
> "blob" object in the index immediately before you called "reset"
> came from, and why do you say that the user does *not* consider that
> one expendable, unlike the case for non-sparse path example above?
>=20

I guess that I should have said files that were newly added, meaning they
are new files that were created and added in the previous commit.
=20
I think that the difference is that the user explicitly removed the file. W=
hen
using sparse it is git that is causing the removal of the file.  For exampl=
e
if I have /file in my spare-checkout file so that I am only working on the =
one
file.  The previous commit had new file2 added and I run a git reset HEAD~1=
.
I as the user do not expect that file2 just disappear, but yet that is what
happens.  So from you example above if I do.

	create $path
	git add $path
	git commit
	git checkout // where $path is not in the sparse-checkout
	git reset HEAD~1

$path will be gone yet I the user did not remove it.  I guess you could
argue that the user did when they specified their sparse-checkout and
ran checkout but I wouldn't know what would go missing unless I ran
a diff before the reset to see.  There could have been X number of
files created and added in the previous commit(s) and status after the
reset would not report them and they are gone.  So I could clone,
setup sparse-checkout, checkout, reset HEAD~X and possibly lose
data I didn't expect to.

In the modified case where the previous commits have modifications
to files outside the sparse-checkout at least the status after the reset re=
ports
the file as deleted so the user sees that something has happened to it.

I suppose the entry could stay in the index with the skip-worktree bit
on and not removed like it is now so that a git reset will only apply
to the entries in the sparse-checkout?  That seems like it would be
changing the meaning of reset.

> I suspect that a similar reasoning would apply to your 2., but I
> didn't think it through.
>=20
> The possible misconception, which I perceive in both of these, is
> that you are somehow disagreeing with this basic assumption: by
> saying "git reset [<tree-ish>]", the user is telling us that the
> version in the index, even if that is different from HEAD,
> <tree-ish>, or the file in the working tree, is *unwanted* and be
> replaced with the one in HEAD (or <tree-ish> when given).  Touching
> the working tree files upon "git reset" is the last thing the user
> expects to happen.
>=20

I agree with this when you are not dealing with a sparse-checkout.
When using a sparse-checkout I expect git not to touch things
outside of what I have specified in my sparse-checkout file.  If it
does, it should let me know or put my working directory in a
state that is expected.  Especially when it is changing the
skip-worktree bits causing files outside the sparse-checkout to be
reported incorrectly by status.

=20

