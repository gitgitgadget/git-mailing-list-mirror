Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3F315853A
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 12:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732107045; cv=none; b=CjZ+WrMfFvbqreBy1IDYUK++s9B19D/HpholZT0uOFXsVaog55j7cgK4MV9/LOxFXskhlIZ9fk53B1VCeXZ5uB7VmEIebuU7PFWhMeqKI4MEt+y8+rPhGUDTkqfdIFrbQ/wfXxc+1jACtN7zkcuWYu3J644+ZYq2PCNSZUxeQeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732107045; c=relaxed/simple;
	bh=JT81E7mR5VlA8oTCgi00yZH8o5AG5aKRVzrStOoD0+U=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=D2yXae+hz5B9D/nhwEVqKxxbNsurkQXlVYQ0leynb+ip/4g6qWPlTa+9QN/J+7/3iGJlVUHYTtmEePWrzH0hwjqBdxggMB1Zz1GB+bN7HdOZnSOcbCVgUbvwSMJi0EaY4vo1peZ4XCzM6F66LbS17mKgaBmKmPLnFUtbuuXYUjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=bzFWPbfY; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="bzFWPbfY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=O++Rf63ad5V/Pb4/KrDt2eA8Uu1wW07zEogZ3tily/k=;
 b=bzFWPbfY/AdVm8PEAcjAf6CHVIc9ra5c5DYQCVAk0rnlhHP4eLj4VqOUpHz0jxspfnQesbiK/Evl
   3zRAtwtRg4V9Hdsc6X8Loc0ehqpjwx0KH/nQGVKwa1pEugbsmzswt3ksCNgq8w5KJQ1D2KdZuiWj
   UpEIysK82gL9l+ISS8HyF9BA8LSxnuK/978gjq0HSewdil/4LuwUGuwqwJu0ohHLWlmkNBX0GRPm
   D7gFiR3CWhXIMofW7eIVNdl53Rk/OHjsw0c5lxVr73RFmhhg7RvZKUVrwhCNdVJyAsiH7S2AJf88
   jqsfZvn4lvWnb4TnkkXPIW73gIiFZtx7MKK3XQ==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SN9008DT2CHSC80@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Wed, 20 Nov 2024 12:50:41 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Wed, 20 Nov 2024 13:49:53 +0100
Message-id: <D5R0ONTYT1EG.K1XD9FZQO6R6@ferdinandy.com>
Subject: Re: [PATCH v13 5/9] remote set-head: better output for --auto
Cc: <git@vger.kernel.org>, <phillip.wood@dunelm.org.uk>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>, <karthik.188@gmail.com>,
 "Taylor Blau" <me@ttaylorr.com>, "Patrick Steinhardt" <ps@pks.im>
To: "Junio C Hamano" <gitster@pobox.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <20241023153736.257733-1-bence@ferdinandy.com>
 <20241118151755.756265-1-bence@ferdinandy.com>
 <20241118151755.756265-6-bence@ferdinandy.com> <xmqqldxgez4l.fsf@gitster.g>
 <D5Q32ODJM8P5.6VQ08LDQHPXS@ferdinandy.com> <xmqqiksjcx4e.fsf@gitster.g>
In-reply-to: <xmqqiksjcx4e.fsf@gitster.g>
Reporting-Meta:
 AAGPTdGUHIL1B/M3tgbWa8PFu2+D6IpVmybMEGCxno2DbEip2axeN+aPzk8V2r7y
 7pHRM+eF/dsrorEZyBRllpez18T4/h+a3d0s4ulNruUwDLL/bo2TpsanzADfuLfh
 Fp78umfqu//UY+zaQeYgRyfKHxHdJwve1SebXFbS12vkHemC8VXY7xiNyFuqnLOU
 8F4zv/qCEsh2FKEsQonVzAD5Z2jNWNH9yB5Y4dw2jhZ/4Jn+j2OEBhYvaMuGhy4v
 6vGEjCajk2jKP1KvomJcNlRSrifRYrydsjBhq2bPkAZBwcIiKGtZp0n9NcRN3O/i
 +lr/vG3eN0EDPdhOk+v2QRL22hLnEEEiyxoH0WDtsJCL+r+PzS1YDHlPynC0VYMS
 lU4enoYDkB9RTvOt2IjsuzPgUsvC4gT73WcYE+rQ3kvNzJOdvMLEfi8RYEhOVY05
 xDm7hy5RUWWZ3HitGpa78b2ppBzzZuVeEpSXUOYZIX6pxZwND1cxA75w


On Tue Nov 19, 2024 at 11:54, Junio C Hamano <gitster@pobox.com> wrote:
> "Bence Ferdinandy" <bence@ferdinandy.com> writes:
>
>> No, it is not, but it's also a mistake. It should be `updateres =3D=3D 1=
`.
>> refs_update_symref_extended outputs -1 for "not a symref" and 1 for any =
other
>> error currently. Before I touched the code it was 1 for any error, so I =
left
>> that as is. So we want to error out on set_head if we get a 1 and contin=
ue if
>> we get 0 or -1 (and handle the difference in the report_set_head_auto).
>>
>> Thanks for noticing, I'll get that fixed in v14.
>
> It is good that somebody noticed it (and it may have happened to be
> me), but if it is a "mistake" as you said, I wonder why none of your
> tests caught it.  Do we have a gap in test coverage?
>
> Thanks.

I've been looking into how I can force an error on remote set-head to test =
the
error branch. For the files backend it seems to be pretty easy

touch .git/refs/remotes/origin/HEAD.lock
git remote set-head [something]
rm .git/refs/remotes/origin/HEAD.lock

My problem is that in this case, since I want to force an error on a user
command, I don't see a way that is possible with git commands and I'm not s=
ure
how I could manipulate the reftable file in a way that can be reversed and =
only
errors out the particular thing I need.

I've been looking through the functions called here and it seems other erro=
rs
all depend passing wrong parameters but that is not possible (and should no=
t be
possible) to trigger with remote set-head, so I think something "manual" ne=
eds
to be done, like the above.

Since this particular test just wants to test what happens if
`refs_update_symref_extended` returns with 1 and not testing correct behavi=
our
of backends and such, would it be acceptable if this particular test case w=
ould
check for the backend and if it is reftables it will just pass without actu=
ally
checking and do the manually locking thing above for the files backend?

Thanks,
Bence
