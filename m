Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DEAC1F859
	for <e@80x24.org>; Wed, 24 Aug 2016 11:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753185AbcHXLAS (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 07:00:18 -0400
Received: from mail-db5eur01on0047.outbound.protection.outlook.com ([104.47.2.47]:58192
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752308AbcHXLAR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 07:00:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sociomanticlabsgmbh.onmicrosoft.com; s=selector1-sociomantic-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=AmPrXdAu4qcQZ8SxFO6HYzUEKGwfoylppZDtD7475Mk=;
 b=UR7qmmm7KkbMg12FpyLQDmMMbSKQC4AGH9RhFKA3l9b3U83Wpd6isS/+N1cIZpHHYyyH1S0ojJeqRgaQDn2YiORWVgB4AGMMc0EzMzMHTxgUv7+LmjR2J2P0J5ikQHQSdjnOO4bqeaidoFAcXu9TNf3M2KSs7maYrRzAFi88+Xs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leandro.lucarella@sociomantic.com; 
Received: from labs-064.localdomain (87.149.166.167) by
 HE1PR0101MB2139.eurprd01.prod.exchangelabs.com (10.168.29.8) with Microsoft
 SMTP Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384)
 id 15.1.587.9; Wed, 24 Aug 2016 10:28:34 +0000
Received: from localhost.localdomain ([127.0.0.1] helo=labs-064.localdomain)
        by labs-064.localdomain with esmtp (Exim 4.82)
        (envelope-from <leandro.lucarella@sociomantic.com>)
        id 1bcVQ4-0006nf-Hh; Wed, 24 Aug 2016 12:28:28 +0200
Date:   Wed, 24 Aug 2016 12:28:28 +0200
From:   Leandro Lucarella <leandro.lucarella@sociomantic.com>
To:     Stefan Beller <sbeller@google.com>
CC:     <gitster@pobox.com>, <git@vger.kernel.org>, <hvoigt@hvoigt.net>
Subject: Re: [PATCH] transport: report missing submodule pushes consistently
 on stderr
Message-ID: <20160824122828.0c2688e8@labs-064.localdomain>
In-Reply-To: <20160823214008.32331-1-sbeller@google.com>
References: <20160823214008.32331-1-sbeller@google.com>
Organization: Sociomantic Labs GmbH
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [87.149.166.167]
X-ClientProxiedBy: AM3PR04CA0029.eurprd04.prod.outlook.com (10.242.16.29) To
 HE1PR0101MB2139.eurprd01.prod.exchangelabs.com (10.168.29.8)
X-MS-Office365-Filtering-Correlation-Id: 617c2ada-4674-4ab8-cf8c-08d3cc096745
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0101MB2139;2:myiTj0Lniq0qhziC9RJnkYrP3A51rVpr2ktbOFpmqOwBvZ+l8uW79Zith7C6PTrhdV2AnLvdyl+jh+r130vNEVNjn5IordtKlFW4znrsGLD7Pk1t7bxcdGJZp8SgxH/fG2wUCK5YUWWrzNJpVOnud435lXG3tfv8AFL7P0AKtAeLj5iQVS10eqvj9LFS1Uxn;3:4vPiWIq+xNr3yM0h/7u37JAbNN4dmZB148RNHn7gUl89aUWsh085pFW0pvX5Q/GCMkJQkqjhcqybbypIBsrgvVitWJQPYaKPkySpcDAo7mF6b2hrediVcbCuxFGpRsTk
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0101MB2139;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0101MB2139;25:pDStuZB8ZOaggT7UF7BNt8Rb0qU7G2gDSdDNWDLuwh675bgLDfcCmyY6VbXzHMZOlJdaQpnQOspTTpWk7FCycPfWFe95uaS+68cyy6jSf5AfonHlc3BNcMuFloBKcFrndAIYcdSrbZ8itgbqafhNSm0syFFfSFCxBkxTvVw9j8loq7uk7pluN5okmZwBJg7rJBeCbf7IPka44OuVgVg2oBh4JnaT5YqEE0FoQTsXDC8NdNotJTA4lxHexJXeJvozV+ZoGjz0YZKlIzYMeTDXr3zNHx2Xwz7GwXqFgtpFEd9yITITKy/y+JpVJ78t99UANa3WwLfcOajpoxfdXkd9Js0fZghCVto56bpx78yF1PZZXZ/V/yWBqikqne4d8USBw3iXTKYhxkvAQoL1ON3h535wIaQkSjHs6YWFsH+S3nh6Tdq7lnwert9e9Pj8haadI0+C3vJOTsqcN7L+Rscb23vPihdfJYg8Ezpwm/9VFHM8ht7oKjavJpE39oLuD/rqCdv27fJdqN5NYICtN680AHmlccFaCtaM454w72uzdXo+65YjC08KHIk0ENorkwqKbTWFuWeK64C2zDdZz+8r5z68VB92/OFDNBj9fruacciOnIURH7PLiH5vky0E9og3Oi+yMk/7ORlQgZLzOFXKHoJlqmFOGCUdOj4k1WT6zko22jrnvMXopE92nSXpyNrMteBHNNFYnl+onQubak4mzII3mhFGQt/2kDpHvn1TsrmPf6DPHSFEW0JtGiBEHA5jUg7diDEnB+armjUAQMipoRp3S7dZD9vtQAHoboPjCMl4u9RdyZsMmM14vx5lM9JiYDOhTivZc1Oov72l0BXnkw==
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0101MB2139;31:Sr03Xy+qk9ZUyPiioM8H6pIwupq44H7R7BIhtI6UyTLKob7YoDRjOf9fj6cplbcKv0G0DatqJIc1gEdyJC2xF8iGzsT2+yZ7xzVk9hDXqfXgFoMBeXIDsSNMgpKVi1SwZboFv+2JGvCy1mEO5G3g5dmc7e6Ix2dwsDtQfp/YQCMumY5JQkWDkRsEUllydFC6r9wchYsS8lJsD6veqM6JBtE3HJhnt9XP8SUZcRKEkCQ=;20:y0h81sgR0X+8Y4PpZFXq2Bk5i9+NncEKx2IFf7pCGWPVhZe0TchFaqNgUt8+X/Akj5zzIjwaNUF/69LVGPa4BlQiykreqr4fX4EA1vvVIdMk6MF7ksCaO0NFwgluj1tU2Hg8MO7gqREzHIBt2iWZJWuC5F5yhutcrK7tpyVpqEZ2qPtAXyyAddq21QuQ/ODMnbs4uYJl0ICY92tAtmxeCoKdBhmhu3GOiPdhD85eaZcRNaGL1Ef74naJrdmNjsp1
X-Microsoft-Antispam-PRVS: <HE1PR0101MB213970054743D3FF097AC4B2ECEA0@HE1PR0101MB2139.eurprd01.prod.exchangelabs.com>
X-Exchange-Antispam-Report-Test: UriScan:(7783539604369)(211936372134217)(211171220733660)(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001)(6042046)(6043046);SRVR:HE1PR0101MB2139;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0101MB2139;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0101MB2139;4:4SvnP/PHQqu6jiIlX350N4C3Rq/NSIk7+G2r6ZUO8fdij5PP1t7htm1qsSVtUWzbxf645bm/Hnk0UQFXgwfIBB6PbtWnq2ZOeRDFG697E21KI8vc6bpeZwa4LHXR1FDlbiUzoEYYozBM/qOpKq7sArOK/P2UJmXRWkHQG2tB68arD98KG50AEHY9XY37rDJd7rXBH02XfpF53UFJMPayvpbzu0QMRRW0puYdP50G63XIKB7e2qBhazPZJvwSy/mqm6RZtgQw3/NU2poHoQS5ILKKVO1AWyz0rhMbPJqiNqwkcdMdI/vO+c9LAxAmrDxSg3ZfHbaaLijWWAF6t0KTzxIeAbtmRdU7wt6A30oktKiYRRq9Lya4vA7qRjMgCKCmfC/r63+BJSuPbGVhdCWFDFQU4edys6bqiLBkxwPT/PjWeq+J81WW3PbLKbJtcJMMPUHLMyUDHaOHEONcVOlggRCUVS1aS1Jmljuj/uhiqMOZ3qZ2IjCui+RWFbdsBXvTii+WMv8AGvLU+tBQV+sOo6Z1IQ+0vHeYYfVbsviXPXKremtxBQrFhWWvtCg3jCx2
X-Forefront-PRVS: 0044C17179
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(199003)(51914003)(24454002)(52314003)(189002)(77096005)(97736004)(105586002)(4001450100002)(50466002)(49486002)(122856001)(76176999)(19580395003)(9786002)(7736002)(7696003)(50986999)(7846002)(46406003)(101416001)(305945005)(50226002)(86362001)(33646002)(23726003)(8676002)(81156014)(81166006)(19580405001)(92566002)(106356001)(47776003)(66066001)(9686002)(68736007)(15975445007)(1076002)(7126002)(230700001)(110136002)(189998001)(586003)(2906002)(2950100001)(3846002)(6116002)(4326007)(5660300001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0101MB2139;H:labs-064.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: sociomantic.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0101MB2139;23:qJ8cYNtQLHNTVFPF74U8rK3A0kiKmHB/2CI8oGP?=
 =?us-ascii?Q?ToX65+KQg0RQSjnmBhnYIeOXT4WZKfY1d7i5SW+qP/tsO9XLzEHVJFUN/lKA?=
 =?us-ascii?Q?CiaEHGX0IGIJF3Hiz08uOFkml7thu14sj6l9cu8sSwyUH7JFJlJ1nh3ZeLZs?=
 =?us-ascii?Q?uqdOJS4O3XVm8n7kOM02vbW27yhidV9lGBqXSHRI/vStz+h6YWTWMosBBgWX?=
 =?us-ascii?Q?B7YmZdWxd3VU00g/DmlBpvNu8qqHayu/Hqomoj1H3/IqPuyOrCCPS67tGFXV?=
 =?us-ascii?Q?LibBqfBnwe+HAFdat1jcDqKamrIor4LxI2/dVS2ERdu18mXsV5hq0cbMGlbQ?=
 =?us-ascii?Q?19FO2B+ndfrqrF3sqxd2u5F+ln7SnKqD7NIOrI5rM2dlf4r3XGM+ruspsb5x?=
 =?us-ascii?Q?fQDxZ8UJZTjCJ3x7wKQ9HX/TKwz0ULxZqlkgtFxqgmkdhvGm8qCs93zGrvOP?=
 =?us-ascii?Q?xkhakyk183dCedw2yvbxwIVz9MbIEaG0ZpSag32dFqLfHEsgpDB1mn8egGiK?=
 =?us-ascii?Q?e+WhjME1yDV/NV7qYC2+4Ahu49QYPnq2i6DeM/v//iuQSX4bEhOxiL2BA3mG?=
 =?us-ascii?Q?wX0mu/6PUnqMLO2jwB09ZjYK83H1rqv2qPu3sxOgq/vLX/QzCGfXKMR+C5L5?=
 =?us-ascii?Q?pEyc8CoJZlkzyZi2+LvnPj/KbKrNBq2Z8k4Z6hqg4Kgx4ngZvp1GLMByUOuP?=
 =?us-ascii?Q?GvZ/feMijamsjaF/eKXQARVeituVV8tED/5akG+6NIu5J0rdM0/6BVeRL5QR?=
 =?us-ascii?Q?ZaGbUD8tpfsntACPaocL6pvFOOVxF+UY0b6NNXWc9+k8hEcNu54gYm0N6Csr?=
 =?us-ascii?Q?E4b6aycAz4hjGMW5EZIWNfkEyAFnOU7epPi11z0zVGNQEEzCH3Hi/vUKyw6W?=
 =?us-ascii?Q?NqRaU3cG3ExWz9eg78JrKkyMorLfAK9dYCZS/zCJ1eYMkGxAE+f9ksGulRUw?=
 =?us-ascii?Q?r9jVw+dB1Fc2iyzf8pOqsLiH2DWjivUr9ajxzR6oxQrwpxzyxgbwgxhv4+Et?=
 =?us-ascii?Q?cJWD3RZSyyiFj8GdIBUpZb6eHqwV8i2IMIvI8glRJjKEzOUAlfyH0N6OQN+U?=
 =?us-ascii?Q?OnjN0WmRt9NNsPOVMVqs+dO44FxGjMgT5oq3JqTxyGAJGCLefgoCW8vE34Dz?=
 =?us-ascii?Q?QcoFeFrRnwq2w/CQ/E5fEQ6UkCk+SiysBRQrunmKUtVfmQy4uxPE/AawvNm1?=
 =?us-ascii?Q?19TZSb2p8V3uUzGMT20xSlQYXpTEHqVM/YftO8Jik5ADdUSGm0iiAcUrPOxq?=
 =?us-ascii?Q?BhGi3O9PpG+QqKFpBXsDiNIvWBo0pbxb0OiuT5+R1?=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0101MB2139;6:x4UGW2E5dxwOODfJRBNgdepnWV9FgrqKa50sucX/r5vugecrP9F+UxAEZAYaLCyBISkOQmz0Arejw5NkjvlTc7ppKQqZ51dC1usddW23SSU0Go7r+w2Q3aU6MoPLdyoseE9WoGMxosl9pi2ARe9pO9XqbOt2ojJumKEKyKp17PhQlGLCIMdQftZoT5VWTytynDEWXpV2ZPXf8jHJPYez2RZdfDB5trGwnkOlK3CaAQboaklQXWAV/FxuvRiYS2pH+HuQL2oGxfHkoxsXyWQ52wwh9nzPdmJHf0sb3ksIfapX/mPjqs3KWqQBMZ04e0Fk;5:zCR2qgZ0vrlVLZVB9REgCWfFkCZVITt2eIolT0wwoVbzTwEJmj0XUM4dZlASfA0zVihKrN727Sz0KcZokAXW7y0wX65rGeEpog4/ICC4OybXIRPY0hDowA94I+SBdFcn8LphqAS3gmlVfVYoHXWUzA==;24:db5DW4I4qiPqABhGPwpBfE79GLAOlaQ7hXIobKpF9Tdz4STZGXT+ZNmWAlNl0t5aHsnpYOO2PbNCOYe4V/63ko073DUOyie/m3JT1vTtqC0=;7:8iVJVoZ3wBxPwRvdsvoQuFUOCpTKUCr+XxPB7THZA00PUIu2D3b83D16mubTwV2+amapwsfUeFJjwOk/ftvRh6L4XPH3QzDWOG1KenMfvuEKLjtJfxlaLmUiIEBLc1C6M2edyLn6ny5r5Fq3H0Hg7LFVG0EdtKNtkG/1nsuWmpdJz+8/LgIXbfx86Zi4o2EKcVKzrj9eDZIWooiEZgFLlTAB2Dwnh2bUCjiNQzwOHiIK3KAOuvvkK6ZuQ0gEM/TL
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: sociomantic.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2016 10:28:34.7941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0101MB2139
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 23 Aug 2016 14:40:08 -0700
Stefan Beller <sbeller@google.com> wrote:
> The surrounding advice is printed to stderr, but the list of
> submodules is not. Make the report consistent by reporting everything
> to stderr.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> 
>   This fixes one of the bugs mentioned in
>   https://public-inbox.org/git/CAGZ79kbkyupBJfvyX3Hj_R5ZW36+3ufOnnLC-Dpic40nPJAxDA@mail.gmail.com/T/#t
>   
>   How to fix the other was not as obvious to me as I do not
> understand the philosophy on verbosity in the transport code.

I had a look and I would say just enclose all the fprintf() inside a:

	if (transport->verbose > 0)

But then this is the first time I look at the code. I was about to send
a patch too but it will conflict with this one :)

Anyway, thanks for the quick fix to the inconsistent printing with
--quiet.


-- 
Leandro Lucarella
Technical Development Lead
Sociomantic Labs GmbH <http://www.sociomantic.com>
