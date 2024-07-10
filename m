Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B153C194C6B
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 17:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720632214; cv=none; b=F3epxHwv41t+r5Ybx/nowmg4dCiyCmtjZ7WecPnjytPmy37ogpVoKazptV2ddNdsJQ8VXbHzgWvbvwwQtcXYU7DS3U0MtXl0+7nRlyW7/nzSa02KW9qseGdeqYht9QpQCb37gV7Y7ksuoT3T4hY68HtSPM/MVkfrgupubV9tSRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720632214; c=relaxed/simple;
	bh=5qIkTlwYagm8VAlPk1B/BrfN9PDDZZRfLVYW9JIXteU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=lSJkT5Z0rh/XR/QjZB9ICST/QFziPxpj1RT7okF2LOc7bAGzOqfS3ZhUx1S2Lv6hWWA+456w2mxKmlnGmeQYPhhqq0ITFyF++xy09+46niIDx7Ww0gsh3YkMrPIVi8qjP0Ufimy72ut9EysGl4PFFtZ68HRO2S37bc3MvNOll8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=B6qr4Xwi; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="B6qr4Xwi"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1720632206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Xv7freT73LbdkiInOTK46QPsnlxX0t61vVtguDstZ0=;
	b=B6qr4XwiGDusz2vaOiIzrR0nmv3H1+nDz2o48FuKXq/jufTLq1xsYSFU3rqewkt8m2C5Q7
	BkOV7YxYN217AHOh74KsCvZiwQRzvlwNip5izDPvrqbvfXHuPCLw3/OYdpye2E20l6ZTi5
	KebyvJv0RthyxDgbEGjNRs9uATPFvi+PuVv+4eU0c9tzLPeJEQOY+Q8xeoS8QJDPzuok+l
	nCoUxvsf1ohso25MUjoqk72P7p+GYjAm3BxFhZaxVpDmPx6IBCoIr+NpH63dvUC+TAd5VC
	bQuAR/Ap1PcMprLyGAMgcADF5JTXmGp7Z1HA8B7QWLKqfkrfkdHr+98XA7FzDQ==
Date: Wed, 10 Jul 2024 19:23:26 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, "Schoonderwaldt,
 Michel" <michel.schoonderwaldt@sittard-geleen.nl>, git@vger.kernel.org,
 git-security@googlegroups.com
Subject: Re: Request to Update OpenSSH Version in Git due to Security
 Vulnerabilities (CVE-2006-5051, CVE-2024-6387
In-Reply-To: <xmqqa5ipxjdr.fsf@gitster.g>
References: <AM9PR07MB71854BD4C1CE7E517203FFB6B1DF2@AM9PR07MB7185.eurprd07.prod.outlook.com>
 <ffe00b81-5f19-a073-9a9e-ee84b7d3845b@gmx.de> <xmqqa5ipxjdr.fsf@gitster.g>
Message-ID: <25ce4ec25b054cfbf4c540663c6b6c18@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-07-10 19:10, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> The crucial part is the `sshd` part. Git for Windows does distribute 
>> the
>> `sshd.exe` binary, but it is in no way used by default, nor is there
>> support how to set it up to run an SSH server.
>> 
>> Git for Windows is therefore not affected by this vulnerability, and
>> therefore it is not crucial to get a new version out as quickly as
>> possible. See also my assessment at
>> https://github.com/git-for-windows/git/issues/5031#issuecomment-2199722969
> 
> I think I've seen in the past another inquiry about vulnerability
> in OpenSSH, which turned out to be irrelevant in the context of Git
> for Windows for this exact reason (i.e. "sshd" is problematic but
> "ssh" is OK).
> 
> Would it make future confusion like this less likely if you stopped
> shipping the sshd and ship only the ssh client?

Not shipping sshd.exe would make sense regardless of the associated 
security
issues, because it would prevent accidental enabling of SSH access.  
Also, if
someone wants to make SSHing into their Windows machine possible, I'm 
pretty
sure they won't do that by installing Git for Windows and using the 
shipped
sshd.exe, but by some other means.

In other words, not shipping sshd.exe would not only reduce the likeness 
of
hitting some security issues, but would also prevent accidental enabling 
of
SSH access on a Windows machine.
