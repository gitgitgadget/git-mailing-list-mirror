Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2144A1D
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 19:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737748331; cv=none; b=h421977C2aFe7gnAHL6PBtj01UPACrEldZs+Sc5SVmHhI61x7f/5GOzXe2JTLsH50wlbuh7ugtfCh7PHFWAkcK/2/BNm3cyYREks1M7Ps6jsU5t8VLsoaRvjFlAChLTfIuhr/4JeTebkmOvI+nrk57WNyVzSe3vh9oBeCbkLsm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737748331; c=relaxed/simple;
	bh=CRwCwv13+izp2EjEAYyPEzwQVoczNZDSM66JQFD3PWw=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=qudE9Hl1tQKjWOfvfzHPyhcqN6c0MgvjCguUyan/jWo2RZy3Id3h51hmAZ35fLxXPY+4AE557XK/sXtwAm/1o6F5elUR/lJxor5RKpxnjekQSBcoIdahTA+LrV8E5YQQmQsLImyRZlcbJGoDbiU3Int77wg5kFEv6HWOIowfEAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 50OJq0G61025666
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 19:52:01 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "=?UTF-8?Q?'Perez-Lopez_=C3=81ron_Ricardo'?=" <perez.aron@gmail.com>,
        <git@vger.kernel.org>
References: <CAL_k5jZkYG0evQ2L+bCNvPAnePj=WdU-36GujfjRDwm3iX8ynQ@mail.gmail.com>
In-Reply-To: <CAL_k5jZkYG0evQ2L+bCNvPAnePj=WdU-36GujfjRDwm3iX8ynQ@mail.gmail.com>
Subject: RE: Bug report: parallel fetch tries to unlock SSH keys over and over again
Date: Fri, 24 Jan 2025 14:51:56 -0500
Organization: Nexbridge Inc.
Message-ID: <005501db6e99$6f8b1880$4ea14980$@nexbridge.com>
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
Content-Language: en-ca
Thread-Index: AQIhGmLhKZ20eSZoqeSbpV2ZZeI6tLKa/ZGg
X-Antivirus: Norton (VPS 250124-4, 1/24/2025), Outbound message
X-Antivirus-Status: Clean

On January 24, 2025 2:47 PM, Perez-Lopez =C3=81ron Ricardo wrote:
>What did you do before the bug happened? (Steps to reproduce your =
issue) git
>fetch --all --tags --prune --jobs=3D10
>
>What did you expect to happen? (Expected behavior) Being asked for the =
password
>of my SSH key, then git updating all of the remotes.
>
>What happened instead? (Actual behavior) I get asked for my SSH key =
many times
>over, and the fetch does not succeed.
>
>What's different between what you expected and what actually happened?
>I should only be asked to unlock my SSH key once. All fetch jobs should =
wait for this
>and then use the unlocked (cached) key.
>
>Anything else you want to add:
>If I do just `git fetch` and unlock my key (once), it does get added to =
the SSH agent
>properly, and afterwards I can execute the command above with no =
issues.
>
>[System Info]
>git version:
>git version 2.48.1
>cpu: x86_64
>no commit associated with this build
>sizeof-long: 8
>sizeof-size_t: 8
>shell-path: /bin/sh
>libcurl: 8.11.1
>OpenSSL: OpenSSL 3.4.0 22 Oct 2024
>zlib: 1.3.1
>uname: Linux 6.12.10-arch1-1 #1 SMP PREEMPT_DYNAMIC Sat, 18 Jan 2025
>02:26:57 +0000 x86_64
>compiler info: gnuc: 14.2
>libc info: glibc: 2.40
>$SHELL (typically, interactive shell): /bin/bash
>
>[Enabled Hooks]

Add your SSH key to your ssh-agent. The agent will prompt for your =
passphrase.
Git will not do that. Then perform your git fetch operations. You will =
not be
Prompted by git. If you are using some other credential manager, you =
will need
To add your key separately.

--Randall

