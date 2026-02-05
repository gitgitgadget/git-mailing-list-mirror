Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677E33D333A
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 12:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770293931; cv=none; b=uuwG/7EQXN4hLAGSvGdKDqRsqMebuXLTTDYHbvw/r5HMAl8Xy2B7cCVgj2+n4MqFHosdOAOFRYN5p3wf3dcO8UjImgSNZ6p86GBoz2D34ulaRygVkifIvaVIJGh4096PZFMRbLVZcL+ammzwB24IkylwV0OW2EVnY+qA2ua/n7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770293931; c=relaxed/simple;
	bh=Q1dMV7Duhr8MmZVM4H0bd1JG0/MEQSXrf1NOo2/+wCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OppLWijPv8/UvMc0q557d66m9R939/HnrB23zbz8h8QkbsBL48UmoOHW6nprhUs9cS42wYg8Y0kwbU4+k2IntII0YJcGInR4ITl5h/5mT1IEwQ1mhzaFuThJhhqEZsSLCIaiBlMBznUkImgBVMlj7OdMOem+KfjLyWy+IlaOsuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1S6gDBb; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1S6gDBb"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-352e3d18fa7so703964a91.1
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 04:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770293930; x=1770898730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycX7yKs9l0pyKMFb0QVXh3ju3Oo491EsdpBbdzWZPfo=;
        b=i1S6gDBbBHWNaRUbb5jLscAZlq5QSrBZKci+vWeX7N4UdFMiwFFDsZhYt9H6Ts2xAD
         YPZgXF7wT8skfqhtN7r/QkoZ4Ucd9D3Z40ktVkyXPLvHDt9hrGTIKkHXsjgkJdWvM8VN
         KDOLmozf9AR2BB2a49Jb0cctcJEtVZqn964JkBcdvaktFZ84OH6+34ObgS2RM6k+0NCH
         BW5yHpM0qkkqK1VtLrnuEn7sqvDhWXUpPQp5F7Rg5DcDyqp095PuDFQ/Upw3Y0MRz0z+
         VDkjpfgYjSeKSVIWPBoQHrO+GHuWi4X0xlaQ9/54eRPF3VmVG0FwHqj/OAm1FgVoDIj8
         xHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770293930; x=1770898730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ycX7yKs9l0pyKMFb0QVXh3ju3Oo491EsdpBbdzWZPfo=;
        b=q5qRHyB/CwP9eE124cpS4oVu4k7cN+QQ0t58T47KDKgjszDgklmAw43+ROgfoaF2nT
         VBaQnjlPu886YDIbl+ZyygHCswr4LcLr08XMVkQpTgMHBAx0j1Vh7vI6LYP0UVlfUgp+
         KO+dVR6W1VUXBOyYAtE2zSkO9cORoEZT4RfujlMicSA/HvrdX6MKIByvltKrlFaq13/L
         u6f9OyVqrd2QbnSqNHneJ+MKHubLb4YUBoDaudNcQ8BoThLAMtqCz/vqR8JeoNq8BgIR
         FAqb44+oRHDUpyQzh5FFP2R3MyhqoGbipzmNejdxbnHgxqwyRN/LO2CDff5fWNft8jSp
         LCoA==
X-Gm-Message-State: AOJu0YzlfFfkU2MimFCQmXE/aGnktQBpKPgvw3qecP/Cl04NcJoPWxFw
	kKVA1UTwEiab0mlr8PCinyfbYJg/ZpAAW2FJTCwZmeAq/gTP73Z3fnxlnmsGzg==
X-Gm-Gg: AZuq6aLs+hiW0kx7HyWZ5FjJ1FqHWgVqSrcoF4CM8AmUe4RMgIepJ3Ud7MvK2FobgoM
	JqTday5r+kp0P8IBNnAl2O+d1JmzIn+F3LdvSP8tnPqJBDDMZa1qGilHs/r/hSPimX+5zFrRh+X
	GZZBeIOL5wNLbdtZbmUPcFRz1/DNQG4B2zDrC5FifD6sgNh6Q/JnognZJaMPk80Rupt9Im8J8Ty
	7ummhC4zYE2cBY2FMO773wUTLv7hdPNv02W0KiKEJ8DEnqEXcKMyeab6b1pnSUxqxf8wGLcnQ2T
	ZhYc+OhQsBUaqjobRMaa98/kJtM4Hm5Pe3zj9pQ8yQwgRtdjAb+dNSBWVAUk0qbVgkwI94LJiSX
	TqehUbW7jsX/7sNfiP8AlEj4V6OxZ3xs4lQG0lSTRUgax47B3KejUG8gKbc0iqGNPvfonbdSQsK
	vX/CW0LxRtuRK2upO+p0rPh9iMdjaJ7c5qHRcGzoZh8ICNQQ==
X-Received: by 2002:a17:90a:c10f:b0:352:d59a:b28 with SMTP id 98e67ed59e1d1-354871b10bamr5621148a91.19.1770293930583;
        Thu, 05 Feb 2026 04:18:50 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:312c:955:7bd3:104b:5765])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3549c28204esm2500133a91.10.2026.02.05.04.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 04:18:50 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com,
	phillip.wood123@gmail.com
Subject: Re: [PATCH V2 1/3] wt-status: replace uses of the_repository with local repository instances
Date: Thu,  5 Feb 2026 17:48:27 +0530
Message-ID: <20260205121839.38752-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CAOLa=ZTFUZF_8YFk=TkMXVYptP6q9_bJRUoBYYsjCMW02NKc7w@mail.gmail.com>
References: <CAOLa=ZTFUZF_8YFk=TkMXVYptP6q9_bJRUoBYYsjCMW02NKc7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

[...]
> >> +	if (strbuf_read_file(&sb, worktree_git_path(wt->repo, wt, "%s", path), 0) <= 0)
> >>  		goto got_nothing;
> >>
> >
> > So if you look into `worktree_git_path()`, it has a certain check
> >
> >   if (wt && wt->repo != r)
> > 		BUG("worktree not connected to expected repository");
> >
> > But this is okay with your change, the only question is, do we know wt
> > is always defined here? Unfortunately, wt can be NULL here, in the same
> > file we have:
> >
> >   wt_status_check_rebase(NULL, state);
> >   -> get_branch(NULL, ...)
> >
> > Which would crash, no? This is applicable for other parts of the code
> > too were we're now using wt->repo.
> >
> > This is also what I was requesting in the previous round, about
> > explaining why it is safe to make a particular change.
> >
> > [snip]
> 
> One question, did you run the entire test suite with these changes? I
> would hope that we have tests which would fail if my inference is
> correct. If not, there's a gap in our tests too.

You’re right, I hadn’t run the tests initially, as I assumed
this was a refactor-only change.

After running the tests, I do see failures, which confirms the issue.
I’ll make sure to always run the tests before sending a patch going
forward.

Thanks for pointing this out :)
