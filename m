Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B5221ABC3
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741356886; cv=none; b=V9Jh6++umt4rQjcBRGwaH9FBpcmxaQvi8tYVXQp12G+uFXv5xyFOSPdS8IrHVVfyqZEbgwYWgeUHvT7MDojaNxy5Bqe128TEqZQaIPMZEq04KGzUafBTcsyA10KvPbIdwuIU+HetrPni/Q7erIjqzbZdd/GL/vqR4sq7+gbj0Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741356886; c=relaxed/simple;
	bh=HAMXtnFXlD/xBJHLrKDBse+ixtsC1kicXXOpxIoYIuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1JAXIF192xyevKxRFSHWvHEpxC8NckDXwg2FuxKcGt+WzpU9HkaStzsDxwAOYj2msopzeOOsz722EFnqZyWVMEqTLt8yaChIt2JThV9tzhuadYOPr8zdvuMs4zrJtH18wrtAKu4Bk0fqL03ubv2d700st6p10mlpYEwIFbvyyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMfZc83J; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMfZc83J"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2feb91a2492so3392892a91.2
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 06:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741356884; x=1741961684; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HAMXtnFXlD/xBJHLrKDBse+ixtsC1kicXXOpxIoYIuw=;
        b=CMfZc83JtOSg614aYl6quAjwWWMiKENfnEdSWn0NFWW64Pe/PTHO7miOBTup0/9/nD
         qreAfBBVnspuUrqgLg3jyuurxScx2V5JtpRmHdfbXmKJCmwyuYbQAix3RShx5XTBLrDc
         JKIs5Py3lzZn4imqBkWW1D3SHVknRSZ1iJU39zok01KSWTdqIEEdMESIOcE2jgbfgbmT
         bDz/eO42OJkKuoAR5KURmo8FidZA6debDwKElEPa3asnyxunJr1dr8xTYeivhMYO7oa1
         JjwRQ7I0ulBOwnXw3lAyOnIjk2tVWCj0JCflJZ5t3T1SH/RmNVq1LTd7t5JD2ZdeZdI9
         HO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741356884; x=1741961684;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HAMXtnFXlD/xBJHLrKDBse+ixtsC1kicXXOpxIoYIuw=;
        b=n8c3HuMg9EzDYvtXmfCI6byh/lzDn8HDEZU88hGQLTn0mFZQuJ4Ax/fz6Tfx1eY6tT
         E4QMDuCYnoN3JOVbCRiuIWiu85UMxq0g3jfcwryEi0FQzYKIKmt2MOnn7PFsH3hIE1oG
         Vbz2wf0jIsNtUG6hSXSR8yFNtBEdU47elgNCHcLFnuF64xhyvyyjDZFffu45cB29Xq3y
         LwfpWihGM1L6+nCpYZPU1yU3QLhHuVEfLLpLsv3nqv+e1LBJKLCJcjGvJAYCGQ2vlRuf
         pAxgTiY8OmE4jh3ePoyWFTQmWi1PxlxS7Xh+PbuWUcQTw25WTZZi1Srw9eGo/xNIBYLV
         IPSA==
X-Gm-Message-State: AOJu0Yy/Pek90HXhrRTh7SzabKutVViKXxI4tBxKL6hr8jWQ2w6vdPqF
	iFcJqD3YRJKzehiRV4cNeUuMiaw+cv+SfZtjkjSyHLlaNvBrhetGVqiuWLeJioPV9+LHjhyGOSg
	VpoFG6JZzqZHlkKb1BwnhY2zH/Yo=
X-Gm-Gg: ASbGncsESuB8OMhVqcFA8x6YgJpTorDgjRc5rhVNjSJ8b5hEQPAWCOUHl00344j+OZH
	dKyQs8B5SW+HQnCyanqjd29EVSYbu1W1bvgYKMi2Fad4n/SGsmBq9FS9MboyXJV/KqsdC4uQf4Y
	UiT8zSQGrcGNKZHaLEjRbqg8hELTc=
X-Google-Smtp-Source: AGHT+IHKTrfxmhOWKdpqSR21ejodGDSnwk/peCiZYgwXsxdIUUtGOlgWgVUdXRpjCZD8a5jHol1xfUhknv5MKLCnd90=
X-Received: by 2002:a17:90b:384a:b0:2fe:ba7f:8032 with SMTP id
 98e67ed59e1d1-2ff7ce6ec12mr6081742a91.9.1741356884418; Fri, 07 Mar 2025
 06:14:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305104650.238392-1-ayu.chandekar@gmail.com> <Z8g4dTSFQDTi9ueU@ArchLinux>
In-Reply-To: <Z8g4dTSFQDTi9ueU@ArchLinux>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Fri, 7 Mar 2025 19:44:32 +0530
X-Gm-Features: AQ5f1JoTLmC8sHv_2KWVWTpyNVdizSoi4Y-CST4TSTR4oM0Oe2q4BsNamFeUQkQ
Message-ID: <CAE7as+ZEKE1P_va8e6=nT1SvFoGd+nNJXxZzNoyTJmaQcDBoXA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Discuss_GSOC=3A_Refactoring_in_order_to_reduce_Git?=
	=?UTF-8?Q?=E2=80=99s_global_state?=
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im
Content-Type: text/plain; charset="UTF-8"

Thanks for the response!

> Although there are few callers calling `have_git_dir`, I don't think
> it's a good idea to remove the `have_git_dir`. This is because we need
> to reomove the dependency on `startup_info`. It's not an easy thing.

Oh, I will try to study more about it.

> I somehow understand what you mean here. But "shift" may be not
> accurate. When user sets the "core.*" in the command line or config
> file, we will parse the setting and sets the _global_ state defined in
> "environment.[ch]". We don't want to use these global variables, but
> want to put these states into repo settings.
>
> So, we do not shift core.* into repo settings, but shift the global
> variables which are related to the "core.*" or other settings to repo
> settings.

Right right, I went through it after your response, and understood
what you are saying.

> I think you could work on this but I don't think this would be a small
> patch. You need some efforts to figure out the solution. You are on the
> right direction.
>
> However, it's hard to suggest which files you need to read. This is
> because that for each global state, there are many files which may use
> this global state. So, you'd better follow the call stack to know which
> functions you need to change.
>
> In conclusion, I somehow think that you could first think which states
> you want to change. Try to figure out the most simplest global states.
> Classify them by the complexity or difficulty thus you could write a
> good proposal.

Oh okay!
I was thinking of creating a poc patch to get a better understanding
of how to approach this during the timeline.

> > Also are these patches ([1] and [2]) an example of how the project
> > should be carried throughout the GSOC timeline?
> >
>
> Exactly.
>
Thank you so much!

(Sorry for the delayed reply, I have my university exams going on this
week :') )

Regards,
Ayush
