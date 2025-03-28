Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C574C6D
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 15:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743176475; cv=none; b=kemWHA0UqW05ruUCCyV8ooCvHRnuv2CIMry+zLiUi+2Fl+M5l3nmjNjGqZRxCMXo5O/PSmibyAka+nkCLIsH6dP2AXJlqBfGW25/vGYv9hs1nXm+FbwVWJsEe2+dp3DG9oPfSPDR7QTcUt1VO0gkjl+8zIbwvkbXNCESuTKVl/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743176475; c=relaxed/simple;
	bh=s/ES6nEXTcpQ2fd+jns2mKrHx6Xbf6kQ0+JmdtVd4pM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HI+uOXhmY0PzS94hL0pE1O2nKxvNzMB2Ph6uzRpO+IsYR12eXhj70yUvSYadBAKTX92vTLRS4vMePT4/z/RHz4wuCy4yS/sTrkqXv9NA/JGKstWAJTElwUCSN+rO/qj/FkBYMHlTFovxjNGB5CPbl6bra0kxYVEpaRYY8G5phQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=K7ajsaFF; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="K7ajsaFF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1743176466; x=1743781266;
	i=johannes.schindelin@gmx.de;
	bh=KheseBJOtO8vS2VnCJX7fAUGE0L7g4OKNG6CTU03HFA=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=K7ajsaFFknl9+DsGqb6XVJML5zka5Al0bE+iRr7SEQO86p0QLYKSl6CXrB0IaUk0
	 w3SyqIPyuZpMj6Ut2VoXU9hx7uNqCMO5cNcD2/+xpYamNdpNSDzWv6tTm3ub5kT7F
	 06Neq1WEGdykiA+NwNM9bDAkxOdWwce9BiJVVIy7XjD7yhjItaufLj3r3QxXqLzY+
	 MeI+q3mrr1VYf8yX0CmdGiIoFJtVe7LGvuf9ThYHv/Y6RBg82b9mfKXvW9qIW+/Yb
	 Fqwbc/BCXGcuMh09Sn7Q456ozewzuVOUmZtF5IPHfCWx4Ahv5EEYMhjv7EdFzXeF7
	 j0TNzF+Fu1+ZifPdNg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.168.126.83]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8GMq-1t2q7W0y48-00zs83; Fri, 28
 Mar 2025 16:41:06 +0100
Date: Fri, 28 Mar 2025 16:41:05 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>, 
    Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] compat/mingw: fix EACCESS when opening files with
 `O_CREAT | O_EXCL`
In-Reply-To: <Z-Zp9Dvi_Iz7CZ-J@pks.im>
Message-ID: <801fac5d-dd98-d157-6ff3-c3e8aa6a68ae@gmx.de>
References: <20250320-b4-pks-mingw-lockfile-flake-v2-0-a84c90cfc6c2@pks.im> <20250320-b4-pks-mingw-lockfile-flake-v2-2-a84c90cfc6c2@pks.im> <d149a082-cef7-3fe9-f9ce-6a4588cc3d1c@gmx.de> <Z-Zp9Dvi_Iz7CZ-J@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:toczKItfCw0DbL55kQKRY5iA7AimoQtjn4MibDjpzDAblV5W7I7
 YJ13206VerHJ0EJkuz7KUqkYaYwB5TXlGTJcmqXXR0p6txCy0JxM14GMbVJ+LcOxe+KB0kH
 UDc4dy7YYsccTjfggJfFDlS2i/98Gs4JlfbjERV936dfhX7rVda6jx8kIXWGIIV6F0r603I
 sJTgSnouu9C8m0/Fn+Zmw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:e26znH8idA0=;rE49sJdPhiTlOevO5YMDKga+uzF
 z3xlpRVtY2e7LKoNJ16eyeqpTzdbg+0gt/j8XNe3Vc1/pIHeSH1QVsd+xei1UD6HIPF1r7o8U
 kKOW1VAgvSnAcjlBKZe4I43nLoNpyBFzgCSLLwLn+uzp5Q3YK9wBbSaAPOqfp2c+rRo5dYk9s
 vk203m3ii9Gu/Oxo0Wi8Y7m7qad0X6VD/V6u1FSfkiPdP6caHdsgxoE2LBSMoKTCZPGujVhbP
 KKmJPoyyYG8/27C00aKOUUD50f1iHo/q5ZstXFfLck8ZsxWtHeVxlmIgwVJ3WO9F+zOzc9nV6
 aRbAAXNUbhM4i5noEyh5BUIWwSz7nbV7cww+7eF8YYDktnf2066pla6NgW7yo5Qtfr55W7WOG
 lDpN+/bwf9TLM7Paof+DbWKTHwOkUWyvTX1Kk1YXRUhV9EreII6mTvAu58aFqE3Xt4C5AI91g
 F3WTOqJruCzyZxpa3crsBRMC+gPELHKiiY7hohy/1ASt5P+QwXmo9ga8b6WfKz0L0Tw1/XRjB
 DdlSgNyDpCiMcCkRg/xcxwwA8OJKQxAokxpooUtkTGeOVUggRL0UFxCk0RuKQS2L39BRsQhB8
 fG2TSoveAMRm0vwpdLCnLEDR0t6mTHgKLKgguMUPOQXlNLaXstq4qnaBhR5tQjcQxjwgan5kv
 TFnEXTPjw6eR4OEVl2DD/qJ4ZHyPh3TURTbAYRLAKzu7sFT/H/9TefwVuBmobsi9ILOEePvGA
 WGriVHbfWGSOgRHpNgzjB9tuzPL1rBDMuLdjpYgGEVxLryvtzUHHH+oSzgWFaqGbONy/SIeF6
 czkSUnU47g4angubaIhFwXXPEAufIbZPnqWdzzbzKx32SICGGEvd5vxid4AFWUTeubsKp2Hh0
 YpFlar6zpnPRcTDQwew04ngGn30/GoTYEp9S8SOAKFHZ8qgqKdsqnmjXCayg09zIDb3PqDrm8
 jYeD+UPAdOFt7RrVnwz1YLFzLN+71pL7mc4Zfy+j+CxGh7yrsQIVHFML9F+NTcmDVT1sWaHjz
 guaTXx1/rLanYZuPDziw2OfSEMGKmJ1189FkJHgISOyVnLHwrx6Sm08SZpT2KvE0pjdBI5UYC
 BOfeZjs6p+kYibbpYlIXkUMTjH+8MmWXEIsNBOjfrbzFE2DXoWnCfez2NJ/RSMa7I1aISO+T+
 snwYckE9GEtRMUYP31Sm4480nwth53KkPvsAEYAe/OeRbGxcfFw4YpfDnsCSwMU4psGPxutBP
 RNTYOJAMtEdJvSmXcdWtkimAEK4xSgXMvsrwI3oWPweEs3/Rof7JAK7uHzWAP7TY4/xymzTKo
 hISqjuZ1U73Va14JMT2QFsYcQrLcy14OeN2DcIm6cDAtfz8uTJXGL1xrmwip3YSV7BLZvSeIW
 mOgksudYK7TqtzgNkRY3hVmVSL1Zuj3BZNzuNSstTqxuZLxcqwl0sjlzXlNXQ71WwdNO+s3i/
 Qd0/pnxnVWMeDPe3urCMJsJUmqft8xKDK4Zwyz+sZR6YJd/4e
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Fri, 28 Mar 2025, Patrick Steinhardt wrote:

> On Wed, Mar 26, 2025 at 01:20:12PM +0100, Johannes Schindelin wrote:
> > On Thu, 20 Mar 2025, Patrick Steinhardt wrote:
> > > In our CI systems we can observe that t0610 fails rather frequently.
> > > This testcase races a bunch of git-update-ref(1) processes with one
> > > another which are all trying to update a unique reference, where we
> > > expect that all processes succeed and end up updating the reftable
> > > stack. The error message in this case looks like the following:
> > >
> > >     fatal: update_ref failed for ref 'refs/heads/branch-88': reftabl=
e: transaction prepare: I/O error
> > >
> > > Instrumenting the code with a couple of calls to `BUG()` in relevant
> > > sites where we return `REFTABLE_IO_ERROR` quickly leads one to disco=
ver
> > > that this error is caused when calling `flock_acquire()`, which is a
> > > thin wrapper around our lockfile API. Curiously, the error code we g=
et
> > > in such cases is `EACCESS`, indicating that we are not allowed to ac=
cess
> > > the file.
> > >
> > > The root cause of this is an oddity of `CreateFileW()`, which is wha=
t
> > > `_wopen()` uses internally. Quoting its documentation [1]:
> > >
> > >     If you call CreateFile on a file that is pending deletion as a
> > >     result of a previous call to DeleteFile, the function fails. The
> > >     operating system delays file deletion until all handles to the f=
ile
> > >     are closed. GetLastError returns ERROR_ACCESS_DENIED.
> > >
> > > This behaviour is triggered quite often in the above testcase becaus=
e
> > > all the processes race with one another trying to acquire the lock f=
or
> > > the "tables.list" file. This is due to how locking works in the reft=
able
> > > library when compacting a stack:
> > >
> > >     1. Lock the "tables.list" file and reads its contents.
> > >
> > >     2. Decide which tables to compact.
> > >
> > >     3. Lock each of the individual tables that we are about to compa=
ct.
> > >
> > >     4. Unlock the "tables.list" file.
> > >
> > >     5. Compact the individual tables into one large table.
> > >
> > >     6. Re-lock the "tables.list" file.
> > >
> > >     7. Write the new list of tables into it.
> > >
> > >     8. Commit the "tables.list" file.
> > >
> > > The important step is (4): we don't commit the file directly by rena=
ming
> > > it into place, but instead we delete the lockfile so that concurrent
> > > processes can continue to append to the reftable stack while we comp=
act
> > > the tables. And because we use `DeleteFileW()` to do so, we may now =
race
> > > with another process that wants to acquire that lockfile. So if we a=
re
> > > unlucky, we would now see `ERROR_ACCESS_DENIED` instead of the expec=
ted
> > > `ERROR_FILE_EXISTS`, which the lockfile subsystem isn't prepared to
> > > handle and thus it will bail out without retrying to acquire the loc=
k.
> > >
> > > In theory, the issue is not limited to the reftable library and can =
be
> > > triggered by every other user of the lockfile subsystem, as well. My=
 gut
> > > feeling tells me it's rather unlikely to surface elsewhere though.
> > >
> > > Fix the issue by translating the error to `EEXIST`. This makes the
> > > lockfile subsystem handle the error correctly: in case a timeout is =
set
> > > it will now retry acquiring the lockfile until the timeout has expir=
ed.
> > >
> > > With this, t0610 is now always passing on my machine whereas it was
> > > previously failing in around 20-30% of all test runs.
> > >
> > > [1]: https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-=
fileapi-createfilew
> >
> > Couldn't we simply handle `EACCES` the same way as `EEXIST` in step 4?
> >
> > This suggestion is different from v1, which would have affected all
> > callers of `mingw_open()`.
>
> Yeah, but it basically has the same problem: we cannot tell whether
> EACCESS is caused by the race or by insufficient privileges. So the
> behaviour would be more self-contained, but it would still not be
> correct in the same way as it would be incorrect in `mingw_open()`. We
> do want to retry locking the file in case we raced, but when EACCESS is
> raised due to insufficient permissions we don't.

My thinking was that in the call chain from reftable, it seems that the
failure to lock the file is less bad than in other cases, that's why I
asked whether that might be a layer where we could add a work-around
without resorting to undocumented functions.

> > The reason I ask is that `RtlGetLastNtStatus()` is undocumented, and
> > should therefore not be used. I know that I will be tasked with removi=
ng
> > that call should it be introduced into Git's source code, and naturall=
y
> > I'd like to avoid that.
>
> Unfortunate, but fair enough. It's quite surprising that it is not
> possible to figure out the exact status code without relying on
> undocumented functions.

Indeed.

> > I know that e.g. PostgreSQL used this undocumented function at least a=
t
> > some stage, but SQLite avoided it by introducing a simple poll strateg=
y.
> > We could also do that, but if there is already code in the reftable
> > library that skips doing things if a `.lock` file exists, then doing t=
he
> > same if the `.lock` file cannot be created, too, should be a safe argu=
ment
> > to make.
>
> I did stumble over the PostgreSQL patch at one point indeed, yeah.
>
> Thanks for the pointer to SQLite. It indeed has the following snippet:
>
>     #define winIoerrCanRetry1(a) (((a)=3D=3DERROR_ACCESS_DENIED)        =
|| \
>                                   ((a)=3D=3DERROR_SHARING_VIOLATION)    =
|| \
>                                   ((a)=3D=3DERROR_LOCK_VIOLATION)       =
|| \
>                                   ((a)=3D=3DERROR_DEV_NOT_EXIST)        =
|| \
>                                   ((a)=3D=3DERROR_NETNAME_DELETED)      =
|| \
>                                   ((a)=3D=3DERROR_SEM_TIMEOUT)          =
|| \
>                                   ((a)=3D=3DERROR_NETWORK_UNREACHABLE))
>
> The function gets used via `winRetryIoerr()`, which is used in various
> I/O functions to retry the operation, including `winOpen()` to open or
> create a file. And it indeed uses a rather simple polling system there
> where it sleeps for 25ms up to 10 times.
>
> This certainly is something we could implement in `mingw_open()`: when
> we see that `CreateFileW()` has returned any of the above errors we
> simply retry the operation. It wouldn't fix the race itself, but it
> would hopefully make it less likely to hit. If you would be okay with
> such a solution I can implement it.
>
> Also, one thing to note: this problem isn't caused by the reftable
> library, it's caused by the lockfile subsystem. So if we don't want to
> do this in `mingw_open()`, any self-contained fix should go into the
> lockfile system, not into the reftable library, because we may hit the
> same symptoms anywhere else where we race around creation/deletion of a
> lockfile. We just happen to hit this case in the reftable library
> because the test is intentionally stress-testing and racing this code
> path.

As I mentioned, I had hoped that we could address this at another layer.

But let's move forward with the `RtlGetLastNtStatus()` solution because,
as you correctly pointed out, it is the only solution so far that lets Git
determine precisely whether the underlying problem is a pending delete.

I had only one remaining concern: If `RtlGetLastNtStatus()` has not yet
been initialized, would we not potentially overwrite the last NTSTATUS
while initializing it? And the answer I can give to myself is: unlikely.
The `ntdll` is already loaded, so there won't be an update to the
`NTSTATUS` there, likewise the `GetProcAddress()` call won't fail and
hence also not update it.

So let's go ahead with v2!

Ciao,
Johannes
