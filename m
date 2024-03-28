Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E07051C46
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 18:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711650572; cv=none; b=ggEa0/YfAFQjUPrIl0Feu09To8oIY86DGT7YS3lIh46vVEqdWEdeAMGtgCCWef5hD+B2fJhZn0kz7wTvDa8SoQhnnofPThQiy7+pR0hNX20x9mWxpsJiYALDYFttYWN5PZZYcIAWyxQ8sJiFykOmqI1oUZMvznffveoJclFgUBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711650572; c=relaxed/simple;
	bh=lDed37mO4cHXHV2K4SisB31tK/YltTimjPymU9f4SrU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=CwFIIi9evyY0dTZ0xUjBFnD01uikHhd9K0EcSjxzfPgU+CUP7CidsXvfiOQFKEvM7YnUnkuEMAvJJirPF7rsA+BwxS8Q/l0IctFp8QOVcBMDcpRbZPTGvkIKfnOwwVKnSOe0DLkHD9F0u4A+Pjf0Es14T+ACEQLj4TIttjWJ6Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=sSToFFN/; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="sSToFFN/"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711650567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I27HxqWPiTgsqBl17I6tgDO/S/VW1jk+aHxnZgRS+RY=;
	b=sSToFFN/7IbBsuksleFS0BTRcP1FJlAp0GjNMs9oRGGgH/GIVMrE6in5VrU1TXppiLOOP4
	nZ3dRr672IAI0iFKMpXM5YFWjk8vFk2Uens3Ee9l287VD197R4xKQ4L2bjRISkI6nBcR9z
	ttAy9URg4iIZUM8YRsBPEJ8v6qf6dgEfQoYLoBW/iSa8wlP2cXytwT8Afkpdrq6EmhgI5t
	TD9vap0KsSNs/LSASCsagci2NOBZPQV1U7ZL/kBdvaRJy/h7pahnlVWrTY4pakKV6JKuvi
	wKjlI11khdegWbDa9JdJUHmAgXMKiB0XCj43GUTx5J5z05qXJhI7FJj8jjvi/w==
Date: Thu, 28 Mar 2024 19:29:26 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Eugenio Bargiacchi <svalorzen@gmail.com>, git@vger.kernel.org
Subject: Re: Better visual separation of hunks in `git add -p`
In-Reply-To: <xmqq1q7uusin.fsf@gitster.g>
References: <CAHfn=+snXChcPFiEgxvK=XFCq2uVMKQTyfrN9RNfAod18d0V=Q@mail.gmail.com>
 <xmqqo7ayuwpi.fsf@gitster.g> <a9cffbe4aadd319760635ca6d5b4f465@manjaro.org>
 <xmqq1q7uusin.fsf@gitster.g>
Message-ID: <1b81a013dd0faccdc24fe018fd740755@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-28 19:21, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> Here's a possible solution, or better said a new configuration option,
>> which I've been thinking about for a while...  When running "add -p",
>> displayed chunks can sometimes become confusing or a bit hard on the
>> eyes, but simply clearing the screen _before_ displaying any new step
>> (i.e. a new chunk, interactive help, etc.) could make it much easier
>> on the eyes.  It would be a new option, of course.
> 
> Or your 'p' option can have a 'P' variant that clears before prints.
> I have this feeling that even those who want clearing of the screen,
> they do not want it always on, when many of their hunks are 7 lines
> long.

That would be even better.  Though, would adding new short command-line
option to git-add be frowned upon?
