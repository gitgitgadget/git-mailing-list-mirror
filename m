Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5323B214817
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 12:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740572922; cv=none; b=c6S1JS7L0RTKd23Hr5i0ND72DQbuAoW8sOZhq/Muwnn3Sz/ZKolk0p8b2lkQ3B73M78YdGoXJI4N9i04Y+xs8VUuPu2JcdbRaiuN4/ToKKpz0+8yeQrkjI+1Tta2fOlXaP/+rJZTYgWfW6f+eaGLH9DXLbCD12xl8hQFW3g0LYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740572922; c=relaxed/simple;
	bh=ilAwMvlds2S84nFbklhB7O39VDtFGUFQbQ+3yCPwQ1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jfhxix5gTN1r+AauDCBInISd9NtGaBwzn1TmZp3Z8K/OICbWQjo98mN5l0O472USpdLI+Lw6htpyyYGDjDPOKWCsr2uGX0+l3O/TNOukD5nhJkX2l0LT1RyNuPLO1P+emOJGQn4qU77nT+kkTkEtM0EK6cfk7RQaAWLn07WeuM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6dq1/8O; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6dq1/8O"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-221206dbd7eso139026145ad.2
        for <git@vger.kernel.org>; Wed, 26 Feb 2025 04:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740572920; x=1741177720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h1riTAhzRMMWthRQs2RukJ+nECskLwHA7xXARzx4YYE=;
        b=I6dq1/8O9mrXd7xNxXEVBVUMUXoATu0PSJ3UDrbxfP7sQGyQREDC8mi3o87WE77x7+
         fZf/7eyA1Spd9QeJkkLtX4xNMmOEn5V9+yAj8m/+X0RSod5KJ1yKgUpBObh9LoLW5Zz1
         qxxrYrIybmfHRiOLiEqnirnQhHo5uyijY9sMwyQU884i+TKxCkMWBK2dWWKWsWHjYfB8
         fviRUkPRw3IJj7MgmkKbqXi8CEJC8teresGG9C08bLB++V8wXKWQaeEUWfZZaSk3R48H
         Sz0yPayItDAkYSpcYWv2D6xvoYKtZBa8xMwPMi+pOpJbyK4Mklupwh10rVY2Euhv+uSh
         nSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740572920; x=1741177720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1riTAhzRMMWthRQs2RukJ+nECskLwHA7xXARzx4YYE=;
        b=kdByAA6CYcUdwGNYyEUmGnPgSqNWFiHMtnU3WUtscCkVZa/WKt3K2RkXMucsYGCKT4
         F+JApVmC9o7BMqEy5Rn5XeIXqlyYvBzZPB4QQ1DUUjT2HqN5CX5tYj3K0PvhxZgFnlSk
         f32o2FF4CvozT2+6yOZSJGJ5LB0magc9e5pn99G9IVtbotfU4S6JbmXY6Ic9PmPIs0W6
         ycCnwOcSmtuEcTgajh3Lwi1tWPwBHS6xxE4QSGbDj9+QSK56qFZvO+rxUCHz0odGskZ4
         6RtnTOSnp9qwVFJnCZaFTVtwIlCYaD6eDQwzwW3vQ2z1nnMy+yqOTKFTzovQL8QL4LHk
         qU6g==
X-Gm-Message-State: AOJu0YwAYTMHy2cBqU7D3J8X/pm4fyRw5LImDA2+pL6t0khOVAvluFwj
	4fVNXVi0Ydx1C4gmNJa3ENxfrw0a6IrkBbt+S8qTlSzAZsNWQeyk
X-Gm-Gg: ASbGncs7hhMaC0oyxlinLGm72rnQ0Mt1YFu2+MGY50VnvrMehy13koeqATe2MM1wdm6
	OzY4BECd+dV1+iNX3SKrbEa+OJQXYSnKRCvCNOoJFSoFesAoiwWAl/7T1MEbvHBWX1H1x0X+YYW
	yuqAGPNMJOVHnuO1AuClGMck1OEdHv5rWU9Cv76eKsrj+6M86lU0krsAUIPcEtn5RxyNmV5ZZz7
	XeidWqJ6oyadyu4KyGuQ9A7EH1tWsSEZdHumAhTK0qWjyK2KYULTmqKrYlq6TS8hJhh29RsbIEO
	9rW2nj6XaECjBcSKjTiWGA==
X-Google-Smtp-Source: AGHT+IGlhxGk59i9W1ZQBjBYX3jNgRHGYxjuze+mHdxTKT/VjVaECeLS+psGog6rCxLn09+pHvtL2w==
X-Received: by 2002:a05:6a21:4613:b0:1ee:c1b2:76c8 with SMTP id adf61e73a8af0-1f10aece6b1mr6046216637.37.1740572920406;
        Wed, 26 Feb 2025 04:28:40 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7347a81bafesm3284095b3a.126.2025.02.26.04.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 04:28:39 -0800 (PST)
Date: Wed, 26 Feb 2025 20:28:49 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v6 4/9] packed-backend: check if header starts with "#
 pack-refs with: "
Message-ID: <Z78JAaKTTivF5M0A@ArchLinux>
References: <Z73DTwr9RicKMINe@ArchLinux>
 <Z73D5XLzzg-OPmdT@ArchLinux>
 <Z77MAMqVGrT2jgcf@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z77MAMqVGrT2jgcf@pks.im>

On Wed, Feb 26, 2025 at 09:08:32AM +0100, Patrick Steinhardt wrote:
> On Tue, Feb 25, 2025 at 09:21:41PM +0800, shejialuo wrote:
> > We always write a space after "# pack-refs with:". However, when
> > creating the packed-ref snapshot, we only check whether the header
> > starts with "# pack-refs with:". However, we need to make sure that we
> > would not break compatibility by tightening the rule. The following is
> > how some third-party libraries handle the header of "packed-ref" file.
> > 
> > 1. libgit2 is fine and always writes the space. It also expects the
> >    whitespace to exist.
> > 2. JGit does not expect th header to have a trailing space, but expects
> >    the "peeled" capability to have a leading space, which is mostly
> >    equivalent because that capability is typically the first one we
> >    write. It always writes the space.
> > 3. gitoxide expects the space t exist and writes it.
> > 4. go-git doesn't create the header by default.
> > 
> > So, we are safe to tighten the rule by checking whether the header
> > starts with "# pack-refs with: ".
> 
> The commit message nicely describes why it's safe to do the change, but
> it doesn't describe why it's something we _want_ to do.
> 

Yes, as you have said below. We don't have document about the header
format. It's an internal implementation of Git.

> Ideally, we'd be able to argue with a technical spec of the format, but
> unless I'm mistaken such a document does not exist. The next-best thing
> is to do what everyone can agree on, and that seems to be to both write
> and expect a space after the colon. By not following consensus that
> exists in other libraries we're being more loose.
> 
> So if we for example started to stop writing the space due to a bug,
> we'd still continue to parse the header alright and thus not notice the
> problem, but now we have broken other implementations. That may be a
> good enough justification for the change itself.
> 

Thanks, I will improve the commit message in the next version.

> Patrick
