Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C031E1DF0
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 04:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772771910; cv=none; b=kDf0iFncOlO7vLfLLiBAWWmXhZ1MhRpfInZDLLAr7CM2hzrW3WEtE5MPnPiii86m6ZgDFlh4Q8jiCYAUH6V2RN/2R5kbRZZZlMPlBUc2zWor/4wpSTyqxZej2Xr85y7EuJuTHK9dTkBAMWT7dL//i4SQ1+hnIs4z2Jbe/rvw0b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772771910; c=relaxed/simple;
	bh=lcieci67R66B3XNKC6ZqCrmPDt3TmIIIRjv0KKo2hhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhqgcNwMIIzQE9Ei7yjmuklkocDYqQXyNMyB3hqa0WBONHrtNgWVw60ZR0QlIBY+ZAbT8K10ZDU4gRGNgtwm4ZjTcXSrVeSu5izyXSvH1Tl99AffJSrlyrp73NCFyaiRIbih4laOYECeCdZAgB3L+i4z8LHQjtSY3kSr95lpYL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FO4LB4lR; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FO4LB4lR"
Received: (qmail 4426 invoked by uid 106); 6 Mar 2026 04:38:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=lcieci67R66B3XNKC6ZqCrmPDt3TmIIIRjv0KKo2hhg=; b=FO4LB4lRc3QNsHEHl61KNA6nQFQ6nONjl1bJ+RnpuSv9mmzxebfqU629NkhCbE9oUxKmSA24p/rZvLv1ZVHJylDIFc0PvdXzGLUs1PHTL+1fOtugw0NaIOpnzMnZunMQAxDLLxc2rjWmLSPv1UMRN54/4gtLkeZnfImFUlI6IX1GqNXLQcDb/H/A5mz9JlR6jQnZOIJYIj20RJBloaGWjSEtfzCCqw/TGRK4TU0Y0/PQn0lI37J9FpmwJ828UMJ9VuTe0B1uFVKMVzvkMlqDvtOdHBX5CBayd0XLZSeCiRDjRYH7jVeEvN+JNOHhEJAymOmROly4sS5+9ldLB6URzA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 06 Mar 2026 04:38:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 397084 invoked by uid 111); 6 Mar 2026 04:38:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Mar 2026 23:38:25 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Mar 2026 23:38:21 -0500
From: Jeff King <peff@peff.net>
To: Ivan Ivanov <qmastery16@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: Test "t0300-credentials" is failing on Arch/Artix: asks to enter
 the Username/Password in an infinite loop
Message-ID: <20260306043821.GA3465674@coredump.intra.peff.net>
References: <CAAaskFBp+A9pOhd8O6owd6k0cDj66ipXrqH2Hj_c7j3d=HM10Q@mail.gmail.com>
 <CAAaskFANnrqTAjQOHhAgzES9=S+y7w9u-LMWbRbi8FayVdvzFw@mail.gmail.com>
 <aaosmo1Iluc5KeZw@fruit.crustytoothpaste.net>
 <CAAaskFC=tpuS-saP9t5Kp0+i6qTHe29x-dGkanyAzz-xaq_HDA@mail.gmail.com>
 <aao1DF3lXfHTMH30@fruit.crustytoothpaste.net>
 <CAAaskFC0WETe7NaEfznW-h53Huee2sLLAQYWBA3moLpeULhtcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAaskFC0WETe7NaEfznW-h53Huee2sLLAQYWBA3moLpeULhtcA@mail.gmail.com>

On Fri, Mar 06, 2026 at 05:14:12AM +0300, Ivan Ivanov wrote:

> Brian, thank you very much for checking my logs: indeed, unfortunately
> my system is Arch-based so we can't compare it directly with
> Debian/rules. Thank you for an idea about /dev/shm , although I would
> like to clarify that while it *might* be what is failing this
> particular test - the causes of failure at .out files are different as
> we could see by the prior 0300/0301/0302 and some future tests (could
> share more logs if needed). But the external appearance of these
> errors (Username/Password prompts) is similar to a user and that may
> indicate some common pattern between the problems, i.e. maybe there is
> some extra shell precaution needed on some systems (although I'm a bit
> puzzled why my distro's packager seemingly didn't have such an issue).

The inability to exec scripts in the test directory is the cause of all
of the username/password prompts. What's supposed to happen is:

  1. The test script creates a script called "askpass" in the temporary
     test directory, and sets its executable bit. That script just
     returns a dummy response on its stdout.

  2. It then sets the GIT_ASKPASS variable to point to that askpass
     script.

  3. When Git needs a username/password, it tries (and this is in the
     git_prompt() function prompt.c):

       a. It runs the askpass program specified by $GIT_ASKPASS.

       b. If that doesn't return a password, it prompts on the terminal
	  using either getpass() or by opening /dev/tty directly
	  (depending on your platform).

Since we've set $GIT_ASKPASS, we expect it to stop at 3a, returning that
value.

But on your system, running askpass doesn't work (I agree with brian's
guess that it is probably because /dev/shm is mounted with noexec). And
so we jump to 3b, prompting on the terminal. If you just hit enter, then
it will not get the expected value; while it may keep running, it's not
going to work. If you manually typed the same response there that
askpass would have provided, the test would probably succeed.

But of course that's silly. The right solution is to use a temporary
directory that allows execution of scripts. And I would expect there to
be a ton of other test failures, too, as many of the tests write helper
scripts and such.

The culprit is the use of --root=/dev/shm here in the package config:

  https://gitlab.archlinux.org/archlinux/packaging/packages/git/-/blob/main/PKGBUILD?ref_type=heads#L71

It's reasonable to point it at a RAM disk (Git's test suite does a lot
of file I/O that gets thrown away, so running on a RAM disk can be much
faster). But it has to be a fully capable filesystem, not one mounted
with noexec. You might want to alert the package maintainer.

-Peff

PS There's one other related tidbit I noticed. These days we have a
   $GIT_TERMINAL_PROMPT variable that tells Git not to access the
   terminal at all. If that were set to "0" then the broken tests would
   not prompt you at all. They'd still be _broken_, because askpass
   would not give the result they expected, but at least they wouldn't
   spam your terminal with prompts.

   It might be worth putting GIT_TERMINAL_PROMPT=0 in test-lib.sh, just
   to prevent accidental breakage from becoming too annoying. We didn't
   do it when t0300 and friends were written because GIT_TERMINAL_PROMPT
   didn't exist back then.
