Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D821DDC1A
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 10:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749118647; cv=none; b=tUH5roS3GZo42TssWP0qEcCTR6+t8rH6W4JIceJZDszrY/ACDrBC+3JdQ8Q8ZHlO2Xy4OC4BGCd+/chmpKljRxEUeHGi6lMmU7HyI6XxZLMj1rmaZs0cSknJxHwyS+gtR6BAXtQT07Px66Mm7Olf+WXJzh4N+Z1A8r3uRhIn/RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749118647; c=relaxed/simple;
	bh=H6snI+WWvHPRPQAfsiWBA6hVDGCa6u9gumlDXzSOEQM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZHg1sWQDMxbiop1ubt+oFJp9eNKNsn78xi2KacjDr30zavk+Jgjv+QAk/chdPCOaTNLJ6a2v2hBWZTm8+nvd8BqEMf4Hipams9LaGY3fkaYKvJu2T0vX7DQeWOJJcTfZugcgJMaVcOUeBAQmW4cIgZQ9DX2odZjQkBQFI1nHgi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=bHVDzmRo; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="bHVDzmRo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1749118639; x=1749723439;
	i=johannes.schindelin@gmx.de;
	bh=tb88+LwPxIbABlKbXTVl8ZwdXVso+BSesGSvYULOf6M=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bHVDzmRoM3ircziKRqAz0vnwkzgz61eVJMJVo8RiMJIRwZxpHtdrgFt5dXXvM5wd
	 ySik6oD9MK19YK6wOars5jJ+/9rFQAJX8lVmZtiy7XLKPPeUexzoh4OOwQkbn4HdT
	 5nQ+ypePvlTz6lFynXoXj4bNmGaDlOABT+JtTcdbuXX8N3A2G/yBqEW0PmnMw7ulk
	 9paHdabLgM6KT4ykRQmVsQ8rsFE+9Fey31Jq2zDr7mr/BuwgkxBOkUGS6FaH2cMc0
	 RlekoRHiQAia7CubhWUW2hkwsSc6ZnlAC9dbpO97Cqy2bwQaAObsTZNBAGV8rMvob
	 ibJDkPdzhCwFa6ALHA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.53]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8GMq-1uryJT1y8O-012IbC; Thu, 05
 Jun 2025 12:17:19 +0200
Date: Thu, 5 Jun 2025 12:17:17 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org, 
    karthik.188@gmail.com
Subject: Re: [PATCH v2 2/2] builtin/receive-pack: add option to skip connectivity
 check
In-Reply-To: <aD7tKfXD7YxprSZh@pks.im>
Message-ID: <0c2cc369-f57d-e03c-88b4-2e3206953101@gmx.de>
References: <20250520014920.201736-1-jltobler@gmail.com> <20250520163218.263921-1-jltobler@gmail.com> <20250520163218.263921-3-jltobler@gmail.com> <74668a00-5b90-2450-52c5-d9f00dcb42b9@gmx.de> <gw6j5enpzcit2zquafoaiujreoa4kbv3n6feq6yeqylcfynqim@s53ctnlg7tmm>
 <aD7tKfXD7YxprSZh@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+AYtHJQ4/Go9Py57XKJtO7Ss91+zavjfZVFNDjFk4Ahqa12JXN4
 KBv1jeZHaYd6Vin34j2LnZz/2Ty+kJ2+qcY7M/1pVIJpiXK9mn60Ygj4w7e2YNaUQr3WjMv
 qtHjPc7ohIECQRBJGZ56UwSsdnemF+DBX3tArjk/1g1gVFmM4fM5m4nLlzRxF7vkoj41opL
 wV4UY83fOVd+TaXpPBYQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:60Q5BPfP6R8=;MajuxnH27IbYN5UDk16Rwjud6Ip
 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
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Tue, 3 Jun 2025, Patrick Steinhardt wrote:

> On Mon, Jun 02, 2025 at 10:59:53AM -0500, Justin Tobler wrote:
> > On 25/06/02 05:01PM, Johannes Schindelin wrote:
> > > Hi Justin,
> > >=20
> > > On Tue, 20 May 2025, Justin Tobler wrote:
> > >=20
> > > > diff --git a/t/t5410-receive-pack.sh b/t/t5410-receive-pack.sh
> > > > index 9afea54a26..f76a22943e 100755
> > > > --- a/t/t5410-receive-pack.sh
> > > > +++ b/t/t5410-receive-pack.sh
> > > > @@ -62,4 +62,26 @@ test_expect_success 'receive-pack missing objec=
ts fails connectivity check' '
> > > >  	test_must_fail git -C remote.git cat-file -e $(git -C repo rev-p=
arse HEAD)
> > > >  '
> > > > =20
> > > > +test_expect_success 'receive-pack missing objects bypasses connec=
tivity check' '
> > > > +	test_when_finished rm -rf repo remote.git setup.git &&
> > > > +
> > > > +	git init repo &&
> > > > +	git -C repo commit --allow-empty -m 1 &&
> > > > +	git clone --bare repo setup.git &&
> > > > +	git -C repo commit --allow-empty -m 2 &&
> > > > +
> > > > +	# Capture git-send-pack(1) output sent to git-receive-pack(1).
> > > > +	git -C repo send-pack ../setup.git --all \
> > > > +		--receive-pack=3D"tee ${SQ}$(pwd)/out${SQ} | git-receive-pack" =
&&
> > > > +
> > > > +	# Replay captured git-send-pack(1) output on new empty repositor=
y.
> > > > +	git init --bare remote.git &&
> > > > +	git receive-pack --skip-connectivity-check remote.git <out >actu=
al 2>err &&
> > > > +
> > > > +	test_grep ! "missing necessary objects" actual &&
> > > > +	test_must_be_empty err &&
> > > > +	git -C remote.git cat-file -e $(git -C repo rev-parse HEAD) &&
> > > > +	test_must_fail git -C remote.git rev-list $(git -C repo rev-pars=
e HEAD)
> > > > +'
> > > > +
> > > >  test_done
> > >=20
> > > This test case seems to hang occasionally in the "win+Meson test" jo=
bs on
> > > GitHub (I tried to find the same failure at
> > > https://gitlab.com/gitlab-org/git/-/pipelines but couldn't find any)=
. See
> > > for example
> > > https://github.com/gitgitgadget/git/actions/runs/15383915635/job/432=
79134837#step:6:627
> > >=20
> > > Note that this problem afflicts only the "win+Meson test" jobs; The
> > > corresponding "win test" job seems not to hang.
> > >=20
> > > Even in the Git for Windows project, where the `win+VS test` jobs ar=
e run,
> > > the t5410 test passes within a dozen seconds or so, see e.g.
> > > https://github.com/git-for-windows/git/actions/runs/15383945895/job/=
43279689086#step:5:143
> > > (confusingly, the subset of tests run in the matrix jobs differs bet=
ween
> > > the `win+Meson test` jobs and the `win+VS test` jobs, but if you cli=
ck
> > > through all of the `win+Meson test` jobs, expand the `test` step,
> > > patiently wait a few seconds for the log to be lazy loaded "enough" =
for
> > > the search to work, you will notice that t5410 is not mentioned in a=
ny of
> > > them, and the only one that times out after 4h37m11s is
> > > https://github.com/git-for-windows/git/actions/runs/15383945895/job/=
43279753911,
> > > likely while running 5410, too).
> > >=20
> > > Do you have any idea why this particular test case, in conjunction w=
ith
> > > Windows and Meson (and only on GitHub) acts up like this?
> >=20
> > Thanks Johannes for the report. I'm not quite sure yet what is going o=
n
> > here, but I'll dig into this a bit and see what I can figure out. :)
>=20
> I've been banging my head against this issue for a bit today. A couple
> of findings:
>=20
>   - The issue is specific to Git for Windows, I could only reproduce it
>     when working with aa550efd0bb (fixup??? survey: add command line
>     opts to select references, 2025-05-08).

I can reproduce it consistently with Git's `master`, see e.g.
https://github.com/git/git/actions/runs/15454602308/job/43504424816#step:6=
:627

>   - When working on top of the above commit the bug is consistent. It
>     doesn't only happen in GitHub, but also happens in GitLab CI [1].
>=20
>   - That being said, I still can't reproduce it locally?! This one is
>     quite puzzling to me. I have tried to get my environment as close as
>     possible to the environment we have in the CI systems.

I, too, was unable to reproduce locally (probably because of the way the
runners start the processes, without an initial Win32 Console and all). So
I took to mxschmitt/action-tmate to debug on the runner itself. It is a
bit tricky to do, as MSVC's debugger runs in a graphical IDE and gdb is
unable to find the symbols.

>   - I have a fix, see the patch further down. But I don't understand
>     that fix just yet.

I would like to propose an alternative:
https://lore.kernel.org/git/pull.1932.git.1749118606047.gitgitgadget@gmail=
.com

The reason why I prefer that solution is that I suspect the extra script
to make the conditions only less likely, but not impossible, for the bug
to rear its ugly head.

Ciao,
Johannes

>=20
> I saw that all other sites where inject a custom receive-pack command
> also use a wrapper script, so it's not the worst thing to do. But it
> would be great to understand why this issue exists in the first place.
>=20
> Patrick
>=20
> [1]: https://github.com/pks-t/git/actions/runs/15416185892/job/433793998=
61
>=20
> diff --git a/t/t5410-receive-pack.sh b/t/t5410-receive-pack.sh
> index f76a22943ef..112da408d45 100755
> --- a/t/t5410-receive-pack.sh
> +++ b/t/t5410-receive-pack.sh
> @@ -49,9 +49,13 @@ test_expect_success 'receive-pack missing objects fai=
ls connectivity check' '
>  	git clone --bare repo setup.git &&
>  	git -C repo commit --allow-empty -m 2 &&
> =20
> +	write_script receive-pack-wrapper <<-EOF &&
> +	tee "$(pwd)/out" | git-receive-pack "\$@"
> +	EOF
> +
>  	# Capture git-send-pack(1) output sent to git-receive-pack(1).
>  	git -C repo send-pack ../setup.git --all \
> -		--receive-pack=3D"tee ${SQ}$(pwd)/out${SQ} | git-receive-pack" &&
> +		--receive-pack=3D"${SQ}$(pwd)${SQ}/receive-pack-wrapper" &&
> =20
>  	# Replay captured git-send-pack(1) output on new empty repository.
>  	git init --bare remote.git &&
> @@ -70,9 +74,13 @@ test_expect_success 'receive-pack missing objects byp=
asses connectivity check' '
>  	git clone --bare repo setup.git &&
>  	git -C repo commit --allow-empty -m 2 &&
> =20
> +	write_script receive-pack-wrapper <<-EOF &&
> +	tee "$(pwd)/out" | git-receive-pack "\$@"
> +	EOF
> +
>  	# Capture git-send-pack(1) output sent to git-receive-pack(1).
>  	git -C repo send-pack ../setup.git --all \
> -		--receive-pack=3D"tee ${SQ}$(pwd)/out${SQ} | git-receive-pack" &&
> +		--receive-pack=3D"${SQ}$(pwd)${SQ}/receive-pack-wrapper" &&
> =20
>  	# Replay captured git-send-pack(1) output on new empty repository.
>  	git init --bare remote.git &&
>=20
