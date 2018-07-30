Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C64B1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 09:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbeG3KkA (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 06:40:00 -0400
Received: from buffalo.u-blox.com ([195.34.89.137]:53125 "EHLO
        buffalo.u-blox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbeG3KkA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 06:40:00 -0400
X-Greylist: delayed 445 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Jul 2018 06:39:58 EDT
Received: from mail_filter (localhost [127.0.0.1])
        by buffalo.u-blox.com (PF_LO_10026) with ESMTP id E30D039E44
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 10:58:30 +0200 (CEST)
Received: from ASSP.nospam (localhost [127.0.0.1])
        by buffalo.u-blox.com (Postfix) with ESMTP id C245B39E32
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 10:58:30 +0200 (CEST)
Received: from unknown ([127.0.0.1] helo=anyhost.local) by ASSP.nospam with
        SMTP (2.4.7); 30 Jul 2018 10:58:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ubloxcom.onmicrosoft.com; s=selector1-ublox-com0c;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUNqLYJS4XRVYN/mYoxeJ6KZH6zVVKiBbrG2b2/AJtc=;
 b=TBMLiWtfT8VbZ3JN5+LVu5NvuNYigSbym+bF160qKFuB/UqbFWABP/eROrROqUGfQg9kW/QLWBahE6sQN7hiUGgkVx6xT23ekVhKP1679SxMNg2c4TlkAb8kEyg4W3udSqWKKy33T5e/qekyoDNqOVfOr5QS/cirYcYUY1GRnVE=
From:   Mika Vesalainen <Mika.Vesalainen@u-blox.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Using Environment variable GIT_CONFIG does not work as expected
Thread-Topic: Using Environment variable GIT_CONFIG does not work as expected
Thread-Index: AdQn4aQ2kBkepcYWQ+ywBmLFBFRIag==
Date:   Mon, 30 Jul 2018 08:58:28 +0000
Message-ID: <LNXP265MB0892616339D20CA9B10D6A31D42F0@LNXP265MB0892.GBRP265.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Mika.Vesalainen@u-blox.com; 
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;LNXP265MB0490;6:bvELEl+ctKU/xabNA3RM0KEJDF3gh1mBYYhcbdT4oJAuSyB5Ac/dlWC8+V7R9x8q+jB/VBnFsm5A8pYdSMcq7YeuEBgveWP35X83ZmuQV8QrfRCCT7i/umV64Itvcv/CIm+kLj1qHdILbujNCt6Ry4h7XwT+YsOBZYrw/U6pRI37yt7hfjg06Tz+Dp0S6x/AYO4MZgUTi+a0LAakSZvnaReA15UxlEMixDMVLzBp24xDq/lN7Hcmh7FdyciB007kbApNhQ/+bdpPi3lhqfuH480AsisXAxFd5fAvjY6CssJbVP4+KWW3Nocfk+gHRxRDT8i8AShVPvEzCwuHc0+J5COunY7A/ohHmY7WXwCZAgrm46/wX7OI9cetxbRYmOm4jN3yGp9WzcujcWPjFyWZCxm+H/qbRvVuVFTRdXWV1lYhoX4swO7uahaEiEb6Zwk/73Nb49mhgZC/3HPSZ8koOw==;5:l0hlb8PVk4Kw/ZYKHliM5Bviuf3q6VNnTErvWXSZ3GCJOveOdRM9vWliHeSXdrNIkSDqm1ZmqA38Dar0FIWneTdfFbscV/gkLmyrtHezuDRJvOVz3Afh5btltPD60av5WoKDtZzYjKCYT0mD67Tv8pLYXRRid8Y6yaNoEj5IFgs=;7:YwSvSO2vlC+eE1oFt5q38kIVxxIc4uh6TLIYToxbVsH4X1yiJB4ZUDz9dKVsWr+yYspL1IRxIxHckjftzTOrrUnQ2Lf5dZTIu55lhNtA8pMiY0DQ2I5NFvqS/2RLi8AP/da+lfYWqnKvpw02hXZT2+sjXOKR8p2lJO4VVvTEC4PdrWD5AXHHVrlyCwsC43Mn1+Ol3PFPyJiOtALx6+RBQatJeAszT4Dtg9ecw56qIsembYnD9dEWmgrNPqMPZear
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1e28e9c9-0c7f-4a08-4e8f-08d5f5fa9e7c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:LNXP265MB0490;
x-ms-traffictypediagnostic: LNXP265MB0490:
x-microsoft-antispam-prvs: <LNXP265MB049087A227D8DC65AD31078FD42F0@LNXP265MB0490.GBRP265.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(120990272794272)(21748063052155)(65415361840574);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:LNXP265MB0490;BCL:0;PCL:0;RULEID:;SRVR:LNXP265MB0490;
x-forefront-prvs: 0749DC2CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(39850400004)(396003)(346002)(57704003)(199004)(189003)(316002)(105586002)(102836004)(14444005)(5640700003)(97736004)(26005)(86362001)(7696005)(106356001)(25786009)(53936002)(6306002)(8936002)(6506007)(9686003)(2900100001)(256004)(99286004)(186003)(55016002)(74316002)(72206003)(2351001)(33656002)(6436002)(305945005)(68736007)(476003)(2906002)(486006)(966005)(6916009)(478600001)(1730700003)(81156014)(2501003)(5660300001)(81166006)(5250100002)(8676002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:LNXP265MB0490;H:LNXP265MB0892.GBRP265.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: u-blox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: UrktQVn2PfDobqjW3rd+8sOxZVeSyrQXL3p0uV7O5mnEFeBSMAul5I1WPpkeu6RStMF14RFj0BXz4RBtVZcEVn3kBdELQENlDDgPEJhEwMHPaFktwcvcjNpDKq7mN+VaOBx5gTQ2+5GWW4qRw9mGhSR0AHbMF3Cdy7mZ7vHiNmFrKXjk2gtw/GdX11WY9e8KrnNOFq08FrJQS1Tq4WwJlm4RvFaGSYCS7rlJirDcy4Yg8wAVeK9tdQF3V/nRin3VhT829KguG3HzMKzCayOc8fBUZ7sxJiv7yfwc3WSfSxynMWiu2izgdZ3SaCEOlFnKmtaArWKl2hXv5r/by0hqMZm53i8qbkg7shve+BivEgE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/alternative;
        boundary="_000_LNXP265MB0892616339D20CA9B10D6A31D42F0LNXP265MB0892GBRP_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e28e9c9-0c7f-4a08-4e8f-08d5f5fa9e7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2018 08:58:29.1148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 80c4ffa6-7511-4bba-9f03-e5872a660c9b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LNXP265MB0490
X-OriginatorOrg: u-blox.com
X-Assp-Version: 2.4.7(16004) on ASSP.nospam
X-Assp-ID: ASSP.nospam 41110-19679
X-Assp-Session: 56AA8780 (mail 1)
X-Assp-Original-Subject: Using Environment variable GIT_CONFIG does not
        work as expected
X-Assp-Client-TLS: yes
X-Virus-Scanned: clamav-milter 0.99.4 at buffalo
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--_000_LNXP265MB0892616339D20CA9B10D6A31D42F0LNXP265MB0892GBRP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I have a shared linux account which is used by multiple developers. But I w=
ould like to have git commit history configured so that I can see who made =
a change to common repository (so that author of the commit would be correc=
t person, not shared user). There are reasons why developers cannot clone t=
his environment to their own accounts.

So I don't have ~/.gitconfig in place for the shared user, and when develop=
er log in I enforce them to configure git for them first. They must "export=
 GIT_CONFIG=3Dmy_specific_gitconfig".
When this is done, "git config -l" will show correctly the user.name, user.=
email and other parameters which are set in "my_specific_gitconfig".

However, if user tries now to create a commit the git blames:
*** Please tell me who you are.
and so on...

But running "git config -l" shows that 'user.name' and 'user.email' are pro=
perly configured.
Do I need to configure something more in order to get this GIT_CONFIG envir=
onment variable working. I'm working in Debian Linux environment.

I have tested this with git versions: 2.1.4, 2.11.0 and 2.18.0.321.gffc6fa0

Thanks,
Mika



--_000_LNXP265MB0892616339D20CA9B10D6A31D42F0LNXP265MB0892GBRP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">
<div>Hi,</div>
<div>&nbsp;</div>
<div>I have a shared linux account which is used by multiple developers. Bu=
t I would like to have git commit history configured so that I can see who =
made a change to common repository (so that author of the commit would be c=
orrect person, not shared user).
There are reasons why developers cannot clone this environment to their own=
 accounts.</div>
<div>&nbsp;</div>
<div>So I don&#8217;t have ~/.gitconfig in place for the shared user, and w=
hen developer log in I enforce them to configure git for them first. They m=
ust &#8220;export GIT_CONFIG=3Dmy_specific_gitconfig&#8221;.</div>
<div>When this is done, &#8220;git config -l&#8221; will show correctly the=
 user.name, user.email and other parameters which are set in &#8220;my_spec=
ific_gitconfig&#8221;.</div>
<div>&nbsp;</div>
<div>However, if user tries now to create a commit the git blames:</div>
<div>*** Please tell me who you are.</div>
<div>and so on&#8230;</div>
<div>&nbsp;</div>
<div>But running &#8220;git config -l&#8221; shows that &#8216;user.name&#8=
217; and &#8216;user.email&#8217; are properly configured.</div>
<div>Do I need to configure something more in order to get this GIT_CONFIG =
environment variable working. I&#8217;m working in Debian Linux environment=
.</div>
<div>&nbsp;</div>
<div>I have tested this with git versions: 2.1.4, 2.11.0 and 2.18.0.321.gff=
c6fa0</div>
<div>&nbsp;</div>
<div>Thanks,</div>
<div>Mika</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
</span></font>
</body>
</html>

--_000_LNXP265MB0892616339D20CA9B10D6A31D42F0LNXP265MB0892GBRP_--
