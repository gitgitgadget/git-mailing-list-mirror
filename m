Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FC242A96
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 20:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787170947; cv=none; b=H80MOXELxtDSxXesb27ry3pbQqatRZ5Q/2v5vNCEGLBK8tXH22bfA8RjGApLB86FrqwZ1AfKWUn2RAB1BhZ2Xc9vnxhegjvKMusOqOWMQAs0xSOSbmrW0SHRrGMowial66phadABpdgmPGTlIkvKD+vL4p4Z8NTST7XWk/KC/hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787170947; c=relaxed/simple;
	bh=/B5WZ2IPoxXCjy0xKaVc8urVYLLSfivY1LZ8rwgtqos=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n8Pm/CsKKj4cR9zVkB+IshYoTSoHziz9j079Yz+/Ujo8d9Uap/+AE69DK0HvelZfUnr0qso6Lo0uBOj55BgKgtdbaIHxyh72J4fUtExMTiRzDNzjXqTVXKSi5z9a9IucwvHIXgZfO2aKLq4LMYafAI4Alvlktn+zc//Ku1sAzbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y5AVhb0F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YeIGX+Km; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y5AVhb0F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YeIGX+Km"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 9CF061D00176;
	Wed, 19 Aug 2026 16:22:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 19 Aug 2026 16:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787170945; x=1787257345; bh=5dxWyiQB/F
	OejNgkFtr1MDzjL6uw67kPC59ai6HhCtk=; b=Y5AVhb0FFbYFTEbsUFvqGedsh2
	RLF4DZC1MgamdsiZtQy8Wl67q2hfjVlM/3sB6x9Ox+HShzFibm+mH2wNa9kavu+e
	RpkwerAZplekUR05QpE9haC+Z9y+THvGHNGGNn/9poqg7NsGtJ6HiAsZi4S3ty82
	YeaObQNW9389i3PRQHzjaeks4vOTn7VWzj0yFH3THckSL6usuKA60q/QjTwv7um5
	6b0sEIxvNAkYhmq7AB44KN8ADkSyvLMYJgwpJrRyZW/Y3xXKNhOYgFBl9b5WebNj
	vC5WLQU2XmJWvMdsCqcQ5+8ISUNE0jj/j0KpUxeqTspKpLlWikl+NcGjtvWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787170945; x=1787257345; bh=5dxWyiQB/FOejNgkFtr1MDzjL6uw67kPC59
	ai6HhCtk=; b=YeIGX+Km3XpywfR+n2Znaml2Lo0hx8ybnLfOMyCeeQ3OZFBsaS0
	4igyC0MFjghql/7jNGKol2xMCUofMilfUJBWqrDtalpkUfplr3WOInnYT9g/wr5R
	ozjGX4HblS/ekWyGberX5MdOKVHG+Y3XFRx7pyl2suadD6EAaQTCaRjir6ynba/m
	KZlAcMrJp64dqoG1XeSRhJ1nADF4IbjVRLI5xslH1SCxYojk4Mxu9A3p9KCbk/TS
	dbRfV8c+09tOghNXCvN0uU33yBFRQ2cha6qwgNp1lL4NtQA/Qogsr9iQnTGxLz4l
	Dp2VWoia+xC97H3nQ+nmDm6pA4pJKqcXLSQ==
X-ME-Sender: <xms:gRCGam08BldvGmoFIFFJM_mJG1YZUwp6HOXkFUq-dtDt4jSejDE8OA>
    <xme:gRCGav-Omv0ywP0Phy8CfCu7_25ZMNHyC5gOAzUa49ezuigjdacV1Xi6UMh6Rd1q0
    ZfDHQCNwmP3dnEosZpz1Fl9u6KRJ8GxJ56UADssTCgQrraOKZMciQ>
X-ME-Received: <xmr:gRCGanOPbm-AG_REoGXcany_Z3rog7pOnshgGkDhGxEttf8DVEj-6zGx7gSfd5oVOMR-eDBHlH9xN1wmZ2fdrMY2dHChE9H5PQ>
X-ME-Proxy-Cause: dmFkZTEk1SruZln2HQvd3hiKYwsc0MDWES8+Rf3p1upWV0dKNNzLRI1Kc6X5j4lRvIwCJ2
    p9yyVnrK/eXiGaNmz0+dHDHvbvnoxKBBAAQI9AmpM6JvkSWtxiRMZm4CQt8otiFNapX3n5
    m1hRmLrYWEE1ihr0rfJ/qSLnItot23I0UvN6pPBZx118eHv7pTYRYtfh1SQzWUcvqeNNZm
    GfvFEIMD4TlMvOAMz+Rd+ryFD/T/SvzPRpmUSrqySx+13QzGFYcFX9CL0ow/4PPqwlKCGR
    dlfHdHmxICNkNVmwKDzMepNgI9TVl47gvqJ6+z9rfGUfjk5AvphYsfatWb/xWNFrufKGgS
    ihHQKkoylBIrdTadH4WF9U+UEVkzLNmJ2oyUTeqWzL5QU90Y1vpy+tpPbEc5JfYlcqpm5U
    J/GIlLIjfIVJAu0fBITS+RXC5BQE1J/sX4OUr3SyWHESxyqWx+Yl2xlLsWOLymNWZPeAOC
    ZT1KzRTubi7P2qBm0uXZZFrzHRsXI2ihi+OY+IYU9SvqaA0RiXwhIM54T+4faySIcd+BtR
    Cgc2RjiYTI59BmYjIdBKt8nSEXirmE14UXO/WpIuYvmvRWzfQO+h+8rzcQtjzen7hXPQMn
    nXS7Z4k39KchiGZegzshyFWZRZxxNVN5qMV71gxVxIXG4PW7hLHCM+tAFZmQ
X-ME-Proxy: <xmx:gRCGajeQmUTSKIjDlPKjAmGrTQg690fEC59zDcxWarQkxg5BNjRZjw>
    <xmx:gRCGamWOvQbjKrykXRnH5doerv_gJVNvKH_Gc2S-jasvTzS6G5Ij0g>
    <xmx:gRCGari4vAsa_0mjzq4HrjVaM0OjD-Slp4X-V1Ah01KWbzkU1rHoWQ>
    <xmx:gRCGal8-Kb1_cfb-n4L0mCvzElfVM5dUc-Jac-WEJ9uWzTZ3rsu3tw>
    <xmx:gRCGaiu9omhsyFL4L95iKiLEbiv5sECEpYRAWqEpzPPnJi8I1zOhLQDP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 16:22:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Nikolaus Schuetz via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Nikolaus Schuetz <nikolauspschuetz@gmail.com>
Subject: Re: [PATCH] t1402: test forbidden characters in refnames
In-Reply-To: <aoWRZhO6BVy7uPLI@pks.im> (Patrick Steinhardt's message of "Wed,
	19 Aug 2026 13:20:06 +0200")
References: <pull.2203.git.1786653837190.gitgitgadget@gmail.com>
	<aoWRZhO6BVy7uPLI@pks.im>
Date: Wed, 19 Aug 2026 13:22:23 -0700
Message-ID: <xmqqo6exuagw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Aug 13, 2026 at 08:43:56PM +0000, Nikolaus Schuetz via GitGitGadget wrote:
>> From: Nikolaus Schuetz <nikolauspschuetz@gmail.com>
>> 
>> git-check-ref-format(1) documents that a refname cannot contain a
>> space, tilde, caret, colon, question-mark, asterisk or open-bracket,
>> and that it cannot be the single character "@".  Of these, only "?"
>> was tested as a character embedded in an otherwise-valid refname;
>> "*" was checked only as a lone character or with --refspec-pattern.
>> 
>> Add the remaining forbidden characters in that embedded form, and
>> check that "@" alone is rejected even with --allow-onelevel -- where
>> "@" is otherwise a valid refname component, as "refs/@" confirms.
>
> Okay.
>
>> diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
>> index cabc516ae9..bc1e878a0f 100755
>> --- a/t/t1402-check-ref-format.sh
>> +++ b/t/t1402-check-ref-format.sh
>> @@ -51,12 +51,20 @@ invalid_ref '.refs/foo'
>>  invalid_ref 'refs/heads/foo.'
>>  invalid_ref 'heads/foo..bar'
>>  invalid_ref 'heads/foo?bar'
>> +invalid_ref 'heads/foo~bar'
>> +invalid_ref 'heads/foo^bar'
>> +invalid_ref 'heads/foo:bar'
>> +invalid_ref 'heads/foo*bar'
>> +invalid_ref 'heads/foo[bar'
>> +invalid_ref 'heads/foo bar'
>
> This feels a tiny bit excessive, but I guess it does not hurt to enforce
> this property, especially now that it's so easy to add new backends.

"Why would we even care to check these insane cases?" was my first
reaction, but I agree with you that these are to protect authors of
new backends from stupid mistakes.

> One thing I was briefly wondering is whether we could maybe have a
> simple loop here, as this feels quite repetitive. We could for example:
>
>     for c in '?' '~' '^' ':' '*' '[' ' '
>     do
>         invalid_ref "heads/foo${c}bar"
>     done

True.  And c does not have to be a single byte. ".." can also be
part of the repertoire.

> By the way, one weird bit: is it intentional that all of these really
> use "heads/something" instead of "refs/heads/something"? I guess it
> ultimately doesn't matter.
>
>>  valid_ref 'foo./bar'
>>  invalid_ref 'heads/foo.lock'
>>  invalid_ref 'heads///foo.lock'
>>  invalid_ref 'foo.lock/bar'
>>  invalid_ref 'foo.lock///bar'
>>  valid_ref 'heads/foo@bar'
>> +valid_ref 'refs/@'
>> +invalid_ref '@' --allow-onelevel
>
> This one certainly is a good addition, as these are quite a bit more
> subtle.
>
> Thanks!
>
> Patrick
