Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C78323D
	for <git@vger.kernel.org>; Thu, 26 Dec 2024 20:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735246001; cv=none; b=APdTGmEkUDBv/Y6GXc8ThsG8HcolVZX0zrS0g9gy4t8/OeKrh6UefN/HGWIjZDEe9iZyw49FM56gWufiI1c1s7CG71jT4ctMff6h3kb7CwLtB8H83rvcYlhAIbpb1MUzOeVipvOd93KwXFdunFwGnGmgLyU9A8j000fyE3RXyyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735246001; c=relaxed/simple;
	bh=NvYiefnxLd5R+t9Hi1/egFxMhu+0x0T/xpREglt0Tf4=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=fujEPYAOmWKBmRR6/EYlFBszzzr5BD976b0uTv31s72Il/38DG1moyVGT0nNCt5kLGLs+v60kDSrGA7ogl3oisGiTOOBMP0915HFrsA7fX8aKqsHXfWS1X2hWI1Veco4U72P+Ix3Dc/JjNQ43MGiRik7q1S6Qu0EZIdgtOrBXAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 4BQKkYT53605580
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Dec 2024 20:46:34 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Alejandro Colomar'" <alx@kernel.org>
Cc: <git@vger.kernel.org>
References: <lwjb3p4mqv6h3mewyh4b5gm4gs6omfapmbd34roexs7yujnswv@xwn6oriqdt62> <015f01db57ba$7c9e14f0$75da3ed0$@nexbridge.com> <brgripo67yq43wzti5tpsxqezwfrurt2qpaiugnxuuksjvmmab@eeugej54ncxm>
In-Reply-To: <brgripo67yq43wzti5tpsxqezwfrurt2qpaiugnxuuksjvmmab@eeugej54ncxm>
Subject: RE: /etc/git/
Date: Thu, 26 Dec 2024 15:46:29 -0500
Organization: Nexbridge Inc.
Message-ID: <016801db57d7$40a7b740$c1f725c0$@nexbridge.com>
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
Thread-Index: AQJx+1MmbdhywYTVyNILNB2phSczkgLSjx8wAUWvXCOxqvTosA==
Content-Language: en-ca

On December 26, 2024 3:42 PM, Alejandro Colomar wrote:
>On Thu, Dec 26, 2024 at 12:20:34PM -0500, rsbecker@nexbridge.com wrote:
>> On December 26, 2024 12:11 PM, Alejandro Colomar wrote:
>> >I'd like to have all system-wide configuration under a single =
directory.
>> >What do you think of adding /etc/git/, and reading a 'config',
>> >'ignore', and 'attributes' files from there?  /etc/gitconfig and =
/etc/gitattributes
>isn't very clean.
>>
>> Have a look at GIT_CONFIG_SYSTEM documented in
>> https://git-scm.com/docs/git and let us know whether this might work =
for you.
>
>That's a workaround, which would involve appending some line in =
/etc/bash.bashrc
>or somewhere similar.  In the end, the git configuration would be =
spread and
>unorganized, just in a different way.
>In fact, I think I prefer having several /etc/gitsomething files than =
having a dir and
>then having to clutter the system-wide bashrc.
>
>So, I prefer /etc/gitconfig over /etc/git/config + GIT_CONFIG_SYSTEM, =
but I prefer
>/etc/git/config over both.

One possible thing is to have your central git config, wherever you put =
it, use [include] sections.
These allow flexibility to pull in relevant configurations depending on =
the qualification
of the include. Maybe something else to think about.

An enhancement like this is high impact and would touch a fair amount of =
code. It is not
Just for --system, but --global and --local also. The semantic of =
specifying and resolving=20
Configurations and attributes (inherited in repositories) are =
significant.

--Randall



