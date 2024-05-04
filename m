Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C425028F7
	for <git@vger.kernel.org>; Sat,  4 May 2024 02:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714791566; cv=none; b=K+BLBBbEWun2UyLAMnjOCPeZ7P3GDFB7UpIYj8QlQRoxiy+vjlJWL6BpFdmpsDFX3pkIys+9snhyvS62ZEQ7e/liT0R32jP+2I7u2VshIvk4Zo8J3EWnZWRxdPbqECb/rVqep2HCrTiL3JZTKi0EU+5/RXKVzCvgMEtJqiqdGqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714791566; c=relaxed/simple;
	bh=yqSkobxE3RAe+8Nmp7oT1cRQyWmAJ7nt87iipP2QCZw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Wp/0LEHArFVVu5XVWvGXgO+NxkQFsCemZm0SHIQKSMupUCiy1RkfgpjtS4JNcGegTeg9WK3luVBVyT92OBxhqQYN0uV4Z+O4iHYsdwS8ZrSbxFpLAWgAYt3xfsj2lDjN0oVQydCsEVMuogVRoKVDY5kxeewV/4vbm2i8sNiN/TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=J7YAu3oi; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="J7YAu3oi"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1714791560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z+JUh+ElsDQu7lIWtXdmgAA5YbXVBIbSr0ehHxAtjeY=;
	b=J7YAu3oiDcGsP1WYdNjjcPJbzFav7BWoqIDuhZI3qx4XHbbQZbjD0AftH1vMvL+bH3ZxBs
	2wmrBySq3rSkpVrWzI88I3ikuvYRvG/0Ig/4Rory7K6Kc0cQR2+SEJixUIdHJtaceo055t
	3Lte2pZnLdd3IhRO/Tju7NQMTykTdm2RjLwr2CoOU1fJcjVDOWR7kX/jPRTivzE7hkpNgt
	g71VYNLTlfh8SEj7mysCPHldekvDtUcQcv41QZLgBd3A+f3I/DhAy7jugCn60OJY4GYAWJ
	w5eDrcIRqZPDc97l5wfMmCf7woBRm2srMupUkhHZ9NYu8JhepdqJ6zwB4gDAFw==
Date: Sat, 04 May 2024 04:59:19 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2024, #02; Fri, 3)
In-Reply-To: <xmqqa5l64e0i.fsf@gitster.g>
References: <xmqqa5l64e0i.fsf@gitster.g>
Message-ID: <a07d3807a24f6d68cb48ee48366ae25e@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-05-04 02:27, Junio C Hamano wrote:
> * ds/send-email-per-message-block (2024-04-10) 2 commits
>  - send-email: make it easy to discern the messages for each patch
>  - send-email: move newline characters out of a few translatable 
> strings
> 
>  "git send-email" learned to separate its reports on each message it
>  sends out with an extra blank line in between.
> 
>  Comments?
>  source: <cover.1712732383.git.dsimic@manjaro.org>

After thinking a bit more about these patches, I think that the second
patch in the series ("send-email: make it easy to discern the messages
for each patch") should be dropped, but the first patch ("send-email:
move newline characters out of a few translatable strings") should have
no roadblocks that prevent it from becoming applied to "next".

The reason why I'm proposing that the second patch gets dropped is that
I now think there are better ways to utilize the vertical screen space
in the outputs produced by "git send-email".  I'll keep thinking about
it for a while, and possibly submit a clean and irresistible [1] patch
at some point in the future.

[1] 
https://lore.kernel.org/git/72c114086590b9b15a3fdd9e0d6bd67e@manjaro.org/
