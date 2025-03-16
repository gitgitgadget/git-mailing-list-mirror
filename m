Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B78F23BB
	for <git@vger.kernel.org>; Sun, 16 Mar 2025 00:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742083290; cv=none; b=Ol7tVMzfN7G2qh3n3CLaNa1Bm0bvN2pWNMXl4/V5IaX2d7bEt0rnVmr7T2ZXT9gWOPMQyRv71H+jMIUZtq+pqGSDGVOLgQaJl4v9JHlep+7vmpUAH6LWNE4mTX66ejcpvovTy2Y6qTsXxx0BTlprnAot1DN1/0qN3YPofWpsVW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742083290; c=relaxed/simple;
	bh=fNxKb5u2q5rroaAlO1dhIvvDLVm1O0xhBhFGFrsYAg8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=T8MyTPv2IqvXd0K3r/GFbF7YXt1d1c8z0TmAC4ZTa2trF3i5/ksb6Xj3bjbZe/rWoBDjWU9d2AjP7BNsyBCHHT70YGzf+F36XF1sM30ypR9JzNFP+mbypW610K+FBznzPlJ3f5+Z9aXe0BcKbd1sNtsK9PWrtMZ7jpJody+sw7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=Qq4GUFwi; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="Qq4GUFwi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1742083285; x=1742688085;
	i=johannes.schindelin@gmx.de;
	bh=q0CTeYLEnK0zQ96Ry3gnlEN3YhSO9XqWN0R/Wq/ERgY=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Qq4GUFwiA8SjCEuMJh4g6l4x3SoiieRIGxxtmI38A0pTuP1ZrfoHvWbZSxtzNs3J
	 dkxCIFCKNUTck9lWFhjr6tw6H/geeia/bam69wzpSGXtOu4XSpf23dEyJgaH/G0Ps
	 WN3lYVlXwr1JmBIcanWxqT/RM/Ey5Zj8WYW/X6EbKg7P5GUmAmXMqYDMvH2FLtPmd
	 acOIOIaLL2mbkPEW7wpykxu3V63XL2QcolKmT/Uu1wLL2Ut5RlYGl7hQRYgbSqYvo
	 4UfDFVIk/0V9/VVvQL1VHNpnNqdPRAKCZXD39Z4WNRTkDBR16ZJM2QJOx66sTyBUz
	 UTJITrXWKKO0znuV4Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.73]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1ML9uU-1tbWat31QA-00Uem3; Sun, 16
 Mar 2025 01:01:25 +0100
Date: Sun, 16 Mar 2025 01:01:25 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/2] compat/mingw: fix EACCESS when opening files with
 `O_CREAT | O_EXCL`
In-Reply-To: <20250313-b4-pks-mingw-lockfile-flake-v1-2-bc5d3e70f516@pks.im>
Message-ID: <239e4222-cdce-90b6-2a8b-ee48c3e024eb@gmx.de>
References: <20250313-b4-pks-mingw-lockfile-flake-v1-0-bc5d3e70f516@pks.im> <20250313-b4-pks-mingw-lockfile-flake-v1-2-bc5d3e70f516@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:iuMzA9bTe6BjeXayHL6MDcJdnM/lxW5wh/oGm/ytzOZmpF++uq9
 I5cU4NCktq71UupykFyju8t1IhHZEqtEwUvVXnZKrxLBXJJe+g/3qTS+oDgAl/KGcQMtmkr
 muh1eDEkAWkhs/c4EjDxGhnv+XPesr2CPDdcIr+ZnR9efHl3p822nbrWbIIUlKXkrA0AXdi
 PnRaRMG6fpkWkPhwEvmcA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EWvGNVuIE30=;KeMq/lhDBa3GAnmdRaarmpJsQZ5
 CbciqfF7VFalGj8Fs0+ein+gtJuf9/vtub8Y9F8qclPu3E7+kxxQkA8fFQiso3TbijeQufuZJ
 YAKl+dKGSdsWwCKg+xVV8SsLPqWv88KK1JsHxFxkS7VV6mUb6kEgM12zQ/Vzskdaha0JWMTRL
 MsGgd5wjFJFqY9Cg772r4E77z2f50uatnTSiy3gmbHjXsD7HDGZ/4e1hZheM/VRmpKTpYBPdz
 48Fs5MAZ3Susg0+lIg4U4k1wilF/hw4B4zRR23JBe2rwOhSPckMxkLw26DZJ0yxKPPMnw0Ji5
 JCMvVNbuPchKQ4qlQ+8sXlzmNZkF1mjAl2FlUSeqWlDJJKUOlIdPAKBCDqTiBjrdny2tXGgv2
 HSP+yfUj+jnU/7s02lLZQ7XjRgefQ19MOX9HGdzlNGRY65iB//WhjrDg+duWTMBsK5eBpFLOk
 pJKPtweUd0RogeDtl0sAxIPY7m1dJM7Eoz65sfXr/lA3T/Iq7RJpItszPQFOR4UAEmaIxJVSO
 c0m7Fo5sCWtiFoeBFw56/1g5xUhhfi5u6wDUwOY1tiI+RG6PyceflRKorpHOhWiHIbMfHBP/6
 JqoO/j4Yn+KjGZs6AU30DazXwIBaRIOu0hLzYtSRAhnsDOXw5zkAmB1erC8dXefqE92Xndo6h
 vkUlmO4Jqa0eWpw+13knldrJIOsbs2A8yFt/1ec2kPu6DzSO1Gs9r/2y1mvQ548BbPXT62CVk
 BkWS2CxV/PshlryIT5ANSG14Y8J0uVyoj16yIBatoUKpn2aqJizP36vLwKdnxPpgH3+XQPDJW
 rLqqOBNca3u3G8erJOzn01K1UuVu3c+4/ZUwD/juyfVBrkyBFUPwIBqzNWcjHzbWBSrogU3Y4
 zr9jrkFrufXDjBHqWm/TWmdXHf6g2qjXdDScwtU7gS9XE4BjviiUB/EDGAVhgePCKefVQ3AtZ
 I7Rf1iHKIiib1Mg2sy8ENsj3nQYxWXc5l9o1ybN/ixo3HD1d/R4cFf9FmV7tMt+N3TA8Tv8U2
 X2WIjPK6d4vAdFTYYgWbc9UCrkfDAh1fN17+Ex+hoh+ic0o78P6W/cK6wrZ/vBpn2vIcOukTG
 JuPTgEjMswTIS2x+ZGeY7ssy4hAZ8OLY9sI7wX67+72pSHN81wvZrQweFAWodTcigSUSicBFa
 Dn2WwVFO6YPRXXeL9S0v8jkmsBz62cSx3zyIU6xYpnHCXgmBgR8mExGORGNrDB4S+sfAaDJCS
 Nwa/2vFhvLpdZeVM0HBNkm9TZJUPstpAIlz3qtkKTEwmlp+UwXXPtdrF0D1zs8cxjUIE5H97W
 qkc54yVOwdL1i+yG23uDBtAw5gfGDNhE3gyT9x0pOq3qzNlTYFU9StPz+l2ZiBezCb+huCKJg
 wkN/t7nohMun5LwnFCTZjiU+IJOdOGl4sfxc9qJC8gndmPizSFfCJTmTxkdizC7X3rn/KstPC
 enSWTz2gm8M0DyHy1YS7Zv7uURD89Yn9wzOMNMyUJpkLDXT7o
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Thu, 13 Mar 2025, Patrick Steinhardt wrote:

> In our CI systems we can observe that t0610 fails rather frequently.
> This testcase races a bunch of git-update-ref(1) processes with one
> another which are all trying to update a unique reference, where we
> expect that all processes succeed and end up updating the reftable
> stack. The error message in this case looks like the following:
>
>     fatal: update_ref failed for ref 'refs/heads/branch-88': reftable: t=
ransaction prepare: I/O error

I saw this error plenty of times and was wondering whether there would be
a way to get more useful information in the error message.

After all, I/O errors come in all shapes and forms, and telling the user
that _something_ was wrong but forcing them to recreate the issue in a GDB
session is an excellent recipe to cause frustration.

So I'd like to suggest to improve the user experience substantially by
augmenting the rather generic `I/O error` with details as to what
operation failed, with what exact error, on what file.

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

It is good that you fixed this issue!

However, `ERROR_ACCESS_DENIED` most often means one of two things:

- The file in question exists but is opened exclusively by another process
  (which might be Defender, the anti-malware scanner), or

- The current user lacks the permission to create this particular file,
  i.e. it is really what `EACCES` would mean on Linux.

While the first condition clearly can be interpreted as "file exists" in
the way this patch wants to do, the latter cannot be. And the patch
touches a function that is exclusively used by the `lockfile` machinery,
each and every caller of `open(..., ... O_CREAT)` is affected by this
change.

This has ramifications e.g. when running in a worktree where the user has
no write permission (but which they indicated as safe via
`safe.directory`). Git would then no longer report correctly whe it cannot
write files because the user lacks permission to do that, but would
instead claim that the file already exists, when that is not true.

Maybe there is a place higher in the stack trace where Git could instead
learn to handle `EACCES`? E.g. treat it the same as `EEXIST`, or maybe
alternatively make it Windows-specific and introduce a back-off plan?

Ciao,
Johannes

>
> [1]: https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-file=
api-createfilew
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  compat/mingw.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 101e380c5a3..fb61de759c7 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -644,6 +644,19 @@ int mingw_open (const char *filename, int oflags, .=
..)
>
>  	fd =3D open_fn(wfilename, oflags, mode);
>
> +	/*
> +	 * Internally, `_wopen()` uses the `CreateFile()` API with CREATE_NEW,
> +	 * which may error out with ERROR_ACCESS_DENIED when the file is
> +	 * scheduled for deletion via `DeleteFileW()`. The file essentially
> +	 * exists, so we map this error to ERROR_ALREADY_EXISTS so that caller=
s
> +	 * don't have to special-case this.
> +	 *
> +	 * This fixes issues for example with the lockfile interface when one
> +	 * process has a lock that it is about to commit or release while
> +	 * another process wants to acquire it.
> +	 */
> +	if (fd < 0 && create && GetLastError() =3D=3D ERROR_ACCESS_DENIED)
> +		errno =3D EEXIST;
>  	if (fd < 0 && (oflags & O_ACCMODE) !=3D O_RDONLY && errno =3D=3D EACCE=
S) {
>  		DWORD attrs =3D GetFileAttributesW(wfilename);
>  		if (attrs !=3D INVALID_FILE_ATTRIBUTES && (attrs & FILE_ATTRIBUTE_DIR=
ECTORY))
>
> --
> 2.49.0.rc2.394.gf6994c5077.dirty
>
>
>
