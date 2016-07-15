Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AB1F203BD
	for <e@80x24.org>; Sat, 16 Jul 2016 08:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbcGPIJz (ORCPT <rfc822;e@80x24.org>);
	Sat, 16 Jul 2016 04:09:55 -0400
Received: from mail-db5eur01on0138.outbound.protection.outlook.com ([104.47.2.138]:21300
	"EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751017AbcGPIJs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2016 04:09:48 -0400
X-Greylist: delayed 37982 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Jul 2016 04:09:48 EDT
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=frtsiZwJ6jSXwnqxNGfRkxCpHK6EUO+6IZU2ckEtz3g=;
 b=JjbEX1pJCxAWR+AbJWc8OC1qD0Nciy3eOdkpX5nxCSIyTMyb+Z2z/F8kWfSk/vDAPnK43Y3YtDPtazRs5mkjYvY369GBMq9MGSFiSbzMb2F/LGM7+YzuEq/joXdBkzEOvWjkU6h5vfqChyfeEnqNtu9nypuScB6TCLnXXyzD0Ec=
Authentication-Results:	spf=none (sender IP is )
 smtp.mailfrom=avagin@virtuozzo.com; 
Received: from outlook.office365.com (162.246.95.100) by
 HE1PR0801MB1980.eurprd08.prod.outlook.com (10.168.94.150) with Microsoft SMTP
 Server (TLS) id 15.1.528.16; Fri, 15 Jul 2016 21:36:41 +0000
Date:	Fri, 15 Jul 2016 14:36:29 -0700
From:	Andrew Vagin <avagin@virtuozzo.com>
To:	Johannes Sixt <j6t@kdbg.org>
CC:	Andrey Vagin <avagin@openvz.org>,
	Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
Subject: Re: [PATCH] git-clean: remove fifo, devices, socket files
Message-ID: <20160715213628.GA19021@outlook.office365.com>
References: <1468550579-9298-1-git-send-email-avagin@openvz.org>
 <ab717fc4-fd07-53d1-1a88-ceba6155889c@kdbg.org>
 <CANaxB-y6XW7-ps1G2CB=N9CiD0VnSLhSer2nsf+2R4pm5TyswA@mail.gmail.com>
 <3a6cb604-daa0-6d34-3342-0671a0b23032@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="koi8-r"
Content-Disposition: inline
In-Reply-To: <3a6cb604-daa0-6d34-3342-0671a0b23032@kdbg.org>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-Originating-IP: [162.246.95.100]
X-ClientProxiedBy: BN3PR10CA0020.namprd10.prod.outlook.com (10.161.211.30) To
 HE1PR0801MB1980.eurprd08.prod.outlook.com (10.168.94.150)
X-MS-Office365-Filtering-Correlation-Id: 2bc0d345-9e8b-428c-d7ed-08d3acf81cc3
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1980;2:xTPi6qzjp6hcV+sdH6Yjp3K4RsgbOlSA+YpKftUTlQZX4qWAw+4bGnlKMfSWo1LuAYMeLRSdvWM81eToexQd/Y17siLfXTgLLUAdotY9NfHS1yhjdaedV/9rsvqx8ZjLu4xmWFD/LOLdelbfYayIoxTk+bw5KysZSdhrjuYCC2/rZtD/5sswcjztJIYerK/q;3:skZKcrigghCnD02kWnTxpoSHc6536/NH7OLizwIRFEsvub00X8n06sxSWsLThOswDt/qkAXFYJXLS9z2EEzKl3rZs6kG3cu1AzPjuDyuGnvsIX/bJPER6dDHvRp61R4a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1980;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1980;25:Lep3hOuc3Vv8FrjBvpCfwWoLijQK+IxUohJmXVTjX1/ud11cZJyL4ejh7zUNO6pmpZbY1m7KsKRHyhqBFW77q6RSnb6XEqUSBJDItZwZTugl97bxpMcK0QpgN3aZai0i/r9XLdbiOVMZWjHbfz438y1KbhJsIlz8/gDdn61ZIGkQc4Qcd8Z2xgWDb5a8dTMWpJQHYscTi36slvPgkc2LqlATaveLeRDi52Dda/2y3YKeygo2fUFRHZf88/9KDtQ/vEB86tlSry9h+sHfdH/WhEqdQJd1ZerS9ykpG+qaaeKDdJiTsI1xkJt7fxg61RsjNg78aqCb0h7Vid6yszr/eGm3qFJiBpPvw83W9Gaodc/5KLplqcIQicNakMkXKjQjiXxq+BKL0/I6RxlLs0jAyd8qABY+UVgPByvOrtIl0STx9MrpWQaDaBEerGfH/Wk34E82Ef4p40MbWeXYq8NcIHJHTwf6ct7H+oX9T4ZWpvCQSSWTI6+zrlKniBikrgkIIGDoyRXOzlhow4rwBAc6qDkXFl5m+rjI9gx46UdPSaPPsP4173ldnO4MylL0i+yFFg+azHMtdIz3q24ZhzDryB+lxCzVyrFjm+FP7VPGZA3ubnWyWG9zUaCpgHiissU2gkLdnqk1buXPDcOitR7iegCCGA2uFWjegvBx8iMjrQmQNodF/WkxGwqm/UIhjEQb4LRV3EMiKIRvrPvnj/ZuOw==;31:NY+6swMxxLDGvrEexLNOwHgF5+48c6M/+qzsoYORN0Pr2nT0rPW2PuZJBe7vlIUtusGpFy3pSigdt7riA1IYfhMLL5VvjCKcdmRL7rjmDp073jeaPUv12CA8iJAfAtIq9sfpbd2AN/glYIM2j336j+Jg18MXdzlF7dclQ0yTpnFqHnw+tuxTy+klokn8wxfpgmBISUPYe1LaMymdzIQDpg==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB198015716CF9930C1B957CFCCF330@HE1PR0801MB1980.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040130)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(6041072)(6042046)(6043046);SRVR:HE1PR0801MB1980;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1980;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1980;4:/KcUWfHH5adbC9UpGmL2vtE2VmH7/yCmIhs34GlP5P/OPYByRfqBvUmnxmq/AqbTqu286btf4wZZXMYVnOYMQeIDJyoPEXbZ6s2BN7royzCspmN0fbUZ6DJIKnNjjI/ZdF6sm7+5FQ4YY0mR0W4hW0mXPfS+eGRCLgQbQRiYXuZM2y4+JxgJUU/HFf4xoo38IUXcUzoJqpAUC7ZHFoqmY/GqJBcaSttoS5jW8E+HsIlkbLY7RrANxOs8mwBjFvUiSBDJmq1exapWR9zL2WQovwAQEs/bz17ld1XeSas43QkpTNmzmwqjc1dS6/68fy3a54GoyQTMwDiVtEsrW+3gh/KUd4gfrLkx6P8kzxB1RwOvoK670ngTsrhbDD3lXMC0IvzkQN0iNpzQ7L1x7cRVUUYFC9h56F6bOs0UoLoKlIDlj+fnQxGzwZzZ9ipVIh+BZEl/bjqscrk7ywZuEOqSAvmL2AKWJxLbri+9CNlPN9o=
X-Forefront-PRVS: 00046D390F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4630300001)(6009001)(7916002)(199003)(24454002)(189002)(377454003)(77096005)(93886004)(19580405001)(8666005)(305945005)(53416004)(19580395003)(50466002)(7846002)(8676002)(86362001)(81156014)(81166006)(54356999)(7736002)(76176999)(189998001)(83506001)(4326007)(110136002)(69596002)(4001350100001)(2950100001)(68736007)(33656002)(66066001)(2906002)(1076002)(23686003)(345774005)(9686002)(6116002)(105586002)(3846002)(101416001)(50986999)(97736004)(42186005)(47776003)(106356001)(586003)(92566002)(7099028)(18370500001)(26326002)(7059030);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1980;H:outlook.office365.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?koi8-r?Q?1;HE1PR0801MB1980;23:aOw3OAtM8zPZLSE0kXR0wDh85wBInK8xph5Kt/Pez?=
 =?koi8-r?Q?YzgoqxhcTYkrj9TouKWnSLhDhuniZ6ADKARH+cv2kMCjKFwrycAv64OL5J81tM?=
 =?koi8-r?Q?/af8CGL1q6CrviWND+EBnxst87y+fOGeGQQQuLFZp/DoyFVJYLrSPZQ2TKYlEB?=
 =?koi8-r?Q?1eegnOHqDhbQc6CQa5ZGcQ5xX8N3B1AE1l7/fd0HH7JaIr90gOYsVTIbpkUvn7?=
 =?koi8-r?Q?kqgrOjFFbw1WCPQ4wwK9ESekwUbIwbsQ/vAaElmN6l2g5D7AWbVVqpZt/93OWp?=
 =?koi8-r?Q?rg7FigRfxmZNEKs3B5VEb7NIZMjurd79xi4hX9fIiVj3xCQmOxFuYC1P6gGz2E?=
 =?koi8-r?Q?CqGkUqqtwnhpB5kDakViTsVNJgyAr9kk8n3/PIHKy3rgjZh40P5+Qfx80apr8u?=
 =?koi8-r?Q?iGYUBa6bB68Sw5+3GOUxSyyemkk1pDpt2MADXEcXruUxsnwovGKVv2lGbttfx2?=
 =?koi8-r?Q?XJEIfM079Vh0aVTZUWjRjU3DBfaVHh5SNbM/zzWPlxvkb6FpwsIjaFFtRrJAGZ?=
 =?koi8-r?Q?+iEmcY9aDwumtIf0ZKu6RS1TlyG0NjN3cjzCLirorvbs30b564bDw6Mz5qHvl/?=
 =?koi8-r?Q?5ZOlo2gb9f7EWSN91HkuCIgd9pGJ3eDNIMXzgasCs3FA85xANZhclB1d40w3y0?=
 =?koi8-r?Q?MW85oTG4lEa1C1qj02aNtCAWcT7+j7BuzkZlX04b+7pZbY/Lm+caGQsc5n+Etd?=
 =?koi8-r?Q?PasFnbSRIdafPorHsTKDVHotqtYG320zzrw140asBfyMIFK5foUYlYZAoumJ3F?=
 =?koi8-r?Q?UAxjKZ92/6HOOHrvSq0GArIDwL04r9WwxIYuQzZDJEvTXQtlcoHGPTmjAfDaHm?=
 =?koi8-r?Q?GiwOlpv4/HppAAkMVvtIdWJs1NxdzQeBBfbI3ut++QQ+LMoMpV0nBlnJpSCUjk?=
 =?koi8-r?Q?5sBV5xMD7Jp6uNz5x5wBL7NJT7g3TMvWnYyiqsZKrUGY/hLmjZ2rBHwa5heCTp?=
 =?koi8-r?Q?Hrv8MGgGUcJZQ3Fh4OQKq+4EL0MVu7z89Ws6RaP/Wer9NUfOmKVncnLxT/6Uwj?=
 =?koi8-r?Q?aLDUqN9QIjDdVS1/pBffQkLKsEKoWtIT0HqrfrhDYaqKw1U/uE+QLYqgPPLeeG?=
 =?koi8-r?Q?o/95JzvFZVpSHJfdZsLE090taQh2zwOcQW2v0MR9XB4m3fg0GVBwkgIdV3L9N3?=
 =?koi8-r?Q?n+3IRL9FfrS0DpVFNamHmA7edMGAtKsKhsjCeQ+h0GY7hc72GC0YLfNnVP7Vzy?=
 =?koi8-r?Q?a7yVAL2kEiGQpJBeoNXh6VvcQ+Y9fq7smyEPuI3CDcJ+a/FJfgJRJVVsDbrqAF?=
 =?koi8-r?Q?X9Cy6D6HJ7dzLQqUxBn7htsNU234XQ3U1MKs+rAknk=3D?=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1980;6:5G18TRJs84Fl5QcGq8xCzAt2EP/wv75Ho6Y5iA0Lm++OUeXiKiDvR93H9s+EkwCqOJzhoxULZpJiMT2STPgmEz+3AU0RBbt30XMKHModdF78rdzoluzxDk+UF0L2LiTpvpwQ/c53QaR22nDqHLL0CPJIm39oC+bViuK/OHq6A5XRXUEf0PBRbIwG6XulYpJJbuZdEDaeD13ZSdJ7UvUxrZPNMPOHd3o4PD3G1uTQPkYz0L4cUQE8SsUiakU18evyO7L0cDpZF9skvoy/MiDMiEDoBo0CXx7tMPGVtYUx9eKmVBlmRONELeZGvi+QIzxv;5:1OKxA1Qsr/CPj27AVHkC4sBQpPqA00PD6tUvCcxu9M2OVjM9liQjnupGwBoXdCa3AWfHicYbwFBN9CJA/PTSO2kzpnlKjWymvGCkjWyPZex+htXZ8kLFD6UVmelHICN0EerV2H6NKYE+5fJIFsMr7w==;24:6ud0wHDFFd5TQyuUtn/ZSFI8sMkEhLEvtX+3+YWO8udjEdcI2u5okmp6xs5nBDFEBfEJ9DXNMSk6+eDlyEF89ZuDPmM2GZQIQB9dposSK54=;7:skvwRdOcmbn8fk87m+5DSTCG/T5RXIfwu4jcGXD4WNCg58Ckj7z5ZCpimS0mlaDyCfK8dVSuoanO0pBzl7dIk0tIq/pdNJKuYeVfkSt//LxgRlqzg9hZ8P1B4bk5A7L0bTjB/7eTiwHdQSp4vNSJihGF8Z6cChGu3ykahmTfS0qMWi5nNGBm0Q9rKxQ2FP4K7lvDTHyZ7iyzPmo6nQahPF5b/Ec8GwNkbTvNdADzsom+vzPVZez1QqO6UvyBdlLo
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata:	NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1980;20:Z8VFiGU/0YLOuLaFE+q3gOLuFb8+hfabiSVKaZgrFtl44YDypUS2GwGYp6i1bObgYQ+Sqlk+DCQXChC6MCvT34u1H8/bCjufeg8mYXpiRFgioElhojOglC8Kh8QnbDMxkEmYR7+iDIbD5S8cFT8LriM92mp5dxCyBJg7OohO7Ks=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2016 21:36:41.1495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1980
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 15, 2016 at 10:33:42PM +0200, Johannes Sixt wrote:
> Am 15.07.2016 um 09:46 schrieb Andrey Vagin:
> > On Thu, Jul 14, 2016 at 10:56 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> > > IOW: These special files are invisible for Git unless it already knows the
> > > names. The latter case is outside 'git clean's domain, and the former case
> > > really means that special files in the working tree are left at the user's
> > > discretion.
> > 
> > I understand your points, but I don't see any reasons to ignore these files.
> > 
> > What will be wrong if 'git status' will reports these files?
> > What will be wrong if 'git add' will returns an error instead of
> > skipping them silently?
> 
> I can buy that 'git add' reports an error for special files. (And I concur
> with Dscho that the behavior should otherwise remain unchanged.) But this is
> not what the commit message sells even if the patch changes the behavior of
> 'git add', too (I haven't tested the patch).

Ok. Thank you for the feedback.

> 
> -- Hannes
> 
