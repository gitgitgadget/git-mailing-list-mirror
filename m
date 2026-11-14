Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.33.87.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794646194;
	b=hwy8XTJl7Di2lR8HdJMQKq8poMAEjLaJnGxBro0kxr2JFV04p15DTu7Ky60WmRbXKalX
	 2gUIuZ9iGLpT7o/IUcNabOYMMSHXuRwqGM3ItgjyCRDgRP96y6YQING8x4HRDgxU6tlMd
	 8CNHXtaYtNS0lQ38/mWgI27wp0LDrGuAGJrO9HrqwwrfzBPM0sdZ5vzaW4Q+1YZvXfJPc
	 S1OBNZesRnaTpiKatGqkOo0oRARwZvaibcO9oHwFPQSqel/l69JQ7Hjo5H8Fx0BeISsGv
	 jOYLneQI28+MuqI4k8L/eXgrGRbE90qw9b/cCko/3WHBHqwV0jrBBvxVfv4Z/t5OO5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794646194;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=KePsTuCmI1WOXwSE1xmCoMj5B/hRjpmaPaEkBAXRjXY=;
	b=xnUAJzVq6q+PUb7fhOwhmPvEs/Syod1keDXcYtNF7Kc37C14SFtku0TiXTHQg0Gm4AQm
	 /SrQyM/F/7vxsRns+zQVVq1DOITEMBsydbwKZ14dIWFryeF2bpVRLL0TvL0S43swDvJ6F
	 sBtWNK2xok6XNq4kweEm9rQzjMhByEckywzBSHTI2ezvbTlNrKVJT6CEX9i5Laih3A3qH
	 +xE3YIU64m/0k0su0WvncRIZIKb14ucMRwNL0Ds2/6MR/JwWV+7fucNdUvxbI6tBeWETi
	 AC7z43uc1UsELf/4yjsfXJIjq31yzBrrIy+uQmg7MzrYtphq5xvBkElRdtZuG60od1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kdbg.org;
	spf=pass smtp.mailfrom=kdbg.org;
	arc=none smtp.remote-ip=213.33.87.15
Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67882606A329
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 08:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67882606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4jRSVb3PLlzRnlL;
	Sat, 14 Nov 2026 09:49:43 +0100 (CET)
Message-ID: <080eb4e7-2885-4057-b063-2f114b99b883@kdbg.org>
Date: Sat, 14 Nov 2026 09:49:42 +0100
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: git context diff does not recognize shell function name
To: "Windl, Ulrich" <u.windl@ukr.de>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
 Junio C Hamano <gitster@pobox.com>
References: <340dc2eef42f4f6690c58765a07621e1@ukr.de>
 <xmqqmrrdhiye.fsf@gitster.g> <69690c3bd37448ff8116bf3497f151a9@ukr.de>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <69690c3bd37448ff8116bf3497f151a9@ukr.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 13.11.26 um 08:09 schrieb Windl, Ulrich:
> The file
> name ends in ".sh", and there's also a "she-bang" at the start
> saying it's a BASH script.
Git does not activate diff drivers automatically for any type of file
(AFAIR), so all of these properties are ignored. You have to activate
the diff driver yourself, for example, by putting a line like

*.sh diff=bash

in your .git/info/attributes or a .gitattributes. Without this, the
default hunk header pattern is used, which picks up lines that begin
with a non-punctuation character.

-- Hannes

