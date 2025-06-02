Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DBF2905
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 11:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748863853; cv=none; b=opH5GDEV/3NdVtrmZZPKS0uZFJlVwnWtGtp3hXYd/fE0LsXOmuGIVSGV8ZAHhW+8IIi4IKKTrjQu1//M53Djjz/Iw62IYc0z+Q07ZLNR1GahxeP1WEaRPoNUzmLc7J8iCUF3uwOuHPIlJN2Hhr0vPyBr+CFiTIhxJxzgSVZucjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748863853; c=relaxed/simple;
	bh=4xwI1YF33eLD4wlxp6/DGwtCxF9jp77qQV6ZVw414Gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQHxhbo9nT7AQSLA0p3hVIcCAhGKJnhx/vKy45OsPap6mvb5OK8TXn6CQ+NoNW3KcYqfeIqmcYvRIzHETnqnliJ9a285BVz07+Kus/ky50TFwBWyyfybqVVBQ4Nr/R+ie4sgbOAAqrO87UIHoAT1WnIcRyWChdHjsSW3szTgSDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtAmnchR; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtAmnchR"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22d95f0dda4so52327005ad.2
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 04:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748863851; x=1749468651; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8bRrQXvWV+j1ejNzBEysWQ1KrKqJ8LLFka3xLj0Lw8I=;
        b=JtAmnchRFtgsmgGUy8r5a1f//NF41Fj2+HGAk0TFp4gc1jTce5cBhVVQYy3VQ3cfS2
         X/fR8I2TTELpyliHoF4iiZhmb3HSm62esrCYiq6LQwD6iUDKZtvsXrzWn6PxjmsLINKk
         /eWS0Cck51OiSmJS7v6HqcdJctfCHhMReY3nu0ifsC3U/q7tsyJ7njWoeJjpq+ErNmQs
         4YwsajbkliRiNMsLiSpNeFgkFr6oK8imES63M+XqW5CPN3QeBJFuYLzU+1No7BVWjWCP
         DlzKfdQYp82uT/bZt09OKVf4Fpiwn0usPTbxvwI5JzuvvEaPzP3teFPoeZac6A0JX3UJ
         zCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748863851; x=1749468651;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8bRrQXvWV+j1ejNzBEysWQ1KrKqJ8LLFka3xLj0Lw8I=;
        b=tGyrfN+OaJc2R+zs8G709GCO6Fi5LIjFrKLJra6QcWou2mzEndjbFfavsKtb5Y8p4q
         NaszBt5SDSWEWQUoFI0NzMEeAkVkRYnJrEfM1o7pJLzBlr4CgTH0KWFGtbX/Jj6QyTk+
         9l2da/emSAwtCvTZ4ghUwBHLh84oA7lM6LyG53eyybtcGALbDUEB/5GPlgW7+hHMm/1I
         uiw8+SwTjxJ6jUIDk9NXJIMP5YjdT7Uz9XGnZcduDwKk+cHPZTxaYrzuB6RgMfeC0ES/
         eoT6Li0Q/6Wo0htarvmCnODtVxhqGepR5faK39+yBVZwQC/vDY9p0i+iDHQkftZGlQE6
         nsSw==
X-Gm-Message-State: AOJu0YweyX72Ha6Xmt2/Ss/MO5RmQ6Sn6aHq15g+WpqG47lsNYQtp6X8
	PjZYX/50MzXuPwTS0+xKfK3f0WCMRwO+9RrmGcMzvNougJNFALWG1GM7v3TXO0Nd
X-Gm-Gg: ASbGnctqSmmidNdBntuiPO2ZvvvJSZpZ8nCQxVpgFU4pzxuVLq2RkQdHnqJiJ4Wlx4I
	n1aQ04W8tF2QJLD+cUKJfwBF//S2QCChfXYBTwGBxnPElZ3q4K6XHBV4bMm7+1Nqcf5FgkLN0kb
	PZRE+9egFkA+pCu+Q/TlcEmLmyilUrDCj5Ru5GBtQQ383iDcXQ1JVaZ5Mg3EHeoqqdmYiHmfmU/
	bupJQ3A87UfCUTbK2+Bg6+frx4Jn/Fy2l5GuIRJteaHq/yvUi9LihgZGhgiRSuHicdJ1oPdHBl5
	+SXwALylaqgGpDR3i1BZQdxnd67/xEoEeagKaQFrxVM5KjigLOu684hxcw==
X-Google-Smtp-Source: AGHT+IGWxWiVmNsmE3zb8SZj9O4lt7fUuOFCC2QsIDQUdiOqfWdcAOhJbGiXoz1atzVu4vBZqtlVgg==
X-Received: by 2002:a17:902:ccd0:b0:210:f706:dc4b with SMTP id d9443c01a7336-23528eedce3mr171561545ad.13.1748863850971;
        Mon, 02 Jun 2025 04:30:50 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23506bcd56fsm68883415ad.48.2025.06.02.04.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 04:30:50 -0700 (PDT)
Date: Mon, 2 Jun 2025 19:30:48 +0800
From: shejialuo <shejialuo@gmail.com>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] fsck: ignore missing "refs" directory for linked
 worktrees
Message-ID: <aD2LaKR-nJVoGMWu@ArchLinux>
References: <1d8f471b6dcb7e952afea834490be195189492a7.1748629208.git.code@khaugsbakk.name>
 <aDp55upE6AhYunz7@ArchLinux>
 <3f731776-9a9e-4c8f-8de9-99d470503345@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f731776-9a9e-4c8f-8de9-99d470503345@app.fastmail.com>

On Sat, May 31, 2025 at 02:17:34PM +0200, Kristoffer Haugsbakk wrote:
> On Sat, May 31, 2025, at 05:39, shejialuo wrote:
> > It is reported that "git refs verify" would fail when encountering
> > worktrees created on Git v2.43.0 or older versions. These versions
> 
> Nit: maybe
> 
>     "git refs verify" doesn't work if there are worktrees created on Git
>     v2.43.0 ...
> 
> The part about it specifically not working if there are no worktree refs
> might be obvious when you take in all of the context here (no refs/
> directory).  I don’t know.
> 

Right, I will improve this.

> > don't automatically create the "refs" directory, causing the error:
> >
> >     error: cannot open directory .git/worktrees/<worktree name>/refs:
> >     No such file or directory
> >
> > Since 8f4c00de95 (builtin/worktree: create refdb via ref backend,
> > 2024-01-08), we automatically create the "refs" directory for new
> > worktrees. However, the fsck code incorrectly assumes all linked
> > worktrees have this directory, thus introducing compatibility issue.
> 
> Thanks for finding that commit.
> 
> At this point in the message it seems like the fsck code never worked
> with these old linked worktrees.  But `git refs verify` used to work
> with them until 7c78d819e6a (ref: support multiple worktrees check for
> refs, 2024-11-20) which was part of v2.48.0.  So I think it’s worth
> mentioning that commit as well.
> 

Good suggestion.

> You wrote on the first email which I’ll just respond to here since
> it’s relevant:
> 
> https://lore.kernel.org/git/a2a50127-6ab9-4d8a-abcc-b1a741df293e@app.fastmail.com/T/#mada29f8b0d02091d21412d8bd57cc666bc657c04
> 
> > > And hope that this fix would land in this release.
> 
> Like I said in the first email the only minor regression in this release
> cycle is that git-fsck(1) reports these errors on stderr because the
> default `--reference`.  This was how I spotted the issue on rc0.  But I
> neglected to mention that the commit that introduced `--references`
> (default) for git-fsck(1) is v2.48.0-rc1-49-gc1cf918d3ad (builtin/fsck:
> add `git refs verify` child process, 2025-02-28).[1]
> 

Because we would call "git refs verify" subprocess in "git-fsck(1)" in
this release cycle, I just want to fix this problem before the release.
Thus, it won't affect the users.

> So based on the last what’s cooking email[2] it depends on if the stderr
> output regresssion from git-fsck(1) in this release cycle is severe
> enough to need be fixed in this release.  Because the `git refs-verify`
> problem has been there since v2.48.0.
> 
> † 1: Part of the reason for neglecting that was that building that
>     commit fails for me.  So the bisection skipped it and couldn’t find the
>     commit.  Is that just me?  The merge commit does build de35b7b3ff (Merge
>     branch 'sj/ref-consistency-checks-more', 2025-03-26).  I changed
>     `start_progress(r, _("Checking ref database"), 1);` to
>     `progress = start_progress(_("Checking ref database"), 1);`.  I
>     don’t know if that is wrong but it made the bisection script run
>     without having to error out with `125`.
> 
> [2]: https://lore.kernel.org/git/xmqqiklhd3tc.fsf@gitster.g/T/#u
> 
> >
> > Check for ENOENT errno before reporting directory access errors for
> > linked worktrees to maintain backward compatibility.
> >
> > Reported-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> > Signed-off-by: shejialuo <shejialuo@gmail.com>
> > ---
> >  refs/files-backend.c     |  3 +++
> >  t/t0602-reffiles-fsck.sh | 15 +++++++++++++++
> >  2 files changed, 18 insertions(+)
> >
> > diff --git a/refs/files-backend.c b/refs/files-backend.c
> > index 4d1f65a57a..bf6f89b1d1 100644
> > --- a/refs/files-backend.c
> > +++ b/refs/files-backend.c
> > @@ -3762,6 +3762,9 @@ static int files_fsck_refs_dir(struct ref_store
> > *ref_store,
> >
> >  	iter = dir_iterator_begin(sb.buf, 0);
> >  	if (!iter) {
> > +		if (errno == ENOENT && !is_main_worktree(wt))
> > +			goto out;
> > +
> >  		ret = error_errno(_("cannot open directory %s"), sb.buf);
> >  		goto out;
> >  	}
> > diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
> > index f671ac4d3a..615b7c0683 100755
> > --- a/t/t0602-reffiles-fsck.sh
> > +++ b/t/t0602-reffiles-fsck.sh
> > @@ -110,6 +110,21 @@ test_expect_success 'ref name check should be
> > adapted into fsck messages' '
> >  	)
> >  '
> >
> > +test_expect_success 'no refs directory of worktree should not cause problems' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	(
> > +		cd repo &&
> > +		test_commit initial &&
> > +
> 
> Nit: blank line?
> 

I would improve this. Normally in this test file, I would add a blank
line to indicate the basic setup ends. So, I should do the following

	cd repo &&
	test_commit initial &&
	git worktree add --detach ./worktree &&

	rm -rf ...

I would improve this in the next version.

> > +		git worktree add --detach ./worktree &&
> > +		# Simulate old directory layout
> > +		rm -rf ./git/worktrees/worktree/refs &&
> 
> Eric[3] had a `git rev-parse --git-dir` suggestion instead of using `.git`.
> 
> [3]: https://lore.kernel.org/git/a2a50127-6ab9-4d8a-abcc-b1a741df293e@app.fastmail.com/T/#mb42bdb046c391f2583c2200668945408a2d0396f
> 

Good suggestion, let me improve this.

> > +		git refs verify 2>err &&
> > +		test_must_be_empty err
> > +	)
> > +'
> > +
> >  test_expect_success 'ref name check should work for multiple worktrees' '
> >  	test_when_finished "rm -rf repo" &&
> >  	git init repo &&
> > --
> > 2.49.0

Thanks,
Jialuo
