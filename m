Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9243719C560
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 20:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758055701; cv=none; b=gFJRyiVNrrkNYeBA7/c7UayGzWO3WEXgzoFD/LLRX2s3iyqyZxOI9r3So2B0HbBI8G4qKcuQUyfw5KIJXKrWHbGhL1+FGdfMkR3U+mctr++VBH1ecsHc79EhxqzsXkSEKCeX8aeSdI8P6US9T3Qgf2UKQaWMcXdMEJ/XdIjyBv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758055701; c=relaxed/simple;
	bh=9VvkOMSoPt7qoJbesqapyIhGGnJagbUCwRmAArf3cDU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p6cx28kc62A7fwcB4KsTCxJ5fb+gL+ASG9uEeb3grSUXGZ1x5bqJbom0DQRftuBtDdVy7RlGoKHFVr4QWjycMjbqSojhnqkxl1ESq6pyRUi2gg6ZziBDlZEc0t/xg1ed8d2+XhfeU7ZU/4RJkccp2l6XnYPsx23vHM5P4cFHs8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZQXxIA2I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y+fGT0eM; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZQXxIA2I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y+fGT0eM"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A1D3C1400176;
	Tue, 16 Sep 2025 16:48:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Tue, 16 Sep 2025 16:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1758055696;
	 x=1758142096; bh=CENJZov7ePvp8KZ9zIn6Kyt6oeKluTXBVBbO5Q0PlHs=; b=
	ZQXxIA2IHIjXsBHkL6zl20t8iWW7oLKZSDQPiieQHpnfpoRxJlZ/NSFxUoObIqfk
	xxkDg4ZzHYFUkPZPZ9VaVgY62lV6mSW6P4lKbHP85mxrZdluuDgM9f1HL1AIw80v
	Cce/1PtRLf6eZVIgtMjS4E283caj/1JIvwLlC4KkuX87TfdbNrWXxRY/gkaaqzLm
	2k9xdnEOXoCnV78Th+aigjvTfc0Z61co4i/w3KpHT1xJmK9uCnjSSaqJtLm1yl1H
	kviJV3JYpS1O9BXNYDSFFUEoJdHP1Td6LPA1zltPcjZvXIa0wtLZlC1V3l82et/S
	mpBK9UXZtwTOCXTT7vnX9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758055696; x=
	1758142096; bh=CENJZov7ePvp8KZ9zIn6Kyt6oeKluTXBVBbO5Q0PlHs=; b=Y
	+fGT0eMoi8UpaPWf1WwG7HrEYQg9K/f2gPTzULfU+PNY3QT7FGrek96Gd9YyH9s9
	g49jgWi7vtM7jyFa+a6gLue3scetID3dSgvnOBaUZ6wwfuRT/TtqWUz73odYCZQ1
	yZ6lnbXYPZ1HJ1/nonIurHm+mylsFs9JgDu/as53xfY0Ah325+8B6Ao1OqprEIMs
	knonqJxFhf/UmTfTslYAtwJLYkcVOj0bU0js1t70CtcBuPUyCTEkd9S1hgGwZKD9
	PTK1cdQlzrC0M/cKNf45LKkiyeAgkrvK1arvHa9/fynVV0QzRn1tlT1cfk4t3ksY
	NJsDIF1A+HuvzHPPMw58g==
X-ME-Sender: <xms:EM3JaMBJ18bhWNXlkefJQeY1QD9LwZOLmyxp3ncsDlMwmZ-9BRhD9g>
    <xme:EM3JaBzvasdy6vWNfEUq1oLNILuK4pGr2eajfisFcfKb6ByeFM2FMyJRbi2t9HNbk
    vGyEyqAtQIiDc8DUQ>
X-ME-Received: <xmr:EM3JaJB69Zm6cmi0H8ONxtrJGP6jHT5_OZoWOhtEICIbLb0aozn3kyVYesWV_fYMY65hrPpOKjrEeWs1hLv9puuXPzkmv4Lg1IY3YvU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegudehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgfgsehtkeertd
    dtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevle
    fgkeefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghilhes
    rghnshgvlhhmshgthhhuvghlvghrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:EM3JaOYKxGDNqrWOYk2sNvtXKWgE-8GXMuaANGHJesIx9yOtYv4Tiw>
    <xmx:EM3JaBjJ3N8Wzpyhp9Mlssz8YJ-GJFNQBAnskHwOeRLZ3o6eXLa5xQ>
    <xmx:EM3JaA45oE1S0uwHpAEc721fwpt9lHjFTgm2H1CuUu67chG0avVjgg>
    <xmx:EM3JaI6fkSC0450Opl6tTHaBKEhwvmZGQwLPRXqwlcv1hSTZXvmc-Q>
    <xmx:EM3JaJCcTJtGv7oJsyHxNPLXzj9ZqdtpGdUgvowkDLT9Gig2C_O4SYx0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 16:48:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Anselm =?utf-8?Q?Sch=C3=BCler?= <mail@anselmschueler.com>
Cc: git@vger.kernel.org
Subject: Re: Why does git-status suggest different commands to unstage files
 depending on whether there is a commit yet or not?
In-Reply-To: <de49d686-73fa-4bb9-9ec6-b65d5432a30a@anselmschueler.com>
	("Anselm =?utf-8?Q?Sch=C3=BCler=22's?= message of "Tue, 16 Sep 2025
 22:34:39 +0200")
References: <5036f7d8-8ac9-4f50-99af-5a3a2d1a07fc@anselmschueler.com>
	<de49d686-73fa-4bb9-9ec6-b65d5432a30a@anselmschueler.com>
Date: Tue, 16 Sep 2025 13:48:15 -0700
Message-ID: <xmqqldmem8ds.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Anselm Schüler <mail@anselmschueler.com> writes:

> $ git status
> [...]
> No commits yet
>
> Changes to be committed:
>    (use "git rm --cached <file>..." to unstage)
> [...]

As this is a very initial commit, any file you are including would
only exist in the index and in the working tree files.  The index is
where you prepare the contents of the commit you are going to
create, and "git rm --cached <file>" is the way to remove <file>
from there without losing or clobbering the <file> in the working
tree.  As you do not have a commit yet, you wouldn't have anywhere
to "restore" from, would you?

> After a commit has been made, git-status suggests using git-restore instead:
>
> $ git status
> [...]
> Changes to be committed:
>    (use "git restore --staged <file>..." to unstage)
> [...]

Compared to the previous situation, you do have a commit, so you can
restore to the version in that commit.  During the course of
development that led you to this state, you may have added <file> in
a commit way before the current commit, and you may have made
changes to the <file> multiple times in different commits before the
current commit.  "git rm --cached <file>" would not be how you would
go back to the version in the current commit in such a situation, as
it would take you to the state _before_ you originally added that
file.  You would "restore" the contents in the index to that of the
current commit (i.e. HEAD) to go back to the state.

So, isn't a short answer to the "why" question, "because that is
what you need to do", I guess?
