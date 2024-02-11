Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652EAAD2D
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 19:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707680923; cv=none; b=dAUb4vJK+Wrh+YxW/6Xcy4Vg2ldSRxkv65Pzs8Ee1WEyeY3jAs7kiqheT2zikPf6oMSpTStp33PiQ2XsnUBlB9h3SY/GGB12/4HaeTIgD3ElyNrpG5lfT/wt4QMWuuhfkrs/o8mbrPSCEKPlqNBs3TxjPWUP+YuyrxqmIj1Woxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707680923; c=relaxed/simple;
	bh=KRLeANwYI7zsGIfEbneE+nR6PdzzaBNMtZ4i4vspxMQ=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ElDKu1n8N1+qi0/1bL+g3thHBWSh84Ef3snZ43elr4XWkXb/wrL72RNXNp555FFQfpLBdSqxkvFa9Q0PKLkrTmbG9usV96E2ZvDUc8gaHSXcAEM9CHfPgpbWzGU6t0gBNZtYXvAdK7aRIcVx3E74UnFkwHibuxdQ57EQeR5pj9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 41BJmJkH3436655
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 Feb 2024 19:48:19 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc: "=?UTF-8?Q?'Torsten_B=C3=B6gershausen'?=" <tboegi@web.de>,
        "'K_V'" <zinen2@gmail.com>, <git@vger.kernel.org>
References: <CABkRduQNdgdF8WhZadP5hyYvpEWgP_AE8=qzxNiRNA71bdJcYQ@mail.gmail.com> <20240211151455.GA27103@tb-raspi4> <ZcjnuSAZiNHvA5h1@tapette.crustytoothpaste.net> <20240211154345.GA28699@tb-raspi4> <xmqqcyt39cju.fsf@gitster.g> <ZckbeJqdvIfY4YPu@tapette.crustytoothpaste.net>
In-Reply-To: <ZckbeJqdvIfY4YPu@tapette.crustytoothpaste.net>
Subject: RE: git gc changes ownerships of files linux
Date: Sun, 11 Feb 2024 14:48:13 -0500
Organization: Nexbridge Inc.
Message-ID: <006101da5d23$436ff460$ca4fdd20$@nexbridge.com>
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
Thread-Index: AQMb+8XFZrrIUcn89M9CO8HTNviv7AI7eFvcAYlHNGACev9s8AIMRq5MAXO/JZCuNE/vkA==
Content-Language: en-ca

On Sunday, February 11, 2024 2:10 PM, brian m. carlson wrote:
>On 2024-02-11 at 16:43:33, Junio C Hamano wrote:
>> You definitely must set up your initial directory with g+s if you are
>> usihng the group-writable shared directory model (which I would
>> actually be surprised to see in 2020---is a shared machine with more
>> than one user-account still a thing???); adjust_shared_perm() will =
not
>> help you there.
>
>I think it's relatively common to have shell hosts from which to log =
into production
>machines, or to have shared hosts for students at universities, and I =
do know that
>shared web hosting is still quite popular (because it tends to be very =
economical and
>low maintenance for the user).
>
>I don't know that shared repositories are really that common anymore, =
and I do
>usually recommend that people clone their own copies whenever possible, =
but I
>have seen posts on StackOverflow where people are in fact using a =
shared
>repository (possibly with multiple worktrees) on one system for various =
reasons.

In my community, shared repositories are particularly common on the =
operations side of the fence. It is a balance between the need for one =
user id (generally does not log on) running the scripts, and the =
individual operations staff specifying them. I have developed =
(commercial) solutions to this that remove the need shared repositories =
in this circumstance, but up to now, I have seen them used. This comes =
into play when multiple people are manipulating web server content =
without a separate deployment mechanism.

