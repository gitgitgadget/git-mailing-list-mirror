Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528BA4D8BA
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 15:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871099; cv=none; b=Xp2cPSPbJsdTSA2Yh3mT8mONXQyHXMzeTlHKC8iYAYxXNPrkJ6kHehy26VIB+8hJKR7HeYJ5v3+Z2qFUstuZumCrIH8AEZ3jMIYE5aqeFnNEHjagjfedWJ/+MkDGWXF3NUBlYnc4hFnZ/iu55BgKUXbkNjE/0lFNU2slsQBuwGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871099; c=relaxed/simple;
	bh=5a7w6V+td4Ce+xN3LDw8KmQ0T/B/xALU4O10JR5Y8Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2RcBEI1wIS4sg4o4IzXuqiAy45An4GrsvWeOlhDwIqzuwQ+Pn1RknXsuKBbidAQiIh5z9BLNk3FaZ4/0eKQmeKDXW9bgpOtCE9LplH6JSeySFpz9TOMPdFAG/6ZuN/Lqyp0pdoCtHUTeeIz+53Vj9aCBNaDQ2863ryTYsz7p/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhJvJXrm; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhJvJXrm"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70d333d57cdso7517880b3a.3
        for <git@vger.kernel.org>; Mon, 05 Aug 2024 08:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722871097; x=1723475897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NgD6ZIpdd1lefNYd5oLJSAYbFGhU2Lh0H8ixftNnTE0=;
        b=LhJvJXrmBQzYIEfgCMjfVMglY5FZLrEoHV+inizA+89+ZN9Hk4HOL2Ev1Jp/O2wYmF
         ksEXjdAsMBrh3Dqr8rkcaL8ssJbu+rWbwQdEmK9ISMaIoEd/f4CogS8nxFsDNSO9y9iE
         UUFKmPdO+D+KOFyRdB+SoY9sU4iT1KbHiikZXou2PdkhBtZFlxai9S7pkE+JMjmD/lWS
         mmN8HjvZUWtgm4JRRfIey+qqVs9H62NzLkJYtvMiidZVt/J6YmhZN+39J0Yk/OK15W+J
         PWy6A+t1tg+WhnTwbj0WGGv1gXEdvdUhZw/S/jdJPKEDjXA2YFGQh1ICsIy1UF43z7Ao
         Lq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722871097; x=1723475897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgD6ZIpdd1lefNYd5oLJSAYbFGhU2Lh0H8ixftNnTE0=;
        b=ApXKCpECCAe/IP/HWJxBlFOTEFrXZTVFNTK8mCbJlB4y0tPCmgrm6zJcMjIRVmNg/T
         Tsanv6xuYkLAAYq+IUQ4t68AdWurnYD5IWEjT4E/dkegcO1blD5xOX8VgLH2tD5Dljfu
         0QTEnfsJduVw22fGLMclhGreCI8gHorRzzV6mtY6xI3aKZ6Yo8PEbPpVuAuUGQnyrrSD
         eEanzO3jwmoONCFHztGOAq2pDXt2kbn/Y5m1Es72dx19zwCcNJleOVC60Bv6lTQqTQGr
         d2XekspIrOetYJTXa0oOAWfOE0QlnzxBPgkkywDsuatAkx7Yxx5sP8KCTG7TuyeTS3wJ
         WZOw==
X-Gm-Message-State: AOJu0Yw/dfb/CrQRffN7YVK2L7PI7zUQBr+4KRirFOsi6MJOhw3YJ7J1
	IH+nrwtzBzJVrIL+L8K6+251l/0clgNoBRdq2MAo0/+BF2A4dbJh
X-Google-Smtp-Source: AGHT+IGs/mkVa/ui8602NjTk2UAzGngZug1KQO0JvI+8Vw2uUPGH2KEpfOJsdWRkxWRosyeGkFVF3Q==
X-Received: by 2002:a05:6a20:db0a:b0:1c2:8949:5ba1 with SMTP id adf61e73a8af0-1c69966b82bmr9401557637.53.1722871097486;
        Mon, 05 Aug 2024 08:18:17 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ecfd1d4sm5522114b3a.163.2024.08.05.08.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 08:18:16 -0700 (PDT)
Date: Mon, 5 Aug 2024 23:18:44 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v14 09/11] builtin/fsck: add `git-refs verify`
 child process
Message-ID: <ZrDtVJYoJJZDesB4@ArchLinux>
References: <ZqulmWVBaeyP4blf@ArchLinux>
 <ZqumdJz3-0mqh6Rc@ArchLinux>
 <ZrDMdEJR6DV5HyLD@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrDMdEJR6DV5HyLD@tanuki>

> > +static void fsck_refs(void)
> > +{
> > +	struct child_process refs_verify = CHILD_PROCESS_INIT;
> > +	child_process_init(&refs_verify);
> > +	refs_verify.git_cmd = 1;
> > +	strvec_pushl(&refs_verify.args, "refs", "verify", NULL);
> > +	if (verbose)
> > +		strvec_push(&refs_verify.args, "--verbose");
> > +	if (check_strict)
> > +		strvec_push(&refs_verify.args, "--strict");
> > +
> > +	if (run_command(&refs_verify))
> > +		errors_found |= ERROR_REFS;
> > +}
> 
> Okay. I think that it's sensible to execute this as part of git-fsck(1).
> But do we want to provide an option to disable this new check, as well?
> 
> It does feel a bit like opening a can of worms, though. None of the
> other checks have trivial ways to disable them, and git-fsck(1) is
> gaining more and more checks. So if we can disable ref checks, we may
> also want to have options to disable checks for objects, connectivity,
> reverse indices, indices, commit graphs and whatnot. In other words, in
> my opinion we need to think a bit bigger and design a proper UI around
> this.
> 
> But I don't think that should happen as part of this commit series, as
> it is already big enough. So either we just accept this patch as-is. Or
> we evict it from this series and handle it in the future together with
> all the other taks that one may potentially want to disable.
> 
> I'd rather pick option two.
> 

After talking with Patrick offline, we decide to drop this patch. At
current, we should put this change slowly for the user. Because many
people use "git-fsck(1)", currently we don't have a way to disable ref
checks by default. It's a little beyond this series.

We may consider later.

> Patrick
