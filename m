Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0849C42A8B
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 17:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738170091; cv=none; b=MaXZV/+kQifedp24GYYYbf3xP8V7iEtpgE/G4Ru3EdqnWW94V8sQu+3q/Rl6ETlbFXx2vFHlZ4O30MIVePR1FSwgAlkUhkbdn5vv8CqLhGeTNWUB+hnFn+/siYOrxrZPtOOapVpggLlbizhjYSsz9t6IfP+eni2OknvsGzg3nxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738170091; c=relaxed/simple;
	bh=iFyks3gKMZKw1o2EdMZYtJeHZ1c1iPFQdDQssbrZK+A=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZeiLKL8csrs3UUf0s4aifxihRgHERfYZus6jhMJYqyHqHScW8HahHnuknVt+YeDfESlxTYIwxNmdhFHVzG5icXXtmzVssPpWHjlJmXaNi+sHaeW6fQrhnQ5ANT86SXEw8FvPbh/NLVnl1yuny8aWTir08gMXsn7asx7F512L6X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 50TH1OOj1964531
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 17:01:25 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
Cc: <git@vger.kernel.org>
References: <007f01db726b$ac911ce0$05b356a0$@nexbridge.com> <xmqqbjvpk1wo.fsf@gitster.g>
In-Reply-To: <xmqqbjvpk1wo.fsf@gitster.g>
Subject: RE: [BUG] PREFIX environment variable ignored by git config --system
Date: Wed, 29 Jan 2025 12:01:19 -0500
Organization: Nexbridge Inc.
Message-ID: <008201db726f$6e6990b0$4b3cb210$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQN9fsp86lG5K0M4uVvG8mjsU9to7QHrUQSBr9qE5WA=
Content-Language: en-ca
X-Antivirus: Norton (VPS 250129-2, 1/29/2025), Outbound message
X-Antivirus-Status: Clean

On January 29, 2025 11:42 AM, Junio C Hamano. Wrote:
><rsbecker@nexbridge.com> writes:
>
>> Thank you for filling out a Git bug report!
>>
>> Please answer the following questions to help us understand your issue.
>>
>> What did you do before the bug happened? (Steps to reproduce your
>> issue) export PREFIX=/home/randall git config --system --list
>>
>> What did you expect to happen? (Expected behavior) Git should use
>> ${PREFIX}/etc/gitconfig instead of the build location to
>
>But that is now how PREFIX works, as far as I remember.  PREFIX is a
build-time
>thing.
>
>Perhaps you are looking for RUNTIME_PREFIX build-time option?  I do not
know
>how well it is maintained these days, and if it allows you to futz with the
paths at
>runtime (without _moving_ the executable and all other installation
material en
>masse), though.

The documentation on the Environment Configuration page seems to imply that
these are run-time variables, not build time, which should come from the
config.mak.uname. In any event, I'm in a situation where I do not have the
security to create the actual ../etc directory so am trying to test an
alternate
location. Some of the customers I am supporting have experienced this also.

Any ideas on handling an execution time override of the system location,
instead of
just using GIT_CONFIG_NOSYSTEM to turn off --system?

I would gladly add GIT_CONFIG_SYSTEM=path with a little guidance, if that's
what it
comes down to.

--Randall

