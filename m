Received: from aib29agh127.zrh1.oracleemaildelivery.com (aib29agh127.zrh1.oracleemaildelivery.com [192.29.178.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96821A0700
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 20:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732653916; cv=none; b=INtHNjNg8gwmh5u/Ei5IKmlIYC02G8RKK9G+lGEuFK2D2qKK5ynW/O5zSdVIrUMPAHHwcLLhi98pe1IJLHrjnShKxu6V9ijs8oD+ktHtAsqIiGIHn5CpuwhKB7AKTiyPWRUjT2I7gklB01cpnlacBkVepE7KrLlGL2e/2zSeq9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732653916; c=relaxed/simple;
	bh=N0lbLwM1elbkNfme2+7JdUIvar4sot4gXpPobKS5lSE=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=Kl2YJYM85irQ0uJvxDv+Jft6hlPg5AY3fJZpUHuXwYV8hKzQqRrmEo4SzPYcn+iKwsqgHf9ejzq52Q912/fYaigfoMs/ZRMz55tFgF2l+K5EBaVhGbFhK0l+cJkkOeu+in89fT8AT8kO6ExV0WMSeldrKUHGwDXc4+Jgfo0QVLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=QRICSvy2; arc=none smtp.client-ip=192.29.178.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="QRICSvy2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=W0TK8D/wIkQAbp7g7pdPUAOUL6G2ZZKqMIRdYfyU0Yg=;
 b=QRICSvy2p7ZDZuo+q9L99GD4wD6aA8DsIS+3Ghn1ArRfLc0J8v2QWH+oqsjwTHTfXiO1oHTboE+r
   TrOxPnXpfqEK1eM0Qd+ZzH4SkPIFDJ8RFSc+wN+k4w/roQN6UL09QURnftxHmu/WDKdweI50wEFm
   fYbBjS9yYNJ+Dh0ClTZmggzQ3fYZiIKE4lPiETu1NYnf7Af3q8VFEX0hIL7YdeAyOkcrkYoGmFSB
   1R/gcQUsgtyDznm83KFuKgLKkwo7RUZs8Iv03oSW/UawWOD4WGlevs4a8yKhFTfKjmo18GipEkNG
   vVTLIr1Nv+kWpDSsUaJnsZXAR8vbLgxs2zQbBQ==
Received: by omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SNK000Q5SB5JA30@omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Tue, 26 Nov 2024 20:45:05 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Tue, 26 Nov 2024 21:44:47 +0100
Message-id: <D5WEJJBMSO1K.2TPXDI1K08SHT@ferdinandy.com>
Subject: Re: [PATCH v14 03/10] refs: standardize output of
 refs_read_symbolic_ref
Cc: <git@vger.kernel.org>, <phillip.wood@dunelm.org.uk>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 "Taylor Blau" <me@ttaylorr.com>, "Patrick Steinhardt" <ps@pks.im>
To: "karthik nayak" <karthik.188@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <20241118151755.756265-1-bence@ferdinandy.com>
 <20241121225757.3877852-1-bence@ferdinandy.com>
 <20241121225757.3877852-4-bence@ferdinandy.com>
 <CAOLa=ZS5yNpZEUqBAUpP-pSbJXk4+=XM6S6e9RY_eSVJEBhqkA@mail.gmail.com>
 <D5SNGOK1IKRS.1TY1DL9PJ7MPF@ferdinandy.com>
 <CAOLa=ZS28xvpEBNO9AMamF00Yf8eHFGKyU5uHjBD7vOVF3_oEA@mail.gmail.com>
 <D5SPDJZAM5K1.24R4JYB0WNTSF@ferdinandy.com> <xmqqwmgs6mxk.fsf@gitster.g>
 <D5W75LQ6Z44H.3LKJ0OX40QKVQ@ferdinandy.com>
 <CAOLa=ZQ-ZeM4Lk0=ojx3f9RebRkVCX7w4KUKHphZoxUa5Cgfsg@mail.gmail.com>
In-reply-to:
 <CAOLa=ZQ-ZeM4Lk0=ojx3f9RebRkVCX7w4KUKHphZoxUa5Cgfsg@mail.gmail.com>
Reporting-Meta:
 AAHhh4dA2aNZ8bE97xIG1tOe5sfDLE9VnaMMGLH64quINnxTCVZ/SwNu4pJUDm9d
 fVRQyo1ihCJ0UUisz9a/PItxtdB6rJYLAr0yvi7uUQ2sxeenuP82Tzm9w5dDwPpd
 rceIi6Yv7mVOFSm2ikDVfKrI/aPdeJ+1vHtb8Ls4oXHHjd8Smbovx7h0eICpoEVy
 cs9E5tymhWcF6oLC6WfuNfmEtGRuU13XKyBSy6dtAugDsDIvVxaA3Gn5L97yh2xL
 d5BF/FBSKx1G/3710rOViC+bQXW3gQhcMqqrWNgXGtkI2dPfX35bz8ugLMpFJUXE
 bhy3CwYe7KgDtDh0rg2T5jQCwzw8iBl7sATVT7d+NGvOqxAu8W2qE7FKgxbNcfnB
 StQptw+39m5ToMLSLHiuOG9+cTHoxlEaADG7ZxqQymhsAXcwaOh9WnmBbH7kys+q
 eAIspFb3pVmwsGEI25EsLrSBhzVRPZgijeop0d4S2kdsdJfEUTNnOgQ=


On Tue Nov 26, 2024 at 17:53, karthik nayak <karthik.188@gmail.com> wrote:
> "Bence Ferdinandy" <bence@ferdinandy.com> writes:
>
>> sorry about the other thread, I saw "extend whitespace checks" and I tho=
ught
>> based on what Kartik wrote that `log --check` should have caught it, whi=
ch is
>> why I thought it might be appropriate there.
>>
>
> With v14, running `git log --check --pretty=3Dformat:"---% h% s" master..=
`
> gives me:
>
>   --- f73b2c577b fetch set_head: handle mirrored bare repositories
>
>   --- c0c84fb7f9 fetch: set remote/HEAD if it does not exist
>
>   --- c366911074 refs: add create_only option to refs_update_symref_exten=
ded
>
>   --- c47704d4df refs: add TRANSACTION_CREATE_EXISTS error
>
>   --- 22e7a9bcae remote set-head: better output for --auto
>
>   --- 25d9944eb2 remote set-head: refactor for readability
>
>   --- 01fe46c842 refs: atomically record overwritten ref in update_symref
>
>   --- fed56bc6cc refs: standardize output of refs_read_symbolic_ref
>   refs/reftable-backend.c:833: indent with spaces.
>   +        if (ret)
>   refs/reftable-backend.c:834: indent with spaces.
>   +                ret =3D -1;
>   refs/reftable-backend.c:835: indent with spaces.
>   +        else if (ref.value_type =3D=3D REFTABLE_REF_SYMREF)
>   refs/reftable-backend.c:837: indent with spaces.
>   +        else
>   refs/reftable-backend.c:838: indent with spaces.
>   +                ret =3D NOT_A_SYMREF;
>
>   --- d5534d6c67 t/t5505-remote: test failure of set-head
>
>   --- a77b3b7774 t/t5505-remote: set default branch to main

So at least now I know why I'm confused :) I copied your exact command (wel=
l,
with upstream/master..), and I still have zero output. Since .gitattributes=
 is
committed to the repository, what else could be the difference?

[snip]

>>
>> So `git log --check --pretty=3Dformat:"---% h% s"` was _not_ supposed to=
 catch
>> this?
>>
>> I ran the CI with this patch again:
>> https://github.com/ferdinandyb/git/actions/runs/12031250376
>>
>> and it's all green, so wherever this _should_ have been caught: it didn'=
t work.
>
> I'm not an expert in GitHub actions, but if you look at
> `.github/workflows/check-whitespace.yml`, it says it is only triggered
> for `pull_request`. Did you raise a pull request? From your link, I
> don't see the whitespace job being triggered, so `it didn't work` would
> be inaccurate, since it didn't even trigger the job ;)

Well that make sense, the commit introducing it also talks about pull reque=
sts.
On the other hand: why does this run only on a pull request? The main.yml r=
uns
on both pull requests and pushes and since the project doesn't really use p=
ull
requests, it would make more sense to also run this on push? The
check-style.yml is similar.
