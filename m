Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FB44772AB
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 17:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788198075; cv=none; b=oci+CFlTjDEkXSI5/LcAm6cMCkeJBuJ4/D1mOB6KwSzbV1MTZWcSJ/WBj7VEZXTgemtrX7Cc4zBVWQtvYbDJNQH/otc4UhIqfqFIE7LOSFHpI36DoMv22R72yVwLh35nf0LrCqUrxDnxin7GYjoHr4dTFzE87e7KK+YVdeNiZt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788198075; c=relaxed/simple;
	bh=JBgPkJ2coI1RZ0+3z5oq0MIe4ewDhesbRXSrwOGRgS4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QgxF5KN/5kPT83y148A+4LR1gDeGItXbBasBc/U2YMxqDHTkq9JPuJd9aUTUCrYRtnVApMGI6os3o5Vxc5cm+dspepi2MguPY9KdcdccydVcEMnwzXnjLYwOHBTyqGLRv/5rkbBzPCL3uPMkMm7eUc71eI0pzFTIpq9bjF3xgF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=q6R02Zms; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eTO7PXjL; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="q6R02Zms";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eTO7PXjL"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id C11A81D001E1;
	Mon, 31 Aug 2026 13:41:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 31 Aug 2026 13:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1788198072; x=1788284472; bh=0Yj2ewj++x
	pior+6LCvdkzLh7J6z2NCqEIyzok+qwlk=; b=q6R02ZmsFkdJxBDMcDOBiHys0n
	pgRDLpjvBOKfkYGzLC12nhquOl5AHpUNyWsESeWS97j48cFZ4oTnDpzO0ONcHx9W
	sU21chxse3u3BcN9i7picCSzP1imeJoRjkIFhtiVJlHPSu95IiVH4isIosKDz0wl
	rNulVCOYEyluigFc03CpEsPWICsKwkBChmXOPR/vt7E/WsNRqS8ooJ8dezwDcNaF
	YGzcCeMsWCJASiOmcJX768rGU9cv5SmX8CquoIHXzZp0XFqdE54diOH5znLA3SVw
	UKbqF12gsnDuJyp7G54GU6DD3/3A8P4L7y9POrAZTTlcnb7WFxQ463Kyc5xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788198072; x=1788284472; bh=0Yj2ewj++xpior+6LCvdkzLh7J6z2NCqEIy
	zok+qwlk=; b=eTO7PXjLhTtlPkNaslvxgON81UGAbhv5SfxXQ9L48tkztfYWWeU
	y/jMlule8TR6t6unKOj087kf6aJwATiL+fXp3BOpAzN45wC9KdOJQ4AB9oSi8aQb
	IKf9IgE1pULfDtArDRMzS9diPR09iBRz8HhzwMuL9B7H72APK96nkaP5F6aHIC98
	9Wyd4UVUQsfLYtbBaGhUttyHJPhZ+omBLe4i9NhEKxhh7utQTL40su6R0LJhwm5w
	ngR5ThE9ZOALo747hS+Du9wyRirzwzkGIhA8mEKRkyeQxmMCcG6lJs/XVQeT1i6h
	GVUHMXzTtpnxaD02ICI+V5Ne+AE/Jt7WDSw==
X-ME-Sender: <xms:uLyVajDQqkjLe-x6s34YxF5FfjDJdDCZVn0qFi0t1uIngGVBuf4VyQ>
    <xme:uLyVag-816UpdUotqUqE156MjHtRsvckdCpZljDDiX7ihIX6BexVW6JJIcCfATIST
    6aqv5n1-MlpZ9HbfPJsX9HfTAK9qG0G0sePZ6ukBdMT25hWq0QFiQY>
X-ME-Received: <xmr:uLyVar-UIgQf3wH3zpSV7EYHY4EEJRRhgh1WTHUDjSMir-_ROSt8be0TPsaha7PiZT7bTkklj1w0xvTsqlPUhpBRG1izT6FktQ>
X-ME-Proxy-Cause: dmFkZTG0sPzj1aYfdznY9vT7cpTN2LQMbWtJFHcqV2I1NRxtq2WbQIbtgPQUP6G/vHmbIA
    ldXlcFfF9yNAyMeJChBi+6yAbEnvZRab3BaQa8D3SzDG/vDI2dHBIgyn75gw81dcLwB2GC
    xPTaB9U/GYDBRE0CoMM4cb2n1QoXP3QAZ9vseAJkJ9e6biIhaLTBZI7vclX+yZsAw4/1Qi
    GNHSBa3thYnn2BL6oJLtPkaH4o9ud7X0/qF8FYIVSDY9n8cSSrzdUpTI7dm8sgNHy6wCTk
    kLsivuoeoJotklKoSqfx2pxa+wXZaDCe8EUo2d84PcIpLUZ77saq7KwSbK9rKdLuQyA2j2
    QJUmwOKKE5aj5xwHECuei6LSUe8jB7oP6tHXKCbwWNZFal5HVA1SnW2kWgJ+MAa46nsgqo
    5Ti/6mE0ViSxdOEzwTNEJT8BwQjMibjLD0DQavcJQWVpKJL9XZK+2sBaE0+M7GbJdQpe1T
    g+nHHseKQY/88brY10UW7bCFtf+Fw3zJo5co2WHCkdQd0gqTavh6wgy8jvRB933M+91f6l
    cE5qkr0PcSJW8yqF4Aq5i1fbqICDKGsJTRt2864w4Rsl75UzrAtNibAYrECtI9vltkgZ08
    H1IgAAbybUxfeDYoqQWbWDVbgPYqNGMSZAqboe0kI6j4ZxN8uE1slYfDvsoQ
X-ME-Proxy: <xmx:uLyVavdyO3_PLd04HIKEvRofC1H4SDRgaxOwa1euM0nBYLWKOPiqcw>
    <xmx:uLyVasFYry2CmoFH3oCrETPmEXD5941Z3SVAOuIL-c1TDLBsDoQLOQ>
    <xmx:uLyValex4zesGjV1Hvrq6Xpw_d9O9j-zsjnDxUIWaV_JBHay4w90dg>
    <xmx:uLyVauG1Tbm5PxnCxTuGn6PUourDaP1PEw_s_XWM2C2RBtUCVBVocg>
    <xmx:uLyVag9vFElt-dWVtRRLUYrGk4d-Fwpz5d5wsFm7k9pim8M1P1NnCNgL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 13:41:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Hardik Kumar <hardikxk@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] typofix: fix spelling mistakes in comments and test
 description
In-Reply-To: <20260830-typo-v1-1-d397c8dfb301@gmail.com> (Hardik Kumar's
	message of "Sun, 30 Aug 2026 19:12:35 +0530")
References: <20260830-typo-v1-1-d397c8dfb301@gmail.com>
Date: Mon, 31 Aug 2026 10:41:10 -0700
Message-ID: <xmqqzey2w5l5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hardik Kumar <hardikxk@gmail.com> writes:

> Fix spelling errors in the following places:
>
> versioncmp.c:           "fractionnal" -> "fractional"
> git-gui/git-gui.sh:     "occurence"   -> "occurrence"
> t/t0022-crlf-rename.sh: "similiarity" -> "similarity"

git-gui comes from a separate project and a different rule applies
to patches in that area.  See Documentation/SubmittingPatches for
details, but the consequences to the rule are:

 - Any patch to git-gui (or gitk) would not be a patch against a path
   inside git-gui/ (or gitk-git/) directory.

 - A patch message to git-gui (or gitk) would not contain any
   patches to other parts of the system.

