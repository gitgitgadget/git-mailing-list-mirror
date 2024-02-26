Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8183C1CAAF
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 09:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708940098; cv=none; b=J218drQX4My3DYoxK2Bs0Av0t6Mz4spgjukgBMp5imgwOyAnaSLvFEJ9fxNGQGuCi5eDSrpz7m1ynBek3xw3X5PSlkKGApFfPAWra/BNCCG9c8lIn0RUgnLCz1k1FRoZI8QWmChjkJstxR8yiAF5gZgTu0c21lqYQWL0GayMD4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708940098; c=relaxed/simple;
	bh=0+/QMiUQEjnKKc5br4yOllxQkl9DcjsPIKpt/c/YvHo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ILUZ9twGMaqx4my7dkSK9De1A/jxFEyQXQOi5IYrfah2ygtohc/2PkcUypcHSqcoTpthQ73pn82+KX/we5SEQ6+IG6LJgNuAeyMVWWXwzFJU4PVaHg7e7w6rSPrJreqNhOzxLsAsW3eCTKXyLta4vhzfq+p6uAS2UAukZdWwE+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=mKsu5fiy; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="mKsu5fiy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708940086; x=1709544886; i=johannes.schindelin@gmx.de;
	bh=0+/QMiUQEjnKKc5br4yOllxQkl9DcjsPIKpt/c/YvHo=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=mKsu5fiyVK3Q8TRU3yF56KS4QafGIeUrf7w8SOqfjiAUCpsDEmkjZMBzXJCMuFKt
	 UTmvmjN0aXYnNqgMeTs5BwBLeNHzwP/nnYPfEcx/5T3XQQWJQHPbUFnzkiXWidmU1
	 YQzqvJQT7YkIkVhwQCtt0D4Pm7hdcQ2Ka58RTrueWrp9YhTwFgm6a/jmFSQP85JPJ
	 BtG/s3O0qnJkhaAiZbwJuNx4FAhXakkQx1Rr+/4kvHcs6WnLFZfIHK7p/hBuYHx7x
	 o4UMeA4/LZCBXVLFu2BVfUIdc4h6TmNI5LnZsE7TkpPFvTsPIAyR8MQ9cJiYpPnG9
	 str9fqad+BnGQ/mikw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.214.170]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mzhj9-1qjfR12mjx-00vhtk; Mon, 26
 Feb 2024 10:34:46 +0100
Date: Mon, 26 Feb 2024 10:34:44 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 03/11] Start reporting missing commits in
 `repo_in_merge_bases_many()`
In-Reply-To: <xmqqle7asnu9.fsf@gitster.g>
Message-ID: <c27015da-0867-f417-4cd6-f4eaad3b66a9@gmx.de>
References: <pull.1657.git.1707813709.gitgitgadget@gmail.com> <pull.1657.v2.git.1708608110.gitgitgadget@gmail.com> <4dd214f91d4783f29b03908cc0034156253889a7.1708608110.git.gitgitgadget@gmail.com> <xmqqle7asnu9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:s3RZc22fPk6/FkKAFaLUfTOcRQfiQ30N3TEhS/Xxpk/VYklP81L
 1Gti0IOZAprqUP/Lordtxx3HW38sEeNvsrSVg2Jm3u+V88IpC4zWpxs32c82D2lwZenC2J3
 XLBXrVTZKH4PQIHS3hGPpgzNuZoUgs8KWVAmmUokw2aWpXiShTZIZYN1O/uoU0TvE4fXmdD
 5gCSwE3Qpe0kvAhgD2Oxg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:I/MgPS2qPOE=;LVMXdPzRViuiajQXaQYv9yGq7gf
 GW3eOdSB7zL8YAoEy1zsgpZ8ZvFrYi746B0MQdwAQ2+PW2xhR2D1cQzOuEtxANmV28DQBd9IF
 CWk/T1IOAsmL8soQoak4Mw4+hi8PQMe02p0nLTW2+y1RdVAjuZuXEzh0ifL8obVkuCUp9cAk3
 jLbmyvM+VQ7fQaC9ZvcSegXUaaeQjBBDBiTm6ZdY2KRaDSquqc9OzhfKTZmEXIFUFzBAgcHs8
 6A26a55T/Tj8Vo4vYLeAHD/YBzoK1EJF3ERUD0P3laEXFDP8XVUp1ExY0OkYO38Bn3KGZAKTk
 U3f/6hZFm2c9wadiSnDkJ6Obx1mC11p1HNmKiiTrgG22CDEVGOZ6ejlAbCppGrD2450pVk59t
 LKucwF9z819hVIeHxDAwT2lF+7QeNpePUY1/Tny+fgYOTuRO/W+1aHIjziviTm+l33bkA/RXU
 jDzkQc9NfaK+F6/dbwhAFS9zoI99VPrL1zURX9HntqAJwMIf9lGehON8PqBWjv46Jq4Dpct5U
 mcouW/Ry6oK1GppGijSG7Nt3YR9EnlB5i4cq5VudD/YiavklTqP3qk9gxpAOZn9S1+3DIoMvb
 iIFzKxQ/CoZPeCjijsW3HBCeayQFJxaD3HjFJyEBBvJP+0C1cKseGEJAo7yRO+Fmfbi5T1OUR
 YC6IlnAgZoVoivTHEUg8vysvbjc0IKITPuTHYvaChNzipeSaMRKJ8H7B/EXKmMiQr2F8/7vyL
 PDoH8shOuaTzocqGrb0HcuoQZNF44sYCD3MjVZFvxEbKlD5F6xHEaQZD/96khCnL2YTaGLJCp
 /mD9eygcarRY2p/qTEyD0tIZSyfU1l5CbST+tj5VqBXEY=
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Fri, 23 Feb 2024, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Some functions in Git's source code follow the convention that returni=
ng
> > a negative value indicates a fatal error, e.g. repository corruption.
> >
> > Let's use this convention in `repo_in_merge_bases()` to report when on=
e
> > of the specified commits is missing (i.e. when `repo_parse_commit()`
> > reports an error).
> >
> > Also adjust the callers of `repo_in_merge_bases()` to handle such
> > negative return values.
>
> All of the above makes sense, but I have to wonder if this hunk
> should rather want to be part of the previous step:
>
> > @@ -486,10 +488,10 @@ int repo_in_merge_bases_many(struct repository *=
r, struct commit *commit,
> >  	timestamp_t generation, max_generation =3D GENERATION_NUMBER_ZERO;
> >
> >  	if (repo_parse_commit(r, commit))
> > -		return ret;
> > +		return ignore_missing_commits ? 0 : -1;
> >  	for (i =3D 0; i < nr_reference; i++) {
> >  		if (repo_parse_commit(r, reference[i]))
> > -			return ret;
> > +			return ignore_missing_commits ? 0 : -1;
> >
> >  		generation =3D commit_graph_generation(reference[i]);
> >  		if (generation > max_generation)
>
> as this hunk is not about many callers of repo_in_merge_bases() that
> ignored the return values, which are all fixed by this patch, but
> about returning that error signal back to the caller.
>
> Yes, I know you wrote in [02/11] that it does not change the
> behaviour, and if you move this hunk to [02/11], it might change the
> behaviour, but that is changing for the better.

I wanted 2/11 to be trivial to review, and therefore specifically wanted
behavior not to change just yet: At least when I review patches, this
information helps me assess the correctness of the patch because I have a
different pair of glasses on, so to say.

> Besides, adding a parameter "ignore_missing" to the function only to be
> ignored until the next patch feels rather incomplete.

By that reasoning, the entire patch series should be squashed into a
single patch, as the missing commits will only be handled properly if all
11 patches are applied ;-)

Seriously again, I designed this patch series in a way where it builds up
incrementally, adding preparations here and there, in as easily reviewable
a shape as I could, until the final patch wraps everything in a bow.

I did this mostly to be able to convince myself of the correctness of the
patches because I sense such a vast opportunity for bugs to creep in.

> The other changes in this patch about its primary theme, fixing the
> callers that used to ignore return values of repo_in_merge_bases(),
> all looked sensible.  This hunk somehow stood out like a sore thumb
> to me.

I have an idea. How about pulling out this hunk into its own patch? And
insert it between 2/11 and 3/11? That would probably make most sense, as
it would make the patch series still (relatively) easy to review, and it
would not conflate the purpose of this hunk with the rest of 3/11's hunks.

What do you think?

Ciao,
Johannes
