Received: from mxout1-ec2-va.apache.org (mxout1-ec2-va.apache.org [3.227.148.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED73E31AF30
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 20:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.227.148.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768337825; cv=none; b=u4z8CG21lVvzttZgMpM3IHuMxRYHO37WRA29VH9cHWQduEhRHOBFOmsC1erA25PAcHy1SCPYYDFezREN8e4G5gLUMr3u/RCOK7++/TTkJWYAJe5820GUfRZWeesWM9L76ddVhtCx48/yspv+9j8LFIhAybz22hF9Knbo1dFEZD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768337825; c=relaxed/simple;
	bh=SxNSBHfLhGtlKKdyluHQSXU1lvW+1zZAtsANenghwGU=;
	h=To:Cc:References:From:Subject:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dXz9sNCB+SUM9FKlKOAgAvIgecFZffqDPipXWh7HZOm0BNk7dneL3BJdcuilyhFSQ63vzc6quX9BZIZwZLtFlyqAedBuco/HLPdBDnefwRRkPF3R0PsfUgxRSfCXlE+z90lnnk57+JmcO3hJgUli1JduLW1Hd+D8nB9OTBMk5u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=apache.org; spf=pass smtp.mailfrom=apache.org; dkim=pass (2048-bit key) header.d=apache.org header.i=@apache.org header.b=B5VoGK6y; arc=none smtp.client-ip=3.227.148.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=apache.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apache.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=apache.org header.i=@apache.org header.b="B5VoGK6y"
Received: from mail.apache.org (mailgw-he-de.apache.org [116.203.246.181])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by mxout1-ec2-va.apache.org (ASF Mail Server at mxout1-ec2-va.apache.org) with ESMTPS id B273B4E223
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 20:49:59 +0000 (UTC)
Received: (qmail 2477235 invoked by uid 116); 13 Jan 2026 20:49:58 -0000
Received: from mailrelay1-he-de.apache.org (HELO mailrelay1-he-de.apache.org) (116.203.21.61)
 by apache.org (qpsmtpd/0.94) with ESMTP; Tue, 13 Jan 2026 20:49:58 +0000
Authentication-Results: apache.org; auth=none
Received: from [IPv6:2001:569:bef2:d200:63e1:9891:d2d4:fc0] (unknown [IPv6:2001:569:bef2:d200:63e1:9891:d2d4:fc0])
	by mailrelay1-he-de.apache.org (ASF Mail Server at mailrelay1-he-de.apache.org) with ESMTPSA id 80A5A42698;
	Tue, 13 Jan 2026 20:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apache.org; s=mail;
	t=1768337398; bh=9DKSXPcoZtLALp1fi8Xom01IONYOUgNhRTWNzcx3xM4=;
	h=To:Cc:References:From:Subject:Date:In-Reply-To:From;
	b=B5VoGK6yw1bWYWTIYMsKSf6WsVAN09Vjl+zrsNGxUF2rJtLmKKiwBYZBAa1PwfR92
	 wD88a/mH04fTNvKJkfYP3nQ9Q8rOCBgg5jDJbg4teWAKOG5ikT82wxA5o4VBlBefDu
	 iqpUggAstmfUa32c7vyklMiGgUkB3BFiFR1do6lzYAWDB5PB0PlfYwPwViw8E+XFbc
	 jZcK4WgnuCkGv8ffTR3nppsQhhQsaqbf3MUKjA1rsguIqAOJo6SI7J10llyaWDJRlv
	 xxflzgTVqUJTv6glaTJsOVbaUmCni77Op6vqueyN1sv16zn1quS3UnmnVPbT4B2JkI
	 vOqoNAjF6cl4w==
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
 Chris Darroch <chrisd8088@github.com>
References: <ab578804-891e-edcc-12a6-8b1030d1bacb@apache.org>
 <87y0m1onad.fsf@gentoo.mail-host-address-is-not-set>
 <87pl7diti0.fsf@gentoo.mail-host-address-is-not-set>
From: Chris Darroch <chrisd@apache.org>
Openpgp: preference=signencrypt
Subject: Re: pre-push hooks and stdout regression
Message-ID: <86fa98ad-973c-ea5d-e0c7-fe092747a874@apache.org>
Date: Tue, 13 Jan 2026 12:44:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.7.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87pl7diti0.fsf@gentoo.mail-host-address-is-not-set>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adrian:

> On Tue, 13 Jan 2026, Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
>> On Mon, 12 Jan 2026, Chris Darroch <chrisd@apache.org> wrote:
>>> Hello --
>>>
>>>    I'm one of the current maintainers of the Git LFS project, and we
>>> happened to notice that a recent change in Git's "master" branch has
>>> introduced a regression in our test suite.
>>>
>>>    Specifically, with commit 3e2836a742d8b2b2da25ca06e9d0ac3a539bd966
>>> ("transport: convert pre-push to hook API") from the "ar/run-command-hook"
>>> merged last week, it appears that when a pre-push hook such as our
>>> git-lfs-pre-push program runs, messages it writes to its standard output
>>> are now delivered to the user's standard error stream instead of
>>> their standard output stream.
>>>
>>>    I suspect this is because the pick_next_hook() function in hook.c
>>> sets the stdout_to_stderr flag for its "cb" child_process argument,
>>> and that function is now used to run the pre-push hook.
>>>
>>>    Arguably, the Git LFS pre-push hook program should write its
>>> progress meter messages to stderr, but since at least 2017 it appears
>>> we have used stdout for this purpose:
>>>
>>> https://github.com/git-lfs/git-lfs/commit/d665f7d725150761fe3b196da2c2d4448f7d2c61
>>> https://github.com/git-lfs/git-lfs/pull/2732
>>>
>>>    We can certainly work around this change in the Git LFS test suite,
>>> since our progress messages are still output by Git, just to stderr
>>> instead of stdout.
>>>
>>>    However, I think there remains the larger concern that users who
>>> depend on the existing Git pre-push behaviour in some way may also
>>> encounter regressions, perhaps because they expect (as our test suite
>>> does) to see certain messages either output or not output to stderr
>>> during a Git push operation.
>>>
>>>    Please do let me know your thoughts on this subject!  If the
>>> consensus is that the new behaviour is correct, we'll adjust our test
>>> suite to match it, but I'll wait to hear the outcome of any discussion
>>> before making that change.
>>>
>>>    Thank you again and all the best,
>>
>> Thank you for reporting this, it's exactly the kind of regressions I'm
>> looking for and the reason I did the "Extending git without breaking it"
>> presentation during the mini-summit a few months ago (video should be
>> online).
>>
>> I tend to agree with Brian that going back to the previous behavior is
>> best for now, maybe schedule a breaking change or extension to make
>> hooks to print to stderr instead of stdout.
>>
>> I will test this on my parallel config based hooks topic towards which
>> this conversion is building up to and send a patch or report back ASAP.
>>
>> Of course I will also run the git LFS test suite to confirm the
>> regression and the fix.
> 
> I couldn't reproduce the git-lfs test failure using the public tests
> from the git-lfs repo (they always pass), however this patch should fix
> it:
> 
> https://lore.kernel.org/git/20260113115633.230479-1-adrian.ratiu@collabora.com/T/#u
> 
> Chris or Brian, can you please confirm if it works? Much appreciated.

   Thanks very much for taking a look at this!  I can confirm this
initial patch works to resolve our Git LFS test suite failures.  I'll
keep an eye on the subsequent patch proposals and try to test them as
they are developed.

   For reference, the Git LFS test suite failures occurred in places where
our shell tests happened to only capture messages from "git push" commands
on stdout, instead of capturing both stdout and stderr.  For example,
the "fetch: setup for include test" test in our t/t-fetch-include.sh
script was failing at this grep(1) command:

https://github.com/git-lfs/git-lfs/blob/1f2f7c697b5568b4bf1ed76e7ed4115dd1f0b3ba/t/t-fetch-include.sh#L39

   One can run these shell tests by entering the "t" directory, e.g.:

$ cd t
$ make t-fetch-include.sh

   (Confusingly, the Git LFS project also has a bunch of Go language
tests which "make test" runs if you're in the top-level directory,
while "make test" in the "t" directory runs the shell test suite instead.)

   Thanks again for taking time to help resolve this issue!
All the best,

Chris.

-- 
GPG Key ID: 088335A9
GPG Key Fingerprint: 86CD 3297 7493 75BC F820  6715 F54F E648 0883 35A9

