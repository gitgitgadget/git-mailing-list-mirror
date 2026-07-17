Received: from aburayama.m.codeberg.org (aburayama.m.codeberg.org [217.197.91.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D23F507
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 00:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.197.91.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784247601; cv=none; b=LdC49UR5GMY7KavUvzQ4JPuRVzz4VYRxvFYdg2RsX9npnSuQ5rfoQAvzGCXFLU8hKgCz7AsQM1NbviTrW3OzIyq0fb9u+2V8ARCcb/a5PyXQ8Mueh9MKial3pEAHEULF9DvFq8VhgYDRxjJS8DFPhHqdOY9ykP+h4Byzy7BF3AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784247601; c=relaxed/simple;
	bh=YfGVkhDfg44kFfeHPGwlfLn7DaHM9B63ftpiw5PUqjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pMO9eWtDS1Yp6SlpTHWlOsruf5EPU1/ANkTGkSpzcywq5ZnPp5Ai5sOVcHK5lSHSuFMSNQpmrAZ+0soRJ7cZv65Bbb/6ecuiQIUYDIlOj2+jC2WmGZUMUDHse9AjrEy2X2E/sfbHBNqU5QjH4LSm/JMGgD9MXCRrd0QxKObToo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codeberg.org; spf=pass smtp.mailfrom=codeberg.org; dkim=permerror (0-bit key) header.d=codeberg.org header.i=@codeberg.org header.b=K3pf+2X5; dkim=pass (2048-bit key) header.d=codeberg.org header.i=@codeberg.org header.b=oyKCRH3x; arc=none smtp.client-ip=217.197.91.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codeberg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeberg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=codeberg.org header.i=@codeberg.org header.b="K3pf+2X5";
	dkim=pass (2048-bit key) header.d=codeberg.org header.i=@codeberg.org header.b="oyKCRH3x"
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=codeberg.org; c=relaxed/relaxed; r=y;
	h=From:To:Subject:Date:Message-ID; t=1784247590; bh=9oiw6HxuJJ/rpDQ1uUfcDg0
	avwdh0cQTVSKSFtE71yc=; b=K3pf+2X5yU7mweXRSUXh4jYvguk7/MAf+W6Z1XI57bNJveaNmT
	lHkpjouiQNt5WDkUCVP86+QZLIo8B5Iw9jCw==;
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=codeberg.org; c=relaxed/relaxed; r=y;
	h=From:To:Subject:Date:Message-ID; t=1784247590; bh=9oiw6HxuJJ/rpDQ1uUfcDg0
	avwdh0cQTVSKSFtE71yc=; b=oyKCRH3xdec1i/MJoNyd/7bCigubDi4/dOgbd44a+qHZ/NoyN9
	F31CxkeovXjNiecrujGn/WuimSVXXuZCAEFq1LN8j1+hy83ry/Vzxa7W2riph3OzCIhzhvZPYP4
	3pcqFAZjeTIkZ50cTLD1tNpzYZPxwRPjlApnK/lyaIPJppBk/DbaAgo45K1q30AJZXr37wqSh8c
	KMUBLPw52NYz1m7w8Gb6W1DtnqxbexP8A58Su6zy3uRO8QQrxNStCukfkD+79arw6ZZDsBP8iLK
	TEr1oCE5RsakS5twh3krEaE6L9REz69TMYnUU+v9GKVJNurwtP/Bl7oR6VhwmELdGmQ==;
Message-ID: <6491c7e6-9310-4a5e-8ba5-9d3a2e7e3312@codeberg.org>
Date: Fri, 17 Jul 2026 02:19:49 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git-last-modified(1) slower than git-log(1)?
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
 Jeff King <peff@peff.net>
References: <17f356ff-7bfb-47f5-b714-62a95cc8b821@codeberg.org>
 <87v7afffpa.fsf@emacs.iotcl.com>
From: Gusted <gusted@codeberg.org>
Content-Language: en-US
In-Reply-To: <87v7afffpa.fsf@emacs.iotcl.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/16/26 11:26 AM, Toon Claes wrote:
> Hi Gusted,
> 
> Thanks for reaching out.
> 
> You're actually not the first to notice this, and I've been aware of
> this.
> 
> The thing is, you're testing the difference on a single file. For us at
> GitLab, it wasn't very useful to optimize that use-case, because usually
> we want to see the last commit for a bunch of files at once.
> So the use-case for git-last-modified(1) for us has been to replace
> (pseudo code):
> 
> $ FILES=$(git ls-tree $COMMIT $PATH)
> $ foreach $FILE in $FILES; do git log -1 $COMMIT -- $FILE; end
> 
> GitLab is batching files 25 at once, and in my benchmarking, it was
> shown git-last-modified(1) is faster:
> 
> $ git last-modified $COMMIT -- <files
> 
> (I did this benchmarking in our Gitaly component to have a real-world
> experience and you can visit the results at:
> https://gitlab.com/gitlab-org/gitaly/-/merge_requests/7999#note_2850505479
> )
> 
> So we left the door open for future improvement, although I never have
> gotten to it. At some point I was trying to chase down when git-log(1)
> was doing differently, but I never figured it out.
> 
> But this email challenged me already. And with some help of AI, I
> managed to work on some improvements. You can expect a patch series
> soon.
> 
> (Right before sending out this mail I noticed Peff sent out some changes
> as well. I'll coordinate how to combine.)
> 

Hi Toon and Jeff,

Thanks for having a look at this!

The use case for Forgejo is the same as Gitlab then, we only use it to
get the last-modified of each entry in a directory. Looking a bit closer
I missed that in Forgejo's code it's considered the output might not
have the answer of all entries, and happily calls it as many time is
needed on the 'remaining paths', especially when using gitlab as
repository this required a lot of git-log calls.

Looking at the mentioned benchmark, yeah this is where Forgejo's
implementation with git-log would fail in terms of performance
(seemingly even slower than doing N-1 git-log calls, by using your
benchmark numbers). It's somewhere in the minutes :')

Kind Regards
Gusted
