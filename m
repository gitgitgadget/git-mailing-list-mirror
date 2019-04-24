Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E6231F453
	for <e@80x24.org>; Wed, 24 Apr 2019 07:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbfDXHyP convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 24 Apr 2019 03:54:15 -0400
Received: from smtppost.atos.net ([193.56.114.165]:17265 "EHLO
        smtppost.atos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbfDXHyO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 03:54:14 -0400
Received: from mail3-ext.my-it-solutions.net (mail3-ext.my-it-solutions.net) by smarthost2.atos.net with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
         id 0b90_15e2_1030e28f_3e36_40e6_acbe_c67360cc5604;
        Wed, 24 Apr 2019 09:54:04 +0200
Received: from mail1-int.my-it-solutions.net ([10.92.32.11])
        by mail3-ext.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id x3O7s41h025163
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Apr 2019 09:54:04 +0200
Received: from DEERLM99ETVMSX.ww931.my-it-solutions.net ([10.86.142.97])
        by mail1-int.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id x3O7s3fx002243
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Apr 2019 09:54:03 +0200
Received: from DEFTHW99ETRMSX.ww931.my-it-solutions.net (10.86.142.99) by
 DEERLM99ETVMSX.ww931.my-it-solutions.net (10.86.142.97) with Microsoft SMTP
 Server (TLS) id 14.3.439.0; Wed, 24 Apr 2019 09:54:03 +0200
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (10.86.142.137)
 by hybridsmtp.it-solutions.atos.net (10.86.142.99) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Wed, 24 Apr 2019 09:54:03 +0200
Received: from AM6PR02MB4950.eurprd02.prod.outlook.com (20.177.199.143) by
 AM6PR02MB5366.eurprd02.prod.outlook.com (20.178.91.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Wed, 24 Apr 2019 07:54:01 +0000
Received: from AM6PR02MB4950.eurprd02.prod.outlook.com
 ([fe80::147e:c96e:accd:c32b]) by AM6PR02MB4950.eurprd02.prod.outlook.com
 ([fe80::147e:c96e:accd:c32b%6]) with mapi id 15.20.1835.010; Wed, 24 Apr 2019
 07:54:01 +0000
From:   "CHIGOT, CLEMENT" <clement.chigot@atos.net>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] git-compat-util: work around for access(X_OK) under root
Thread-Topic: [PATCH] git-compat-util: work around for access(X_OK) under root
Thread-Index: AQHU+a/BrB7ZLE29Jku4TzdCEFH6dKZJjFlqgAAO6KmAAOBg7YAAb3s7
Date:   Wed, 24 Apr 2019 07:54:01 +0000
Message-ID: <AM6PR02MB49502D1CDC7853F95B357ECBEA3C0@AM6PR02MB4950.eurprd02.prod.outlook.com>
References: <AM6PR02MB4950BB0152893633FF95DC99EA230@AM6PR02MB4950.eurprd02.prod.outlook.com>
        <xmqq4l6p57x6.fsf@gitster-ct.c.googlers.com>
        <AM6PR02MB495010DED643EC262D116DD0EA230@AM6PR02MB4950.eurprd02.prod.outlook.com>,<xmqqwojk449b.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqwojk449b.fsf@gitster-ct.c.googlers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=clement.chigot@atos.net; 
x-originating-ip: [193.56.241.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0b4bac3-7e81-4173-8e3a-08d6c88a041a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:AM6PR02MB5366;
x-ms-traffictypediagnostic: AM6PR02MB5366:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <AM6PR02MB536673294FC70A57C6C62CDAEA3C0@AM6PR02MB5366.eurprd02.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39860400002)(376002)(366004)(136003)(396003)(346002)(189003)(199004)(86362001)(71190400001)(93886005)(76176011)(81166006)(102836004)(6506007)(2906002)(256004)(186003)(71200400001)(316002)(52536014)(8936002)(26005)(8676002)(66556008)(5660300002)(76116006)(486006)(99286004)(81156014)(446003)(11346002)(7696005)(64756008)(66446008)(476003)(66946007)(73956011)(66476007)(14444005)(6116002)(478600001)(45080400002)(229853002)(6916009)(7736002)(966005)(74316002)(14454004)(33656002)(3846002)(55016002)(305945005)(6306002)(53346004)(9686003)(4326008)(53936002)(68736007)(6246003)(66066001)(25786009)(6436002)(97736004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR02MB5366;H:AM6PR02MB4950.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: atos.net does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jXjlhVy/pyhKi+oreXAET4GDRp1ErTWry/yzCZ2i3c01y6V753eo5kfqCKFPy6Mefzq3OR/kPYEU+1NM3RphEGTUYB29RoTUSLA4hoT4rCUQiKUcnYQZCnrJOPzvO2ZaZu8tG1ge7BdH6+S7BhvGEGu2wsU8XJ3k2C+Kr7lPPw0qbOJZve4HeZ8qKMHWR4jOuZqbUH8agaQgJ+krXzi+FdfIVcEv2gkZ/T+niNLuKoZb48stDZ2kzqDflB5/w5mj/DAwdWxg6GBtsMKtVgWmlsJmeg5Y0yDsjHWIpONiwaPUDFqUwBU2ObhhutNIGSQwfLGmwulExD4fR79pbf6efYnoUmrpR2TGfWujFZUQMNmzhixhal5Z14bYqEClnWZr2MTDOpnsC2z2H9LdBqGkrlxr7kpmj5s2jYsI41Plw3w=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b4bac3-7e81-4173-8e3a-08d6c88a041a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 07:54:01.7693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB5366
X-OriginatorOrg: atos.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <jch2355@gmail.com> on behalf of Junio C Hamano <gitster@pobox.com>
> "CHIGOT, CLEMENT" <clement.chigot@atos.net> writes:
> > From: Junio C Hamano <jch2355@gmail.com> on behalf of Junio C Hamano <gitster@pobox.com>
> >> > On some OSes like AIX, access with X_OK is always true if launched under
> >> > root.
> >>
> >> That may be the case, but you'd need to describe why it is a problem
> >> here, before talking about the need for a "work around".
> >>
> >> For example, if a directory on $PATH has a file called git-frotz
> >> that has no executable bit, perhaps "git frotz" would execute that
> >> file but only when you are running it as the root user, but not as
> >> any other user.
> >> ...
> >
> > This patch is needed in order to have hooks working on AIX. When run as root,
> > access on hooks will return true even if a hook can't be executed.
> 
> Ah, OK, so the issue is not that AIX allows the root to execute even
> files that have no executable bit, but X_OK check on it returns
> useless answer when we want to know if an attempted execution of the
> file by the user would succeed.
> 
> That was exactly the kind of information expected in your log
> message to explain why this change is a good thing to have.

Ok I'll add something clearer. 

> 
> >> Does the true UID matter for the purpose of permission/privilege
> >> checking?  Why do we have to check anything other than the effective
> >> UID?
> >>
> >
> > Actually, I don't know. Bash is doing it but I think EUID is enough.
> 
> I wasn't questioning if it is "enough".  If the root user "su"es to
> a normal user, does the issue that exec(path) and access(path, X_OK)
> are incoherent still happen?  If not, checking for !uid is actively
> wrong, not just unnecessary.

Yes, it doesn't happen. So, only EUID should be check as you said. 

> 
> >> > +     return access(path, X_OK);
> >>
> >> I think the last "fallback to the system access()" is wrong, as the
> >> "special case for root" block seems to except that the function may
> >> be called to check for Read or Write permission, not just for X_OK.
> >
> > That's a mistake from me. It should be "mode" instead of "X_OK". It seems that
> > most of the time, it's used only with X_OK or F_OK that's why it has worked. I'll
> > fix that.
> 
> Yup, and have the function fall-back to the system supplied access()
> after doing geteuid() and finding that the user is not the root user
> without doing anything else---and use the remaining lines in the
> function for the special case.  That would make the function's logic
> easier to read, too.
> 
> >> See how FILENO_IS_A_MACRO defined immediately before this part uses
> >> the "#ifndef COMPAT_CODE" to guard against exactly the same problem.
> >
> > Alright, I now understand how this work.
> 
> Good.
> 
> > By the way, do I need to recreate a thread with [PATCH v2] ? Or I'll add the new
> > version in this one ? I don't know how you're proceeding. 
> 
> As the patch we are discussing in this exchange has not been
> accepted nor merged to the 'next' branch yet, you'd be sending a new
> version as a whole (i.e. not as an incremental patch on top of the
> version we have reviewed here) with "[PATCH v2]" on its subject
> header.
> 
> Emily Shaffer has been writing and revising a tutorial on the
> procedure recently, which may be of interest to you, and I am
> interested in using your fresh eyes to see if its expectation
> for the readers is set appropriately.
> 
>   https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpublic-inbox.org%2Fgit%2F20190423193410.101803-1-emilyshaffer%40google.com%2F&amp;data=02%7C01%7Cclement.chigot%40atos.net%7C4646e90041f04b4fa46c08d6c84ea22b%7C33440fc6b7c7412cbb730e70b0198d5a%7C0%7C1%7C636916637385863489&amp;sdata=nO1e1MV99iHsCyhDLTgBNIRCj0AZ%2BpwqtGrQY%2FJAB3g%3D&amp;reserved=0

Indeed, that's a really good tutorial. As I didn't made a new feature, I can't
judge the part referring to this. But, how to submit with both way seems pretty
clear to me. Maybe a sum up can be added because it's quite long and verbose. I
think a part with just the commands to run in order can be useful. Something
like this: https://golang.org/doc/contribute.html#tmp_12. 

> 
> Thanks.
	



