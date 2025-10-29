Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DE525CC5E
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 22:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761777702; cv=none; b=MV+XGpLFhnYGrJ1LhnIvzmF9Ox3Gvcb94+ZyR+AFx5QMcCvHXuuG6d68qYWKEh5qvvD9YGFzymbAMBIh9tBRcnWyJ9k/G0aCiDyVNKPjC+21Fg01AVgcuGClznzNF8SC8tm+O+u3P7F4a8rZeWMEbA2D7DvhXWENcNGBqIx4iGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761777702; c=relaxed/simple;
	bh=d1inKzvntuLJ2ZZcmgpTq0JiS95udpHx6bWDT1vt0Cw=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=uR4uJt424nZadLWIlBUc5fBL5fP5rykxA1FJD3QN5vaYkob0UIedyIF+Uu6h6Q3t6PIR7ZlGx5QmmsDgXSOe+vLfNvXVvr17ipjaO7J7AqmbBgNCfj3Uf8LFbEisUlP3F2TrL25VeRBo3xBhDZcKFy+fiu3IzF3GLURW1Dka8wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 59TMfWQw1834938
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 22:41:32 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "=?utf-8?Q?'SZEDER_G=C3=A1bor'?=" <szeder.dev@gmail.com>
Cc: <git@vger.kernel.org>
References: <xmqqo6psjq2n.fsf@gitster.g> <000d01dc4831$ff049500$fd0dbf00$@nexbridge.com> <aQKVByfUdYHSEcDz@szeder.dev>
In-Reply-To: <aQKVByfUdYHSEcDz@szeder.dev>
Subject: RE: [BUGS] Git v2.51.2 on NonStop
Date: Wed, 29 Oct 2025 18:41:27 -0400
Organization: Nexbridge Inc.
Message-ID: <000201dc4925$2cdbc450$86934cf0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGUZTuwh66ijI7aIz2t8Y1znRjrdQMi5nLUAqYtrUO1OzaJwA==
Content-Language: en-ca
X-Antivirus: Norton (VPS 251029-2, 10/29/2025), Outbound message
X-Antivirus-Status: Clean

On October 29, 2025 6:28 PM, SZEDER G=C3=A1bor wrote:
>On Tue, Oct 28, 2025 at 01:40:42PM -0400, rsbecker@nexbridge.com wrote:
>> I have found new defects on 2.51.2 that were not present in 2.51.1 =
when building
>with OpenSSL 3.5 (probably unrelated).
>>
>> Many failures in t7900 resulting from the use of test_subcommand ! as =
seen
>below. This is run in bash 5.0.18:
>>
>> + test_subcommand git gc --quiet --no-detach --skip-foreground-tasks
>> + 0< run-no-auto.txt
>> =
{"event":"child_start","sid":"20251028T172435.690328Z-H36b1c598-P7b000
>> =
02d","thread":"main","time":"2025-10-28T17:24:35.879833Z","file":"/hom
>> =
e/jenkinsbuild/.jenkins/workspace/Git_Pipeline/run-command.c","line":7
>> =
40,"child_id":2,"child_class":"?","use_shell":false,"argv":["git","gc"
>> ,"--quiet","--no-detach","--skip-foreground-tasks"]}
>> + test_subcommand ! git gc --auto --quiet --no-detach
>> + --skip-foreground-tasks 0< run-auto.txt
>> test_subcommand[5]: test: argument expected
>
>This is a strange trace output, as it includes file descriptor =
redirections, but lacks the
>trace of commands executed in test_subcommands.  This trace doesn't =
look like it's
>coming from Bash.

The test_subcommand[5]: test: argument expect is coming from bash. I =
cannot see how
it is coming from anywhere else. The test was run with -x but snipped. =
Reference to
test_subcommand ! git... fails exactly the same way. Is there something =
else I can provide?

