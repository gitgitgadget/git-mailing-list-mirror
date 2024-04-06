Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EAD2137E
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 17:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712422924; cv=none; b=r2DCxuyz/JLeBQLJcZx8hWcBE/mhK0AYqQS8XW7udtltkIq8UBD9/Df0r2NyzPEPydjrq5Vz4CYuw6stTEiVYQsOYnlZtNYLa9g++Sx8fn+3Qry5B5LHrxpQMLc7PITu4j+gx50qnN0WtYDPnBPlMvCcZ1YMF5mbsPiEaQdMy1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712422924; c=relaxed/simple;
	bh=9HZoUigajkVZvLiH9QryZ4IZyMmOUCwVaijhr8zNiuw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ax+H1DVufIMoksKtn0wWfkCqYT4dCM5SO1kDwgPDkw2By6qsCc92WLGk0iFqYV0/mMdX9mTB6bAys5GYt7GTi/Pr1Fdy8kCHt5Ak/YdBijsAcMeybxHQHktgYdMpRKWhUc1I0+eFWUCcDkRY/uELFC/LbsUlWHNMBhBhScCxz3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=TgLdEa6E; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="TgLdEa6E"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712422918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+oGgnQB8Ne636Q7MbcBsJFKj54M/tjwPhs8AJzWJlmc=;
	b=TgLdEa6ElRhnP3oSntO4K+vYLmQxbkv2HpV05jfk9TlLAjzkBPQGyVGFNUnlrTwmon8N/U
	1V2clQ1lt5CFQeqCN+1UYq/w4H3W/7jTx1OxoGV+dH3vLpw6HdTs/Ws2HJP5ygGZIfL0A+
	eG8bypTd4DvKjFQ5iTiv9Vj6nH8jQtB4TOrHVxP/qqGO2/qMv3K5Su78cSBwDp1SfflCXI
	5/CTFS1ph+8+SP9qOSlDx+TT/Jm2wcmSwWWEZQP0EwwXcsDnskQx8wr7OrbWCeMYObFfYO
	YLnjM3Nh3S/3RL8w0KoTiMhYKrXNnT8YCA1N2Y9BN3sWEch8QS8fpr5JFt2J1w==
Date: Sat, 06 Apr 2024 19:01:58 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2024, #03; Fri, 5)
In-Reply-To: <xmqqmsq6l9c3.fsf@gitster.g>
References: <xmqqy19rtygr.fsf@gitster.g>
 <36f7e1b7122b0bdeb2e8b70f69abd331@manjaro.org> <xmqqr0fjnkul.fsf@gitster.g>
 <de15fc1ca9b5abe694196f4d468d4226@manjaro.org> <xmqqmsq6l9c3.fsf@gitster.g>
Message-ID: <ceddded683e20b87236e1d4880786881@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-06 18:55, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> Ah, sorry, I wasn't precise enough, please let me explain.  When
>> I wrote "prefix", I had its use by humans in mind, e.g. for searching
>> the "what's cooking" emails by hand, to see the statuses of one's
>> patches.  I mean, that's what I do -- by searching for "ds/", I can
>> easily find the statuses of my patches in "what's cooking" emails.
>> Does that make sense?
> 
> Yes, and the fan-out reduces the search space by a lot, but like the
> birthday paradox, given sufficiently large number of people, the
> chances of two people falling into the same shard increases.  It of
> course does not help that the first and the last capital letters in
> people's names are not evenly distributed ;-).

Exactly.  Actually, such collisions/overlaps are a good problem
to have, because it means that the number of contributors is large
enough to cause such issues. :)
