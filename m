Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB9B520401
	for <e@80x24.org>; Mon, 12 Jun 2017 22:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752607AbdFLWEn (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 18:04:43 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34972 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752525AbdFLWEm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 18:04:42 -0400
Received: by mail-pf0-f194.google.com with SMTP id s66so3176886pfs.2
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 15:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tKQzRDeDbcEuX6zD9FVOBd2/aRPngZ1HIQalDwXGhyA=;
        b=ovlKIF46954p6euUycKp+JGgfLMeKwTFbEV4+J4qAteqUaBwwqM5+keLUP36C4hI1I
         K2h9mNxPwNJ3IYxf5H88C1HmOxFNFrI3t+tQx6ipzARmYgXuZbJfdAUC48BvgA255soU
         UW6dkU6/b63YmJs8vFRziVGOf3xRUNMdaj3+up1WSDd/4zJL65dbPZdoJGU3wMvSXQ0S
         WLt/mLicXw+PRGuNdktRbZrhScGyIruast3rHXoPL2ogQD+iSNTyiB0yTI+t0Il91uRZ
         1ObAMyILXsYcwZmG6xODtz0aRGhsGEvfSVemNwWmLu3STI5IHYWHIBh1c0yg5GmtZ4ZB
         oY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tKQzRDeDbcEuX6zD9FVOBd2/aRPngZ1HIQalDwXGhyA=;
        b=JdQREhg4oUPrJaznIIpoa9KKsR5DPBg1LROZCgAZPxLqMAmyRj4kYHTuW+YjT38e3l
         X2k9b0ZPeq6m4F9m6Y/zcZpt36ATqamispCu9tAVQ2VuawOIE+ULZRCvEBrlTjRtA1/l
         0V4KC+W20QOytzzp9GOJzcdoomcPzuVqC4+9Luvks1Utjna6Z0/ov7fWVK4+aYQtj7tl
         /4RzVnJIlDdUPBLy1u0xaOfYQOWQyW9GL0+Y2cQBVmyKS4hbUNDeOl7+bZppu63IuO4P
         GKCjkNITxEJ4uboiODBU9gAreswOCkZrVAqIb3hVXxoYKbAZXfD+w4WuiiqrzC4KlkIo
         4reQ==
X-Gm-Message-State: AODbwcCCjq/uhv0V/+6RHUvudRxbVuUS9NTfZpz0pBP4r0G9DXZNBVMg
        aFwp0WpRwMkuVQ==
X-Received: by 10.99.107.136 with SMTP id g130mr57552394pgc.3.1497305081425;
        Mon, 12 Jun 2017 15:04:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:695d:4129:fb97:59df])
        by smtp.gmail.com with ESMTPSA id s68sm24475596pfj.33.2017.06.12.15.04.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 15:04:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net, christian.couder@gmail.com, avarab@gmail.com
Subject: Re: [PATCH v5 7/7] fsmonitor: add a performance test
References: <20170610134026.104552-1-benpeart@microsoft.com>
        <20170610134026.104552-8-benpeart@microsoft.com>
Date:   Mon, 12 Jun 2017 15:04:39 -0700
In-Reply-To: <20170610134026.104552-8-benpeart@microsoft.com> (Ben Peart's
        message of "Sat, 10 Jun 2017 09:40:26 -0400")
Message-ID: <xmqqo9tsn9qg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> diff --git a/t/helper/test-drop-caches.c b/t/helper/test-drop-caches.c
> new file mode 100644
> index 0000000000..80830d920b
> --- /dev/null
> +++ b/t/helper/test-drop-caches.c
> @@ -0,0 +1,107 @@
> +#include "git-compat-util.h"
> +#include <stdio.h>

I thought compat-util should already include stdio?

> +
> +typedef DWORD NTSTATUS;

Is this safe to have outside "#ifdef GIT_WINDOWS_NATIVE"?

> +
> +#ifdef GIT_WINDOWS_NATIVE
> +#include <tchar.h>
> +
> +#define STATUS_SUCCESS			(0x00000000L)
> +#define STATUS_PRIVILEGE_NOT_HELD	(0xC0000061L)
> +
> +typedef enum _SYSTEM_INFORMATION_CLASS {
> +	SystemMemoryListInformation = 80, // 80, q: SYSTEM_MEMORY_LIST_INFORMATION; s: SYSTEM_MEMORY_LIST_COMMAND (requires SeProfileSingleProcessPrivilege)

I would have said "Please avoid // comment in this codebase unless
we know we only use the compilers that grok it".  This particular
one may be OK, as it is inside GIT_WINDOWS_NATIVE and I assume
everybody on that platform uses recent GCC (or VStudio groks it I
guess)?

> +} SYSTEM_INFORMATION_CLASS;
> +
> +// private
> +typedef enum _SYSTEM_MEMORY_LIST_COMMAND
> +{

Style: '{' comes at the end of the previous line, with a single SP
immediately before it, unless it is the beginning of the function body.

What you did for _SYSTEM_INFORMATION_CLASS above is correct.

> +	MemoryCaptureAccessedBits,
> +	MemoryCaptureAndResetAccessedBits,
> +	MemoryEmptyWorkingSets,
> +	MemoryFlushModifiedList,
> +	MemoryPurgeStandbyList,
> +	MemoryPurgeLowPriorityStandbyList,
> +	MemoryCommandMax

Style: avoid CamelCase.

> +} SYSTEM_MEMORY_LIST_COMMAND;
> +
> +BOOL GetPrivilege(HANDLE TokenHandle, LPCSTR lpName, int flags)
> +{
> +	BOOL bResult;
> +	DWORD dwBufferLength;
> +	LUID luid;
> +	TOKEN_PRIVILEGES tpPreviousState;
> +	TOKEN_PRIVILEGES tpNewState;
> +
> +	dwBufferLength = 16;
> +	bResult = LookupPrivilegeValueA(0, lpName, &luid);
> +	if (bResult)
> +	{

Style: '{' comes at the end of the previous line, with a single SP
immediately before it, unless it is the beginning of the function body.

> +		tpNewState.PrivilegeCount = 1;
> +		tpNewState.Privileges[0].Luid = luid;
> +		tpNewState.Privileges[0].Attributes = 0;
> +		bResult = AdjustTokenPrivileges(TokenHandle, 0, &tpNewState, (DWORD)((LPBYTE)&(tpNewState.Privileges[1]) - (LPBYTE)&tpNewState), &tpPreviousState, &dwBufferLength);
> +		if (bResult)
> +		{
> +			tpPreviousState.PrivilegeCount = 1;
> +			tpPreviousState.Privileges[0].Luid = luid;
> +			tpPreviousState.Privileges[0].Attributes = flags != 0 ? 2 : 0;
> +			bResult = AdjustTokenPrivileges(TokenHandle, 0, &tpPreviousState, dwBufferLength, 0, 0);
> +		}
> +	}
> +	return bResult;
> +}
> +#endif
> +
> +int cmd_main(int argc, const char **argv)
> +{
> +	NTSTATUS status = 1;
> +#ifdef GIT_WINDOWS_NATIVE
> +	HANDLE hProcess = GetCurrentProcess();
> +	HANDLE hToken;
> +	if (!OpenProcessToken(hProcess, TOKEN_QUERY | TOKEN_ADJUST_PRIVILEGES, &hToken))
> +	{
> +		_ftprintf(stderr, _T("Can't open current process token\n"));
> +		return 1;
> +	}
> +
> +	if (!GetPrivilege(hToken, "SeProfileSingleProcessPrivilege", 1))
> +	{
> +		_ftprintf(stderr, _T("Can't get SeProfileSingleProcessPrivilege\n"));
> +		return 1;
> +	}
> +
> +	CloseHandle(hToken);
> +
> +	HMODULE ntdll = LoadLibrary(_T("ntdll.dll"));
> +	if (!ntdll)
> +	{
> +		_ftprintf(stderr, _T("Can't load ntdll.dll, wrong Windows version?\n"));
> +		return 1;
> +	}
> +
> +	NTSTATUS(WINAPI *NtSetSystemInformation)(INT, PVOID, ULONG) = (NTSTATUS(WINAPI *)(INT, PVOID, ULONG))GetProcAddress(ntdll, "NtSetSystemInformation");

Is this "decl-after-stmt"?  Avoid it.

> +	if (!NtSetSystemInformation)
> +	{
> +		_ftprintf(stderr, _T("Can't get function addresses, wrong Windows version?\n"));
> +		return 1;
> +	}
> +
> +	SYSTEM_MEMORY_LIST_COMMAND command = MemoryPurgeStandbyList;
> +	status = NtSetSystemInformation(
> +		SystemMemoryListInformation,
> +		&command,
> +		sizeof(SYSTEM_MEMORY_LIST_COMMAND)
> +	);
> +	if (status == STATUS_PRIVILEGE_NOT_HELD)
> +	{
> +		_ftprintf(stderr, _T("Insufficient privileges to execute the memory list command"));
> +	}
> +	else if (status != STATUS_SUCCESS)
> +	{
> +		_ftprintf(stderr, _T("Unable to execute the memory list command %lX"), status);
> +	}
> +#endif
> +
> +	return status;
> +}

So status is initialized to 1 and anybody without GIT_WINDOWS_NATIVE
unconditionally get exit(1)?

Given that 'status' is the return value of this function that
returns 'int', I wonder if we need NTSTATUS type here.

Having said all that, I think you are using this ONLY on windows;
perhaps it is better to drop #ifdef GIT_WINDOWS_NATIVE from all of
the above and arrange Makefile to build test-drop-cache only on that
platform, or something?


> diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
> new file mode 100755
> index 0000000000..e41905cb9b
> --- /dev/null
> +++ b/t/perf/p7519-fsmonitor.sh
> @@ -0,0 +1,161 @@
> +#!/bin/sh
> +
> +test_description="Test core.fsmonitor"
> +
> +. ./perf-lib.sh
> +
> +# This has to be run with GIT_PERF_REPEAT_COUNT=1 to generate valid results.
> +# Otherwise the caching that happens for the nth run will negate the validity
> +# of the comparisons.
> +if [ "$GIT_PERF_REPEAT_COUNT" -ne 1 ]
> +then

Style: 

	if test "$GIT_PERF_REPEAT_COUNT" -ne 1
	then
	
> + ...
> +test_expect_success "setup" '
> +...
> +	# Hook scaffolding
> +	mkdir .git/hooks &&
> +	cp ../../../templates/hooks--query-fsmonitor.sample .git/hooks/query-fsmonitor &&

Does this assume $TRASH_DIRECTORY must be in $TEST_DIRECTORY/perf/?
Shouldn't t/perf/p[0-9][0-9][0-9][0-9]-*.sh scripts be capable of
running with the --root=<ramdisk> option?  Perhaps take the copy
relative to $TEST_DIRECTORY?
