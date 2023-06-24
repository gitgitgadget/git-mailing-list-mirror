Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791ADEB64DD
	for <git@archiver.kernel.org>; Sat, 24 Jun 2023 10:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbjFXK27 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Jun 2023 06:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbjFXK2y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2023 06:28:54 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2092.outbound.protection.outlook.com [40.107.21.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76BB10F5
        for <git@vger.kernel.org>; Sat, 24 Jun 2023 03:28:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GfBvSBN8rwVOhySDFfBDiUB9UQkRveOinASbzki1dZvWRmwwZYLhBOdoqNDa2BJ+YCIclFudMmTMpmCmlrO8Vif7WYEZd7NcvaJkrC4vZpl8nseEpj0b8UxhCLuO82eNzdijgvAwUFcchPgxr0R4k3PWjPkyOVjaKTFyGWkCGD7JOZti3rhGKv+QZwlneSZF5xdw6/JIzbsUYtTzDJ2Tle+7e0ApcUzjXvdljCgJzPCJ5DPoDGCXL9s6m1SPDLTMSC/RxDu9ssdxCKdasiCLosIwUwy3Y+lq4BR2e5s1TU8wJ6jpjmAVvjAoUw4BdkodJS4TSkBHtwGyt1ztjBra9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rcpuBXYzmR/BWLeWLNXe9sAKgn14qSXYeGaNrT9SX5g=;
 b=ZFm0+ustlkpfCTNcFnehGmYK3KiSQLs3XO5Yh47+zRLK74fD6eL/cDIlwfBTf60si8T1jrVZI3I4uqK/YTZZsRM3DHsfnowDNKR/hZ6gb009mSS2PfUQxEif4fwglkr73OvDe7KCgX4/7sYow0zRE0WIN8KN01Ve9Py2SNfTrrSowZoTr4ioFQ+3ThCAaaR3VEhDBDqua0d0ZeT9nu2B666kxGJyslpqF7quF18wTMpqo6tklflNSEOmL3O9zbZZGVGiebVYFyStVzb2iETjLM5zHg00/LehzdbXbNd1hNeYaSjailps5IP4gcen7EmhLnndTrmykHvXvWxVCW3Prg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcpuBXYzmR/BWLeWLNXe9sAKgn14qSXYeGaNrT9SX5g=;
 b=FSl5RF1ZxXMQQ9n7kwCHtp/JAiEyXAY06De9YFAy8S2sp9T+N+IpYtv6TPpFkRHHWNtGjEcbjlagj74QqgBmFtVolxGJGr0Npv3i0+LQKcRKLiMvNceQP4ymZX3mS02RkwUyIwJDG+MYEkZ0hKWnoKGx2LOie/1qILCzjwWKkL4=
Received: from AM7PR83MB0418.EURPRD83.prod.outlook.com (2603:10a6:20b:1be::11)
 by AM7PR83MB0435.EURPRD83.prod.outlook.com (2603:10a6:20b:1be::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.1; Sat, 24 Jun
 2023 10:28:42 +0000
Received: from AM7PR83MB0418.EURPRD83.prod.outlook.com
 ([fe80::37fe:4e6:d28d:fa51]) by AM7PR83MB0418.EURPRD83.prod.outlook.com
 ([fe80::37fe:4e6:d28d:fa51%3]) with mapi id 15.20.6544.006; Sat, 24 Jun 2023
 10:28:42 +0000
From:   Premek Vysoky <Premek.Vysoky@microsoft.com>
To:     "phillip.wood@dunelm.org.uk" <phillip.wood@dunelm.org.uk>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: git apply fails with 'error: git apply: failed to
 read: No such file or directory'
Thread-Topic: [EXTERNAL] Re: git apply fails with 'error: git apply: failed to
 read: No such file or directory'
Thread-Index: Adml0C0BoV7g9ueIRD6rtF+KvPKsBAAs6/QAAACWLaA=
Date:   Sat, 24 Jun 2023 10:28:42 +0000
Message-ID: <AM7PR83MB041804AFB4F0F8E850C51039EA20A@AM7PR83MB0418.EURPRD83.prod.outlook.com>
References: <AM7PR83MB04183860D4E70F935319E9B9EA23A@AM7PR83MB0418.EURPRD83.prod.outlook.com>
 <fff79e55-cf35-b5ca-6208-dfa7234be33d@gmail.com>
In-Reply-To: <fff79e55-cf35-b5ca-6208-dfa7234be33d@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=bcbfb758-825b-47eb-b2f2-722fa01ab903;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-24T10:25:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR83MB0418:EE_|AM7PR83MB0435:EE_
x-ms-office365-filtering-correlation-id: 15a75a22-e47f-47fc-7367-08db749dc855
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fcvPWQeCwrLbymh1tO+ug5pLeb/LOaQCswAAXJX7unCjTMuey4RT+r5JbUXY5Q/m/OppqPwrv4wdSxuuIHunGaiNabmF0aV54amxtbz71RuS/H9cW6a68r5+fPnhft5dFSe7A0WS8D11aOFv9sKuSFPNlH9FL/j9kxrklHcLYiVb6m1DX7L3nCquqXQ8Hl5Opu19yzqYr8xNRwkWSh0TLYdhwtKrH3ubvFZqhL86lN1xNrhvnDEZePLjuCT81gGuitCUnRh4BRQRwONmodrTumkyW5eFfTQ3aZpn7PpzouArwWjensq60HHvZaUUUGW3FVdv6KrdP8IGgVSf/pw0tr2kNhabRcozTeUz1HxJyXrLaVPx6EUQ3Tcgc81MkjOgsSosTLWPcbJTsCfSmbSw7LoZxAFn1cIljYkPZigGdxetjPvSzwbtjvV4rzED7/YIC3k3SV9jdyrTjTsv3hMUfVLptpztIAequdk1Y7OBIJCldVoIYT95wJQocwcHRhn7+YkFEWEeUWlncTfmR62NFBKUCa5VEG4moZcd0Y/YJxb5twAMX3xi/OkNzJEzJ40pbNNLlxoWA5VxSfscQ3Ik5NIIfXa9Qprs+jj3DL3kc/DNUz3zkNBDn8qQYMZfbPzNFvZF71zLVXESc0c5e7+FA8egj9fZzbrYpC7h2riM8joKo4o9jbTWui4j2UWxPtEa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR83MB0418.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(451199021)(4001150100001)(7696005)(38100700002)(71200400001)(82950400001)(82960400001)(122000001)(83380400001)(6506007)(186003)(9686003)(53546011)(966005)(55016003)(41300700001)(110136005)(38070700005)(8990500004)(86362001)(10290500003)(478600001)(2906002)(316002)(66556008)(66476007)(64756008)(33656002)(66446008)(66946007)(76116006)(52536014)(5660300002)(8676002)(8936002)(460985005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dfJjlyfvU1bRDwSbu3usIZ2lkLQqqUo052D0ZZl1BYcv3COo0XxP7oCEqtCv?=
 =?us-ascii?Q?V0amp1YJVnWicEZ7e9B05Iw/k1es7ADVu7sBEYZMi2/SOtoglde6ZQOQTPiA?=
 =?us-ascii?Q?y0PdJW1+ea7+BdpY0Tiw90m/pzkqTdwTCqHXfRav7TYa0Tr6fsHEkqCz/5Pn?=
 =?us-ascii?Q?V5ab6IltjViP67Prza22/6QhWPLL76x89TJ3+hT7hMF8l6ZxdELXFxupsdqL?=
 =?us-ascii?Q?uEeAlh9/0gclO+NESVqz0fRtep8O4PZKJNi0+Kynhwy+mTCrMGxAbcHvp6TF?=
 =?us-ascii?Q?l7ofrxbTpuvX8R2ctmXv+UKr58DLWySXcwDXMw+U/cRt25kYjpL/aSXj+xop?=
 =?us-ascii?Q?+uws0Zvy7If4AHvE5ravYPGqhmlM3oc8d7YoiSKtr7o/9WaoQ9iMahWm0i+0?=
 =?us-ascii?Q?PWufPQ4xG03tDzKG8AYNjSgRLKHHqw3OSrF4IEShSas6SgdoTcR9qUUeDvUg?=
 =?us-ascii?Q?xw+pzCRwur4UjxgYp6RijtqaEz4x3v1LtfqHZhNnFMCXKRAtSz386VItdWAc?=
 =?us-ascii?Q?NzM31IxlPCl2kA9eEru2a4SI7i74WO6Wf/hMO7pjMKIGWhY5cRog8IxC+1cr?=
 =?us-ascii?Q?L25piIuosixZ4jb6OE7HrplMRTKo+JMf87mc1TAlerN4/rJcK3nitHwxfRR5?=
 =?us-ascii?Q?mIdrQeeAISPU8wlL5n1WLZ34Xwz9Hr4ape0C2eskZ2xO9iPINF8ahcCyuiPE?=
 =?us-ascii?Q?bwSFV0IdQfZAEqBpUEJIeSSnEuTED+muHIJMfefbj134neOUr9xdIoLzk32J?=
 =?us-ascii?Q?+apoo5WXml1Trf/69p77glEAxMuutVFSh7ZirwbB8aO9T0MlQ4D2cJ+mLhRR?=
 =?us-ascii?Q?l787UV79RZevWf+pOhxVvqzEMbBBNW97BH5blxWHBRnOwSkoxUwDlqGta9s0?=
 =?us-ascii?Q?bZIiMN1uAKuQA1oEWqQ8aaaszijIZzdJzqyq4+N86tucnFJ25rPozcSo4ytU?=
 =?us-ascii?Q?5tPA1NP/zhvtyeBEqegHQ1IgHeORbb1SfjppyWukcsy8/Zo6Rj5vjkm/ujgu?=
 =?us-ascii?Q?lreTWWtMgGsWqj8QZG0ZDF1VQU7eyrB1+zQGy8J0O+CKgFhUUqPavV5AuvPC?=
 =?us-ascii?Q?LAG1Uqe5T9B8VT/ONYcGU5FJXEgJr+nwUsxyYEkGAva4mE7jrsYLACUCa35V?=
 =?us-ascii?Q?HiV4vt+arGecBhObXIGDOt2ttJcPWNaURc1jAPi9sihkGJyFuI5swiY+JmOm?=
 =?us-ascii?Q?/j5XeTnQbIWfwrijCpmGuS5uEDHqa2era0Ric5YTvwl6Ujx4Whoy0nAuGEys?=
 =?us-ascii?Q?RmMpqAekum1mFgE/ck8IRxQ8ki0F1ULg+ta9vsfUD8WW4QScGJti0DKHHZss?=
 =?us-ascii?Q?cFgXvsh/cfAX7N2kcA6MGRZF86oIBSnaLyjYUpoiglbZ2hzArk6HcQYIV0Jr?=
 =?us-ascii?Q?bPrDPG49FuBdoM1KvgeFDu1loaCohyniI+t8s+6g0GSaGFIX1ICyHINFd7Hd?=
 =?us-ascii?Q?amvSaU7onbAyRcQLKI8kwjGobwhm9XWAbDFNXJtvaGARLNYr0kuogATlkGtP?=
 =?us-ascii?Q?wL/WTHoD9PhxCC4d0iyrD/88O84omsdjJml8kOw+FZdi3ptvZYmHpwhWGWLl?=
 =?us-ascii?Q?geEhqoRA70POEibMYKxt257s7BIJ4nAobH6ALg14JIhL+e8+iOmuOqwTevu9?=
 =?us-ascii?Q?iNBpIt4ECAuOdsKKMBxXgZiYZUVpUlcCdvinCp6xnCjz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR83MB0418.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a75a22-e47f-47fc-7367-08db749dc855
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2023 10:28:42.2664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hYRmgmOF+jFCgcdutnvLxsY0zEMfcFFklRGYTE9Q0UHKxxC+Qw4OIkO6fF2BnHTZ614ZG7U3BeaSEwr5rIb+Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR83MB0435
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

Thanks for the fast response! And thanks for the improvement if you decide =
to make this more obvious.
I must have used an older git version earlier as I was able to process even=
 3GB patches easily.

Too bad there is no override for this..
(we're working on a .NET monorepo - https://github.com/dotnet/dotnet - so o=
ne of a kind, and we hit these limits at times)

Cheers,
Premek


-----Original Message-----
From: Phillip Wood <phillip.wood123@gmail.com>=20
Sent: Saturday, June 24, 2023 12:09 PM
To: Premek Vysoky <Premek.Vysoky@microsoft.com>; git@vger.kernel.org
Subject: [EXTERNAL] Re: git apply fails with 'error: git apply: failed to r=
ead: No such file or directory'

Hi Premek

Thanks for taking the time to report this issue

On 23/06/2023 13:42, Premek Vysoky wrote:
> What did you do before the bug happened? (Steps to reproduce your=20
> issue) git clone=20
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgith
> ub.com%2Fdotnet%2Fllvm-project&data=3D05%7C01%7CPremek.Vysoky%40microsof
> t.com%7Ca9684566250842b65be608db749b030b%7C72f988bf86f141af91ab2d7cd01
> 1db47%7C1%7C0%7C638231981398613951%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7
> C&sdata=3DprrT8WKHGtvll2XG%2FKSrxSOplev6eLjjeBGu%2FRQzOMg%3D&reserved=3D0
> git -C llvm-project diff --patch --binary --output ../llvm.patch 4b825dc6=
42cb6eb9a060e54bf8d69288fbee4904..30e9e6bc2e9f04e0a75daf4b8088ee91f66069da =
-- ':(glob)**/*' ':(exclude,glob)**/*.dll' ':(exclude,glob)**/*.Dll' ':(exc=
lude,glob)**/*.exe' ':(exclude,glob)**/*.pdb' ':(exclude,glob)**/*.mdb' ':(=
exclude,glob)**/*.zip' ':(exclude,glob)**/*.nupkg'
> mkdir foo
> git -C foo init
> git -C foo apply --cached --ignore-space-change ../llvm.patch
>
> What did you expect to happen? (Expected behavior) Patch should be=20
> created and applied to another folder
>
> What happened instead? (Actual behavior) git apply fails with 'error:=20
> git apply: failed to read: No such file or directory'
> (and returns 128)

This stems from commit f1c0e3946e (apply: reject patches larger than ~1 GiB=
, 2022-10-25). Unfortunately it does not provide a very helpful error messa=
ge. I'll submit a patch later to fix that in the next few days.

Best Wishes

Phillip

> What's different between what you expected and what actually happened?
> There is no error. I tried -v, --reject etc but wasn't able to get any de=
tails.
>
> Anything else you want to add:
> This happens in both Windows and Linux environments.
>
> I tried analyzing file handlers via procmon.exe and could not see anythin=
g. git reads the whole patch and then shuts down. No indication of a file i=
t is trying to open.
>
> I tried excluding more files from the patch and then I was able to create=
/apply the patch, like so:
>
> git -C llvm-project diff --patch --binary --output ../llvm.patch 4b825dc6=
42cb6eb9a060e54bf8d69288fbee4904..30e9e6bc2e9f04e0a75daf4b8088ee91f66069da =
-- ':(glob)**/*' ':(exclude,glob)**/*.dll' ':(exclude,glob)**/*.Dll' ':(exc=
lude,glob)**/*.exe' ':(exclude,glob)**/*.pdb' ':(exclude,glob)**/*.mdb' ':(=
exclude,glob)**/*.zip' ':(exclude,glob)**/*.nupkg' ':(exclude,glob)bolt' ':=
(exclude,glob)clang/docs' ':(exclude,glob)clang/www' ':(exclude,glob)flang'=
 ':(exclude,glob)libclc' ':(exclude,glob)lldb' ':(exclude,glob)llvm/docs' '=
:(exclude,glob)mlir' ':(exclude,glob)openmp' ':(exclude,glob)polly' ':(excl=
ude,glob)pstl' ':(exclude,glob)third-party' ':(exclude,glob)**/tests/**'
>
> But if I do the opposite and create a patch with only the previously excl=
uded files, I'd expect that it breaks. But this works as well!
>
> git -C llvm-project diff --patch --binary --output ../llvm.patch 4b825dc6=
42cb6eb9a060e54bf8d69288fbee4904..30e9e6bc2e9f04e0a75daf4b8088ee91f66069da =
-- ':(glob)bolt' ':(glob)clang/docs' ':(glob)clang/www' ':(glob)flang' ':(g=
lob)libclc' ':(glob)lldb' ':(glob)llvm/docs' ':(glob)mlir' ':(glob)openmp' =
':(glob)polly' ':(glob)pstl' ':(glob)third-party' ':(glob)**/tests/**' ':(e=
xclude,glob)**/*.dll' ':(exclude,glob)**/*.Dll' ':(exclude,glob)**/*.exe' '=
:(exclude,glob)**/*.pdb' ':(exclude,glob)**/*.mdb' ':(exclude,glob)**/*.zip=
' ':(exclude,glob)**/*.nupkg'
>
> Only when they are together, git fails. Size of the patch is 1GB but I've=
 had 3GB patches apply successfully before.
>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>
>
> [System Info]
> git version:
> git version 2.41.0.windows.1
> cpu: x86_64
> built from commit: ff94e79c4724635915dbb3d4ba38f6bb91528260
> sizeof-long: 4
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> uname: Windows 10.0 22621
> compiler info: gnuc: 13.1
> libc info: no libc information available $SHELL (typically,=20
> interactive shell): <unset>
>
>
> [Enabled Hooks]
> not run from a git repository - no hooks to show
