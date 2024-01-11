Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C9E56B74
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 20:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjCFJlMd"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-28ca8a37adeso4834793a91.3
        for <git@vger.kernel.org>; Thu, 11 Jan 2024 12:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705004393; x=1705609193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0spYrij6PcGi94l6Nll+wBNI8qRPR1xbX1EPLP9T7o=;
        b=PjCFJlMdDmJl6q5GmnQ8kDchr0tDJN63ZrAeLhKVYSnv+xAQTqdQeH0Ff1YY+VZBzO
         Bt1tj9DJ4uB7MAHcUmhT+niJ0oIgdsblZJUv/qLytJNEzAjFuPZiEK/wL/Tbzb3NoGkv
         3vWu3339IGh7UJMLVbB+NztaHSfKE6TvqX/IVDBsrYIy+6q40F6AwwZDNWz0hmEj8KhG
         +XOy4SOkilTOo0K9lK9kb/GnPLJ67KMQ7yXakzD8XYxJQUXy7fgKp21LD3v3mLHK8nw2
         ptOgwILulVlSpbF9WSXwNyBA3Hl/BQ3KuF2LkyyWmqhma2cxsUaYhqzPqaVpSSWW2sDE
         HIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705004393; x=1705609193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t0spYrij6PcGi94l6Nll+wBNI8qRPR1xbX1EPLP9T7o=;
        b=t/8wQjUALTM9uR1vqgFFzTYgSsKxewFY0Vr6IGJ4I4fGuKWhAH6GOlObpPXXtrbpJu
         N5OBHZAW4gyS41MU43T7UF1brpgUXLaLkKokwl7xkd/i+G+RgXOu/c8rZ07cB2qtH+IV
         OgMskYpcPFMT1rtry03kjRv4pmU5PFQmDFM5rvXIgQ+yiNJwHvKy1iEVifklZLRLV+1T
         z4pJDcneS2YELQRML2aQQ7to9BGakjp6thmtS5+qFjwhKpfdPMluyjSv12fUtlCYssnB
         fD9uF8sRb3lJnRAqWlU/avHh2ohwxfml8ABYf4DrEHVDoUQUwWzP0TazT/xqs2LHVCzd
         y9hw==
X-Gm-Message-State: AOJu0YxgBkAiK9jG+1eS6bFwQlFehV2IUIO7nQpbBPNxRAhsX2ZFC2y6
	vVsQL05FiVxmhoLxSRBRr8thRo7knqbx5qVjIfU=
X-Google-Smtp-Source: AGHT+IGioK1ptvS1XJ1WASZZnF3AVnKYnU3fJxRToIuIFcj1qL+6QUmZuVRhjbbZRMCH9995UOeknFBjJbTHyRM6h54=
X-Received: by 2002:a17:90a:62c9:b0:28b:d485:2b27 with SMTP id
 k9-20020a17090a62c900b0028bd4852b27mr344761pjs.84.1705004393653; Thu, 11 Jan
 2024 12:19:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1634.git.1704912750.gitgitgadget@gmail.com>
 <cb78b549e5e826ffef39c55bd726164e6b7bb755.1704912750.git.gitgitgadget@gmail.com>
 <20240111071329.GC48154@coredump.intra.peff.net>
In-Reply-To: <20240111071329.GC48154@coredump.intra.peff.net>
From: Justin Tobler <jltobler@gmail.com>
Date: Thu, 11 Jan 2024 14:19:21 -0600
Message-ID: <CAGAWz+6MEbxeWyPk5aw7jfEve0tYjvfPRXpDCqsw6pe-nGFPjA@mail.gmail.com>
Subject: Re: [PATCH 1/2] t1401: generalize reference locking
To: Jeff King <peff@peff.net>
Cc: Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jeff King <peff@peff.net> writes:

> It looks like you re-create this situation in a backend-agnostic way by
> having two simultaneous updates that conflict on the lock (but don't
> care how that lock is implemented).
>
> That works, but I think we could keep it simple. This test doesn't care
> about the exact error condition we create. The point was just to die in
> create_symref() and make sure the exit code was propagated.

As you mentioned, the original intent was to recreate the same error
condition in a reference backend agnostic manner. Since the test doesn't
care about the exact error condition being used, I agree that creating a
d/f conflict instead is a much simpler and better approach. In the next
patch version I've updated the test in t1401 to use git-symbolic-ref(1)
to produce a d/f error.

Thanks,
Justin


On Thu, Jan 11, 2024 at 1:13=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Wed, Jan 10, 2024 at 06:52:29PM +0000, Justin Tobler via GitGitGadget =
wrote:
>
> > From: Justin Tobler <jltobler@gmail.com>
> >
> > Some tests set up reference locks by directly creating the lockfile.
> > While this works for the files reference backend, reftable reference
> > locks operate differently and are incompatible with this approach.
> > Refactor the test to use git-update-ref(1) to lock refs instead so that
> > the test does not need to be aware of how the ref backend locks refs.
>
> It looks like you re-create this situation in a backend-agnostic way by
> having two simultaneous updates that conflict on the lock (but don't
> care how that lock is implemented).
>
> That works, but I think we could keep it simple. This test doesn't care
> about the exact error condition we create. The point was just to die in
> create_symref() and make sure the exit code was propagated. So something
> like this would work:
>
>   $ git symbolic-ref refs/heads refs/heads/foo
>   error: unable to write symref for refs/heads: Is a directory
>
> (note that you get a different error message if the refs are packed,
> since there we can notice the d/f conflict manually).
>
> There may be other ways to stimulate a failure. I thought "symbolic-ref
> HEAD refs/heads/.invalid" might work, but sadly the refname format check
> happens earlier.
>
> I think it is worth avoiding the fifo magic if we can. It's complicated,
> and it means that not all platforms run the test.
>
> -Peff
