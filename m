Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56745EAD5
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 08:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712392637; cv=none; b=mU88kB3pSbV+N9EA6kh411/99RPbOnyLOHqcxsQ/+8bPddMuKaB1xiT0B0xbIVsUo5/+aIBGY5awvIdpWbssDDWjVudNahdMlEtAQXCgz70l/udtR2TgLnPusjJ0uucJrDtLjv/n1icvVLlDcma9jtlYRiZPx+e1V5GL7iCbWl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712392637; c=relaxed/simple;
	bh=Ar00eQJDcYHxuGAIXzWbvN1jOafNYql33/N1GccV42c=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Xr6QpFhcsiK3hMbKnuJG3SLhcyOt7PR8FFYB/RpxqX7SQ15j3516ciD76kbQGIbDZPJl/BFHqgGQAMgBERzcSP7tviZ+VP9pfCYLFWCqRLSR1u6TmEBgzgByHMo53QDg/LFhROddIkm+Hg4Y4UgAwAE8vWplPwL/hwT4KpurTfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=flRC5S8V; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="flRC5S8V"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712392630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cIMJQ5hezix51guOuCfcfQFY1jpESMjrDwgei9Mm/nQ=;
	b=flRC5S8Vgb75wPSZt3U7H1YqgazxnpyO49c6LiYxYMU/XQG60cW333ECnWAhR/n/WDGnmL
	q/paUKKugt66TAmKxPhqdUtiibFsLxNoXd9vaGrHS3Ur0voNaC+bz1NbcNS1a8+VWOtKbD
	Wv+73s62+LIVfVNdbNjeFFNCFq9Z8jLJTOIYuPOOamqNyiSjKU8ksAzlJgGexRACVmD0zp
	0CKKthdfr0c1KAEScjcNhtEaU8FQvbZLaAurkxLP/akIB2VNGCQN8wi8cQ+8rkOvmiAUPJ
	7ZmEJRTxpKk+8ijRn4QHtYydE6hlekC3Z/1pmXeMadqgNrwuUCemAlG6KwpQWg==
Date: Sat, 06 Apr 2024 10:37:09 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2024, #03; Fri, 5)
In-Reply-To: <xmqqr0fjnkul.fsf@gitster.g>
References: <xmqqy19rtygr.fsf@gitster.g>
 <36f7e1b7122b0bdeb2e8b70f69abd331@manjaro.org> <xmqqr0fjnkul.fsf@gitster.g>
Message-ID: <de15fc1ca9b5abe694196f4d468d4226@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-06 07:03, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>>> * ds/fetch-config-parse-microfix (2024-04-05) 1 commit
>>>  - fetch: return when parsing submodule.recurse
>>>  A config parser callback function fell through instead of returning
>>>  after recognising and processing a variable, wasting cycles, which
>>>  has been corrected.
>>>  Will merge to 'next'.
>>>  source: <pull.1709.git.1712285542303.gitgitgadget@gmail.com>
>> 
>> Isn't this an example of a prefix collision, i.e. "ds/" points
>> to two different contributors?
> 
> "ls .git/objects/" would tell you that no object is important enough
> to squat on a single "prefix" and exclude others, and two objects in
> 00/ hierarchy are by no means closer together than an object in 00/
> hierarchy and another object in 01/ hiearchy.  The idea to use the
> fan-out in the ref namespace is pretty much the same.

Ah, sorry, I wasn't precise enough, please let me explain.  When
I wrote "prefix", I had its use by humans in mind, e.g. for searching
the "what's cooking" emails by hand, to see the statuses of one's
patches.  I mean, that's what I do -- by searching for "ds/", I can
easily find the statuses of my patches in "what's cooking" emails.
Does that make sense?
