Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867FA15217A
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 23:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720480694; cv=none; b=DjykCpMfKmRNguXOWks2FBfn00MKdj41ofkuwvzqK0c3B6Lm+2hLnAcULedKzuBCKorBmoSXyVYxpv8sCId6uNM473FoJmo7f2Y56BVfeLyjdccQqi3Ovllird3ojY00BOGhQmkAQPPpf1zInOQKVYpYSpcn6x3Pnu12LkGb+3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720480694; c=relaxed/simple;
	bh=C+WC1WvUaY605kNi+RmuVibrbrclYgEdAOJaU4Obr9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lyswUr0uCMKAy9CZ1maM/3gK29hIGxZvenQ+IbrDbnQnIxs64RYqiIPsXOqMrYZYOHZsthM4ENVxGl2SVmyQa0YdeFHj/q/DPBcLTOI044r/hYd6Y5U6BmXVTTFyRRCkDR6bnT8WSTAEBhaRpGHBYVOFEBduS34UnwANLtAlqyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KiBrYTNt; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiBrYTNt"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3d9306100b5so1029736b6e.1
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 16:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720480692; x=1721085492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2yBkFO5RBfOQIbKAJOLUrNxHJKaTEupUQC7IxxC7hA=;
        b=KiBrYTNtpenK/AUxPoAU3bMk4wzh6tlIRAXvfzBvgUQ2zZN5fvkdPSIeIgOs/+nZej
         Qi944dbsXEDYBGnB86mgczbpCGOnT19g2UhFv9oLCdAhE8+VNrCjm7a26IpiIXvTOg7B
         sxSUxkHdlRZnDIuHhqh4P7kcF1cBYWnF7EXZjFUQVLFpH9EBRT+Kc2qiM1xvF/NJOuyX
         rWZ5YJQr2jpArdQSaMWcZkOukplkaJhDu83r9es9XZZr03rbN+/oexofdxCh38izFHnz
         w82qnvDLS3KMLqp0S4suU4BQYij7sFUsEQP4rrdG/+gBrk/pSTwQoeGoGE1NsZlFX9np
         ke8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720480692; x=1721085492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2yBkFO5RBfOQIbKAJOLUrNxHJKaTEupUQC7IxxC7hA=;
        b=VjQAvjms1siv0D4mI3IKn8UgJzoxvwiKi4zFWZc3zoBlJ+jgXJZWH0GOGylIoOyFPx
         ViVxxr7We+Vn0MCOP0OsTkCEFQbeopZ6PD+R/6+vHP2tnwrkgQgqg1wW9bdoy9o8DDmV
         EU/mhUEfaNDBOP7oE+H0MXLkXqiw/srJvw/eqJHJo0qzPY4fHpwP6G33jImfjiaqMc8S
         wOW95RNkX1ma7WimXT7vN1bjnV0imGlJsiJh05tkH1reM6KmdwEBmovEBZ2xa1FnEous
         MDBKgkJI/Miy/kl9hL+7IS9c1EDo5qj33+KVmaUIi3Nj3BZEoyldiRmst6BzsfEQWY1g
         H1hA==
X-Gm-Message-State: AOJu0Yzad8IJ2BQR6UHbe8ft4gtZWuEp6imaP7JVyBvuoGpqRRdsxCHM
	5XzK2uNheHmIzLcO0VWxVFTa373PlWAXozZeHJLHuym5kD3Er5i8uxDQErRX
X-Google-Smtp-Source: AGHT+IHZCQwd46pEoQGnpKdVIFs5kZI8D7UnXYFy/AMcik9OM0Ew5ExnSgrinXC8J8iA7vW1X6o3iQ==
X-Received: by 2002:a05:6808:2128:b0:3d9:2043:e170 with SMTP id 5614622812f47-3d93c0b333bmr894568b6e.57.1720480692572;
        Mon, 08 Jul 2024 16:18:12 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d93ad2593bsm177571b6e.27.2024.07.08.16.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 16:18:12 -0700 (PDT)
Date: Mon, 8 Jul 2024 18:17:43 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	chriscool@tuxfamily.org
Subject: Re: Re* [PATCH 7/8] ci: run style check on GitHub and GitLab
Message-ID: <pcyr4eb52de67j7idzfklbeg5d5jbfmgkt6loqhkbxppvjvnco@3b2lmbd7nt3b>
References: <20240708092317.267915-1-karthik.188@gmail.com>
 <20240708092317.267915-8-karthik.188@gmail.com>
 <xmqqr0c3hkjs.fsf@gitster.g>
 <xmqqwmlvcx9g.fsf_-_@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwmlvcx9g.fsf_-_@gitster.g>

On 24/07/08 03:52PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I think the consensus from the last discussion we had was to allow
> > scripts that rely on bash-isms to say "#!/usr/bin/env bash" because
> > we know /bin/sh can legitimately be not bash and we assume bash may
> > not be installed as /bin/bash.
> 
> Let's do this before we forget.
> 
> ------- >8 ------------- >8 ------------- >8 -------
> Subject: [PATCH] ci: unify bash calling convention
> 
> Under ci/ hierarchy, we run scripts under either "sh" (any Bourne
> compatible POSIX shell would work) or specifically "bash" (as they
> require features from bash, e.g., $(parameter/pattern/string}
> expansion).  As we have the CI envionment under our control, we can

s/envionment/environment

> expect that /bin/sh will always be fine to run the scripts that only
> require Bourne, but we may not know where "bash" gets installed
> depending on distros.
> 
> So let's make sure we start these scripts with either one of these:
> 
> 	#!/bin/sh
> 	#!/usr/bin/env bash
> 
> Yes, the latter has to assume that everybody installs "env" at that
> path and not as /bin/env or /usr/local/bin/env, but this currently
> is the best we could do.

Makes sense to me to be consistent and I also think `#!/usr/bin/env bash`
is probably the best route. Other than the small typo this looks good to
me.

-Justin
