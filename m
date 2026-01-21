Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CC6366DCE
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 10:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768991417; cv=none; b=rJuNQOO217suSLHGnAfc1W7K9T6YwLRzY+n1VTxkcCSfyRj15O0m4gQ56XnBlpW3uw69vzkCxSpEz8r4mQlZYjSXQp+wei5lRo7H7OtMnwbQCmoT2IMHNueMZPBwM7EkgPkeoXLY3wZtIUkdKqt8zjyUMAJH2xgC/z/CHmDdcLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768991417; c=relaxed/simple;
	bh=djXfgmtc+PG7raKrR0pD5DM58sBN56tXTGovywIIN0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oWJUkyTqaYfn/Lu6l23hl2l10C4porr0l6Xhku39nz29mq+baGfAsyAgYWtJq/Dgz0I5ErY9WtvpGdp221sOCUHTGD1o34zyfV+Dpd/KTOrwfJU5yvI8f5bJ53TDKtUc/827Uawx8p8dcLDOPliNeUwAEx+oNeKMpfeu3hn0w08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0AT2iDf; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0AT2iDf"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-81ed3e6b8e3so3085779b3a.2
        for <git@vger.kernel.org>; Wed, 21 Jan 2026 02:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768991414; x=1769596214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WapHS9fGsh+438osiq6oeJhIGWZ1I5e3kumC9FZyMCc=;
        b=f0AT2iDfpnJ353UscQvsRvSnskWI5Nj+IltMG9PfCBzKLs+Q/YgJXxCiAy7jYJJ7rn
         khkgEAfp4P/pLV9JLm0TeLJ94AM3XIvnUBTcFDUooySsDlTiiqOSy+Ow6Bh7vvdQY8Lj
         pbGU8XfepXDI5EADpzn73gMNucmR3AANPZgGdup2SUeW50WK2FbwGwYe1R2YRe0iQmzj
         WCX18pz60DOPcZXrWLRX5sl5+w/E0kg/tj9IqEUDYMMwWRKIX7VOza5NNg6/Evc/reTK
         wB3QW1gWAJAfYwxbX4R5FYSB/9sZzw2xMdz0mBjQii4rA5toElpE6LEZQm2Qk1C8Ix7T
         Shiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768991414; x=1769596214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WapHS9fGsh+438osiq6oeJhIGWZ1I5e3kumC9FZyMCc=;
        b=ijYJ05AGyjH1nVHbDB1yzRsBns/2DOjTAaDVzycsHHzPgQx5dqYHtsUbg8pLpIpfag
         fMVbm9LOEu7+R+26wdtH6BxSRLdjlZmS+dX5XWwJeU17uM8dthMfCX1DeRo7ggDmGxce
         lb65KQ9oVMevxHiYk/FtR5M5LdMvTuvPUybdc5N4qW8lRIa4yh1/IxpaxItzmQZJy35g
         3YqvTedjTlKJhyByWBbcDHcE75uzh8sCcJE2bVt2/7qwgj4waNat1LkEj7g7J4RDX3Vu
         2OqxTNZ7rgYbFfisP6Frh50UmKi+kvNjO3uQgj/7DReA9s4R+xYUmX3SUVnnfd1XsXKb
         C3AQ==
X-Gm-Message-State: AOJu0YwJwgcqI24arWh7dZS/xptT7nr9eIiunyyTznozS9xXKHUa1Akp
	63S35K94eQIg4ZEXd49t/URFwLFuzkk9gxk/X6MUFouyVqXrHs63hN0o/PMM4w==
X-Gm-Gg: AZuq6aJK5hA6tzvWi1X7PcHsFDULNe+1Ufv65jehJmmvUv++rInH4SwpkO33x+B0Qzc
	S775NKvBiwRsgbR4bmCZZLiE5PTlQB3Y7d9SdqLh8VuNzosTXM7oWUNVD30lxhpwOB08wVWLzx4
	SHXhpjcIBKT8e7QhStWnINg+XqY4WovFPj16rBHQAgVy5GOf/VvNIY9b+NRA78OSG4a1FM05hJV
	OKlD559LUhMD+48YFUIOqW99rfc+AI4CatCVXtd0A4UM4SI0Eui2h+biqBfufH7vMcGBI+MebpJ
	9CoCN/fYbYurQZcvX+ndh8bePgwR8jhf7XWUfliL8/Dgp+uGewmvtX5pYtOKmnEqol+JipKDpCF
	hhm/nflQhSzjULsHSsyN5j0g3DsWAcAxGuaAVMYHk5X56DsyftaV0Apch+ZUvLhP5ozOyun+Vuf
	/AxUO23390Cj7egW9Py3XP+F/79qsbSASdMGwH43l/vOKnlg==
X-Received: by 2002:a05:6a21:6b05:b0:38b:e430:156f with SMTP id adf61e73a8af0-38e00c001f8mr13763491637.20.1768991414362;
        Wed, 21 Jan 2026 02:30:14 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd7:6181:4ac5:7f6c:c462:4847])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf32d82fsm14136958a12.19.2026.01.21.02.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 02:30:13 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com
Subject: Re: [PATCH 1/3] show-index: implement automatic hash detection
Date: Wed, 21 Jan 2026 15:58:34 +0530
Message-ID: <20260121102956.759871-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqqzf68yx75.fsf@gitster.g>
References: <xmqqzf68yx75.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:
> 
> > @@ -71,6 +60,40 @@ int cmd_show_index(int argc,
> >			die("corrupt index file");
> >		nr = n;
> >	}
> > +
> > +	/* detection of hash algorithm
> > +	Only works for small files, i.e without large offsets */
> > +	if(!the_hash_algo && version == 2) {
> 
> We have one SP between "if" (and other syntactic elements like
> "while") and the open parenthesis "(".  End-user controlled function
> names lack this SP between <word> and "(".
> 

Got it, I will keep this in mind.

> For example, ...
> 
> > +		struct stat st;
> > +		size_t file_base_size;
> > +		size_t table_size;
> > +		size_t size_rem;
> > +		size_t hash_size;
> > +
> > +		if(fstat(0, &st) || !S_ISREG(st.st_mode))
> > +			die(_("unable to detect hash from non-regular file"));
> 
> ... this "die()" does not have to be here.  We can just return
> GIT_HASH_UNKNOWN and let the caller fallback.  Does the existing
> code correctly complain when the filestream is opened for a
> non-regular file, or it just gets totally confused?
> 

I believe there is no explicit check for
irregular files in the current implementation.

> > +		file_base_size = 8 + (256 * 4);
> > +		table_size = file_base_size + (nr * 4 * 4);
> > +		size_rem = st.st_size - table_size;
> > +		hash_size = size_rem / (nr + 2);
> > +
> > +		if(hash_size == GIT_SHA1_RAWSZ) {
> > +			repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
> > +		} else if(hash_size == GIT_SHA256_RAWSZ) {
> > +			repo_set_hash_algo(the_repository, GIT_HASH_SHA256);
> 
> And instead of calling repo_set_hash_algo(), just return the
> constants so that the caller can handle it.  And 
> 
> > +		} else {
> > +			die(_("unable to detect hash algorithm, "
> > +					"use --object-format option"));
> 
> ... this also can return GIT_HASH_UNKNOWN, without complaining
> anything.
> 
> > +		}
> > +	}
> 
> So, instead of inserting all of the above lines in cmd_show_index(),
> we'd have something like the following ...
> 
> 	hash_func = auto_detect_hash_function(0);
> 	if (hash_func == GIT_HASH_UNKNOWN) {
> 		warning(_("assuming SHA-1; use --object-format to override"));
> 		hash_func = GIT_HASH_SHA1;
> 	}
> 	repo_set_hash_algo(the_repository, hash_func);
>         hashsz = the_hash_algo->rawsz;
> 
> ... there.
> 

Yes this is surely a much better approach than before,
I will implement this as a seperate helper function in v2
if we go ahead with the detection logic.
