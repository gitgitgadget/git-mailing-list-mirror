Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671C023E330
	for <git@vger.kernel.org>; Sun, 15 Feb 2026 18:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771180976; cv=none; b=pI3avO4x//bLPcpsDi9zepA7Q0+7KaTg9b5r7UGYBt9cS7Z8Fm7/bjRfFBWgdKrJ8DDg2DUqmEepIWu3T1+Q6wGGMLzeNsyIRwZ6DH7SgOzXOr7fh4GHfSkoSqRLbeiFmWqJrJD0krUoZASGg5rdiYNeJcxx2/YdxuNt73npedM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771180976; c=relaxed/simple;
	bh=vtAIZ21HfbZDjcDTbrslCAiyieD9kIU9MBilgEeBOPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c19s2BYCdb6uPMe/jc5246OzlWQntqd4qH9edn+c48xgw6f4tKy3m2HbNptRaVqWCyjK8if93A1n67gfi8TsNBYtIB/nmYsis9yv5dLCjjdIABqDu80l3bNBEzxxlU2egNiG9nfPpOgsBDOqM7+Llxnm30vAEPcLXMsdZNiIwuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=mHuPD3NC; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="mHuPD3NC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1771180964; x=1771785764; i=l.s.r@web.de;
	bh=wbs+DBaEpoJe8l2UIFGrdH4m7sEmk/eP53tNlqgqiF4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mHuPD3NC0T8280g3E0AIGVqWJxxvkuBA6qrMfoO2IaSYGlyobgjcAx1ZdYbNgmWb
	 6FhJQ5WaQK/d7dCJyuca7YH6eym1KTABqOZsH2HMpeOJandRp3V6pbgnp1aeQrIZc
	 sfNq4NK7CcOKbuNZUE5Q7fjvsJqaFKZNhlsIWcljaY8v4875WuLQ4S0irAWnSOO07
	 Nmk0Q61x5bNMGq9A2fR7hbP0s9XQG0YhgATnSKOKCB9t86riZbinH+9oV7kM3pVs2
	 nyOyXF0GPoW3CbQOMqrkTXCaS/yGyiE0N4LkIcwHv/SNH8lK2cYF0F2z7gqJZdH8P
	 JxEaj1OVy/nDfF7RbA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.22.157]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MBjMM-1w3q9Y3FKm-0004vz; Sun, 15
 Feb 2026 19:42:44 +0100
Message-ID: <ba0e8878-1f76-4491-badf-9f37364f4cec@web.de>
Date: Sun, 15 Feb 2026 19:42:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xdiff-interface: stop using the_repository
To: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>
Cc: Git List <git@vger.kernel.org>
References: <f58fa33d-b015-4339-819a-9d91be60cd0c@web.de>
 <CABPp-BFuwvqiCTCCpoyT6em9_1-qrgPWHWhrufQ3UuZ+Kfkb6A@mail.gmail.com>
 <xmqq8qd14rfs.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq8qd14rfs.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/FduGMNpBB1KtZtOtIK0kgfggSZ67psjAgGECwC6wkZBBwgXqaJ
 VZxvOsxqL7+3skRJeXk4qw66AV89LdCZpRvNn6nDSIXVykNARWpbg6nEs1RDIzORhppY4d+
 sMEPW01/o7b8Z/r+KPDl3XzMTffNNA3dQD5MJT/4zNPHw8hgcIioYCQoKtF9VJ6x9mOu74z
 ATZUFOZsGleON6SzzmLgw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:41SrdgE7ZbM=;ov8C+NyMPvqA4nUgD9fMFGquFLa
 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
 foi23j061m/0aOMbAIHOw0x+9zQ8c

On 2/9/26 9:01 PM, Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:
>=20
>> On Sun, Feb 8, 2026 at 5:47=E2=80=AFAM Ren=C3=A9 Scharfe <l.s.r@web.de>=
 wrote:
>>>
>> ...
>>> diff --git a/merge-ort.c b/merge-ort.c
>>> index e80e4f735a..a4103d56ed 100644
>>> --- a/merge-ort.c
>>> +++ b/merge-ort.c
>>> @@ -2136,9 +2136,9 @@ static int merge_3way(struct merge_options *opt,
>>>                 name2 =3D mkpathdup("%s:%s", opt->branch2,  pathnames[=
2]);
>>>         }
>>>
>>> -       read_mmblob(&orig, o);
>>> -       read_mmblob(&src1, a);
>>> -       read_mmblob(&src2, b);
>>> +       read_mmblob(&orig, the_repository->objects, o);
>>> +       read_mmblob(&src1, the_repository->objects, a);
>>> +       read_mmblob(&src2, the_repository->objects, b);
>>>
>>>         merge_status =3D ll_merge(result_buf, path, &orig, base,
>>>                                 &src1, name1, &src2, name2,
>>
>> A minor point, but could we use opt->repo instead of the_repository in
>> merge-ort?
>=20
> Great.  If we have already an appropriate structure with the
> relevant data, using it is the most welcome.
>=20
>> So, if you want to go ahead with this and then I submit a later patch
>> that cleans them all up, that's fine too.
>=20
> True too, but as long as it is so obvious that "opt" here has .repo
> member that we can use, I do not see a reason not to.
Thanks for solving that issue!  I would have sent a separate patch if
I had been quicker, because using opt->repo would not have been
obvious to me.

Ren=C3=A9

