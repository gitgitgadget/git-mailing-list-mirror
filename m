Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EB1367B92
	for <git@vger.kernel.org>; Tue, 21 Jul 2026 21:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784670949; cv=none; b=uxoVRBme/00E/FTTkyxOB0/8YqZpiIkCpyOP0gpsxkVcTV4dwimR0dJQI//GJ/JFeLzFMNq9xu1/oD9Mbi+OztohwyOwDS+ljKJdAlND8YPbWBIbVnCylGZgOMlxqrE3z2gvNiSIFIQ9JYP8jD2DcaAlmTOfcp3cylwVf1Rt6vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784670949; c=relaxed/simple;
	bh=rB7oIBhRewUU38c1jhoDWkt80VSdQURYAWGHMqxe+7s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jRiz6+VNvVwoAJlTdXaa7LE2fSA2Bcc8ivFpENEKFmj2r0P9cBFwVpag64/XADCZv/DmueZPOw+8/g8TpF3tzWOn0NdcTiUYR8OHvDF49sDxPwnhEEFL3NgJd6pr/hvNbGlhcvuKnyOixle3FM6yLRaMGA3BsHAlhyK2mmWEtkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=i49PKoqS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AmZPTRP/; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="i49PKoqS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AmZPTRP/"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 867171D000DD;
	Tue, 21 Jul 2026 17:55:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 21 Jul 2026 17:55:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784670946; x=1784757346; bh=jFCxEcKNMB
	FXDycGy+JIMBMvH4236PMQ0KQtnnYN5KI=; b=i49PKoqSqsdIiVlQAIsuRM/i6M
	cFR8sq+fXWUlSIUzqy4pkj5nECRKkAj6lnhr1ZMKfmR28zs5TwreFbFREdNsLCF1
	w+wtrTeHrrqB24XRzJvrhqj5o15zyEcD1/PJv+x/Gc9nGlEOKNJEsfTfnaDM28IU
	Ry5h4RRubHeMqaMnbUrxvPtIH9lY+9Efi53hLc5IctAZZ/rIMqu5n5onnMsjrc61
	hseDEHcS8J+rIutHclsBMFHrjX9JJrt1mpbTJ4GOBPdz1CosVc3NlobBGpU8sxbO
	SOFC2U5vFFdiAuDTwN0naV3r2omkMz3K3IGnPyWyu9ERkXsj/ET5qeMBIFNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784670946; x=1784757346; bh=jFCxEcKNMBFXDycGy+JIMBMvH4236PMQ0KQ
	tnnYN5KI=; b=AmZPTRP/HY8Nsq6SOTuEaIvtCGuZ9G/2klVVZWbyq5fYVvwC3Cf
	UDe/WN5w/Yc29afIfbidoYJn8FRn2KS3Cjvds4gStijcq2+s+6WsvG9VMrfeFEgT
	LWr3mPtEAZkuJbMcKZ7rEiIJa4H6q9wiDUZkdfhW41uRgCGSd5dDvJY4m6aFTDQI
	GRUlcA51y6KGI6I/Rj3f37p5rsLn8YoxWHQ6pwUCQ+tPRWe930RX/rlfnxot9ZrY
	YKO6ckl/N13W0dsoMOxwo8cYWpHO6qBZAB2ig2jssiUs4ShJVAs40+rzMY9ijNS/
	Gc5JdU+zLnWN2wBrvC3WJhjYEDSPu1db6tA==
X-ME-Sender: <xms:4upfalz6AOJb42lMHikat6jOfg2j2_-apM1PpiBeU6kOZU-3iotDtA>
    <xme:4upfasInVstM2N-uCDG9VHoQoRt22eHBq6U_owAozX6_SK09OfFZb5t7JpTW2nR_1
    D3tD9XDe4IbI4Zk9TNpufvj9gtukgkzuPBqUkusZ9_JRQ0GqrqVwQ>
X-ME-Received: <xmr:4upfanrMUYHlzC1TlqgVYz_zuNzbncNxh7BA1iH5nCSd_7-deA0ypoY4MNzEEhbDEX03its_Fyj0ylm-MfVqkbrIz2WdeZFovQ>
X-ME-Proxy-Cause: dmFkZTFFyQ5qdyMaXWCfvse9bAlfkc0W8BG+sWtEWKifaOPnC5bG2sz3IsXtyoKkdVuUjj
    Ru+U2pEwNJZyAI03IkkFGq+Qq+YGojHBT1zequcWTU2F64Hdgy9hN5WXXbulFkDqJD0+t6
    GAPc4MXhXhLgdpT8fEpLTp+gffavwAfBWmm7l9qDoS/GkXVpP06onTCgLrJgWUVVw8Y8Lv
    B7Szkxn8kV9w1q/bt4gAdbDWJNUTdfJHsTaTOAtwbxiuO3CVhD3YBPeJX2hMf91eqFQBGZ
    m7YoL/1x6fDWOUhpw+aMflPTZYZwa+N7OURAhswxdcrLrQA9Tn4Yh8ydEXBEHCkbpIlPr+
    4LrD1+LafKhCTVJZEDT8UgxaTcqxKWDPSDDVUdJjHqJvyFAyUudg6JN8VGf+Uv1qmvDk3Z
    30yChke3UMIMhQGxQGfSE6Cq6YNjsva0OK2ubmgGWgtk+K1tz1qopSnbKlfU/doH7zCtde
    GY9mAvTURDQvpHDRfDF1USBwE9A5vJHjtdm70WK6M2Dn1AAtmpSFP6qB3J4qFR0t9Gk/k4
    L7vo1mfk5CioqeLmvnWv9A1gsrX8HAO7weNRBrIbR980tqD6t4TFncQpaMLbcMor1BypXb
    JAwqK1SOO5vpqjIUZplVbWrbrmKU1ElzdpV7K1xkYR1nDuIREvrBoS2L132w
X-ME-Proxy: <xmx:4upfajLWol_fOfsKNIomWQyc06z6l4XkYY826lQO-UJWHH6OPBUGyw>
    <xmx:4upfakTc8wtFyNURk6hAXy8lB1uUNIEMTT0naDKV5hCUt08w58ZoOw>
    <xmx:4upfaqs6ZjkKmPIT8XHxk81c_zc_zLCZ3lND9cbH1Wba3kWYFNGnPA>
    <xmx:4upfatbkGf_y8R3rJ6OYkSEA08A6NtW3B_yVlF7ekEg9_Zx4bYNpLA>
    <xmx:4upfagnmYWtH13huK1ayimoV1s46B-lc1mG_IBM-OUaJRPVk0U3HXFWi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jul 2026 17:55:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Weijie Yuan <wy@wyuan.org>
Cc: Jamie Magee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,
  Jamie Magee <jamie.magee@gmail.com>
Subject: Re: [PATCH] t0213: skip ancestry tests under user-mode emulation
In-Reply-To: <al-1JkcH91aW6VWM@wyuan.org> (Weijie Yuan's message of "Wed, 22
	Jul 2026 02:06:30 +0800")
References: <pull.2168.git.1783359242130.gitgitgadget@gmail.com>
	<al-1JkcH91aW6VWM@wyuan.org>
Date: Tue, 21 Jul 2026 14:55:44 -0700
Message-ID: <xmqqwluot3bz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Weijie Yuan <wy@wyuan.org> writes:

>> ...
>> Cc: Matthew John Cheetham <mjcheetham@outlook.com>
>> Signed-off-by: Jamie Magee <jamie.magee@gmail.com>
>> ---
>
> Very sorry to say something completely outside the patch.
>
> But may I ask what's the point of writting the line started with "Cc:"?
> ...
> I know that Linux kernel has something about writting Cc in the commit
> message, while I don't see much from Git's documentation about trailers,
> including MyFirstContribution and SubmittingPatches.

If you ask me, 'Cc:' belongs in e-mail headers, not in commit
messages, though the Linux kernel community has a different
convention.

GitGitGadget collects 'Cc:' lines from the commit message and, when
sending e-mails on behalf of the author, copies the recipients
listed there, if I am not mistaken.  Thus, it is not surprising that
contributors use the trailer for that purpose.

We do not use the 'Cc:' trailer to allow a commit author to say, "As
the commit object indicates, I CC'd this change to that expert.  I
am no longer solely responsible for any bugs in this commit.  That
expert should have caught my mistake!"  ;-)

Thanks.
