Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D293285C8F
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 11:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755257135; cv=none; b=u1nLD4yIL2rv3hMm/12fBiwZfzdYEVXkSlbXnHhMAwJDOvBZAsh9LPXJB5AHhzU4g/HQktllXWR7GsPx3VSsf70I5VyGDN664S5cZ30OePqlEUIwyrg6bMGjdFcLaoPXfUK5W34pVBdncLfVml+aJK98lHuE23bXCRy4Y9CPWUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755257135; c=relaxed/simple;
	bh=7LF33FeWJxlG0LzMvvkp0IWTNZAz1Y0rYWpxlJ03wEk=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=bxmfruntL2yXS6sFyIKIV9BGBHlX7k6YfqlGGW9ky78ZJGMAKDmbpCjctTRwiQvtr1MslIvUnz59nEVbq4jjN3JAJEc4XXWehWc2bF9WpVljBcVmXSC+cY2JqGcHQbJGWbgo/mxdXxviZiITRGbNDOqItoYaRFUJPHk/YlOL+MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 57FBMwMm1408340
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 11:22:59 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Elijah Newren'" <newren@gmail.com>,
        "'Christoph Anton Mitterer'" <calestyo@scientia.org>
Cc: "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <a24d0d237b9f57535c768da4c00d72bad68cf411.camel@scientia.org> <xmqq7bz5v0mq.fsf@gitster.g> <16220ca65f1ae9883a2fa103e842cf0ffff43236.camel@scientia.org> <CABPp-BHt80YD9bzWeC+r5qxJ0Vp+zRsJZsKDU_GA39CXmuYe5A@mail.gmail.com>
In-Reply-To: <CABPp-BHt80YD9bzWeC+r5qxJ0Vp+zRsJZsKDU_GA39CXmuYe5A@mail.gmail.com>
Subject: RE: why can't one alias `git stash`?
Date: Fri, 15 Aug 2025 07:22:53 -0400
Organization: Nexbridge Inc.
Message-ID: <00ec01dc0dd6$f4e31f00$dea95d00$@nexbridge.com>
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
Content-Language: en-ca
Thread-Index: AQIPhy+wohXIgYlnRbGWGqRHMsMb4AJrPYpfAjIv1KIBX3FI+bPMt6qg
X-Antivirus: Norton (VPS 250815-2, 8/15/2025), Outbound message
X-Antivirus-Status: Clean

On August 15, 2025 12:04 AM, Elijah Newren wrote:
>On Thu, Aug 14, 2025 at 7:15=E2=80=AFPM Christoph Anton Mitterer
><calestyo@scientia.org> wrote:
>>
>> Hey.
>>
>> On Thu, 2025-08-14 at 18:23 -0700, Junio C Hamano wrote:
>> > Look for "alias.*" in "git help config".
>> >
>> >         To avoid
>> >       confusion and troubles with script usage, aliases that
>> >       hide existing Git commands are ignored.
>>
>> Can't one add some kind of override for this?
>
>No.  And there won't be one in the future either; see e.g.
>https://lore.kernel.org/git/alpine.DEB.1.00.0903070407480.10279@pacific.=
mpi-
>cbg.de/
>
>> Cause AFAIU, my command
>> from below would not hide the other commands, or would it?
>
>The documentation you are responding to didn't talk about "other"
>commands, it talked about "existing" commands.  Your alias, meant to =
invoke `git
>stash` with different arguments, would hide the existing `git stash` =
command.
>
>It might also be an infinite loop of sorts, since your `git stash` =
alias invokes `git stash
>...` which is...itself.
>
>And it'd mean that other folks who use git commands in their scripts =
now can't rely
>on any git commands doing what their documentation claims.
>
>> >       If the alias expansion is prefixed with an exclamation
>> >         point, it will be treated as a shell command.
>>
>> Well I kinda thought that... still wouldn't though if it was detailed
>> what exactly happens :-)
>
>Doesn't it detail what happens already?
>
>           If the alias expansion is prefixed with an exclamation =
point, it will be treated as
>a shell command. For example, defining alias.new =3D !gitk --all --not
>           ORIG_HEAD, the invocation git new is equivalent to running =
the shell
>command gitk --all --not ORIG_HEAD. Note that shell commands will be =
executed
>from the
>           top-level directory of a repository, which may not =
necessarily be the current
>directory.  GIT_PREFIX is set as returned by running git rev-parse =
--show-prefix
>           from the original current directory. See git-rev-parse(1).
>
>What is missing from this explanation?

Aside from the above, hiding an existing command would potentially allow =
a
man-in-the-middle attack. Imagine changing git clone to be something =
else,
like cloning a hostile repository. Hiding existing commands could result =
in a
HIGH severity CVE in git - I would consider it as such. Please ensure =
that no
fix/enhancement is done to support this request.

--Radall

