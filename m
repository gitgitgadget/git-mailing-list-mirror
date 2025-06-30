Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3025A242905
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 12:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751285909; cv=none; b=Eo1BzDDaMzWHzm+3yhOIhKTaZldck1sTgfUucfKfH0ZcM1wCE1uFtDJxb8pXuYL5MQFYnwNMZIAH0x12KNeGB1tXJQS+cLHIqD+AAm6gV8uvO6tzlWOfmn4KiJpFNAJKd+TT74/RX1t0nhQD3xp8hGqeqttJxKGNKPBdbJUQj5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751285909; c=relaxed/simple;
	bh=uDJdIJkkc2xuXY8ak48EGeliVd2JNS6eJ2YxzpjZfdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+K+b7MV+CsMTkvvhg1bXgtmS/Lg9PwIStaWhVeKex2bFBc3Rwxlnyml3ekCw/JbWWAHgINjqaDqUPcpy908TcOXzep8HUB3Pvn+iXzve8KD0+RjshOvUc+qEmBsS7PJ9UB2cwuKX8SX0ym4Vj8M2x8ULfZ1v44SgCLigQ3LpNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSEDPAB+; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSEDPAB+"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7fd581c2bf4so1741505a12.3
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 05:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751285907; x=1751890707; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mcjAUWrMKh1mAfqSHvvcc8JrO/MnPyxVNqvZp14aUPs=;
        b=eSEDPAB+9GigjKDzqwqD7sHRpufP86lUdvuh64ThP9QUx4tR4/IZgAArDydokbvbpE
         dgdP1nO6HrtBXFMmH44NVyQjow1UK8wVM7CRqiw9V+Ccx/zt5QbtqYtLoc5d1F6kuWNr
         ganRcHh+JTb0crDMth+GJlMlrauMMZq3BPvmIlCbdcHwgELJYGNY45E/Buv0kHzZwEJ3
         x+vWYeNwfM7Cg9Oh6hWMZx9you1gRO8wLNqj+DOacyag9KPC5cN3Nt5mRgI4DWpw31C7
         VgmbXZd8ukEDZI+mEtcJ9kPjrnHoAl2BEkjUk8iUsBTRIN/8bCEXtbdXqU6Vocim7iDh
         oZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751285907; x=1751890707;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mcjAUWrMKh1mAfqSHvvcc8JrO/MnPyxVNqvZp14aUPs=;
        b=DCdxstbi3h5w6TBYS06sVI2RIEi+l0skvwLmYLGORAxJd3057HpXErwuz/KzjM9oc9
         H0c23aIKtLJl6nwl9q65Id260LKctbHNX5lxHjkQUTODsI7MWbz9wP8MYnqeXdldBslr
         UbDfh9V1uBtyaraGWx5qT5FY9bzXQD7vBcA3Lvwgh+Umshs6+17vTLbKKiF7m6EYp8H3
         xrAtltdJQOrRd5qASmlI1hd27Fg5Uv5NnI+uBbR3DskaZMgapYCqdgwzQqZHf6DafnAG
         aSksiDvESsIiz4v1Vwrf968BGaJdo5wjuwp1SS/gzdQvWmz/IJeVSVSKqOq0n5huJMto
         3vYw==
X-Gm-Message-State: AOJu0YymgG31E38HHXZdPC86bIdCOKZP6ei3bT72JY3DZcgoT039aQOT
	YelxkVyF1Wsc3DaFgN+EXmH77sSmLRdEvjmJEE2k+qAG5571p5R6/ES/LDoiug==
X-Gm-Gg: ASbGncvyic/+rGyqnD5igHaM8KuFaOJNhgptXjvkJBt8MCNnHZZ3d8B287W2l+Y0XfB
	984M+Dyds/jbPWegLbjSmpdjwpsQhcxQ+EK+IvM/8YGB6VyVg2Nvi5xApVzLKG1GmWmZ7ciFrYx
	Wg4fCOiEQF9c9VYlpMJw9P45cA55WLF/dQ8EGYxC8H52k32bDJkMbTHEoy+jE9QBj4U/QhQNF+o
	VRTt5Xm8Ye9q9YSirFVARXRvHNiwgcIinnA80BnQx2C0h5Qv7aNx7nMeWvuuO/lDxzZRn1EVdzy
	pfGDYksNA2Fj8mOR91LbYNBhMCoswPL5BYSkes3uwd5diQKZ5hKv4+Q/z/qzkqrzDPiAhJMjhqQ
	+YW49NYW982XMpzXBDgP44xgiWzIrSCz1RQ==
X-Google-Smtp-Source: AGHT+IEwsG3i/qLexsduizbXt0AR77XbDuGXVVkX6ORf7LM59q9jpp6VTkZ6tUvQCgCch3LMtynWnQ==
X-Received: by 2002:a05:6a21:7316:b0:220:82c7:309c with SMTP id adf61e73a8af0-220a129c4a9mr22111299637.7.1751285907260;
        Mon, 30 Jun 2025 05:18:27 -0700 (PDT)
Received: from Carlos-MacBook-Pro-2.local ([2601:640:8e80:3680:edb3:4a4e:9234:fe40])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e31bea22sm7971690a12.38.2025.06.30.05.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 05:18:26 -0700 (PDT)
Date: Mon, 30 Jun 2025 05:18:25 -0700
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, "Stephen R . van den Berg" <srb@cuci.nl>, 
	Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] daemon: handle EINTR failures from waitpid()
Message-ID: <bo6mr2zqf32wh6nxu53aoowy4xxcu3vle2wbepnbmyphe6b2tl@pofvznggzjui>
References: <20250630041303.93370-1-carenas@gmail.com>
 <16612f65-80ff-4162-a1df-31c2777eb848@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16612f65-80ff-4162-a1df-31c2777eb848@gmail.com>

On Mon, Jun 30, 2025 at 10:00:09AM -0800, Phillip Wood wrote:
> 
> On 30/06/2025 05:13, Carlo Marcelo Arenas Belón wrote:
> > Since 695605b508 (git-daemon: Simplify dead-children reaping logic,
> > 2008-08-14), the logic to check for zombie children was moved out of
> > the SIGCHLD signal handler, but adding checks for a failed waitpid()
> > were missed, with the possibility that a badly timed signal could
> > prevent the promptly reaping of those defunct processes.
> > 
> > After the refactoring of 30e1560230 (daemon: use run-command api for
> > async serving, 2010-11-04), that reproduced that bug, a single
> > process could be skipped from reaping, so prevent that by adding the
> > missing error handling, and while at it make sure that ECHILD (or
> > other errors) are correctly reported as a BUG().
> 
> I agree with you analysis, I've left a couple of comments on the fix. I
> noticed this when I was reading the code to see how well it handled EINTR
> and decided it wasn't worth worrying about as we still collect the child the
> next time we call check_dead_children() but there is no harm in checking for
> EINTR here. It might be worth noting in the commit message that the linux
> man page for waitpid() explicitly says that EINTR cannot happen when WNOHANG
> is given though. I wonder if that is the case on other platforms as well
> because the calling thread is not suspended and EINTR is usually associated
> with calls that block.

I wasn't aware of the comment in the Linux man page, and didn't see
something similar in the ones I checked or the POSIX specification.

If WNOHANG prevents it from returning -1 with errno == EINTR, then my analysis
is incorrect, and the last refactoring is the only one to blame as it didn't
add error handling from ECHILD.

More importantly, if we consider that regardless of the coment in the Linux
man page (google found something similar in the one from zVM) that behaviour
is implementation dependent it might be worth to fix also a similar use case
in run_command.

> >   			cradle = &blanket->next;
> > +		else if (errno != EINTR)
> > +			BUG("invalid child '%" PRIuMAX "'",
> > +			    (uintmax_t)blanket->cld.pid);
> 
> POSIX says pid_t is signed so I'm not sure about the unsigned cast here.

but that is only so that a `(pid_t)-1` is valid AFAIK, and all "real" pid
are expected to be positive (even in systems where pid_t is a 8 byte long
like Solaris).

casting them to unsigned to print them and using a uintmax_t for it was
how all pid are printed since 85e7283069 (cast pid_t's to uintmax_t to
improve portability, 2008-08-31) AFAIK.

> Do
> any of the platforms we support have a pid_t that is wider than a long
> integer?

the ones in AIX are pretty long, but definitely no longer than INT_MAX (with
pid_t being 4 bytes long there).

Carlo
