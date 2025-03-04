Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C236F200BBE
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 12:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741091147; cv=none; b=BREnS3NxYRDJO19Fi1WdoyG0Qn63H5Wapic6snecnHaPzPmYnVo2dN/EdlKzsi7+iAai05ywuYitEihYN8R+1GCb6yzr/Cj4WmXzoPTyXtH9VR/NXLjRzgMGW8AbKNcKq/9w+KhIhS7Ud0gj/3GLBluKb++ogPyO7etGsjvsJJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741091147; c=relaxed/simple;
	bh=Pht88gFTnQCYmW9FU4fJs61mPL7ESEQJIjNBQmlTwQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vs4+QsvHDvqIhW51su+nro/9RC3GSXoozbwlKgsfj+GQOa/nazaex/CnUCg6AGrSxG5ovKRAreccUShstQ1RhvpvHNGvmzvS47SXKgJ2Aga+4k2JCF8rFLZMCBImZosstcp3q0qu/rUHtC+KMv4mUF5Av/4oi6x4M9K8W1WDBMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrobEx2f; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrobEx2f"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2235c5818a3so69794755ad.1
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 04:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741091145; x=1741695945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PgdIcZWOh1vxNc6q6O7xY5lj2llvvGqwLbCxG3GaOyI=;
        b=jrobEx2fRP103y5ZoSK++feUl1FoydL9wmoG6gzK6P/DHOZPQOt1D7ahNVpPDu8fK3
         Za/MLlVZ8dNx72H9BsxQSp/AJAFaq1mO7nScI40Q0ltKqu6BzkgW0Ceis32oECNbYM+R
         lmXKRJmYsyVNyzkQ/z3csD4il5yMwaWt8a2oLa4sycF+Tk01xuZnue/nH+KV8JWOw2iZ
         cjk05J2vgy30ai5j+KpSuj9Oq9/qp99ewmJoZWdMv9kevpoEO/2UAYTgKAQFyY41AUCn
         PlUcJ2QdYlF+fQ4KEI4H+4f5wdN+KrIj8Xu6Dob3QCC+RYakDxS45m+Pnlq/X54YT5+m
         inJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741091145; x=1741695945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PgdIcZWOh1vxNc6q6O7xY5lj2llvvGqwLbCxG3GaOyI=;
        b=qrVAnk+iKalh+7mh8a2gu3P0IpdZZolFXE6gF4OUe9qw+fbrf1zQTioIPivUnGT0uf
         rOv4HCxKHLVoYbAn9Lp4ZwIOpX4Nds/EAeum1+cxot1VJU2rAxJ0xDzaTNgjdKQgWf80
         MKK970upiJwzcZNASLo+RVfcqAjGSAayKKIUX9KP6N2arX1FXLHqxvQg7kV1mohQq+4R
         4nqCnQahe4uZSCfquU9XN7DszX7+0TiMIEXGvZnEzwOU4M/GED08FU8/34tw3UuBUsEk
         nopldDrTHYpl3vFJf6vE3rmiUZSeOg3CcG20kkVBIe+i1+MUuHLZc2ESb9z8Wpy9vQL6
         xesg==
X-Forwarded-Encrypted: i=1; AJvYcCX4bb6JWFILLz2YYHGqF1z8i5AoSQxtlcPzdeDBnJ+3YHNvy66Iw9BaObktLImpg4iB+ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPqTDSStBrsB+CvXD8gw1U/kjxUJJZO0u6ztVEPzEw/XvFNOzL
	QAOzNoq5zzqPGyNd3FI6dpeC4qt8Y/AJl4P46fNUyIGMSNv5Whtu
X-Gm-Gg: ASbGnct/rcwmAcb9isnpYlhYThCj8Yk8FFtVSUnkYBxWuG0LzjXUb6fdzz5pPqn9PxM
	2xbCPO05ixXMB5wjBVs7IPOvqm02s1qnjqzS/Qtc838DR6epXsH8wpqhIccU/aqU1684Fu4twaH
	EiBvdW1JEeVN5jgFFw+R4vrsOeUCXSP8/uwQLvU2mpjPZqsKRzFmMg5wxcnoXGkNjc4bs2K6kHy
	rpYV3iy2D9dbkit6qdcVsqnhW9eyNxh5WjIuOHLKO8zPBfVxKKk6IeMT1Z+7n6Ihj9aNgyb1zyB
	DFPJvMKR2VIdqII5lTLL3F7RHJbjgn4UIWSt7RFG
X-Google-Smtp-Source: AGHT+IHxn+3kqtTL6djkAYUXzgQhwpY/AJo7Oq4j7SdvYja55zpAEwVr47x2opT9i0CFQff6uwavVA==
X-Received: by 2002:a05:6a21:48f:b0:1f3:2e0d:4110 with SMTP id adf61e73a8af0-1f32e0d5e68mr11392441637.29.1741091144922;
        Tue, 04 Mar 2025 04:25:44 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-aee90c7e519sm8070016a12.61.2025.03.04.04.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 04:25:44 -0800 (PST)
Date: Tue, 4 Mar 2025 20:25:44 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: What's cooking in git.git (Feb 2025, #09; Fri, 28)
Message-ID: <Z8bxSEJgaz_aZAfW@ArchLinux>
References: <xmqq7c591sus.fsf@gitster.g>
 <Z8XJnJEHZd1dFE96@ArchLinux>
 <xmqqldtmvyfa.fsf@gitster.g>
 <Z8adWTssWtaNTfx4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8adWTssWtaNTfx4@pks.im>

On Tue, Mar 04, 2025 at 07:27:37AM +0100, Patrick Steinhardt wrote:
> On Mon, Mar 03, 2025 at 09:03:53AM -0800, Junio C Hamano wrote:
> > shejialuo <shejialuo@gmail.com> writes:
> > 
> > > On Fri, Feb 28, 2025 at 04:45:31PM -0800, Junio C Hamano wrote:
> > >
> > >> * sj/ref-consistency-checks-more (2025-02-27) 9 commits
> > >>  - builtin/fsck: add `git refs verify` child process
> > >>  - packed-backend: check whether the "packed-refs" is sorted
> > >>  - packed-backend: add "packed-refs" entry consistency check
> > >>  - packed-backend: check whether the refname contains NUL characters
> > >>  - packed-backend: add "packed-refs" header consistency check
> > >>  - packed-backend: check if header starts with "# pack-refs with: "
> > >>  - packed-backend: check whether the "packed-refs" is regular file
> > >>  - builtin/refs: get worktrees without reading head information
> > >>  - t0602: use subshell to ensure working directory unchanged
> > >> 
> > >>  "git fsck" becomes more careful when checking the refs.
> > >> 
> > >>  Comments?
> > >>  source: <Z8CMx7O19PMs9sVY@ArchLinux>
> > >
> > > I think I have addressed the comments from you, Patrick and Karthik.
> > > Could we make the patch into "next"?
> > 
> > Mine was merely a small kibitzing on the logic flow structure, and I
> > didn't really looked at the larger picture beyond that part of the
> > code I looked at.  Let's hear from Patrick and Karthik (cc'ed) if
> > they find the result of the updates satisfactory.
> 
> Yes, I'm happy with the current state of this patch series. I'm a tiny
> bit worried about the new call to `git refs verify` in git-fsck(1) being
> added this late into the release cycle as we're now exercising a bunch
> of new code with only a few weeks of testing. My basic assumption is
> that mostly noone uses `git refs verify` explicitly right now, so all of
> the code we have introduced there over the last couple of releases did
> not yet receive much testing at all.
> 

Yes, I also think that there are few people who know the `git refs
verify` and execute this command. That's the reason why I want to
integrate `git refs verify` in git-fsck(1) thus we could get feedback
and improve the code.

However, as you have said, we are also taking the risk.

> So while I think that executing the command in git-fsck(1) is a good
> thing overall, I would feel a bit more comfortable if that last commit
> of the series landed in the next release cycle. But maybe I'm just being
> overly cautious?
> 

Yes, by dropping the last commit, the risk would be reduced. Actually, I
don't mind which way we choose. But I somehow think that we should
execute the command in git-fsck(1), we need to get the feedback from the
users. From my point, I want to know how do the users react to the new
aded checks. Because we have tightened more rules, some may be good and
some may not be reasonable. And we could improve this in the next
release.

However, as I have said, both way works fine for me. So, I am open.

Thanks,
Jialuo

> Patrick
