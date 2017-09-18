Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 617332047F
	for <e@80x24.org>; Mon, 18 Sep 2017 18:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756578AbdIRST6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 14:19:58 -0400
Received: from mail-cys01nam02on0124.outbound.protection.outlook.com ([104.47.37.124]:60864
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756575AbdIRST4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 14:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=LImqapKO7r/bD9KNHmSLf/s0FFkBjU4GRaJmo75eP8U=;
 b=EYNXBR/5YFuzSizr+F6DGHLMNcVZA106RR+0CzmyNOUK0wsGXDYoXSGiD1IjbgpniJgn1kERMjq9Eo1SwsmFujd7Vr+hYJ5ZYgCaCv4q++md+qD9lNmQuGxjkRvYtsOBvkheWEBU/8VzavCcGDUhJyJaqDWXwcK+D2r4eCDdH58=
Received: from MWHPR21MB0478.namprd21.prod.outlook.com (10.172.102.17) by
 MWHPR21MB0783.namprd21.prod.outlook.com (10.173.51.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.98.0; Mon, 18 Sep 2017 18:19:54 +0000
Received: from MWHPR21MB0478.namprd21.prod.outlook.com ([10.172.102.17]) by
 MWHPR21MB0478.namprd21.prod.outlook.com ([10.172.102.17]) with mapi id
 15.20.0098.001; Mon, 18 Sep 2017 18:19:54 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
CC:     "David.Turner@twosigma.com" <David.Turner@twosigma.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "peff@peff.net" <peff@peff.net>
Subject: RE: [PATCH v6 12/12] fsmonitor: add a performance test
Thread-Topic: [PATCH v6 12/12] fsmonitor: add a performance test
Thread-Index: AQHTLlfdThNkbz7qzka8pLvFJ/GL+qK6twwAgAA9MbA=
Date:   Mon, 18 Sep 2017 18:19:54 +0000
Message-ID: <MWHPR21MB04789C11E37F58FF9BC11C51F4630@MWHPR21MB0478.namprd21.prod.outlook.com>
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <20170915192043.4516-1-benpeart@microsoft.com>
 <20170915192043.4516-13-benpeart@microsoft.com>
 <alpine.DEB.2.21.1.1709181615040.219280@virtualbox>
In-Reply-To: <alpine.DEB.2.21.1.1709181615040.219280@virtualbox>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Ref=https://api.informationprotection.azure.com/api/72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=benpeart@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2017-09-18T14:19:51.0390285-04:00;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [65.222.173.206]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR21MB0783;6:L93OHCHYcc2gfCGQTOYxBMRi7ivtv50NvsE/0yCeUDwBunSFeno2MAhhRuMOX2/tXzaeDhaJYl+i3y6ZFgJjQf7EBuYY7clsmr7QU5AF2TlElTVXvJVMCborH6p9Y6F1mhVLJVRUk/3DdnpNzM6JRhqdwpYd1ZMo0a9npdpz1KIF2eDg3mjvIXnefd2ANsRLjTtGQiUBQIfRTqU/93N9PRI0Kmm/yY2uGbohRjmrn8VjT4hnC17m5aKmWVnt0Pk4x5XpOouZKdXFFaD2446d84HkdqWeT+Sg86PjrmY1dmX56Dy+/dkLDJxvzqbxNV7xeijSWKZMM4FWj9b3c/iBVg==;5:NiHt9appvDOp4h3Cy4Ar3etlAaYGeKGoGkDuSiERlqCCDDmriJ9ucrEKDt59fcELOtVz3CqcQf5p90zMfyMFjO1tk8gfRrP+FFxmN3BKYNSqtn/umRnMl4XmnihEL9ciKLFHW9TYJ4FoXSZqmBfP1w==;24:rz38GtYUALQVMH/57KjQRzPLSIye1nDcn3KLsa7L9AZyiVh4Uq9yxEJhQCUWmtypUooBDDUAp5y/uYQFwaXr5BmjSRd6CMtDhacXpYH3VRA=;7:7hvGOxJZ6tdQalgveEm7VN/OiaadiQOzkYUs74uua1LKMw/bgg3h4dQD/GBZawvp83wa+IsstSp+SNT9dyeOZ7MlJQ2aYyHdEzcJ5GtoQAS2VkZtOf5JKww6icOMCMjlRfOvnibfEZHAvfk4yoOoNM2xXLaS4p5wSxZIerhvB/+OW00R4nPRbJ1FeJZQe2IjvNvqSr+K+kvLrmeQLE7Cf9Uj5n7zurnuKpcNcni2dd8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 4977efae-7a03-40c1-9674-08d4fec1dc40
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(48565401081)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:MWHPR21MB0783;
x-ms-traffictypediagnostic: MWHPR21MB0783:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-exchange-antispam-report-test: UriScan:(26323138287068)(89211679590171)(9452136761055)(189930954265078)(219752817060721)(100324003535756);
x-microsoft-antispam-prvs: <MWHPR21MB0783DBB8937124072DD78E49F4630@MWHPR21MB0783.namprd21.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(100000703101)(100105400095)(10201501046)(6055026)(61426038)(61427038)(6041248)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123564025)(20161123560025)(20161123555025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR21MB0783;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR21MB0783;
x-forefront-prvs: 04347F8039
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(39860400002)(376002)(346002)(47760400005)(377454003)(199003)(189002)(24454002)(13464003)(6436002)(189998001)(6506006)(6116002)(3846002)(93886005)(102836003)(2900100001)(9686003)(77096006)(2906002)(8666007)(6246003)(3280700002)(39060400002)(3660700001)(316002)(54906002)(55016002)(99286003)(68736007)(33656002)(6306002)(105586002)(5660300001)(14454004)(7736002)(86362001)(478600001)(2950100002)(575784001)(106356001)(7696004)(966005)(86612001)(305945005)(72206003)(6916009)(8936002)(10290500003)(76176999)(50986999)(54356999)(74316002)(10090500001)(53546010)(97736004)(229853002)(4326008)(53936002)(81166006)(81156014)(25786009)(8676002)(8990500004)(22452003)(66066001)(101416001)(8656003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0783;H:MWHPR21MB0478.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2017 18:19:54.2196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0783
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> -----Original Message-----
> From: Johannes Schindelin [mailto:Johannes.Schindelin@gmx.de]
> Sent: Monday, September 18, 2017 10:25 AM
> To: Ben Peart <Ben.Peart@microsoft.com>
> Cc: David.Turner@twosigma.com; avarab@gmail.com;
> christian.couder@gmail.com; git@vger.kernel.org; gitster@pobox.com;
> pclouds@gmail.com; peff@peff.net
> Subject: Re: [PATCH v6 12/12] fsmonitor: add a performance test
>=20
> Hi Ben,
>=20
> sorry for not catching this earlier:
>=20
> On Fri, 15 Sep 2017, Ben Peart wrote:
>=20
> > [...]
> > +
> > +int cmd_dropcaches(void)
> > +{
> > +	HANDLE hProcess =3D GetCurrentProcess();
> > +	HANDLE hToken;
> > +	int status;
> > +
> > +	if (!OpenProcessToken(hProcess, TOKEN_QUERY |
> TOKEN_ADJUST_PRIVILEGES, &hToken))
> > +		return error("Can't open current process token");
> > +
> > +	if (!GetPrivilege(hToken, "SeProfileSingleProcessPrivilege", 1))
> > +		return error("Can't get SeProfileSingleProcessPrivilege");
> > +
> > +	CloseHandle(hToken);
> > +
> > +	HMODULE ntdll =3D LoadLibrary("ntdll.dll");
>=20

Thanks Johannes, I'll fix that.

> Git's source code still tries to abide by C90, and for simplicity's sake,=
 this
> extends to the Windows-specific part. Therefore, the `ntdll` variable nee=
ds to
> be declared at the beginning of the function (I do agree that it makes fo=
r
> better code to reduce the scope of variables, but C90 simply did not allo=
w
> variables to be declared in the middle of functions).
>=20
> I wanted to send a patch address this in the obvious way, but then I
> encountered these lines:
>=20
> > +	DWORD(WINAPI *NtSetSystemInformation)(INT, PVOID, ULONG) =3D
> > +		(DWORD(WINAPI *)(INT, PVOID,
> ULONG))GetProcAddress(ntdll, "NtSetSystemInformation");
> > +	if (!NtSetSystemInformation)
> > +		return error("Can't get function addresses, wrong Windows
> > +version?");
>=20
> It turns out that we have seen this plenty of times in Git for Windows'
> fork, so much so that we came up with a nice helper to make this all a bi=
t
> more robust and a bit more obvious, too: the DECLARE_PROC_ADDR and
> INIT_PROC_ADDR helpers in compat/win32/lazyload.h.
>=20
> Maybe this would be the perfect excuse to integrate this patch into upstr=
eam
> Git?=20

This patch is pretty hefty already.  How about you push this capability
upstream and I take advantage of it in a later patch. :)

This would be the patch (you can also cherry-pick it from
> 25c4dc3a73352e72e995594cf1b4afa46e93d040 in
> https://na01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithub=
.
> com%2Fdscho%2Fgit&data=3D02%7C01%7CBen.Peart%40microsoft.com%7C96
> 4027bdc1f34a033c1f08d4fea1056e%7C72f988bf86f141af91ab2d7cd011db47
> %7C1%7C0%7C636413414914282865&sdata=3Djyvu6G7myRY9UA1XxWx2tDZ%
> 2BWsIWqLTRMT8WfzEGe5g%3D&reserved=3D0):
>=20
> -- snip --
> From 25c4dc3a73352e72e995594cf1b4afa46e93d040 Mon Sep 17 00:00:00
> 2001
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Tue, 10 Jan 2017 23:14:20 +0100
> Subject: [PATCH] Win32: simplify loading of DLL functions
>=20
> Dynamic loading of DLL functions is duplicated in several places in Git f=
or
> Windows' source code.
>=20
> This patch adds a pair of macros to simplify the process: the
> DECLARE_PROC_ADDR(<dll>, <return-type>, <function-name>,
> ...<function-parameter-types>...) macro to be used at the beginning of a
> code block, and the INIT_PROC_ADDR(<function-name>) macro to call before
> using the declared function. The return value of the INIT_PROC_ADDR() cal=
l
> has to be checked; If it is NULL, the function was not found in the speci=
fied
> DLL.
>=20
> Example:
>=20
>         DECLARE_PROC_ADDR(kernel32.dll, BOOL, CreateHardLinkW,
>                           LPCWSTR, LPCWSTR, LPSECURITY_ATTRIBUTES);
>=20
>         if (!INIT_PROC_ADDR(CreateHardLinkW))
>                 return error("Could not find CreateHardLinkW() function";
>=20
> 	if (!CreateHardLinkW(source, target, NULL))
> 		return error("could not create hardlink from %S to %S",
> 			     source, target);
> 	return 0;
>=20
> Signed-off-by: Karsten Blees <blees@dcon.de>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  compat/win32/lazyload.h | 44
> ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 compat/win32/lazyload.h
>=20
> diff --git a/compat/win32/lazyload.h b/compat/win32/lazyload.h new file
> mode 100644 index 00000000000..91c10dad2fb
> --- /dev/null
> +++ b/compat/win32/lazyload.h
> @@ -0,0 +1,44 @@
> +#ifndef LAZYLOAD_H
> +#define LAZYLOAD_H
> +
> +/* simplify loading of DLL functions */
> +
> +struct proc_addr {
> +	const char *const dll;
> +	const char *const function;
> +	FARPROC pfunction;
> +	unsigned initialized : 1;
> +};
> +
> +/* Declares a function to be loaded dynamically from a DLL. */ #define
> +DECLARE_PROC_ADDR(dll, rettype, function, ...) \
> +	static struct proc_addr proc_addr_##function =3D \
> +	{ #dll, #function, NULL, 0 }; \
> +	static rettype (WINAPI *function)(__VA_ARGS__)
> +
> +/*
> + * Loads a function from a DLL (once-only).
> + * Returns non-NULL function pointer on success.
> + * Returns NULL + errno =3D=3D ENOSYS on failure.
> + */
> +#define INIT_PROC_ADDR(function) \
> +	(function =3D get_proc_addr(&proc_addr_##function))
> +
> +static inline void *get_proc_addr(struct proc_addr *proc) {
> +	/* only do this once */
> +	if (!proc->initialized) {
> +		HANDLE hnd;
> +		proc->initialized =3D 1;
> +		hnd =3D LoadLibraryExA(proc->dll, NULL,
> +				     LOAD_LIBRARY_SEARCH_SYSTEM32);
> +		if (hnd)
> +			proc->pfunction =3D GetProcAddress(hnd, proc-
> >function);
> +	}
> +	/* set ENOSYS if DLL or function was not found */
> +	if (!proc->pfunction)
> +		errno =3D ENOSYS;
> +	return proc->pfunction;
> +}
> +
> +#endif
> -- snap --
>=20
> With this patch, this fixup to your patch would make things compile (you =
can
> also cherry-pick d05996fb61027512b8ab31a36c4a7a677dea11bb from my
> fork):
>=20
> -- snipsnap --
> From d05996fb61027512b8ab31a36c4a7a677dea11bb Mon Sep 17 00:00:00
> 2001
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Mon, 18 Sep 2017 14:56:40 +0200
> Subject: [PATCH] fixup! fsmonitor: add a performance test
>=20
> ---
>  t/helper/test-drop-caches.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
>=20
> diff --git a/t/helper/test-drop-caches.c b/t/helper/test-drop-caches.c in=
dex
> 717079865cb..b27358528f7 100644
> --- a/t/helper/test-drop-caches.c
> +++ b/t/helper/test-drop-caches.c
> @@ -1,6 +1,7 @@
>  #include "git-compat-util.h"
>=20
>  #if defined(GIT_WINDOWS_NATIVE)
> +#include "compat/win32/lazyload.h"
>=20
>  int cmd_sync(void)
>  {
> @@ -82,6 +83,9 @@ int cmd_dropcaches(void)
>  	HANDLE hProcess =3D GetCurrentProcess();
>  	HANDLE hToken;
>  	int status;
> +	SYSTEM_MEMORY_LIST_COMMAND command;
> +	DECLARE_PROC_ADDR(ntll,
> +			  DWORD, NtSetSystemInformation, INT, PVOID,
> ULONG);
>=20
>  	if (!OpenProcessToken(hProcess, TOKEN_QUERY |
> TOKEN_ADJUST_PRIVILEGES, &hToken))
>  		return error("Can't open current process token"); @@ -91,16
> +95,10 @@ int cmd_dropcaches(void)
>=20
>  	CloseHandle(hToken);
>=20
> -	HMODULE ntdll =3D LoadLibrary("ntdll.dll");
> -	if (!ntdll)
> -		return error("Can't load ntdll.dll, wrong Windows
>  		version?");
> -
> -	DWORD(WINAPI *NtSetSystemInformation)(INT, PVOID, ULONG) =3D
> -		(DWORD(WINAPI *)(INT, PVOID,
> ULONG))GetProcAddress(ntdll,
>  		"NtSetSystemInformation");
> -	if (!NtSetSystemInformation)
> +	if (!INIT_PROC_ADDR(NtSetSystemInformation))
>  		return error("Can't get function addresses, wrong Windows
> version?");
>=20
> -	SYSTEM_MEMORY_LIST_COMMAND command =3D
> MemoryPurgeStandbyList;
> +	command =3D MemoryPurgeStandbyList;
>  	status =3D NtSetSystemInformation(
>  		SystemMemoryListInformation,
>  		&command,
> @@ -111,8 +109,6 @@ int cmd_dropcaches(void)
>  	else if (status !=3D STATUS_SUCCESS)
>  		error("Unable to execute the memory list command %d",
> status);
>=20
> -	FreeLibrary(ntdll);
> -
>  	return status;
>  }
>=20
> --
> 2.14.1.windows.1.510.g0cb6d35d23
