Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090FD33D1
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 20:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723234928; cv=none; b=uPGwQxNLqaum2yWuGFaBqe5S1XDcEYRFmjB2VwONeRfF/u0qx/DPG0XSWSyC06dy3VVIvRFX6BsVrfE5NMxyblH4+kenVgL/hCkfCED+OUa0ERBSmIgnfqYEtjlNmyspcUhV5TZPrnFVTh5Yw5y3AsSXNnTn7c4GXbRhAcsiwPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723234928; c=relaxed/simple;
	bh=hr3rbDxPaMGwEPGJk9769XuR7e3Sko36jFRWlk4in7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8sgnGyPAB0pYHWvaIMweGyRKqD9Yym1IHrDidrc1KXwS+b7hoylYc/d6SWtEL/5p+wHsY0g3gOAj6NKtBk6Lu9bEmQB0yOufmFlgpBeOWIckdS5h9XbTbRld4scl+kZncJZrITuE1mCW2nw4U6El28igttOfVPX5uRQGw8kQxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNxshMYH; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNxshMYH"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3db2315d7ceso1478711b6e.1
        for <git@vger.kernel.org>; Fri, 09 Aug 2024 13:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723234926; x=1723839726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rc2YVYtkxciMOiw4IhqIS9PV9t4wnGouaaTobI4IfAU=;
        b=NNxshMYHvJ7TAAyUY6qXyPZYN1LflhNKraGr7ygAyYphy5TJcESwHaerHrUy+1hUgr
         grMS40IL2AHdB7vN7Qnhw0KcOu4V5+6xepH6Rbql5WaSc7gWlrphI21aoioEjQpmdFq/
         m8igsZeRr4pz8j6RMnODEbXwfF9sh6DJLyoOF+DafFZexrZJK/jcVrAZwKw5uELzl4vg
         Z23gDYpkry1It/eRu8n76y8gz6c1bh3+oozSTuCP4HN3YKbO0wwHWuHKnkrUozO94/Ed
         I7bRGilaYMxVXJtSqH0/7GVvnXl7iJBGMtRIMvBuOeP71wiWISA00XM1RiN6JUrZ/3fg
         5MaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723234926; x=1723839726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rc2YVYtkxciMOiw4IhqIS9PV9t4wnGouaaTobI4IfAU=;
        b=BlB/2gTdoTXhTlytmw+zE9V9WRZWRu8oORboDHWscE5DgafnUKVcsUcMvQ5C9Bbpei
         VB3MrZpxOkhTRl21kZg+FpCTITtm+yfVNKIaJlYAjBSc4rxhkyufyZCunooYcA7LtdM2
         SFCvZ4+PbTPMAhzBcEiCcsudFNXYzcKDt8btujRr6iCUMbt8j51tGOmL0P6+CQSvgXud
         h40b2jgdBtZcKZSUNa9HnVPynkG1zf2OaSabZ0KyBmBBgrihGAs03GUiSG0WyKP5a8H9
         MJZrFMrzP8kK5ovmyjhV7TSA4gehil5rwAmzCpsalnE/mEAcodfVYYn5oRUqtrOr+cki
         w6Kg==
X-Gm-Message-State: AOJu0YzUSOnwjikLedqkTm7Um6YmKdEin3iFYZnAAI17jRasWUkDDaT5
	uf4RGrVqwHGiBqZ66P4RAdnZW2/QP1wf+FpxxME4rhLW1TmK3FgwNWwK3g==
X-Google-Smtp-Source: AGHT+IHZc5nWTSh1aO2Mm6E7d+dY8odGK0xDaPuapaWDRt1vP+Iy23bVmkTu28njVrx490G0Uz43Yg==
X-Received: by 2002:a05:6808:2dc5:b0:3db:1f8a:2aec with SMTP id 5614622812f47-3dc416803a9mr3181128b6e.19.1723234926135;
        Fri, 09 Aug 2024 13:22:06 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dd06078749sm52260b6e.19.2024.08.09.13.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 13:22:05 -0700 (PDT)
Date: Fri, 9 Aug 2024 15:21:18 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 14/20] config: pass repo to
 `git_config_get_expiry_in_days()`
Message-ID: <qo26pmkrctepcob4vjfimvxlgoic7gqjxasnz2hqmv4hpgc37t@jh5wo2fjqyoo>
References: <cover.1723013714.git.ps@pks.im>
 <cf7942479f75d95dcd8606b0947a8897ae60da60.1723013714.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf7942479f75d95dcd8606b0947a8897ae60da60.1723013714.git.ps@pks.im>

On 24/08/07 08:57AM, Patrick Steinhardt wrote:
> Refactor `git_config_get_expiry_in_days()` to accept a `struct
> repository` such that we can get rid of the implicit dependency on
> `the_repository`. Rename the function accordingly.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
> -	git_config_get_expiry_in_days("gc.rerereresolved", &cutoff_resolve, now);
> -	git_config_get_expiry_in_days("gc.rerereunresolved", &cutoff_noresolve, now);
> +	repo_config_get_expiry_in_days(the_repository, "gc.rerereresolved", &cutoff_resolve, now);
> +	repo_config_get_expiry_in_days(the_repository, "gc.rerereunresolved", &cutoff_noresolve, now);

non-blocking: Do we want to fold these lines?

>  	git_config(git_default_config, NULL);
>  	dir = opendir(git_path("rr-cache"));
>  	if (!dir)
