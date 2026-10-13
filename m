Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FD64A499C
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 18:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791916552; cv=none; b=rbpsaMQTglhEJK+uXfjwNsx21bm0yuKa+TPxJM062+BSDea4IScAy/oMc36p7D7hJyhsa01sbSzAUcV6BfJSLA9N/PpaeZ91dyQc//2UKQoFIxSoB2dKkX+lEs2HpoSxWhPlDmLEWk58t/9/dPq3PwO8XFLdHvsaqQFsnXPSCSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791916552; c=relaxed/simple;
	bh=J5yNjS/7NWUQLJQj5imMlsOz7H71tZYPumOzyJeIgyA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bpPhukMkA1Ox6266Eh2z4M9E467BYW2lNwLUCU0RrK1HhNEOLXaAIt0XAUjSaL72jsv5+tOnTL6cpcYD/+d46itjSQBNpUe4TFbSn/adBMIUhM6auknu92j7ILBN1ZGVkpo8z/OsEkGy3iVxEvkIDM9Fca3JMMsdN5ObQnRNIQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pZ1zWmHX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gaALPbj8; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pZ1zWmHX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gaALPbj8"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 59B321D000E3
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 14:35:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 13 Oct 2026 14:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791916549; x=1792002949; bh=J5yNjS/7NW
	UQLJQj5imMlsOz7H71tZYPumOzyJeIgyA=; b=pZ1zWmHXPDG03g0ecHCnT+Ia4x
	9JgPwJH83aIlyDI366m2SYFIA40C6+gVzXpabbfrD2VwLyQ8DrVQ+IVYyAH/Re4P
	4Z0/WHms7f8ZCqxV2B/RNV6FcESOUnYSuDZ513VbTcjilYEcuZqHnrHmUkINPqdt
	/V3zf7JrqgxD3j6xKz06aJo6osD1xbEznJJ9z8HOGhMIcexz+j7o37KU1tObNkHO
	LWv4VJhe5a/g8MOHjFzbgWK0gbK63ThanGATaaTin1VDXhdfMuqXQRF/pAJmxqu5
	FduEBcizNgPjp2X+JWTxJcyvj/rTauzvX2tm8UC8yYythdPayJKhsoevNQNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791916549; x=1792002949; bh=J5yNjS/7NWUQLJQj5imMlsOz7H71tZYPumO
	zyJeIgyA=; b=gaALPbj8MpB8hrr/As5wM9bVjVOTuJgGbDMPlh3UNE9dU0Bcti9
	O8j1sDBn4YxysmgKW/6G0AUdPd38G9aClQHnSnDqIGU1XZWHpPYXcAnj4qfjoR10
	gN6UznkA48KqEZUCjDcVsO9kCbW3Vf476ovvjmC7PlHWRLfITyVHvCd9AtlL6WfO
	gx/JhqFTraMOwFwrqkgFjRvJ1JpRL4C98etiuAMOHG96GGi7mBT0KlcKoPUatQ4X
	aT+D9B84LMESvh+KrRJShTIAdJQfZSBRi5O1SuKCGqjKAk6uoIvDOhd11PEiozms
	RVgWQUUbfZwkJUWSHWskzePfIygme9rQc+Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791916549; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:eh9L37w8Jn9aXEwuBgmbDeRqweJ5t9DKaC182yU52O86pqX
	L+Jo2g8W/IBtKZs5cr6SMI5vTJN9HGwneyoE3fK8EYQTtxjWgXSvbBP+JBZKAYAC
	czfNTT1wxOUjjwJKU30CeVi8Sf3LpNgbtSRmIHbFCwdpGHRKzOKreEDO94CM8f7S
	ydpQQr1LDR8X147VY8mlplwNHc2KNcFysHvjQhtwlFdbNfyMSDlpUx6yr/j0+vLY
	e6YNzLhsieY5m+eC5RNcxAXbd2c6aI0UJ505db1zDz9p+EjMufghRmbr4KvH3jGS
	INbAoyfPxiqPXDI6xhEok3WAnUh1IsrDwdbJvCw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:CQHURtMbJjgTrM6wOonAu1Cz2FESLfokP0o002a5R6M=:J5yNjS/7NWUQLJQj5imMlsOz7H71tZYPumOzyJeIgyA=;
X-ME-Sender: <xms:BXrOavFOdtiO-c2UvfViIHbcxlVFJkT18EGLger97R6B-7WcZ-NGyw>
    <xme:BXrOajXjppyJPW6tpR5M_NBsmXP6wVTQuLGy2ZQmHEyFUok5rxI5bu1jJoEedCHlC
    ADRAmJbWgMYXwda0i_ZDlxr9EksuTo2GhPybHpokaKwIwmr7FFaAH0>
X-ME-Received: <xmr:BXrOamJp9ntXrWuSIaGKlzVlX2B_-AJwjvglVaFV-nFQX7J6PT6_Q3jbmBtO0ZiUIQcpoR4kT8CtAk316-xvkFKoHmbmtdjvCkax>
X-ME-Proxy-Cause: dmFkZTFxsvfnAqcyUKiVMUcW3yQzze+4+3jOY249xAWgS6O5YYTRRaJ4DN6gkXsvNZFZeZ
    6bd+4ZD1fO2Zvkcdf2aG+yXyBkHTkFOGvRRkqturRiQtID8CpieN6KHGn/cb9JKMT509iu
    0TpTZUVP1CeEHLgL72s9Fpah98oI3FuPX2dDs5xoJwA8EOqLJy8WPkHk0ATYV+w5TpHu4f
    NYYwLA3KjOcPAJ+haQnyTE897vWz38QN9w681MgMRHzfXIpGaPJA7Xom5f/qRejHf6T+tZ
    127e69mNdxHenFrb0rd+8FH6tSRZo3GZjw3wj4xqzniW4nwWZr2Y9oOjAk1ZZL65ihasTJ
    5fPQxtO1LXN/WBsxB6oFvKEaRUhL16bZtI6elRDH7afQm8TJJ69Zb4lI7T/SfJtWn24Vdj
    zP52WjeTLxIwqZN0ve1mWjyj5o71w2l3R9YiHSfrZ2/HEQ9wVeEYJbXgg65+0I+3YEmQ6s
    eWOZhAKulMSalpKDoBCiy81jYI2T8BwjuqEG7KHCFm6wqo895Gf6XRE3Yz4tB62UUK9RTb
    RBhgF0kf/q43eFLmhw7HjZ8NnQJq+FdjQoNOcWuvo5jGTrm267ibFdVoNaiRqnK0oa1NqA
    73pKCOMnSrY4fFts+hy51rxufRAku4Z6pzqL+69qGencB0mqDr/HhwA4OaGg
X-ME-Proxy: <xmx:BXrOar_4ECaGnzBX7npf1bjE-Asihsv9NPg8qmuJzfrPV_AjhpyXig>
    <xmx:BXrOahK5ChRffO4RX-Ei4hQxYm07hjfzH5EzUDVnI85uQ9ndA8Gl1A>
    <xmx:BXrOaolGBbJBhlYCYplWOUDNI5e0lJgytt82a-tbOe4wqxApRtQC5g>
    <xmx:BXrOatMx1eVVbbF7jmiqvBI-PXgUNTcLKR0tZ8857_bz-O-z8uLvAw>
    <xmx:BXrOahpelDgYceWI9mdA0y2FipnKl316TnDXt8IxTWD1w1u1VyUqPvb9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 14:35:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Shashank S <shashu8660@gmail.com>
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,  git@vger.kernel.org
Subject: Re: "[Outreachy]" Intent to work on t0081 : replacing basic shell
 test command to test_path_is_*
In-Reply-To: <CANHmUQTm_4b125eFAwvCkqnNEu386P=z_Fh4rMjuyh0kSshWoQ@mail.gmail.com>
	(Shashank S.'s message of "Tue, 13 Oct 2026 22:54:37 +0530")
References: <CANHmUQTa8tLpHjZZ=Fp0m=X5Tb+uFuCcRobX7x05gKamXAgrqQ@mail.gmail.com>
	<CAPSxiM_36hf1r33GQyEMEkCAs5yeEWr2J+gFfgk=rx_-DoTv3g@mail.gmail.com>
	<CAPSxiM9eQY8oQVnpiNRqXK8SNqSMy3YcDwkV07Mh1wJzb-n4fg@mail.gmail.com>
	<CANHmUQTm_4b125eFAwvCkqnNEu386P=z_Fh4rMjuyh0kSshWoQ@mail.gmail.com>
Date: Tue, 13 Oct 2026 11:35:48 -0700
Message-ID: <xmqqld81xxbv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shashank S <shashu8660@gmail.com> writes:

> Got it. I will make sure to CC the mentors when I submit the actual patch.
>
> On Tue, 13 Oct 2026 at 19:35, Usman Akinyemi <usmanakinyemi202@gmail.com> wrote:
>>
>> > >
>> > > I'm shashank s , an Outreachy applicant for December 2026 cohort.
>> Next time, I will advise you to try to cc the mentors. So, they can
>> see your patches.
>> >
>>
>> Thanks.

On this list, please do not top-post (i.e., write your response
before the message you are quoting to respond to).

