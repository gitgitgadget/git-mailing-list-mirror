Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B0653F6BC
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 15:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792079561; cv=none; b=bKLXWka9oy5XDSnjl6H56ayaF8QG6NTkkEwXAexG++64U4Nrrk0fJhZTN+zVS525IZhLJDSjoUrDcZYs3SZLHoAkFS7fQEKfirdUnaxBLlq7+5gqil1tnkLUdTs2LFNucUMRpilzIXtnOvwfw3q3DUoOwJE0zghu3lz87ZdZg6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792079561; c=relaxed/simple;
	bh=U7szrJ1z37DlirgDD/an29+7eBc4h6RAVT3FWTnVEkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YABY9jXRQkt3AvPb+4APdMJekKxVvAvz61S4z+GW3h+HcjJZaZoAG7DUFaSRZWB8uEqkyAcLOG9jHyWfN0vo8EBcR7RMH1eYsBVeQ0zBA5Dgi2ITZciEV8wgAt1gtGondTipEVsxmFQnuD/2j/VsJqHDgRmlFv7w7dpALwnNx7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uhrLQaas; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kp845AVL; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uhrLQaas";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kp845AVL"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D31991400144
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 11:52:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 15 Oct 2026 11:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792079546; x=1792165946; bh=ztU0szJCwU
	lrhz/Rqr+iexpX1wLE3bO6gMOoCWkIvJM=; b=uhrLQaasbRg7ZI0QxWAM2cQjbw
	IouYr3UkE//lI2lSU0gTaSyakM7UeCshX8Ne39ijz3OvPzo6KKFmhf0FreG/a7ee
	RopQPxW+CyyxHrXBeIJNCm0nAw2OlXAhHGy2vLCQOWqUq/HCjoAkwqzHQNaBT7rn
	vDeLG7zYNBEhHFPDdGX/sHgtOW4LRw4Z061uLr1HlNTZ2pAGoHVCLM2rOsp3/v32
	GbuQ6nvEUrx+4jcD4tUQt5In4w3wqWcI8SNNA60ee9uHMPHc3bOppZp6p2jVh46Z
	evFEqNwjCOCh2pbmn88O8B6lFw0cN1S0OvZ1Vewos1agLOhDJ08PEWdaMJZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792079546; x=1792165946; bh=ztU0szJCwUlrhz/Rqr+iexpX1wLE3bO6gMO
	oCWkIvJM=; b=kp845AVLSDhBj8I+xXCGxfy6MjANnRaLd90TXHtzUu1CRKcqtk0
	VCXaFoMT1we1bMuDKsUT8nr+n3lIfBHuTNrqxYiPbfkaHkeyeDUg5q+pHUVMvAM4
	H7dG60jshouzsTyI6cT1gfnV5O8tEwz0yIZQTYVwSOdaFDPc4aah6A9ncrP4Kq1+
	1B4vXWOEZkDo3ihSPLzZ+qZZFOyffX3fK05JopPWARqd0SktKhemYqpSg8p6tS/j
	TmF+8sIsJKqSDf+X5MUK9N3KQbc4F2IXG6YvLDQdDUZexvEACVQ+xc1nCgQOPTvq
	VFqhAr/+dIWx5AxnaTJkgkSrF+AM/11D0gQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792079546; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:PxS4bO6ZA/zJjij609lUeaLnhMmiJ5IcDC6BCnNlkr0raOP
	qF5D4dMaPouu6uYIgxQApO2KCkLrDL5mbyE0QVLFHZLJMdGj+QKVPlPOsH5K31cY
	3Z0PU7x0gvB1u0TT5w5TEO/IYlS6BOw5Nka4IE7/+qYbeUiZ4pig0y8NHQtf5u88
	kUuU9/tzzhPzHVDpVJQgIGqYS90PaVZU+ZEfyrQMd9jrCWIrKeLbKCos6uiBodQa
	v+wonEBT40lZcnz5AphI1LDe0Q0Mt/VTrI7VViKyS/vg2LWZ3S2SuYRvQfpu1Gh2
	pwW1Yonv9NhGsOmUS3NlRd4siDQA52EgliJ3CHw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:caRbE0B9uHUyvv/nGxDtA1Wt5Zi3e1rEh8MzY3ArDvA=:U7szrJ1z37DlirgDD/an29+7eBc4h6RAVT3FWTnVEkI=;
X-ME-Sender: <xms:uvbQarqZFWvgjbjjdkweJIUsjnSaIJUp4poGVUR4WsXU4bZ7EZXR_A>
    <xme:uvbQatGHmbXC-jc1286iTI3wtpffNtlTyKOXeZghTYLv2DQDLG_GYN9IgQrXw7543
    8OXs1ND24a_dqn_v-uoct0tInyXrkqftnsMrsKE8pk3-q82tZTXJVJQ>
X-ME-Received: <xmr:uvbQalmijulPoOm8JMnqtveTEudawrCykKEEJnOQSMxSrdUszhClZ-UiVBpmrd_h-ERq8Z4>
X-ME-Proxy-Cause: dmFkZTGTpkdlDhPibUugeOOuF3Ta7Emdo/zzt/QjxNsW0MEKTqAvR6ts+RPfo1LlwIjZZu
    mGU5sOJ5BCBcsAQcboJZ8IorPsf12JuX4slI3ebaeb2Medl+kMuZafXKbRCnITpeCdcsiD
    BB4LTUnLnRnBtdEssLuhczq9dTaVM1v+GtD81pAUgBqcomkAm8xBDpgaKX4JlzmwUymKQU
    APiFN2zW7tmyH64FSB7XHtvWeL0psPWD9UaU9HmM+Tbw8o/JstzSbrzZNuWdhKjZB9NALV
    EG9lRc7l/f7wOD6FEBuGxrl6UZSoAlWAyerNCyYQ1aNqKUGxJMnwQD2tE+N6Jw8+TWg2kV
    bop1yD6wOUABVxhEUeug38e4iFDnMptSf8IRVIC5r+ULj8svmCieyK+rWsYrhqFHIAhNqs
    eT1aTXsOCzFKsRflTtlEvzxgs4fjqje8RVNtnagN6TFTk/kK/ls5ciHm7ZIAkmPVY5sAvL
    JJY27f+CbYJCUoleLHntK0IL0ZXX3pyCqevcxsb5UbIB7oLSzQ75zrkXVARmMls6wlB/LY
    E5Nk0B49Lhs8rO/dIDvy0YdXrjL7NrNQk2NZF5OWCXMeXekByF3wemWRryYNWdfL9AWofR
    AhsUJPDVckR9vnX53DbGY8b+AIDdA/0Fkf4fcs8ThX4Q+epoMnNON0ceeNgA
X-ME-Proxy: <xmx:uvbQaomZbVgpnUeXJ9xpDX2SROpxL5d32XLdzZQuXW35l1Z9-xs9hg>
    <xmx:uvbQauvwSOFoWYpQIiGpWe90heU65K8LKWe2BzKNjPhVS1sT6DOsVg>
    <xmx:uvbQajk3t2GMcaHmalhMvOf2T-B31qUZg9i3YGpw5hsaHYlwEf5Edg>
    <xmx:uvbQahvD_vpcR4-M_-jx44H1ewMT3vFSlrRLIYxl3cYXt3HfNuV-Tw>
    <xmx:uvbQalHBn4f1sVdmvs4Q8Z-qXFZ8_f7yAxVmyP4t406Sg-nyjEUcwfRq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 11:52:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c6ddef90 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Oct 2026 15:52:24 +0000 (UTC)
Date: Thu, 15 Oct 2026 17:52:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com
Subject: Re: [PATCH v5 1/1] repo: add filtering options to "repo structure"
Message-ID: <atD2uH1pPJxH7pgR@pks.im>
References: <20261010150539.930614-2-markchucarroll@fastmail.com>
 <20261013172849.1109478-2-markchucarroll@fastmail.com>
 <20261013172849.1109478-4-markchucarroll@fastmail.com>
 <as9yXVSdEh526Qi9@pks.im>
 <DM5HQ9U1JWFE.28OMPLQUD2E7P@fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5HQ9U1JWFE.28OMPLQUD2E7P@fastmail.com>

On Thu, Oct 15, 2026 at 10:44:13AM -0400, Mark C. Chu-Carroll wrote:
> On Wed Oct 14, 2026 at 8:15 AM EDT, Patrick Steinhardt wrote:
> > On Tue, Oct 13, 2026 at 01:28:51PM -0400, Mark C. Chu-Carroll wrote:
> >> diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
> >> index 02cc2b594a..1d25ee14e5 100755
> >> --- a/t/t1901-repo-structure.sh
> >> +++ b/t/t1901-repo-structure.sh
> >> @@ -140,10 +140,208 @@ test_expect_success SHA1 'repository with references and objects' '
> >> @@ -186,13 +384,13 @@ test_expect_success SHA1 'lines and nul format' '
> >
> > I'd drop these while-at-it changes. If you want to include them they
> > should be part of a preparatory commit.
> 
> Will drop. My reflex is to change all instances of something after
> a comment like this.

I think that's not the worst reflex to have, but in that case those
should go into a preparatory commit.

Patrick
