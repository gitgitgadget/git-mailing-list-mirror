Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC44F5733E;
	Fri, 20 Feb 2026 05:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771566243; cv=none; b=bPFTimacKzRgcucM83w3Cdm9qQG+mqWBaZdVXzcbBaJ8sbDzk8qaF9SzGfLOef2BACf9mMC7c7C1g3xW96RiokmOgD/mPUvpe2oMbGa03UrLaPGw+K5F9rRU8FzlfCePfzIunGi6QQeyp0cBchCmzzr/Urcwq6TeGjf8Xw4kv8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771566243; c=relaxed/simple;
	bh=nAwASGi5c/XcXYGVV67cIULqGiwOoqBepR7MHcsA1Ms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VN/bLtzMO403ae1dIOFY4BigDKg9PzaApNGMZkqPuGoEU4tMQJt9mCBtJGyjJrWpM8350/6LIZQzYwwVoUTWPhTas/hVsQFFGux7VzUN6UqnD+OsZvz3IgLNabaPpW0gzE99lcoLDwEOww+IWJ905UwyfQLUlaA6gJXuUejfw1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=DAnpc4w7; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="DAnpc4w7"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id CAEE51D49A;
	Fri, 20 Feb 2026 05:43:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me CAEE51D49A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1771566240; bh=nAwASGi5c/XcXYGVV67cIULqGiwOoqBepR7MHcsA1Ms=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DAnpc4w7DPMpux3k8n9028GXe5YHPsOE/VINiFMy2Y4vpZa1/EMts/Grxcwvzc7Ik
	 IcisP9RWXKR4XGPh0/OdyVr/HBmcH9TDQiWjxGUmqg6F8vesbHmQ7qpAF7O/Yzr0u8
	 w8bAM5ex9R8wUmfp8MNU/hK1sxX5/10d5mbogfQ8=
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id RdSmHJ/0l2kVlgIA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Fri, 20 Feb 2026 05:43:59 +0000
Message-ID: <a676fa73-bb73-485b-9ace-36a841be2b15@dev.snart.me>
Date: Fri, 20 Feb 2026 14:43:58 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] Introduce filesystem type tracking
To: Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 git@vger.kernel.org
References: <1211196126-7442-1-git-send-email-tspink@gmail.com>
 <7b9198260805200606u6ebc2681o8af7a8eebc1cb96@mail.gmail.com>
 <20080520134306.GA28946@ZenIV.linux.org.uk>
 <20080520135732.GA30349@infradead.org>
 <20260218-goldrausch-hochmoderne-2b96018fbe5b@brauner>
 <aZakzr_QAY6a-dlB@infradead.org>
 <20260219-galaxie-sensibel-b6d27e60d524@brauner>
 <20260219-kavaliersdelikt-ansatz-9bdd1aa77326@brauner>
From: David Timber <dxdt@dev.snart.me>
Content-Language: en-US, ko
Autocrypt: addr=dxdt@dev.snart.me; keydata=
 xjMEYmJg1hYJKwYBBAHaRw8BAQdAf5E+ri1XLtjqYbZdHOyc8oS+1/XJ5bSlbx5WHXmVBZzN
 IERhdmlkIFRpbWJlciA8ZHhkdEBkZXYuc25hcnQubWU+wpQEExYKADwWIQQn/Jn96EMUaIoF
 X+T/ldyyrZpWaAUCYmJg1gIbAwULCQgHAgMiAgEGFQoJCAsCBBYCAwECHgcCF4AACgkQ/5Xc
 sq2aVmjJZwD8COjPlUwccrlRvbNQ6f87DWchtYO0o8W2DNRM3RLps0EA/jEhIbRV6AsyC8jr
 30Ut3aJ3/mO/6G4sLj7OvkEEBH0MzjgEYmJg1hIKKwYBBAGXVQEFAQEHQFpgtIgaByv9lIEY
 EmpavMO0pYjtu7TMJynwdnGYkN9LAwEIB8J4BBgWCgAgFiEEJ/yZ/ehDFGiKBV/k/5Xcsq2a
 VmgFAmJiYNYCGwwACgkQ/5Xcsq2aVmhFCwEA0kM9VyYB4bLCM7+SuXUUH+5Ec99Nj4RXxFad
 Key9GuwA/2BZK6bNyrLSfEk2JDRoskqf7OIL0wa6JOD5SrBnMe8E
In-Reply-To: <20260219-kavaliersdelikt-ansatz-9bdd1aa77326@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> All these mails have a broken header and set In-Reply-To: to <>:
>
>   In-Reply-To: <>
>
> So all of these messages share a single bogus parent with the empty
> message ID <> and then Neomutt groups them together which makes it look
> like a really old thread got new replies...
Sorry for off-topic

I run my own Postfix+Dovecot stack and for an added layer of security, I
enabled client cert verification for all MUA ports(submission and imap)
so that bots don't even have a chance at establishing a TLS session.

The downside of this would be lack of client support. I'd love to use
but unfortunately git-send-email cannot be configured to present a
client cert to the server. I just learned that git-send-email is only a
single 2k-line perl script, so I could submit the patch if anyone's
interested. Just a few lines for the script to pass the PEM paths to the
openssl lib.
