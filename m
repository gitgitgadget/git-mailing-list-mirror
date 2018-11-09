Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A09A61F453
	for <e@80x24.org>; Fri,  9 Nov 2018 02:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeKILoR (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 06:44:17 -0500
Received: from mail-eopbgr740080.outbound.protection.outlook.com ([40.107.74.80]:5161
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727500AbeKILoQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 06:44:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jci.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjwoGA7xxg3nmFNTjopstOp9/K1AKRXSMZ1XJFdSgoE=;
 b=Wdd6wwBMIypX2/Vb+x+iSqpNxE5ltLTfIDdemzyED7I3OAvwey+CDzvEmVyahuXg9IZHzWNhKpRcYJs6jlJ/Om6d5CqQ6zXN5ox2Qpbda+cjFnU0bIPfejSLIUhptxU4h0znCm5e3mhSCh20Vw7hSO8SR0MPX7Rdf7IF2jXEuhE=
Received: from DM5P132MB0143.NAMP132.PROD.OUTLOOK.COM (52.135.22.214) by
 DM5P132MB0159.NAMP132.PROD.OUTLOOK.COM (52.135.22.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.28; Fri, 9 Nov 2018 02:05:48 +0000
Received: from DM5P132MB0143.NAMP132.PROD.OUTLOOK.COM
 ([fe80::e45d:f8f5:626d:ba98]) by DM5P132MB0143.NAMP132.PROD.OUTLOOK.COM
 ([fe80::e45d:f8f5:626d:ba98%7]) with mapi id 15.20.1294.034; Fri, 9 Nov 2018
 02:05:48 +0000
From:   Joseph Moisan <joseph.moisan@jci.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [PATCH 1/1] mingw: handle absolute paths in expand_user_path()
Thread-Topic: [PATCH 1/1] mingw: handle absolute paths in expand_user_path()
Thread-Index: AQHUd9Bd3AKS0uyytkuGaq/5xJMDf6VGsTJw
Date:   Fri, 9 Nov 2018 02:05:48 +0000
Message-ID: <DM5P132MB0143B9D5FAF40A3999131517E7C60@DM5P132MB0143.NAMP132.PROD.OUTLOOK.COM>
References: <pull.66.git.gitgitgadget@gmail.com>
        <2287dd96cf0b9e9e250fdf92a32dcf666510e67d.1541515994.git.gitgitgadget@gmail.com>
        <9174a750-3498-c2fc-d7fa-29c1926c95fc@ramsayjones.plus.com>
        <xmqqo9b1d6na.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1811071217280.39@tvgsbejvaqbjf.bet>
        <d7a70226-3441-76c4-df6a-e8fb32249f27@ramsayjones.plus.com>
 <xmqqr2fwa0ew.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqr2fwa0ew.fsf@gitster-ct.c.googlers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=joseph.moisan@jci.com; 
x-originating-ip: [68.116.189.65]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5P132MB0159;6:t/lhbyZci3Mp6XjvS0K9xEc7JaKjru47e+nXEHuPzBiI8FdcWzG3ukTvrUbudqYABjwkO1XCZ4HmZbVL5cOp1BYO22ps71HKdF+4kDvr9bzuCA8UtogPQ1EwstIma0nFAoGP6CK9iES5ywKvBIGK5jvdQVleXxSm0Vu5xuNa3oFakaP+SCTbFxaKBu2elPpSkRnJT1CR5L0ASY/YIjr+kwKwY8mS/tVQoMQIbvTR6TmhaenH9xqZB78JY7+GZJCxGuZu6WnPyhZ9y7t8iKlZWI+n2UaUFYKRK6QPJajBnxBrR7+1Zh1d7SIMo/z7RjvPL3K7EPVgvPcKWMzeW/kSoUImRW7nwNyFodDwNucTLjbxsZHzut+anrk3+fZYMPX3Y1VbD7uDETYxKwidjOT8E53L66q+1Bb4bjoJ8RGBJG3HOq1uRAu6MnoStfCMTqAjfEGhHjO1mu2+9FWryBKgRg==;5:lN3MKQvoO0c/hZ+qFwi9+PctlDpk+kTcc4hv/dbQ424c9RXkrN3lMPqRqxqQteUJtQJXYmJ9WmMLmd2quXN8sA0zv9DWne4TcrR9zJebJNk4VQsgpDs/NrJlo82Y/Zq5Eg4CNeuHEMp9fTkC9nILCkdUrIlMaGNg3TdTZ2ozelg=;7:3u//ERvIQTf041p7tCJ3JV8RPvW1Xp6ggzEy+/UbAC3DDlbHHOfCM09OgQXxKdESXTbrhIwkDSNeRuHgXcbNqHSavMYuL0gaNd7Od4mMSGNAwpj8QQqnlibWSjniZdjS0gGGy7ROtqo2hyfgzUS6TA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: bcb9424f-201e-4c6f-9c43-08d645e7ddf6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5P132MB0159;
x-ms-traffictypediagnostic: DM5P132MB0159:
x-microsoft-antispam-prvs: <DM5P132MB0159C17D62223025A81BE10DE7C60@DM5P132MB0159.NAMP132.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(219970919918780)(9452136761055)(192374486261705)(26323138287068)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231382)(944501410)(4982022)(52105095)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DM5P132MB0159;BCL:0;PCL:0;RULEID:;SRVR:DM5P132MB0159;
x-forefront-prvs: 08512C5403
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(366004)(396003)(189003)(199004)(13464003)(504964003)(478600001)(66066001)(44832011)(71200400001)(3846002)(14444005)(256004)(316002)(71190400001)(2501003)(6116002)(33656002)(25786009)(97736004)(14454004)(93886005)(6916009)(486006)(68736007)(5660300001)(476003)(7736002)(229853002)(11346002)(74316002)(6436002)(105586002)(6246003)(1730700003)(99286004)(446003)(106356001)(81156014)(8676002)(186003)(5640700003)(81166006)(2900100001)(305945005)(8936002)(55016002)(2906002)(2351001)(7696005)(26005)(86362001)(102836004)(9686003)(53546011)(6506007)(76176011)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5P132MB0159;H:DM5P132MB0143.NAMP132.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: jci.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QARXCkmDfVfv/PsIgp7KdX4yySYqxTlKKqU0q2dKr4OgzBqC/dueOhJBWPG22bVfZ2YJuhbYHATH4XzrIWXCKGMbNe95YFV22f8iWvXRqZ/eJRWMqaYWGY6dsjZfrdcqB+9dBI2S27ox3X/ByICicK02D1IrTxUu+oVMcGAsiiJ6gHUr9B4fpseT6W6bZ+hHa+0/DqCrTmuUatsKzlPXDmD/kWXaZX+sIOjcb8+vbjYXdFTzHmM6PWY5SxJrfShWXDPfEfYKrDhX8WchZxPKVjRPz3Gv8+vWb3KFXoyfvWCdcZNVUPUIOgm4DVwIVFIDnwZXDflpUZ8GVsHX6PWtfBNqdTgPXi81zpYgHzUJKWE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: jci.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb9424f-201e-4c6f-9c43-08d645e7ddf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2018 02:05:48.1871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a1f1e214-7ded-45b6-81a1-9e8ae3459641
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5P132MB0159
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Can someone please tell me how to unsubscribe from this email.  I am no lon=
ger interested in receiving these emails, and cannot find how to unsubscrib=
e.
Thank you in advance.

Joseph Moisan | Software Engineer
Building Technologies and Solutions
Tel: +1-978-731-8950
Joseph.Moisan@JCI.com

-----Original Message-----
From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On Behal=
f Of Junio C Hamano
Sent: Wednesday, November 7, 2018 7:17 PM
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>; Johannes Schindelin v=
ia GitGitGadget <gitgitgadget@gmail.com>; git@vger.kernel.org
Subject: Re: [PATCH 1/1] mingw: handle absolute paths in expand_user_path()

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>> The cute thing is: your absolute paths would not be moved because we=20
>> are talking about Windows. Therefore your absolute paths would not=20
>> start with a forward slash.
>
> Ah, sorry, I must have misunderstood a comment in your cover letter:
>
>     The reason is this: something like this (make paths specified e.g. vi=
a=20
>     http.sslCAInfo relative to the runtime prefix) is potentially useful
>     also in the non-Windows context, as long as Git was built with the
>     runtime prefix feature.
>
> ... so I thought you meant to add this code for POSIX systems as well.
>
> My mistake. :(

Well, I do not think you should feel so bad about it, as you are not alone.

It wasn't clear to me either that it was to introduce a new syntax that use=
rs would not have otherwise used before (i.e. avoids negatively affecting e=
xisting settings---because the users would have used a path that begins wit=
h a backslash if they meant "full path down from the top of the current dri=
ve") to mean a new thing (i.e. "relative to the runtime prefix") that the p=
atch wanted to do.

If that is the motivation, then it does make sense to extend this function,=
 and possibly rename it, like this patch does, as we would want this new sy=
ntax available in anywhere we take a pathname to an untracked thing. And fo=
r such a pathname, we should be consistently using expand_user_path() *anyw=
ay* even without this new "now we know how to spell 'relative to the runtim=
e prefix'" feature.

So I agree with the patch that the issue it wants to address is worth addre=
ssing, and the function to enhance is this one.

I am still unsure about the solution, though.

I suspect that any build that uses runtime prefix would want access to this=
 feature, regardless of the platform.  The new syntax that is "a pathname t=
hat begins with a slash is not an absolute path but is relative to the runt=
ime prefix" cannot avoid ambiguity with users'
existing settings on platforms other than Windows, which means this feature=
 cannot be made platform neutral in its posted form.  The documentation mus=
t say "On windows, the way to spell runtime prefix relative paths is this; =
on macs, you must spell it differently like this." etc.  Which is rather un=
fortunate.

Perhaps we need to make an effort to find a syntax that is universally unam=
biguous and use it consistently across platforms?

I am tempted to say "//<token>/<the remainder>" might also be such a way, e=
ven in the POSIX world, but am not brave enough to do so, as I suspect that=
 may have a fallout in the Windows world X-<.

An earlier suggestion by Duy in [*1*] to pretend as if we take $VARIABLE an=
d define special variables might be a better direction.

Are there security implications if we started allowing references to enviro=
nment varibables in strings we pass expand_user_path()?  If we cannot convi=
nce ourselves that it is safe to allow access to any and all environment va=
riables, then we probably can start by specific "pseudo variables" under ou=
r control, like GIT_EXEC_PATH and GIT_INSTALL_ROOT, that do not even have t=
o be tied to environment variables, perhaps with further restriction to all=
ow it only at the beginning of the string, or something like that, if neces=
sary.

[References]

*1* <CACsJy8DmyU_Kn4yytu_PQdpppXO8wLcuuzQ-fjwnyjA0ntB2Dw@mail.gmail.com>
