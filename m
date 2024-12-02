Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282AD1FCFFD
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 11:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733139989; cv=none; b=lQzcnzxVjjGWSp/WDd+3ppmuKAwx31HzYy52y2c7ruhkjhGEFi/OiY9AWI7quItkRt0w5zej98D9NgM8SkKzig3Vp6TGcW+LyNEGrxw2ellUWX6EbbNs8lnDmPnDKONdFh8tryyFS3ub94Kl/5mQJfzZqMaq3z24aZHJIkFuYYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733139989; c=relaxed/simple;
	bh=iDbsTMqcp82m5XdN9lobQ2Berm0ReoEOROhaj0iTCBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MV9rUUjEZxDNcHhwhxoGgg9MZwCwai1Nsmn5C9v4GLcsorsN4etpwkouzuAq6zA2v66MAjjgAnJmxM3h6ujJlxqXKNIuKI+eVQcmFhtcQNcZs3fRAcSkWXWNkubUQ/L01Aa6mYqW08fo4b+BQc90HTRvgBEpPivtjH0LYj3EUIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OT49VB1s; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OT49VB1s"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7fbc1ca1046so3662110a12.0
        for <git@vger.kernel.org>; Mon, 02 Dec 2024 03:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733139985; x=1733744785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F01IDOaw4CAoZ1BO9UINmtQcioFA1d7RR6uFPdrAYc4=;
        b=OT49VB1sZNWMVnHZRkE0xL2wGUTHHMd6J6T1qEsp4pzPFSmOE/30XnhsZSL0fJHm2I
         vKbnoGBwGOFgm8SuOrsr5/YVXDsp+iGawjcol3IevZW/NmfWIXtpwnumID3DZFvEe1Er
         bd+LxZo1aeTpxalvtS4EHtZJ4D1Wj5paid/1fshM7cNy+8rLHBbXsUzkCsKPjL16xFmR
         ca0wvemsp8RwCk0mxj+CCsdaScCgLQWzMmJqxCaHo6NoZtVTIET7hqeAypmWlYNu3yMc
         VYfRWfIjYe/vRPdedYP0JOQYpj98CFC8GguM37IsG1ZQ2wAzOvQQGXU0frOFymjVZWjX
         QIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733139985; x=1733744785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F01IDOaw4CAoZ1BO9UINmtQcioFA1d7RR6uFPdrAYc4=;
        b=f8DGI22LpfrepqgR6NNTlIboCADxz6fa8emAfn6aBELw5M97r+7hMic0R9lkc6+WTf
         ELrBAj82uLaCVXJTEDZRhRIRmSSoA1OwsawQVNoxNA19YIJFWPV2IMXzLQkf+spCAthf
         xInWlvawDVF5fiD7PL+BDmXkRHIcdFA6hGcjzD3EAZyGOWsxjaDxaiLuv5O3ah22qVjV
         jfKFlGvLz8IqwSf+h+qu36kGTeikghmrhcjqNN7kLlPx56w6qerk+07+jsx7tznWoL7/
         K8Et0Ldcu77XcFyvXrhv5kTzG7wXuIsMsbdLbQOjJasRiyYVYlUMGWBa/ZdfvP193CDN
         +PfA==
X-Forwarded-Encrypted: i=1; AJvYcCXwkxpu/bkQmAa+SUStdvI9oKquqXgeQFHKqwlgGw1HEi1buYP66nDyZU/k82kIOvcskxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuC/tGl8jbfJ+Hygz71O86WjpJA7wdlqLoKFBatw71hba1EemU
	bC/8kMh/iOnZrqaSxVOG4bTiU/m2AmlmJFbSqhAnL/CInq0AtRg4
X-Gm-Gg: ASbGncuZFRKdBrpSgRnR2p/+wQA3UvcP0v1N+bVMD4i5IT2QO9ULFt4JF6YC05iUa+6
	qJPvfobQLnfTPHTKMS5GUrgaFjVyKsHZbOz1QWj9qtLmHnbfSuNguoZNqXvLR8+BSr0WSWDzEJx
	9CVdnvF75KECNJijOLqtW16wmV8LwWgokG9xVqbj+Ocsuw/pVvYrRCgHl1Eh2B2qfByEkT+oxEp
	jQ2YVg1cU6+o4H3+NihUC8vWTWeN6EvDUCDez6IF9UERw==
X-Google-Smtp-Source: AGHT+IHdQSyijKEO+Zzlz1rD8Vw/aLffOoCQNizIkRYhsSeOZ9XWtNk58HF75osTB3Sr+WwlA0zsRw==
X-Received: by 2002:a05:6a20:6a28:b0:1e0:d6d5:39c3 with SMTP id adf61e73a8af0-1e0e0aada91mr32611697637.8.1733139985324;
        Mon, 02 Dec 2024 03:46:25 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c3a320asm7584614a12.83.2024.12.02.03.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 03:46:24 -0800 (PST)
Date: Mon, 2 Dec 2024 19:46:48 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Caleb White <cdwhite3@pm.me>, git@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Ensure unique worktree ids across repositories
Message-ID: <Z02eKA8i51QyXgJ-@ArchLinux>
References: <20241129-wt_unique_ids-v2-0-ff444e9e625a@pm.me>
 <xmqqed2qkfn0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqed2qkfn0.fsf@gitster.g>

On Mon, Dec 02, 2024 at 11:00:51AM +0900, Junio C Hamano wrote:
> Caleb White <cdwhite3@pm.me> writes:
> 
> > - Add the worktree id to `worktree list` output
> 
> I have always thought that we deliberately hid the "ID" from the end
> user's view because it is a mere implementation detail, and used the
> filesystem path of the worktree directory instead to identify each
> instance of the worktree in the end-user interaction.  It is unclear
> why this change is a good idea from that point of view.
> 

I have a discussion with Caleb in the first version. Because appending a
hash / random number will cause the worktree id has more digits, the
user cannot easily use the following commands to make a ref in the main
worktree point to linked worktree ref:

    ```sh
    git symbolic-ref refs/heads/foo \
        worktrees/<worktree id>/refs/worktree/foo
    ```

And I expressed my concern about above situation, the user types the
extra hash to do above. So, Caleb decides to list the worktree id.

Actually, this usage should not be common. But when implementing the
consistency check for files backend, you have told me that the above
situation could happen. And you have said we _deliberately_ hide the
"ID" from the end user's view.

But cross-ref operations between worktrees must explicitly specify the
worktree id, so I am wondering whether we should allow the user do
cross-ref operations in the first place:

  1. main worktree symref points to linked worktree ref.
  2. A linked worktree ref points to another linked worktree ref.

Thanks,
Jialuo
