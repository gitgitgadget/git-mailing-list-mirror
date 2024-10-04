Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABAF14A4FB
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 10:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728036604; cv=none; b=sa9hAUlty6R7AuvYrf3p+RhzPsNf/4I4cxw78VoCCMAl+xtwi0rEXyUtkxGoxo7dXbBoCZU9ln93uXk+aDsFj3wilawm49VIHwYcJfgVYEqOocN47nS6/nHvbf108U+GZPDL1pRKhleWz7BaJTS6F8tNFytMmaARFiTvnAjAgew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728036604; c=relaxed/simple;
	bh=lKx3y8d1V2CXTsb+eEP/A+is3OrAIgPOn7Dz+Y1NM2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQuc5gXluYcCrVMHhjlRTtvHQWg383Kc1m4h9OvGKC6xWaAbdmRlHamC5JliiVzCkPjIf8JNx3jaQVpwdaTlUjxfTC8GPjYBq5r2m6xhmQgLFm6UpSLbtEgGweUQvW/XrWKflGDYKqShFhkcgMS7D3+AiYpIp+xV55jC37DSNfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DI7rmQLi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AmbqjO0D; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DI7rmQLi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AmbqjO0D"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 738A4138069C;
	Fri,  4 Oct 2024 06:10:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 04 Oct 2024 06:10:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728036600; x=1728123000; bh=dm1kmFifJU
	8mj1mnzsRJXXO2ukxpma5Fgt8LoGyLEr0=; b=DI7rmQLisjpOQFTj1x4NDXT9Ww
	ihEWG0CXW3tXc6cmP+KKEI7wVHwTExK8cbDQh1yXOgUJebO0tYFCP8YlMOWxEF7c
	C74r0tvqGll4Z1ipqE91ltoMuRN4wGgqux0xm4uXIAJTcEk+yxG1PCcdVFpp0GNj
	0jEs5Z7cVtrdz1MvbDw7LsYAjx4eAX5ZAyQg1y+2mBB20NIN1b+WU/Y2VeXzaCE0
	CWK6E8ea60Rcmj5d4bfmzx3QMdnUYic4qP7d7mVngDk6gRb3XykhPGEtuiukQ6a5
	2QBg3ZsI1raez2cnIOPYqeoa2/Y33HbMIGYfSE1cslhvYXkmf5CJwy0eQfZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728036600; x=1728123000; bh=dm1kmFifJU8mj1mnzsRJXXO2ukxp
	ma5Fgt8LoGyLEr0=; b=AmbqjO0DAmQFmAQeCgKZTrv2je5M8QA+HdGeQTYlRDTQ
	/0+pn1yUUwV/NpqY6p49iCgFjRMmS+iSRivRNJOlGfXdgpuK8BEcDZ6+Gr6uf624
	Y7WehH43orFfpXm5nK0/bSqbDGjq3WFyMxFzFRffKldNXCKmR76VsxYft7+B5OEc
	izKEd/SxFlZMVSDFRZ/vADrf5Gm3Vp1S4xDrr+gRen6KjE+GGs2fsdUZPOhbM+jS
	pnCR7CuBjrfKm41tcwVDGz8+OLyeKDhJc5LQa+N5RzYmFPRcygexd1WV2EUETdCZ
	7FQ67fGpRMZSgBskenUi8e4zLsizPJ05MCdzjCo6wQ==
X-ME-Sender: <xms:977_ZsJzYYq_tDHd_uBpm4GEOmQIsn1xnrGeka_3IirHjfQmSTKtWw>
    <xme:977_ZsKxTLT6Q0AYqD7Cc65978qYIQ3UMIB9gbzG9mtH5lZSWWhj53ePRdTdDTnKT
    bIhb3IhpT8hclsI4g>
X-ME-Received: <xmr:977_ZstTlL5s7r56dixSjuyzbIvebErpx0GpLKYD3TXhBAvIydl0OzZYGd-OLQEg16XoKfGFwL8jbUDTSu0fszuNZdfH-Mt0wfLZaZ8aYCOZwViN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvfedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjohhhrg
    hnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:977_ZpZ7d_ZzmpScLv81DS46JrUEwTW2O_pCLC54B2q2XjDvtfoiag>
    <xmx:977_ZjYndIhuSOXCbrIhyomllxiIfKDTLkIVNzGpSfoKcMMYsssdlw>
    <xmx:977_ZlDSXe-sdShSa5TDgGck3OtAo4xvr-u4CMywKWFWA0PWbnfTTA>
    <xmx:977_Zpb9Q-qPQ0MXGuuXnenNqGfKh8ifUWVIyTEIIDS3zA5JdxOS6A>
    <xmx:-L7_ZiVp45LzPxEKgF4jxF5Rotm4R0lS_mZF4I2pnDljbJWJ285RCAnO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Oct 2024 06:09:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0ba61982 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Oct 2024 10:09:04 +0000 (UTC)
Date: Fri, 4 Oct 2024 12:09:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: v2.47.0-rc1 test failure on cygwin
Message-ID: <Zv--68J5qv60IuQz@pks.im>
References: <b1b5fb40-f6c2-4621-b58c-9b7c8c64cc01@ramsayjones.plus.com>
 <Zv9oIrKveu-JAGQM@pks.im>
 <Zv-HbT8qrM6IYKb4@pks.im>
 <8718c5c4-1d0a-104b-eb39-6338ae9c5dbf@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8718c5c4-1d0a-104b-eb39-6338ae9c5dbf@gmx.de>

On Fri, Oct 04, 2024 at 11:13:34AM +0200, Johannes Schindelin wrote:
> Hi Patrick,
> 
> On Fri, 4 Oct 2024, Patrick Steinhardt wrote:
> 
> > On Fri, Oct 04, 2024 at 05:59:30AM +0200, Patrick Steinhardt wrote:
> > > On Fri, Oct 04, 2024 at 02:02:44AM +0100, Ramsay Jones wrote:
> > > >
> > > > Just a quick heads up: t0610-reftable-basics.sh test 47 (ref
> > > > transaction: many concurrent writers) fails on cygwin. The tail end
> > > > of the debug output for this test looks like:
> > > >
> > > [snip]
> > > >
> > > > t0610-reftable-basics.sh passed on 'rc0', but this test (and the
> > > > timeout facility) is new in 'rc1'. I tried simply increasing the
> > > > timeout (10 fold), but that didn't change the result. (I didn't
> > > > really expect it to - the 'reftable: transaction prepare: I/O error'
> > > > does not look timing related!).
> > > >
> > > > Again, just a heads up. (I can't look at it until tomorrow now; any
> > > > ideas?)
> > >
> > > This failure is kind of known and discussed in [1]. Just to make it
> > > explicit: this test failure doesn't really surface a regression, the
> > > reftable code already failed for concurrent writes before. I fixed
> > > that and added the test that is now flaky, as the fix itself is
> > > seemingly only sufficient on Linux and macOS.
> > >
> > > I didn't yet have the time to look at whether I can fix it, but should
> > > finally find the time to do so today.
> >
> > Hm, interestingly enough I cannot reproduce the issue on Cygwin myself,
> > but I can reproduce the issue with MinGW. And in fact, the logs you have
> > sent all indicate that we cannot acquire the lock, there is no sign of
> > I/O errors here. So I guess you're running into timeout issues. Does the
> > following patch fix this for you?
> >
> > diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
> > index 2d951c8ceb..b5cad805d4 100755
> > --- a/t/t0610-reftable-basics.sh
> > +++ b/t/t0610-reftable-basics.sh
> > @@ -455,10 +455,7 @@ test_expect_success 'ref transaction: many concurrent writers' '
> >  	git init repo &&
> >  	(
> >  		cd repo &&
> > -		# Set a high timeout such that a busy CI machine will not abort
> > -		# early. 10 seconds should hopefully be ample of time to make
> > -		# this non-flaky.
> > -		git config set reftable.lockTimeout 10000 &&
> > +		git config set reftable.lockTimeout -1 &&
> >  		test_commit --no-tag initial &&
> >
> >  		head=$(git rev-parse HEAD) &&
> 
> That looks plausible to me, as this test is exercising the POSIX emulation
> layer of Cygwin much more than Git itself (and therefore I expect this
> test case to take a really long time on Cygwin). If it turns out that this
> works around the issue, I would propose to use something like this
> instead:
> 
> 		# Cygwin needs a slightly longer timeout
> 		if have_prereq !CYGWIN
> 		then
> 			git config set reftable.lockTimeout 10000
> 		else
> 			git config set reftable.lockTimeout 60000
> 		fi &&

We also saw that this creates an issue when running e.g. with the memory
and leak sanitizers. So I'd just generally raise the timeout value to
something way higher to avoid flakiness, like 5 minutes.

> > The issue on Win32 is different: we cannot commit the "tables.list" lock
> > via rename(3P) because the target file may be open for reading by a
> > concurrent process. I guess that Cygwin has proper POSIX semantics for
> > rename(3P) and thus doesn't hit the same issue.
> 
> Indeed, this is where the symptom lies. I worked around it in Git for
> Windows v2.47.0-rc1 via this patch:
> 
> -- snipsnap --
> diff --git a/compat/mingw.c b/compat/mingw.c
> index c1030e40f227..56db193d1360 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -784,6 +784,7 @@ int mingw_open (const char *filename, int oflags, ...)
>  	int fd, create = (oflags & (O_CREAT | O_EXCL)) == (O_CREAT | O_EXCL);
>  	wchar_t wfilename[MAX_LONG_PATH];
>  	open_fn_t open_fn;
> +	int tries = 0;
> 
>  	va_start(args, oflags);
>  	mode = va_arg(args, int);
> @@ -813,7 +814,11 @@ int mingw_open (const char *filename, int oflags, ...)
>  	else if (xutftowcs_long_path(wfilename, filename) < 0)
>  		return -1;
> 
> -	fd = open_fn(wfilename, oflags, mode);
> +	do {
> +		fd = open_fn(wfilename, oflags, mode);
> +	} while (fd < 0 && GetLastError() == ERROR_SHARING_VIOLATION &&
> +		 retry_ask_yes_no(&tries, "Opening '%s' failed because another "
> +			"application accessed it. Try again?", filename));
> 
>  	if ((oflags & O_CREAT) && fd >= 0 && are_wsl_compatible_mode_bits_enabled()) {
>  		_mode_t wsl_mode = S_IFREG | (mode&0777);

Wait, this is surprising to me as I saw the error happening when calling
rename, not open. So why would retries in `open()` fix the symptom? I'm
probably missing something.

In any case I also tried something like the below patch (sorry,
whitespace-broken). But unfortunately this still caused permission
errors when the new path was held open by another process.

I think for now I'd still lean into the direction of adding the !WINDOWS
prerequisite to the test and increasing timeouts such that I can
continue to investigate without time pressure.

Patrick

@ -2152,9 +2152,12 @@ int mingw_accept(int sockfd1, struct sockaddr *sa, socklen_t *sz)
 int mingw_rename(const char *pold, const char *pnew)
 {
        DWORD attrs, gle;
-       int tries = 0;
+       int tries = 0, wpnew_len, wpold_len;
        wchar_t wpold[MAX_PATH], wpnew[MAX_PATH];
-       if (xutftowcs_path(wpold, pold) < 0 || xutftowcs_path(wpnew, pnew) < 0)
+
+       wpold_len = xutftowcs_path(wpold, pold);
+       wpnew_len = xutftowcs_path(wpnew, pnew);
+       if (wpold_len < 0 || wpnew_len < 0)
                return -1;
 
        /*
@@ -2166,6 +2169,58 @@ int mingw_rename(const char *pold, const char *pnew)
        if (errno != EEXIST)
                return -1;
 repeat:
+       {
+#define FileRenameInfoEx                      22
+               enum {
+                       FILE_RENAME_REPLACE_IF_EXISTS         = 0x01,
+                       FILE_RENAME_POSIX_SEMANTICS           = 0x02,
+                       FILE_RENAME_IGNORE_READONLY_ATTRIBUTE = 0x40,
+               };
+               typedef struct FILE_RENAME_INFORMATION {
+                       union {
+                               BOOLEAN ReplaceIfExists;
+                               ULONG Flags;
+                       };
+                       HANDLE RootDirectory;
+                       ULONG FileNameLength;
+                       WCHAR FileName[1];
+               } *PFILE_RENAME_INFORMATION;
+               size_t wpnew_size = wpnew_len * sizeof(wchar_t);
+               PFILE_RENAME_INFORMATION fri = NULL;
+               HANDLE handle = NULL;
+               BOOL success;
+               int ret;
+
+               handle = CreateFileW(wpold, DELETE,
+                                    FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE, NULL,
+                                    OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
+               if (handle == INVALID_HANDLE_VALUE) {
+                       errno = ENOENT;
+                       ret = -1;
+                       goto out;
+               }
+
+               fri = xcalloc(1, sizeof(*fri) + wpnew_size);
+               fri->Flags = FILE_RENAME_REPLACE_IF_EXISTS | FILE_RENAME_POSIX_SEMANTICS |
+                            FILE_RENAME_IGNORE_READONLY_ATTRIBUTE;
+               fri->FileNameLength = wpnew_len;
+               memcpy(fri->FileName, wpnew, wpnew_size);
+
+               success = SetFileInformationByHandle(handle, FileRenameInfoEx,
+                                                    fri, sizeof(*fri) + wpnew_size);
+               if (!success) {
+                       errno = err_win_to_posix(GetLastError());
+                       ret = -1;
+                       goto out;
+               }
+
+               ret = 0;
+out:
+               CloseHandle(handle);
+               free(fri);
+               return ret;
+       }
+
