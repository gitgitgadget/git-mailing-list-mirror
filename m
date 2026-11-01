Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793526432;
	b=02bpa0Cxqn0+6X/1Le58ccVplbV90ShYr8MLuoWAoyN3c7/ZGQfVcF8+w8934QeiYJPz
	 yy+TfGGvF75+CAGHUwf80uBVMQSYauUpdRP95HLopGeFj0Uzh9hHIzmBl7KmwWUvWa/Ko
	 x2Du0UaucnKxwHtoOgB8IJ232J64IdwjvLULRgcNsYw20G6cliIjXjXja/746gRbjgj6/
	 6RPCnUDtgSPGJ1JP2iRe8Z7TsgWv+4spROGSFLii9witgPzSWDuj9l+H4KnoUl77SsBKO
	 zEScdvnCHxNmCQN6b9En/7omBoQnmyspe8U1u3WnVSNGQCwqfgUozvPENgXxTkcLz7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793526432;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:X-FEAS-BEC-Info:
	 X-FEAS-Client-IP:X-FE-Last-Public-Client-IP:X-FE-Policy-ID:
	 X-FE-Hostname:DKIM-Signature;
	bh=QWKz4E8sZ9/UH83FCDsXI2bKepPdksL6xQN0JUEcjkE=;
	b=MI7AQqF3MbMZC5/q36pkuftsf7SjfuyygcZSMUkFmwCSop6iL6BEkZUuJZQVCU62TQwY
	 OTGlaAxnBGUk0LVNzjFE2idSwQew7wveQz6bMlPCkD6yQSx6816EGmR9qF0mVaN+saj1P
	 GpLTF50WNPhROo8w9seaUdir6875qzp2cZKlZmA/tXbzydfQvMnO2MRnuZyplzFRWWvw/
	 hevLvF1GYnjoK/BZlawPODmfYVjpC44nXUQgOGWRByzZlqYvy0kURgQYMRTT3rsI0S+Tm
	 CMKiiEZviSItX2dD7cqAlGVFDK3krPj+lU7OnYHJ7+IAwTjtilbBFWpBkbYphI60n/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=AzMp0Jmc;
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127AA606A325
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 09:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 127AA606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=AzMp0Jmc
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 6A19ksCC018582-6A19ksCE018582
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 1 Nov 2026 11:46:54 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xNS9O-00FiaD-7m;
	Sun, 01 Nov 2026 11:46:54 +0200
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sun, 1 Nov
 2026 11:46:53 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id cc3df952;
	Sun, 1 Nov 2026 09:46:53 +0000 (UTC)
Date: Sun, 1 Nov 2026 11:46:53 +0200
From: Tuomas Ahola <taahol@utu.fi>
To: Junio C Hamano <gitster@pobox.com>
CC: Linus Torvalds <torvalds@kernel.org>, <git@vger.kernel.org>, Linus
 Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] describe: count the distance correctly when commit
 dates are skewed
Message-ID: <20261101094653.NKAEk%taahol@utu.fi>
In-Reply-To: <xmqqa4nt2wch.fsf@gitster.g>
References: <20261031065525.19883-2-torvalds@kernel.org>
 <20261031123149.yxap3%taahol@utu.fi> <xmqqa4nt2wch.fsf@gitster.g>
User-Agent: s-nail v14.9.22
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: ex19-16.utu.fi (130.232.247.56) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhaUUgcBxoeCQQMGygEAQYdEEUO
 Bx0GDAkcAQcGRgcaD0hYSFpIWVxIWVtYRlpbWkZaWF9GXF9IUEhYSFhIXEhYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWV9IDwEcGxwNGigYBwoHEEYLBwVI
 WEhZUUgcBxoeCQQMGygDDRoGDQRGBxoPSFhIWlFIHAcaHgkEDBsoBAEGHRBFDgcdBgwJHAEHBkYHGg9IWA==
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=QWKz4E8sZ9/UH83FCDsXI2bKepPdksL6xQN0JUEcjkE=;
 b=AzMp0Jmc66qm+rjCy1GvFA0L0gsYJsp1noD0HneOTNuEQDZxXZBYeBolrtY7tBwCqzNyeKmqqz8w
	JGQTdUPJIA1CTJcdcpK6+ojcJW6NwfLjfgcuRpDzqs5GSfVWWrbA9Gn0vCZ8F/XHVCGeJB3958qf
	6m0ngbSjptB7/5m0891xjfuV+Tqikn2vHoTK9dffzyNNBKZc5rOPFZl/OdJkpKV8MWVN8CKITn6Q
	F3+kh3gIUdMEH2jYqWDNcMz+ZzzSznL2w0NLlBwoUqFp9yoKA+ogwFMQvV1jbHaYvMfLNUyTvb5k
	peL1QeHvbFBmk4GnP+B8lPpcOdT+cvVIxzYDNw==

Junio C Hamano <gitster@pobox.com> wrote:

> Tuomas Ahola <taahol@utu.fi> writes:
> 
> > Linus Torvalds <torvalds@kernel.org> wrote:
> >
> >> ---
> >> +test_expect_success 'setup: describe a tag dated before its parent' '
> >> +	git init skew &&
> >> +	(
> >> +		cd skew &&
> >> +		git config core.commitGraph true &&
> >> +		test_commit --date "2020-01-01 18:00" base &&
> >> +		test_commit --date "2020-01-01 18:01" o &&
> >> +		test_commit --annotate --date "2020-01-01 17:01" T &&
> >> +		git checkout -b side o &&
> >> +		test_commit --date "2020-01-01 18:02" B &&
> >> +		git checkout main &&
> >> +		GIT_COMMITTER_DATE="2020-01-01 18:03" git merge --no-ff -m x side &&
> >> +		git commit-graph write --reachable
> >> +	)
> >> +'
> >
> > Just a clueless rewrite of the above.  I had quite fun writing it, so why not
> > to share... it works and might even offer some not-completely-bogus food for
> > thought.
> >
> > 	git init skew &&
> > 	(
> > 		cd skew &&
> > 		test_config core.commitGraph true &&
> 
> Doesn't this barf when it tries to register a clean-up action from
> inside a subshell?
> 

Hmm, only in Bash---something I forgot to test.  This of course fails properly:

	$ make -C t/ SHELL=bash t6120-describe.sh 

> > 		test_commit base &&
> > 		test_commit o &&
> > 		test_tick=$(($test_tick - 3600)) &&
> > 		test_commit --annotate T &&
> > 		test_tick=$(($test_tick + 3600)) &&
> > 		git checkout o &&
> > 		test_commit B &&
> 
> Quite honestly, I do not see much value in this rewrite.

Well, I did prepend the code with a "caveat lector", quite aware that the
rewrite was somewhat pointless---if it had contained any good parts, that
would've been by sheer luck and happenstance.

That said, I actually tried my best, and I am quite happy that you gave that
clueless waste of time a serious review.  Thanks!

>                                                    [...]  Explicit
> dates and times from six years ago will eventually become distant
> history, but at least they made it clear, even in the source code,
> which event was recorded with what exact timestamp.  In the
> original, it was much easier to tell which commit had a newer or
> older timestamp than in the rewritten version.  Can you tell if the
> annotated commit 'T' has a timestamp older by 3600, 3599, or 3601
> seconds than the next commit 'B', just by looking at the sequence
> above and without inspecting how 'test_commit --annotate' is
> implemented?
> 
> Unless the focus of the test in question is "I do not really care
> what time they record as long as they are reasonable and
> reproducible from one run to the next", relying on $test_tick is
> probably counterproductive.  The test for this fix, where the issue
> is entirely about the relative ordering of timestamps on the
> involved commits, is a prime example of where using explicit --date
> options would make things much easier to understand.
> 

Okay, I'll be wiser next time.
