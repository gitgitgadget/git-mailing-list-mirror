Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D6D429004
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 19:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798020; cv=none; b=hfXCD1IkqwFjLHsiDpXD4MFNY7ieadn/s8fwAxZK1gOgik8dxaanqIitHfWOgU26DYQjOu/auhE6mFDYGauqN9/sF2qG8XFP1anIqq2x4FHLF47kPgJ/jNgCCH82CGzR2pjj8ahWxVnh3+RuQFBRfRhNuW4kXT8QNVAPGjnjIlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798020; c=relaxed/simple;
	bh=ibsRVdV2+WlCzGOJ5Ea7Xfb32tVYqybhlm1QQyr7W2U=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pFFTZQwCVp15YHR2UZ495m5pVO7aluD6y4LGzgqjKaRnXkmIpoSUYWoyYzbhlMtcJ8F6piD0CnqTQaruVb0qpnvfCjP2qzcIWB5II97yfLfYmNA50NkUj7K9A9UbDo1B4md5GdUQir/GzMklPqy0+C7RWUfYG1PEvPntWHDWJKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=qrCDMOCC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KT71D0qQ; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="qrCDMOCC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KT71D0qQ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id C54331D00064;
	Wed, 30 Sep 2026 15:53:37 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Wed, 30 Sep 2026 15:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790798017;
	 x=1790884417; bh=7Rhm6exNEaJFj2cXfe4B7+rQqythertiDkgVjTmsiY0=; b=
	qrCDMOCCdGZCk5qIofXU+cGvb/4PPfUrrOhAba5sAg2c1Ylp35L2qJ2XhTjAMLTc
	MZg3zTv/7GkgSWBkoIZka+fhoyLacJPwnjFDkIQVGekSVJEZbsJB+VXTu3ZX4bPJ
	I8ZRK1uCIq0PLTXzZhRKhcz36BvuJoA1JQWSI+26Pla/lTEAc61uBRbXbBTbMqev
	dih9IS5UuxcMhb0m06pUm06zO57c+bq6auRXRVnpAweOfbXZhbqSjuVcFNEYjvyf
	Yy47KiNF4BiGtT2suC5TfJQBgpEzj4t/gBjmVT12RTMINdNzm4yn/4XtGxU+13W2
	tRkg3wfyLg9EjiKkYql/xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790798017; x=
	1790884417; bh=7Rhm6exNEaJFj2cXfe4B7+rQqythertiDkgVjTmsiY0=; b=K
	T71D0qQ2ynKviUGELGFJN6KwMGDYLrRnu2cA42Rz1ExyJFl+doyml5gtbWHi4UwS
	3EPbQWllUJXYLOmlOOFjxZVCCRWKX7fbiPuvH2SJBNwjxBtvxgxpamU1WCPTC0qQ
	lOhCuzR+QhJwJs2kt63qlBlY8cwR3jKq77kDtha35Ftscj49K271W2E7VbJrab++
	VPydyVO9KnjfK2DPZ6OPAiYZq0+VXfRKPmQIt935q+iGnCK1IaCds5KZKTYABqwH
	bhDcob6Mp9Zju1mEr+9l0cl0c3D6E3ehVq7TWtlb150LQX9bplr/UPa+n7ZiqaM+
	5wmGv2rXtnVaSxhHnlJHQ==
X-ME-Sender: <xms:wWi9ar13PgR5Ymh78AW2rou3j5S10PaN2uwOVJw_HfsfbCG8FhRpaw>
    <xme:wWi9ak6d9xHs1zzaVAyFqO0Kf5MgMBE1paIqXcA0wznQ4T-dL-clKpDqkafDbt43G
    JBxR83jijHKg3HPpUyHfFVWihGPL8c97Do5CfnGPC7iTwqXoe5_VtEU>
X-ME-Proxy-Cause: dmFkZTGZl2VQc8hXVi/2EhBwfszax/jiMzHm63jf/R4jUMDVdEwO3DDPn90uMpsya/uVPp
    Dl68k4Wq7dYW44LwtroVlEu6/uoIo3kEs4E4Fnr0jF4msN7o5pTx8/03El6KKw5itpcsPw
    tWfx7sJZxFBdDylv4iqolW/ry/PyWAEu695yJnRLFLFNkwm4kxDkJPyPA/TvjGQi7k1G0D
    t+5u3niQYWlivJfzp/MEFH/W32PGNTjJf7P38BkksYrHlAzNCCFXQGUt0BDxBV3aKs4F31
    1ZzYYs9Hrh2y3p8qlVxiqtIAzHEEHE53066VY6VZNgvqea3ny1MhINI0lV4iEb2bhPnjHX
    yOd6jNjsX1qE+xObUwRxwoYFlhuWZzUZnI76qSBYHs3lwqobWnmUZcbquSw/wVnnQVTWIv
    lo/XtTbQA6rZISGDotNTAg3PMuP23lbAoQm4VGMntnS3pizFu+JrHwIh2norPFXgBT5nPT
    nrrb3FJX8bhblv3X46tfFdRuSemOiAP0pYJH3414NdK5jkTM2WDyFN483zTGEV0qOvM6Xr
    IQLcclRsiE9zYa9s8rPDAdlvTdOz9OMLzu1Ridi4ZtJ7e7MrwG+ZStMMjR8KTBiLkUAUgp
    d95wePXcqpGJuRhgw4cHlEY2hgrOthsUdOwPMoG9b7rNhLWECc+gf3xsqk/w
X-ME-Proxy: <xmx:wWi9amxOIBf_WtjRVDjxVH3ZEzIf0O1NiUurBS4CNiAXAnxCP4CdRw>
    <xmx:wWi9aqDvkLvsy2sZJHbpJxhL4-g5nz7dKPkcf1AZHVGIrOOUo3UM6w>
    <xmx:wWi9arZC4SWZk1pY9eWTa_JCXwhGpUEfyYA4AVf1LhohO3Wm3QvZXg>
    <xmx:wWi9aqhsMuHAHNXLNR_7vwCQ6hsn1kkYbj6vGRHEp56Gg_u4EtnJ2g>
    <xmx:wWi9akvVFy4s3gR7F5JTbhYZ-kHQ2EILeOmOBREC55EqQ4yYTbrCNys2>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7229C780070; Wed, 30 Sep 2026 15:53:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A4MQIL0NZ3EZ
Date: Wed, 30 Sep 2026 15:53:17 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Patrick Steinhardt" <ps@pks.im>, "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <5ba2088c-4919-465f-8892-4ed0685f81ea@app.fastmail.com>
In-Reply-To: <ar0MVRV5X8zgZfLy@pks.im>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
 <ad4853dc36cdb883c9a8dc6bda747a5ea318e7a8.1790261062.git.gitgitgadget@gmail.com>
 <ar0MVRV5X8zgZfLy@pks.im>
Subject: Re: [PATCH 1/7] [doc] Add new gitmergeconflicts man page
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

>> +Merge conflicts can happen during a `git merge`, `git rebase`, `git
>> +cherry-pick`, `git pull`, or `git revert`. All of those commands use
>
> Should all of these be using linkgit:, like for example in
> linkgit:git-merge[1]?

Makes sense to me, will change.

>> +The most common ways to handle a merge conflict are:
>> +
>> +* Resolve the conflict. (see <<resolve,HOW TO RESOLVE A MERGE CONFLICT>>
>> +  below for details)
>> +* Or stop the operation and return your branch to its original state
>> +  with the appropriate `--abort` command, for example `git merge --abort`
>> +  or `git rebase --abort`. See <<git_status,EXAMPLE: GIT STATUS OUTPUT>> below
>> +  for how to find the command to run.
>
> I wonder whether the explanation should be expanded a bit to briefly
> explain how Git performs a 3-way merge in the first place. I feel like
> it's quite important to understand what the three different sides of the
> merge are to make sense of it.
>
> But I may be too far detached from the "normal" user, so this may only
> cause more confusion for our users.

I think it would cause more confusion. I did some experiments in explaining
merge conflicts using the concept of 3-way merge a couple of years
ago and it didn't go well.

My experience was that what users they found the most useful was
learning about the tools Git offers (like `git diff --check` and `diff3`),
so that's why this document focuses on tools and formatting much
more than concepts.

I think it would be cool to find a way to explain how 3-way merge works at in
this document in some later iteration though, maybe at the end. Definitely some
folks would find it interesting. I didn't understand 3-way merge myself until a
couple of years ago and it was fun for me to learn, but it didn't really help me
use Git effectively.

(this is quickly becoming a bit of a novel, but it's often very counterintuitive
how some facts that seem "fundamental" about how Git works actually turn
out to not be very important to understand in practice to use it effectively.
It's something I find tough to talk about on this mailing list because it's something
I've only been able to learn empirically)

>> +[[markers]]
>> +MERGE CONFLICT MARKERS
>> +----------------------
>> +
>> +Merge conflicts happen when both of the sides being merged edit the same
>> +area of a file. When this happens, Git will update the conflicted file
>
> I wonder whether we want to use "hunk" instead of "area". It's jargon
> again, but I have never heard anybody speak about an "area" before
> myself.

Ah thanks, I think I took "area" from the `git-merge` man page.

I looked up how I explained this previously and I used "lines of code",
which I think communicates the same meaning without the jargon.
I'll try that instead.

>> +Note: During a `git merge`, `git commit` and `git merge --continue` do
>> +the the same thing.
>
> s/the the/the/

Will fix. 

>> +to include merge conflict markers `<<<<<<<`, `=======`, and `>>>>>>>`.
>> +For example, here's a merge conflict where both sides edited a list of
>> +fruits in different ways:
>> +
>> +----
>> +FRUITS = [
>> +    "apple",
>> +<<<<<<< HEAD
>> +    "cherry",
>> +=======
>> +    "banana",
>> +>>>>>>> add-fruit
> Hide quoted text
>
> A bit of a tangent, but sometimes I wonder whether we should make the
> respective commits a bit easier to access. For example, we could put the
> equivalent of `git rev-parse --reference <commit>` here for each of the
> sides.

Personally I'm not sure if the commit ID would do much for me, but I feel
like it would help me if it were possible to include the commit message. 

> I tend to forget that by default, we only render ours/theirs in the
> conflict. I always feel like that makes it way harder to resolve
> conflicts as you don't have the context of what the code looked like
> originally. So I have diff3 configured locally for ages.

Every time I show people diff3 someone tells me how happy they
are to learn it :)

>> +* There are many graphical "merge tools" for Git, which will normally
>> +  show you the different versions of the code side by side.
>> +  If you have a mergetool configured, `git mergetool` will launch it.
>> +  See also `merge.tool` in linkgit:git-config[1] for a list of
>> +  the mergetools Git supports.
>
> There's also `git merge-tool --tool-help` to list all available drivers.

Oh, cool! It's fun that it autodetects which ones you have installed
on your system. I'll suggest that.

>
> [snip]
>> +[[ours]]
>> +"OURS" AND "THEIRS"
>> +-------------------
>> +
>> +Git refers to the first part of a merge conflict (between `<<<<<<<`
>> +and `=======`) as "ours" and the second part (between `=======` and
>> +`>>>>>>>`) as "theirs".
>> +
>> +Normally, "ours" is the commit that was checked out before you started
>> +the merge, and "theirs" is the other commit.
>> +
>> +But when the merge conflict was caused by a `git rebase`, it's the
>> +opposite: "theirs" is the commit that was checked out before you started
>> +the merge. This is because under the hood, `git rebase main` checks out
>> +the `main` commit first before doing the merge operation.
>
> Hmm. This part is a bit confusing to me. "ours" is always the commit
> that's currently checked out, and "theirs" is always the one that is
> getting merged into the checked-out commit.
>
> How about a variant of the following instead?
>
>   In a conflict, the side between `<<<<<<<` and `=======` is "ours"
>   and the side between `=======` and `>>>>>>>` is "theirs". "Ours" is
>   always the side that `HEAD` points to while the merge happens; "theirs"
>   is the commit being merged into it.
>
>   For `git merge <other>`, `HEAD` is your current branch, so "ours" is
>   your branch and "theirs" is `<other>`.
>
>   For `git rebase <upstream>`, `HEAD` is first moved to `<upstream>` and
>   your commits are then replayed on top one at a time. So "ours" is the
>   already-rebased history starting at `<upstream>`, and "theirs" is the
>   commit from your original branch that is currently being replayed.

Thanks, your suggestion gives me some other ways to think about this.

I think I'll try to write something shorter that is unambiguous, instead of trying
to use more words to make it feel more intuitive. I don't think I actually know
anyone who feels it's easy to understand the way merge conflicts are
presented, and more explanation may not help.

It might be more useful here to encourage (again) folks to use one of the many
amazing tools available (in the "tools" section) to get more context.

>> +These terms in Git all mean the same thing when dealing with a merge
>> +conflict:
>> +
>> +* "common ancestor", "base", and "stage 1"
>> +* "ours", "us", "stage 2", and `HEAD`
>> +* "theirs", "them", and "stage 3"
>
> I wouldn't say that "stage N" is equivalent to the respective other
> terms. These stages rather refer to the different versions of a specific
> file as recorded in the index, they do not indicate a specific commit.
> In contrast to that, all the other terms may also indicate a specific
> version of a file, but may also refer to the commits.

Thanks, will try to figure out how to make it more accurate.
We could also refer to gitdatamodel if folks want to learn what the
term "stage" means too.

Thanks for the review!
- Julia
