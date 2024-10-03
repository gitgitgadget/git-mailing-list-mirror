Received: from aib29agh126.zrh1.oracleemaildelivery.com (aib29agh126.zrh1.oracleemaildelivery.com [192.29.178.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A981D17BA3
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 19:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727984971; cv=none; b=cwA7o3AwCgnA1wD3mTuJvhaKwdVDKL+uAva/qSfEQXLeDIJxjKMMw2QBM2Xz4q+e45FINhjzTErLrl3vDVzjoB1stvI1e85F7g8YSrkZFG+yeD4fK9FW1ObHyQdUcCK/IRBS050Xt1pzrUOJ37uQT213c11RpS7zehT1aXzx8dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727984971; c=relaxed/simple;
	bh=uzcCkMSQ0CxCvLUtDOQOTvShHzql78aRGJGU6AMOuz0=;
	h=Date:From:To:Cc:Message-id:In-reply-to:References:Subject:
	 MIME-version:Content-type; b=kJby8MERqgfrc1q19aPzvxToWZy7XdymUWvoEleGtWbBYJVp6jKShvJR6mLyz07v4ZcgppmgOFT7hVQvia5uW2Lf0wsY1SsUkurGhVK0s7Jgk1/iHVSGdJ8BLILdWzwR5+/zNnDjcNQ74ZLe3pfQG08pJJ7VzWE2lBDW+ShJ9HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=cQwXUOUz; arc=none smtp.client-ip=192.29.178.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="cQwXUOUz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=uzcCkMSQ0CxCvLUtDOQOTvShHzql78aRGJGU6AMOuz0=;
 b=cQwXUOUzCAXCfoELlMZthXGiIe3kMhkLxaTNt/gh9tnZCCjS/n7L3WgrDeju9ipad9BleZtMAyBb
   y1qCDEaZTilG5EAPRVOU2YDU8Uyq2WWwK5eyAbIH7K2MG8+PycMDa6iXqBXzBcumx1ATV5lhwPP1
   k8u2P8pix+ON2ztZ1RxaYqua2RCxY+AnwU3XDDc0MW4Vjz6naS6GdHNxXDEDyvBqdkdW0MDdPV4+
   TfH3tgyvrustzuErXhUzepkHQqU+G/aGiGtz05lbl9p5dxB6fHy9jXatVdCis5rawiEGc8mXvIxS
   0VZBIPZFcRFlKf6Ldmf4AWxJt5NRd00Az3Ydvw==
Received: by omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SKS009EOPQ82630@omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Thu, 03 Oct 2024 19:49:20 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Date: Thu, 3 Oct 2024 21:48:31 +0200 (GMT+02:00)
From: Bence Ferdinandy <bence@ferdinandy.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk,
	Taylor Blau <me@ttaylorr.com>,	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Message-id: <51b356df-d0a6-44e1-98b2-c579dd9465d8@ferdinandy.com>
In-reply-to: <xmqq1q0xhu13.fsf@gitster.g>
References: <D4JIG4VS5WVN.2F0PNU5514UEL@ferdinandy.com>
 <20240930222025.2349008-1-bence@ferdinandy.com> <xmqq1q0xhu13.fsf@gitster.g>
Subject: Re: [PATCH v4 0/5] improve handling of remote/HEAD
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: quoted-printable
X-Correlation-ID: <51b356df-d0a6-44e1-98b2-c579dd9465d8@ferdinandy.com>
Reporting-Meta:
 AAGpLabi5EKp+KurSSDKx7MWMzkcCfTeaMwJrkx+vbiR9KXvm/Q9Ne/KsSzZ5YTN
 ScevZjsDKf6dYgb+Jw6LPlLkPWMOSiUy0dPt90NQYvgUAZ4pBpOhTr/fXNmNar63
 SGTuC/T8eXN0aSE7rS5LncB3IQsX6Om+osx953oFM1m8kFTZn9aYxkh//nISxdCI
 g9csKDt+W4VRkQDAOsiKg53ikZD1wwOfIX2DCQo2W+uTH0ppGLGLufv9Hc6JDDYc
 htDKCy/MovudxlxfDuoWvzH0fMnd+wOvLh0yyZVsIKiCUamdE48v1dWK2BvQPs57
 5MTc8WcebvqLr0bkAfn7T5Q/UTw4Y8yYu/PdLBqspYDEbJZX40SOBf/65zlOpC1l
 nTEB7B5IUK4frpKZ6ZCzVgidWmMZy6XPb1QAF/8zNtU4nYVtaU3e5uP+IFxA9uBD
 RnA/5e2DVdiQQu/5kcf0Di6kEl/oUOLg+PrgBeIvwtoequzOKYHgEmns

2024. okt. 3. 21:22:13 Junio C Hamano <gitster@pobox.com>:

> Bence Ferdinandy <bence@ferdinandy.com> writes:
>
>> Bence Ferdinandy (5):
>> =C2=A0 refs_update_symref: atomically record overwritten ref
>> =C2=A0 set-head: better output for --auto
>> =C2=A0 transaction: add TRANSACTION_CREATE_EXISTS error
>> =C2=A0 refs_update_symref: add create_only option
>> =C2=A0 fetch: set remote/HEAD if it does not exist
>>
>> builtin/branch.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 2 +-
>> builtin/checkout.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +=
+-
>> builtin/clone.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 8 ++--
>> builtin/fetch.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 83 +++++++++++++++++++++++++++++++++++++++
>> builtin/notes.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 3 +-
>> builtin/remote.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
 43 ++++++++++++++++----
>> builtin/symbolic-ref.c=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>> builtin/worktree.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +=
-
>> refs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 35 ++++++++++++-----
>> refs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 +++-
>> refs/files-backend.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 29 ++++++++++----
>> refs/refs-internal.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ++++
>> refs/reftable-backend.c=C2=A0=C2=A0 |=C2=A0 6 ++-
>> reset.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>> sequencer.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +-
>> setup.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +-
>> t/helper/test-ref-store.c |=C2=A0 2 +-
>> t/t5505-remote.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 13 +=
++++-
>> t/t5514-fetch-multiple.sh |=C2=A0 9 +++++
>> 19 files changed, 222 insertions(+), 43 deletions(-)
>
> These seem to break some of the tests, either standalone or when
> merged to 'seen'.
>
> I have the topic queued directly on top of e9356ba3 (another batch
> after 2.47-rc0, 2024-09-30); here is how the summary report looks
> like.
>
> Thanks.

Sorry, I should have probably left in the RFC prefix to be more clear
about this... As I noted in the cover letter, the first four patches pass=
=20
the
tests, the last one doesn't (yet), as I'm still not quite sure if even=20
the
approach is fine. If those look good I'll send a v5 and also fix the=20
tests
as well. Although based on your review of the first 2 patches there's=20
already
some changes needed there, so I can just do a v5 with that and tests=20
fixed
and see if that version looks good or not.

I'm currently on a holiday, so my ETA on this is early next week.

Thanks,
Bence


>
> Test Summary Report
> -------------------
> t0410-partial-clone.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (Wstat: 256 (exited 1)=20
> Tests: 38 Failed: 1)
> =C2=A0 Failed test:=C2=A0 32
> =C2=A0 Non-zero exit status: 1
> t4207-log-decoration-colors.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (Wstat: =
256 (exited 1)=20
> Tests: 4 Failed: 1)
> =C2=A0 Failed test:=C2=A0 2
> =C2=A0 Non-zero exit status: 1
> t5300-pack-object.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (Wstat: 256 (exited 1)=20
> Tests: 56 Failed: 1)
> =C2=A0 Failed test:=C2=A0 51
> =C2=A0 Non-zero exit status: 1
> t5512-ls-remote.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (Wstat: 256 (exited 1)=
=20
> Tests: 40 Failed: 1)
> =C2=A0 Failed test:=C2=A0 32
> =C2=A0 Non-zero exit status: 1
> t5527-fetch-odd-refs.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 (Wstat: 256 (exited 1)=20
> Tests: 5 Failed: 1)
> =C2=A0 Failed test:=C2=A0 4
> =C2=A0 Non-zero exit status: 1
> t5514-fetch-multiple.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 (Wstat: 256 (exited 1)=20
> Tests: 25 Failed: 4)
> =C2=A0 Failed tests:=C2=A0 9-10, 18, 24
> =C2=A0 Non-zero exit status: 1
> t5521-pull-options.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (Wstat: 256 (exited 1)=20
> Tests: 22 Failed: 8)
> =C2=A0 Failed tests:=C2=A0 2-9
> =C2=A0 Non-zero exit status: 1
> t5505-remote.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (Wstat: =
256 (exited 1)=20
> Tests: 114 Failed: 7)
> =C2=A0 Failed tests:=C2=A0 4, 31, 51-52, 54-56
> =C2=A0 Non-zero exit status: 1
> t5574-fetch-output.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (Wstat: 256 (exited 1)=20
> Tests: 14 Failed: 3)
> =C2=A0 Failed tests:=C2=A0 11-13
> =C2=A0 Non-zero exit status: 1
> t5703-upload-pack-ref-in-want.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (Wstat: 256 (exit=
ed 1)=20
> Tests: 26 Failed: 1)
> =C2=A0 Failed test:=C2=A0 12
> =C2=A0 Non-zero exit status: 1
> t5616-partial-clone.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (Wstat: 256 (exited 1)=20
> Tests: 46 Failed: 2)
> =C2=A0 Failed tests:=C2=A0 10, 22
> =C2=A0 Non-zero exit status: 1
> t5516-fetch-push.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (Wstat: 256 (exited 1)=20
> Tests: 120 Failed: 1)
> =C2=A0 Failed test:=C2=A0 102
> =C2=A0 Non-zero exit status: 1
> t7814-grep-recurse-submodules.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (Wstat: 256 (exit=
ed 1)=20
> Tests: 34 Failed: 1)
> =C2=A0 Failed test:=C2=A0 33
> =C2=A0 Non-zero exit status: 1
> t7900-maintenance.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (Wstat: 256 (exited 1)=20
> Tests: 53 Failed: 1)
> =C2=A0 Failed test:=C2=A0 23
> =C2=A0 Non-zero exit status: 1
> t7406-submodule-update.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 (Wstat: 256 (exited 1)=20
> Tests: 68 Failed: 1)
> =C2=A0 Failed test:=C2=A0 59
> =C2=A0 Non-zero exit status: 1
> t9211-scalar-clone.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (Wstat: 256 (exited 1)=20
> Tests: 13 Failed: 2)
> =C2=A0 Failed tests:=C2=A0 8-9
> =C2=A0 Non-zero exit status: 1
> t9210-scalar.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (Wstat: =
256 (exited 1)=20
> Tests: 21 Failed: 1)
> =C2=A0 Failed test:=C2=A0 11
> =C2=A0 Non-zero exit status: 1
> t9902-completion.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (Wstat: 256 (exited 1)=20
> Tests: 256 Failed: 56)
> =C2=A0 Failed tests:=C2=A0 54-55, 59, 61, 63, 71-75, 77, 86, 88-89
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 92-93, 95, 101, 113, 116-117, 119-129, 138-141
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 143-157, 162-163, 168, 170-171
> =C2=A0 Non-zero exit status: 1
> Files=3D1029, Tests=3D31709, 371 wallclock secs (11.74 usr=C2=A0 4.74 sys=
 +=20
> 853.87 cusr 6465.88 csys =3D 7336.23 CPU)
> Result: FAIL
