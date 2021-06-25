Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8833C2B9F4
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 16:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDEBC61969
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 16:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhFYQxD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 12:53:03 -0400
Received: from mailgate6.prudential.com ([161.151.153.47]:8925 "EHLO
        mailgate6.prudential.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhFYQxD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 12:53:03 -0400
IronPort-SDR: zJtQq2KXBi2/0ULprv/+dTo+THApBq09sT0SNzPyA1JXmY/5Un4KmBEhywD1FdHzb6oYoNgQmt
 IlkCJNs3bGFQ==
Received: from p2erscba1085.prudential.com (HELO ironportnjprod2.prudential.com) ([161.151.153.21])
  by ironportnjprod2.prudential.com with ESMTP; 25 Jun 2021 12:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qmaw.com; i=@qmaw.com; q=dns/txt; s=20200731;
  t=1624639841; x=1656175841;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FGeZa9DrNhTeBr+rvpvQjl9QRuTlmE50eNkdQuoLov0=;
  b=ZHqg0GIPDESk5sekJHKyqXtODKDU67HqMVx0O+nuNS2W2KcxSYsylb3u
   sCtkaVxYjhJxKn+duOqMskzeFG4KMtZrbXhKNn8o0yRxmyHmGgAB4ticq
   1fU2PaFpGVy7ysy7ABle99Mvp1om99Jq+bBIBeSxqH8jXIT8CvH8dTYJi
   bJ2FisvotOfPhKLgNA8PXtFd3s+GS5PsCka8NptL4sKFKHFb4I/KHw4/r
   2mriiHWG92J3aH+6Of8DCwwcfWjrKv+BqGmM/7YuDDqSBZZE5FbjasVm+
   5ltKV2w82T6s5roqayLWC/+zy1AIsMMZSn0BH56nLdXDWYsEEHnCNePPP
   g==;
IronPort-SDR: 5tIHNCX2k7Wku021BcEVVNPdVse26ibV7dOa5WzTYdkl1MLCfyuzkS9Z6kcTBvDSWofLt8rAfs
 ZNFJYQ4tN7/g==
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AcJcdyqCvo/wV/0HlHegxsceALOsnbusQ8z?=
 =?us-ascii?q?AXPh9KJCC9I/bzqynxpp8mPEfP+VAssQIb6Je90ci7MDfhHPtOjbX5Uo3SOD?=
 =?us-ascii?q?UO1FHIEGgA1/qr/9SDIVyYygc1784JHMZD4bbLfDtHZLPBkWyF+qEbsbu6Gc?=
 =?us-ascii?q?6T5ds3thxWPERXQpAlyz08JheQE0VwSgUDL4E+DoCg6s1OoCflUWgLb+ygb0?=
 =?us-ascii?q?N1FdTrlpnurtbLcBQGDxko5E2lljWz8oP3FBCew1M3Ty5P+7E/6mLI+jaJq5?=
 =?us-ascii?q?lL8svLhiM05VWjoai+q+GRi+erw/b8yvT9Hw+cxTpAor4RGIFq8gpF4t1Ho2?=
 =?us-ascii?q?xa6eUk6y1QR/ibrUmhNV1d6CGdoDXI3TM2gkWSuGOwkD/tp9f0Syk9DNcEjY?=
 =?us-ascii?q?VFcgHB405lp91k1rlXtljpw6a/ICmw7hgV3eK4Ii2CV3DE30YKgKoWlThSQI?=
 =?us-ascii?q?EeYLheocgW+15UCo4JGGb/5Jo8GOdjAcnA7LIOGGnqGUzxry1q2pihT34zFh?=
 =?us-ascii?q?CJTgwLvdGUySFfmDR8w1EDzMISk38c/NY2SoVC5e7DLqN0/Ys+OfP+rZgNd9?=
 =?us-ascii?q?vpZPHHQ1AlbSi8TF56EG6XZJ3vYUi91qIfyI9Fm91CVqZ4tqcPpA=3D=3D?=
Received: from NAM04-BN8-obe.outbound.protection.outlook.com ([48.96.18.96])
          by njros1ngw23.prudential.com (IBM Domino Release 9.0.1FP8 HF450)
          with ESMTP id 2021062512504160-762441 ;
          Fri, 25 Jun 2021 12:50:41 -0400 
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LlLXlLdD/A9m27SVWkVh12eFXwpbRPLzZdZF9ECSqFlqg1/Q9F/qoPFJNTsLFVwTKlqEjqvOfO5xMt0anz7HyaNK189C7Uz6YohI0Z6ke5gLOxt8G4new7GFrTZpgl8cziE2f84ltNYMmQXgl99ydZJI9RNV9ZVLzraFFtxTGraVWU9Yh1SQKIQUyOK9BTtVpAzIR60EvWJJCSKLLOp2m89lkm2pvEUNjN5HBjz3iGd7jhCa5eKUI34UfwjKmseDo4CblqS25ya6YANC3vE4ZGVGCp37/m7DFt40GhiVT3oShityhCS3Kpm/yfgM4d4I34cvQwLi3X7m1VYfCNTtPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vTetyOfMk8kGD2HkWZxPNhJIHrH+7UCgVLjR236uQA=;
 b=M1mhVfbkU8LE4CfhOMrUVsI7YSr+wmu584R2R6zcx4+GtPIiYbIR1QAIKB0yM2jeLNix232wdtxqQ+lle9DEKxKLCJpZYNa42lK6aJQvDgOExhaVlLNn8/rVjYNoeFEzXOPPRM66fRYaZlhJWVXEaTdYxEJIgtGYHR4wXJvLHqM+iKUiyGouPZ6RNQ8QUkF8uviAFlag1v80RGAvuSuwxABIbqSkImCtxvqCfucg/7vMX86Gvt2E9Zmx6LvCEQmwspMxP364dPHo4J3oXZQZuKcV5CCU2JnueJ3WmTFKC9BVn6waRFSm8ZD7YtOmSgKd87tYa0a0CaRMTeBePwm8Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qmaw.com; dmarc=pass action=none header.from=qmaw.com;
 dkim=pass header.d=qmaw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prudentialus.onmicrosoft.com; s=selector1-prudentialus-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vTetyOfMk8kGD2HkWZxPNhJIHrH+7UCgVLjR236uQA=;
 b=YAKX9irXSQ0b28vbPr2k5pepxI0KgW2i609gxiSmzf+mC+/LkMhg9pghNt7PSmZWkfbN09N5P9Xc0AKdxqO08UzcX/erfclOH/xeOJkMiamzyaQWwWMulMweCcHj7Ni9Z/V0SCELx0qVyZHQF1SGlm+b/DVusy2MjT01RM4/Kf8=
Received: from DM4PR11MB5247.namprd11.prod.outlook.com (2603:10b6:5:38a::20)
 by DM5PR1101MB2219.namprd11.prod.outlook.com (2603:10b6:4:4d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Fri, 25 Jun
 2021 16:50:40 +0000
Received: from DM4PR11MB5247.namprd11.prod.outlook.com
 ([fe80::c8d4:a2b8:3888:858c]) by DM4PR11MB5247.namprd11.prod.outlook.com
 ([fe80::c8d4:a2b8:3888:858c%5]) with mapi id 15.20.4264.023; Fri, 25 Jun 2021
 16:50:40 +0000
From:   Ed Avis <ed.avis@qmaw.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Feature request: 'git reset' to print old state
Thread-Topic: Feature request: 'git reset' to print old state
Thread-Index: AQHXaeIxMBvQpvUMUEuZKPp5vlHh0Q==
Date:   Fri, 25 Jun 2021 16:50:40 +0000
Message-ID: <DM4PR11MB524701700B6BF444B1A87E219D069@DM4PR11MB5247.namprd11.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=qmaw.com;
x-originating-ip: [2a0c:5a84:3a06:eb00:c4ec:1103:dc41:2e3f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b16ce02-6f02-424d-8c1e-08d937f95dbb
x-ms-traffictypediagnostic: DM5PR1101MB2219:
x-microsoft-antispam-prvs: <DM5PR1101MB22193B541E203C7243C7D43A9D069@DM5PR1101MB2219.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4TYtZJlqiRa7AG2JdRjod8kKStMh4EwdgFoJDzmWgYnsNtHpDi0BRcHXNvqHP2hcPvwm7FrqNlH9x+qyyB85MahpY2z4/Q5+Y6SA/1+P30N8gtcLMbfSFg8HFXAkcd1aS4DZXLhGTmI/10m2YeADt4/lJctXP6vOmy+2TxRqfj7hLCK4rUxudQCyx4lf0UMKVNwhxaxy7Vx7RYR5yLm3tp3D5JMqqqvs5HPwSNYrMRi3TXj4zvlwxGw8YAAUkxkHd+mgBcBPvT4aEXaPfU99EtA0H4JzbhtBVHTgTPjRqgjwT4/kPvHJHoLhvNHnJQLP3+XB/ixaXd49VpfxFUVqo9VdlAiwM17MNJJ//94GSNJpNeV7G0pDZejLYcipRh+SpYrAmfX5a7VmHELX2JC0KI2Q9oC/rP9IfiZKYrvZUgzj7qUr5SdELBlJbybJa8snNPYzAa67OgIiXDo4QUhwPapielk9K1gKZB0ppyTJWKzjPMfBuwUY3zWaniMs18BKWctggtkPdQMUy0muJg03AyKacw3iWXqzfhQJQEOSst+6Z5cyygeDbJklW5otajnXtfegITHj5x66sun7H2BY4cGWs5yKOIEE+SQX+nMuTIcaMh5Pq5X2/WWQ4dFm/3yBfwGuLkB5LclKlmtKXi87ew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5247.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(55016002)(9686003)(5660300002)(186003)(83380400001)(8676002)(52536014)(6506007)(7696005)(44832011)(6916009)(8936002)(478600001)(33656002)(86362001)(76116006)(66946007)(38100700002)(66446008)(71200400001)(64756008)(66476007)(122000001)(66556008)(91956017)(2906002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XNsF8v8ACtjG4KlvegQuxrTS6u/oWLvkb5VRxtRN/nKxaE3Dt5rYVDlEXc?=
 =?iso-8859-1?Q?pGa6fHiF6GTYL3WHTbVhdgK89n6ecQrsEKSr+OKSsbNYbYLnstIOJTjyII?=
 =?iso-8859-1?Q?eT58cSDrgK2qfNiX6ZOtUcSsVG934CRX5XUZbuNKHQQz2ym9Bkv9Lsx8/9?=
 =?iso-8859-1?Q?esOE8T1fIxGTdA0JZ5bYY8VMCO2FIizilp3tM/tswU7/IdVm4NizVxGq1Z?=
 =?iso-8859-1?Q?GCv34Q/Q9CMFLTEbECGudqrrK0vh7WGaQ33hh6jtNyjuV9Y/Ew0miJqXVd?=
 =?iso-8859-1?Q?0mh3HxmVPIHbEIBrg7tKSM81E6ziGgvzzY96sKEUyfJ1SNNJAQ9MtvS7JV?=
 =?iso-8859-1?Q?SJhSVJJc2ILQSSHE/Q0nPNuJ6iCF+zKHY7rOY/gJhEKNQwyRhq0tF5unr2?=
 =?iso-8859-1?Q?lKszFSp1rStRe9nU+mhdaRJieXIsi/qhCZNpvxWCk7n2K9eaBWWkHXE+aP?=
 =?iso-8859-1?Q?lgB5H3HmBx2opIA277UrkOnn9KbL2JgLX/KP3F7kRv0OSI25wFFjCpG8cS?=
 =?iso-8859-1?Q?ta3b/5tDajSNOuI9kt1+al+Dpr5tHRJwfH1okruqSYZCQibxsXOtkGcqBM?=
 =?iso-8859-1?Q?7/XRgdBR411ew3yeHP8aZiFzebQMqCkY3QPgfEH7W+8yFy3RgnCWWMtRRw?=
 =?iso-8859-1?Q?kVkymlQNoYkYhvTehsPzmrEvu0SNhiYNQuwGNbCDKSvVR3tCAjM0RpTddE?=
 =?iso-8859-1?Q?Ms5o5FNi68EiLq8sDqpXBWPwMcO6ECr/Efcs40eD8GVY4xYTFxRcW53nYn?=
 =?iso-8859-1?Q?9nRVSBLCl0OMam02S1Zs0CDbukx/bNRj289zaMnh0bQLw56KhQ7fD9c6ti?=
 =?iso-8859-1?Q?TaaB0t02fZBXgofGfVLXGAC9PDNse9WaEyx5pCY0gHT4Qkup1/1xasCPc7?=
 =?iso-8859-1?Q?V6DH4FaRkzuBtazig0rzBppYC6pmjNxDNjvdo/loHeVzRvEXD2TUERj5kk?=
 =?iso-8859-1?Q?ZWiX3BV/1zNB6pFNdyglUMdYR+81VgxLfW4uynMzxTC/cnPW57XO9G+PFh?=
 =?iso-8859-1?Q?AHhPQZu+gpgpNy2qfaB7NqQlRMUy5YLeWAi1Viy3qb1NtlaCWSu9rsVLnW?=
 =?iso-8859-1?Q?mM9hQ5+v9bFz/cJQ7z9TPCyqgdgDfn47FHBkycqF1EKasf/S/5PFI9+Wpi?=
 =?iso-8859-1?Q?bAIUmQYG1Taobb656G+4/Y/U/jLCfjsXlmyVnrwpO2A/B1hICDqtd4LEd7?=
 =?iso-8859-1?Q?VPT9Dz7UCbyE+MqW0cKiDNcKxg1cLWCFrbxLQrKrlaAXLu02AXFLzBN757?=
 =?iso-8859-1?Q?pWU7tn3bbEaYE4Zjd4KgAwQgYWPzWskGjtJgW66UruBvS9vagNVoE4p1Iz?=
 =?iso-8859-1?Q?ZTwUHQXJKj87faB0pop5zmjmpQeqCMxvfNaOAAPtuZv9Un5vVnSdyiM2hG?=
 =?iso-8859-1?Q?lqTrdRCDPDuc0e0w3PO8Dyj9xGRtafbdKTlmU77ymKduslQQJkeNWcd6Kb?=
 =?iso-8859-1?Q?lIb+l32i1aeyvONE?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: qmaw.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5247.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b16ce02-6f02-424d-8c1e-08d937f95dbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2021 16:50:40.7148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d8fde2f5-9392-4260-8a03-0ad01f4746e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5kd3OY2tMrsbsms0rlvF8ZJ/I4pXilt1lJQY9HdQ4iopbR+Ec50YybdL6nYOtlzxMmUPpSs8VNwtWk7InOfQCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2219
X-MIMETrack: Itemize by SMTP Server on NJROS1NGW23/SERVER/Prudential(Release 9.0.1FP8
 HF450|June 28, 2017) at 06/25/2021 12:50:41 PM,
        Serialize by Router on NJROS1NGW23/SERVER/Prudential(Release 9.0.1FP8 HF450|June
 28, 2017) at 06/25/2021 12:50:41 PM,
        Serialize complete at 06/25/2021 12:50:41 PM
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Content-Language: en-GB
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When you run 'git reset' in the form that sets the current branch head to a
given commit, it should print out what it's changing from.  Then you can
easily go back.

% git reset master
Resetting current branch 'mybranch' to abcdef (was bcdef0).

--
Ed Avis <ed.avis@qmaw.com>

This email and any files transmitted with it are CONFIDENTIAL and are inten=
ded solely for the use of the individual(s) or entity to whom they are addr=
essed. Any unauthorised copying, disclosure or distribution of the material=
 within this email is strictly forbidden. Any views or opinions presented w=
ithin this email are solely those of the author and do not necessarily repr=
esent those of PGIM Limited, QMA Wadhwani LLP or their affiliates unless ot=
herwise specifically stated. An electronic message is not binding on its se=
nder. Any message referring to a binding agreement must be confirmed in wri=
ting and duly signed. If you have received this email in error, please noti=
fy the sender immediately and delete the original. Telephone, electronic an=
d other communications and conversations with PGIM Limited, QMA Wadhwani LL=
P and/or their associated persons may be recorded and retained. PGIM Limite=
d and QMA Wadhwani LLP are authorised and regulated by the Financial Conduc=
t Authority. PGIM Limited (registered in England No. 3809039) has its regis=
tered office at Grand Buildings, 1-3 Strand, Trafalgar Square, London WC2N =
5HR and QMA Wadhwani LLP (registered in England No. OC303168) has its regis=
tered office at 9th Floor, Orion House, 5 Upper St. Martin's Lane, London, =
England, WC2H 9EA.

Please note that your personal information may be stored and processed in a=
ny country where we have facilities or in which we engage service providers=
. If you provide personal information to us by email or otherwise, you cons=
ent to the transfer of that information to countries outside of your countr=
y of residence and these countries may have different data protection rules=
 than your country.

To learn about our privacy policies, please use this link<https://www.pgim.=
com/disclaimer/privacy-center> to read the Privacy Notices.
