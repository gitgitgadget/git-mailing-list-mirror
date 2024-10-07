Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBD9502BE
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 04:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728275326; cv=none; b=a9B+/qKNFCFIGnzExAHv9zFWOzb18gT/sSjyakCtQ3D0JinUsXJmK75FV7pyHkrCs1GgNWqQfkPPMy/s8Qr1upwFgL2PQbm+M//ZixMgCEYMFoq/77lLmZ69u0Mk4S9kxZMbkQtc19A4AbAldngwScrCWs/fXAHyu9dZ5bcHnEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728275326; c=relaxed/simple;
	bh=9Rij+3q9MuYsw/3RpzQMK9Q+1hgyY8DSTpjrjUj+388=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plcgPv5eDUwkGEFXfXWKkLhWRWJY4hnXcSJYXHbKCw817Yh7elZw9nNieQKswkxYxjx6qqnSAtpXYDww1+gUTarjzxG+XPCXYJVD1UiblJ44cbRakQqI2X4d/ZKFyYcwU5LVtVEIn95+geY6bfnshSlHt90MyYLIl6PxKcautDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSKy48W7; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSKy48W7"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e09ff2d890so3387316a91.0
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 21:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728275324; x=1728880124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CflEsSx7uVhB5tQgH5lnh+MWmpJZg5RBv8dOOQ9SIFU=;
        b=kSKy48W7IwkbG7ndelTawBs5mQnVt/i+7vDRTbO1CBoLhEyOtvLWmAyXyLfMXrBgCv
         dPRJ3dxBR2r4/E5Oyi2DjJ2LDn9PqTtPE+XbZ2pZp9ogIHzAPnnk6Ah/xOY1M7R9sVYO
         7X0NxQ6lT7GeawYrOgndjdnrQIdQKmJlhZXO8Ego+DfOmmdfNqSIx2zxxCxHsbwHHqfy
         H492qCdPZtSI/s2BFM6hpgFxILvRsNxnVcWCAyagTnhOqfl2QIAJFlmru/fdf+RPfNdQ
         0B7aeOVLfFDiZ/ij4zh2ehLP3aOxw6eNUhHsVgh5ku0QwTJS1WksYAwP5tz9SdB7ssHH
         dP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728275324; x=1728880124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CflEsSx7uVhB5tQgH5lnh+MWmpJZg5RBv8dOOQ9SIFU=;
        b=gyYSOR9V53yxMrEBr6n552ERMcTHPZk4Fy977YBmMwLypvHRGRZb41EUV7ZU18c9Uk
         tpoiED/KzIzfUg2/iztuBTXoPvO8yppKEyEZHkOGA9TBIPE+NdyFUh9JocoOL2fyc9j1
         wuoyM88O/8N9pJKXBUwjxzQxfyTo+ElwKl1QC4CzyoF7ePVfpuqXpf22vZIUiIluCcsg
         NT7VCUPZ/0mUDamgbynGYJFYat6ZZM8ZZ9FNxTSiWrYXWvIG2jstFXQzeFfzrOBXN2OL
         IZi0pKmxzgXu6nKpmB/UkRTPVnv2CSt+anqvp7lDjF9w9eX65N42dpjs7+VJTD66hX8G
         2a+w==
X-Forwarded-Encrypted: i=1; AJvYcCU605N7CklpuEGw9c3R4g/LTgHXuWna/keyA9wk0qNr+Ktq9/q2c3Z7mJKJ0tmmfq+1uYg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk/iVqWy2yU2z3IvDLhqPPmHjuOSfttvlp/C5QTnCaU5sLCiYQ
	AXxxq5Uum2zv9wGPrFnjYiBQq4hyFOhtLtZQAJRhM2auBM07Bukz/COwF90f
X-Google-Smtp-Source: AGHT+IE81Dn4T48aTW71iAfi6yz70xbQpKw6tzcOuDk8Dkus3gsilj0E0b7FeD3Yvz0YVvLHCTyhUA==
X-Received: by 2002:a17:90b:4a4c:b0:2da:61e1:1597 with SMTP id 98e67ed59e1d1-2e1e636f476mr13879802a91.36.1728275324471;
        Sun, 06 Oct 2024 21:28:44 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20b0f89basm4166640a91.39.2024.10.06.21.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 21:28:44 -0700 (PDT)
Date: Mon, 7 Oct 2024 12:28:50 +0800
From: shejialuo <shejialuo@gmail.com>
To: Caleb White <cdwhite3@pm.me>
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/4] worktree: refactor infer_backlink() to use *strbuf
Message-ID: <ZwNjgvMbUKgpbP7O@ArchLinux>
References: <20241006060017.171788-1-cdwhite3@pm.me>
 <20241006060017.171788-2-cdwhite3@pm.me>
 <ZwKoNg-HYGaohvCd@ArchLinux>
 <CAPig+cQC45_Pofw31h2RSydj_CjqpfajLLa5O_sR9m0AQh5OVw@mail.gmail.com>
 <o7jQV4JUYr2iQtErKFhCrjCySiGn7_I18gmdInKbOC9TAsvqazG0O_fPUtiWZ5UfiGLr25OZ5xvqIhfOIwCG-s1RGgri-BJIdHqiokIw4z0=@pm.me>
 <ZwNfuLoVn4aU4mgQ@ArchLinux>
 <XzNC1BXk2OaIGmgas_MWKZ_ubpeR_kA19hNxmF76FLtgI_WfYrMOGEDEr5uqOETNPHTI_bA3qJE0R0eah4UTPXZUgeRjG7psN6ncDOdPXNA=@pm.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <XzNC1BXk2OaIGmgas_MWKZ_ubpeR_kA19hNxmF76FLtgI_WfYrMOGEDEr5uqOETNPHTI_bA3qJE0R0eah4UTPXZUgeRjG7psN6ncDOdPXNA=@pm.me>

On Mon, Oct 07, 2024 at 04:19:22AM +0000, Caleb White wrote:
> On Sunday, October 6th, 2024 at 23:12, shejialuo <shejialuo@gmail.com> wrote:
> > That's not correct. It is true that the contents can be NULL and
> > `backlink` could be filled with the infer_backlink. But do you notice
> > that if `backlink` was filled with the infer_backlink, it will jump
> > to the "done" label.
> 
> This is not correct, if backlink is filled with `infer_backlink` it
> continues on with the processing. I have made this more clear:
> 
>     dotgit_contents = xstrdup_or_null(read_gitfile_gently(realdotgit.buf, &err));
>     if (dotgit_contents) {
> 	if (is_absolute_path(dotgit_contents)) {
> 	    strbuf_addstr(&backlink, dotgit_contents);
>         } else {
> 	    strbuf_addbuf(&backlink, &realdotgit);
> 	    strbuf_strip_suffix(&backlink, ".git");
> 	    strbuf_addstr(&backlink, dotgit_contents);
>         }
>     } else if (err == READ_GITFILE_ERR_NOT_A_FILE) {
> 	fn(1, realdotgit.buf, _("unable to locate repository; .git is not a file"), cb_data);
> 	goto done;
>     } else if (err == READ_GITFILE_ERR_NOT_A_REPO) {
> 	if (!infer_backlink(realdotgit.buf, &backlink)) {
> 	    fn(1, realdotgit.buf, _("unable to locate repository; .git file does not reference a repository"), cb_data);
> 	    goto done;
>         }
>     } else if (err) {
>         fn(1, realdotgit.buf, _("unable to locate repository; .git file broken"), cb_data);
>         goto done;
>     }
> 
> 

Thanks, you are correct here. We cannot use "BUG" here. And I think
currently this is OK.

