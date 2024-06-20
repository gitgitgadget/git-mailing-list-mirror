Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93FF1AED53
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 13:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718890158; cv=none; b=euwp7TU/B3p6gxKAZIa4bUcp/xHji7i4fIuGYzqIaYriOSkxmpF4O3vJ40H2S89lI2+DWkHlF5tFogmxiphke18FIIrVT27l0ymfD4CIrDaQZfnLbcDjyQJntll6tTh3ze6/fb3BMNxC3/0fO0esu8itXmm4p94geMfIGr7GVBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718890158; c=relaxed/simple;
	bh=7be7WMcvfMaRtL1XwQ5TYOVXOEdIDMHf9QoONpoo9Wg=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=a9f0r/nQd0lJk9mC4Z/fMFouiPCHZY1roQzrHxB2tYljuvzxQQpkQuaeOfKreVSSlppJ+12x8hDsovGLYu1q/UUcmCGObA9OsDAS65eX8Xr5FqictX7YmA8vkJCUjJnLPrKv4iztIGeAQpTLVIxhtHFR2F5kSaaqEbjyQ3Yjhk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 45KDTAop3790344
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 13:29:11 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Clement Sello Tsetsa'" <clementsellotsetsa@gmail.com>,
        <git@vger.kernel.org>
References: <CAOqo0cWd5BK5zAgMmsWPYFuWscLvuOq0Gq_a5PH-oXJoGrPb_w@mail.gmail.com>
In-Reply-To: <CAOqo0cWd5BK5zAgMmsWPYFuWscLvuOq0Gq_a5PH-oXJoGrPb_w@mail.gmail.com>
Subject: RE: Feature Request
Date: Thu, 20 Jun 2024 09:29:05 -0400
Organization: Nexbridge Inc.
Message-ID: <009e01dac315$d6399b40$82acd1c0$@nexbridge.com>
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
Thread-Index: AQFAClqJm06o7b9xM6sibCRYCYbrGLMGFHrQ
Content-Language: en-ca

On Thursday, June 20, 2024 8:58 AM. Clement Sello Tsetsa wrote:
>My name is Clement and I am a second year student at NWU university in =
South
>Africa studying towards a bachelor's degree in information technology, =
i just
>recently learned about Git and it is a fascinating piece of technology. =
This is my first
>time making a feature request for anything and please excuse me if it =
is not up to
>your standards in any way. Please read the below text as it is the =
feature request:
>
>When initializing a Git repository, allow specifying file types to =
track using the
>command git init <file>. If no file type is specified, Git should track =
all file types by
>default. Additionally, automatically create the .gitignore file during =
initialization, and
>as new file types are created, add them to the ignore list. Later, when =
adding files to
>the staging environment, Git will already know which types to include =
or ignore
>using the git add <file> command.
>
>I think the user should not have to create the .gitignore file in the =
future if this is
>implementable.

Can you clarify what you mean by "file types"? In a cross-platform =
distributed situation, file types can be interpreted as a combination of =
file extensions, file encodings, and internal contents. .gitignore only =
deals with name matching patterns, so cannot reflect inclusion of =
exclusion of internal content types (for example *.doc with UTF-8 vs. =
US-ASCII content).

This is an interesting idea but seems to require that git build a =
generic mechanism for determining file types on all supported platforms =
and extending .gitignore to represent internal types . This is =
definitely non-trivial. In Linux, for example, the 'file' command can =
determine the internal guts of some files, as in:

$ file myfile
myfile:    TNS/X PIC object format,64-bit data model,executable,NonStop =
OSS target

Note that there is no file extension above.

Can you please clarify what you are looking for in this area?

I would also suggest that you look into both git templates and git =
hooks. The combination might help cover at least part of this. =
Specifically, the pre-commit hook might help with management of the =
.gitignore file.

Regards,
Randall

