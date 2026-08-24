Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD8D379EF9
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 20:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787601752; cv=none; b=SIpaTxK8d9y7WW5mLGrhGjA9cig/7ealPVeZI/zOYYJP/K4wyK9WTPxPax6ZBZuJSeC+z0SKiQJpSNoBssYbVlxvrn7fe4m6Yyw5uUN0+NhIijEr94naqgOsr3IoqeRLCcAANnc/f4cZKTPe1Z2TeqtCDOyPVP4AF1TUlHRxLV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787601752; c=relaxed/simple;
	bh=4txPQ425UIwJol6zyKSUnj/7fmepaAuDIsEuqaQHBlI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j7OrhYGHXZMS0KhNPBESG8f9yUgdWUD6fOZWETT3yoCo29B0CVBdMdVeQK00+yARUcRfwhPFonv7eiWhMMrRxalu7R0vZxnSP+Vh7/tw6bi3eDEFjVMntwW1YW6fZBe/ouPjHv/S8Ga0HG3EJrSoty9qqsnSW6JFRCo9W4DzLAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qxL03UOQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ef0MW9g/; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qxL03UOQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ef0MW9g/"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 8E968EC00B5;
	Mon, 24 Aug 2026 16:02:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 24 Aug 2026 16:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787601749; x=1787688149; bh=YzlXcSBYhz
	2bC9itL5Q+fUcbtOIhTy0ncmeLXWaKDbM=; b=qxL03UOQQ35Ug6HDnxzFe/1gej
	KKPz3bHS/HZ6Ht8KnySNNIIwiNJa+rHiJDhRvljUQ328kmnHSfnvO2pZrmUCbM8B
	LRfdpvu0Om2ZYEiWO86ktf5AeVqimQKrzp7W4UJOza98Yre9PqbD1eS2n+VFFJSa
	gvTqgHZjGq3jw4gXFDLRUjosKf8C2w3VpKzjEcqYv6SlrJLQC6goIlSaWeq0GNAQ
	ZlOuD/LLKoPiE1nnB9PnGjO9XQM8Ur4n9CmNmk5jb0wjDvqKLdScIOTO25zz/M8A
	bAXS5GVc9zQY+pSamEOaSj+kPTV5Dsfr0hq2FQ9zGb1ETpcTfX6IzldoVziw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787601749; x=1787688149; bh=YzlXcSBYhz2bC9itL5Q+fUcbtOIhTy0ncme
	LXWaKDbM=; b=Ef0MW9g/Q2oxRAfQizATe3hxE2fMhnZBlBYL4ybAa0krxGCrPqB
	QrxcBqmr7cr1vKJ4Za6JaZ5WB9nkdAdXuCEWE+iUf0IG6YeH0oHXavPPfTyxGzdc
	SjjGjvZGLAzw3Zl+M7OzolCkET1ot2TNm4sHRyanI78HddmbUL4+KQ3EpLqc/a45
	ymfvBSn8aHJdSX5HUG5ZBucs0F1XJEKDM+BDMnqmMc3DiyZR1f75vuPR/7K47oDC
	B07Udm9xRiAnACT08oP51pSVHJJEH352uG4bl4OavFvz+tef0/PjoXo/09FdflOs
	899LII6VsXhSzYGrFu2Z3IHaX6+jmDUoFdQ==
X-ME-Sender: <xms:VaOMalMBaCmnGMD2ljc-RqLLCZNjWqFTg-donxcIp1cvrlqTXcg7WA>
    <xme:VaOMavYZz_ZQ4-9JxwcHu0cTTqUVuXXZSdyVRq7haSS6G6xNaU51Ry02SLJwn6B3X
    IQgKJs_DIW-Dedn3oODLB4TO9Xh3vLczPgXCWjbvztCLYMuLlYNOa0>
X-ME-Received: <xmr:VaOMahoax56kDJWcgXD3RJJMUwxatu0NMP8sJxj249XcgVotwqviLlx-AWr7-XuV5TfNCSz8-OVjGoAHpgVcrI7HvJBEw3ievg>
X-ME-Proxy-Cause: dmFkZTFnkPrg9Uyz5p3S6VRsYCDazX4ccqmXX6j8LXyoaVStDgbm5LFt9jjLPjAt7EffGY
    iquDVnM1eTDx511B7NCfjwvMTGbn/f9uoRCmo0ypLgxnbDItCYeqTFAVVPQLf/A3WJN50V
    fp2O0c6A5iby+ftvQiVumXYsUvqb2LEzRdUgTb6ZV45adszhcW7sPSGnDn0IjWYupNWslk
    mfr6mNoxr8pup7pwuXn7nXXB/ZMk6vqare+nE7bJn4zEuQ0Fo0OY6a0/rYaENp7Sq7Lk1g
    JebWJKEyB8LM0zGrAxY46F220sUm2ZF00/gxIqBwRfQl6EciZqgwl6N1FfOnXyxaSU02Zf
    pGA8fwgmT6Pq9XKK8ESxV7JxOIqZttec7tLbMvCxKULBU/g5MRDQ7gVaT2U0E097aSp7qa
    stUyZce6Tb2zpj30jmAT5h7m/NI2hv0l1/7OWwrCh6tVvdaF5e2nV5mFqN6jHmsEFIbQpI
    DasukiLL2BliAWUtnZdrBUNewlMKHo50FddvxiJ53IBUkYA6kCkOJgu/wwNQaArnB7JZQK
    7hzQKnnHjjETfaG9cfhoTuEBvd4Y0WYzUKDCkhymyed5I8PUM42Cj9p1Eorz2+h5uz42jF
    0fRF/7c89IKS9qbLJ4utEuhTBYaTTJBJctgReztD45ZFOGNjFk62+Ak8DoRw
X-ME-Proxy: <xmx:VaOMarb8-wBRJvUCK-Io-kDXWfVGaIDeZQCuJSYRd1ky3S9fkt3NoQ>
    <xmx:VaOMahSZfwbzS3P0GO_QMnialR1-Ti7VoG4eN6ll3JOLQ3FOffyTCw>
    <xmx:VaOMaq6m3egIe3p1JK9mu9W4Mf8XG5GwM1OppzSqbtNLAus7ciJRHw>
    <xmx:VaOMauxVW0QLTCS9RikBF7NG7ewYMCdGLdOryCEF-ZF3MoqaorWGHg>
    <xmx:VaOMavi6XFXgP6ImV81JWhFNbezPHiNMy8iHtIMyT5bpFxRA82oJH_dh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 16:02:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2026, #10)
In-Reply-To: <aoyCyYDWEbgdnA48@pks.im> (Patrick Steinhardt's message of "Mon,
	24 Aug 2026 19:43:37 +0200")
References: <xmqqbjaru0yx.fsf@gitster.g> <aoyCyYDWEbgdnA48@pks.im>
Date: Mon, 24 Aug 2026 13:02:27 -0700
Message-ID: <xmqq7blfqobw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Aug 24, 2026 at 06:01:10AM -0700, Junio C Hamano wrote:
>> * ps/odb-geometric-repack-loose-threshold (2026-08-11) 1 commit
>> * ps/odb-pluggable-pack-generation (2026-08-20) 6 commits
>> * jt/receive-pack-pluggable-writes (2026-08-20) 9 commits
>> * ps/odb-eagerly-load-alternates (2026-08-17) 6 commits
>> * vm/complete-history (2026-08-13) 4 commits
> ...
> I'm happy with this version.

Thanks for reconfirming these.

>> * dk/use-nsec-runtime (2026-08-20) 3 commits
>>  - core: convert build-time USE_NSEC into runtime core.useNanosec
>>  - environment: align repo_config_values_init with struct declaration
>>  - meson: expose knob for xmlto relative links in manuals
>> 
>>  The build-time knob 'USE_NSEC' for nanosecond stat precision has been
>>  converted to a runtime configuration 'core.useNanosec', allowing
>>  distributions to bundle one binary that adapts to filesystem
>>  capabilities dynamically.
>> 
>>  Needs review.
>>  cf. <xmqqa4qgsn20.fsf@gitster.g>
>>  cf. <aoaP7oIrR_Bpvx34@pks.im>
>>  source: <cover.1787231825.git.ben.knoble@gmail.com>
>
> I haven't gotten around to it yet, but will try to review it tomorrow.

Thanks.  FWIW, I am happy with this iteraiton (modulo a nit on a log
message).

