Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3C138B15F
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 20:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776286247; cv=none; b=j6QNvVmcLXEXEbn42v3L9vBAcLsMbEkWOMNkvDcHRoFEi4TzoqE5fTwBdw+wA95nzPS3wR72TiYuXUMf7UWwRxh1ZRsL+QaH14CrufIcLtoLRBjVaHpizQSa7IQ2t2Xn25ENUdkM1N4o4hP647j5DdR8p5AbEa5/QuqmWfweCEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776286247; c=relaxed/simple;
	bh=IVogQCQ43nBPlSI6KNindGGBSlP/vVLHEaoZd1q0+M0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=M5JNRwhddnYfQZ+LdfZ+xzSztW6sH9jRDOy9liA/dg9y/Hzw5ZvPSIE6aOuor01+naG3jY63lm74opvVyRtcvW1XJnyjwoptx8WsPb9uN0RXRPXaquZ8ohcydoTMX3bCGmpyQMiB+22+MXwgI5dzb/5qTXP6DlDSd8g9Q+O0xUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=Nf5zQZsc; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="Nf5zQZsc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1776286243; x=1776891043;
	i=johannes.schindelin@gmx.de;
	bh=ADBGWxux7oQnOrLjNLRgsp/ifPqrYVbRkhvCISFCq3o=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Nf5zQZscELgYtfJaiYIJxMoiu56r0oRs3GO90ITmFRgfnZ1ZlNuK+93vKVmX44yj
	 k+HAVZnV2cwYnAOLD1CKC4CrnAO9Z3DHr+9fc6+Z97aMpOc2TbVoA7i91uCb0gYyb
	 Ap1mxy49uCKtYgOkOawwlKEv2ZndydBGC/KVBzZKeRYyhGswL9vkUUDEYzlKOKzeP
	 tow3/4heR6v9ElQcnjKmia/RC7DoOl261amnOfv4xkTQ1kUyrbW+B8rjE2oYc+zRQ
	 2nd4++2MM81fLFFQznMkwCRyhpcW6ILkIHHyp0dDoOaDE6157yttGg7ypxB+VPQqQ
	 hhfF/RHLp9iJY3ZORg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKsnF-1vrrzC2PrZ-00YlV8; Wed, 15
 Apr 2026 22:50:43 +0200
Date: Wed, 15 Apr 2026 22:50:41 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: git@vger.kernel.org
Subject: MIDX woes, was Re: [ANNOUNCE] Git v2.54.0-rc2
In-Reply-To: <xmqqqzohd0sh.fsf@gitster.g>
Message-ID: <8c1def10-9039-aecd-4ce4-fb4676b47e9b@gmx.de>
References: <xmqqqzohd0sh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:fvlOZTdFyfetmH1ZxCkV8KlvwbXR3HdrPKxAMIkkoyP8yz9qUBE
 R15Q30ZHSw/5LQ1T11Cyqn3kQ1I0juqebifenj1+BDsP0283jb2ZlnmLpeZCGysVnmU7CRs
 xer0yUHgvoawZXhQRX4xCOtU4v3vU7f1SUU6+juMsN1gy15QX5xpp0YwpdYRqj6ykEtdnOX
 wiznViIFSo3vLbeyb0TfA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gd2QjurY3o0=;qohUkHlHgWj9BsxbN9ndb4ykURK
 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
 qSi3VU3kunv5ZAAkAxFVZo3Q==

Hi Junio,

On Tue, 14 Apr 2026, Junio C Hamano wrote:

>  * Further work on incremental repacking using MIDX/bitmap

I just noticed that a fetch with v2.54.0-rc2 into an existing repository
rendered it unusable for Git v2.53.0:

  fatal: multi-pack-index version 2 not recognized

Is it possible that v2.54.0-rc2 forcefully uses a MIDX version that has
_just_ been introduced?

If so, that might have been a premature bump of the default MIDX version,
if even the preceding Git version fails to handle that MIDX version. It is
guaranteed to cause substantial problems in setups where e.g. libgit2 or
JGit is expected to be used interchangeably with Git. It also causes
problems when users have to downgrade Git, or use several Git versions
side by side (e.g. using GitHub Desktop, which bundles its own version of
Git).

Ciao,
Johannes
