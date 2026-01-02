Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC41D3FF1
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 08:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767340919; cv=none; b=LsDk4/pbRwZTyGytfkQMVsiLBCFAYMUCH9iuQlq9XNSNViv3sm4CESOr7qcA6yPNAKFNHJwMNy9hlq4VQcgT1Rzo3gcclBoNkQH2IhCXHW+6JY67b9S2Gfh9g8TlmYAt3rbqPUrm8msaqJhEQjMIwp9dKohgpqj6oJwStSGtb00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767340919; c=relaxed/simple;
	bh=KUjNGFmX9PCyD79xvR2uRB7FfimK6fj3nloThL7bud8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dndufb4WPfqQtjOVSUPusWadYUc45+LDkF4mq5diFej0qsrCN3GandP9fz18GhC9XVabaqktFOpig/bGlFcru+h3ymuMcezNQ+PlvFnmceoMcI7HkfVIhximnQ5YvvC9iYEyXwbbFFeU2lqNPfiafvxs/KWenAgsM5ChzSHu+MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N81d6plW; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N81d6plW"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so10029887b3a.3
        for <git@vger.kernel.org>; Fri, 02 Jan 2026 00:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767340917; x=1767945717; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KUjNGFmX9PCyD79xvR2uRB7FfimK6fj3nloThL7bud8=;
        b=N81d6plWEiRK+olOnOcPld5bMe9oOeQeaVhMGJZChz5fvlW/ezs+32QGOsOUIyB7Kn
         zbcLNlkZH0EM+GtY0+vjG8oLroz5g9P1giADgZCsiQVkWCaEKntipxPyBuhaxxlH//3v
         Zvhu9oaiENsX/FgwAJWVJ3l3ak/9dIEFm8QIhf3mdQVx7hhqve4HRVqgndsLVHR+rK9a
         +voTJyCJpzHcibcT+aWRxavVa9QZPZHHNGlKhC0XV8iUfmK8XGff083A5ANwf7mDhZZC
         wC6fyu0BDNKj+9CDG9aLiyvkD41BaczJQx2h48pSWI3AilkQurOKjHgERjVjFkED2g5p
         FHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767340917; x=1767945717;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUjNGFmX9PCyD79xvR2uRB7FfimK6fj3nloThL7bud8=;
        b=Tj2t3V0cGTOBzQs+vqx2zFJXJ73oaWN7wlHwNeRepi8E8yScXyVmdAFnYyYG7iew00
         zHkLd7ZEW/yWCZS1wh4BaeD9/K9HYNg/Jja+5yX4iCvhYW37KeRaoYHvgKhi6JmIztE3
         5RjIN9tVDRAEK4zI9XqFNSztyTbY/z5pFsCpRRuh047WGwmE40C2eBAQt/LXF/gm56zM
         FSRU316Zt2gnYOUWAqirk40dsgfEtWm/OAYg5ifnyqo3AZbjH5ke/OM1K9YMmKEoSNiI
         IyXb7q5cUXoQZf/b386KgxUsKtovdFBJI1+/NtF72tDwawirZbGmxz51cAJ6PFJ2aPJe
         cEpQ==
X-Gm-Message-State: AOJu0Yxk6xEHyXJu+wWPnFnf5G+rvWaYYxnvYPp1uezzKwwvwx5tUdTZ
	ykQhhpkArAf5Ri86EpMr9fnPQZzOP0wZ3EasX2AwAiSg7OUkFUs30e2UAUN31jsttefxou4XCq/
	ogYqHAGu+AHJ7L1tDMQXhOqn9sT+Xtry3ItejS48=
X-Gm-Gg: AY/fxX4vooUVsKT2qu2JlIwFK9h1qrE4RFzVM+0ctDUb04DvMB9yC/21b6csZ7bTN8G
	vLUMmAKJU0NYm3A26kfRwgCLeLxCDzpImAU9EmFINflfD+eD9U+KMfphKDGkoUBA40X3AaeN/Kb
	RwNYpbRdLLAkZ7eIIkk/3mJeL9ATFhlHnQ5mmr4NiRS+5UN2dzRlcG+UtKEFjXC0s9CEzHNrAhC
	3zOcYC9JOFdf/TtkNyhInghMtAyUc2RHRksiJe77gHXcy6AxyrukL+Ycol7eao5t1Mz10zs4sE=
X-Google-Smtp-Source: AGHT+IE8WwrHyJN0FZKfDo8Xh2QXR5nvcveVVnn5PMDSYA5yKI3nc0DOgb2ECwQpCWrSFGn9L7yXSZmJEVpEf890zlM=
X-Received: by 2002:a05:7022:e11:b0:11b:7dcd:ca9a with SMTP id
 a92af1059eb24-12172302438mr47159855c88.34.1767340916729; Fri, 02 Jan 2026
 00:01:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aUO7jQQAERTe5xYc@ubuntu>
In-Reply-To: <aUO7jQQAERTe5xYc@ubuntu>
From: Bello Olamide <belkid98@gmail.com>
Date: Fri, 2 Jan 2026 09:01:57 +0100
X-Gm-Features: AQt7F2oXfbdfdGgiYNEwCDecRP4dvls9OHq3OBOj46jYBcKGR0pXcGLXvIfTxPE
Message-ID: <CAD=f0L88QW_tL2iKg8ru3mU7t-vmY=p61S33GN+6tSQBMQAjqw@mail.gmail.com>
Subject: Re: [Outreachy PATCH] environment: move "core.attributesFile" into repo-setting
To: git@vger.kernel.org
Cc: gitster@pobox.com, Christian Couder <christian.couder@gmail.com>, 
	Usman Akinyemi <usmanakinyemi202@gmail.com>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Dec 2025 at 09:30, Olamide Caleb Bello <belkid98@gmail.com> wrote:
>
> When handling multiple repositories within the same process, relying on
> global state for accessing the "core.attributesFile" configuration can
> lead to incorrect values being used. It also makes it harder to isolate
> repositories and hinders the libification of git.
> The functions `bootstrap_attr_stack()` and `git_attr_val_system()`
> retrieve "core.attributesFile" via `git_attr_global_file()`
> which reads from global state `git_attributes_file`.
>
> Move the "core.attributesFile" configuration into the
> `struct repo_settings` instead of relying on the global state.
> A new function `repo_settings_get_attributesfile_path()` is added
> and used to retrieve this setting in a repository-scoped manner.
> The functions to retrieve "core.attributesFile" are replaced with
> the new accessor function `repo_settings_get_attributesfile_path()`
> This improves multi-repository behaviour and aligns with the goal of
> libifying of Git.
>
> Note that in `bootstrap_attr_stack()`, the `index_state` is used only
> if it exists, else we default to `the_repository`.
>
> Based-on-patch-by: Ayush Chandekar <ayu.chandekar@gmail.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>

Hello.
Please I am replying to this as no reviews have been done on this patch.
Thanks
[...]
