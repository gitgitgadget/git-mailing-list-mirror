Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010010.outbound.protection.outlook.com [52.103.67.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6032E3373
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 11:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753184614; cv=fail; b=CCalJFbWJ6rewzr77tHEmttf/EhYXny2G6/TU1OKihl6aJ5D+l2f5Im+JO99xWy2Cbhr9Kc8zQURWtaDF3xMmubfIydIkgHn7eylAJ1AsgS1eu/IyQQVRG8X86FFTRH0L5GiXMdup/BGT0FnJ7zTHdE5d6DXrNinyxRRmlLeWIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753184614; c=relaxed/simple;
	bh=hAAW1VaORvry9mh2+z79DioXeYEGeh7SD9JPYwatb3M=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=orL9Wk7aiNgMwlGYNP+H2gocerFr6tEUUWP3to0KwQwDOPveN48fNft/zg92bhqbRYD58vnr/tS6p1/u3xUJZQQG1/XT/JC41QHANRqutcg5xsEAHtIY0dT3005GsJudVODkHWXV/ocToFjEwf2aIi5jnbD+KB7Lqght5vgRLJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=uFvDgg9t; arc=fail smtp.client-ip=52.103.67.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="uFvDgg9t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M560Th2otPtjonhPPJ5Sq+buGT2Kk4eVgTZ9AlM2HYdTlU/Q0W0cORG6y1VkoiAyoj1XLvxLVpm0bGc5n7z/EOuo8PYHotyJZ6NSCrIoq0h8EXHtWKV8eQMeN6i/JjieAodGah+2XBZN+vxaW/61MHxHQ2WjMNvUGWZ/OxX1OMBC1O3NBs9DYdieVBQek7neGkUBQyuITZp/vH//GFBMNpWooowwfL+m2fv+CMqd0y38ujjPVqFzIJ7vsoz2gs/eJ7Y6kaT0l7lbdED4XuvI+3PqdbBIPM7MeBlhJN5Zpa2W3z7WHSt4LRybfqNmmiAIWbJlTi/Isxy95O2UXDBHFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hAAW1VaORvry9mh2+z79DioXeYEGeh7SD9JPYwatb3M=;
 b=PWcN4q13LDxWYDRwQcj7EeRRc53a4ggoxbIIfucVtmjTgp+RqJdyzkeBp8K157zuObrJO1em1DKRD+tckQ1fpc7NoQz1l6bnxu6u6FTAKFtAR5NFV32mr0afrUvqq/kxyvkBGzNme+UiorpQKlZXc/I53k5ZXpU1ITag9yKWXi102EiOjb2ublQQC0SgbbeIPFY6eztACSjvyr6d9VXc0nyib21NPF19cdTTXo9yk8Z+2L0Yv5gL/htcedeNTDhutY/pBlZ107c5pOVL1F0ZYj7PQCqWYipjkWClD1i7JgMSWslO7iJkKcta1eb26Mt9EMOMNdaXIwJ7xGMzTgfKqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAAW1VaORvry9mh2+z79DioXeYEGeh7SD9JPYwatb3M=;
 b=uFvDgg9trsj/Wzon++l+JoiQAlqXHcRUG5EEw7Ewz+5ZsUSXela9FtOSHOmDzjsw42leVykVqtfqt+rzpnm73JsTehLUoexIYAbJNjJAYpSuG+CAezbGnwp0jBuXzKr8BJmTdRZsM9AbgS3uOddokuxrHvmg6hMglSu4TF6PZJKUxoUvgOtXoYj/P8FrUzMHZwhzNZr4B6SvBJMq3Tqgy5QT5jQUYraluH6HRtSU8OT1RSYxFWrauJBS8IpWJFxzsI4RP+YBKqOAI0O+phxqaoxWEFjwjZgKEwSxaF4LM1Rm81nuCp8/ppZtIE7dFv/BLXetqewdfK6ImfxNJdnobA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB9267.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:be::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 11:43:27 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 11:43:27 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>, Junio C Hamano
	<gitster@pobox.com>
CC: Eric Sunshine <sunshine@sunshineco.com>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>, "brian
 m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] docs: explain how to use `git imap-send --list` command to
 get a list of available folders
Thread-Topic: [PATCH] docs: explain how to use `git imap-send --list` command
 to get a list of available folders
Thread-Index: AQHb+v3Wa5SxIaVoCkKYr0nlsf4E7g==
Date: Tue, 22 Jul 2025 11:43:27 +0000
Message-ID: <20250722114246.20422-1-gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA0PR01MB9267:EE_
x-ms-office365-filtering-correlation-id: dbbf2154-2a04-4004-0241-08ddc914f964
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|461199028|38102599003|440099028|40105399003|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?u1qcBSoATVXvQcwcA3/ixl5Tm7PIAB75xgunK84mOCotomEqxvIjDfPhXk?=
 =?iso-8859-1?Q?C+ZnPDqQHt2XQKxHuoT8LtdrCZrmflYAnrWniNeMpS6D+u+l5pyZuyPsKL?=
 =?iso-8859-1?Q?D4tXcRFdr9hewz1iGx6wKSaUErZIR7j8B6+5G4r0S/jV6mFe6Vt7T8qvBE?=
 =?iso-8859-1?Q?AMV1pEeiT+/vauPTjNrL1omQ1lM8rpmEriqUMFkTp2BuogW+ZmJzVTPGLO?=
 =?iso-8859-1?Q?la7fdx95HdcHjW/pdpj2JIgi5lpw/p0Ml9AKKdHQO33Rx+vF3VtUzcZ3uF?=
 =?iso-8859-1?Q?Evl2iPEh2e/hzXbNtnHw1P+UhTehFwOszo0LHkeQu6oGbUfoNbIVu5TE/E?=
 =?iso-8859-1?Q?fwKybFI77uMod7qEmYmuJO848jps9NQEgvHjYjxmb/FrxL7KdQiJXgFA10?=
 =?iso-8859-1?Q?mesUzVs5X7cdFhy+ZTX7pp9EdKrYhBTtP3gR7QkqVQLY0G17W+9eHuRxdX?=
 =?iso-8859-1?Q?YcGvYEi3T5hWWLductAhr2g+9ujkFwxoWm+YylWsFooJxnXgZNnovElXKU?=
 =?iso-8859-1?Q?ccpo3obkyTEDA45rdDjosrlGoinBUHyvDuDcU7vKrwhoPnyGqAW/4muhJ9?=
 =?iso-8859-1?Q?9J6Nv2mUkCkmhwtmlM3PVIUrL1wlYPra60O5kSyhyc6dXXgexUSC+7AnSf?=
 =?iso-8859-1?Q?JKZ9eaTcsTHu5C55lXATjuAM/SBi+cVsl4H/264GVjDf8+4ceyJAlgjNNq?=
 =?iso-8859-1?Q?RtOrm8h6DbRb7OkTDdXh0CiM5Im1ofLNExNe5ZQrN6m1H3uPCTmvjJ2wf1?=
 =?iso-8859-1?Q?tt4GvGYdQ6s8QYVlVqEQlLodPHH1lnG39CMnTGkp4epgIjj4KHFU2d2MYH?=
 =?iso-8859-1?Q?HD28LymdnW8+CvYmX5MQ25jZmGUbELavl44rxkP7VA9t0UjOK6EtwllJuv?=
 =?iso-8859-1?Q?b7/EwXoLlIm8dXij+Ki2t5ww0SyvKiKOeeTqEUSLL8PeS6Ens+e8uadrDV?=
 =?iso-8859-1?Q?AQaGbLmsPVqIFhCkwkyLZlUSIdDZ8u+ldla8wpGN5JyDme8RMLQq8heUx4?=
 =?iso-8859-1?Q?uGZf+x0UmtR4aF84lUVgsZyiB+Cg5paHKlXL6+c0AOgeMcbCgFOccKoK5T?=
 =?iso-8859-1?Q?+uCxbDuqwQTzLj7QjmYFnFUcaYRPdmA3I8N/zRZBFGeY?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?y7309tivyQLducONQJcWYDqrycSOh+L8u80vXwrvmeMkM1HfFJNsQr6ayP?=
 =?iso-8859-1?Q?yit8UtbBHWoHwlGuEAvEeJ3jwbO8K32SWPyG4LuJ3gaEnmANWQS7v4xzqy?=
 =?iso-8859-1?Q?c6ctFjF1PlHReWm6VLxTnFvCQ52P0imPEor8XGsIyLLGYpdPfahC/vfQ0h?=
 =?iso-8859-1?Q?njGC3D0qsgIVKyP5Cy6GT0s4y6ycKl4GP0cVQjB5+nz4bLeSPQEYJHJ1+/?=
 =?iso-8859-1?Q?1Zs6gz+ZWOl5COh1HA+Q8hqcYnjGPeaONaHf4GM99Q8TaEtKXbRIzqxDMI?=
 =?iso-8859-1?Q?jmuWFpkXsuEV2HdV6FoVlQeUC+oLu/IARB2F5IjGj9o2rMbaFlsNanLFQh?=
 =?iso-8859-1?Q?KorVjpwC+0ruva9/EEijF4eUmzBttE9GgPAds6KHh/T5PEa6XJKCF/DAx8?=
 =?iso-8859-1?Q?kp6LYOwZEzPvYjc1pZQLYOr3x+AevvOQouw9j7mr2dJl8eETQIUOev3cEZ?=
 =?iso-8859-1?Q?QB1UHIf/PL2t/+dxfGRQk/GiytAogqH291dKeyXAC1sjqZTMjSp5+Odio6?=
 =?iso-8859-1?Q?zvzVfOkikB9r4dz6bQi9zf8tiws++Zsc6owy9Hw2B85Z2UKhI7gx7OZMQz?=
 =?iso-8859-1?Q?TlHy39pcDcOPSrvfbEOwll8yL80MoLGIOkfDsGaGia1w5uEOdzT9QBE8Z8?=
 =?iso-8859-1?Q?fCBiVFbBuYgWJPcirAzhIzH5v90u38XwAg4Lj1qSt2ANb4xpf32j28nPob?=
 =?iso-8859-1?Q?iubZPV2V9VpeQqPjOdZ6zylt0A1z4uZlCvnUjps+BPUa+Br1wxDaOqBjEy?=
 =?iso-8859-1?Q?69ZrgE5zbKMPfRpzmDYYHrGLbG0Me8Z8wfje+NGakLSIArDKxUjooluvLq?=
 =?iso-8859-1?Q?ERc/BJBrxRUKso+6tX/H3la8xPjJH//WNZs46YQma4n++ajz3cx+RtI7og?=
 =?iso-8859-1?Q?TsvGohs+w0ZdNdMWOSL6DtEsEEYQfFFgPl86Guq5MK5bqeTF+YPtpW+ruo?=
 =?iso-8859-1?Q?YKznw6YbPhkC8ekApiOL0HKvyOVmUeq3NtRm0UBmfgCJBl1cQdeMwnhXpa?=
 =?iso-8859-1?Q?KOmuAbe8zNi16wgyik+o6iT2/rVTQ/UATpdi7uHIe9YgKNJ9thXVS2rlZB?=
 =?iso-8859-1?Q?NV+dPndQt740iv+s93UZ0B9EH5IrEJl5JksGHjj0eHrEUFk0iJKQs7uuWC?=
 =?iso-8859-1?Q?7AtW75HdtRMqScAae57wXDA4ui5MwFv3mDvmgvAPnkzQjXo0kxNzezsILi?=
 =?iso-8859-1?Q?2YYxLQu0xo21WWACWBCEi8knRRcv6F9ll8QFuSVjaG1zEFB2V+ADFXd56O?=
 =?iso-8859-1?Q?VS98VmRSjhaEFc1+s3HUzwcBsqVKN5/fC6uLOQAqM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-8769-5-msonline-outlook-acae4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: dbbf2154-2a04-4004-0241-08ddc914f964
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 11:43:27.7063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB9267

The output `git imap-send --list` command can be a bit confusing for new
users since the IMAP LIST command output is very verbose. Help such users
to analyse the same by using an example output.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/git-imap-send.adoc | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/git-imap-send.adoc b/Documentation/git-imap-send=
.adoc
index 17147f93c3..6411fee046 100644
--- a/Documentation/git-imap-send.adoc
+++ b/Documentation/git-imap-send.adoc
@@ -68,6 +68,34 @@ include::includes/cmd-config-section-rest.adoc[]
=20
 include::config/imap.adoc[]
=20
+GETTING A LIST OF AVAILABLE FOLDERS
+-----------------------------------
+
+In order to send an email to a specific folder, you need to know the corre=
ct name of
+intended folder in your mailbox. The names like "Junk", "Trash" etc. displ=
ayed by
+various email clients need to be the actual names of the folders stored in=
 the mail
+server of your email provider.
+
+In order to get the correct folder name to be used with `git imap-send`, y=
ou can run
+`git imap-send --list`. This will display a list of valid folder names. An=
 example
+of such an output when run on a Gmail account is:
+
+.........................
+* LIST (\HasNoChildren) "/" "INBOX"
+* LIST (\HasChildren \Noselect) "/" "[Gmail]"
+* LIST (\All \HasNoChildren) "/" "[Gmail]/All Mail"
+* LIST (\Drafts \HasNoChildren) "/" "[Gmail]/Drafts"
+* LIST (\HasNoChildren \Important) "/" "[Gmail]/Important"
+* LIST (\HasNoChildren \Sent) "/" "[Gmail]/Sent Mail"
+* LIST (\HasNoChildren \Junk) "/" "[Gmail]/Spam"
+* LIST (\Flagged \HasNoChildren) "/" "[Gmail]/Starred"
+* LIST (\HasNoChildren \Trash) "/" "[Gmail]/Trash"
+.........................
+
+Here, you can observe that the correct name for the "Junk" folder is `[Gma=
il]/Spam`
+and for the "Trash" folder is `[Gmail]/Trash`. Similar logic can be used t=
o determine
+other folders as well.
+
 EXAMPLES
 --------
 Using tunnel mode:
--=20
2.50.1.319.gda7cee769f

