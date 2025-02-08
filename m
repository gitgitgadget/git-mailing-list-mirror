Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6F3194C86
	for <git@vger.kernel.org>; Sat,  8 Feb 2025 04:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738989904; cv=none; b=gcix3gHqzfDvCWEqtp9XGy3hL0KQL6CoTEz/L0XWAPnSJq7CBGbvH3mrt6RONgP+WTJCeAoMKxnEbnbXtO8BsBcgSgru3afK+6cG2QEZMwUn34dKiZD5sXiwN2MLN6OXhryYdXm5iArgt6WKPjjfpyeQ6Kw/qtGMHw04mtNAMPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738989904; c=relaxed/simple;
	bh=JUrWRLQFl4ZP9GQrWudqqSKBNRMj6Tvz4H/XoamB4t8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ei1kgT+pXbY4MEOKM+KPRFGmMwtR6r8xwifABt7DOSPsXQRIXgKX9OTU7H43KFSdvuCMQWYoaNJqeUsVnQqg/QXepKRZ7jRu6xpV0XPtVkTwy55OH+sO5dePi1Wbypg5iRRhNPzSu4YAeNk85mmMYxH55pZ90S5fF4FDMKQtxXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOnb8BG+; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOnb8BG+"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2166f1e589cso71610605ad.3
        for <git@vger.kernel.org>; Fri, 07 Feb 2025 20:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738989902; x=1739594702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q2xf9uJyyjiL2pGLulxw38ecebpHj0G9aSYL9UafZco=;
        b=kOnb8BG+mL9TP+8eGuB21CvlPoT1xmpaASFAvPm/KB2UiGMvQsHqlppOyutofUpHpv
         cZ3rs++nKyFawaJW8f7KV2/fVTyaOcoWdKbNmsoqB6qyQThfGLRQwWPbNsk/dobSL8O3
         C44MLnWJci0N4VaI2OsXdEKhDas/l45D8cOYkGuVIquj/9lyAe7FmMWCfi+mnU7HMwOh
         yWBIJj63uhkrmPnTpDlWPQaJrZxkwQsMEnZvzrKKkm7FkF0TB2UA4il01cW3mNBLptFq
         cJqvwd/EpgnCquDWMWiklPaxn2Zt84a5sAd2xSV4Q5WibeHB+HMG6YjVf/hufhmWIPel
         sWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738989902; x=1739594702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2xf9uJyyjiL2pGLulxw38ecebpHj0G9aSYL9UafZco=;
        b=EwGko5/Zhk8sDKHdBs6/70IxpM+Wy6wCIGiYCSMfwVcZe1eFHbHjmCOYnNi0tj35YW
         q9gsM7KjwFhVUQg9etlKXeY4mJ+THxUMYLYdfcf9NUw/wwIZ/xX25xRvaV8dgsLb+hKv
         GA5BbNNGoMHIUxCEaMBF0K6PtOG3LTjZj1gttyRbDpePOy+7Att00U3f7PVbpR32DilY
         5q+OumL2m05YSVP7GiJpvDQlayFJ98yyvebqb40mkOPkxY3bC8pCSC5+ZOS2FJmkXnrh
         CsidFz8lbFQjdg3NYC2t3jWCRkke8fZfrsFBp8ufBoyA1j0JAzedXZzj7bpBiNsPeuCz
         CrAA==
X-Gm-Message-State: AOJu0YwTPWAisSWWKsE4FOHu/WemmBZuqZ8iiLfuMK4CuRnitlmvDaOv
	6ZYuGnu5W3ou+wVnzgPhAFCDFP2ytJ5Sw7G2KA9ur2LfF2dDVbU5
X-Gm-Gg: ASbGncs9Oyd2XvEJjuhrRMC2cbGMu8EuswTPONYvU4kOdP2Ha1erEpDyj8Otb2ikgWN
	9wPRdB5dlw4M33F63nmXMQ+wVB0tEfcXstfghsrNM/U1WrOKftNrRalZNFzi38QUHQsmpPLGHJE
	mdZ9SgQ0+ISHyudzSc8X46mzz01538l+I3ZMBEWCnHgA/TVh3PXnZXsT+D+c4Gumj28gjxTO1Iv
	zSKNpGXfRWoop6ni2+7sYz2GZ+Tp2cGdvSATA3TKy4biJucOF+GpL1tW2tFIaOsi9HP7izJGmqs
	wGzIGH/jGJ+Obg==
X-Google-Smtp-Source: AGHT+IGjTZjSoDdbZuduOyvSUsGrcKpuVb03VKmiOOzWz965tIfgeaB/qsYmgz4U+VZeyKxkTY2woQ==
X-Received: by 2002:a05:6a00:807:b0:725:f282:1f04 with SMTP id d2e1a72fcca58-7305d4eff53mr10006916b3a.18.1738989902232;
        Fri, 07 Feb 2025 20:45:02 -0800 (PST)
Received: from localhost ([14.191.220.105])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73048c16259sm3813373b3a.153.2025.02.07.20.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 20:45:01 -0800 (PST)
Date: Sat, 8 Feb 2025 11:44:59 +0700
From: =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>
To: Emily Klassen <forivall@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: git log --graph --no-graph can cause segfault
Message-ID: <Z6bhS7THkV2ovXfQ@danh.dev>
References: <CADY4h_qagYhSP2kz=zNSjfskN1ODxLf1DjEME6BdYw6j-JEAhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADY4h_qagYhSP2kz=zNSjfskN1ODxLf1DjEME6BdYw6j-JEAhA@mail.gmail.com>

On 2025-02-07 19:34:11-0800, Emily Klassen <forivall@gmail.com> wrote:
> > What did you do before the bug happened? (Steps to reproduce your issue)
> 
> $ git config --get alias.l
> log --pretty=oneline --abbrev-commit --decorate --graph
> 
> $ git --no-pager l --reverse --no-graph --name-status
> e83c516331 Initial revision of "git", the information manager from hell
> error: git died of signal 11
> 
> > What did you expect to happen? (Expected behavior)
> 
> I expect the commit listing to display successfully.
> 
> > What happened instead? (Actual behavior)
> 
> Git seems to have crashed. My best guess is that some state gets set with the
> first `--graph` flag which is not cleared with the `--no-graph` flag.
> 
> > What's different between what you expected and what actually happened?
> 
> Git crashed.

Given commands yields: "fatal: Out of memory, realloc failed" in my
system. But it's fixed by jk/combine-diff-cleanup, which is merged
into master.

Would you try to run from master branch to see if your problem has
been fixed?

-- 
Danh
