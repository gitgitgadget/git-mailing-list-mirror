Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67233EA73
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 21:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705959733; cv=none; b=CB+TfBBFGEkZn9EdKJhGhFdvKxfDYD5YSbzS8zSvXTUCslzSTaAX6OUeaG4wqe7syEeqGcAY4htosNLKvss0Q9av8LokqjxeLohf9nU32pihkSu1PBpABSniULYFFIAnz30WgEyIWrVP2LKXaiBhjNhFmx9b85pcO6zyEfAV+J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705959733; c=relaxed/simple;
	bh=Cs9hTyq5QbBHTiuRjV+mtZAFR9vLWIopCMnRDN8WGGw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P0ZSxKqYfvspnB7rfLT2Fgl7AXxsfIn1tGQ1Ewj0eeQqr5Y689tcJ5wBfaqfWOUqQv1qOO8yzEAeTv/z1okLfqW2OCSot8W/IV+lai0VHg8AcaOeM8y6dY6W6dwiAcOOlZHSHPGYnUntuU1DLtDMe/zR8Q+kueKZdNRcU3fxeh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wReYzeIi; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wReYzeIi"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 69DF133DF6;
	Mon, 22 Jan 2024 16:42:10 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Cs9hTyq5QbBH
	TiuRjV+mtZAFR9vLWIopCMnRDN8WGGw=; b=wReYzeIinVWQRibyIFqJczPJEnkG
	4M2mSaw2aPQeLiORhiCT9rCvMbZ1x7zmihzYdToYYptCxwXmNPVLxeFaztXgYxtk
	4mc7mZzDNuqjxrblv7w0otYDLbCksnAqwAzd+ssQrohKW72sBWGoJ2PPAeZkH3Vd
	WofhXBS6tKbPjrg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6200133DF5;
	Mon, 22 Jan 2024 16:42:10 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EAC1333DF4;
	Mon, 22 Jan 2024 16:42:06 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmHDumwgTsO6w7Fleg==?= de Arenas Coronado <raulnac@gmail.com>
Cc: git@vger.kernel.org, 
    Elijah Newren <newren@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Sebastian Thiel <sebastian.thiel@icloud.com>
Subject: Re: Fwd: Unexpected behavior of ls-files command when using
 --others --exclude-from, and a .gitignore file which resides in a
 subdirectory
In-Reply-To: <CAGF1KhU=o2rb-tCjZAG278kgoW50NYymsJakUwiMxWTQ33gQYA@mail.gmail.com>
	(=?utf-8?B?IlJhw7psIE7DusOxZXo=?= de Arenas Coronado"'s message of "Mon, 22
 Jan 2024
	22:07:03 +0100")
References: <CAGF1KhWNaO_TUuCPo2L_HzNnR+FnB1Q4H6_xQ2owoH+SnynzEg@mail.gmail.com>
	<CAGF1KhWiYX=3R01Odj2yCNgvx=f5+HRCjRJogWf5eBikuATCcg@mail.gmail.com>
	<xmqqfryprsyp.fsf@gitster.g>
	<CAGF1KhU=o2rb-tCjZAG278kgoW50NYymsJakUwiMxWTQ33gQYA@mail.gmail.com>
Date: Mon, 22 Jan 2024 13:42:05 -0800
Message-ID: <xmqq5xzlrqoi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 16C802B0-B96F-11EE-813E-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Ra=C3=BAl N=C3=BA=C3=B1ez de Arenas Coronado <raulnac@gmail.com> writes:

> ... I was thinking about what git itself
> does when ignoring files, especially when dealing with .gitgnore files
> in subdirectories, but clearly this needs a different policy, yes.

What "git" internally does is the equivalent of using the
"--exclude-per-directory" option to honor ".gitignore" in the
subdirectories, and in addition use ".git/info/exclude" as another
source, pretty much the same way as "--exclude-from" reads it.

> What I needed from this command is a way of backing up some ignored
> files. These files should not go into the repository, but I'm using
> them temporarily for development so it is a good idea to back them up.
> I'll just backup the entire repository instead, is not a big deal :))

The current mechanism can be used to list "ignored" files that must
be left out of the project (e.g. the most obvious one being object
files "*.o") but these "ignored" files are considered "expendable"
(i.e. Git is allowed to remove it as needed, e.g., when switching
branches and need to make room---if you have an untracked file F
that is ignored, checking out a branch that has a file F/G requires
the file F to disappear so that a directory can be created there).

We have been discussing to extend the mechanism so that we can have
"precious" files, which also will be left out of the project (e.g.,
"git add ." will not add to the index, just like an ignored file)
but are not considered "expendable".  If file F is "precious":

 - "git add ." will not add F to the index

 - "git status" will not say F is left untracked and can be added

 - "git clean -f" will not remove it.

 - checking out a branch with a tracked file F/G will *fail*, to
   prevent the loss of file.

No code yet, but the design consensus is almost there.  Once it
appears, you should be able to say "give me the list of tracked and
precious paths---I do not care about ignored ones that are expendable,
because they can be recreated mechanically and that is why they are
marked ignored", and from such a list of files, you should be able
to drive your back-up solution.

[jc: cc'ed those who are involved in the "precious" discussion].


