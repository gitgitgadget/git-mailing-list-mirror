Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02779358D38
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 12:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962013; cv=pass; b=FwYKilPMFuU+5F+nkUYSifiWPopRF5R6uL1Eas/kHCnu1jzMWuQm5Cck7zc074o/LJTWRCxUiCB1WuqtD6n2rQ1kZqtlzVD5PbpRAEbxKq1FjdwQ4P58/WtEa0ZDQVW0HGcnWDB0NUfzTdbe+zh0Yt/MFdM8SEvbnt4uSE1OFCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962013; c=relaxed/simple;
	bh=e0oCztfqU9zL/wiqR5xL0TmcEM2lFmFhg47KZRqGSnc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hHGBdt5aRfZ4IciG+MxKRAcncK8f/5wn+9XdWePzogF49cxS1HfXoMwA4nsOes4BRc3VWG9Phwr+kz2naghsCUatMNjqGSY2uOLVZ122Dt+baumrDWVVmp/Cg49Y9/tjE176ghUzsahL5y/I9OSeqlLPJdh5Lj7FZZm0ka5btxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=CD81NE+M; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="CD81NE+M"
ARC-Seal: i=1; a=rsa-sha256; t=1767962005; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CWbyzUNf+IY+puwJ7sFSuDF76L25m20TtTtpK9NWbuGm3vj1O02YYKTYB7rcYxJFL7ggYnZOs19vCPzyklgvpq1Z2VsQ8yGztRjhypr8vP1kmKhX3QXJ6sgBi1k3PSlUY8WHO0YVjf328La57pRoaJrl+iNuUcKit8+IGuoCcRs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767962005; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nWJZ8HYhaKmT6XeKOr4jwtQV2txu6JqRdWfoLtlabFg=; 
	b=XZSh6DydIwQQ1QGlkz0MmHY/sWjlaMtkxYmZBc1YVdjzUTdeiDXuJ57Zk28KV/3lD9Xe/S1Kqk93B9rzJMzf7MQDJozMOzm8gSul9mBnkHPzQxUlsV4bkpY+5wCiOm4C6bUcdv0AJA3QuVZzGxrrOUVnk7FxgoYGZrF+9fPutLg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767962005;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=nWJZ8HYhaKmT6XeKOr4jwtQV2txu6JqRdWfoLtlabFg=;
	b=CD81NE+M6vbu1qMdHIsByHGsbRcr/ZX2dap4SmyWGav5VzYabfKsNfA91nJSgGP7
	/qU3D2t1BKauQ1AA6k56A0dyFWb+aufAc5QAMhEFj1vPZsL/4eid0DwhkC6hsnNwYSo
	NsxhpRwwlZuTgEynl9Gyx8oi2ZLNhVY4fcx8+IeU=
Received: by mx.zohomail.com with SMTPS id 1767962003105612.6450912173707;
	Fri, 9 Jan 2026 04:33:23 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>, correctmost <cmlists@sent.com>
Cc: git@vger.kernel.org
Subject: Re: [Bug] hook: -Wanalyzer-deref-before-check warning in run_hooks_opt
In-Reply-To: <aWDm_n2YgjvaRmpV@pks.im>
References: <72d123b8-b75e-4b1d-8506-95eb9ad350da@app.fastmail.com>
 <aWDm_n2YgjvaRmpV@pks.im>
Date: Fri, 09 Jan 2026 14:33:18 +0200
Message-ID: <87jyxrvucx.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

On Fri, 09 Jan 2026, Patrick Steinhardt <ps@pks.im> wrote:
> On Thu, Jan 08, 2026 at 08:24:01PM -0500, correctmost wrote:
>> Hi,
>>=20
>> GCC 15.2.1 warns about a potential NULL pointer dereference in
>> run_hooks_opt on the master branch:
>>=20
>> ---
>>=20
>> ../hook.c: In function =E2=80=98run_hooks_opt=E2=80=99:
>> ../hook.c:167:12: error: check of =E2=80=98options=E2=80=99 for NULL aft=
er already dereferencing it [-Werror=3Danalyzer-deref-before-check]
>>   167 |         if (!options)
>>       |            ^
>>=20
>> [...snip...]
>>=20
>>     =E2=94=82  156 |                 .ungroup =3D options->ungroup,
>>     =E2=94=82      |                            ~~~~~~~~~~~~~~~~
>>     =E2=94=82      |                                   |
>>     =E2=94=82      |                                   (7) pointer =E2=
=80=98options=E2=80=99 is dereferenced here
>>     =E2=94=82......
>>     =E2=94=82  167 |         if (!options)
>>     =E2=94=82      |            ~=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>>     =E2=94=82      |            |
>>     =E2=94=82      |            (8)   pointer =E2=80=98options=E2=80=99 =
is checked for NULL here but it was already dereferenced at (7)
>>     =E2=94=82
>>=20
>> ---
>>=20
>> This does seem like a real bug, though I'm not sure how likely it is
>> to occur.  It looks like the warning was introduced in merge commit
>> f406b89552 ("Use hook API to replace ad-hoc invocation of hook scripts
>> with the run_command() API.").
>>=20
>> I noticed the warning while compiling commit d529f3a19736 on Arch
>> Linux.
>
> It's not a real bug. If you take a look at the the `if (!options)`
> check, you'll see:
>
> 	if (!options)
> 		BUG("a struct run_hooks_opt must be provided to run_hooks");
>
> So we'd abort immediatly with an error message in case the pointer was
> `NULL`. Which clarifies that this is a case that shouldn't ever happen
> in the first place.
>
> That being said, it's of course a bit careless to dereference the
> pointer before we have the opportunity to call `BUG()`. I see two ways
> to fix this:
>
>   - We can either move all derefs of `options` after the call to
>     `BUG()`.
>
>   - Or we can drop the call to `BUG()` altogether.
>
> Out of those two I think I slightly lean towards the latter, mostly
> because the resulting code structure is simpler. And we'd reliably
> segfault anyway if we dereference the pointer, even though we would not
> get a clean error message. Not sure whether that really is worth the
> hassle though.

Your diagnosis is correct: options is never NULL in practice.

I'd like to keep that BUG() and move it before dereferencing, just in
case some future code change accidentally calls run_hooks_opt() with a
NULL options, so we get a clean error and not trigger the compiler check.=20

Will see if I can make the code structure nice and send a patch.
