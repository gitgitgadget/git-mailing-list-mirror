Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CBD64A8F
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 19:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732303574; cv=none; b=QoWHr5M61JSjTbpwRX9JmzqCTIK/Cvb4kNnLtapMYoHN8qL1yxD7Bdmr7MFCy+6FE3pETo2joEJVtP2qK4hYFGNmn8D7CzM3H3CGLiF41i44QaReTYIsUrETr+RNRJga//O8mBx5czYqccvmnBQ4VjG4ujJZd33yAQTON0cHbK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732303574; c=relaxed/simple;
	bh=lYr1mVYi2FZcONPBS0EOoNKKW0WKPg+4YHWdwXdLJfw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FuSFIAgYUUmeJ5OST0vLDw8RgnMw+560dtFQiYG1QNK9755JVFimF5Sr8E5jHIcflN95vOoVV/GPvJYl04IOTEXHBJxOXekOAIxq2RsvEdfuxUHR+U8ba9YNVZoQ+ykT+P/beittPlO1yafXGHItwMN5QJEz53Uy0WIMslMIh7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=GUa86QVZ; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="GUa86QVZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732303564; x=1732562764;
	bh=lYr1mVYi2FZcONPBS0EOoNKKW0WKPg+4YHWdwXdLJfw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=GUa86QVZCg6j1gw3KNHM0J8QDrTucoVvpthMsb+8ZgKZGpjtpKB3YCBKXCn3CKiOH
	 DsGAhJpnH8PJe/lk1wYc7bPfG+6SyrAvbZaFJpxtwgwJof2hb8SbRMHQl0lmKmAgqa
	 TxZFU01DMkRA3B6ya8E27M/9C9J4tSQNHbzuK9MQvT2vpgqp/LP4mt+UiZ2rfqlKpS
	 HOmyhaaPz8KahdJxGubUote5diAJTn+XPTVUL5IPyOgSi6dSKDjtssfQ+OIpqli2PA
	 Vxc0eWdfsvj1asdRXY0cvaR99OuXUzIXoL6fsDDwueckib4pi5pbfGNlj2V3Tr6mY3
	 T9HYkm2TrA71Q==
Date: Fri, 22 Nov 2024 19:26:02 +0000
To: phillip.wood@dunelm.org.uk
From: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 3/8] worktree: refactor infer_backlink return
Message-ID: <svDK3f3yQtR2snjDN2RJPcvSLOV200EFlIpOhyyk1DfgPI9EYZzH9Um-GcnCcZuwbZ4u5V_khXizC-l1cOX_aahBlCDWPYjpdkYJfr34YBU=@pm.me>
In-Reply-To: <18dd2d59-aa12-4921-bd2a-2bbc0027c63c@gmail.com>
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me> <20241031-wt_relative_options-v4-3-07a3dc0f02a3@pm.me> <977c1e75-1fef-4827-91ae-cc1a6ce7508e@gmail.com> <D5QR4BHKBZH9.231NGDY7RCV0L@pm.me> <18dd2d59-aa12-4921-bd2a-2bbc0027c63c@gmail.com>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 00ec066ed19c5b1c36ff478f98b7d5ae1b5badf1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Friday, November 22nd, 2024 at 10:44, Phillip Wood <phillip.wood123@gmai=
l.com> wrote:
> On 20/11/2024 05:20, Caleb White wrote:
> > Originally this function was called inside an `if` statement, however,
> > another topic extracted the call to a separate line and so this return
> > was no longer used. I decided to keep the return anyway in case it was
> > useful in the future.
>=20
> If we don't use the return value I'd be inclined to leave it as is.

This is being changed in response to feedback on the previous topic
(which was merged a bit too prematurely). I would prefer to leave
these changes in if that's alright to respect the previous reviewers
and given that I've already made the changes.

Best,

Caleb
