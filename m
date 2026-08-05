Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C32930D411
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 06:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785911255; cv=none; b=M5muFQaBkPGeI47re3u2LNzjU83B0UdIgfMq91MPdxt3p+ym0cIqBFMybXmBcLYOV6b5baujoe+GXFP2x8dFfuErPnL6kV075dZc1XJ+InrLupdRz8r37l+7la6NTodHy/V4NnMPm9l7o5xwbc1bnDd94l3xm6etfTUxDVuqkGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785911255; c=relaxed/simple;
	bh=VfEP2vguxr1XOpDuoJ+otMWaWwIYXvRZuTShf/GnE6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XspsT4SeHi1FjQQmuK/BYI4LIsJvVkgAVsnC5GjveuO1L37IoJFkwC49p3HqqujMQN6IuCWYyPb/28WkbHtqCrZ3Wej/79yeyn3BxVRz/vcR8uxqExMzgdX+V45kJuVGLIDdzIiOfP6Yqs/7zHp8DvJqVGu0slrfaJlfL/Plx5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Djd/+4hZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CUqxwEbW; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Djd/+4hZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CUqxwEbW"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 7B22FEC01CB;
	Wed,  5 Aug 2026 02:27:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 05 Aug 2026 02:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785911253;
	 x=1785997653; bh=PVWupZr/0+hc0C8fEAW3ln0R4gcCFLUWO7GfcRzoMII=; b=
	Djd/+4hZ4DT6UCxW1Z7p+v3y3l6yMJ5ywKo9qZcWXJEB5ryAgZKLVDB/nL3c186R
	hPziQBDw95Efv6wPoqcZBSQZn671MJRXXrfvbqEbDfHT3Q640irBoJp5oB1O+30j
	bgRjoGjJA6t8vcTPomxmElTY+tsn/fSJ+aCArn88i6rB+yXy6/xx+ylcXvgYsyUB
	5bgoPKdRtJdi5Z1i0dOtc9CjfQ0ED4j376Iqj8qGY61qCUy+zLShA3kitOnSLnBz
	WscwTVinUmNvO99gOZGbMt5z1nBeqWxVzgqD/QFNYTXpUuywhpf43wwn3m+SRqx0
	i7JcvpOabxK6UL2tzV+dSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785911253; x=
	1785997653; bh=PVWupZr/0+hc0C8fEAW3ln0R4gcCFLUWO7GfcRzoMII=; b=C
	UqxwEbWWNVUx59Fa5z7GIAxJ1s2wx/DjYHDtvFeUakKJGGCT0b4jXiczUXJU9OEt
	rkZ0AU0TnOr7eNeqpMhooY0JP8D++z47dJuSi+zdJBWImWAKzD9s2iqfj3WFimU/
	fDKNK2WVkQ0CXFcQiBhZKXcaAuDGE2mF6Y9m24giLDjQDOnuCVoQ5H2axWpxd5nD
	7CKw1IOSqlfrmH8EJcZkmaiA3SVn7M3bStWx3WpFpeq7B1H0jXEP1Gy/+bJJ1tn/
	dUJNhaYll2i8avggDfVyf9VHZ8RvK24X4S7oiuCavG4RYDqnLqsa5ezU/yIUtFx2
	DWDuyHa4LjiaLzaDZcv/w==
X-ME-Sender: <xms:1ddyajcg_GzPV0EJ0C3E5KRmUkrlnDaeOLTGiUsk7RSi3ixhZT11AA>
    <xme:1ddyagoZ0QI5tbFNMC9KJKJb1JFU7b70nN2UttGPzoQMbiJBFe_7XjD2BXJwOqrRp
    Zk5KCBzdb1I7dSbE_APYYky2tmDPDdIiFbruRWm-b4uYKLBaY_g>
X-ME-Received: <xmr:1ddyap6tPAWGdyLaqS3SmoRQ3tkkbE2sVz-Ei500mmRbMwZKaDZr9oPkXgQ0JauSeIwouMVhNBt6npFTE6vIzdaalg9mDUdgCGZ_2b4xyQ>
X-ME-Proxy-Cause: dmFkZTEgMqncQcGRjuWQ8dnY9exM9vJSTQ5+Or74LBB9SpPYYfuJylrVS60iRj6lYyvuXp
    x0IMQNpHBRYvbTCzkHH3OO5RvtNrNO9e9kbP5nfLBWdd2fidEl2o1mjBQwSGysghA7Y7+/
    E9GqhPz9H16sFg1ikY/jUILCd3Z4B56Q6CFBxISNf8GGxVuVY5RWO4E7cf2puEe2JAhfd8
    +NHijUT69prj1tYD7aibSipazPTFpS8QcVun35If7TPk1x37ushHCejs5M5MCgVP5yUGpQ
    PnxRTJeveyL1A5zXZUU2GB3uLDNRXKj4TqY6IXlFE0yzOzNj3wuiwiReQJFc+allgSYEYJ
    0HBUrlHae18AUTRwu4IGCN99TraZFHg+RXcoK1T9QVcl0R4DU/ECO4UfTxaOyRCSWprjOt
    Tlyq4RX4fpmnwjOT8xzVwib+6dsf1TtviGchSvhDaXe8VpykOKJGObzMr/OKssyniVTItV
    YVrTNAr6UGCSkZxpG0l+K+llG5V2kAhlY22f+mLCZXlupGJXbVcNYgW2LOkpjovIhpKhbU
    AyRM3w7fhwPUuudlkps+gc7lxC/TBFzVvZ0zq2lYK0aN9m3ta58gSpLGRYcZ5Jz+V7t8pz
    iyHd2IO2X9hYXbOoWG8IXC7ti3AAYXL3GLpmqJ6ghMSO8pLoTsm3iXgnwO4A
X-ME-Proxy: <xmx:1ddyaupjRLmnmUVLrfAAQ0i6Z-aIuiqu2baM4XCD0cnejTZnDtI-lA>
    <xmx:1ddyajhC_MWPHU6zDSqjC0B7aEVdpu0CJnIFQYIA1EzwrHRRVxXSmg>
    <xmx:1ddyagIDGJZqnAGEO78aPP2lQTmb2WfzUilAvWtiQH71uSpa9sd5IA>
    <xmx:1ddyarAdmGqc9LVn0turo6fmBfV4275Igzsry6LOsfE4e-hPb3tPdg>
    <xmx:1ddyavHx3UQQL_TNj37YBxujGXO_9HtmyTmLo-PPV_JO_IDFCsFE6WkH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 02:27:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 53203ac9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Aug 2026 06:27:30 +0000 (UTC)
Date: Wed, 5 Aug 2026 08:27:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>
Subject: Re: git-replay/git-history lose notes
Message-ID: <anLXz2vos4zbIciW@pks.im>
References: <CALnO6CAN1=dgRsYjABfa3CJkGnvb139EcrzS9EnX43i3szOgtQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CAN1=dgRsYjABfa3CJkGnvb139EcrzS9EnX43i3szOgtQ@mail.gmail.com>

Hi,

On Tue, Aug 04, 2026 at 04:06:38PM -0400, D. Ben Knoble wrote:
> Hi all,
> 
> I don't think this has been reported or discussed yet, though my
> apologies if my search skills just didn't find it.
> 
> It looks like git-replay and git-history will drop notes (or rather,
> not carry them over) when rewriting history. I've seen this both with
> "git replay --onto=… …" and "git history fixup" recently, though I
> suspect it affects all the modes.
> 
> Fortunately when I check range-diffs before pushing out new versions,
> I notice notes have disappeared and can "git notes copy @{1}" or
> similar for a note at the tip. Recovery for the intermediate commits
> is a little more… involved… as I'm sure you can imagine.

This somehow rings a bell -- wasn't there a recent discussion about this
on the mailing list somewhere? I might be confusing it with a different
command though that's loosing notes.

> Are notes out of scope for replay and history, or is this just a
> "nobody's gotten around to it yet"?

For git-replay(1) I'm not too sure, as I consider that command to be
part of plumbing. But git-history(1) is a user-facing command, and
because of that I think it should handle notes automatically for the
user.

So for me at least it's more of a "nobody's gotten around to it yet"
scenario. I've created an issue in our GitLab issue tracker so that we
can maybe pick this up in the next release cycle. But I won't complain
if anybody beats us to it :)

Thanks!

Patrick
