Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040332A1BF
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783872456; cv=none; b=BVK4v2TksopaxEboVScquXXRy8XWMuAtf5XavyAnXBiZNeo7LG1mv2wY92I86q7o0fqhOEK1jtHyYf7EStGyX0xfUdFKYyiIc+6qeYooU8HSKElATq6KyZ2Ft4ALypHufAo1SyVtaff0c3u/TVnpAGM7oOebqVnlqEFsbBIzai0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783872456; c=relaxed/simple;
	bh=ndidLS6jbyLrw119TRWTJg5QWvas49djJs6377vrlQ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i2hxEWSH4MTbRhDRN8faTLumttWuw/t+iChz2RunS3sXGhSKoNLasyEhqOrPXzHpMw+R6xeOyOZOeAj1rbHB4cGiXlx0dZjsYpd46rp+tFMy/EZmKFuSALT4bAK0SbhC+zdqw26mI1gnzz8XRfr3132foTsTJWtXMOvn3JPtZIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nphY41st; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OZbsAjJ+; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nphY41st";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OZbsAjJ+"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3AE661400030;
	Sun, 12 Jul 2026 12:07:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sun, 12 Jul 2026 12:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783872454; x=1783958854; bh=x9Dyk+rUb/
	GdRqSM4cIsMb7N0M1lCPdxTq+RbD62C8Y=; b=nphY41stdhPeU+Ghxv0a4KbJ7D
	9bsOms3HRdj6zdIFwDQ3O6glNaAFAyR5b5xJmsa8JB3JCBreQKlUoQB9JQpUNdT9
	FP3rbd44l8JmNGangpWP0nr+XPGHBjDLa8bnil3pF2vJpWqCkaq3LwDJGnzsSjYG
	fZuCDudl6XYhwzpaS3jVMflePxFZGQVyIM1pZiMMI4FvsU0DMTls19xBkJ+x4CMS
	gHtryJqN/ABR5FDpkjMOXzux2cM6PdAu76pjNO/mi1MksYan7m767rJ9H719Z39i
	Xh/9xx1OFtqLQcz1Jf+c4JJHxdB/P07zC5t/uE94xf1L2BKQfsrCUyCuzu7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783872454; x=1783958854; bh=x9Dyk+rUb/GdRqSM4cIsMb7N0M1lCPdxTq+
	RbD62C8Y=; b=OZbsAjJ+rmdhJ7hxYJxSOzu55HBu04bYmPHGGaSOQS8SmmR8jeK
	j5v+LE0XKRHZFEJDfu6+YVaLkyWtbLEQyG8jeJUhf7vzg42Wf0+HY7Kpg58MZy0e
	hdxQG0vhDkPcU64kuuShJXwmR1lVrO2cCDwYtX6P6LFs69+y7mJmquCkuLMsRDCA
	wO2zl+KngFAam/VPWv5Fy2hjGd7Kx5CFPA6zr9gRXl4guA6zd253pTVWzEHY43jM
	BU4OdOmoM57EZGUWpwN8SDEDJF0wDvQCZ5Y012x2iuSEYZxJQc1IGgx0tYQz/bS1
	BYU5Lu82mfyeCh4CXq6gbZNnADA6m4jibdg==
X-ME-Sender: <xms:xrtTakleVDCzMqRVIsZW-pbZlXd5hAMrexAwDuSnGtRqrUWo5eaPtg>
    <xme:xrtTarSyv0tN2hC5M52ue3gZU00uDbPFC5L6eAtd51HCFchKmaJwjD2ceh4UPOo99
    Zsgz_OiPYYt4_Iz3FOdflV1vhAAXqRQqgKXEY0U0wNwsLORB1z4>
X-ME-Received: <xmr:xrtTagDXmoXDdyPIHNHSwh6ncvP2jyUMt6vBcPZ1P994okM9kVlKWKy-_NJrmRNzr4Iut62v--bUrVONkC7sHeOgXoyWYcwRESlJI6o>
X-ME-Proxy-Cause: dmFkZTEyE2JU6+M5b84LkGtZh7ZKfjr5g6fEX35tHsqHjYWvtwleqa4h53OPy1VSG/X+PW
    04yl2pPeVPasIAZnebC6W1Sk7Ly4Rc2NGIWMVip6+IYBiV1Ocr/7sFLDnUYN45AupLcHOd
    xtKg21cOd04cQoeaMdyMnKK5ha1caZ49VZK7qz0ScH5l1wRV+enPg8MzDfVp+u1JGJLl8x
    FtOChVsLxzpwjIbXLtq6j7yMFAVMuXqha4ug/54bJdi+3bPuQA9aSLmmUm8nabajijHF9j
    GMErljF7j8Hp2968hET7AkdihWGjyvlm/2kAM5cJGg4VlfrZwd62RWQZmqrjldTGMQA4jE
    MZw2tfjOW7P+KmC4yRrq8SuhEmilWhIF3L+hP177lDGkVi/8r6gqy3jxPn9tbILZMetKLb
    WwUnhoHsTVExbk0CfizKBBMhPfELA0bn25Heqf8aKodKKaDY4cneHYTWcbT8RAFxal1hnZ
    zQsUY3D6iICZCI3mSt5OCfbgHnOWO8fsZGziHEvuQq4R3pp4EIOIMDHmx7gY3TW5D1uvfB
    QBg6YllcYcjGsMIUaqLxq8Or63qO+z4+3n4vL2FgDsrhXjNexcm+WXhZ1Gw8QS8LOswt0k
    6VV8Bu6d6Q2FoxEnWEKjYIY2TX0ObPf8/x7r+BSfyHjuE1Af6XuBYEd3taqA
X-ME-Proxy: <xmx:xrtTaqQO4hxqVtJubgf3qVZxU2WShx8NjVzfOfX5dGbd-pYjCsio7Q>
    <xmx:xrtTamoP-YbJjgoocqTd1_OQ1jBL833IE0qd_P-zyg3DFL62gXIkOg>
    <xmx:xrtTakxNLmhQZsm-bVyKGcLagSsigBYHPDMuohMMsEfM7awZw2H1EA>
    <xmx:xrtTajI7DI0v7BiWFdtNeKQKxmryuNZZulpHdKJYvYMJEsytdDc5HA>
    <xmx:xrtTak4kiFPgTF38rj6OJfkAUdo1y3bbXyZIXcSt1lF8iLExDV8KcyB4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Jul 2026 12:07:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Weijie Yuan <wy@wyuan.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/6] SubmittingPatches: clarify expected structure of
 commit log message
In-Reply-To: <alOplirhJxIkpDYh@wyuan.org> (Weijie Yuan's message of "Sun, 12
	Jul 2026 22:49:58 +0800")
References: <20260711192650.2417665-1-gitster@pobox.com>
	<20260711192650.2417665-2-gitster@pobox.com>
	<alOplirhJxIkpDYh@wyuan.org>
Date: Sun, 12 Jul 2026 09:07:32 -0700
Message-ID: <xmqq7bn042ez.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Weijie Yuan <wy@wyuan.org> writes:

>> +2. **Solution (The Approach)**:
>> +3. **Command (The Instruction)**:
>> +   [[imperative-mood]]
>> +   Command the codebase to change.  Write this in the **imperative
>> +   mood** (e.g., "make xyzzy do frotz" instead of "This patch makes
>> +   xyzzy do..." or "I changed xyzzy..."), as if you are giving orders
>> +   to the codebase to change its behavior.
>
> Stopped and confused for a moment. I am not sure that "Command" belongs
> alongside "Observation" and "Solution" as a third part of the message.
> Sometimes the command still describes the solution. In other words,
> Solution and Command seem not to be logically completely separable.

I do not think "Command the codebase to change" is a good phrasing.
It would have been better to highlight the distinction between the
design of the solution (approach) and the implementation.  Perhaps

    2. Design (The Approach)

    3. Implementation (The Changes)
    [[imperative-mood]]
       Describe how the change is implemented.  Write this in the
       imperative mood. ...

or something?

>> +#### Formatting and Style Guidelines
>
> Perhaps using "====" here would be in harmony with the existing content.

Indeed.

>> +* **The Body**:
>> +  * Explain the *why* rather than repeating the *what* of the diff.
>> +  * Try to make the explanation self-contained.  Avoid relying on
>> +    external URLs (like mailing list archives) as the sole
>> +    explanation; summarize the relevant points of the discussion
>> +    instead.
>> +  * Wrap lines to 68-72 columns.
>
> MyFirstContribution:
>   This commit message is intentionally formatted to 72 columns per line
>
> Should we update both?

Perhaps just to stick to "around 70".

I do not think the defaults in various editors matter.

The "wrap around 70 columns" rule exists so that in a text based
email exchange, where you lose two columns to leading "> " when
quoted, and an additional column with each subsequent reply, the
lines will still fit on standard 80-column terminals.

Thanks.
