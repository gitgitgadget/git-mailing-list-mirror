Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6748C1FC7FE
	for <git@vger.kernel.org>; Wed,  5 Mar 2025 22:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215057; cv=none; b=b/VM3kpfqYZJJ0Rs1Y8sFTG0f+R/Ah8yCNllj9Y2JrRJnzi6Z9l8km/MK2P4Hd6YrElUHTnxSA6848bcnBKhAm4geIpKLc8rh/nr3xJPbspSplFq6Qv62sguC1ORB0+IkFzP2GWcANohGk/9s6M1EASjwd3/RjRX2u15iWLZdJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215057; c=relaxed/simple;
	bh=YTrWeuQcYGm2CtLgIcVnBc8+GOnDfBQiueJtnXpmrfU=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qyh31sXfIS2eTCSnXXeznHDdx6bbLGejehftU1uo320IdVKTCztTXWw1QQCVT76jSJDRSPxmrC6Z+k4MeymZrV96S2lrlQS02w8m6o1lb7TiVpOigfG4+0HcLGM9nlV0X32r0xKjB8fNkZlHDpCQaEcRTXhNedkeFV7sGcWElv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 525ModC1768794
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 5 Mar 2025 22:50:40 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Tech Kenya'" <techkenya@protonmail.com>
Cc: <git@vger.kernel.org>
References: <qMn1k_iuZCe353x0BBxdD5z4-17Abk_ZHoPr8nVDLOgLhGf8Nxb3-bsXPH2GiATUsuGLVqAaEESua5G9qBaW0qqxwz-7AbcNyRwSXJzbKMs=@protonmail.com> <Z8jTjt1CQ7hp8KSP@tapette.crustytoothpaste.net>
In-Reply-To: <Z8jTjt1CQ7hp8KSP@tapette.crustytoothpaste.net>
Subject: RE: Suggestion: Enhance git init with Language-Specific Templates
Date: Wed, 5 Mar 2025 17:50:34 -0500
Organization: Nexbridge Inc.
Message-ID: <00a201db8e21$04d42ac0$0e7c8040$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIINqQHmR7GQL0BoiPAsMdoBnAsZAFNJp3ZswFq7hA=
Content-Language: en-ca
X-Antivirus: Norton (VPS 250305-8, 3/5/2025), Outbound message
X-Antivirus-Status: Clean

On March 5, 2025 5:43 PM, brian m. carlson wrote:
>On 2025-03-04 at 11:49:14, Tech Kenya wrote:
>>
>>
>> I would like to propose an enhancement to git init that allows users =
to specify a
>language or framework when initializing a repository, automatically =
applying an
>appropriate .gitignore template.
>>
>> Proposal
>>
>> Introduce a flag to git init that enables users to initialize a =
repository with a
>predefined .gitignore based on the project's language or framework. For =
example:
>>
>> git init --golang
>> git init --python
>> git init --node
>>
>> This would generate a .gitignore file using well-established =
templates, such as
>those from Toptal's Gitignore Generator
>https://www.toptal.com/developers/gitignore/ or GitHub's official =
.gitignore
>repository.
>
>I think this is an interesting idea, but unfortunately, I think it's =
going to be practically
>difficult to implement.  You've mentioned three very common languages, =
but there
>are a lot of programming languages and even more compiler environments, =
and it
>wouldn't be practical for us to try to support them all.
>
>For instance, I use Neovim, and the version I'm using ships with 693 =
different syntax
>files, which means that there's about 693 different programming =
languages
>supported.  I was recently exposed at work to some languages that I'd =
never heard
>about before and which are not supported by Neovim, and presumably =
those users
>would also want similar functionality.
>
>That is compounded by the fact that there are a lot of OS- and =
environment-specific
>configuration.  As an example, a C project on macOS might want to =
ignore XCode-
>related files, but for a project that's only on Linux, that wouldn't be =
necessary.
>Similarly, that C project might create shared libraries that should be =
ignored, but
>those might end up with any of `.so`, `.sl`, `.dylib`, or `.dll` =
extensions.
>
>You mentioned some possible sources for this configuration, but we try =
not to
>prioritize specific outside projects.  So just because GitHub is widely =
used and some
>GitHub employees contribute to Git doesn't mean we give it special =
precedence or
>privileges, and we wouldn't want to prioritize their specific =
collection (or any other),
>nor would be want `git init` to attempt to make a network connection.  =
We also
>don't want to maintain this collection ourselves, since it's very =
project specific.
>
>What Git _does_ provide is a way to create a template of objects that =
should be in
>the `.git` directory using the `--template` option.  It's possible to =
create a template
>that contains an initial commit with a `.gitignore` file.  I personally =
would not
>recommend this approach, since it will not work gracefully with =
alternate ref
>formats or hash algorithms, but it is an option for people who want to =
use it.  This
>was in common use for setting up the default branch name before `git =
init` added
>the `-b` option and it's related config, so it is well tested.

One way to deal with this is to add language-specific descriptors. What =
I did in my
own front end is to provide a set of regex patterns that define the =
relevant portions
of the languages and extensions. This allows my end-users to add their =
own languages
and leave me out of it completely. It might be workable if we have a =
quantified
extensible language structure for this. Otherwise, this might be DOA.

--Randall

