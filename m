Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F26200DB
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 03:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728272706; cv=none; b=ZAkOoyVJVLviS0IK/MoQZaUPUWPOA6cCOTA6V7V6gxEBASRDB7++lcbunRk2HgipDd1PaTK9pmDzhK6x8aZcSq/mbUNzL/Li2+/1RadCUXt866Dc7lKjyPpUIW7MfIYNJhC3rhDKcwCv+s4axwqn5TKRnRANnF7Tn4t7UxfNKfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728272706; c=relaxed/simple;
	bh=Kt8D46RwA+G7OiCjh+9jWuxtfaJpTeXdoZA1pBcczok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vtbpd6m1RQZVwTJnra9oqF2JSRzOvUOcZuZokznLo9B5pncsRMZBzFJTAanPyYOa3zgIH1bVa1kyLE1Pyx9O/z7SpXVgXI5jDuFIFE0BIZAdhDIRcaDNT6JwSXnpzecp/BJBw6TXUplKgE1/1bfEpmM6kQ0UUrpEFC4svbrRfqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSbAy5Hr; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSbAy5Hr"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71dec1cf48fso2042590b3a.0
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 20:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728272704; x=1728877504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=71ZvA86Vtkwrugd5psS8ztJC1akSQjbBFqwlUeGAJW8=;
        b=kSbAy5Hr/ST+AkhBt8BlkOJJwnCiyMJ8lk6pIeaX53OFQk4rbJH8K/c0BStxKK9r1D
         FeJhUVROHs2W5qzxgGROwdhBFxm7qpODafBQVawxstX7wXYH3K+6sn/9PLzZP7oRdX9W
         erry0oVdz5Nro0ge60hdit4qqKO528l00DgVrZpAaqtSYACALxj/WaYr+SAduukuQl5s
         BIM5OsR8KEdMdhwqKvcYBl+1ZXjOXpaoIC5ZO44D2Y/mp7TxXJjRoyI+kMkP7NGGZ8qA
         D/caRmI08olhIE9cucFNEoAAB13+D6Y4vrGVDHzgkcjK8R0SlBf7XVBZUNc7fjE+sM0R
         R0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728272704; x=1728877504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71ZvA86Vtkwrugd5psS8ztJC1akSQjbBFqwlUeGAJW8=;
        b=iQbxCxnCHzKYZdTk4/14Ts/SgFCAIZhcokMNmB1MV3axtiU5kctz5zJlFd4tZjCOJ6
         nXOdLLQWqRG3yISPGpqaT7I2dhcS5vsa52/fGu7kUfEtKvNFiKXu7T2CaMSdz/df9unM
         8smI8yYZkhZZKS7lB9IUOENI0627jqOnp3zNyTt39iC2Dxb8tfKs83CsBw2EIBNXI8Ad
         LJGmmriN1wgKV96Y3jhB3tvKzCH84FjC5ZK1Wtne57nUlTf+ucBgpdSafKLNZye1JHYd
         W5+mtEnrj/uMCoVhdpJtCwkZL3hcocaGxi5yZCnxDvLYO1sycrW6a1s6YuHk0Bmh29Gr
         V8rQ==
X-Gm-Message-State: AOJu0Yz4uJtBMbmh5nTEixxMDiKY+42uX8muYaeTFrRWfTu5P3bkdwQR
	l97hZxGtNjPduL6ObRxsoJIRPgaqPehJMajBZR/lOP18rT7FoSHZ
X-Google-Smtp-Source: AGHT+IEt14pZlrZxG4OoZLoRj3XHuW/eMlkXqOE3RNHnf0h36dhUrMzdrF+KZKDRY0FWk6IW+M2prg==
X-Received: by 2002:a05:6a20:43a0:b0:1d3:293d:4c5a with SMTP id adf61e73a8af0-1d6dfa4278bmr16274317637.22.1728272703701;
        Sun, 06 Oct 2024 20:45:03 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d4530dsm3461742b3a.102.2024.10.06.20.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 20:45:03 -0700 (PDT)
Date: Mon, 7 Oct 2024 11:45:09 +0800
From: shejialuo <shejialuo@gmail.com>
To: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] worktree: link worktrees with relative paths
Message-ID: <ZwNZRX1LHlxawJJc@ArchLinux>
References: <20241006060017.171788-1-cdwhite3@pm.me>
 <20241006060017.171788-3-cdwhite3@pm.me>
 <ZwKuptTMf9ECd-kf@ArchLinux>
 <I3BmSHTyOELt2DzfSaLhRYLouu5iAPZIZGZ2Ne73AygO35CM0mq44INa68t6VD4XV61DgzbrfUW0m8fivd3N9Rejgm-tecXQHXQRs1BP9CQ=@pm.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <I3BmSHTyOELt2DzfSaLhRYLouu5iAPZIZGZ2Ne73AygO35CM0mq44INa68t6VD4XV61DgzbrfUW0m8fivd3N9Rejgm-tecXQHXQRs1BP9CQ=@pm.me>

On Sun, Oct 06, 2024 at 11:57:22PM +0000, Caleb White wrote:

[snip]

> > Still, we do not need to call "strbuf_reset" again for "tmp". But there
> > is another question here. Should we define the "file" just in this "if"
> > block and free "file" also in the block?
> 
> The style this code uses seems to place most / all of the declarations at
> the top of the function and frees at the bottom so I think this fits in.
> 

Yes, as you have said, the code style places most / all of the
declarations at the top and free at the bottom. But the trouble here is
we will free the "file" in the "if" block.

    char *file = NULL;

    if (...) {
        file = xstrfmt(...);
        free(file);
        file = xstrfmt(...);
    }

    free(file);

If we want to follow the original code style, should we create two
variables at the top and free them at the bottom?

> > And I don't think it's a good idea to use "xstrfmt". Here, we need to
> > allocate two times and free two times. Why not just define a "struct
> > strbuf" and the use "strbuf_*" method here?
> 
> I can use strbufs, I just wasn't sure if I really needed a strbuf for
> each of the paths and was just trying to reuse a var.
> 

You don't need to create a new "strbuf" for each of the paths. You could
just use "strbuf_reset" for only one "struct strbuf".

    struct strbuf file = STRBUF_INIT;

    if (...) {
        strbuf_addf(...);
        strbuf_reset(&file);
        strbuf_addf(...);

    }

    strbuf_release(&file);

> > > strbuf_realpath(&repo, git_common_path("worktrees/%s", wt->id), 1);
> > > strbuf_addf(&dotgit, "%s/.git", wt->path);
> > > - backlink = xstrdup_or_null(read_gitfile_gently(dotgit.buf, &err));
> > > + git_contents = xstrdup_or_null(read_gitfile_gently(dotgit.buf, &err));
> > 
> 
> > 
> 
> > Why here we need to use "xstrdup_or_null". The life cycle of the
> > "git_contents" variable is in the "repair_gitfile" function.
> 
> This what the existing code used and I saw no reason to change it...

Actually, I somehow understand why in the original code, it will use
"xstrdup_or_null" to initialize the "backlink". Because in
"read_gitfile_gently", we will use a static "struct strbuf" as the
buffer.

I guess the intention of the original code is that if we call again
"read_gitfile_gently" in this function or we have another thread which
calls this function, the content of the buffer will be changed. So we
explicitly use "xstrdup_or_null" to create a copy here to avoid this.

But I wonder whether we really need to consider above problem?
