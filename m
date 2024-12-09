Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B90BA3D
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733762088; cv=none; b=jstxNlq2h7XtIdRRRF8HoeVUNEfn1sGliJ/681jf49vgrq010NTH73IpWPXRyoI8Zt871wF4tIipV9ZnMLI4ojRTeg6BmlC8qYZtg8ioagOeD8d+Q+ZpgPfMjm2lD8B1uEXxydHJj0aDhrPqRYiBdJlplyclz1hlgzY2LrIkbFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733762088; c=relaxed/simple;
	bh=+X+AwsZkTCY9qnVWw4Cvxkt6CXs0DN7GfXHoIq5rvNc=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=A5c0vsr4FQCiU/jtk1dN/X2Y6Jw3+xhflgqn4IU4ChfYbMBUKJrrxSitBhuCP2oUVqjmTdizHnDXejdtNQ0rSphOUGRJrhgY/JTWPbtVlCLwgIPnRg+dLeoQY8BY8tcP9+onk05PeXT8b1dPF4pdvJrN98boQRrBEX8VlwVuo00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 4B9GYXPc112669
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Dec 2024 16:34:34 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Usman Akinyemi'" <usmanakinyemi202@gmail.com>, <gitster@pobox.com>
Cc: <Johannes.Schindelin@gmx.de>, <christian.couder@gmail.com>,
        <git@vger.kernel.org>, <johncai86@gmail.com>, <ps@pks.im>
References: <xmqqfrt7y3xp.fsf@gitster.g> <20241209161445.10321-1-usmanakinyemi202@gmail.com>
In-Reply-To: <20241209161445.10321-1-usmanakinyemi202@gmail.com>
Subject: RE: [PATCH 0/3] Advertise OS version
Date: Mon, 9 Dec 2024 11:34:28 -0500
Organization: Nexbridge Inc.
Message-ID: <00e201db4a58$3b198fb0$b14caf10$@nexbridge.com>
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
Thread-Index: AQLyRRqI/aFN8MyxQnA6vHKyrUPA/wLxTrVHsJiba9A=
Content-Language: en-ca

On December 9, 2024 11:15 AM, Usman Akinyemi wrote:
>Thank you to everyone who participated in this discussion. I am Usman =
Akinyemi,
>one of the two selected Outreachy interns. I have been selected to work =
on the
>project =E2=80=9CFinish adding an 'os-version'
>capability to Git protocol v2,=E2=80=9D which involves implementing the =
features discussed in
>this thread.
>
>You can find the full discussion about my proposal for this project
>here: https://public-inbox.org/git/CAPSxiM_rvt-tkQjHYmYNv-
>Wyr0=3DX4+123dt=3DvZKtc++PGRjQMQ@mail.gmail.com/
>
>In summary, this is an outline of my proposal and what I plan to =
implement, which
>has been influenced by the discussion in this thread:
>
>- Send only the OS name by default while allowing a knob (custom
>configuration) to specify other information (e.g., version details) and =
disable
>sending OS names and any other information entirely.
>
>After discussing with my mentor, @Christian, we think that adding this =
as a new
>capability (os-version) is a better option compared to appending it to =
the user-
>agent. This ensures that we do not disrupt people's scripts that =
collect statistics
>from the user-agent or perform other actions.
>
>Intentions of implementing this project:
>- For statistical purposes.
>- Most importantly, for security and debugging purposes. This will =
allow servers to
>instruct users to upgrade or perform specific debugging actions when =
necessary.
>
>For example:-
>A server seeing that a client is using an old Git version that has =
security issues on
>one platform, like MacOS, could check if the user is indeed running =
MacOS before
>sending it a message to upgrade.
>
>Also a server seeing a client that could benefit from an upgrade, for =
example for
>performance reasons, could better customize the message it sends to the =
client to
>nudge it to upgrade. If the client is on Windows for example the server =
could send it
>a link to https://gitforwindows.org/ as part of the message.
>
>Please, if anyone has any suggestion or addition or concerns that =
might, kindly add.
>Thank you very much.

Is this build-time or runtime? If run-time, please make sure the code is =
portable or provides
hooks so that non-linux systems can contribute content.

Thanks,
Randall

--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.



