Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5843BDF44
	for <git@vger.kernel.org>; Sun, 22 Sep 2024 15:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727020325; cv=none; b=HFY+CZl6mjJU9PpVamjZakrpNu8ReagiG+O0hcXtiriGZy093QPu3ShZKVKuDcOZDgtVoxjBh87M/XO93PNSGNLHEgbKJKyL8AlUHovdeO+eaNvwVrCFG7zXTUREExUW5Gqeo6syIyWlRQSVpcgsL8hwLg193fEcMSxtFRqfVZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727020325; c=relaxed/simple;
	bh=pXL/3fTGN11sfoq1Sa2R4qz9y6XuJBSEtUWTfsiPxX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQ/HSqWaTKZlwWg6DdkbiJMW0ZJkoL+ZnrD6yFntL0Hu0BjSFddwDxrknOJX2bNUhxSjTuyqmaazI9QyaPX47Rbjv0dJLg4GjRswX0O8IEKwfVrgauUm3NkRJQSJdVUbvtOlNXUFzWfhK2a8P2/QvpozrS7woWZWYNjSly6bAss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnQZXLh7; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnQZXLh7"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-718d8d6af8fso2571019b3a.3
        for <git@vger.kernel.org>; Sun, 22 Sep 2024 08:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727020323; x=1727625123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xz2/yWplDssPQEKgKyB2f4YVESawwm0Nt8KZ61nV528=;
        b=LnQZXLh79iNnAifP/lqjcRidi6vWQqKfWSrwuu1vWbUzjVSvx9JA+oXvR580cQnubN
         HL+E14+EvoHVJohD7m2CkNGQhf7Ri9hjDyXcwZrgBKs4gTcNMtuF04GdkBkwD3jXxUa2
         iVwA+mhzHWuK3j3Cik+nlfVjjn9XGml0B126KKH3RWd38tTrogJXxjDTvGFrMzfjjtMy
         wPRSo0pAeayZMCSqJEHT7TVeqnU6VSXjQwLWu85gqRuom33phXRQWEHWhH+ZkjU1F+Et
         MI31UmItAx8YHNE+Nm5cUlUtZfKeWILSPYSRKBwtN/j4ZAdxLRtEjzoQLgCWBDd4JSgW
         Jbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727020323; x=1727625123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xz2/yWplDssPQEKgKyB2f4YVESawwm0Nt8KZ61nV528=;
        b=Rb7ynU0fmNKBvIUi9XXqxt13b/sDJ/tzAznJC4jJJ7q4d/nMoHmGJM/U1eG176EIQB
         VUuKP+ZbFDDCdlQ9p4fO5fYkVgpt+D8g1/tESLozm2JYGkWjimBbjOW9xn8jW1QqDjV6
         hfUJz1fbpFr7YYDrK6lW1vz5jJhqd/hAQwNkELPqfSsgpU8fzfrbKkiVU2shW+uCaldb
         0UUUnpiEPcvDbQ/WwNBehsYhIEY1fJ1DSe+U9I8REvcRW0gX1NwD3/AVrWpmebGdmSuq
         3YxfzL3PTDaUSa/AcPEkIF3h65rV7S4F6pVnJbZyuMl4/t33MMne8vckflb6DR9ced2m
         Nwlw==
X-Gm-Message-State: AOJu0Yydv6gTlxEj51FAaFpp0dgGU0R/haiShbTGPyqvMR+3nV3z/WcN
	ExWTMKglaOrM+yLEHYJS5RaUgPsGfLAWUAtZw89HcqdXfIbRWX8Q
X-Google-Smtp-Source: AGHT+IFoYjPwfFfJJyHm6/d7Fc6mMP0vHs893VR8asFWDfiPd2qxS1QVd3o2XFMlILeVXMQj/nmGLQ==
X-Received: by 2002:a05:6a00:882:b0:718:e062:bd7e with SMTP id d2e1a72fcca58-7199ca8336amr13525073b3a.24.1727020322432;
        Sun, 22 Sep 2024 08:52:02 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b7b577sm12637076b3a.118.2024.09.22.08.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 08:52:01 -0700 (PDT)
Date: Sun, 22 Sep 2024 23:53:14 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 4/5] ref: add symref content check for files backend
Message-ID: <ZvA9agbGaGnF6nxW@ArchLinux>
References: <ZuRzCyjQFilGhj8j@ArchLinux>
 <ZuRzzwZds8ys-JEN@ArchLinux>
 <xmqqldzobtq6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqldzobtq6.fsf@gitster.g>

On Wed, Sep 18, 2024 at 01:19:13PM -0700, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> Expect that people do not read the body of the message as completing
> a paragrpah the title started.  I.e. ...
> 
> > We have already introduced the checks for regular refs. There is no need
> > to check the consistency of the target which the symref points to.
> > Instead, we just need to check the content of the symref itself.
> 
> ... this needs a bit of preamble, like
> 
>     We have code that check regular ref contents, but we do not yet
>     check contents of symbolic refs.
> 

Thanks, I will improve this in the next version.

> > A regular file is accepted as a textual symref if it begins with
> > "ref:", followed by zero or more whitespaces, followed by the full
> > refname, followed only by whitespace characters. We always write
> > a single SP after "ref:" and a single LF after the refname, but
> > third-party reimplementations of Git may have taken advantage of the
> > looser syntax. Put it more specific, we accept the following contents
> > of the symref:
> >
> > 1. "ref: refs/heads/master   "
> > 2. "ref: refs/heads/master   \n  \n"
> > 3. "ref: refs/heads/master\n\n"
> >
> > Thus, we could reuse "refMissingNewline" and "trailingRefContent"
> > FSCK_INFOs to do the same retroactive tightening as we introduce for
> > regular references.
> >
> > But we do not allow any other trailing garbage. The followings are bad
> > symref contents which will be reported as fsck error by "git-fsck(1)".
> 
> This description needs to be updated, as it is unclear if you are
> talking about errors we already detect, or if you are planning to
> update fsck to notice and report these errors.
> 

Yes, When I was writing this part, I felt a little painful to express my
words. I have thought how could I express the connection between the
current patch and the previous one.

> > And we will remember the untrimmed length of the "referent" and call
> > "strbuf_rtrim()" on "referent". Then, we will call "check_refname_format"
> > to check whether the trimmed referent format is valid. If not, we will
> > report to the user that the symref points to referent which has invalid
> > format. If it is valid, we will compare the untrimmed length and trimmed
> > length, if they are not the same, we need to warn the user there is some
> > trailing garbage in the symref content.
> 
> That is an implementation detail of what you did.  But if the
> implementation were buggy and did not exactly what you intended to
> do, the above description gives no information to help others to fix
> it up so that it works as you intended it to work, because you do
> not explain it.
> 
> So what did you want to achieve in the third step (the first being
> "limit to refs/ hiararchy", the second being "no incomplete lines
> allowed")?
> 
>     Third, we want to make sure that the contents of a textual
>     symref MUST have a single LF after the target refname and
>     NOTHING ELSE.
> 
> or something.
> 

From the above comments, I need to organize the commit message of
this patch to make things clear here.

> "a directory" -> "an existing directory"?
> 
> I am not comfortable to see the word "directory" used in this
> proposed log message, as some refs could be stored in the packed
> backend and are referenced by the symbolic ref you are inspecting
> (this comment also refers to the "refs/ directory" you mentioned
> earlier as "the first check").
> 
>     Lastly, a symbolic ref MUST either point to an existing ref,
>     or if the referent does not exist, it MUST NOT be a leading
>     subpath for another existing ref (e.g., when "refs/heads/main"
>     exists, a symbolic ref that points at "refs/heads" is a no-no).
> 
> or something (but again, I am open to a phrasing better than
> "subpath").
> 
> Design question.  What do we want to do when we have no loose refs
> under the "refs/heads/historical/" hiearchy, (i.e. all of them are
> in packed-refs file) hence ".git/refs/heads/historical" directory
> does not exist on the filesystem.  And a symbolic ref points at
> "refs/heads/historical".  Shouldn't we give the same error whether
> the .git/refs/heads/historical directory exist or not, as long as
> the refs/heads/historical/main branch exists (in the packed-refs
> backend)?
> 

I guess I need to think carefully here. Actually, my intention is that I
want to concentrate on the loose refs and then take consideration about
the packed refs.

However, from what you have said above, it seems I could not do this.
They are connected. But at current, I am not so familiar with packed
refs behavior, I could not answer all the questions above.

I decide to understand what packed-ref done. So, this series may be
stalled sometime until I have a good knowledge and re-think the design
here.

> > +`escapeReferent`::
> > +	(ERROR) The referent of a symref is outside the "ref" directory.
> 
> I am not sure starting this as ERROR is wise.  Users and third-party
> tools make creative uses of the system and I cannot offhand think of
> an argument why it should be forbidden to create a symbolic link to
> our own HEAD or to some worktree-specific ref in another worktree.
> 

Do we allow this cross-access (hack)? It might cause some trouble from
my perspective.

> > +	if (referent->buf[referent->len - 1] != '\n') {
> 
> As you initialized "len" to "referent->len-1" earlier, wouldn't it
> more natural to use it here?  That would match the incrementing of
> len++ later in this block.
> 

Yes, exactly.

> > +		ret = fsck_report_ref(o, report,
> > +				      FSCK_MSG_REF_MISSING_NEWLINE,
> > +				      "missing newline");
> > +		len++;
> > +	}
> 
> Having said that, the above should be simplified more like:
> 
>  * declare but not initialize "len".  better yet, declare "orig_len"
>    and leave it uninitialized.
> 
>  * do not touch "len++" in the above block (actually, you can
>    discard the above "if(it does not end with LF)" block, see
>    below).
> 
>  * instead grab "referent->len" in "len" (or "orig_len") immediately
>    before you first modify referent, i.e. before strbuf_rtrim() call.
> 
> 	orig_len = referent->len;
> 	orig_last_byte = referent->buf[orig_len - 1];
> 

I agree.

> > +	strbuf_rtrim(referent);
> > +	if (check_refname_format(referent->buf, 0)) {
> > +		ret = fsck_report_ref(o, report,
> > +				      FSCK_MSG_BAD_REFERENT_NAME,
> > +				      "points to refname with invalid format");
> 
> Similar to an earlier step, the message does not give any more
> information than the enum.  Wouldn't the user who got this error
> want to learn what referent->buf said and which part of it was bad
> in the same message, instead of having to look it up on their own
> after fsck finishes?
> 

Yes, I agree. I will improve this.

> > +		goto out;
> > +	}
> 
> At this point we know check_refname_format() is happy with what is
> left after rtrimming the referent.  There are four cases:
> 
>  - rtrim() did not trim anything (orig_len == referent->len); the file
>    lacked the terminating LF.
> 
>  - rtrim() trimmed one byte (orig_len - 1 == referent->len) and
>    the byte was not LF (orig_last_byte != '\n').  The file lacked
>    the terminating LF.
> 
>  - rtrim() trimmed exactly one byte (orig_len - 1 == referent->len)
>    and the byte was LF (orig_last_byte == '\n').  There is no error.
> 
>  - all other cases, i.e., rtrim() trimmed two or more bytes.  The
>    file had trailing whitespaces after a valid referent that passed
>    check_refname_format().
> 

That's so clear. My implementation is not good compared with this.

> So in short,
> 
> 	if (referent->len == orig_len ||
> 	    referent->len == orig_len - 1 && orig_last_byte != '\n') {
> 		FSCK_MSG_REF_MISSING_NEWLINE;
> 	} else if (referent->len < orig_len - 1) {
> 		FSCK_MSG_REF_TRAILING_WHITESPACE;
> 	}
> 
> can replace the next block you wrote, and we can also remove the
> earlier "it is an error if it does not end with '\n'", I think.
> 
> > +	if (len != referent->len) {
> > +		ret = fsck_report_ref(o, report,
> > +				      FSCK_MSG_TRAILING_REF_CONTENT,
> > +				      "trailing garbage in ref");
> 
> As check_refname_format() was happy, the difference between orig_len
> and referent->len are only coming from trailing whitespaces, i.e. it
> is not that it had arbitrary garbage.  Shouldn't we be more explicit
> about that?
> 

Yes, I made a lot of mistakes when calling the "fsck_report_ref". I will
report the exact garbage content to the user.

> > +	/*
> > +	 * Dangling symrefs are common and so we don't report them.
> > +	 */
> > +	if (lstat(referent_path->buf, &st)) {
> > +		if (errno != ENOENT) {
> > +			ret = error_errno(_("unable to stat '%s'"),
> > +					  referent_path->buf);
> > +		}
> > +		goto out;
> > +	}
> > +
> > +	/*
> > +	 * We cannot distinguish whether "refs/heads/a" is a directory or not by
> > +	 * using "check_refname_format(referent->buf, 0)". Instead, we need to
> > +	 * check the file type of the target.
> > +	 */
> > +	if (S_ISDIR(st.st_mode)) {
> > +		ret = fsck_report_ref(o, report,
> > +				      FSCK_MSG_BAD_REFERENT_FILETYPE,
> > +				      "points to the directory");
> > +		goto out;
> > +	}
> 
> If referent_path->buf refers to "refs/heads/historical/", and all
> the branches under the hierarchy have been sent to packed-refs,
> then this check will not trigger.
> 

Yes, because "refs/heads/historical" will not appear in the filesystem.

> I wonder if this check is the right thing to enforce in the first
> place, though.
> 
> As far as the end user is concerned, refs/heads/historical/master
> branch stil exists, and there is no refs/heads/historical branch, so
> such a symbolic ref, for all intents and purposes, is the same as
> any other dangling symbolic refs, no?
> 
> Of course, "git update-ref SUCH_A_SYMREF HEAD" will complain because
> there is refs/heads/historical, with something like 
> 
>     "refs/heads/historical/master" exists, cannot create "refs/heads/historical"
> 
> but that is to be expected.  If you remove the last branch in the
> refs/heads/historical hierarchy, you should be able to do such an
> update-ref to instanciate refs/heads/historical as a regular ref.
> 

I am a little shocked here. I do this in action and find the directory
will be automatically converted to a regular file in the filesystem. So,
I agree with you here. We should never check this, because we allow
symref to point to a directory. As long as there is no loose refs and
packed refs under this directory, we could use "git update-ref" for this
symref.

Thanks,

> > @@ -3484,12 +3553,24 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
> >  					      "trailing garbage in ref");
> >  			goto cleanup;
> >  		}
> > +	} else {
> > +		strbuf_addf(&referent_path, "%s/%s",
> > +			    ref_store->gitdir, referent.buf);
> > +		/*
> > +		 * the referent may contain the spaces and the newline, need to
> > +		 * trim for path.
> > +		 */
> > +		strbuf_rtrim(&referent_path);
> 
> I doubt this is a good design.  We have referent, and the symbolic
> ref checker knows that the true referent refname may be followed by
> whitespaces, so instead of inventing referent _path here, it would
> be a better design to let the files_fsck_symref_target() to decide
> what file to open and check based on referent, no?  Give it the
> refstore or refstore's gitdir and have the concatenation with the
> rtrimmed contents in the referent->buf after it inspected it
> instead, perhaps?
> 

Yes, I agree with you here. We should use "files_fsck_symref_target" to
do this.


----

From this review, I think I need to understand more behaviors about
files backend and packed backend. Thanks for your so dedicated reviews.
I may spend more time to send the next version. And there may be some
delay.

Thanks,
Jialuo
