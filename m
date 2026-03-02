Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EE7322B6F
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 14:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772460769; cv=pass; b=TYlo0rWNn70DdG2O1fIy9vETHWhXyn5+RQe/iJddZZ3jNwUECT6BWqWokjVg57Nxi0YgwqFp9wEbTuDrYcdXx8KvO/XFSgvj2d4IsyCkdSalpy/4TBaOGIRcwvPw1jS6+m+ZO8ikPKlmkRnu3u2yKIjZgSpa/4pcNSd65+OuAxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772460769; c=relaxed/simple;
	bh=gUIlvwxUU8Bmh/UBLLyXASSIEwQ8D4DDs7vZFUQCCIY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GnDYugWGbUJcquZJ7RoTjVWVUCClFcUKWbQZqWoWb/0Kx+UGWGDbdjsHlANcvSWj4dPhL0b6zx/o56JY842UYTNXr7c2+0YbcWKdPmyOZ/b6/q8PYGvbMbh//wzxPpXTfQgwq+vROQZk96BLFj6HTj+51njnz0SV0xkO0FomWeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=eei+G71S; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="eei+G71S"
ARC-Seal: i=1; a=rsa-sha256; t=1772460763; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FaEchhi8fP8qd3cMQKjnG6fC/sYGUAK/BrdG1Xqmd6S5zK5uxNgfKtX3+cAW5ZlPXvqifCeNSq//Uk9Y7hECkjLAO1uoHO9nvzKSr11U4uBgGlKk2RFeeI2pT1jFDE5o7p2K+yAx13rY9miG385y61MjWHMRoLkPKX5Gjb8gz4A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772460763; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Zq6MoEx7BMcnEiUZODUn5fCoa2g1hFDkDscQPmD8LCQ=; 
	b=ln89ytkYfnDNUUzPEDjVTIVBrhgsc+Arwobghxwvs2VqPbx1rGI5l4LIYJHpiZeXPOfZwgtolZL+JbX+wu9jKxFnajuhrR7Xxc0XksNl2CPiKTNEK5v80NKxDhHLaOVKBY9YS1wp72abo6P4GpayBWaqa+/QQ2M2L73PNRUqzVY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772460763;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Zq6MoEx7BMcnEiUZODUn5fCoa2g1hFDkDscQPmD8LCQ=;
	b=eei+G71S7YCy2bbjyx0wbzvZUWY7Vw36nkdLFry2a8q1VbO5buJi7Hm88Q5qPaZu
	Tr3YvpuDuLJEtRaYvAhQ3M614eYAWBZZTNzKApoblR3SwMkZr5w+LbvaFjVBdrLwZl6
	mKXmS5kw8pzardy7eEWSxIBnk/yiE3lET6qsvCCc=
Received: by mx.zohomail.com with SMTPS id 1772460762369219.217597307029;
	Mon, 2 Mar 2026 06:12:42 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: Performance regression in "update" hooks
In-Reply-To: <87bjh673o0.fsf@gentoo.mail-host-address-is-not-set>
References: <aaU5lZwEuR4OrxCl@pks.im>
 <87bjh673o0.fsf@gentoo.mail-host-address-is-not-set>
Date: Mon, 02 Mar 2026 16:12:39 +0200
Message-ID: <874imy7220.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

On Mon, 02 Mar 2026, Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
> On Mon, 02 Mar 2026, Patrick Steinhardt <ps@pks.im> wrote:
>> Hi,
>>
>> Bencher has alerted me that there's been two performance regressions in
>> git-receive-pack(1) [1] and git-fetch(1) [2].
>>
>> The first one is quite easy to reproduce with the benchmarks at [3] and
>> bisects to fc148b146a (receive-pack: convert update hooks to new API,
>> 2026-01-28):
>>
>>   $ cd receive-refs
>>   $ ./run --revisions /path/to/your/git/repo \
>>       fc148b146ad41be71a7852c4867f0773cbfe1ff9~,fc148b146ad41be71a7852c4=
867f0773cbfe1ff9 \
>>       --parameter-list refformat reftable \
>>       --parameter-list refcount 10000
>>
>>   Benchmark 1: receive: many refs (refformat =3D reftable, refcount =3D =
10000, revision =3D fc148b146ad41be71a7852c4867f0773cbfe1ff9~)
>>     Time (mean =C2=B1 =CF=83):     182.0 ms =C2=B1   2.7 ms    [User: 91=
.5 ms, System: 89.3 ms]
>>     Range (min =E2=80=A6 max):   175.8 ms =E2=80=A6 185.0 ms    15 runs
>>
>>   Benchmark 2: receive: many refs (refformat =3D reftable, refcount =3D =
10000, revision =3D fc148b146ad41be71a7852c4867f0773cbfe1ff9)
>>     Time (mean =C2=B1 =CF=83):     484.6 ms =C2=B1  27.6 ms    [User: 17=
6.2 ms, System: 376.1 ms]
>>     Range (min =E2=80=A6 max):   406.2 ms =E2=80=A6 495.1 ms    10 runs
>>
>>   Summary
>>     receive: many refs (refformat =3D reftable, refcount =3D 10000, revi=
sion =3D fc148b146ad41be71a7852c4867f0773cbfe1ff9~) ran
>>       2.66 =C2=B1 0.16 times faster than receive: many refs (refformat =
=3D reftable, refcount =3D 10000, revision =3D fc148b146ad41be71a7852c4867f=
0773cbfe1ff9)
>>
>> I've Cc'd Adrian.
>
> Hi Patrick,
>
> I looked at the commits before and after the many-refs test regression
> and it appears the regressions started after Junio landed v2 of the
> config series in next [1], which might cause it.
>
> v2 was not ready to land. I sent v3 yesterday addressing all the
> feedback, didn't even realize v2 landed. :)
>
> Does the regression go away if you revert [1] ?
>
> I don't have the benchmark setup and it might be easier for you to
> confirm?
>
> Many thanks!
>
> 1:
>
> commit 6a04cca28e210f0c51cfefcb52475c7ede6e99fb
> Merge: d6ebc97cb1 4b12cd3ae3
> Author:     Junio C Hamano <gitster@pobox.com>
> AuthorDate: Fri Feb 27 15:16:30 2026 -0800
> Commit:     Junio C Hamano <gitster@pobox.com>
> CommitDate: Fri Feb 27 15:16:30 2026 -0800
>
>     Merge branch 'ar/config-hooks' into next
>=20=20=20=20=20
>     Allow hook commands to be defined (possibly centrally) in the
>     configuration files, and run multiple of them for the same hook
>     event.
>=20=20=20=20=20
>     * ar/config-hooks:
>       hook: add -z option to "git hook list"
>       hook: allow out-of-repo 'git hook' invocations
>       hook: allow event =3D "" to overwrite previous values
>       hook: allow disabling config hooks
>       hook: include hooks from the config
>       hook: add "git hook list" command
>       hook: run a list of hooks to prepare for multihook support
>       hook: add internal state alloc/free callbacks

Actually I think these are two separate issues.

I will reproduce and look into the regression which bisected to
c148b146a (receive-pack: convert update hooks to new API,  2026-01-28).
