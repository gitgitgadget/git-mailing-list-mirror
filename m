Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FD71A2572
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 15:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724858769; cv=none; b=a6PZFJXUGQqI+Wzvd9mUbpI3+cb1RgljCyQIJQt3BaPbDUQe5Ku9pPMjMzqcBEv//Z4Lvteu+gF/yOCEMQgxY+pOC3ilVP86oOVNVPWYJGBIUgOMz8FNPuX22kqv1QAQCwguYJrLPOUcym8pSLA3uT3GB7rsfduwAL2nbxsnNgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724858769; c=relaxed/simple;
	bh=ACUCIwpjnBMBH1XCOoCRwvTPTItYFHAnCF5129tHc80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xh02F6IInxH+wYpGGiu803ZuUHWZ5/f9mEDHNZqxLqT9UKiCFplc9sf6tW1WbCtUcHRHrp5mBD3Fegstj3K1Q2wqDDjk57V6T5GxHybhl2j1sEmbm2sEX4NpaKpgdqWZcvclNBR7X1brm1c122S1TzEyFE7ZZg4z3zR+tLpILZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HE/cZoxE; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HE/cZoxE"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7142a30e3bdso596565b3a.0
        for <git@vger.kernel.org>; Wed, 28 Aug 2024 08:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724858767; x=1725463567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ghobjer6RS3/uW3txkjp1S0NAOOQEqrHF/SlLvVFwYY=;
        b=HE/cZoxE/Jh/YRMSsgmMFnNHRebPrcHok0D+M4NRCeHlVVrkez8wLtmSqA7jHgD2Ud
         8JFVf3ZC34OK+OzbizOsw+i8HnWk4bupXredrK3MWHQmPe41p0PtjoEQVve5shhSVLC3
         ud8KVGkV6uUgEeswtdERy6O2/ppMwJnNRLzb9S9RQVyD3SPPb6QOPItsqKG38wn9XkqV
         d9basN7nFyqRdi3Sawd8AikQLq+OdszOLUrzeorvlIew8kteHVhklkgYr6cRiRQ14jlz
         jINyjActIGVm4G90QW18fi2qoZ8i9rnAbXeC+Mbx30vcH5TFXlRPbhmtuU2eCynx8ci3
         cCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724858767; x=1725463567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghobjer6RS3/uW3txkjp1S0NAOOQEqrHF/SlLvVFwYY=;
        b=pwtKShM9uc0sLMn1+M3/Tfn1s6A2/JScuOehNb5PDX12c/Dt9dWk0uQH8e181YMtJh
         5CgZZbNKOiDwqFFjfXtyPFiTIDIrLtM4Yz6qyfV+z6fJoYjn/rDN7yr+coaGrmdKYmjb
         alorBEAcVukQm3ihaPwYX9Xv+Z1UPwObsUPEbqHlsmqt7N6z5E43qqLcvP7+TJhJfrHm
         iCRgIQE9qtGDOVseC9bp7lrFkChBdydpml52TxSlbZIURlHyqOMn0KDNmv1MzuXD3DX2
         IUFKOILAgETpdAGNvw9ESB4CEkBDqEslKB/3DmbnO+OauCsLuEzoW7JAWCRNEB18ylnT
         h7sg==
X-Gm-Message-State: AOJu0Yz9CRGX6BXK6fLjYRaYPoo4Xqw9TpWruRaMPVtOMmXjFxe6fddL
	MQeVWbq9NEr4eeQecz6oL023cNiRKhoCwq5EWFwijME1HbeceZnT
X-Google-Smtp-Source: AGHT+IENmKVog+4TrYTr5AucfUnS3OHSVoHQRwGtHMysPmwpKEjG0UDWoNo+YZC/4m47N/DJyFjZ7Q==
X-Received: by 2002:a05:6a21:150a:b0:1be:c41d:b6b7 with SMTP id adf61e73a8af0-1ccd1ac92camr4279354637.19.1724858766681;
        Wed, 28 Aug 2024 08:26:06 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714343001easm10579785b3a.147.2024.08.28.08.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 08:26:06 -0700 (PDT)
Date: Wed, 28 Aug 2024 23:26:58 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 3/4] ref: add symbolic ref content check for files
 backend
Message-ID: <Zs9BwpUbWBLvsFMZ@ArchLinux>
References: <Zs348uXMBdCuwF-2@ArchLinux>
 <Zs3558scHssaG_XS@ArchLinux>
 <xmqq1q2993kg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1q2993kg.fsf@gitster.g>

On Tue, Aug 27, 2024 at 12:19:11PM -0700, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > In order to check the content of the symbolic ref, create a function
> > "files_fsck_symref_target". It will first check whether the "pointee" is
> > under the "refs/" directory and then we will check the "pointee" itself.
> 
> Hmph, as the pointee must be within the usual places that you would
> find refs (either in refs/ directory or pseudo ref files immediately
> below $GIT_DIR), wouldn't we check the pointee when fsck (or "git
> refs verify") run and check everything?  The pointee will have its
> turn to be checked, and I am not sure why you need to check the
> pointee when you find a symbolic ref is pointing at it, which will
> lead for it to be checked twice (or more).
> 
> I however did not find an additional code to "check the pointee itself"
> in the patch, so perhaps it is OK---the only thing that needs fixing
> may be the above paragraph if that is the case.
> 

Yes, "we will check the 'pointee'" itself makes the reader confused. I
will fix the above paragraph. Actually we do not check the "pointee",
but check the symref content. Will fix this in the next version.

> > There is no specification about the content of the symbolic ref.
> > Although we do write "ref: %s\n" to create a symbolic ref by using
> > "git-symbolic-ref(1)" command. However, this is not mandatory. We still
> > accept symbolic refs with null trailing garbage. Put it more specific,
> > the following are correct:
> >
> > 1. "ref: refs/heads/master   "
> > 2. "ref: refs/heads/master   \n  \n"
> > 3. "ref: refs/heads/master\n\n"
> >
> > But we do not allow any non-null trailing garbage.
> 
> Your use of word "null" is probably too confusing to contributors to
> this project.  None of the above has NUL bytes in them.  I think you
> want to say something like this:
> 
>     A regular file is accepted as a textual symbolic ref if it
>     begins with "ref:", followed by zero or more whitespaces,
>     followed by the full refname (e.g. "refs/heads/master",
>     "refs/tags/v1.0"), followed only by whitespace characters.  We
>     always write a single SP after "ref:" and a single LF after the
>     full refname, but third-party reimplementations of Git may have
>     taken advantage of the looser syntax that is allowed as above.
> 

Thanks for your suggestion. I will improve this in the next version.

> > The following are bad
> > symbolic contents which will be reported as fsck error by "git-fsck(1)".
> >
> > 1. "ref: refs/heads/master garbage\n"
> > 2. "ref: refs/heads/master \n\n\n garbage  "
> >
> > In order to provide above checks, we will use "strrchr" to check whether
> > we have newline in the ref content.
> 
> strrchr() to look for only LF is overly strict.  You need to match
> what refs/files-backend.c:read_ref_internal() does to the contents
> read from such a loose ref file, i.e. strbuf_rtrim().  Any isspace()
> bytes are trimmed at the end, including SP, HT, CR and LF.
> 

I will look into how "strbuf_rtrim" does to see whether we can reuse
some functions to avoid repetition.

> > +static int files_fsck_symref_target(struct fsck_options *o,
> > +				    struct fsck_ref_report *report,
> > +				    const char *refname,
> > +				    struct strbuf *pointee_name,
> > +				    struct strbuf *pointee_path)
> > +{
> > +	const char *newline_pos = NULL;
> > +	const char *p = NULL;
> > +	struct stat st;
> > +	int ret = 0;
> > +
> > +	if (!skip_prefix(pointee_name->buf, "refs/", &p)) {
> > +
> > +		ret = fsck_report_ref(o, report,
> > +				      FSCK_MSG_BAD_SYMREF_POINTEE,
> > +				      "points to ref outside the refs directory");
> > +		goto out;
> > +	}
> > +
> > +	newline_pos = strrchr(p, '\n');
> > +	if (!newline_pos || *(newline_pos + 1)) {
> > +		ret = fsck_report_ref(o, report,
> > +				      FSCK_MSG_REF_MISSING_NEWLINE,
> > +				      "missing newline");
> 
> If newline_pos is NULL, it is truly a "missing newline" situation.
> If I am reading the code correctly, the severity level is set to
> INFO, which is good.
> 
> If newline_pos is not NULL but newline_pos[1] is not NUL, however,
> that is not a "missing newline".  "refs: refs/heads/master\n " would
> trigger this report, for example.
> 

When I design this, I actually consider "ref: refs/heads/master\n " is
still missing the newline. And then we also report that it has garbage.
I think "ref: refs/heads/master\n \n" is not missing the newline. But, I
don't think this is good.

I will find a good way to handle this.

> As far as I can tell, such a textual symbolic ref is taken as a
> valid symbolic ref pointing at "refs/heads/master" by
> refs/files-backend.c:read_ref_internal(), so we are trying to detect
> a valid but curiously formatted textual symbolic ref file with the
> above code?

Yes, these situations will be taken as a valid symbolic ref but actually
there are something wrong. So this is what we need to care about.

> 
> And strrchr() to find the last LF is not sufficient for that
> purpose.  We would never write "refs:  refs/head/master \n",
> but the above code will find the LF, be satisified that the LF is
> followed by NUL, without realizing that SP there is not something we
> would have written!

I totally ignored this situation, and in current patch, we cannot check
this. I know why Patrick lets me use "strchr" but not "strrchr". I think
we should find the last '\n'. But instead we need to find the first
'\n'. However, in this example, we will still fail by using "strchr".
This part should be totally re-designed.

> 
> I am not sure if that is worth detecting that if it is something we
> would have written, but if that were the case, then you would
> probably need to do
> 
>     (1) check the last byte of pointee_name.buf[] to make sure that
>         it is LF; and
>     (2) remember pointee_name.len, run strbuf_rtrim() on pointee_name,
>         and that LF at the end was the only thing that was trimmed by
>         checking the pointee_name.len after trimming.
> 
> or something like that.  Then you do not have to have an ugly "oh we
> need to check again"---the production code would not do that, either.
> 

Yes, this is a good idea.

> > +	if (check_refname_format(pointee_name->buf, 0)) {
> > +		/*
> > +		 * When containing null-garbage, "check_refname_format" will
> > +		 * fail, we should trim the "pointee" to check again.
> > +		 */
> > +		strbuf_rtrim(pointee_name);
> > +		if (!check_refname_format(pointee_name->buf, 0)) {
> > +			ret = fsck_report_ref(o, report,
> > +					      FSCK_MSG_TRAILING_REF_CONTENT,
> > +					      "trailing null-garbage");
> > +			goto out;
> > +		}
> 
> IOW, the above "let's retry" feels totally wrong.  You shouldn't
> have to do so, and that comes from running check_refname_format()
> before rtrimming the pointee_name.
> 

Yes, actually, I have thought I could compare the length change after
executing the "strbuf_rtrim". I don't want to create two new variables,
so I call "check_refname_format" twice.

Will fix this in the next version.

> > +	if (!S_ISREG(st.st_mode) && !S_ISLNK(st.st_mode)) {
> > +		ret = fsck_report_ref(o, report,
> > +				      FSCK_MSG_BAD_SYMREF_POINTEE,
> > +				      "points to an invalid file type");
> > +		goto out;
> 
> I do not think it is wrong per se, but I am not sure if this check
> is needed, either.  When "git fsck" or "git refs verify" is told to
> check the loose refs, wouldn't it walk the refs directory and report
> such an unusual filesystem entity that is not a regular file,
> symbolic link, or a directory as "there is unusual cruft exist
> here"?

When setting up the infrastructure, actually we DO report filesystem
entity that is not a regular file or symbolic link like the following:

    if (S_ISDIR(iter->st.st_mode)) {
        continue;
    } else if (S_ISREG(iter->st.st_mode) ||
               S_ISLNK(iter->st.st_mode)) {
        ...;
    } else {
      // report file system error
    }

We do not check the directory, because the directory will be always
valid in the filesystem. we could not say that

  "refs/heads/a/" is a bad ref.

So, this check mainly need to check whether the symref points to a
directory. Actually, Patrick has also gave the review about this
question in the previous version:

> What exactly are we guarding against here? Don't we already verify that
> files in `refs/` have the correct type? Or are we checking that it does
> not point to a directory?

However, we should remove this line, because "check_refname_format" will
take care for us.

  git check-ref-format 'refs/heads/'

It will generate an error. So, we could entirely remove this line and
let "check_refname_format" do this. And we could also remove the

    if (lstat(pointee_path->buf, &st) < 0)
        goto out;

The code will be much more clean.

Thanks,
Jialuo
