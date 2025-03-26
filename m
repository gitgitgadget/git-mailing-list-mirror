Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8301DF72C
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 12:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742991623; cv=none; b=mJRF27KXnRh5tFcNmBDio4MjhQaP6BMX89a79S92wgx5bmVZq/A5jvanX7/4Ouffm8t1Xf5XV3N7ZDaU48jeEVqHsCAWpGEmSASbDg1qO1Wgz0kIpbKZ4TBYM39dSdXFL5M0EVXYzU1CbWFkjilPfI+wxZ3ir3qgJZYN4ugUWcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742991623; c=relaxed/simple;
	bh=g+DpdFq4REBCcmKvMBtbXhWwYz/IHS8f2wDhIrMpOa8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qz+nagKFu/n6PAJToUPpsBJyGJobX9qPbro/sfyvytFsrVC6r3Pccm2TPvz4XYP7tIx+HkynJ0QRKXSgpVe9YsYXh/HMA+SIkI8oIyKoygT0pOy9swNRTkjqRBewd0Yr1H2MLzL2WDeYQBMcdS9xXOattd4VA0QkoTefmSGz6gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=OH9x0LjD; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="OH9x0LjD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1742991613; x=1743596413;
	i=johannes.schindelin@gmx.de;
	bh=iRxmwS/jGS1rCwTXYa4chy16aWA8gHupE1zWqh3traQ=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OH9x0LjDJE9+6lZ+WW5FN4TjINWP4TyPjjnwJ7YWY4wqpfUmQvU2rIofX2aC8npW
	 HBr/vMxw9UfP7tyIenmpmdDbDOFMCZGIxR9EQoyuWERpifbatdU5gDnbUjicTMm0a
	 x2M58Dx3yHgAVUacHXGhaYUolYSqMdZR8uyQasVFn6cEYxH+CEAcaflIBa+L/1au2
	 61zpZfMTPx+L3VaXUPpqvTfI+yZueRZ82mjub/EA90tWBc7tAGhLoAspPObv2257O
	 hRDV+90UNYiEbiZkfnQqDDQEUjczdMIULM5lLd/WwvXcctuQfNHWPzdh6sAdNbIAN
	 p808VavwHPdgPVUPrA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.156]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2E1M-1t0LEA3uoA-0155rZ; Wed, 26
 Mar 2025 13:20:12 +0100
Date: Wed, 26 Mar 2025 13:20:12 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>, 
    Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] compat/mingw: fix EACCESS when opening files with
 `O_CREAT | O_EXCL`
In-Reply-To: <20250320-b4-pks-mingw-lockfile-flake-v2-2-a84c90cfc6c2@pks.im>
Message-ID: <d149a082-cef7-3fe9-f9ce-6a4588cc3d1c@gmx.de>
References: <20250320-b4-pks-mingw-lockfile-flake-v2-0-a84c90cfc6c2@pks.im> <20250320-b4-pks-mingw-lockfile-flake-v2-2-a84c90cfc6c2@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:6vWYmO0OSSGV++FlWvKoam/YGfKy/1MTGoS9J4knSRDbDVV+KCU
 DoAkzkkzoNY9PsKvIYdWAcTL7YRVdiHzSnmIO/2iAup/LWye6UWHLxRB1mAqM3BgqzKXyby
 HcDnB4ecsDzgHprQPF9F6iPLNQOfMtsxZyUgX2SOjAWAVU0rCR7YS1zcUo7r110peti9LuC
 apFs4y9HBLXQGh05q8PNw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:M+6m+R1xiCA=;0kuMjNro4QU+scA5zFzAx55+wv6
 6ogRdmPoMyJIQfvwKAtfbDjGtYWQkU0BIjn9yLPkC9FCF7VCQ+OqfWqYLLLl1UsXBki8cFvTp
 5dvf4kCmYF2wGUUwMTnJoeAcyh9VDYAbK8oajExG2KkX3dwFsG74Yf6Fyy4OYa8heyPpvEy9z
 R+LdP2FwFApLk0sYTp+/MWpUx8Tblzpm7gs1PIqQaobFmooWQrTOseg9uiuSPRFMvVF995dhX
 P3jGFusd8TGM3bOgw8bcaGRRt2OiqHg/ovvyd7rM4IPyD4IR9453Nm/zRXlNrZj496E3evlPR
 YP4D7w8IQm7MK7Yh2D4Enkq7v0mtf3+iB7cXf3KIAL7CL9lfHDFtwFPr6w5m/MaeWIOnVeEn7
 ibHA3y7dP4DVRkcyEYJRdgDkDt7IUp0ni7iTPYRXAd2Ytav2l91eebvTtXmeFfNZPRf8TyPQ8
 UIUCMG1zZnGfqQJ7sMgkb/0mFIwSIw0rCOgIwxiV7azfCX4qyjwFerfCK04ToGoVs+IqH/VJ1
 Uaq4Ah5Etl2BTOqrBkuVtn8QQ6QVU03dPNg7CGXR0R7Ez4keVrRX84+KrRKrkrCcO4K0cE+PS
 rUug0YA0ndiXKn+ErZMJEgR9+Hi5/Vt+o6vLGw9aNBwUTJ2hmntBBK+necSkwyNVSMLMtJEdG
 rgBtl5cvmxLcK5z+4ypwzCFmKHVgatZ1fAupv8fFKfBPEDszRYiWl8dMesFuMJrRQbwqwcqbZ
 R3w1GBx8TiBIYF0W0i04ADBCQLCI5dbYxUyYVOzcVYPPejneHnVCKfi/YOB/T3iVQ6TIoQWbW
 9FtfF+VTqaDoHcAGA3puHEmCLRi0sYI3kcA85v0RZMRvapTEjP7wBQtMCyguyAIzduczPcL5U
 0dJp+id0Ug8ZTufUGUAWoku0C0+i+Eqh8hF4iZXaRESodNFGWE1CDllJHHfErpCitA9M9Lt/m
 O4q0syAKbSQQKBeO/PZKlx++TapPuvra39DtVHkYHFnqNoRD5/itLzBvAFP663TYGPcz039rf
 OapsR9wQLjByDarvNpn1JIGzyZ8mwkny771x32NNyXXYkaFuqwVR9iwRfL76nQsBUehBRn8eD
 U/vW4kqIJ9UadiYof8Qi/PMeDzE0VaAmyflSP1nSMfZaXzm2VFwT0bh9SkFePptnnwPaxizxp
 oVDlax4aP/yHSzDaHuNe/hWL6PzZzKFIn2wGyUwYkh+zCwci9IZad2SOdvQA56Zjb/uKtb6ao
 s0fOAcmXLlIr+iL38Vh9Y6rnZ9NEjhWE7IRsUjYjS1qTUBJyxQKT62bVDx1yG8q67MOPvQLJ5
 LHXBFkDBhC9joB5uyFZIo0/9bCSfc8T7DX3dLrzShAflpcF/9nIoj/L3K/ATJpooC8402M2+B
 0RZDn85DSdGrEmz9VoCaptyD4yKfyef7AENw1Yb0Cfj+gQATYwP+nUATolfOy6ljmmkrQeyqS
 ZnfTQT+FpCUH8z6bOLt7fh0vm8bO5I0jsZeNkZsYL+jIUB150
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Thu, 20 Mar 2025, Patrick Steinhardt wrote:

> In our CI systems we can observe that t0610 fails rather frequently.
> This testcase races a bunch of git-update-ref(1) processes with one
> another which are all trying to update a unique reference, where we
> expect that all processes succeed and end up updating the reftable
> stack. The error message in this case looks like the following:
>
>     fatal: update_ref failed for ref 'refs/heads/branch-88': reftable: t=
ransaction prepare: I/O error
>
> Instrumenting the code with a couple of calls to `BUG()` in relevant
> sites where we return `REFTABLE_IO_ERROR` quickly leads one to discover
> that this error is caused when calling `flock_acquire()`, which is a
> thin wrapper around our lockfile API. Curiously, the error code we get
> in such cases is `EACCESS`, indicating that we are not allowed to access
> the file.
>
> The root cause of this is an oddity of `CreateFileW()`, which is what
> `_wopen()` uses internally. Quoting its documentation [1]:
>
>     If you call CreateFile on a file that is pending deletion as a
>     result of a previous call to DeleteFile, the function fails. The
>     operating system delays file deletion until all handles to the file
>     are closed. GetLastError returns ERROR_ACCESS_DENIED.
>
> This behaviour is triggered quite often in the above testcase because
> all the processes race with one another trying to acquire the lock for
> the "tables.list" file. This is due to how locking works in the reftable
> library when compacting a stack:
>
>     1. Lock the "tables.list" file and reads its contents.
>
>     2. Decide which tables to compact.
>
>     3. Lock each of the individual tables that we are about to compact.
>
>     4. Unlock the "tables.list" file.
>
>     5. Compact the individual tables into one large table.
>
>     6. Re-lock the "tables.list" file.
>
>     7. Write the new list of tables into it.
>
>     8. Commit the "tables.list" file.
>
> The important step is (4): we don't commit the file directly by renaming
> it into place, but instead we delete the lockfile so that concurrent
> processes can continue to append to the reftable stack while we compact
> the tables. And because we use `DeleteFileW()` to do so, we may now race
> with another process that wants to acquire that lockfile. So if we are
> unlucky, we would now see `ERROR_ACCESS_DENIED` instead of the expected
> `ERROR_FILE_EXISTS`, which the lockfile subsystem isn't prepared to
> handle and thus it will bail out without retrying to acquire the lock.
>
> In theory, the issue is not limited to the reftable library and can be
> triggered by every other user of the lockfile subsystem, as well. My gut
> feeling tells me it's rather unlikely to surface elsewhere though.
>
> Fix the issue by translating the error to `EEXIST`. This makes the
> lockfile subsystem handle the error correctly: in case a timeout is set
> it will now retry acquiring the lockfile until the timeout has expired.
>
> With this, t0610 is now always passing on my machine whereas it was
> previously failing in around 20-30% of all test runs.
>
> [1]: https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-file=
api-createfilew

Couldn't we simply handle `EACCES` the same way as `EEXIST` in step 4?

This suggestion is different from v1, which would have affected all
callers of `mingw_open()`.

The reason I ask is that `RtlGetLastNtStatus()` is undocumented, and
should therefore not be used. I know that I will be tasked with removing
that call should it be introduced into Git's source code, and naturally
I'd like to avoid that.

I know that e.g. PostgreSQL used this undocumented function at least at
some stage, but SQLite avoided it by introducing a simple poll strategy.
We could also do that, but if there is already code in the reftable
library that skips doing things if a `.lock` file exists, then doing the
same if the `.lock` file cannot be created, too, should be a safe argument
to make.

Ciao,
Johannes

>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  compat/mingw.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index f524c54d06d..50c80b1b750 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -21,6 +21,9 @@
>  #include "gettext.h"
>  #define SECURITY_WIN32
>  #include <sspi.h>
> +#include <winternl.h>
> +
> +#define STATUS_DELETE_PENDING ((NTSTATUS) 0xC0000056)
>
>  #define HCAST(type, handle) ((type)(intptr_t)handle)
>
> @@ -621,6 +624,8 @@ int mingw_open (const char *filename, int oflags, ..=
.)
>  	wchar_t wfilename[MAX_PATH];
>  	open_fn_t open_fn;
>
> +	DECLARE_PROC_ADDR(ntdll.dll, NTSTATUS, NTAPI, RtlGetLastNtStatus, void=
);
> +
>  	va_start(args, oflags);
>  	mode =3D va_arg(args, int);
>  	va_end(args);
> @@ -644,6 +649,21 @@ int mingw_open (const char *filename, int oflags, .=
..)
>
>  	fd =3D open_fn(wfilename, oflags, mode);
>
> +	/*
> +	 * Internally, `_wopen()` uses the `CreateFile()` API with CREATE_NEW,
> +	 * which may error out with ERROR_ACCESS_DENIED and an NtStatus of
> +	 * STATUS_DELETE_PENDING when the file is scheduled for deletion via
> +	 * `DeleteFileW()`. The file essentially exists, so we map errno to
> +	 * EEXIST instead of EACCESS so that callers don't have to special-cas=
e
> +	 * this.
> +	 *
> +	 * This fixes issues for example with the lockfile interface when one
> +	 * process has a lock that it is about to commit or release while
> +	 * another process wants to acquire it.
> +	 */
> +	if (fd < 0 && create && GetLastError() =3D=3D ERROR_ACCESS_DENIED &&
> +	    INIT_PROC_ADDR(RtlGetLastNtStatus) && RtlGetLastNtStatus() =3D=3D =
STATUS_DELETE_PENDING)
> +		errno =3D EEXIST;
>  	if (fd < 0 && (oflags & O_ACCMODE) !=3D O_RDONLY && errno =3D=3D EACCE=
S) {
>  		DWORD attrs =3D GetFileAttributesW(wfilename);
>  		if (attrs !=3D INVALID_FILE_ATTRIBUTES && (attrs & FILE_ATTRIBUTE_DIR=
ECTORY))
>
> --
> 2.49.0.472.ge94155a9ec.dirty
>
>
