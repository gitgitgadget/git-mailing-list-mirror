Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113FD47A88E
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 19:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791832845; cv=none; b=qMy6Y2Jr1jSYhIT1qqvr+ZGpOch3nFpqTwXHcvTbCOFggs93z93qXyTNYsxCIyeaTI4oJcdjkaRisjJrxVx2Zz/VINxxyTLRAVLwoN0KWFi9iOEA/gHf0qj66tEPDb77Piv0pOufu/o6KAGfIEE3PmJkLv9QuSIn/eXT/TCaNco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791832845; c=relaxed/simple;
	bh=rg6PRDGFvpSbu1YRY177iQ57A4tDFZtdbLotI+zG+Cw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fb6exov8sdTxj1Ir0hVqYgYJteK/ADOqxucu4hDsZ6MrJVexlZkEyxkUNEvy+MiVwOg554TucHaaJiRjkgWalt8zbAEkNCGe9am/ZCpgDQnfAFfITmo/TLtO/GATU11FnSC4yPlBZMvjEIYHG1Oc4poqPhPkCuS/i+Kc255MW48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oOTseVpD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZuXngjq7; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oOTseVpD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZuXngjq7"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 536AFEC080D
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 15:20:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 12 Oct 2026 15:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791832843; x=1791919243; bh=9IZccoZIFV
	0v5hYCQSlxKrBUyOThQKuEImAP/nZWCAc=; b=oOTseVpDM3nlGSxDRVYZQDz03Q
	HaCMv/F7/mKrCUuUE/Z+Rvos5fDneEmp0tHuRqU0OIvJcAbwApgQ6aPlmc50DYZw
	iuOtwRBl0z9RWX62EragzYV2n3aY2VQUZct1WgGUDtYAjq+n5XwwYPaROYJ+Wd2C
	Qi5/+ppXnUeHR6a9TUh5CtDan1nJg52FTZJ8okt9AtQUXDuZTRdBjqP7RE05XMdK
	27yaIV75Rd8keH/32ornuAc1xJ5ucH990dQ32tliXnL0a1Lgyg/1GvP6DRNaC4i/
	gphGvtBiDiLNDkF+pPuWqt4EOAO1WNZfldFJbnkTINzi0s9G8I4f/cf5inkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791832843; x=1791919243; bh=9IZccoZIFV0v5hYCQSlxKrBUyOThQKuEImA
	P/nZWCAc=; b=ZuXngjq7AAHn1uGEXzOsyrGHMJ4UV7Duz5OBfR4WIXgBN6PzIct
	tGpOF5iaEET6tddKBAnjiA29i1uBaoumvgG7lVLdNoqaSrM22zw9tIIt34VbmuGT
	no/aXvOLb7TTEbdKlKdKyrahB3k6O3K7pSQiGNU9em//db+BzjlF03AFGaCn9DvN
	fqSixcuv+r+5/ouQaLRdpLj/rvM3YvHV+4k5otm3Uo2rcYybQMvbQRPkMsfqeTM1
	zMUfDEaE16TOl2wVUB3IJvJxLqNAAWyWMCXnxRgjfK/rzma0qyaZwRsR9XmfxdMd
	tE8fDj6TvemALEBnebCBW9hjOud3LnxD/RQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791832843; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:pa02KVIZm2HAITcO019e/WEWUSriO40ad1b5hMKLajOGctY
	PJQUI6Oh/6zBML8hZviu/GQN/VQPKyJTlFVLK0lBXkCDuYX0Vd5UQ42R0YLuGmDj
	BJ5LCn386PxRhQNwu6gePaI7p6A73lGvGMCAGoAWZjsxT3y6fhvtPuIUSNu/qYhr
	OYBY7USGlYqJ7WBfcW7o09TnXIJiAVXsSxNs69cnY7R08vH0xvbP8CVoNlsW4Rco
	s1gTwFMYfBanXdeNvXayVw1T6l36cC4GM15/CwBoZd5uz9bc5Zm8mlZfpiN2QuwG
	X2WCSiZIkI5QRUBtqJ2OPw8ZxdMaFahNRyJiv/w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:nyRkoM50BpkdSRRbdNHhno9kLhvjk+ngJLtY76A42GA=:rg6PRDGFvpSbu1YRY177iQ57A4tDFZtdbLotI+zG+Cw=;
X-ME-Sender: <xms:CzPNapbvtlaaV4GYGJvwfdkU52EM9_FfMcPerXc1QPowJRaD6Ruumg>
    <xme:CzPNakEI3jDD4W9BPvTav1qe9-EeV7M8hgILmeUzWtK-xMCH6Cw4SPhm5utiL3dU7
    WY2_eCFYv57yPV3RJJ9flVDyUs1z4blYOGhbiiTOwJZ9oza52GsLUs>
X-ME-Received: <xmr:CzPNalxEo4wc6UMDeDlQp5qDJNGPVprH65Yx7i_TFu-xSl_QrorNFFcXZ6VHkn3WyLILzTUErzDXp3kerAEbmKtMqv0qdjYuKmgS>
X-ME-Proxy-Cause: dmFkZTEjqq/7hcbtL/q53nsBua0CeWcnX4a0Z7QUmjUFjfdMXNbV999halqZzIMI+LG1Nq
    FJRbAkVTibB/09EJKlDDQYDAchvZhe6q3JmxymcvGRe+h3jNrC59wlEEiGV9dh5kxXWp7U
    eXqzWQaFhDT8x49PupeeoCuqTdLsfdjFz/IgiIoHWjCLnu/VtAm2qyyXV1cOhiUuK/BsQL
    H/p0I5x9/R90FwhXfkZWTTu/yMus7AxkOGBL1pN6wxJIGszwZdxC3D4YblI2LXWsSgvmE3
    yeXr1cT+4rdUibjBSfw8lKuNvJCm7joTaCSpJ+b1mikGLzv/gi02bGCKdR2gEEgKWFBuPc
    Mus76NTZfNlR1pfHp4+y4rHDkZSML+mtx71L+rv/cT1Fm/lxQlbvWrXiZtPhQQ9azNNEVg
    RJlpegeFYgrMgWhtDC0VCNePNbJ1famvKlpC9dfyLt27ve5JFNxEZbCxxbdgTTPW/9ADG1
    BpU6+0yXNBC1qIXLPtrZ+r/LWol1yG5s+idg1Tb/CVLlrclvtUSmz2oIQutiL0JHIarbyD
    unerZEFQEWMlKS01MZ4JHfYjeiJgytlvVlrA5Hv/+dg0gU9p9/c/Nl7NHfHGBzMwt4aOr4
    L8KUqxaBkPMG80msFy2RFHYwR9KEcWxphILeD/uNylByISQQahzUqPyhrzyw
X-ME-Proxy: <xmx:CzPNaukyrEFYRuFf8X_T8ZF0HKOCNIn9iCNFynTBCIlhPkp65tfkpQ>
    <xmx:CzPNamnSUA-IEDIMTXmQaa6RuKyfjpXRXsREiABjAd-pF6X2195_Aw>
    <xmx:CzPNaowLcLgq750k8oj65BW9EmY-exApiKc0gOn5sD5Jb2IAbATa0g>
    <xmx:CzPNajopLU31hrNqGz7G0__wCVF-Le9Itoh_Isk_urwa0Vg3K3athg>
    <xmx:CzPNajG1R1ubwT7uE2ROsb9fcQEMBnz2plpTeySLrIUerRkyOqDDV3hI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Oct 2026 15:20:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Isabella Caselli <bellacaselli20@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Ignacio Encinas <ignacio@iencinas.com>
Subject: Re: [PATCH 2/3] t6500: get hostname from "git var"
In-Reply-To: <20261012015846.2649843-3-bellacaselli20@gmail.com> (Isabella
	Caselli's message of "Sun, 11 Oct 2026 22:58:45 -0300")
References: <CAK4AdTSnaAOk649a0GLe1M9C+cYuDa0Nwo54=HT47R53Q4ZdWw@mail.gmail.com>
	<20261012015846.2649843-1-bellacaselli20@gmail.com>
	<20261012015846.2649843-3-bellacaselli20@gmail.com>
Date: Mon, 12 Oct 2026 12:20:41 -0700
Message-ID: <xmqqecdu67zq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Isabella Caselli <bellacaselli20@gmail.com> writes:

> The test "background auto gc respects lock for all operations" simulates
> a concurrent gc by writing our shell's pid and hostname to "gc.pid".
> It gets the hostname from the "hostname" command, falling back to
> "unknown" if the command fails.
>
> "git gc" gets its hostname from the system and only checks whether the
> pid is alive if the two hostnames match. Otherwise, it assumes the
> lock belongs to a gc running on another machine. Since the test passes
> in either case, a missing "hostname" command or a mismatch between
> its output and the system hostname can cause the test to silently
> exercise the wrong case.

"exercise the wrong case", meaning...  where hostname(1) output is
different from "git var GIT_HOSTNAME" (aka xgethostname()), we would
have written bogus name in .git/gc.pid file, simulating the case where
gc.pid was written by a process running on a different machine.

What is the implications of doing so?
>
> Use "git var GIT_HOSTNAME" to get the same hostname as "git gc".
> Keep the "unknown" fallback, which is also used by "git gc" when it
> cannot determine the hostname.
>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Isabella Caselli <bellacaselli20@gmail.com>
> ---
>  t/t6500-gc.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
> index a7142ab815..f928089bf0 100755
> --- a/t/t6500-gc.sh
> +++ b/t/t6500-gc.sh
> @@ -413,7 +413,7 @@ test_expect_success 'background auto gc respects lock for all operations' '
>  
>  	# now fake a concurrent gc that holds the lock; we can use our
>  	# shell pid so that it looks valid.
> -	hostname=$(hostname || echo unknown) &&
> +	hostname=$(git var GIT_HOSTNAME || echo unknown) &&
>  	shell_pid=$$ &&
>  	if test_have_prereq MINGW && test -f /proc/$shell_pid/winpid
>  	then
