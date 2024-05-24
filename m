Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062C336D
	for <git@vger.kernel.org>; Fri, 24 May 2024 00:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716511410; cv=none; b=lwNz9SLd9M5m8zc8Rhp4eq8bJL4LTYneqo3RoEEM7bVbqZAy7s5JOQSabZx5V0gEDuP/kaMVTmpqPhoHzmwsrQgy/kC5zxk4k+X4BQzCKsBlTF8H2BU5GTDSyHIumtJTLelV1u67Cbnq6r/q0mvRJcbLjFKaDRwrda2x2WOzIFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716511410; c=relaxed/simple;
	bh=eqIVticb8ZAidfawbPKrw128glPzjRZjXLLkpA91Nnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3uHXUy/4uB/+eEMasAmLS9ZydsnpczKmgSSwX0Sh2PJaOfAwJtRP7BAu7mECkISHFXt/uvNh666cIkVwIdFpxSl2xx/JjS8lXrMO0fAtYwlqORcKbZvMYQL1DCNP70dASFnGx6fJVyLizO4kOZH4iTB6jSsCz84ZM1y949IQvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aT0a9ZO0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aT0a9ZO0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716511407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aYlZsxS5iN67xzP1FPdX/+cfEIa5xyOtKxuCZAnoSgw=;
	b=aT0a9ZO0BZhzjXhE9styUf+lsIPxB9QzXrEDPhDG/4fQFOAKlOm82kkLNB3JlMLrTYs1OP
	Whqn33N3mRNB81UEMS7NIbUGe8SFZyqVI6rac+PADpQbrDnbvRImU7MGXrU+P6eLxAgEcM
	AxUz4U6z84jeni/Z093brdUyE4TuJIc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-48ndWspDOOq7WweaOeTn5g-1; Thu, 23 May 2024 20:43:26 -0400
X-MC-Unique: 48ndWspDOOq7WweaOeTn5g-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-792c365cb16so78303885a.3
        for <git@vger.kernel.org>; Thu, 23 May 2024 17:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716511405; x=1717116205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYlZsxS5iN67xzP1FPdX/+cfEIa5xyOtKxuCZAnoSgw=;
        b=EbVPC3aN77Bmw6ZqdlPf/bPQ95ztF8NNog4RBPiJMN8gIOwIu0bxqvjSGRCCQVtxnw
         PvHmauDpNPeOM4KXiQ/bLJ8gZ2oXJ7vXu7ewA+jnJUCjoxmeqLK5LAnGkSjGq79Gn+xI
         /fJSJSMAWEpjry5sUQCzrroLtq3fHmO8yF5fpnvw191TiaLzyNeO3Bn/P1h1ORq7vC5+
         82yRhTi0oZ8OIvY9hbtgWyfnSblZviJphqCkFxmv0OkFpVQLBUMAor3Fj0UXOfAJ9+Y1
         HRMvZyS1/ytBR6wy4l7JkOrVqOwJu7EURBwkzRIb5j19xt23aX0EI8+RqruOoP83Z8P9
         glqQ==
X-Gm-Message-State: AOJu0Yxy3jeInm2OnvgwwcI2YJ9yljmDXJ69j6MRDVE7YQx84cI8cOPg
	L5nvZVd+lTsrMoeV8ZDt7oQtFA812QdxdvYsKHqNq3dsljnUoP56PYqk0HggsQ5uBK8VIAcFC2z
	6aZgVnD7FWuOAkpLw9D4R2OcbrWt62EyPSvpV4OzpjbUn2WQ7/mb2bCeoHA==
X-Received: by 2002:a05:620a:94a:b0:794:8de6:505f with SMTP id af79cd13be357-794ab1233e2mr74954285a.65.1716511405585;
        Thu, 23 May 2024 17:43:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJh1w/JKvotj1ISPWV2lTgF+UxVm/o0ckuMYv+vQZHTINT070S8MJm0tEpJkOPw5iqm/vk/Q==
X-Received: by 2002:a05:620a:94a:b0:794:8de6:505f with SMTP id af79cd13be357-794ab1233e2mr74953185a.65.1716511405086;
        Thu, 23 May 2024 17:43:25 -0700 (PDT)
Received: from fedora19.localdomain (203-12-11-234.dyn.launtel.net.au. [203.12.11.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abd063adsm14899885a.78.2024.05.23.17.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 17:43:24 -0700 (PDT)
Date: Fri, 24 May 2024 10:43:19 +1000
From: Ian Wienand <iwienand@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 3/3] run-command: show prepared command
Message-ID: <Zk_ip35jHUj_5M94@fedora19.localdomain>
References: <20240523042143.1220862-1-iwienand@redhat.com>
 <20240523043806.1223032-1-iwienand@redhat.com>
 <20240523043806.1223032-3-iwienand@redhat.com>
 <xmqqpltcwnqm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpltcwnqm.fsf@gitster.g>

On Thu, May 23, 2024 at 08:29:21AM -0700, Junio C Hamano wrote:
> > For example, this can be very helpful when an alias is giving you an
> > unexpected syntax error that is very difficult figure out from only
> > the run_command trace point, e.g.
> >
> > test = "!for i in 1 2 3; do echo $i; done"
> >
> > will fail if there is an argument given, we can see why from the
> > output.
> 
> ... if the reader truly understands "the alias gives the command and
> its leading arguments, to which the invocation can supply even more
> arguments", the reader wouldn't be writing such a command line to
> begin with, no?
> 
> So I find the example a bit suboptimal.  Hopefully additional
> explanation in patch 2/3 stressed on that point well enough with
> much more stress than it talks about the implementation detail of
> using "sh -c" and "$@", so that readers who read it would not even
> dream of writing such an alias in the first place.

Right; I was seeing this in a more convoluted way via our tool but
essentially the same issue.  I was just looking for the simplest thing
that also gave the syntax error output, which I thought was something
people might search for (the "unexpected "$@" stuff).

Should I just leave as is?

> > +test_expect_success 'tracing a shell alias with arguments shows full prepared command' '
> > +	git config alias.echo "!echo \$*" &&
> > +	env GIT_TRACE=1 git echo argument 2>output &&
> > +	cp output /tmp/output &&
> > +	test_grep "^trace: prepare_cmd: /bin/sh -c '\''echo \$\* \"\$@\"" output
> > +'
> 
> This is probably too specific search string, I suspect, given that
> runcommand.c:prepare_shell_cmd() uses SHELL_PATH or "sh" so if your
> SHELL_PATH is anything but /bin/sh (or if you are unlucky enough to
> be running this test on Windows), the pattern would not match.
> You'd want to loosen it a bit, perhaps with "/bin/sh" -> ".*", as
> the rest of the output are expected to stay constant.

OK, should this perhaps just look for '^trace: prepare_cmd.*'?

My initial thinking was to enforce seeing the "$@" appended, but
perhaps that is implementation details that don't really need to be
covered; the interesting thing is we show the person tracing the full
command as constructed, so this is useful just to ensure the
tracepoint remains in place?

-i

