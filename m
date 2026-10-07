Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31028287247
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 20:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791405853; cv=none; b=aebiKNKUJimGBJ2Iv7aJzb29/61oCtAOrdv04pPWOjcHVJ/zTCFnkzRKUQK/y9M6AUQbhB0+g7PUBUkD9FPjYIzr2oT3XurJuuU9J8bBJItfBJ8e3g4EwwdQkVwZ9C9ypicFPHrJ5uB+V5ITHKRbLz1yy9ah2VZ2gsqm5PaMN1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791405853; c=relaxed/simple;
	bh=W7f8dMgpIeW9eT273Sh32xQOaW7A41oeFosfcFEPSKw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b8ah8lpWHJV9mlKrhv33SUe6qhIxDUTTiq1+BuKMEXP2bRI/xevQGN8mP5SD3TKYhamxfc5hTjgql2rlVqHXk6QmYCRTCKFkpKwiIBwogxR6RXAfQ0L9CbHHCDrwm0KYYgLuLuTWvK1yaquQWn0boE2OZCmgLvDYwN+tcbalEIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YTQRQf0B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sV0qxJPR; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YTQRQf0B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sV0qxJPR"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 646931D0011A
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 16:44:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 07 Oct 2026 16:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791405851; x=1791492251; bh=aS5kO0qcxi
	oSc2dmN33tq6bWJ2iOpoX5Pv7+yN0enbQ=; b=YTQRQf0B9FKef3b6IV9nNvgjOL
	E/Xhd7uHRF96vp/cjPR8xN7Pvr+KjoluaRLfMz1OCl87+chmddWlAyvtuRMQIhj2
	x7Hin6EnHZQ7QnP/TV2CHht7paPTfJZgrXtqmHrV0gCLU2XfrviIttNgJjcuuOI9
	39m4bcnYR0Ie3MK+LgDYKVSzNtHPQJoSO0L3/SZ5DdilEy3YxbHXOJPTUjukpeeo
	lFsUnDFoAH+okB9yCkdbMzf/u6Ja5XPJ/iGOEzv5ml8zDig04fXbrtb/prWfsPEO
	MRXmMVFA1rWT9ogHINA3i7pV5Cv6IgbKVefZ2JhojAQXBXYOtCE+UfusMmuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791405851; x=1791492251; bh=aS5kO0qcxioSc2dmN33tq6bWJ2iOpoX5Pv7
	+yN0enbQ=; b=sV0qxJPRmOheDLcvnAHVpBM1pz2YEGq87ucD2juiYZ+aKCeGO+T
	T6eMA7veaRMmz1UW3KEM+OI1mWv3BW7xcb/kV+CC0cx+/Z0SvwBm+pXNE3ze6GJL
	6iAnbtK3+ElNd0Gaisj5vkCTyrfRBA6MDNyANbcTvjiFZs6Uu3i9uiki52hqjXzC
	3kf1xWgSVQwXYgZZHPYBkVNZLBcbeYM4lADoqiiLfNQv0Le9BFgkk8OK9tcO3/rt
	H31r22+dJ0IyNXPpT/O2Ib+EjqKbEwzxx6wzsOhDy01Ooe1KrfvqHEJydv4o6oV6
	Tl3z1+nelMcT7d+6+uxCBWjqzHRE5rmcoMA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791405851; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:GKdSJNybR2/tBW3lI+IS8oaepE32sGrP+BG0+7+wCcyYMxf
	tqxX4CrY1NNr31HcGMD5ofRrGDXHxcjCkyn+Xw6L5ouwP2EpNWHakP2aarFqoGfq
	8DVIDYLskg9BivVRLjs+WddRXZ2PfMJH1kd+6ULB8/lBHBPyADB+3MhcjTWlCVKo
	zWTOoToFyx1VF8b0lwur+Klqp3i7XS9aG5qihaSb6GfIeFY0u4CGqWLJx+Jf0rrY
	wVRIJMUIjVIzpg+STX/f+4+pN8Qb4DOCtOi+nHXAIvbiSpZLLTyMmcLvRc0I83P0
	2OFWAdCMwNfcrLG6lpZuXTvL0XxIjup6ES0QdHg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:hKmVo63OAf6ZtpWlNAQ1zGsEpURNGKAxdpgWsSDaoN8=:W7f8dMgpIeW9eT273Sh32xQOaW7A41oeFosfcFEPSKw=;
X-ME-Sender: <xms:Gq_GaqO2AVovWMTAd6QkIVO6dY6YHiZYUjvY4uq2ib-KvRefoP0KUg>
    <xme:Gq_Gav0bQrDEJD1hEyH7QcEGYMbwKg850fmbF-D5X1oXYdSoBrXKEuNaYuTi3YbHr
    PxnWfxsAz6EbEy6VhDj1mWlf4ICbARxjBVeQcshkKuTvg1IOAtl4Uo>
X-ME-Received: <xmr:Gq_GapnLmUdMvRBsldeC1wrOmAaSErOVDrbG2ibuXss_Rfm4-vZtUA86m4bhoNDvHusgmpg_rxqEyF1YLa70IKjDRedqWhQO1XBS>
X-ME-Proxy-Cause: dmFkZTGh2GCjzDUNlsiBPoOAEqeSVNh+Fpw76V6VIdUvdd5xFrsbeuQky/5Xyrcc8b8hwB
    f+gtxKZ8YfnOhmuwZ5CvIUNnE2Eb0XwRx+9bqqWjj5isPdL7p96rMolYeOn/l0uwx3tmN2
    2mAC85tD/61UXeDXB637rP5ADZqF5wTDPlQluo7AIVYffk2TBpNU7qSEju9fk7oB8qYIk+
    TQSIhLIIC66xXAMLnZ1Mw3KRz1xHjSIpuEGStovX9HfYQyXCw4jW/RcWEzdPVRJJg1dSoM
    nnXlsTC02SVX8HMraDWfAoGtkSZ/9s6txDDXa7vnW5fw4ZgUvgkZWhq/BVWaLTjiuVGSL3
    lnZxfR5uRUSRrDFj4C8SyBTG3+NmzkOHyKrHzKvd7Zs81cOEJ0GGckHS9XgWRW/sDb5F/f
    1G/VTpUIBGmWHpKI1fJbw0I8q17cu0yA+/PoyjJO61aTPSCpHmHNfULCIG9LiziXNgp722
    3ayRlKo0mAArR7SkCIQ3/kR7+dxb7ryPF9ZTcgtg1NmkCoMFnbzzKoqhvdOPJOX0t7pDIF
    sOn4IYx0sH0L0HoBk9MihRPmOKSq1wq8WKza4x5/msBiz6EUFVi7XACPpWnzRgUG3DosHN
    fMD2/TcXf4zjAnT//MvzFEQfZv3jWCGMhI546IFzvTcK2UxRTk1+6gFcMKAw
X-ME-Proxy: <xmx:Gq_GamVQFI6yLA3UYWnwykeTiL3dNPK5qw-0SNKPrXUQDnm_i9IRuQ>
    <xmx:Gq_Gavu1EqekJQ146SMs3N8d1jpXWOfbcj2-UjqZS_3PajEIln_cVg>
    <xmx:Gq_GapZX12MnTAgd6foKMqOwNswb2TWyzU4x9nHW64U9BdFy6r_KXw>
    <xmx:Gq_GauVW4iNQtfHXqSMcsAdT_sBKE_9qnI5kGkXIajrE8kNxoZoGQg>
    <xmx:G6_GasntFHVlbGxRepjXXUdO4vCbCD2hG__9ArZKxzAm5RktqVQwr8CP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 16:44:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] ci: bump debian-11 job to debian-12
In-Reply-To: <20260906151137.GA328152@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 6 Sep 2026 11:11:37 -0400")
References: <20260905135822.GA3914811@coredump.intra.peff.net>
	<20260906151137.GA328152@coredump.intra.peff.net>
Date: Wed, 07 Oct 2026 13:44:09 -0700
Message-ID: <xmqqzewp5jhi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> BTW, I noticed that the linux32 build is using ubuntu 20.04, which has
> been out of LTS for a year. But bumping isn't really an option; they
> dropped i386 platform support, and so has Debian.
>
> I'm mostly inclined to leave it unless/until it starts creating
> headaches. To some degree, if we cannot even find an image to test
> again, it might not be an important enough platform to care about. But I
> can also imagine there is a long tail of oddball 32-bit platforms that
> Git does run on (like small ARM chips), and it's nice to at least have
> some coverage. Possibly there's an ARM image we could use (looks like
> armhf?).
>
> We also seem to use 20.04 for linux-TEST-vars. On the surface there's no
> reason it couldn't be using ubuntu-latest, though I think this may be
> one of those cases where it's doing double duty as "test exotic configs"
> and "test on an older platform". But might be worth bumping to the
> oldest in-scope LTS.
>
> All out of scope for this patch, and mostly I'm inclined to ignore it
> for now until we hit problems (and then decide if it's worth
> accommodating or if old systems are too old).

I am getting annoyed enough to see that the lack of 20.04 is finally
giving failures more often than it used to.  And am planning to
suggest to:

 * drop linux32 job

 * update linux-TEST-vars to run with ubuntu:rolling like everybody
   else with the default version of gcc

I personally do not see much value in the test-vars job in that
enabling all exotic configs all at once would not match use patterns
of any real world users, which may likely to enable only some but
not all of them, and for that reason am also tempted to propose to
just remove it at the same time as we remove linux32 job.


 .github/workflows/main.yml | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git i/.github/workflows/main.yml w/.github/workflows/main.yml
index b229739be8..b86568ec83 100644
--- i/.github/workflows/main.yml
+++ w/.github/workflows/main.yml
@@ -409,9 +409,8 @@ jobs:
           image: ubuntu:rolling
           cc: clang
         - jobname: linux-TEST-vars
-          image: ubuntu:20.04
+          image: ubuntu:rolling
           cc: gcc
-          cc_package: gcc-8
         - jobname: linux-breaking-changes
           cc: gcc
           image: ubuntu:rolling
@@ -431,9 +430,6 @@ jobs:
           cc: gcc
         - jobname: linux-musl-meson
           image: alpine:latest
-        # Supported until 2025-04-02.
-        - jobname: linux32
-          image: i386/ubuntu:20.04
         # A RHEL 8 compatible distro.  Supported until 2029-05-31.
         - jobname: almalinux-8
           image: almalinux:8
