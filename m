Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DCA1459E0
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728041530; cv=none; b=t/wJHRQVG15wx2tCn7wCR8CCaOduTe9dAa8RMFx4CbzdHosbjB1Hk2XRVSIWw0GUydE3fIXZ3FJiWxw5300i9D1OfZfE5j/O3FsdCUsExXlhscbr8k/T8nTaW03laQhjuDGl469OaitunS5Md1XjA5XGy2H9wWRTFO+1HGUJKJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728041530; c=relaxed/simple;
	bh=TAy5RhmiWsrS+GVtQMI4em5HGeiVCVy7yQ+J3UoD480=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRqooHCehRWObTTPOZ2JZJx//uM5Xa2qa9FgE6NVJIOOXdfEdoBJpkha33qKvS3+FClyqpAPfWpbH3bUKqQIlO6lpiT+c0GbuO6brdV0EVUTkl+bLgXznqqJMAu+zuxE6X0eHknVOb3cgd9y/hRp3A8bOuCJBGULPMWtq6scJqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gxnqGjkE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TZ7TycJj; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gxnqGjkE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TZ7TycJj"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 8D50F138028D;
	Fri,  4 Oct 2024 07:32:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 04 Oct 2024 07:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728041526; x=1728127926; bh=ofBkp63Q8W
	VnJM15s8B8tEXSwvSSuEcRopkFJIXKMG0=; b=gxnqGjkE0RyRQf7JhqITALOhPP
	CGKJxiN88rWOvKPxG7EqQrzGDqfesqsYovi00d4TTtIVvZIJQ685mXTu1O4Xao2A
	xIByUbQn0kYly+3Qg7eERGrjwAW9HKEMsTAypKZ40T5rGEWaJxQu1zqGpm1Ikh7e
	S7lKZD2sb54EGPT7dUeQ4d38afU+Y58YqTx6j21AVEp+M+G4AdchPvsANFyFEBBK
	M5aVoJ4l5D4lceKT01Xv3IP/A3A43M9QFovfAGPNn/3jq/47zTRJFrRXIIC4rOrD
	AZWBNPllnohslCoZ+o/ti/UqsgVOWO4qNhh2ac4wJlue+9xm9Khz03cvujIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728041526; x=1728127926; bh=ofBkp63Q8WVnJM15s8B8tEXSwvSS
	uEcRopkFJIXKMG0=; b=TZ7TycJjZtcBF6HCvlJu0UgJ+B5JJ9NttcqXhHs4EySX
	HT1lseVkR1evN/SEBNed7PCe6zA1ndodAzEN9nb/iSNBEhFLcrhnNJgbPhUZi6Tp
	YDeDKuKDXcGIi+0lAD96h+HLBrV2jIGjEB1fMkF6DqareaLz29TRh9Od7XdhYVil
	OTYMz0B1yNOj/9Yy0LM4lMm7h9dcYTVC+ZRHF512VOzu8yra24aisKPGNxVi5i3K
	amJdsJ/4jluwcyi38q0fvYR28UREednq3azPnsaCSnricFVXZlTsLh/XKM8x+QQq
	HNxArgidEc+VBLuriaQvolSll3dLycq1lgP/7Co1Sg==
X-ME-Sender: <xms:NtL_ZvXZ3AZSEqjZKzl7kU0eegoXvY8lmtHOyrT03qPJ08gKL3EemA>
    <xme:NtL_ZnkHrQOSBeeQ_hU5t7VVC-DRJBmiVvFds9EmFsNg2iqfNaBNiCF3nH9GHhEr8
    eSuxuEuXp3FPOG9kA>
X-ME-Received: <xmr:NtL_ZrY8T853PufwuBVrxglwxqp4G9WLLbBJfwYcXx5cZ-6MvkTjyxFxq9vaDDu4AqOB_uaOYXki8J_REyFiWIyKVGntRnWi43BiKEkPrX48NSOi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvfedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrg
    hnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:NtL_ZqXJ8xicXXnzizNDIM6In7aVc2NTIUpDUeGiLEQE1TMqViihJw>
    <xmx:NtL_ZpndVt3JOiphckRyiKQLaczajiVnOxNTamu_ejXwkjzVul1N7g>
    <xmx:NtL_ZndsBsGDfV2S-zLE1PzMu6D_QaRF4cRHU6BH0EchV1OLqZmP7Q>
    <xmx:NtL_ZjGqgJdAHWI6lCcfVVqOHyOjMVx-JKd5AlENH6i-ReJYjm3FgA>
    <xmx:NtL_ZiDuUM7LPHN5miC_vEpsw3y7ksFNAUF96eo5fjXpF_b-UeLuI8au>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Oct 2024 07:32:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7470c712 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Oct 2024 11:31:11 +0000 (UTC)
Date: Fri, 4 Oct 2024 13:32:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: v2.47.0-rc1 test failure on cygwin
Message-ID: <Zv_SKtehwx2dsflo@pks.im>
References: <b1b5fb40-f6c2-4621-b58c-9b7c8c64cc01@ramsayjones.plus.com>
 <Zv9oIrKveu-JAGQM@pks.im>
 <Zv-HbT8qrM6IYKb4@pks.im>
 <8718c5c4-1d0a-104b-eb39-6338ae9c5dbf@gmx.de>
 <Zv--68J5qv60IuQz@pks.im>
 <f29241a7-aadd-e824-97f3-a95ac6619951@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f29241a7-aadd-e824-97f3-a95ac6619951@gmx.de>

On Fri, Oct 04, 2024 at 01:11:15PM +0200, Johannes Schindelin wrote:
> Hi Patrick,
> > > > The issue on Win32 is different: we cannot commit the "tables.list" lock
> > > > via rename(3P) because the target file may be open for reading by a
> > > > concurrent process. I guess that Cygwin has proper POSIX semantics for
> > > > rename(3P) and thus doesn't hit the same issue.
> > >
> > > Indeed, this is where the symptom lies. I worked around it in Git for
> > > Windows v2.47.0-rc1 via this patch:
> > >
> > > -- snipsnap --
> > > diff --git a/compat/mingw.c b/compat/mingw.c
> > > index c1030e40f227..56db193d1360 100644
> > > --- a/compat/mingw.c
> > > +++ b/compat/mingw.c
> > > @@ -784,6 +784,7 @@ int mingw_open (const char *filename, int oflags, ...)
> > >  	int fd, create = (oflags & (O_CREAT | O_EXCL)) == (O_CREAT | O_EXCL);
> > >  	wchar_t wfilename[MAX_LONG_PATH];
> > >  	open_fn_t open_fn;
> > > +	int tries = 0;
> > >
> > >  	va_start(args, oflags);
> > >  	mode = va_arg(args, int);
> > > @@ -813,7 +814,11 @@ int mingw_open (const char *filename, int oflags, ...)
> > >  	else if (xutftowcs_long_path(wfilename, filename) < 0)
> > >  		return -1;
> > >
> > > -	fd = open_fn(wfilename, oflags, mode);
> > > +	do {
> > > +		fd = open_fn(wfilename, oflags, mode);
> > > +	} while (fd < 0 && GetLastError() == ERROR_SHARING_VIOLATION &&
> > > +		 retry_ask_yes_no(&tries, "Opening '%s' failed because another "
> > > +			"application accessed it. Try again?", filename));
> > >
> > >  	if ((oflags & O_CREAT) && fd >= 0 && are_wsl_compatible_mode_bits_enabled()) {
> > >  		_mode_t wsl_mode = S_IFREG | (mode&0777);
> >
> > Wait, this is surprising to me as I saw the error happening when calling
> > rename, not open. So why would retries in `open()` fix the symptom? I'm
> > probably missing something.
> 
> I am sorry, I did not really read the bug report in detail, I only meant
> to unblock Git for Windows v2.47.0-rc1 and thought I had a fix in hand. It
> certainly fixed the failures on my local machine, but it unfortunately did
> not fix the problems in CI.

Nothing to be sorry about. Quite on the contrary, thanks for chiming in
here, I was hoping for your input.

> I tried to debug in CI a bit, but it is a gnarly bug to investigate, what
> with plenty of processes the intentionally block each other, and no `gdb`
> to help.

Yup, indeed it is.

> > In any case I also tried something like the below patch (sorry,
> > whitespace-broken).
> 
> Oh, you reminded me that the `mingw_rename()` function looks
> _substantially_ different in Git for Windows than in Git. I did not have
> the time (or the strength of mind, more like) to upstream those changes
> yet.
> 
> > But unfortunately this still caused permission errors when the new path
> > was held open by another process.
> 
> Yes, this will _always_ be a problem, I think. The
> `FILE_RENAME_POSIX_SEMANTICS` as per its documentation should help, but if
> it does not in your tests it might actually not quite work as advertised
> (wouldn't be the first time I encounter such an issue).

It could of course be that the code I wrote is just plain wrong. I had
to stub out the struct as well as the constants because those are not
available on my Windows system, due to whatever reason. Not even when
bumping _WIN32_WINNT to 0x0A00 (W10+). Maybe this is because I'm using
Windows 10, but I thought that thish should have been available starting
with Windows 10 RC1.

> I tried to read through the code (it's a lot!) to figure out whether there
> is potentially any situation when the `tables.list` file is opened but not
> closed immediately, but couldn't find any. Do you know off-hand of any
> such scenario?

We indeed do keep the `tables.list` file descriptor open as part of our
stat cache. But that only happens on non-Windows system. This all
happens in `reftable_stack_reload_maybe_reuse()` and is documented quite
extensively in there.

> > I think for now I'd still lean into the direction of adding the !WINDOWS
> > prerequisite to the test and increasing timeouts such that I can
> > continue to investigate without time pressure.
> 
> Let me bang my head against this problem for a little while longer. You
> might be right, though, that this is a thing we cannot fix in time for
> v2.47.0, which would be sad.

A bit sad, yes, but as I mentioned this is at least not a regression.
The test just demonstrates that the improvements I did in this area are
not yet sufficient for all platforms and that I need to spend some more
time on it. Or that the central "tables.list" mechanism is not a good
fit for Windows, which would be a shame.

I'll send the patch as a reply to this thread so that it can be picked
up as required.

Patrick
