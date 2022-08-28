Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A215FECAAD2
	for <git@archiver.kernel.org>; Sun, 28 Aug 2022 08:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbiH1IcC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Aug 2022 04:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbiH1IcA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Aug 2022 04:32:00 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70128.outbound.protection.outlook.com [40.107.7.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5F425299
        for <git@vger.kernel.org>; Sun, 28 Aug 2022 01:31:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dd15zvQnABy7Q4blthbcEKBRGEVK8gxSKbTsJqi5JPHVpNQ4it2E6ZpD/KI6EXXmxnDu8O7feOqs23pCynjJ7IKYyN+MAFcuq8rs43TuUDX9ZX/2oSKBwvAHwV+1BF5OQd03EFmEcqqoQwbrEwJSOJDCNUs74cEFeMiYBpN5gMjjj9ef5scn33JRnQACZy4HOR++izeZ7TfANnqCUiXFA+kdnFVp+m8qddfzTBgxt3gsjVtx0PZjvX4izEEHpIbDuWdlZZO6C9g4dp/ff7DA2HdwgZNxxtd0vcgw/GaEhowgrVM8bO5XRQrqtiZTkwE0z0WTN7BaPv6cpre4PBn9Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Z5AnazAAonDNg8n1NwI4PEV7NqU9hifmkHZB0bUrEI=;
 b=YxOhkvZPr4NLdvvylFH2T13gvkHYhKBHWiKTl8F6+8BfpHXSUPiw5A/OKC0JXz8AVWT8dIq42hMujNAjS9Iv2ExALJTVpFnkO/W7CQc779JKNhz/1KI/wo2m+nzkalQqsNgPzkUeP7PPDv6syo61dBEiQXnA5cKMhgF0otac2uBKMJkJxezT6KiIq9aLd24J6Qe9mPqDi1mv5VaVVvjk7+cnc5DEtOK8KBEXxxfAWdOEohf/eJMTAkJ8+YExL9/LYnzO5gPKgpSRhbrzGa/NFOfgN3gNSdVSk6kCPE1q3vU44PHWoZXNdDf1BL9NA3eRsqShTyU8/rn79CiY7xTlpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sparsetechnology.com; dmarc=pass action=none
 header.from=sparsetechnology.com; dkim=pass header.d=sparsetechnology.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sparsetechnologycom.onmicrosoft.com;
 s=selector1-sparsetechnologycom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Z5AnazAAonDNg8n1NwI4PEV7NqU9hifmkHZB0bUrEI=;
 b=Du6wrgMJ39NtXTykkbpmvCNw6/VAT5WQuCY5c4KHv+OiqmVrq3YqoSxbofLONFu6TmE3a1ISLDFkamsRFGAH4oADD6zCKMv20nt4Q+5Nuyzhh7atVp/6H/rRAgLQL0Bx/k5S3fin5eg61fL5omXxF+Fzb3cahhShAbsUzvJOGxY=
Received: from AM0PR08MB4323.eurprd08.prod.outlook.com (2603:10a6:208:13d::13)
 by DB7PR08MB3529.eurprd08.prod.outlook.com (2603:10a6:10:50::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Sun, 28 Aug
 2022 08:31:56 +0000
Received: from AM0PR08MB4323.eurprd08.prod.outlook.com
 ([fe80::d491:a986:c5e7:d83e]) by AM0PR08MB4323.eurprd08.prod.outlook.com
 ([fe80::d491:a986:c5e7:d83e%7]) with mapi id 15.20.5566.021; Sun, 28 Aug 2022
 08:31:56 +0000
From:   Caglar Akyuz <caglar.akyuz@sparsetechnology.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Ambiguous 'HEAD' issue.
Thread-Topic: Ambiguous 'HEAD' issue.
Thread-Index: AQHYulLK5nx0XyLHc0yBFLDTESNSQK3Dfp+AgAB9gbQ=
Date:   Sun, 28 Aug 2022 08:31:56 +0000
Message-ID: <AM0PR08MB4323EAC9ED1F88D5FF680DEFFD779@AM0PR08MB4323.eurprd08.prod.outlook.com>
References: <AM0PR08MB4323160241D4341FB1B99CC2FD749@AM0PR08MB4323.eurprd08.prod.outlook.com>
 <CAMP44s2iwWhpeBrzuRK5mB9ekpy4MRu5OEQ-BA4mvbUb1EJRqw@mail.gmail.com>
In-Reply-To: <CAMP44s2iwWhpeBrzuRK5mB9ekpy4MRu5OEQ-BA4mvbUb1EJRqw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sparsetechnology.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0565105-b9e7-49f1-f399-08da88cfc46f
x-ms-traffictypediagnostic: DB7PR08MB3529:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CwycpxLR4gGpsilL0fcz3KVSd6b62iOvaFz1j7IIwkjCwUTnW0+H6vx+qyigz51xUiGix2z5e2X/SgoH5JtqXI0btuP+ADYkQRPJZEL9v+6k7ytJegI6zS7MZcQB05Q7CM1Wk5Iqvbe0VXkCkVoA5zomRYkgwzBpsKuxnHu4ct7mqlBStg5uHMX/U0WQyqObwPEUXyfej0VEeJR3kYCfVAtMdm7cgB4Ds/92lV42hNQpgT9fkVEIT6e8c7+8ZdluWHtGQGIPgPRNK+4ajmBtYrn05TwG8gZGc/D/brkQMNBGgYQ/XFJxDfIgyQc+7kZrg0fPzpzhX0zXBeQyKyJ/yZLpY5+uiCUvQb1eJ/M4MTXZr722N7DAnTpJytXSi5j1QDawQ7XNDbE9bg3sQ5XrV8JKQlyBn6YdM/H/g7BX7JHXiarFNpfKiqITE/GTzR9utZ3vQmySbh2oCE24R9huIgqGClJz8KmsTRR2QwTbERIV6OsJt8eu11h6QLWgaXUJa74sMAq+0Fv5XOCG3CfDORxQe2rXNCjACO96Z6ORg89ffgXLyiHgEsc0LaO402BnRl99CGhRIY94u5gM2ydoZ+mFcLFJJ0j5Exizlkrr04PLXRToih+rBQ2eYTxL+Jr7hR5chAf/H3gM0e07DX08X0a/DLIa/JJyjrUMGq9H9qULbFTMqgS7AFl4mLxgYdO6jhvF2M3kv8pKeAl+4QhTHL4QXLZrXqLUqrsTcpkTuqo7tyAzuDsJiMYlO+REo3Q4L68xNelEVDurinLURjTEgw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB4323.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39830400003)(396003)(346002)(376002)(366004)(6506007)(38070700005)(7696005)(9686003)(26005)(122000001)(2906002)(53546011)(6916009)(83380400001)(71200400001)(316002)(38100700002)(4326008)(91956017)(66556008)(66476007)(66446008)(64756008)(8676002)(76116006)(66946007)(33656002)(5660300002)(44832011)(41300700001)(4744005)(8936002)(52536014)(186003)(86362001)(478600001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mURxlqmjzJ9lHUVHh06OXprpeP5NcNgbKtypWQs0+yv5Dsx64cEudjkyBL?=
 =?iso-8859-1?Q?M6FmPdOA0J4ZY1GBOrnhTMZeCrUEerk3xjxPqmvtyJMvZljOzhicmMKjDS?=
 =?iso-8859-1?Q?IIaxjbyxoIleuTOp6KA4Q6nk0jcPMg0ak5Ir+UdaR2GQxekjJgWG+E7ujL?=
 =?iso-8859-1?Q?wzY5/+0eEv8wLvGlKAtblYPlwT1sl//J0n1l/Vr8SoDYAVkJ69FnxPhJlc?=
 =?iso-8859-1?Q?m/UfiF4QOSSLzBBq86jXuDrlzAkgU+U1O0ur9cvCQGBx4Al59nBJnewUy/?=
 =?iso-8859-1?Q?HAIAW/9g4fiB7aPNYD2G7IxNKXziqaw5Iij60ypvB/vt8cmbjq56nI1VrI?=
 =?iso-8859-1?Q?f+Z4hUBSHqkIyvyk56mree28g7MM4KoBpIw/ENIsTFjy1VeY2IRIPNY1Nk?=
 =?iso-8859-1?Q?raMrq1UE0M025btaJtYR894TAKA1LQLjabtme1tEf2I4ofLqMCKokMcSyL?=
 =?iso-8859-1?Q?RRa7RcrMrVSDr4IYpk1eEzIIW578pU4z7vsck60RPsIpIpqlJ/it2k/9u4?=
 =?iso-8859-1?Q?kByF6pyOp0XPuk8c4AdxskSv8Q51Wd42F9mmABBI941PgzFJfW8/xoKne5?=
 =?iso-8859-1?Q?JTWMLTadlpgB34ZRZYt7iWZJ56zfR7Vb9yYueMEvrfS8xu8jxV0aEAEvPo?=
 =?iso-8859-1?Q?22LVO7v6dY53zRS2haE59/czuCEmfm8Ge+gLDV7r2lCop2BFsiBbfdajLV?=
 =?iso-8859-1?Q?TQJpplQEDph6evK9Pd3fx7Q5CO0cOtTF4V+6IAk5EBcUBXwi9lrmozt/PQ?=
 =?iso-8859-1?Q?PjnPa99n65xnNPY4/RbUsiiinzQZh84HaQUlcOeN9tkhMD5XMIa0M+chLl?=
 =?iso-8859-1?Q?tKHctHQpiFoLhIRsVWhDxM2eGi4tUnR1uc1y3PURo5JOb3WvehpINTLmZK?=
 =?iso-8859-1?Q?S+G4IWkRRKYLsPpseqb4FAoKWw1Ec9kjEpfyYZPOzK/iY4T0s6NRucJzKw?=
 =?iso-8859-1?Q?rfX1gPDuxvikEHB6UntchKj2b0Qj8LcgZP+D+iPCYj5YOvLzw46uUURM40?=
 =?iso-8859-1?Q?i9nAW86t87wpl5SMhnpcFHh5TL3Hm4/oWJ4t4K+uSfw7u41vIzmPiod6Ip?=
 =?iso-8859-1?Q?+eNB6uYUnbtzc9AQp3L2WPOeAQt1JY4ljyMmjIBnTdihS6tmQQPMIfLIQT?=
 =?iso-8859-1?Q?+4ZogxY9QE427Q5MAVOgs8pyTkNSmzWrww4yqtPuJGpjd+GZBsmjzohwhE?=
 =?iso-8859-1?Q?rXiT5YxGu6dZ95Z1rPSul5lzrBYGHnjCt3giVZKNiPDMMKvyB461Ikpftc?=
 =?iso-8859-1?Q?tRXaxnvkZVOMaj+P/XVcsbT5Isq7wvx9BV80qxDISV6PsAAnoKT1WW8o3S?=
 =?iso-8859-1?Q?ofPyiWmIEfl77FI0hxlcUGbIPqU2x22lPWEtXkRdUJBTbMBpzUQRLBORVg?=
 =?iso-8859-1?Q?usBvQOBQze4U3XBFBc1YDnwncFHPGSxqS/XkgwPm3jRdqEd4mUoPWw6fNW?=
 =?iso-8859-1?Q?BE/tSIdB6/gZWrVf5d4E58GzdUIVgsj4WXhtCy3goO7C5W6JgKLKSdCnKC?=
 =?iso-8859-1?Q?HeoCQMzIVefGs5MQdwXrAUDoKegnRJoQDFVx/qmqtuMmfaBBcH3U42PhA4?=
 =?iso-8859-1?Q?CzzJ7589jGsn+R0vf08tiD08w6b36n1hbSQ7x5U7h+FM3pgXwMKTUw8Ig+?=
 =?iso-8859-1?Q?l7CbpYynB9duMzhrHNK0IY3xYbtGT9DxngLzOT6qy/a2GMTUk9Bo6TYg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sparsetechnology.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB4323.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0565105-b9e7-49f1-f399-08da88cfc46f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2022 08:31:56.1313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0fb7b744-90b4-41ff-95c2-686d3964ba8c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GZRXD1OaJd9SZLJ2pHWUhOWyM2XvTzBWad+n9CnYyuzIhBcxVlurTi+VIYaqYxMV6HtZd6VtyigLf7RiiUMXszx3zjlsKYMRD5c1M34hZxM8R3GV5dyn5VEDn8tQ/zeJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3529
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=0A=
=0A=
=0A=
From: Felipe Contreras <felipe.contreras@gmail.com>=0A=
Sent: Sunday, August 28, 2022 4:00 AM=0A=
To: Caglar Akyuz <caglar.akyuz@sparsetechnology.com>=0A=
Cc: git@vger.kernel.org <git@vger.kernel.org>=0A=
Subject: Re: Ambiguous 'HEAD' issue. =0A=
=A0=0A=
On Sat, Aug 27, 2022 at 5:15 PM Caglar Akyuz=0A=
<caglar.akyuz@sparsetechnology.com> wrote:=0A=
=0A=
>> Recently I changed one of my repo's origin URL from gitlab to github.=A0=
 After this switch, I start getting:=0A=
>>=0A=
>>=A0=A0 warning: refname 'HEAD' is ambiguous.=0A=
=0A=
>> * git show-ref | grep -i head -> nothing suspicious=0A=
=0A=
> Are you sure? You don't have a ref called "HEAD"? Just "HEAD".=0A=
=0A=
I don't see just "HEAD".  "git show-ref | grep HEAD" doesn't show anything =
if that's what you mean.=0A=
=0A=
Thanks,=0A=
Caglar=
