Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C3F53E31D
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 19:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791919265; cv=none; b=SPSopBwtnh9lO2+aQrVrVZMIOnAS1iCB6RcXXWZULkfK9NG3/jgSZ98B9KIaUNgQ20YoOPAh8Iz+yUOcgKvQgtk4j6gXxDYcz/sXz65+3Lc0oOwfCwYhu/MJYHp+1YYrkSTzgBDusSNIgQfqsl47Zp0aB+o8BW7hy2wwBv/YM14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791919265; c=relaxed/simple;
	bh=AhvLfzka/7fQk7mc4IA87YejOJ7g1dlm1yPMiXk/gug=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jcQxnkXCysiq8q6DONgO/4Kd0fQxzsbd+IB5bbMJchXazwEKaWzYd8taVw4xr2V6B9yLds42FM9TVpey/QIUa+SMMwDCGUFNy0/qeSm9L2/LYJlOZJXsbL2BreGau4uIp46gX7sjQGdzIPAd2zZJUNKudrTV806JpuU1NySuq4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=R8vKZjFd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PzX8evIT; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="R8vKZjFd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PzX8evIT"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 659647A0100
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 15:21:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Tue, 13 Oct 2026 15:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791919262; x=1792005662; bh=IYYr7xk8+n
	1swBDWPIgBaf2bYY5g3nQKEkh5CX0SiKc=; b=R8vKZjFdhh3vaq/ZKYzvGCv4uo
	B7O9E1d0gqn5JRBCRKDY7r5TslNTCbALqn1xZBS+SjfHF5I+gUS4AqKURs7+CWif
	zPdDXQPM07i9A3GnHeGbz+A+4VS+nhpPmPg7SjhwLkBxlN/vY5KXGAMj2Xm3Ml5Z
	EK9lyzPiqLxM9PXYL+INjkK7svbnisA02ZCuAyjHUE3fLCx8dT747w2K0b48JryM
	85CYZKuWsFfRR3wIHNkxyGbUOxqPcoLu3mH3O1ap4M2JazsrFAvVc3WuiYPw3wqx
	r1xESnQDRNNW1jkVFAlMSEpIYPdsT4jfDyhfoMgt+0TcJVPT5As/uRPtvupw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791919262; x=1792005662; bh=IYYr7xk8+n1swBDWPIgBaf2bYY5g3nQKEkh
	5CX0SiKc=; b=PzX8evITDsE7k2cVr6PTyMVtDU5ax5N0EwZDWS6R4ytLuE2S+bY
	abvWR1EDfIRsscHmrzDpxeHeW/vEt+nKrK1Rp0sMfAg0VoK+fDBaAAQWQ7JI1tK7
	AiLRy1N3y3lg88RielpwNcCViRuRSkoc6orErkJ78HKiKhQEGSe7Sj1co7Ro30dS
	jFfUAEA1RiJkdJLvNZFo7ozUuxZn6gMK+9WujPNMMfN2i31VmEDiFJUnLDXagOJL
	/8PQFc9TqkD0laLeZrF3EnGuxMCWprAmKBo1+LFwx5zZRr2/CJY/Ob2VB0s7IHkD
	get//8mebKE+TwNm8beF/ISsnT4yHyYgM1A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791919262; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Ugwwgwew7KIRleTT1VBgvwzX/hBJMm48BaIfTtkAdYkTHSo
	Bg52ZmVD+yEMZ9PydXBEq0A2qwEJYLd5l8tuZ+DpOl96+vuwitb2Ii/cOImlyXMM
	if6ZHZe+o7KurVFvzGzQvx7lqKpmZBrl6qPJAbY0aLjvLphMu2X1iVhqhOdNwE17
	J/J7gUKMIwjRePaxShMFPKS+lrCfK5fT1b8JhBfVMV8Z8mqLyeALwRpEZpfcozsn
	VvKYFLxfLSwMgpivHADvP0bS7ydCBbyZx8Z+9TNEvNaShMetFNDB7pGP2l27H73h
	8PQZcjzeD6qrkLnxKHh1mR8auiRv30r3/N0io2w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:YNTDtUByc6VngXg02x9p+udCtoG1Eb0A+6JY20VBaXk=:AhvLfzka/7fQk7mc4IA87YejOJ7g1dlm1yPMiXk/gug=;
X-ME-Sender: <xms:noTOatQU6uQWRYP8VDOIuezWcVXTuZipZZhOdAGm61zpRT5ZPOuiCg>
    <xme:noTOatwWADXX9B2sspsqKxc1rxyOSTyoq26PQsBFR2kd_f_KIwR7w-5oBxEvlVuHt
    b58o8-QzvhdnYxNtQ9s3iMHJv1jXBqZnycgACKR7f6pwAbanZchKZY>
X-ME-Received: <xmr:noTOan1xTe5hSY8JqRnClPiyUTIpNr28rmwMZUqMlUeLwwnGvgefTftgewyoJJlAuyvHSIW3m6qJlsku4LXYzgW5NaqDeyGIQ2wN>
X-ME-Proxy-Cause: dmFkZTEKas5mxKOmiHk8QvthLE+0qwFI5q43ioKGdwNGaKYTEZNTbSHeGT4DlLJ9EE5vao
    MPI4+DxmqDXc68lsko4NiplMWgYJSCLldnLPHpfOIbdirdgpuLuM6DwBCogpMtdSEjG5rw
    v+ZfMZ8FDFKGV5s8Oo4QLCuC0GC6UHlq/qDXkf5z8e7MSwlFSSJYS+YJfU7n3nUf1n+HBC
    y24y6n8avV4IREnFc6lSpsq1jI7X6k57CTH1UCZwGzgju4TEoCGItBfHikfvdT+t+pgmub
    AnchAYanBFXMxqAOQaFpGAdIWM2k1U8zFtHVr6uFp8UBAS9iZOEW0CDQjST9VDFQFfPTTX
    3tvL/+bQWHp1NfS6d6nIpuCeIktcWIHs+IWCDq7AmzCBag1kxVbjS6y9y0W7R1W3ccfBjp
    85HX5VaFJZ6FuPqEHQ6cl08HYThYMAUsCGMoj9rkfbmStOtqPvpA8naLCblrwWsuytuFt4
    KKhoqOeXCKRTnYkea2xgIEqQff7SVcDmlm8Tcb+720v3dKGp/6MRuPMUpshVeqy9uKafvi
    2wZAARAhr/33sybQ3XTeSjbqOCof6j1r1qrJXUT+eCKmk3ZuOrX76kMbE4Ar1HkAY+MVVs
    0183ck99P3mS1VAE/W/tZoj6BGUuCqfRYUmVaMznws76o9wjFbYKI5Ek0gbA
X-ME-Proxy: <xmx:noTOaj6uS-kVywiLRi97pecK59YVmKr6OeuN-t1_08pXgASniTjv2g>
    <xmx:noTOaiUaLmZ-nzn1RNFOStfDrFlPGeCwb8KQDY062K6IG5GLgybw4A>
    <xmx:noTOaqCt0GtAfE2-aTR-KczKIqr7Mp-2rT-KHxYLZ-V4tfDz2n-t4w>
    <xmx:noTOap7AQrtyjGaTTtWbPswk8rS4wKyQQ5UPcR5BsoGAWuf3Vvw5eg>
    <xmx:noTOavV1AewUXgrHFsQexvchnySnQvsh6_HkY5UPB29033VrXw51Hgf8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 15:21:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Shashank S <shashu8660@gmail.com>,  Usman Akinyemi
 <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: "[Outreachy]" Intent to work on t0081 : replacing basic shell
 test command to test_path_is_*
In-Reply-To: <CAPSxiM_36hf1r33GQyEMEkCAs5yeEWr2J+gFfgk=rx_-DoTv3g@mail.gmail.com>
	(Usman Akinyemi's message of "Tue, 13 Oct 2026 14:52:10 +0100")
References: <CANHmUQTa8tLpHjZZ=Fp0m=X5Tb+uFuCcRobX7x05gKamXAgrqQ@mail.gmail.com>
	<CAPSxiM_36hf1r33GQyEMEkCAs5yeEWr2J+gFfgk=rx_-DoTv3g@mail.gmail.com>
Date: Tue, 13 Oct 2026 12:21:01 -0700
Message-ID: <xmqqqzhtwgo2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> ... You can work on it now. Also, we do not assign work
> here. You are free to work on anything you like or interested in so
> far, no other
> a person is working on it.

These are all good things to mention.  Thanks.

It is helpful that Shashank announced early their intention to work
on this.  Especially during the busy preparation season for
mentoring programs, it is a good practice to allow other candidates
avoid working on the same microproject.

It is not strictly necessary to prevent multiple candidates from
working on essentially the same microproject, provided they do so
independently.  The "graduation" criterion for a microproject is
not whether a finalized patch lands in my tree.  It is more about
helping candidate mentees get used to the process of making it
happen.

Enjoy the journey.
